FROM nginx:latest

# Install dependencies quietly
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y apt-utils certbot python3-certbot-nginx && \
    rm -rf /var/lib/apt/lists/*

# Copy website files
COPY . /usr/share/nginx/html

# Copy Nginx config
COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]