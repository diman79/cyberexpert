from django.conf import settings
from django.core.mail import send_mail, EmailMultiAlternatives, get_connection, EmailMessage

from .models import *
from django.db.models.signals import pre_save, post_save
from django.dispatch import Signal, receiver
from django.template.loader import render_to_string
from django.contrib.auth import get_user_model

from django.conf import settings
from django.core.mail import send_mail, EmailMultiAlternatives, get_connection, EmailMessage

from .models import Statya, Comment, Answer_to_comment
from django.db.models.signals import pre_save, post_save
from django.dispatch import Signal, receiver
from django.template.loader import render_to_string
from django.contrib.auth import get_user_model

answer_author = Signal()


def send_answer_author_email(**kwargs):
    template_name = 'emails/answer_email.html'
    comment = Comment.objects.get(id=kwargs['comment_id'])
    answer = Answer_to_comment.objects.all().filter(comment=comment).order_by('-id')[:1]
    statya = Statya.objects.get(id=comment.statya.pk)
    context = {
        'statya': statya,
        'comment': comment,
        'answer': answer[0],
        'message': f'Автор ответил на ваш комментарий к статье <{comment.statya.title}>'
    }
    send_mail(subject='Ответ автора статьи на ваш комментарий| Платформа Cyberexpert',
              message='',
              from_email=settings.DEFAULT_FROM_EMAIL,
              recipient_list=[kwargs['request'].user.email],
              html_message=render_to_string(template_name, context, kwargs['request']),
              fail_silently=False)


answer_author.connect(send_answer_author_email)
