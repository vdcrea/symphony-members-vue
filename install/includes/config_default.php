<?php
	$settings = array(


		###### ADMIN ######
		'admin' => array(
			'max_upload_size' => '5242880',
			'upload_blacklist' => '/\\.(?:php[34567s]?|phtml)$/i',
		),
		########


		###### SYMPHONY ######
		'symphony' => array(
			'admin-path' => 'symphony',
			'pagination_maximum_rows' => '20',
			'association_maximum_rows' => '5',
			'lang' => 'en',
			'pages_table_nest_children' => 'no',
			'version' => '2.6.7',
			'cookie_prefix' => 'sym-',
			'session_gc_divisor' => '10',
			'cell_truncation_length' => '75',
			'enable_xsrf' => 'yes',
		),
		########


		###### LOG ######
		'log' => array(
			'archive' => '1',
			'maxsize' => '102400',
		),
		########


		###### DATABASE ######
		'database' => array(
			'host' => 'localhost',
			'port' => '3306',
			'user' => null,
			'password' => null,
			'db' => null,
			'tbl_prefix' => 'sym_',
			'query_caching' => 'on',
			'query_logging' => 'on',
		),
		########


		###### PUBLIC ######
		'public' => array(
			'display_event_xml_in_source' => 'no',
		),
		########


		###### GENERAL ######
		'general' => array(
			'sitename' => 'Symphony Members Vue',
			'useragent' => 'Symphony/2.6.7',
		),
		########


		###### FILE ######
		'file' => array(
			'write_mode' => '0644',
		),
		########


		###### DIRECTORY ######
		'directory' => array(
			'write_mode' => '0755',
		),
		########


		###### REGION ######
		'region' => array(
			'time_format' => 'g:i a',
			'date_format' => 'Y-m-d',
			'datetime_separator' => ' ',
			'timezone' => 'America/Adak',
		),
		########


		###### CACHE_DRIVER ######
		'cache_driver' => array(
			'default' => 'database',
		),
		########


		###### ANTI-BRUTE-FORCE ######
		'anti-brute-force' => array(
			'restrict-access' => 'off',
			'remote-addr-key' => 'REMOTE_ADDR',
			'length' => '60',
			'failed-count' => '5',
			'gl-duration' => '30',
			'gl-threshold' => '5',
			'auto-unban' => 'on',
		),
		########


		###### MAINTENANCE_MODE ######
		'maintenance_mode' => array(
			'enabled' => 'no',
			'ip_whitelist' => null,
			'useragent_whitelist' => null,
		),
		########


		###### MEMBERS ######
		'members' => array(
			'cookie-prefix' => 'sym-members',
			'section' => '1',
			'activate-account-auto-login' => 'yes',
			'generate-recovery-code-template' => 'etm-members-recovery-code',
			'reset-password-auto-login' => 'yes',
			'regenerate-activation-code-template' => 'etm-members-activation',
		),
		########


		###### HTML5_DOCTYPE ######
		'html5_doctype' => array(
			'exclude_pagetypes' => null,
		),
		########


		###### HTTP-RESPONSE-HEADER-MAPPINGS ######
		'http-response-header-mappings' => array(
			'alloworigins' => 'Access-Control-Allow-Origin: *',
			'503' => 'HTTP/1.1 503 Service Unavailable',
			'ra1h' => 'Retry-After: 3600',
			'ra1d' => 'Retry-After: 86400',
			'ra1w' => 'Retry-After: 604800',
			'xml' => 'Content-Type: text/xml; charset=utf-8',
			'txt' => 'Content-Type: text/plain; charset=utf-8',
			'js' => 'Content-Type: application/x-javascript; charset=utf-8',
			'json' => 'Content-Type: application/json; charset=utf-8',
			'css' => 'Content-Type: text/css; charset=utf-8',
			'csv' => 'Content-Type: text/comma-separated-values; charset=utf-16',
			'xls' => 'Content-Type: application/msexcel',
			'rss' => 'Content-Type: application/rss+xml',
		),
		########
	);
