<?php
PathManager::setAppCacheTtl(300);

PathManager::loadPaths(
    array("/running", "index")
);
