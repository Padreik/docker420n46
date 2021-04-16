FROM php:8.0-apache
RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN a2enmod rewrite
RUN pecl install xdebug-3.0.1
RUN docker-php-ext-enable xdebug
RUN echo "xdebug.mode=coverage" >> /usr/local/etc/php/php.ini
# Install Composer
RUN apt-get update && apt-get install zip unzip git
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
