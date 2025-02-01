#!/bin/bash

# Start Nginx without SSL first
echo "Starting Nginx in HTTP mode..."
nginx &

# Wait for Nginx to be fully up
sleep 5

# Test if SSL cert exists
if [ ! -f "/etc/letsencrypt/live/chase-patterson.com/fullchain.pem" ]; then
    echo "No SSL certificate found. Requesting one now..."
    certbot certonly --webroot -w /usr/share/nginx/html -d chase-patterson.com -d www.chase-patterson.com --non-interactive --agree-tos -m chaseelliottpatterson@gmail.com
fi

# If Certbot succeeded, restart Nginx with SSL
if [ -f "/etc/letsencrypt/live/chase-patterson.com/fullchain.pem" ]; then
    echo "SSL certificate obtained. Restarting Nginx with SSL..."
    nginx -s stop
    sleep 2
    nginx
else
    echo "SSL certificate request failed. Check logs."
fi

# Start Certbot auto-renewal in the background
echo "Starting Certbot auto-renewal..."
certbot renew --quiet &

# Keep container running
echo "Nginx is running..."
exec nginx -g "daemon off;"
