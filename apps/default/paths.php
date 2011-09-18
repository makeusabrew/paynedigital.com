<?php
PathManager::loadPaths(
    array("/", "index", null, null, 300),
    array("/(?P<path>[A-z0-9_-]+)", "view_static", null, null, 300)
);
