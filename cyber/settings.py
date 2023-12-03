"""
Django settings for cyber project.

Generated by 'django-admin startproject' using Django 4.2.7.

For more information on this file, see
https://docs.djangoproject.com/en/4.2/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/4.2/ref/settings/
"""

import os
from pathlib import Path

import rest_framework.permissions

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/4.2/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = os.environ.get('SECRET_KEY'),

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = ['127.0.0.1']
INTERNAL_IPS = [
    "127.0.0.1",
]

# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'logica.apps.LogicaConfig',
    'utilites.apps.UtilitesConfig',
    'auth_app.apps.AuthAppConfig',
    'debug_toolbar',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    # 'django.middleware.cache.UpdateCacheMiddleware',
    'django.middleware.common.CommonMiddleware',
    # 'django.middleware.cache.FetchFromCacheMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'debug_toolbar.middleware.DebugToolbarMiddleware',
]


# Session settings
SESSION_ENGINE = 'django.contrib.sessions.backends.cache'
SESSION_CACHE_ALIAS = 'session_store'
SESSION_COOKIE_HTTPONLY = True
SESSION_COOKIE_SECURE = False

# SESSION_FILE_PATH = BASE_DIR / 'session'
SESSION_EXPIRE_AT_BROWSER_CLOSE = False  # при закрытии браузера удаляет файлы сессии
SESSION_COOKIE_AGE = 3000
SESSION_SAVE_EVERY_REQUEST = False
# SESSION_COOKIE_SAMESITE = 'Strict'

# Custom setting for remember user after logged
REMEMBER_KEY = 'is_remember'
REMEMBER_AGE = 60 * 60 * 24 * 365


ROOT_URLCONF = 'cyber.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [BASE_DIR / 'templates', BASE_DIR / 'templates/registration', ],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.contrib.auth.context_processors.auth',
                'auth_app.context_processors.global_context',
                'django.template.context_processors.request',
                'django.template.context_processors.static',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]


WSGI_APPLICATION = 'cyber.wsgi.application'


# Database
# https://docs.djangoproject.com/en/4.2/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'HOST': 'localhost',
        'PORT': '3306',
        'USER': os.environ.get('USER_DB'),
        'PASSWORD': os.environ.get('PASSWORD_DB'),
        'NAME': 'cyberexpert',
        'ATOMIC_REQUEST': 'True',
        'TEST': {
            'NAME': 'lms_project_test',
        },
    }
}


# Password validation
# https://docs.djangoproject.com/en/4.2/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]

CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.redis.RedisCache',
        'LOCATION': 'redis://default:'+os.environ.get('PASSWORD_DB')+'@127.0.0.1:6379/0',
    },
    'session_store': {
        'BACKEND': 'django.core.cache.backends.redis.RedisCache',
        'LOCATION': 'redis://default:'+os.environ.get('PASSWORD_DB')+'@127.0.0.1:6379/1',
    }
}

CACHE_MIDDLEWARE_ALIAS = 'default'
CACHE_MIDDLEWARE_SECONDS = 60 * 10
CACHE_MIDDLEWARE_KEY_PREFIX = 'codeexpert'


LANGUAGE_CODE = 'ru'

TIME_ZONE = "Europe/Samara"

USE_I18N = True

USE_TZ = True

SHORT_DATETIME_FORMAT = 'j.m.Y H:I'

# Internationalization
# https://docs.djangoproject.com/en/4.2/topics/i18n/


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/4.2/howto/static-files/


STATIC_ROOT = BASE_DIR / 'static'
STATIC_URL = '/static/'
STATICFILES_DIRS = [
    BASE_DIR / 'static/img',
    BASE_DIR / 'static/styles',
    BASE_DIR / 'static/scripts',
]
# Default primary key field type
# https://docs.djangoproject.com/en/4.2/ref/settings/#default-auto-field

# Media Files
MEDIA_ROOT = BASE_DIR / 'media'
MEDIA_URL = '/media/'

AUTH_USER_MODEL = 'auth_app.User'


LOGIN_URL = 'log_in'
LOGIN_REDIRECT_URL = 'index'
LOGOUT_URL = 'log_out'

# Email settings
EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = 'smtp.yandex.ru'
EMAIL_USE_TLS = False
EMAIL_PORT = 465
EMAIL_USE_SSL = True
EMAIL_HOST_USER = os.environ.get('EMAIL_HOST_USER')
EMAIL_HOST_PASSWORD = os.environ.get('EMAIL_HOST_PASSWORD')
DEFAULT_FROM_EMAIL = EMAIL_HOST_USER


DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
