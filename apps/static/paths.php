<?php
PathManager::setAppCacheTtl(300);

PathManager::loadPaths(
    array("/(?P<path>[A-z0-9_-]+)", "view_static")
);
