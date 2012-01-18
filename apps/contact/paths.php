<?php
PathManager::setAppCacheTtl(300);

PathManager::loadPaths(
    array("/contact", "index"),
    array("/contact/thanks", "thanks")
);
