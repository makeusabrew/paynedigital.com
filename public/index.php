<?php
define("PROJECT_ROOT", realpath(dirname(__FILE__)."/../")."/");
if (!defined("JAOSS_ROOT")) {
    define("JAOSS_ROOT", PROJECT_ROOT ."jaoss/");
}
set_include_path(get_include_path() . PATH_SEPARATOR . PROJECT_ROOT);
set_include_path(get_include_path() . PATH_SEPARATOR . JAOSS_ROOT);
ini_set("display_errors", 1);
ini_set("html_errors", "On");
error_reporting(E_ALL ^ E_STRICT);

// convert errors into exceptions
set_error_handler(function($errno, $errstr, $errfile, $errline) {
    throw new ErrorException($errstr, 0, $errno, $errfile, $errline);
});

//@todo this is temporary - some logging happens before we set
//from config. need to hunt that down
date_default_timezone_set("Europe/London");

include("library/Smarty/libs/Smarty.class.php");
include("library/core_exception.php");
include("library/email.php");
include("library/file.php");
include("library/validate.php");
include("library/error_handler.php");
include("library/flash_messenger.php");
include("library/log.php");
include("library/path.php");
include("library/path_manager.php");
include("library/request.php");
include("library/response.php");
include("library/controller.php");
include("library/settings.php");
include("library/database.php");
include("library/table.php");
include("library/object.php");
include("library/app.php");
include("library/app_manager.php");
include("library/cookie_jar.php");
include("library/session.php");
include("library/utils.php");
include("library/image.php");

$mode = getenv("PROJECT_MODE") !== false ? getenv("PROJECT_MODE") : "live";

try {
    Settings::setMode($mode);
    include("library/boot.php");
    include("library/load_apps.php");

    date_default_timezone_set(Settings::getValue("site", "timezone"));

    $request = JaossRequest::getInstance();
    $request->dispatch();
    $response = $request->getResponse();

    $response->sendHeaders();
    echo $response->getBody();
} catch (Exception $e) {
    $handler = new ErrorHandler();
    $handler->handleError($e);
    $response = $handler->getResponse();

    $response->sendHeaders();
    echo $response->getBody();
} catch (Exception $e) {
    exit($e->getMessage());
}
