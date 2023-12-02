from django.conf import settings
from django.db import models
from django.shortcuts import reverse


from logica.functions import *
# Create your models here.


class Rubrika(models.Model):

    naim = models.CharField(verbose_name='Название рубрики', max_length=255, unique=True)

    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, verbose_name='Автор создания записи рубрики')

    class Meta:
        verbose_name_plural = 'Рубрики'
        verbose_name = 'Рубрика'
        ordering = ['naim']
        permissions = (
            ('modify_rubrika', 'Can modify rubrika'),
        )

    def __str__(self):
        return f'Рубрика: {self.naim}'


class Statya(models.Model):

    title = models.CharField(verbose_name='Название статьи', max_length=255, unique=True)

    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, verbose_name='Автор статьи', null=True)

    rubrika = models.ManyToManyField(Rubrika)

    description = models.TextField(verbose_name='Описание статьи', null=False, blank=False, default='', max_length=200)

    data_publication = models.DateField(verbose_name='Дата публикации', null=True)

    content = models.TextField(verbose_name='Контент статьи', null=True, blank=True, default='', max_length=1000)

    kartinka = models.ImageField(verbose_name='Картинка', blank=True, upload_to=get_timestamp_path_user)

    count_views = models.PositiveIntegerField(verbose_name='Счетчик просмотров', default=0)

    def get_author(self):
        return self.author

    def __str__(self):
        return f'Статья: {self.title}. Рубрика: {[rubrika1.naim for rubrika1 in self.rubrika.all()]}. Дата публикации: {self.data_publication}. Автор: {self.get_author()} Описание: {self.description}'

    class Meta:
        verbose_name_plural = 'Статьи'
        verbose_name = 'Статья'
        ordering = ['title']
        permissions = (
            ('modify_statya', 'Can modify statya'),
        )

    def get_absolute_url(self):
        return reverse('detail', kwargs={'statya_id': self.pk})


class Utilita(models.Model):

    naim = models.CharField(verbose_name='Название утилиты', max_length=255, unique=True)

    description = models.TextField(verbose_name='Описание утилиты', null=False, blank=False, default='', max_length=500)

    file = models.FileField(verbose_name='Файл утилиты', blank=True, upload_to=get_timestamp_path_user)

    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, verbose_name='Автор загрузки утилиты')

    count_downloads = models.IntegerField(verbose_name='Счетчик скачиваний утилиты', default=0)

    class Meta:
        verbose_name_plural = 'Утилиты'
        verbose_name = 'Утилита'
        ordering = ['naim']
        permissions = (
        )

    def __str__(self):
        return f'Утилита: {self.naim}'


class Comment(models.Model):

    statya = models.ForeignKey(Statya, on_delete=models.CASCADE, verbose_name='Статья')

    content = models.TextField(verbose_name='Комментарий', null=False, blank=False, default='', max_length=500)

    author_comment = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, verbose_name='Автор комментария')

    date = models.DateField(verbose_name='Дата публикации комментария', auto_now_add=True)

    def __str__(self):
        return f'Комментарий <{self.content}> к статье: {self.statya}'

    class Meta:
        verbose_name_plural = 'Комментарии'
        verbose_name = 'Комментарий'
        ordering = ['-id']
        permissions = (
            ('modify_comment', 'Can modify comment'),
        )


class Ocenka(models.Model):

    komu = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, verbose_name='Кому поставлена оценка', related_name='komu')

    author_ocenka = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, verbose_name='Автор оценка', related_name='avtor')

    CHOICES = (
        (1, "1"),
        (2, "2"),
        (3, "3"),
        (4, "4"),
        (5, "5"),
    )

    bal = models.IntegerField(choices=CHOICES, default=0)

    def __str__(self):
        return f'Оценка <{self.bal}> пользователю <{self.komu}> от {self.author}'

    class Meta:
        verbose_name_plural = 'Оценка'
        verbose_name = 'Оценки'
        ordering = ['-id']
        permissions = (
            ('modify_ocenka', 'Can modify ocenka'),
        )


class Answer_to_comment(models.Model):
    komu_answer = models.ForeignKey(settings.AUTH_USER_MODEL, related_name='posetitel', on_delete=models.CASCADE, verbose_name='Посетитель')
    comment = models.ForeignKey(Comment, on_delete=models.CASCADE, verbose_name='Комментарий')
    content = models.TextField(verbose_name='Текст ответа на комментарий', max_length=250)
    sent_date = models.DateTimeField(auto_now_add=True)
    author_otveta = models.ForeignKey(settings.AUTH_USER_MODEL, related_name='avtor_otveta', on_delete=models.CASCADE, verbose_name='Автор', null=True)

    class Meta:
        verbose_name_plural = 'Ответы на комментарий'
        verbose_name = 'Ответ на комментарий'
