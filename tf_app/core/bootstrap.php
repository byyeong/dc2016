<?php
    /*
        TF CORE
        Name: bootstrap
        Author: Binseop Ko
        Description: 프레임웍 boot up.
        
        Version: 0.8.0
        Last modified: 2011-06-14
        
        Version history _____________
        Jun. 14, 2011 (0.8.0) object_trail 로 대부분의 기능이 분리됨
        Jul. 13, 2010 (0.7.0)
        Feb.  6, 2010 (0.6.1)
        Jan. 13, 2010 (0.6)
        Apr.  7, 2009 (0.5)
        
        Contact: binseop@gmail.com
    
    */
    if (phpversion() >= "5.4")
    {
        // error_reporting(E_ALL & ~E_NOTICE & ~E_STRICT & ~E_WARNING);
        error_reporting(E_ALL & ~E_NOTICE & ~E_STRICT & ~E_WARNING & ~E_DEPRECATED);
        ini_set("display_errors", 1);
    }
    
    // 모델 및 컨트롤러 베이스 로딩
    include_once('../tf_app/core/model.php');
    include_once('../tf_app/core/controller.php');
    include_once('../tf_app/core/route.php');
    include_once('../tf_app/core/object_trail.php');
    
    session_start();
    //include_once('../tf_app/core/error_handler.php');

    $trail = new Trail($_REQUEST['tf_url']);
    $trail->load_global_components();
    $trail->set_route();
    $trail->load_components();
    $trail->load_models();

    $trail->method_invoke();
    
?>
