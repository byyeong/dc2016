<?php
    
/*

    TF External Apps
    Name: logs8
    Author: Binseop Ko
    Description: 로그 컴포넌트 v0.8 용
    
    Version: 2011-06-14
    VersionMin: 0.8.0
    VersionMax: -
    
    
    2011/06/22 0.8 용으로 수정
    2010/05/10 첫 버전
    
*/
    
    include_once("../tf_app/ext/logs/log_model.php");
    include_once("../tf_app/ext/logs/log_controller.php");

    $ref = $_SERVER["HTTP_REFERER"];
    $current_host = "http://" . $_SERVER["HTTP_HOST"];
    $url = $_SERVER["REQUEST_URI"];

    // PV
    $log_pageview->update_pageview($url);

    if (!$ref || substr($ref, 0,strlen($current_host)) == $current_host)
    {
        // same
    }
    else
    {
        if (!$ref) $ref = "";
        else
        {
            $ref = substr($ref, 7, strlen($ref));
            $pos = strpos($ref,"/");
            $ref = substr($ref, 0, $pos);
        }
        
        
        $log_ref->update_ref($ref);
        
    }    
    
    if (!substr($ref, 0,strlen($current_host)) == $current_host)
    {
        $log_uv->update_uv();
    }    

?>