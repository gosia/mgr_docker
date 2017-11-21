#!/usr/bin/env bash

cd /app/django_scheduler/grunt

npm install
bower --allow-root install
grunt build
