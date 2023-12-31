# Generated by Django 4.2.5 on 2023-12-03 13:24

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('logica', '0016_ocenka_statya'),
    ]

    operations = [
        migrations.CreateModel(
            name='Utilita',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=255, unique=True, verbose_name='Название утилиты')),
                ('description', models.TextField(default='', max_length=200, verbose_name='Описание утилиты')),
                ('data_publication', models.DateField(null=True, verbose_name='Дата загрузки утилиты')),
                ('count_downloads', models.PositiveIntegerField(default=0, verbose_name='Счетчик просмотров')),
                ('moderated', models.BooleanField(default=False, verbose_name='Проверено модератором')),
                ('author', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='author_utilites', to=settings.AUTH_USER_MODEL, verbose_name='Автор утилиты')),
                ('rubrika', models.ManyToManyField(to='logica.rubrika')),
            ],
            options={
                'verbose_name': 'Утилита',
                'verbose_name_plural': 'Утилиты',
                'ordering': ['title'],
            },
        ),
    ]
