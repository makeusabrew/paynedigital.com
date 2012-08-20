<?php
define("PROJECT_ROOT", realpath(dirname(__FILE__)."/../")."/");
if (!defined("JAOSS_ROOT")) {
    define("JAOSS_ROOT", PROJECT_ROOT ."jaoss/");
}
set_include_path(get_include_path() . PATH_SEPARATOR . PROJECT_ROOT);
set_include_path(get_include_path() . PATH_SEPARATOR . JAOSS_ROOT);
error_reporting(-1);

// alas, PHP < 5.3 doesn't like anonymous callbacks, so this has to be a function...
function handleErrors($errno, $errstr, $errfile, $errline) {
    if (error_reporting() == 0) {
        //Log::info("Surpressed error (".$errno.") caught in handler: [".$errstr."] in [".$errfile."] line [".$errline."]");
        return;
    }
    throw new ErrorException($errstr, 0, $errno, $errfile, $errline);
}
set_error_handler("handleErrors");

include("library/init.php");

$mode = getenv("PROJECT_MODE") !== false ? getenv("PROJECT_MODE") : "live";

//session_cache_limiter(false);

try {
    // make sure a request object is available as soon as possible
    $request = JaossRequest::getInstance();

    Settings::setMode($mode);

    include("library/boot.php");
    include("library/load_apps.php");

    if (Settings::getValue("date", "allow_from_cookie", false) ) {
        $date = CookieJar::getInstance()->getCookie("test_date");
        if ($date !== null) {
            Utils::setCurrentDate($date);
        }
    }

    $request->dispatch();
    $response = $request->getResponse();

    /*
    $response->setIfNoneMatch(
        $request->getHeader('If-None-Match')
    );
    */

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
