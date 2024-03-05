#!/bin/bash

curl  https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
cp wp-cli.phar /usr/bin/
wp core download --allow-root

wp core config --dbhost="mariadb:3306" --dbname="maria" --dbuser="zmakhkha" --dbpass="tfooLALA" --dbprefix="wp_" --allow-root
chmod 600 wp-config.php
wp core install --url="localhost" --title="hahua_title" --admin_user="zmakhkha" --admin_password="hahua123@" --admin_email="zmakhkha_su@gmail.com" --allow-root
wp user create "zak" "zmakhkha@gmail.com" --user_pass="hahua_passTFO" --role="editor" --allow-root
/usr/sbin/php-fpm8.2 -F