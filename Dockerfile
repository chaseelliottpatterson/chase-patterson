FROM nginx:latest

# Install Certbot
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y certbot python3-certbot-nginx && \
    rm -rf /var/lib/apt/lists/*

# Create directory for Certbot challenge files
RUN mkdir -p /var/www/certbot

# Copy website files
COPY . /usr/share/nginx/html

# Copy Nginx config
COPY default.conf /etc/nginx/conf.d/default.conf

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80 443

CMD ["/entrypoint.sh"]
