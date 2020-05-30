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
		gettext-base \
    && pip install --upgrade pip \
    && pip install supervisor

COPY ./src/metrobus_pull_data /app/
RUN pip install -r requirements.txt
COPY ./config/pulling_app/supervisord.template /app/supervisord.template
COPY ./config/pulling_app/entrypoint.sh /app/entrypoint.sh

RUN chmod 777 ./entrypoint.sh

CMD ["./entrypoint.sh"]
