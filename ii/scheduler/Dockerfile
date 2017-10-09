FROM ii_basescala:latest

ARG github_username
ARG github_access_token

RUN git clone 'https://'${github_username}':'${github_access_token}'@github.com/iiuni/scheduler.git'
WORKDIR /app/scheduler

COPY production.scala /app/scheduler/config/production.scala
COPY Config.scala /app/scheduler/src/main/scala/com/mgr/scheduler/config/Config.scala

RUN mvn clean install
WORKDIR /app/scheduler/target

EXPOSE 8000
CMD java -Xmx64m -jar scheduler-1.0-jar-with-dependencies.jar -f ../config/production.scala
