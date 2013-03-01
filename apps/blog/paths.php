<?php
PathManager::setAppCacheTtl(120);

PathManager::loadPaths(
    array("/articles/(?P<month>\d{4}/\d{2})", "view_month"),
    array("/articles/(?P<month>\d{4}/\d{2})/(?P<url>[A-z0-9-]+)", "view_post"),
    array("/articles/tag/(?P<tag>[a-z0-9\s\.]+)", "search_tags"),
    array("/articles", "index"),
    array(
        "pattern"  => "/articles/(?P<month>\d{4}/\d{2})/(?P<url>[A-z0-9-]+)/comment",
        "action"   => "add_comment",
        "cacheTtl" => false,
        "method"   => "POST",
    ),
    array(
        "pattern"  => "/articles/(?P<month>\d{4}/\d{2})/(?P<url>[A-z0-9-]+)/comment/thanks",
        "action"   => "comment_thanks",
        "cacheTtl" => false,
    ),
    array(
        "pattern"  => "/burn-after-reading/(?P<identifier>[A-z0-9]+)",
        "action"   => "burn_after_reading",
        "cacheTtl" => false,
    ),
    array(
        "pattern"  => "/comment-unsubscribe/(?P<hash>[A-z0-9]+)",
        "action"   => "comment_unsubscribe",
        "cacheTtl" => false,
    )
);
