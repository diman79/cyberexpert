# Generated by Django 4.2.5 on 2023-12-02 05:52

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('logica', '0004_remove_statya_author_statya_author'),
    ]

    operations = [
        migrations.AlterField(
            model_name='statya',
            name='date',
            field=models.DateField(null=True, verbose_name='Дата публикации'),
        ),
    ]