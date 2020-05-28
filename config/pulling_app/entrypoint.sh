#!/bin/bash

envsubst < ./celery_worker.template > /etc/supervisor/celery_worker.conf
envsubst < ./celery_beat.template > /etc/supervisor/celery_beat.conf
supervisord
