FROM composer:2 as composer
FROM php:8.2-cli-alpine

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN apk update && \
    apk add $PHPIZE_DEPS && \
    pecl install opentelemetry && \
    docker-php-ext-enable opentelemetry

COPY . /app/
WORKDIR /app

RUN composer install -n
