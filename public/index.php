<?php
define("PROJECT_ROOT", realpath(dirname(__FILE__)."/../")."/");
if (!defined("JAOSS_ROOT")) {
    define("JAOSS_ROOT", PROJECT_ROOT ."jaoss/");
}
set_include_path(get_include_path() . PATH_SEPARATOR . PROJECT_ROOT);
set_include_path(get_include_path() . PATH_SEPARATOR . JAOSS_ROOT);
error_reporting(-1);

// convert errors into exceptions
// alas, PHP < 5.3 doesn't like anonymous callbacks, so this has to be a function...
function handleErrors($errno, $errstr, $errfile, $errline) {
    if (error_reporting() == 0) {
        //Log::info("Surpressed error (".$errno.") caught in handler: [".$errstr."] in [".$errfile."] line [".$errline."]");
        return;
    }
    throw new ErrorException($errstr, 0, $errno, $errfile, $errline);
}
set_error_handler("handleErrors");

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
include("library/cache.php");

/**
 * custom PD stuff (@todo: autoloader!!)
 */
include("apps/stats/statsd.php");

$mode = getenv("PROJECT_MODE") !== false ? getenv("PROJECT_MODE") : "live";

session_cache_limiter(false);

try {
    // make sure a request object is available as soon as possible
    $request = JaossRequest::getInstance();

    Settings::setMode($mode);
    include("library/boot.php");
    include("library/load_apps.php");

    if (($timezone = Settings::getValue("site", "timezone", false)) !== false) {
        date_default_timezone_set($timezone);
    }

    $request->dispatch();
    $response = $request->getResponse();

    $response->setIfNoneMatch(
        $request->getHeader('If-None-Match')
    );

    $response->send();

} catch (Exception $e) {
    $handler = new ErrorHandler();
    $handler->setRequest($request);
    $handler->handleError($e);
    $response = $handler->getResponse();

    $response->send();
} catch (Exception $e) {
    exit($e->getMessage());
}
