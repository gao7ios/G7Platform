# -*- coding: utf-8 -*-
# Generated by Django 1.9.1 on 2016-03-28 13:06
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('Feedback', '0008_g7feedbackmodel_image'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='g7feedbackmodel',
            name='image',
        ),
    ]
