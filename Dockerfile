FROM laradock/php-fpm:latest-8.3

RUN apt-get update && \
    apt-get install -y libz-dev git openssh-client libzip-dev libicu-dev \
    build-essential g++ make autoconf libtool pkg-config \
    libprotobuf-dev protobuf-compiler

RUN pecl install grpc && \
    pecl install mongodb && \
    docker-php-ext-enable grpc mongodb && \
    docker-php-ext-install zip && \
    docker-php-ext-install sockets && \
    docker-php-ext-install pcntl && \
    docker-php-ext-install intl

RUN apt-get purge -y build-essential g++ make autoconf libtool pkg-config protobuf-compiler && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === 'c8b085408188070d5f52bcfe4ecfbee5f727afa458b2573b8eaaf77b3419b0bf2768dc67c86944da1544f06fa544fd47') { echo 'Installer verified'.PHP_EOL; } else { echo 'Installer corrupt'.PHP_EOL; unlink('composer-setup.php'); exit(1); }"  && \
    php composer-setup.php  && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer

ADD add-ssh-private-key /usr/local/bin/
