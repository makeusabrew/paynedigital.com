<?php
PathManager::setAppCacheTtl(300);

PathManager::loadPaths(
    array("/running/(?P<year>20\d{2})", "archive"),
    array("/running", "index")
);
