Run services in docker (`Docker 17.09.0-ce`, `docker-compose 1.16.1`).

Available services:

* scheduler (scala backend)
* schedulerfrontend (django frontend)
* schedulergrunt (frontend grunt server, use to develop js/html/css only)
* schedulerscripts (couch views, scheduler python client)


Available dbs:

* couchlocal (local version of couchdb)
* couchproxy (proxy to cloudant hosted couchdb)
* postgres


First steps
===========

Create github access token
--------------------------

https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/


Set your environment variables
------------------------------

Make sure environment variables defined in `local-envs.sh` are exported in your bash.
For example copy-paste it to you `.bashrc_profile` or `.zshrc_profile`

Install docker and docker-compose
---------------------------------

This project is tested with `Docker 17.09.0-ce` and `docker-compose 1.16.1`.

Run install script
------------------

Make sure environments in `local-envs.sh` are exported.

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
➜  docker-compose build --no-cache basepythonnodejs
➜  docker-compose build --no-cache basescala
```

Scheduler
=========

Scala backend. You'll need it to run frontend as well.

Run
---

```bash
cd ii
docker-compose up -d scheduler
```

Setup db
--------

Create couch database and deploy views.

```bash
docker-compose run schedulerscripts python couch.py -s http://couch:5984 -d scheduler
```

Load db dump
------------

```bash
docker-compose run schedulerscripts curl -d @data/couch_dump.json -H"Content-Type: application/json" -X POST http://couch:5984/scheduler/_bulk_docs
```

Python console client
---------------------

It's possible to connect to scheduler from python console.

```bash
➜  docker-compose run schedulerscripts python
>>> from thriftgen.client import SchedulerClient
>>> c = SchedulerClient().client()
>>> c.getConfigs()
[]
>>>
```

Scheduler frontend
==================

Scheduler frontend is what you should run to be able to open scheduler in browser.

Run
---

```bash
cd ii
docker-compose up -d schedulerfrontend
```

Setup db
--------

Postgres password: 'asdf'.

```bash
cd ii
docker-compose up -d schedulerfrontend
docker exec -ti ii_postgres_1 psql -U postgres -d postgres --password -c 'create database scheduler_frontend;'
docker exec -ti ii_schedulerfrontend_1 python manage.py migrate --settings=scheduler_frontend.settings_docker
docker exec -ti ii_schedulerfrontend_1 python manage.py createsuperuser --username admin --email admin@cs.uni.wroc.pl --settings=scheduler_frontend.settings_docker
```

Open scheduler in browser
-------------------------

Go to [http://localhost:9602/admin/](http://localhost:9602/admin/) and log in (user:admin, password: yours from last step).
Then go to [http://localhost:9602/scheduler/](http://localhost:9602/scheduler/).


Scheduler scripts
=================

Regenerate thrift file
----------------------

* Copy-paste new thrift file to `thriftgen/scheduler.thrift`
* Run command:
```bash
docker run -v $II_CLONE_PATH/scheduler_scripts/thriftgen:/data --rm thrift:0.10.0 thrift --gen py -out /data /data/scheduler.thrift
```

Python console client
---------------------

It's possible to connect to scheduler from python console.

```bash
➜  docker-compose run schedulerscripts bpython
>>> from thriftgen.client import SchedulerClient
>>> c = SchedulerClient().client()
>>> c.getConfigs()
[]
>>>
```

Django scheduler
================

Regenerate thrift file
----------------------

* Copy-paste new thrift file to `django_scheduler/thriftgen/scheduler.thrift`
* Run command:
```bash
docker run -v $II_CLONE_PATH/django_scheduler/django_scheduler/thriftgen:/data --rm thrift:0.10.0 thrift --gen py -out /data /data/scheduler.thrift
```
