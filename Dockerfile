FROM nginx:latest

# Install dependencies
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    certbot python3-certbot-nginx && \
    rm -rf /var/lib/apt/lists/*

# Copy website files
COPY . /usr/share/nginx/html

# Copy Nginx configuration
COPY default.conf /etc/nginx/conf.d/default.conf

# Ensure SSL directory exists
RUN mkdir -p /etc/letsencrypt/live/chase-patterson.com

# Add script to auto-request SSL
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80 443

# Run entrypoint script first, then start Nginx
CMD ["/entrypoint.sh"]