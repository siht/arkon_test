# Pull base image
FROM python:3.8.3-slim-buster

ARG MEDIA_PATH
ARG STATIC_PATH
ARG SOCKETS_PATH
ENV MEDIA_PATH=${MEDIA_PATH:-/app/media/}
ENV STATIC_PATH=${STATIC_PATH:-/app/static/}
ENV SOCKETS_PATH=${SOCKETS_PATH:-/app/sockets/}

WORKDIR /app

RUN apt-get update \
	&& apt-get install -y \
		python3-dev \
		build-essential \
		libpq-dev \
		netcat \
    && pip install --upgrade pip \
    && pip install uwsgi \
    && mkdir -p $MEDIA_PATH $STATIC_PATH $SOCKETS_PATH

COPY . /app/

RUN pip install -r requirements.txt \
	&& python manage.py collectstatic --noinput

CMD ["python", "manage.py", "runserver"]
