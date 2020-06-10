# GET DATA OF CDMX METROBUS

this project pull data every hour from "datos abiertos de la Ciudad de México", and get the neccesary data to implement an API. more information:

- [about API](https://github.com/siht/metrobus_api)
- [about pull data app](https://github.com/siht/metrobus_pull_data)

## DEPENDENCIES

- docker
- docker-compose

### GET THIS CODE

run in terminal

```sh
git clone --recurse-submodules https://github.com/siht/arkon_test.git
```

### ENVIRONMENT FILES

some of these configuration may be repeated

#### .env_django

[read about](https://github.com/siht/metrobus_api)

#### .env_nginx

this file only require the port that serves data into container

- NGINX_INTERNAL_PORT

#### .env_postgres

this file may contains (if you want to do changes to root use), read [postgres documentation](https://hub.docker.com/_/postgres)

- POSTGRES_USER
- POSTGRES_DB
- POSTGRES_PASSWORD

but must contains for configuration of database that use the two apps

- DJANGO_USER
- DJANGO_PASSWORD
- DJANGO_DATABASE_NAME

#### .env_pulling_app

[read about](https://github.com/siht/metrobus_pull_data)

#### .env_shared

contains configurations related to files that will be served by nginx which are in django, and the sockets served by uwsgi.

- SERVER_DATA
- MEDIA_PATH
- STATIC_PATH
- SOCKETS_PATH
- UID_FOR_SOCKETS
- GID_FOR_SOCKETS

#### .env

contains data for docker-compose

- UWSGI_PARENT_MODULE_NAME
- SERVER_DATA
- MEDIA_PATH
- STATIC_ROOT
- SOCKETS_PATH
- UID_FOR_SOCKETS
- GID_FOR_SOCKETS
- PROJECT_NAME
- NGINX_INTERNAL_PORT
- NGINX_OUT_PORT

## HOW TO INSTALL

set all .env files, change permisions 746 for file "./config/nginx/entrypoint.sh" and run

```sh
docker-compose up
```

that command doesnt run the pulling app, so you need to initialize manually the database only run

```sh
docker-compose run web_service ./manage.py migrate
docker-compose run web_service ./manage.py loaddata metrobus_history/fixtures/districts.json
docker-compose run web_service ./manage.py loaddata metrobus_history/fixtures/district_limit_points.json
```

once that you initialize database you may stop all containers

```sh
docker-compose down
```

## RUN APPLICATIONS

once initialized all only left run

```sh
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up
```
