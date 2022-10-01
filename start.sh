#!/bin/sh
rm -rf /opt/gitee/python/django_blog_tutorial/rumor8008.log

cd /opt/gitee/python/django_blog_tutorial

git reset --hard
git pull

source venv/bin/activate
/usr/bin/nohup python manage.py runserver 0.0.0.0:8008 >> /opt/gitee/python/django_blog_tutorial/rumor8008.log 2>&1 &
chmod 777 ./start.sh