FROM debian:trixie-slim

WORKDIR /var/www
RUN apt update -y && apt upgrade -y
RUN apt install wget unzip -y
RUN apt install -y php8.2 php8.2-fpm php8.2-mysqli php8.2-curl unzip
RUN apt install unzip curl -y
WORKDIR /var/www
RUN mkdir wordpress
WORKDIR /var/www/wordpress



RUN sed -i "s|listen = /run/php/php8.2-fpm.sock|listen = 9000|g" /etc/php/8.2/fpm/pool.d/www.conf;
RUN mkdir -p /run/php/
RUN chown www-data:www-data /var/www -R
RUN curl  https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN cp wp-cli.phar /usr/bin/
COPY ./tools/script2.sh .
RUN chmod +x script2.sh
CMD ["bash", "./script2.sh"]