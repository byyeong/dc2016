<?php

    /*
        TF CORE
        Name: error handler
        Author: Binseop Ko
        Description: 프레임웍 전역 에러 핸들러.
        
        Version: 0.8.0
        Last modified: 2011-06-14
        
        Version history _____________
        Jun. 14, 2011 (0.8.0) - 신규작성
        
        Contact: binseop@gmail.com
    
    */
    
    
    // 에러 핸들러
    function tf_warning_handler_debug($errno, $errstr) {
        if (substr($errstr,0,5) == 'mysql')
        {   // mysql 에러
            print ('SQL ERROR:' . mysql_error() . '<br />');
        }
        else if (substr($errstr,0,5) == 'fsock')
        {   // 캐시 에러, 넘긴다.
        }
        else
        {   // 기타 에러
            print $errno;
            print $errstr;
        }
    }

    function tf_warning_handler($errno, $errstr) {
        if (substr($errstr,0,5) == 'mysql' || substr($errstr,0,5) == 'fsock')
        {
        }
        else
        {
            print $errno;
            print $errstr;
        }
    }

    // 디버그 설정에 따른 에러 핸들러 연결
    if ($trail->_settings->debug)
        set_error_handler('tf_warning_handler_debug', E_WARNING);
    else
        set_error_handler('tf_warning_handler', E_WARNING);

?>