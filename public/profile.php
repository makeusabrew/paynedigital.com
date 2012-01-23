<?php
$start = microtime(true);
include 'index.php';
$end = microtime(true);
StatsD::timing("paynedigital.time", $end - $start);
