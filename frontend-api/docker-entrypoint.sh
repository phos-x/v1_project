#!/bin/sh

# Substitute environment variables in the template
envsubst '${BACKEND_API_URL}' < /etc/nginx/templates/nginx.conf.template > /etc/nginx/conf.d/default.conf

# Start Nginx
exec "$@"
