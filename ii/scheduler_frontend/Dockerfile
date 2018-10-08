FROM ii_schedulergrunt:latest

ARG github_username
ARG github_access_token

RUN cd /app && \
    git clone 'https://'${github_username}':'${github_access_token}'@github.com/iiuni/scheduler_frontend.git' && \
    cd scheduler_frontend && \
    pip install -r scheduler_frontend/requirements.txt

COPY settings.py /app/settings_docker.py

RUN cd /app/scheduler_frontend && \
    ln -sf /app/settings_docker.py /app/scheduler_frontend/scheduler_frontend/settings_docker.py

WORKDIR /app/scheduler_frontend
EXPOSE 8000
CMD ["ln -sf /app/settings_docker.py /app/scheduler_frontend/scheduler_frontend/settings_docker.py && \
    python manage.py collectstatic --settings=scheduler_frontend.settings_collectstatic --noinput && \
    python manage.py collecttemplates --settings=scheduler_frontend.settings_collectstatic && \
    python manage.py runserver 0.0.0.0:8000 --settings=scheduler_frontend.settings_docker"]
