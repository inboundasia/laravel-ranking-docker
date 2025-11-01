FROM laradock/php-fpm:latest-8.3

RUN apt-get update && \
    apt-get install -y libz-dev git openssh-client libzip-dev

RUN pecl install grpc && \
    pecl install mongodb && \
    docker-php-ext-enable grpc mongodb && \
    docker-php-ext-install zip && \
    docker-php-ext-install sockets && \
    docker-php-ext-install pcntl

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"  && \
    php composer-setup.php  && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer

ADD add-ssh-private-key /usr/local/bin/
