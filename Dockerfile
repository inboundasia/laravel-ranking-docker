FROM laradock/php-fpm:2.6.1-7.4

RUN apt-get update && \
    apt-get install -y libz-dev git openssh-client libzip-dev

RUN pecl install grpc && \
    docker-php-ext-enable grpc && \
    docker-php-ext-install zip && \
    docker-php-ext-install sockets && \
    docker-php-ext-install pcntl

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer

ADD add-ssh-private-key /usr/local/bin/
