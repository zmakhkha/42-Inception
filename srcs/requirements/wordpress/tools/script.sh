#!/bin/bash

# Database Configuration
DB_NAME="wordpress"
DB_USER="wordpress"
DB_PASSWORD="wordpress"
DB_HOST="mariadb:3306"

# Create wp-config.php
cat <<EOF > wp-config.php
<?php
define( 'DB_NAME', '$DB_NAME' );
define( 'DB_USER', '$DB_USER' );
define( 'DB_PASSWORD', '$DB_PASSWORD' );
define( 'DB_HOST', '$DB_HOST' );

\$table_prefix = 'wp_';

define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
EOF
