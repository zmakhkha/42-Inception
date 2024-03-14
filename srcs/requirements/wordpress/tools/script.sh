#!/bin/bash

wp core download --allow-root

wp config create --dbname=$MDB_NAME --dbuser=$MDB_USER --dbpass=$MDB_PASS --dbhost=$MDB_HOST --allow-root
chmod 777 wp-config.php
wp core install --url="$URL" --title="$WP_TITLE" --admin_user="$WP_SU_USR" --admin_password="$WP_SU_PWD" --admin_email="$WP_SU_EMAIL" --allow-root
wp user create "$WP_USER" "$WP_MAIL" --user_pass="$WP_SEC" --role="$USER_ROLE" --allow-root
wp theme install $WP_THEME --activate --allow-root

/usr/sbin/php-fpm7.4 -F
