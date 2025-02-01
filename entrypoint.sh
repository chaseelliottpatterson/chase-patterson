#!/bin/bash

# Start Nginx with temporary SSL
echo "Starting Nginx with temporary SSL..."
nginx &

# Wait for Nginx to be fully up
sleep 5

# Check if SSL certificate exists, if not, request one
if [ ! -f "/etc/letsencrypt/live/chase-patterson.com/fullchain.pem" ]; then
    echo "No SSL certificate found. Requesting one now..."
    certbot certonly --webroot -w /usr/share/nginx/html -d chase-patterson.com -d www.chase-patterson.com --non-interactive --agree-tos -m chaseelliottpatterson@gmail.com
fi

# If Certbot succeeded, reload Nginx with SSL enabled
if [ -f "/etc/letsencrypt/live/chase-patterson.com/fullchain.pem" ]; then
    echo "SSL certificate obtained. Reloading Nginx..."
    nginx -s reload
else
    echo "SSL certificate request failed. Check logs."
fi

# Start Certbot auto-renewal
echo "Starting Certbot auto-renewal..."
certbot renew --quiet &

# Keep the container running
echo "Nginx is running..."
exec nginx -g "daemon off;"
