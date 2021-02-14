FROM php:7.4-fpm-alpine

LABEL Maintainer="Adrien Chinour <git@chinour.fr>"
LABEL Vendor="Adrien Chinour"
LABEL License="MIT"
LABEL Version=7.4-fpm

ARG DEBIAN_FRONTEND=noninteractive
ARG UID
ARG GID

RUN addgroup -S -g $UID app \
    && adduser -S -u $GID -G app app

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN set -eux; \
	composer clear-cache
ENV PATH="${PATH}:/root/.composer/vendor/bin"

USER app

EXPOSE 9000
WORKDIR "/srv"
