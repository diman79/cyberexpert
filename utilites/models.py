from django.conf import settings
from django.db import models
from django.shortcuts import reverse
from logica.functions import *
from logica.models import Rubrika
# Create your models here.


class Utilita(models.Model):

    title = models.CharField(verbose_name='Название утилиты', max_length=255, unique=True)

    author = models.ForeignKey(settings.AUTH_USER_MODEL, related_name='author_utilites', on_delete=models.CASCADE, verbose_name='Автор утилиты', null=True)

    rubrika = models.ManyToManyField(Rubrika)

    description = models.TextField(verbose_name='Описание утилиты', null=False, blank=False, default='', max_length=200)

    data_publication = models.DateField(verbose_name='Дата загрузки утилиты', null=True)

    count_downloads = models.PositiveIntegerField(verbose_name='Счетчик просмотров', default=0)

    file = models.FileField(verbose_name='Файл утилиты', null=True)

    moderated = models.BooleanField(default=False, verbose_name='Проверено модератором')

    def get_author(self):
        return self.author

    def __str__(self):
        return f'Утилита: {self.title}. Рубрика: {[rubrika1.naim for rubrika1 in self.rubrika.all()]}. Дата загрузки: {self.data_publication}. Автор: {self.get_author()} Описание: {self.description}'

    class Meta:
        verbose_name_plural = 'Утилиты'
        verbose_name = 'Утилита'
        ordering = ['title']

    def get_absolute_url(self):
        return reverse('detail_utilita', kwargs={'utilita_id': self.pk})
