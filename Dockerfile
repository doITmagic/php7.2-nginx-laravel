FROM phpearth/php:7.2-nginx

MAINTAINER razvan@doitmagic.com

WORKDIR /var/www

ADD code /var/www
ADD default.conf /etc/nginx/conf.d/default.conf
ADD start.sh /var/www/start.sh

RUN apk add php7.2-mysqli \
            php7.2-mysqlnd \
            php7.2-pdo_mysql \
            php7.2-pdo \
            php7.2-gd \
            php7.2-gettext \
            php7.2-intl \
            php7.2-mcrypt \
            php7.2-json \
            php7.2-openssl \
            php7.2-mbstring \
            php7.2-pcntl \
            php7.2-posix \
            php7.2-soap \
            php7.2-wddx \
            php7.2-xmlrpc \
            php7.2-xsl \
            php7.2-zlib \
            php7.2-zip \
            php7.2-curl \
            php7-amqp \
            imagemagick \
            libmagickwand-dev \
            curl \
            zip \
            unzip \
            composer \
            openssl \
            vim \
            sudo \
            git \
            wget && \
    wget -q https://dl.minio.io/client/mc/release/linux-amd64/mc -O /root/mc  && \
    chmod +x /root/mc && \
    ln -s /root/mc /usr/bin/mc && \
    composer update && \
    sed -i 's/user nginx;/user www-data;/' /etc/nginx/nginx.conf && \
    chown -R www-data:www-data /var/www && \
    chmod 755 /var/www/storage &&\
    chmod 755 /var/www/bootstrap/cache && \
    chmod +x /var/www/start.sh && \
    sed -i 's/max_input_time = 60/max_input_time = 10800/' /etc/php/7.2/php.ini && \
    sed -i 's/max_execution_time = 30/max_execution_time = 10800/' /etc/php/7.2/php.ini && \
    sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 120M/' /etc/php/7.2/php.ini && \
    sed -i 's/post_max_size = 8M/post_max_size = 120M/' /etc/php/7.2/php.ini && \
    sed -i 's/memory_limit = 128M/memory_limit = 512M/' /etc/php/7.2/php.ini

COPY nginx-setup/default.conf /etc/nginx/sites-available/default.conf
# NGINX mountable directories for config and logs
VOLUME ["/var/www","/etc/nginx/conf.d", "/var/log/nginx","/etc/nginx/ssl"]


EXPOSE 80 443

CMD ["./start.sh"]