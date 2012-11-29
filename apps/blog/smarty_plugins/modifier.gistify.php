<?php
/**
 * this is pretty rough and ready and is written with two implicit assumptions
 * (which are fine for paynedigital.com)
 *
 * 1) apc_* is available
 * 2) PHP >= 5.3 (anonymous callback)
 */
function smarty_modifier_gistify($text) {
    $text = preg_replace_callback("@\[gist id=(\d+)\]@s", function($matches) {
        $id = $matches[1];
        $key = Settings::getValue("site", "namespace")."_gist_".$id;
        $cache = Cache::getInstance();
        $gist = $cache->fetch($key);
        if ($cache->fetchHit()) {
            Log::debug("got [".$id."] from cache");
            return $gist;
        }

        Log::debug("Fetching gist ID [".$id."]");

        // oh boy. go fetch the raw JS from GitHub...
        $js = file_get_contents("https://gist.github.com/".$id.".js");
        $js = trim($js);
        if (preg_match("@document\.write\('(<div id=\\\.gist-".$id.".+)'\)$@", $js, $matches)) {
            // extracted the raw JS, but we now have to un-escape it
            $gist = preg_replace("@\\\(\"|'|/)@s", '$1', $matches[1]);
            $gist = preg_replace("@\\\\n@s", "", $gist);
        } else {
            $gist = '';
        }

        // permacache please
        if (!$cache->store($key, $gist)) {
            Log::warn("Could not cache gist ID [".$id."]");
        }
        return $gist;
    }, $text);
    return $text;
}
