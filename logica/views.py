from django.core.files.storage import FileSystemStorage
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
from .forms import FilterOrderBySearchForm, StatyaForm
from .models import *
from auth_app.models import User
from django.db.models import Q, F, Count, Sum
from django.db.models.signals import pre_save
from .signals import *
import json

from datetime import datetime


class MainView(ListView, FormView):
    template_name = 'index.html'
    queryset = Statya.objects.all()
    context_object_name = 'statyas'
    form_class = FilterOrderBySearchForm

    paginate_by = 4

    def get_context_data(self, **kwargs):
        rubriks = Rubrika.objects.all()
        data = super().get_context_data(**kwargs)
        data['rubriks'] = rubriks
        data['all_statyas'] = MainView.queryset.count
        return data

    def get_queryset(self):
        MainView.queryset = Statya.objects.all()
        if 'statyas' in cache:
            queryset = cache.get('statyas')
        else:
            queryset = MainView.queryset
            cache.set('statyas', queryset, timeout=30)

        rub = self.request.GET.get('rub', "Интернет")
        search_query = self.request.GET.get('search', "")
        order_by = self.request.GET.get('order', "count_views")
        filter1 = Q(title__icontains=search_query) | Q(description__icontains=search_query)
        queryset = MainView.queryset.filter(filter1).order_by(order_by)
        MainView.queryset = queryset.filter(rubrika__naim=rub).order_by(order_by)
        # print('b=', rub)

        return MainView.queryset

    def get_initial(self):
        initial = super(MainView, self).get_initial()
        initial['search'] = self.request.GET.get('search', '')
        initial['order'] = self.request.GET.get('order', "count_views")
        initial['rub'] = self.request.GET.get('rub', "Интернет")
        return initial

    def get_paginate_by(self, queryset):
        return self.request.COOKIES.get('paginate_by', 4)


class FavouriteView(MainView):
    def get_queryset(self):
        queryset = super(FavouriteView, self).get_queryset()
        ids = self.request.session.get('favourites', list())
        return queryset.filter(id__in=ids)


def add_booking(request, statya_id):
    if request.method == 'POST':
        favourites = request.session.get('favourites', list())
        favourites.append(statya_id)
        request.session['favourites'] = favourites
        request.session.modified = True

    return redirect(reverse('index'))


def remove_booking(request, statya_id):
    if request.method == 'POST':
        request.session.get('favourites').remove(statya_id)
        request.session.modified = True

    return redirect(reverse('index'))


class StatyaCreateView(LoginRequiredMixin, PermissionRequiredMixin, CreateView):
    model = Statya
    form_class = StatyaForm
    template_name = 'create.html'
    permission_required = 'logica.add_statya',
    context_object_name = 'statyas'

    def form_valid(self, form):
        with transaction.atomic():
            statya = form.save(commit=True)
            statya.author = self.request.user

            rubriks = self.request.POST.getlist('rubrika')

            for item in rubriks:
                statya.rubrika.add(item)

            file = self.request.FILES['kartinka']
            if file != '':
                fs = FileSystemStorage()
                filename = fs.save(file.name, file)
                statya.file = file

            statya.data_publication = datetime.now().date()
            cache.delete('statyas')
            statya.save()
            return redirect(reverse('index'))


class StatyaDetailView(ListView):
    template_name = 'detail.html'
    context_object_name = 'statyas'
    pk_url_kwarg = 'statya_id'

    #    def get(self, request, *args, **kwargs):
    # set_views.send(sender=self.__class__, session=request.session,
    #              pk_url_kwargs=CourseDetailView.pk_url_kwarg,
    #             id=kwargs[CourseDetailView.pk_url_kwarg])
    #       return super(CourseDetailView, self).get(request, *args, **kwargs)

    def get_queryset(self):
        statya_id = self.kwargs.get('statya_id')
        queryset = Statya.objects.filter(id=statya_id)
        return queryset

    def get(self, request, *args, **kwargs):
        id = self.kwargs.get('statya_id')
        a = Statya.objects.get(id=id)
        a.count_views += 1
        a.save(update_fields=["count_views"])

        return super(StatyaDetailView, self).get(request, *args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super(StatyaDetailView, self).get_context_data(**kwargs)

        statya_id = self.kwargs.get('statya_id')

        comment = Comment.objects.select_related('author_comment').filter(statya=statya_id)
        context['reviews'] = comment

        answer = Answer_to_comment.objects.select_related('author_otveta').filter(comment__statya=self.kwargs.get('statya_id'))
        # print(answer)

        if answer is not None:
            context['otvets'] = answer
        return context


class StatyaDeleteView(LoginRequiredMixin, PermissionRequiredMixin, DeleteView):
    model = Statya
    template_name = 'delete.html'
    pk_url_kwarg = 'statya_id'
    permission_required = 'logica.delete_statya',

    def form_valid(self, form):
        statya_id = self.kwargs.get('statya_id')
        cache.delete_many(['courses', f"statya_{statya_id}"])
        return super(StatyaDeleteView, self).form_valid(form)

    def get_queryset(self):
        return Statya.objects.filter(id=self.kwargs.get('statya_id'))

    def get_success_url(self):
        return reverse('index')


class StatyaUpdateView(LoginRequiredMixin, PermissionRequiredMixin, UpdateView):
    model = Statya
    form_class = StatyaForm
    template_name = 'create.html'
    pk_url_kwarg = 'statya_id'
    permission_required = 'logica.change_statya',

    def get_queryset(self):
        return Statya.objects.filter(id=self.kwargs.get('statya_id'))

    def get_success_url(self):
        return reverse('detail', kwargs={'statya_id': self.object.id})


@transaction.non_atomic_requests
@login_required
@permission_required('logica.add_comment', raise_exception=True)
def comment_of_user(request, statya_id):
    if request.method == 'POST':
        data = request.POST
        Comment.objects.create(content=data['content'],
                               statya=Statya.objects.get(id=statya_id),
                               author_comment=request.user)
        return redirect(reverse('detail', kwargs={'statya_id': statya_id}))
    else:
        return render(request, 'review.html')


@transaction.non_atomic_requests
@login_required
@permission_required('logica.add_answer_to_comment', raise_exception=True)
def answer_to_comment(request, comment_id):
    if request.method == 'POST':
        data = request.POST
        comment = Comment.objects.get(id=comment_id)
        Answer_to_comment.objects.create(content=data['content'],
                                         comment=comment,
                                         author_otveta=request.user,
                                         komu_answer=comment.author_comment)

        # Отправка письма - ответа на комментарий
        answer_author.send(sender=Answer_to_comment, request=request, comment_id=comment_id)
        return redirect(reverse('detail', kwargs={'statya_id': comment.statya.pk}))
    else:
        return render(request, 'otvet_avtora.html')


@transaction.non_atomic_requests
@login_required
@permission_required('logica.add_ocenka', raise_exception=True)
def ocenka_statya(request, statya_id):
    if request.method == 'POST':
        data = request.POST

        a = Statya.objects.get(id=statya_id)
        author = a.author

        bal = data['bal']

        if author == request.user:
            return HttpResponse("Нельзя оценивать свою статью.")

        if Ocenka.objects.filter(komu=author, author_ocenka=request.user, statya=a).exists():
            return HttpResponse("Вы уже оценивали эту статью.")
        else:
            r = Ocenka()
            r.komu = author
            r.author_ocenka = request.user
            r.statya = a
            r.bal = bal
            r.save()

            c = Ocenka.objects.filter(komu=author).aggregate(bals_all=Sum("bal"))
            d = Ocenka.objects.filter(komu=author).count()
            print('bals_all', c['bals_all'])
            print('count', d)
            reiting = round(c['bals_all'] / d, 2)
            print(reiting)
            Statya.objects.filter(author=author).update(reiting=reiting)

            return redirect(reverse('detail', kwargs={'statya_id': statya_id}))
    else:
        return render(request, 'ocenka.html')
