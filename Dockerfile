FROM nginx:latest

# Install Certbot
RUN apt update && apt install -y certbot python3-certbot-nginx

# Copy website files
COPY . /usr/share/nginx/html

# Copy Nginx config
COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]