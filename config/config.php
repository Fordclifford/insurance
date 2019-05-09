<?php

//Note: This file should be included first in every php page.
error_reporting(E_ALL);
ini_set('display_errors', 'On');
define('BASE_PATH', dirname(dirname(__FILE__)));
define('APP_FOLDER', 'insurance');
define('CURRENT_PAGE', basename($_SERVER['REQUEST_URI']));

require_once BASE_PATH . '/lib/MysqliDb/MysqliDb.php';
require_once BASE_PATH . '/helpers/helpers.php';

/*
|--------------------------------------------------------------------------
| DATABASE CONFIGURATION
|--------------------------------------------------------------------------
 */

//define('DB_HOST', "localhost:3306");
//define('DB_USER', "root");
//define('DB_PASSWORD', "mysql");
//define('DB_NAME', "insurance");

/**
 * Get instance of DB object
 */
//function getDbInstance() {
//	return new MysqliDb(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
//}
function getUipDbInstance() {
	return new MysqliDb("localhost:3306", "root", "mysql", "mifostenant-default");
}

function getDbConnection() {
    $DB_HOST = 'localhost:3306';
    $DB_HOST_NAME = 'root';
    $DB_HOST_PASS = 'mysql';
    $DB_NAME = 'mifostenant-default';
    global $conn;
    $conn = mysqli_connect($DB_HOST, $DB_HOST_NAME, $DB_HOST_PASS, $DB_NAME);
    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error());
    }
    return $conn;
}


 