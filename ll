<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/documentation/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'maria' );

/** Database username */
define( 'DB_USER', 'zmakhkha' );

/** Database password */
define( 'DB_PASSWORD', 'tfooLALA' );

/** Database hostname */
define( 'DB_HOST', 'mariadb:3306' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'L:w@p6maQ.r1ze*r,@h%!se_Z3:1;KCw3R`/FQ~q~c4IL7GGeB7/w+@tyXC:2sx3' );
define( 'SECURE_AUTH_KEY',  '+MKw`jH*t7Zz!AYR6;WKU4p{<qQ/4ZtQ~-Qv|Iqi%@n~/3E 2$0:-X.{$n.c0ma_' );
define( 'LOGGED_IN_KEY',    '2xjO,gxeh>j% 5^F4{#D5wJ(m0;N%[8Tz<4&lP62&d6 8%$5vAN9{hB&lxtVk4cV' );
define( 'NONCE_KEY',        'D5x9}1S;s8DNmdI(+ecDmo~t,?1j#quSvHg:2pW]#z9q5w)kLvm,rP>})O5uaQ^w' );
define( 'AUTH_SALT',        'q7*P>Fv4[cgzl-8XtVrnd2v{6p4 khU{zF!]cTqfn9r2YVJ*{`<kBMI/prx6q02`' );
define( 'SECURE_AUTH_SALT', '/HjG9d2h:Vtk J:0[)F>RSZ~M(du{&R%|Y,7t;o2wzzJNSC` n!5iXn%u2{WBhuI' );
define( 'LOGGED_IN_SALT',   'R/qXPk8Hh@0D^%(i>(|M1*l=}gG)2]X>duhP*TQ5}sXw&^iw7to!{~m$LXFf#fH?' );
define( 'NONCE_SALT',       'pXs?KvZr*-4FdMEx4TO/u(A.eLgBdo5Q}+r}4Yd3i>Ll20gEniAd:R.M9;O)|%9u' );

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/documentation/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';