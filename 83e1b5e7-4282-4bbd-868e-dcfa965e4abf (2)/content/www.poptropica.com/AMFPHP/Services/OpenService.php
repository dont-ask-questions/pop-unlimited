<?php

require_once AMFPHP_ROOTPATH . 'popShared.php';

class OpenService {
    public function getFeatureStatus($feature) : array {
        return \approveResponse([ 'feature_status' => 'off' ]);
    }

    public function getCampaigns($obj) : array {
        return \approveResponse([
            'cache' => 3600,
            'on_main' => [ ],
            'off_main' => [ ]
        ]);
    }

    public function getCampaignsHaveXML($obj) : array {
        return \approveResponse([ ]);
    }
}