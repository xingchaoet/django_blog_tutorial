# Generated by Django 2.2.13 on 2022-10-14 20:25

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('WeiboScrapy', '0002_auto_20221013_1648'),
    ]

    operations = [
        migrations.AlterField(
            model_name='weibo',
            name='publish_tool',
            field=models.CharField(max_length=32),
        ),
    ]
