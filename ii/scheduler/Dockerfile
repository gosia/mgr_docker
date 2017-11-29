FROM ii_basescala:latest

ARG github_username
ARG github_access_token

RUN git clone 'https://'${github_username}':'${github_access_token}'@github.com/iiuni/scheduler.git'
WORKDIR /app/scheduler

COPY run.sh /app/run.sh

WORKDIR /app/scheduler

EXPOSE 8000
CMD /app/run.sh
