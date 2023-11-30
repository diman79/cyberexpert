from django.urls import path
from django.contrib.auth.views import (LoginView, LogoutView, PasswordResetView, PasswordResetDoneView,
                                       PasswordChangeDoneView, PasswordResetConfirmView, PasswordResetCompleteView,
                                       PasswordChangeView)

from .views import *
from django.views.decorators.cache import cache_control

urlpatterns = [
    path('', LogoutView.as_view(next_page='log_in'), name='log_in'),
    path('login/', cache_control(private=True)(UserLoginView.as_view()), name='log_in'),
    path('register/', cache_control(private=True)(RegisterView.as_view()), name='register'),
    path('logout/', LogoutView.as_view(next_page='log_in'), name='logout'),
    path('password_change/', PasswordChangeView.as_view(), name='password_change'),
    path('password_change/done', PasswordChangeDoneView.as_view(), name='password_change_done'),
    path('password-reset/', PasswordResetView.as_view(), name='password_reset'),
    path('password-reset/done', PasswordResetDoneView.as_view(), name='password_reset_done'),
    path('reset/<uidb64>/<token>', PasswordResetConfirmView.as_view(), name='password_reset_confirm'),
    path('reset/done', PasswordResetCompleteView.as_view(), name='password_reset_complete'),

]
