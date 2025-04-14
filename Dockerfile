# Use official PHP Apache image
FROM php:8.1-apache

# Install required PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set ServerName to suppress startup warnings
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Make Apache listen on all interfaces (not just 127.0.0.1)
RUN sed -i 's/Listen 80/Listen 0.0.0.0:8080/' /etc/apache2/ports.conf

# Allow .htaccess overrides for CodeIgniter
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# Copy CodeIgniter project files
COPY . /var/www/html/

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 80 for Render to detect
EXPOSE 80

# Start Apache in foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]
