from django.views.decorators.cache import cache_control, never_cache
from django.urls import path, re_path
from .views import *

urlpatterns = [
    path('', MainView.as_view(), name='index'),
    path('moderate_statya', Moderate_view.as_view(), name='moderate_statya'),
    path('create/', StatyaCreateView.as_view(), name='create'),
    path('delete/<int:statya_id>/', StatyaDeleteView.as_view(), name='delete'),
    path('detail/<statya_id>/', cache_control(max_age=600)(StatyaDetailView.as_view()), name='detail'),
    path('update/<statya_id>/', StatyaUpdateView.as_view(), name='update'),
    # path('enroll/<int:course_id>/', enroll, name='enroll'),
    path('comment_of_user/<int:statya_id>/', comment_of_user, name='comment_of_user'),
    path('ocenka_statya/<int:statya_id>/', ocenka_statya, name='ocenka_statya'),
    path('answer_to_comment/<int:comment_id>/', answer_to_comment, name='answer_to_comment'),

    # path('<int:course_id>/create_lesson/', LessonCreateView.as_view(), name='create_lesson'),
    # paths for session work
    path('add_booking/<int:statya_id>/', add_booking, name='add_booking'),
    path('remove_booking/<int:statya_id>/', remove_booking, name='remove_booking'),
    path('favourites/', FavouriteView.as_view(), name='favourites'),

    # path('settings/', SettingFormView.as_view(), name='settings'),
    # path('get_certificate/<int:course_id>/', get_certificate_view, name='get_certificate'),
    # path('tracking/', TrackingView.as_view(), name='tracking'),

]
