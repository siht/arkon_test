#!/bin/bash

envsubst < /etc/nginx/nginx_conf.template > /etc/nginx/nginx.conf
envsubst < /etc/nginx/conf.d/mysite.template > /etc/nginx/conf.d/default.conf
nginx -g 'daemon off;'
