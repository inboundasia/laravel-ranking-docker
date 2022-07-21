FROM laradock/php-fpm:latest-8.1

RUN apt-get update && \
    apt-get install -y libz-dev git openssh-client libzip-dev

RUN pecl install grpc && \
    docker-php-ext-enable grpc && \
    docker-php-ext-install zip && \
    docker-php-ext-install sockets && \
    docker-php-ext-install pcntl

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"  && \
    php composer-setup.php  && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer

ADD add-ssh-private-key /usr/local/bin/
