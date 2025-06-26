FROM php:7.4-apache

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    unzip \
    libzip-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install -j$(nproc) pdo_mysql zip opcache \
    && docker-php-ext-enable opcache

RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

COPY composer.json composer.lock* ./
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-scripts --no-autoloader --no-interaction

COPY . .

RUN composer dump-autoload --optimize \
    && mkdir -p config \
    && cp -r config-dev/* config/

RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

COPY vhost.conf /etc/apache2/sites-available/000-default.conf

EXPOSE 80

CMD ["apache2-foreground"]