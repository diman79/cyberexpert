import mimetypes
import os.path

from django.core.files.storage import FileSystemStorage
from django.forms import HiddenInput
from django.shortcuts import render

# Create your views here.
from django.contrib.auth.decorators import login_required, permission_required
from django.contrib.auth.mixins import LoginRequiredMixin, PermissionRequiredMixin
from django.core.cache import cache, caches
from django.core.serializers import serialize
from django.core.cache.backends.redis import RedisCache
from django.core.exceptions import NON_FIELD_ERRORS
from django.db import transaction
from django.http import HttpResponse, HttpResponseRedirect, JsonResponse
from django.shortcuts import render, redirect
from django.urls import reverse
from django.views.generic import ListView, CreateView, UpdateView, DeleteView, FormView
from .forms import FilterOrderBySearchForm, UtilitaForm, UtilitaFormCreate
from .models import *
from logica.models import Statya
from auth_app.models import User
from django.db.models import Q, F, Count, Sum
from django.db.models.signals import pre_save
from .signals import *
import json

from datetime import datetime


class MainView(ListView, FormView):
    template_name = 'index_utilita.html'
    queryset = Utilita.objects.all()
    context_object_name = 'utilites'
    form_class = FilterOrderBySearchForm

    paginate_by = 4

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['nm'] = f'Число утилит в рубрике: {MainView.queryset.count()}'
        return data

    def get_queryset(self):
        queryset = Utilita.objects.all().filter(moderated=True)

        rub = self.request.GET.get('rub', "Интернет")
        search_query = self.request.GET.get('search', "")
        order_by = self.request.GET.get('order', "count_downloads")
        filter1 = Q(title__icontains=search_query) | Q(description__icontains=search_query)

        queryset = queryset.filter(filter1).order_by(order_by)
        queryset = queryset.filter(rubrika__naim=rub).order_by(order_by)
        MainView.queryset = queryset
        return queryset

    def get(self, request, *args, **kwargs):
        user = self.request.user

        return super(MainView, self).get(request, *args, **kwargs)

    def get_initial(self):
        initial = super(MainView, self).get_initial()
        initial['search'] = self.request.GET.get('search', '')
        initial['order'] = self.request.GET.get('order', "count_downloads")
        initial['rub'] = self.request.GET.get('rub', "Интернет")
        return initial

    def get_paginate_by(self, queryset):
        return self.request.COOKIES.get('paginate_by', 4)


class UtilitaCreateView(LoginRequiredMixin, PermissionRequiredMixin, CreateView):
    model = Utilita
    form_class = UtilitaFormCreate
    template_name = 'create_utilita.html'
    permission_required = 'utilites.add_utilita',
    context_object_name = 'utilites'

    def form_valid(self, form):
        with transaction.atomic():
            utilita = form.save(commit=True)
            author = self.request.user
            if author.groups.filter(name='Автор').exists():
                a = Statya.objects.filter(author=author)
                if a.count() > 0:
                    if a[0].reiting < 4.95:
                        return HttpResponse("Для добавления утилиты ваш рейтинг должен быть >=4.95 ")
                else:
                    return HttpResponse("Для добавления утилиты у вас должны быть опубликованные статьи,"
                                    " и ваш рейтинг должен быть >=4.95 ")
            else:
                return HttpResponse("Для добавления утилиты вы должны быть в группе Авторов")

            utilita.author = author

            rubriks = self.request.POST.getlist('rubrika')

            for item in rubriks:
                utilita.rubrika.add(item)

            file = self.request.FILES['file']

            fs = FileSystemStorage()
            filename = fs.save(file.name, file)

            if file.size > (8 * 1024 * 1024 * 100):
                os.remove(os.path.join(settings.MEDIA_ROOT, file.name))

            utilita.file = file

            utilita.data_publication = datetime.now().date()
            utilita.ban_author = False
            utilita.moderated = False
            cache.delete('utilites')
            utilita.save()

            return redirect(reverse('index_utilita'))


class UtilitaDetailView(ListView):
    template_name = 'detail_utilita.html'
    context_object_name = 'utilites'
    pk_url_kwarg = 'utilita_id'

    #    def get(self, request, *args, **kwargs):
    # set_views.send(sender=self.__class__, session=request.session,
    #              pk_url_kwargs=CourseDetailView.pk_url_kwarg,
    #             id=kwargs[CourseDetailView.pk_url_kwarg])
    #       return super(CourseDetailView, self).get(request, *args, **kwargs)

    def get_queryset(self):
        utilita_id = self.kwargs.get('utilita_id')
        queryset = Utilita.objects.filter(id=utilita_id)
        return queryset

    def get(self, request, *args, **kwargs):
        return super(UtilitaDetailView, self).get(request, *args, **kwargs)


class UtilitaDeleteView(LoginRequiredMixin, PermissionRequiredMixin, DeleteView):
    model = Utilita
    template_name = 'delete_utilita.html'
    pk_url_kwarg = 'utilita_id'
    permission_required = 'utilites.delete_utilita',

    def form_valid(self, form):
        utilita_id = self.kwargs.get('utilita_id')

        a = Utilita.objects.get(id=self.kwargs.get('utilita_id'))
        if not self.request.user.groups.filter(name='Модератор').exists():
            if a.author != self.request.user:
                return HttpResponse("Нельзя удалять чужую утилиту.")

        cache.delete_many(['utilites', f"utilita_{utilita_id}"])
        return super(UtilitaDeleteView, self).form_valid(form)

    def get_queryset(self):
        return Utilita.objects.filter(id=self.kwargs.get('utilita_id'))

    def get_success_url(self):
        return reverse('index_utilita')


class UtilitaUpdateView(LoginRequiredMixin, PermissionRequiredMixin, UpdateView):
    model = Utilita
    form_class = UtilitaForm
    template_name = 'create_utilita.html'
    pk_url_kwarg = 'utilita_id'
    permission_required = 'utilites.change_utilita',

    def get_queryset(self):
        if not self.request.user.groups.filter(name='Модератор').exists():
            self.form_class = UtilitaFormCreate
        else:
            self.form_class = UtilitaForm

        return Utilita.objects.filter(id=self.kwargs.get('utilita_id'))

    def get_success_url(self):
        return reverse('detail_utilita', kwargs={'utilita_id': self.object.id})


@transaction.non_atomic_requests
def download_utilita(request, utilita_id):
    a = Utilita.objects.get(id=utilita_id)
    count_downloads = a.count_downloads + 1
    Utilita.objects.filter(id=utilita_id).update(count_downloads=count_downloads)

    response = HttpResponse(a.file, content_type='application/force-download')
    response['Content-Disposition'] = f'attachment; filename="{a.file.url}"'
    return response


class Moderate_view(MainView):
    permission_required = 'utilites.change_utilita',

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['nm'] = f'Блок модерации. Число статей для модерации в рубрике: {MainView.queryset.count()}'
        return data

    def get_queryset(self):
        queryset = Utilita.objects.all().filter(moderated=False)

        rub = self.request.GET.get('rub', "Интернет")
        search_query = self.request.GET.get('search', "")
        order_by = self.request.GET.get('order', "count_downloads")
        filter1 = Q(title__icontains=search_query) | Q(description__icontains=search_query)

        queryset = queryset.filter(filter1).order_by(order_by)
        queryset = queryset.filter(rubrika__naim=rub).order_by(order_by)
        MainView.queryset = queryset
        return queryset






