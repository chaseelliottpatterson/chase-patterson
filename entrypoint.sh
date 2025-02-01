#!/bin/bash

# Wait for Nginx to be ready
sleep 5

# Check if SSL certificate exists, if not, request it
if [ ! -f "/etc/letsencrypt/live/chase-patterson.com/fullchain.pem" ]; then
    echo "No SSL certificate found. Requesting one now..."
    certbot certonly --webroot -w /usr/share/nginx/html -d chase-patterson.com -d www.chase-patterson.com --non-interactive --agree-tos -m chaseelliottpatterson@gmail.com
fi

# Start auto-renewal in the background
echo "Starting Certbot auto-renewal..."
certbot renew --quiet &

# Start Nginx
echo "Starting Nginx..."
exec nginx -g "daemon off;"
