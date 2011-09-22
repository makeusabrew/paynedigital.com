<?php
// helper function to set the default cache TTL for a group of paths
PathManager::setAppCacheTtl(300);

PathManager::loadPaths(
    array("/", "index")
);
