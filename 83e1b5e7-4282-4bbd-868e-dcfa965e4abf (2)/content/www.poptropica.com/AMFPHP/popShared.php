<?php

function approveResponse($obj = [ ]) : array {
    $obj['status'] = 7;
    $obj['error'] = null;
    return $obj;
}

function rejectResponse($obj, $status = 21) : array {
    $obj['status'] = $status;
    $obj['error'] = null;
    return $obj;
}