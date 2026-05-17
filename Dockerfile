FROM laradock/php-fpm:latest-8.4

RUN apt-get update && \
    apt-get install -y libz-dev git openssh-client libzip-dev libicu-dev \
    build-essential g++ make autoconf libtool pkg-config && \
    docker-php-ext-install zip && \
    docker-php-ext-install sockets && \
    docker-php-ext-install pcntl && \
    docker-php-ext-install intl && \
    apt-get purge -y build-essential g++ make autoconf libtool pkg-config && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    EXPECTED_SIGNATURE="c8b085408188070d5f52bcfe4ecfbee5f727afa458b2573b8eaaf77b3419b0bf2768dc67c86944da1544f06fa544fd47" && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    ACTUAL_SIGNATURE="$(php -r 'echo hash_file("sha384", "composer-setup.php");')" && \
    if [ "$ACTUAL_SIGNATURE" != "$EXPECTED_SIGNATURE" ]; then \
        echo "Installer corrupt"; \
        rm composer-setup.php; \
        exit 1; \
    fi && \
    echo "Installer verified" && \
    php composer-setup.php  && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer

COPY add-ssh-private-key /usr/local/bin/
