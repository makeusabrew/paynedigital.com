<?php
define("PROJECT_ROOT", realpath(dirname(__FILE__)."/../")."/");
if (!defined("JAOSS_ROOT")) {
    define("JAOSS_ROOT", PROJECT_ROOT ."jaoss/");
}
set_include_path(get_include_path() . PATH_SEPARATOR . PROJECT_ROOT);
set_include_path(get_include_path() . PATH_SEPARATOR . JAOSS_ROOT);
ini_set("display_errors", 1);
error_reporting(-1);

set_error_handler(function($errno, $errstr, $errfile, $errline) {
    if (error_reporting() == 0) {
        //Log::info("Surpressed error (".$errno.") caught in handler: [".$errstr."] in [".$errfile."] line [".$errline."]");
        return;
    }
    throw new ErrorException($errstr, 0, $errno, $errfile, $errline);
});

include("library/init.php");

$mode = getenv("PROJECT_MODE") !== false ? getenv("PROJECT_MODE") : "test";
Settings::setMode($mode);

include("library/boot.php");
include("library/load_apps.php");

if (($timezone = Settings::getValue("site", "timezone", false)) !== false) {
    date_default_timezone_set($timezone);
}

include("library/test/phpunit_test_controller.php");
include("library/test/test_request.php");

include("apps/default/controllers/abstract.php");
