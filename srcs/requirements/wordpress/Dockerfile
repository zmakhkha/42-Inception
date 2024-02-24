FROM debian:trixie-slim

WORKDIR /var/www
RUN apt update -y && apt upgrade -y
RUN apt install wget unzip -y
RUN apt install -y php8.2 php8.2-fpm php8.2-mysqli php8.2-curl unzip
RUN apt install unzip

RUN wget https://wordpress.org/latest.zip
RUN mkdir tfoo
RUN unzip latest.zip \
    && rm -rf latest.zip
RUN mkdir -p /usr/share/nginx
RUN touch wp-config.php
RUN sed -i "s|listen = /run/php/php8.2-fpm.sock|listen = 9000|g" /etc/php/8.2/fpm/pool.d/www.conf;
RUN chown www-data:www-data /var/www -R
RUN mkdir -p /run/php/
COPY ./tools/script.sh .
RUN chmod +x script.sh && ./script.sh
CMD ["/usr/sbin/php-fpm8.2", "-F"]