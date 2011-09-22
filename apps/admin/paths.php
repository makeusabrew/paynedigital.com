<?php
PathManager::loadPaths(
    array("/admin/login", "login"),
    array("/admin", "index"),
    array("/admin/posts/edit/(?P<id>\d+)", "edit_post"),
    array("/admin/posts/add", "add_post")
);
