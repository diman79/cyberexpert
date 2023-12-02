from django.conf import settings
from django.core.mail import send_mail, EmailMultiAlternatives, get_connection, EmailMessage

from .models import *
from django.db.models.signals import pre_save, post_save
from django.dispatch import Signal, receiver
from django.template.loader import render_to_string
from django.contrib.auth import get_user_model

set_views = Signal()


def incr_views(sender, **kwargs):
    statya_id = str(kwargs['id'])
    count = views.get(course_id, 0)
    views[course_id] = count + 1
    session['views'] = views
    session.modified = True