#!/bin/bash
envsubst < ./supervisord.template > /usr/local/etc/supervisord.conf
supervisord
