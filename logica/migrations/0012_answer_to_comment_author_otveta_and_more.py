# Generated by Django 4.2.5 on 2023-12-02 11:15

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('logica', '0011_rename_txt_comment_content'),
    ]

    operations = [
        migrations.AddField(
            model_name='answer_to_comment',
            name='author_otveta',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='avtor_otveta', to=settings.AUTH_USER_MODEL, verbose_name='Автор'),
        ),
        migrations.AlterField(
            model_name='answer_to_comment',
            name='komu_answer',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='posetitel', to=settings.AUTH_USER_MODEL, verbose_name='Посетитель'),
        ),
    ]
