FROM nginx:latest

# Install dependencies (snapd for Certbot)
RUN apt update && \
    apt install -y snapd && \
    snap install core && \
    snap refresh core && \
    snap install --classic certbot && \
    ln -s /snap/bin/certbot /usr/bin/certbot && \
    rm -rf /var/lib/apt/lists/*

# Copy website files
COPY . /usr/share/nginx/html

# Copy Nginx configuration
COPY default.conf /etc/nginx/conf.d/default.conf

# Ensure SSL directory exists (prevents Nginx startup failure)
RUN mkdir -p /etc/letsencrypt/live/chase-patterson.com

# Add a script to automatically request SSL on first run
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80 443

# Run entrypoint script first, then start Nginx
CMD ["/entrypoint.sh"]
