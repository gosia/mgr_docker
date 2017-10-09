FROM ii_base:latest

RUN apt-get update && \
    curl -SLO "https://nodejs.org/dist/v8.6.0/node-v8.6.0-linux-x64.tar.xz" && \
    tar -xJf "node-v8.6.0-linux-x64.tar.xz" -C /usr/local --strip-components=1 && \
    ln -s /usr/local/bin/node /usr/local/bin/nodejs && \
    npm install -g grunt-cli && \
    npm install -g bower
