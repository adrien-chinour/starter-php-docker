FROM php:8.0-fpm
MAINTAINER Adrien Chinour <git@chinour.fr>

ARG DEBIAN_FRONTEND=noninteractive

# Add composer
FROM composer:2.0 AS composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Install dependencies
RUN apt-get update \
  && apt-get install -y \
  libzip-dev \
  zip

# Install PHP extensions
RUN docker-php-ext-configure zip \
  && docker-php-ext-install zip

WORKDIR /app
EXPOSE 9000
