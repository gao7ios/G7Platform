# -*- coding: utf-8 -*-
# Generated by Django 1.9.1 on 2016-01-27 07:11
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='G7Application',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('product_id', models.IntegerField(default=0, verbose_name='产品id')),
                ('product_type', models.IntegerField(blank=True, choices=[(0, '未知(ids默认为0)'), (1, 'iPhone/iTouch版本'), (2, 'HD版本，仅适用iPad/iPad2'), (3, '通用版本，适用iOS系列')], default=0, null=True, verbose_name='产品类型')),
                ('channel', models.IntegerField(default=0, verbose_name='频道')),
                ('inner_version', models.IntegerField(default=0, verbose_name='内部版本')),
                ('name', models.CharField(max_length=150, verbose_name='名字')),
                ('appid', models.CharField(blank=True, default='', max_length=100, unique=True, verbose_name='标识码')),
                ('file', models.FileField(blank=True, null=True, upload_to='application/package', verbose_name='ipa包文件')),
                ('dsymFile', models.FileField(blank=True, null=True, upload_to='application/package', verbose_name='dsym包文件')),
                ('version', models.CharField(blank=True, default='0.0', max_length=150, verbose_name='版本')),
                ('icon', models.ImageField(blank=True, default='application/icon/default_icon.png', upload_to='application/icon/', verbose_name='图标')),
                ('create_at', models.DateTimeField(auto_now_add=True, verbose_name='创建时间')),
                ('modified_at', models.DateTimeField(auto_now=True, verbose_name='更新时间')),
                ('bundleID', models.CharField(blank=True, default='', max_length=200, null=True, verbose_name='标识符(BundleID)')),
                ('description', models.TextField(blank=True, default='', null=True, verbose_name='说明')),
                ('build_version', models.CharField(default='0', max_length=200, verbose_name='编译版本')),
                ('frameworks', models.ManyToManyField(blank=True, related_name='applications', to='Application.G7Application', verbose_name='使用到的框架')),
            ],
            options={
                'verbose_name': '应用',
                'verbose_name_plural': '应用',
            },
        ),
        migrations.CreateModel(
            name='G7Project',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('platform', models.IntegerField(blank=True, choices=[(0, '通用'), (1, 'iOS'), (2, 'Android'), (999, '其他')], default=0, verbose_name='目标平台')),
                ('project_type', models.IntegerField(choices=[(0, '应用程序'), (1, '客户端框架'), (2, '服务端框架'), (3, '插件'), (4, '开源项目'), (5, '开发工具')], default=0, verbose_name='类型')),
                ('project_status', models.IntegerField(choices=[(0, '新建'), (1, '策划中'), (2, '设计中'), (3, '开发中'), (4, '测试中'), (5, '提审中'), (6, '审核中'), (7, '回归中'), (8, '发布')], default=0, verbose_name='状态')),
                ('project_id', models.IntegerField(default=0, verbose_name='产品id')),
                ('latest_version', models.CharField(blank=True, default='0.0', max_length=200, null=True, verbose_name='最新版本')),
                ('latest_inner_version', models.IntegerField(blank=True, default=0, null=True, verbose_name='最新内部版本')),
                ('latest_build_version', models.CharField(blank=True, default=0, max_length=200, null=True, verbose_name='最新编译版本')),
                ('name', models.CharField(default='', max_length=150, verbose_name='名称')),
                ('descriptin', models.TextField(blank=True, default='', null=True, verbose_name='产品简介')),
                ('icon', models.ImageField(default='project/icon/default_icon.png', upload_to='project/icon/', verbose_name='图标')),
                ('identifier', models.CharField(blank=True, default='', max_length=100, unique=True, verbose_name='标识码')),
                ('bundleID', models.CharField(default='', max_length=200, unique=True, verbose_name='标识符(BundleID)')),
                ('create_at', models.DateTimeField(auto_now_add=True, verbose_name='创建时间')),
                ('modified_at', models.DateTimeField(auto_now=True, verbose_name='更新时间')),
                ('applications', models.ManyToManyField(blank=True, related_name='projects', to='Application.G7Application', verbose_name='应用')),
                ('members', models.ManyToManyField(blank=True, db_constraint=False, related_name='projects', to=settings.AUTH_USER_MODEL, verbose_name='成员')),
                ('owner', models.ForeignKey(blank=True, db_constraint=False, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='+', to=settings.AUTH_USER_MODEL, verbose_name='拥有人')),
            ],
            options={
                'verbose_name': '产品',
                'verbose_name_plural': '产品',
            },
        ),
    ]