# Use an official PHP image with Apache as the base image
FROM php:8.1-apache

# Install necessary dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql \
    && apt-get clean

# Enable Apache mod_rewrite (required for CodeIgniter)
RUN a2enmod rewrite

# Set the working directory in the container
WORKDIR /var/www/html

# Copy the project files into the container
COPY . /var/www/html/

# Set proper permissions for the files
RUN chown -R www-data:www-data /var/www/html

# Set the ServerName to suppress warnings
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Allow .htaccess overrides for Apache
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# Update Apache to listen on all interfaces (not just 127.0.0.1)
RUN sed -i 's/Listen 80/Listen 0.0.0.0:80/' /etc/apache2/ports.conf

# Expose port 80 for Render to detect
EXPOSE 80

# Set the command to run the Apache server in the foreground
CMD ["apache2-foreground"]
