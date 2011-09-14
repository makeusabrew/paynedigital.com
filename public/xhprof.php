<?php
xhprof_enable();
include_once 'index.php';
$xhprof_data = xhprof_disable();

$XHPROF_ROOT = Settings::getValue("xhprof.root");
include_once $XHPROF_ROOT . "/xhprof_lib/utils/xhprof_lib.php";
include_once $XHPROF_ROOT . "/xhprof_lib/utils/xhprof_runs.php";

$xhprof_runs = new XHProfRuns_Default();

$run_id = $xhprof_runs->save_run($xhprof_data, "jaoss_profile");

Log::verbose("XHPROF run ID [".Settings::getValue("xhprof.host")."/index.php?run=".$run_id."&source=jaoss_profile] saved");
