#!/bin/bash

set -e

uwsgi --socket ${SOCKETS_PATH}/${PROJECT_NAME}.sock \
      --module ${UWSGI_PARENT_MODULE_NAME}.wsgi \
      --uid ${UID_FOR_SOCKETS} \
      --gid ${GID_FOR_SOCKETS}
