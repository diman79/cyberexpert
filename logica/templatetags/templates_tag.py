from django import template
from logica.models import Statya
register = template.Library()


@register.filter(name='has_group')
def has_group(user, group_name):
    return user.groups.filter(name=group_name).exists()


@register.filter(name='get_count_moderated')
def get_count_moderated():
    return Statya.objects.filter(moderated=True).count()
