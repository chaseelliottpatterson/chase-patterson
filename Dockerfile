# Use the official Nginx image
FROM nginx:latest

# Set working directory
WORKDIR /usr/share/nginx/html

# Copy website files to the Nginx root directory
COPY . /usr/share/nginx/html

# Expose port 80 for web traffic
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]