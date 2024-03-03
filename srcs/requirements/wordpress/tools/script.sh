#!/bin/bash

DB_HOST=$_MDB_HOST
DB_NAME=$_MDB_NAME
DB_USER=$_MDB_USER
DB_PASS=$_MDB_PASS


cat <<EOF > wp-config.php
<?php
define( 'DB_NAME', '$DB_NAME' );
define( 'DB_USER', '$DB_USER' );
define( 'DB_PASSWORD', '$DB_PASS' );
define( 'DB_HOST', '$DB_HOST' );

\$table_prefix = 'wp_';

define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
EOF

/usr/sbin/php-fpm8.2 -F