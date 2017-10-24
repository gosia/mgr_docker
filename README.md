Run services in docker (`Docker 17.09.0-ce`, `docker-compose 1.16.1`).

Available services:

* scheduler (scala backend)
* schedulergrunt (run frontend grunt server, use to develop only)


Available dbs:

* couchlocal (local version of couchdb)
* couchproxy (proxy to cloudant hosted couchdb)
* postgres


First steps
===========

Fork git repos
--------------

You need to fork those git repositories to your git account:

* scheduler (https://github.com/iiuni/scheduler)
* django_scheduler (https://github.com/iiuni/django_scheduler)
* runner (https://github.com/iiuni/runner)


Create github access token
--------------------------

https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/


Set your environment variables
------------------------------

Make sure environment variables defined in `local-envs.sh` are exported in your bash.

Install docker and docker-compose
---------------------------------

This project is tested with `Docker 17.09.0-ce` and `docker-compose 1.16.1`.

Run install script
------------------

```bash
➜  ./install.sh
```

General
=======

Running a service
-----------------

```bash
➜  cd ii
➜  docker-compose up -d service_name
```

See what is running
-------------------

```bash
➜  cd ii
➜  docker-compose ps
```

Building base images
--------------------

Base images are used by all services. They main aim is to cache apt-get and maven packages.

```bash
➜  cd ii
➜  docker-compose build --no-cache base
➜  docker-compose build --no-cache basenodejs
➜  docker-compose build --no-cache basescala
```
