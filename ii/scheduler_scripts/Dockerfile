FROM ii_basepythonnodejs:latest

ARG github_username
ARG github_access_token

RUN git clone 'https://'${github_username}':'${github_access_token}'@github.com/iiuni/scheduler_scripts.git' && \
    cd /app/scheduler_scripts && \
    pip install -r requirements.txt

WORKDIR /app/scheduler_scripts
