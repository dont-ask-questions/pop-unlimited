<?php

require_once AMFPHP_ROOTPATH . 'popShared.php';

class PlayerService {
    public function save($method, $auth, $data) {
        return \rejectResponse([ 'message' => 'Empty pass_hash supplied' ], 39);
    }

    public function fetch($method, $auth, $data) {
        switch($method) {
            case 'getUserInfo':
                return \rejectResponse([ ]);
            case 'getLastScenes':
                return \rejectResponse([ ]);
                //return \approveResponse([ 'scenes' => [ ] ]);
            default:
                var_dump($method);
                var_dump($auth);
                var_dump($data);
                exit();
        }
    }
}