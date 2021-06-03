FROM php:fpm

RUN apt-get update && apt-get install -y --no-install-recommends git libzip-dev zip

RUN docker-php-ext-install pdo_mysql \
        zip

# Install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN apt-get update && apt-get install -y nodejs && apt-get clean
RUN npm install --global yarn

COPY --from=composer /usr/bin/composer /usr/bin/composer

USER root
RUN useradd -u 1000 -ms /bin/bash application

WORKDIR /var/www/

EXPOSE 9000
