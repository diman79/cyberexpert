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

    ban = instance.ban_author


    print(instance.author)
    user = instance.author
    user.is_active = ban
    user.save()


# pre_save.connect(setting_ban_user, sender=Utilita)
