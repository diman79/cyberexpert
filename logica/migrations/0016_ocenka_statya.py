# Generated by Django 4.2.5 on 2023-12-03 07:04

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('logica', '0015_statya_reiting'),
    ]

    operations = [
        migrations.AddField(
            model_name='ocenka',
            name='statya',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='statya', to='logica.statya', verbose_name='Оцениваемая статья'),
        ),
    ]