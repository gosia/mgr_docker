#!/usr/bin/env bash

sed -i 's/USERNAME/'"$CLOUDANT_USERNAME"'/g' /etc/nginx/nginx.conf
sed -i 's/PASSWORD/'"$CLOUDANT_AUTHORIZATION_HEADER"'/g' /etc/nginx/nginx.conf

nginx -g "daemon off;"
