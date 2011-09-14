<?php
PathManager::loadPaths(
    array("/", "index"),
    array("/(?P<month>\d{4}/\d{2})/(?P<url>[A-z0-9-]+)", "view_post")
);
