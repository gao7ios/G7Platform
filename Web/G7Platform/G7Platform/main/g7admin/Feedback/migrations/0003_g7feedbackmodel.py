# -*- coding: utf-8 -*-
# Generated by Django 1.9.1 on 2016-03-01 09:56
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('Feedback', '0002_delete_g7feedbackmodel'),
    ]

    operations = [
        migrations.CreateModel(
            name='G7FeedbackModel',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('username', models.CharField(blank=True, default='', max_length=200, null=True, verbose_name='联系人姓名')),
                ('contact', models.CharField(blank=True, default='', max_length=200, null=True, verbose_name='联系方式')),
                ('context', models.CharField(default='', max_length=2000, verbose_name='反馈内容')),
            ],
            options={
                'verbose_name': '反馈',
                'verbose_name_plural': '反馈',
            },
        ),
    ]
