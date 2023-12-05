from django.db import models

# Create your models here.
from django.contrib.auth.models import AbstractUser
from django.db import models

from cyber import settings
from .functions import get_timestamp_path_user
from django.conf import settings


class User(AbstractUser):
    username = models.EmailField(unique=False, null=True)
    email = models.EmailField(unique=True, verbose_name='Email')
    birthday = models.DateField(verbose_name='Дата рождения', blank=False)
    description = models.TextField(verbose_name='Обо мне', null=True, blank=True, default='')
    avatar = models.ImageField(verbose_name='Фото', blank=True, upload_to=get_timestamp_path_user)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['birthday', 'username', 'last_name', 'first_name']

    class Meta:
        verbose_name_plural = 'Участники'
        verbose_name = 'Участник'
        ordering = ['last_name']

    def __str__(self):
        return f'{self.first_name} {self.last_name}'

    def get_full_name(self):
        return f'{self.first_name} {self.last_name}'

    def natural_key(self):
        return self.get_full_name()


