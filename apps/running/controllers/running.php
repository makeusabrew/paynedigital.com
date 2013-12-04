<?php

class RunningController extends AbstractController {
    public function index() {
        // @TODO at some stage move this to a proper model
        $data = file_get_contents(PROJECT_ROOT."apps/running/data/runs.csv");
        $rows = str_getcsv($data);
        $headerCount = 12;
        $headers = array_splice($rows, 0, $headerCount);
        $runs = array();
        $run = array();
        foreach ($rows as $key => $data) {
            $headerIndex = $key % $headerCount;
            $header = $headers[$headerIndex];

            if ($headerIndex === 0) {
                $run = array();
            }

            if ($data === "--") {
                $data = "0"; // stick with strings
            }

            $run[$header] = $data;

            if ($headerIndex === $headerCount -1) {
                $runs[] = $run;
            }
        }
        $this->assign('runs', json_encode($runs));
    }
}
