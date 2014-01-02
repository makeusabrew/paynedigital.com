<?php
PathManager::setAppCacheTtl(300);

PathManager::loadPaths(
    array("/running/(?P<year>2013)", "archive"),
    array("/running", "index")
);
