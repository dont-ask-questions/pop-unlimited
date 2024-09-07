items_info=<?php

$cats = explode('|', $_POST['cats'] ?? '');
$json = [ ];

for($i = 0; $i < count($cats); $i++)
    $json[urlencode($cats[$i])] = [ ];

echo json_encode($json);