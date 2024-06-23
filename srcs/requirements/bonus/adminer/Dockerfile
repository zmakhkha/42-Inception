FROM    debian:oldstable

WORKDIR /var/www

RUN		apt-get update && \
apt-get upgrade -y && \
apt-get install nginx -y &&\
apt install -y wget php php-mysqli

RUN     wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -O /var/www/index.php


CMD [ "php", "-S", "0.0.0.0:2200" , "-t", "/var/www" ]