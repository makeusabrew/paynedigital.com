<?php
/*
    for now, we let the blog app take care of the index route
*/
PathManager::loadPaths(
    array("/(?P<path>[A-z0-9_-]+)", "view_static")
);
