from django.conf import settings
from django.core.mail import send_mail, EmailMultiAlternatives, get_connection, EmailMessage

from .models import Utilita
from django.db.models.signals import pre_save, post_save
from django.dispatch import Signal, receiver
from django.template.loader import render_to_string
from django.contrib.auth import get_user_model
from auth_app.models import User


set_ban = Signal()


def setting_ban_user(sender, instance, **kwargs):
    user = instance.author

    if user is not None:
        ban = instance.ban_author
        if user.groups.filter(name='Администратор').exists():
            active_user = True
        else:
            active_user = not ban

        user.is_active = active_user
        user.save()


post_save.connect(setting_ban_user, sender=Utilita)
