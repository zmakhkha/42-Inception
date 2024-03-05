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
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
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
define( 'DB_CHARSET', 'utf8' );

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
define( 'AUTH_KEY',          'UQupAJkyWuA_ic32HJ@1]BK!Uvrjj3%[~<_9UnI~K>jb=8fy#.jSD^4&Y3`aJ7Hq' );
define( 'SECURE_AUTH_KEY',   '#9.V#s#@><cuY[@i4gD c/hV+G#Q7p?=|^FtV~#u&Y2aC29M;0)J&vjur[l7sls@' );
define( 'LOGGED_IN_KEY',     '<g})>gsit rv|Y95*2})GT9xnvovIVO@buJa g_1 [_Kn`!.Mr2}|*FEXdt<AZ/_' );
define( 'NONCE_KEY',         'S@rjqx1R8uQ[jE IPlUX;T/6:uN%{j.y=L9HtQ(!AR<Z%G2}_R,nP@`v*!nzYD,N' );
define( 'AUTH_SALT',         '0R.t;@6P%(fjRWy=Wlny(NY!_z!e*h3fs/3MJmwiNb%kaDo;S]kK@kS?KgF+b4!X' );
define( 'SECURE_AUTH_SALT',  'wup~!ff[6peM&cjg]|eS4xrZg@A!z)`bY+Ye&29#b]`.Q/U6JkaO=a#STM?pLeX:' );
define( 'LOGGED_IN_SALT',    '^5tOtzvUW/I;h@@n;ylx_Jx`6h3X=L8DsdPB|5=o9e`H,8)/HV!,XT-1grJ2@hg[' );
define( 'NONCE_SALT',        'C+}1Eil/gEU;U)}>C%h1m#,HRo{e@jO]%GEON*oiqTs]qkYP [<7<E~A#_DsaqIk' );
define( 'WP_CACHE_KEY_SALT', '8u#tJK@;b8_Y%Zb4Aq6Y%8SP}x+<TuE:zChS,2%wa(=%(hQs9i3SL}T*1G_WW`d+' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';


/* Add any custom values between this line and the "stop editing" line. */



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
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
if ( ! defined( 'WP_DEBUG' ) ) {
        define( 'WP_DEBUG', false );
}

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';