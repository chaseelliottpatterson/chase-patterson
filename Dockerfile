FROM nginx:latest

# Install dependencies
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    certbot python3-certbot-nginx openssl && \
    rm -rf /var/lib/apt/lists/*

# Generate a self-signed SSL certificate to prevent Nginx startup failure
RUN mkdir -p /etc/ssl/certs && mkdir -p /etc/ssl/private && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/ssl-cert-snakeoil.key -out /etc/ssl/certs/ssl-cert-snakeoil.pem -subj "/CN=localhost"

# Copy website files
COPY . /usr/share/nginx/html

# Copy Nginx configuration
COPY default.conf /etc/nginx/conf.d/default.conf

# Add Certbot auto-SSL script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80 443

# Run entrypoint script first, then start Nginx
CMD ["/entrypoint.sh"]