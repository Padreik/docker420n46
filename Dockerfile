FROM php:fpm

RUN pecl install xdebug && docker-php-ext-enable xdebug

RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql

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
