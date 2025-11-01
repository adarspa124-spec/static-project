# Use a lightweight Nginx base image
FROM nginx:alpine

# Copy the static website files from the local directory
# to the Nginx default web server directory inside the container
COPY . /usr/share/nginx/html

# Expose port 80, which Nginx listens on by default
EXPOSE 80

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon on;"]