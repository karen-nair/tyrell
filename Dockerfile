FROM php:8.1-apache

# Set working directory inside the container
WORKDIR /var/www/html

# Copy project files from your local directory into the container
COPY . /var/www/html/

# Start Apache
CMD ["apache2-foreground"]
