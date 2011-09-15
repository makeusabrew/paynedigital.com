<?php
PathManager::loadPaths(
    array("/", "index"),
    array("/(?P<path>[A-z0-9_-]+)", "view_static")
);
