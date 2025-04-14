# Use an official PHP image as the base image
FROM php:8.1-apache

# Install PHP extensions required for CodeIgniter
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy the CodeIgniter project files to the container
COPY . /var/www/html/

# Set proper permissions for the files
RUN chown -R www-data:www-data /var/www/html

# Allow .htaccess overrides for CodeIgniter
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# Expose port 80 for the web server
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
