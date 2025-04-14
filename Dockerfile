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

# Allow .htaccess overrides for Apache
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# Expose port 80 (default HTTP port)
EXPOSE 80

# Set the command to run the Apache server in the foreground
CMD ["apache2-foreground"]
