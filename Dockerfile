FROM php:8.1-apache
RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN a2enmod rewrite
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
RUN echo "xdebug.mode=coverage" >> /usr/local/etc/php/php.ini
# Install Composer
RUN apt-get update && apt-get -y install zip unzip git
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
# Install GD
RUN apt-get -y install \
        libjpeg-dev \
        libpng-dev \
        libwebp-dev \
        libfreetype-dev
RUN docker-php-ext-configure gd --with-jpeg --with-webp --with-freetype
RUN docker-php-ext-install gd
