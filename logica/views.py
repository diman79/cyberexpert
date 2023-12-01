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
from django.db.models import Q, F, Count, Sum
from django.db.models.signals import pre_save
from .signals import *
import json


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
        return data

    def get_queryset(self):
        if 'statyas' in cache:
            queryset = cache.get('statyas')
        else:
            queryset = MainView.queryset
            cache.set('statyas', queryset, timeout=30)

        search_query = self.request.GET.get('search', "")
        order_by = self.request.GET.get('order', "count_views")
        filter1 = Q(title__icontains=search_query) | Q(description__icontains=search_query)
        queryset = MainView.queryset.filter(filter1).order_by(order_by)

        return queryset

    def get_initial(self):
        initial = super(MainView, self).get_initial()
        initial['search'] = self.request.GET.get('search', '')
        initial['order'] = self.request.GET.get('order', 'count_views')
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