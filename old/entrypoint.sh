#!/bin/bash

# Start Nginx in HTTP mode (without SSL)
echo "Starting Nginx in HTTP mode..."
nginx &

# Wait for Nginx to be fully up
sleep 5

# Request SSL certificate (if it doesn't exist)
if [ ! -f "/etc/letsencrypt/live/chase-patterson.com/fullchain.pem" ]; then
    echo "Requesting SSL certificate from Let's Encrypt..."
    certbot certonly --webroot -w /var/www/certbot -d chase-patterson.com -d www.chase-patterson.com --non-interactive --agree-tos -m chaseelliottpatterson@gmail.com
fi

# If Certbot succeeded, update Nginx config to enable HTTPS
if [ -f "/etc/letsencrypt/live/chase-patterson.com/fullchain.pem" ]; then
    echo "SSL certificate obtained. Updating Nginx configuration..."
    cp /etc/nginx/conf.d/default-ssl.conf /etc/nginx/conf.d/default.conf
    nginx -s stop
    sleep 2
    nginx
else
    echo "SSL certificate request failed. Check logs."
fi

# Start Certbot auto-renewal in the background
echo "Starting Certbot auto-renewal..."
certbot renew --quiet &

# Keep the container running
echo "Nginx is running..."
exec nginx -g "daemon off;"
