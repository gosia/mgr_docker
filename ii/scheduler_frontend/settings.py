from scheduler_frontend.settings import *

import os

INSTALLED_APPS = (
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django_scheduler'
)

DEBUG = True
TEMPLATE_DEBUG = True

ALLOWED_HOSTS = ['localhost']

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'scheduler_frontend',
        'USER': 'postgres',
        'PASSWORD': 'asdf',
        'HOST': 'postgres'
    }
}

SCHEDULER_BACKEND_HOST = 'scheduler'
SCHEDULER_BACKEND_PORT = 8000
SCHEDULER_BASE_HREF = 'http://localhost:9602/scheduler/'


STATICFILES_DIRS = []
STATIC_ROOT = os.path.join(BASE_DIR, 'static')
STATICFILES_FINDERS = (
    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
)
STATIC_URL = "/static/"
