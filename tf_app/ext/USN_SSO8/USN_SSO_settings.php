<?php
    /*
        USN SSO Library - settings
        Jan. 18, 2010 
        
        contact us: binseop@gmail.com
    
    */
    
    
    // this variable represent ORBIT login status of each client.
    $IS_LOGIN = (array_key_exists($settings->USN_login_session_name, $_SESSION) && $_SESSION[$settings->USN_login_session_name] != "");
    
    // put client's session key here.
    $SESSION_KEY = $settings->USN_SESSION_KEY;
    
    // put URL of our SSO server here.
    $SSO_URL = $settings->USN_SSO_URL;
    
    // put your secret key here.
    $SECRET_KEY = $settings->USN_SECRET_KEY;
    
    // put your service name here.
    $SERVICE_NAME = $settings->USN_SERVICE_NAME;

    // write after login process here
    function USN_login_success($_userinfo)
    {
        global $settings;
        $settings->USN_login_success($_userinfo);
    }
    
?>