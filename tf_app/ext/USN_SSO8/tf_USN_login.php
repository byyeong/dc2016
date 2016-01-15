<?php
/*

    TF External Apps
    Name: USN SSO
    Author: Binseop Ko
    Description: 유저스토리 SSO 연동.
    
    Version: 2011-06-21
    VersionMin: 0.8.0
    VersionMax: -
    
    History--
    2011.06.21 - Trail 0.8과 호환되도록 일부 수정
    2010.01.18 - 최초 버전
    
*/        

    // 렌더링 후 작업을 등록합니다.
    $trail->add_event_list("after_render", "sso_iframe", iframecall);
    
    $is_login = (array_key_exists("userid", $_SESSION) && $_SESSION["userid"] != "");
    
    
    function iframecall($d1=null)
    {
        USN_iframe();
    }

    include_once("USN_SSO.php");
?>