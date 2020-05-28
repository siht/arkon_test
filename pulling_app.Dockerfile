FROM python:3.8.3-slim-buster

ARG DIRECTORY
ARG AUTOSTART
ARG AUTORESTART
ENV DIRECTORY=${DIRECTORY:-/app/}
ENV AUTOSTART=${AUTOSTART:-false}
ENV AUTORESTART=${AUTORESTART:-false}

WORKDIR /app

RUN apt-get update \
	&& apt-get install -y \
		python3-dev \
		build-essential \
		libpq-dev \
		netcat \
    && pip install --upgrade pip \
    && pip install supervisor

COPY . /app/
COPY ../../config/pulling_app/celery_worker.template /app/celery_worker.template
COPY ../../config/pulling_app/celery_beat.template /app/celery_beat.template
COPY ../../config/pulling_app/entrypoint.sh /app/entrypoint.sh

RUN pip install -r requirements.txt

CMD ["./entrypoint.sh"]
