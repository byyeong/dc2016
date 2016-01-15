<?php

/*

    TF External Apps
    Name: tf_service_settings
    Author: Binseop Ko
    Description: 런타임 설정 컴포넌트 v0.8 용
    
    Version: 2010-06-20
    VersionMin: 0.8.0
    VersionMax: -
    

*/


    include_once("../tf_app/ext/tf_service_settings8/settings.php");
    include_once("../tf_app/ext/tf_service_settings8/controller.php");

    foreach ($service_settings as $svs)
    {
        $k = $svs["key"];
        $v = $svs["value"];

        $trail->_settings->$k = $v;
    }

    $trail->add_ext_route("tf_service_settings/admin", "*component*/tf_service_settings8/admin");
    $trail->add_ext_route("tf_service_settings/login", "*component*/tf_service_settings8/login");
    $trail->add_ext_route("tf_service_settings/logout", "*component*/tf_service_settings8/logout");

    
?>
