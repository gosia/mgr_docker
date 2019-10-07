Run services in docker (`Docker 17.09.0-ce`, `docker-compose 1.16.1`).

Available services:

* scheduler_backend (scala backend for scheduler)
* scheduler_frontend (django and grunt frontend for scheduler)
* scheduler_scripts (couch views, scheduler python client)


Available dbs:

* couch (local version of couchdb)
* postgres


First steps
===========

Set your environment variables
------------------------------

Make sure environment variables defined in `local-envs.sh` are exported in your bash.
For example copy-paste it to you `.bashrc_profile` or `.zshrc_profile`

Install docker and docker-compose
---------------------------------

This project is tested with `Docker 17.09.0-ce` and `docker-compose 1.16.1`.

Clone this project
------------------

```bash
➜  cd $II_CLONE_PATH
➜  git clone git@github.com:iiuni/runner.git
➜  cd runner

```

Run install script
------------------

Make sure environments in `local-envs.sh` are exported.

```bash
➜  ./install.sh
```

General knowledge
=================

Running a service
-----------------

```bash
➜  cd ii
➜  docker-compose up -d --no-deps --force-recreate service_name
```

See what is running
-------------------

```bash
➜  cd ii
➜  docker-compose ps
```

Building images
---------------

Before service can be run it has to be built.
Rebuild it when Dockerfile is changed or when requirements are added.

```bash
➜  cd ii
➜  docker-compose build --no-cache service_name
```

Scheduler backend
=================

Scala backend. You'll need it to run frontend as well.

Run
---

```bash
cd ii
docker-compose up -d scheduler_backend
```

Setup db
--------

Create couch database and deploy views.

```bash
docker-compose run scheduler_scripts python couch.py -s http://couch:5984 -d scheduler
```

Load db dump
------------

```bash
docker-compose run scheduler_scripts curl -d @data/couch_dump.json -H"Content-Type: application/json" -X POST http://couch:5984/scheduler/_bulk_docs
```

Python console client
---------------------

It's possible to connect to scheduler from python console.

```bash
➜  docker-compose run scheduler_scripts python
>>> from thriftgen.client import SchedulerClient
>>> c = SchedulerClient().client()
>>> c.getConfigs()
[]
>>>
```

Scheduler frontend (only grunt)
==============================
If you develop only frontend - there's a simplified version of frontend that doesn't
talk to backend but takes backend responses from *.json files.

Run
---

```bash
cd ii
docker-compose up -d --no-deps --force-recreate scheduler_frontend
```

Setup
-----

You need to install grunt dependencies and build static files with grunt.

```bash
cd ii
docker-compose run --rm --no-deps scheduler_frontend "./scripts/install.sh"
```

Open scheduler in browser (only grunt)
--------------------------------------

Go to [http://localhost:9601/](http://localhost:9601/).


Developing static files
-----------------------

When changing js or css files, you have to run `grunt build` command to see changes
in browser (and before `git push` to apply changes).

```bash
docker-compose run --rm --no-deps scheduler_frontend bash -c "cd grunt; grunt build"
```

Scheduler frontend
==================

Scheduler frontend is what you should run to be able to open scheduler in browser.

Run
---

```bash
cd ii
docker-compose up -d scheduler_frontend
```

Setup db
--------

Postgres password: 'asdf'.

```bash
cd ii
docker-compose up -d scheduler_frontend
docker exec -ti ii_postgres_1 psql -U postgres -d postgres --password -c 'create database scheduler_frontend;'
docker exec -ti ii_scheduler_frontend_1 python manage.py migrate
docker exec -ti ii_scheduler_frontend_1 python manage.py createsuperuser --username admin --email admin@cs.uni.wroc.pl
```

Open scheduler in browser
-------------------------

Go to [http://localhost:8000/admin/](http://localhost:800/admin/) and log in (user:admin, password: yours from last step).
Then go to [http://localhost:8000/scheduler/](http://localhost:8000/scheduler/).


Regenerating thrift file
------------------------

* Copy-paste new thrift file to `django_scheduler/thriftgen/scheduler.thrift`
* Run command:
```bash
docker run -v $II_CLONE_PATH/scheduler_frontend/django_scheduler/thriftgen:/data --rm thrift:0.11.0 thrift --gen py -out /data /data/scheduler.thrift
```


Scheduler scripts
=================

Regenerate thrift file
----------------------

* Copy-paste new thrift file to `thriftgen/scheduler.thrift`
* Run command:
```bash
docker run -v $II_CLONE_PATH/scheduler_scripts/thriftgen:/data --rm thrift:0.11.0 thrift --gen py -out /data /data/scheduler.thrift
```

Python console client
---------------------

It's possible to connect to scheduler from python console.

```bash
➜  docker-compose run scheduler_scripts bpython
>>> from thriftgen.client import SchedulerClient
>>> c = SchedulerClient().client()
>>> c.getConfigs()
[]
>>>
```
