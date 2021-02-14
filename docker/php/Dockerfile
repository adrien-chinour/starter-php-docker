FROM php:7.4-fpm-alpine

LABEL Maintainer="Adrien Chinour <git@chinour.fr>"
LABEL Description="Fork of php-fpm:7.4"
LABEL Vendor="Adrien Chinour"
LABEL License="MIT"
LABEL Version=7.4-fpm

ARG DEBIAN_FRONTEND=noninteractive
ARG UID
ARG GID

RUN addgroup -S -g $UID app \
    && adduser -S -u $GID -G app app

RUN set -eux; \
    apk add  --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        coreutils \
        mysql-client \
        libmcrypt \
        libmcrypt-dev \
        icu-dev \
        libxml2-dev \
        freetype-dev \
        libpng-dev \
        libjpeg-turbo-dev \
        autoconf \
        libzip-dev \
        libxslt-dev \
        libwebp-dev \
    ;\
    \
    pecl install \
        xdebug \
        apcu \
    ; \
    pecl clear-cache; \
    docker-php-ext-enable \
        xdebug \
        apcu \
    ; \
    \
    docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp; \
    docker-php-ext-install \
        pdo_mysql \
        mysqli \
        opcache \
        zip \
        xsl \
        intl \
        exif \
        gd \
    ; \
    \
    runDeps="$( \
        scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
            | tr ',' '\n' \
            | sort -u \
            | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )"; \
    apk add --no-cache --virtual .sylius-phpexts-rundeps $runDeps; \
    \
    apk del .build-deps

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN set -eux; \
	composer clear-cache
ENV PATH="${PATH}:/root/.composer/vendor/bin"

USER app

EXPOSE 9000
WORKDIR "/srv"
