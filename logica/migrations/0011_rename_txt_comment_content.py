# Generated by Django 4.2.5 on 2023-12-02 11:05

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('logica', '0010_remove_comment_rod_description'),
    ]

    operations = [
        migrations.RenameField(
            model_name='comment',
            old_name='txt',
            new_name='content',
        ),
    ]