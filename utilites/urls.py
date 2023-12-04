from django.views.decorators.cache import cache_control, never_cache
from django.urls import path, re_path
from .views import *

urlpatterns = [
    path('', MainView.as_view(), name='index_utilita'),
    path('moderate_utilita', Moderate_view.as_view(), name='moderate_utilita'),
    path('create_utilita/', UtilitaCreateView.as_view(), name='create_utilita'),
    path('delete/<int:utilita_id>/', UtilitaDeleteView.as_view(), name='delete_utilita'),
    path('detail/<utilita_id>/', cache_control(max_age=600)(UtilitaDetailView.as_view()), name='detail_utilita'),
    path('update/<utilita_id>/', UtilitaUpdateView.as_view(), name='update_utilita'),
    path('download/<utilita_id>/', download_utilita, name='download_utilita'),
]