<?php
$start = microtime(true);
include 'index.php';
$end = microtime(true);
StatsD::timing("response", round(($end - $start)*1000, 1));
