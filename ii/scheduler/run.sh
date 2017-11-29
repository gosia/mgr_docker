#!/usr/bin/env bash


echo "Starting scheduler in dev=$DEV"

if [[ "$DEV" ]]
then
  echo "Development mode!"
  mvn clean scala:run -Dconfig=development.conf
else
  echo "Using existing .jar file"

  jar_file="/app/scheduler/target/scheduler-1.0.jar"
  echo "$jar_file"

  if [ -f "$jar_file" ]
  then
    echo "Jar file exists"
  else
    echo "Jar file does not exist - packaging"
    mvn package
  fi

  java \
    $JVM_EXTRA_OPTS \
    -Dscheduler.environment=development \
    -Dscheduler.config=development.conf \
    -jar /app/scheduler/target/scheduler-1.0.jar 1>&2
fi
