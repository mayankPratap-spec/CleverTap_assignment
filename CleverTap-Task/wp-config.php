<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the website, you can copy this file to "wp-config.php"
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
 * @package WordPress */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'admin' );

/** Database password */
define( 'DB_PASSWORD', 'mayank1999' );

/** Database hostname */
define( 'DB_HOST', '127.0.0.1:3306' );

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
define( 'AUTH_KEY',         '=jxl#=ZNi{!?|6(M0?=>.]fPD:8_<}sUC;7l*48,wS|J:{bG gU<_4T/n:Rt$AwU' );
define( 'SECURE_AUTH_KEY',  'DeX;{Lh`U^9vwo>.iKpWpb~ -[+u.L*Aoj_[2(/}z}phIDEf~ /d#W74eGKM> r(' );
define( 'LOGGED_IN_KEY',    'iA7D!2S#5%CzP$nrtOa{[;9>M#1(+*G%$TtNs3:;+ROAA[eP%J{Vd;ACb_yp38br' );
define( 'NONCE_KEY',        ';QfL1@<`L*HX5jP~}+dzUvXzhWU[{d%+w|{G_OSp-[%``1kp:)*w=PX0qaw$=3n[' );
define( 'AUTH_SALT',        'HAfRwU2}s~$fz~)RJvq5|!i7:ah+jG&!XKW,e:RWQQaOS4>]:g~FhqWTj2?}Z?fh' );
define( 'SECURE_AUTH_SALT', 'vLzA=`;~bBK/o[a;eqYl!qvN8(woC}Rn_35:ee&{i#!6E;/p|;@ Za5&UR?xLqZN' );
define( 'LOGGED_IN_SALT',   '67C1x~p[cmoAL>(9m*&Q:HjZ^MI<_ctK;yl90ahYf<J9gu #>1+_%@o#|QP1oM;!' );
define( 'NONCE_SALT',       'RKyrvkW*irlO%eWH{8M_zD>~`Z@{pdGg`@sIn+MU(cFNEdi+6FS-V=f*N 9y%YXo' );

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



define( 'FS_METHOD', 'direct' );
/**
 * The WP_SITEURL and WP_HOME options are configured to access from any hostname or IP address.
 * If you want to access only from an specific domain, you can modify them. For example:
 *  define('WP_HOME','http://example.com');
 *  define('WP_SITEURL','http://example.com');
 *
 */
if ( defined( 'WP_CLI' ) ) {
	$_SERVER['HTTP_HOST'] = '127.0.0.1';
}

define( 'WP_HOME', 'http://' . $_SERVER['HTTP_HOST'] . '/' );
define( 'WP_SITEURL', 'http://' . $_SERVER['HTTP_HOST'] . '/' );
define( 'WP_AUTO_UPDATE_CORE', 'minor' );
/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';

/**
 * Disable pingback.ping xmlrpc method to prevent WordPress from participating in DDoS attacks
 * More info at: https://docs.bitnami.com/general/apps/wordpress/troubleshooting/xmlrpc-and-pingback/
 */
if ( !defined( 'WP_CLI' ) ) {
	// remove x-pingback HTTP header
	add_filter("wp_headers", function($headers) {
		unset($headers["X-Pingback"]);
		return $headers;
	});
	// disable pingbacks
	add_filter( "xmlrpc_methods", function( $methods ) {
		unset( $methods["pingback.ping"] );
		return $methods;
	});
}
