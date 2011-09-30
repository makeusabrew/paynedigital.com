<?php
PathManager::setAppPrefix("/admin");

PathManager::loadPaths(
    array("", "index"),
    array("/login", "login"),
    array("/posts/edit/(?P<id>\d+)", "edit_post"),
    array("/posts/add", "add_post"),
    array("/posts/edit/(?P<id>\d+)/generate-burn-link", "generate_burn_link")
);
