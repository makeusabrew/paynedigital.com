<?php
PathManager::setAppCacheTtl(1200);

PathManager::loadPaths(
    array("/feed\.(xml|rss)", "index")
);
