# -*- coding: utf-8 -*-
# Generated by Django 1.9.1 on 2016-03-15 07:48
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Application', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='g7application',
            name='icon',
            field=models.ImageField(blank=True, default='/media/application/icon/default_icon.png', upload_to='application/icon/', verbose_name='图标'),
        ),
    ]
