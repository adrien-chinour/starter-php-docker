FROM composer:2.0 AS composer
FROM php:8.0-cli
RUN apt-get update && apt-get install -y libzip-dev zip
RUN docker-php-ext-configure zip && docker-php-ext-install zip
ADD . /app
WORKDIR /app
COPY --from=composer /usr/bin/composer /usr/bin/composer
