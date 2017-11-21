FROM ii_basepythonnodejs:latest

ARG github_username
ARG github_access_token

COPY install.sh /app/install.sh


RUN git clone 'https://'${github_username}':'${github_access_token}'@github.com/iiuni/django_scheduler.git' && \
    cd /app/django_scheduler/grunt && \
    /app/install.sh

WORKDIR /app/django_scheduler/grunt

EXPOSE 9601
EXPOSE 35729
CMD grunt connect:livereload:keepalive --debug
