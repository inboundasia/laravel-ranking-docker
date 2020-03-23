FROM laradock/php-fpm:2.6.1-7.4

RUN apt-get update && \
    apt-get install -y libz-dev git && \
    pecl install grpc && \
    docker-php-ext-enable grpc && \
    curl -sLO http://ftp.tw.debian.org/debian/pool/main/libz/libzip/libzip-dev_1.5.1-4_amd64.deb && \
    curl -sLO http://ftp.tw.debian.org/debian/pool/main/libz/libzip/libzip4_1.5.1-4_amd64.deb && \
    curl -sLO http://ftp.tw.debian.org/debian/pool/main/o/openssh/openssh-client_7.9p1-10+deb10u1_amd64.deb && \
    dpkg -i openssh-client_7.9p1-10+deb10u1_amd64.deb && \
    dpkg -i libzip4_1.5.1-4_amd64.deb && \
    dpkg -i libzip-dev_1.5.1-4_amd64.deb && \
    docker-php-ext-install zip && \
    docker-php-ext-install sockets && \
    docker-php-ext-install pcntl

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer
