FROM nginx:latest

# Install dependencies
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y apt-utils certbot python3-certbot-nginx && \
    rm -rf /var/lib/apt/lists/*

# Copy website files
COPY . /usr/share/nginx/html

# Copy Nginx config
COPY default.conf /etc/nginx/conf.d/default.conf

# Ensure Nginx runs first
CMD ["nginx", "-g", "daemon off;"]