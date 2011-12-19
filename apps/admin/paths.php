<?php
PathManager::setAppPrefix("/admin");

PathManager::loadPaths(
    array("", "index"),
    array("/login", "login"),
    array("/logout", "logout"),
    array("/posts/edit/(?P<id>\d+)", "edit_post"),
    array("/posts/add", "add_post"),
    array("/posts/edit/(?P<id>\d+)/generate-burn-link", "generate_burn_link"),
    array("/posts/(?P<id>\d+)/comments", "view_comments"),
    array(
        "pattern" => "/posts/(?P<id>\d+)/comments/edit/(?P<comment_id>\d+)",
        "action"  => "edit_comment",
        "method"  => "POST",
    ),
    array(
        "pattern" => "/posts/(?P<id>\d+)/related",
        "action" => "related_posts",
    ),
    array(
        "pattern" => "/posts/(?P<id>\d+)/related/add",
        "action" => "add_related_post",
        "method" => "POST",
    ),
    array(
        "pattern" => "/posts/(?P<id>\d+)/related/edit/(?P<related_post_id>\d+)",
        "action" => "edit_related_post",
        "method" => "POST",
    ),
    array(
        "pattern" => "/posts/(?P<id>\d+)/related/delete/(?P<related_post_id>\d+)",
        "action" => "delete_related_post",
    )
);
