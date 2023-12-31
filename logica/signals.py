from django.conf import settings
from django.core.mail import send_mail, EmailMultiAlternatives, get_connection, EmailMessage
from django.db.models import Sum

from .models import *
from django.db.models.signals import pre_save, post_save
from django.dispatch import Signal, receiver
from django.template.loader import render_to_string
from django.contrib.auth import get_user_model

from django.conf import settings
from django.core.mail import send_mail, EmailMultiAlternatives, get_connection, EmailMessage

from .models import Statya, Comment, Answer_to_comment
from django.db.models.signals import pre_save, post_save, post_delete, pre_init
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
              fail_silently=True)


answer_author.connect(send_answer_author_email)


def update_reiting(sender, instance, **kwargs):
    statya = instance
    author = statya.author
    if author is not None:
        # print(author)
        c = Ocenka.objects.filter(komu=author).aggregate(bals_all=Sum("bal"))
        d = Ocenka.objects.filter(komu=author).count()
        # print('bals_all', c['bals_all'])
        # print('count', d)
        reiting = round(c['bals_all'] / d, 2)
        Statya.objects.filter(author=author).update(reiting=reiting)


post_save.connect(update_reiting, sender=Statya)


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


post_save.connect(setting_ban_user, sender=Statya)
