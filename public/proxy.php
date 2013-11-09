<?php
require("/home/nick/code/web/ReSRC-SDK/src/bootstrap.php");

use ReSRC\ReSRC;

/**
 * this is a long-winded example; eventually several convenience
 * methods will be exposed such that images can be served from
 * as close to a one-liner as possible
 *
 * e.g. $resrc->serveResourceFromString($string);
 */

$options = array(
    "host"   => "http://paynedigital.build/process",
    "token"  => "foo",
);

$resrc = new ReSRC($options);

$string = isset($_GET["q"]) ? $_GET["q"] : null;

if ($string === null) {
    echo 'please supply a single parameter, "q", containing a normal resrc.it query string';
    exit(1);
}

$params = $resrc->getParamsForString($string);

if ($params === null) {
    echo 'the query string provided could not be parsed';
    // @TODO hint at the correct format or provide a link to a resrc.it URL
    exit(1);
}

try {
    if (!$resrc->hasCachedResource($params)) {


        // ping off to resrc.it API
        $imageData = $resrc->fetchProcessedResource($params);

        $resrc->storeResourceImage($params, $imageData);
    }

    // bear in mind this just serves a *cached* resource
    // we need a way of serving an in-memory resource too
    // it would be nice to make one method which could take
    // either some params or a data string
    $resrc->outputResource($params);
} catch (\ReSRC\Exception $e) {
    die("Exception: ".$e->getMessage());
}

// $resrc->getResourceHeaders($params);
// $resrc->getResourceData($params);

// one main method?
// $resrc->serveResourceFromString($string);
//
// e.g. VVVVVV

/*
try {
    $resrc->outputResourceForString($string);
} catch (Exception $e SomeResrcException ) {
    die("doh");
}
*/
