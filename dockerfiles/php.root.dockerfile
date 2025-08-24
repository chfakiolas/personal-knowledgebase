FROM php:8.3-fpm-alpine

# Install build dependencies
RUN apk add --no-cache \
        $PHPIZE_DEPS \
        libzip-dev \
        curl-dev \
        openssl-dev \
        zlib-dev \
    && docker-php-ext-install pdo pdo_mysql \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del $PHPIZE_DEPS   # cleanup build deps

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN sed -i "s/user = www-data/user = root/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = root/g" /usr/local/etc/php-fpm.d/www.conf
RUN echo "php_admin_flag[log_errors] = on" >> /usr/local/etc/php-fpm.d/www.conf
    
USER root

CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]
