#!/bin/bash

# Start Nginx without SSL first
echo "Starting Nginx..."
nginx &

# Wait for Nginx to be ready
sleep 5

# Request an SSL certificate (if it doesn’t exist)
if [ ! -f "/etc/letsencrypt/live/chase-patterson.com/fullchain.pem" ]; then
    echo "Requesting SSL certificate from Let's Encrypt..."
    certbot certonly --webroot -w /var/www/certbot -d chase-patterson.com -d www.chase-patterson.com --non-interactive --agree-tos -m chaseelliottpatterson@gmail.com
fi

# If SSL was issued, reload Nginx to enable HTTPS
if [ -f "/etc/letsencrypt/live/chase-patterson.com/fullchain.pem" ]; then
    echo "SSL certificate obtained. Restarting Nginx with SSL..."
    nginx -s stop
    sleep 2
    nginx
else
    echo "SSL certificate request failed. Check logs."
fi

# Set up auto-renewal
echo "Starting Certbot auto-renewal..."
certbot renew --quiet &

# Keep Nginx running
echo "Nginx is running..."
exec nginx -g "daemon off;"
