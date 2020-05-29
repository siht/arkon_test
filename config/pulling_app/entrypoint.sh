#!/bin/bash
envsubst < ./celery_worker.template > /usr/local/etc/celery_worker.conf
envsubst < ./celery_beat.template > /usr/local/etc/celery_beat.conf
supervisord
