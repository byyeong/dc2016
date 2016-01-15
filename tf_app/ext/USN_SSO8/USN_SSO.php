<?php
    /*
        USN SSO Library
        Jan. 18, 2010 
        
        contact us: binseop@gmail.com
    
    */
    
    include_once("USN_SSO_settings.php");
    
    if (array_key_exists("lk", $_REQUEST))
    {
        global $SSO_URL;
        
        $_lk = $_REQUEST["lk"];
        $_id = $_REQUEST["id"];
        $next = $_SERVER["REQUEST_URI"];
        $pos = strpos($next, "id=");
        $next = substr($next, 0, $pos - 1);
        
        $FILE = fopen ("http://".$SSO_URL."/login_after?id=".$_id."&lk=".$_lk, "r");
        $read = fread($FILE, 4096);
        
        $ret = new DOMDocument();
        $ret->loadXML($read);
        $x = $ret->documentElement;
        $_error_code = "0";
        $_error_str = "";
        $_userinfo = array();
        foreach ($x->childNodes AS $item)
        {
            switch ($item->nodeName)
            {
                case "error_code":
                    $_error_code = $item->nodeValue;
                    break;
                case "error_str":
                    $_error_str = $item->nodeValue;
                    break;
                case "datas":
                    foreach ($item->childNodes AS $item2)
                    {
                        $_userinfo[$item2->nodeName] = $item2->nodeValue;
                    }
                    break;
                    
            }
        }
        
        if ($_error_code != "403")
        {
            USN_login_success($_userinfo);
            header("Location: $next");
        }
        else
        {
        }
            
            
        
  
        
    }    
    
    function USN_get_login_url()
    {
        global $SSO_URL, $SERVICE_NAME, $SESSION_KEY;
        return "http://".$SSO_URL."/login/".$SERVICE_NAME."/?sk=".$SESSION_KEY."&to_url=http://".$_SERVER["HTTP_HOST"].$_SERVER["REQUEST_URI"];
        
    }
    
    function USN_get_info ($userid)
    {
        global $SSO_URL, $SECRET_KEY, $SERVICE_NAME;
        $_hex_org = $SECRET_KEY.$userid;
        include_once ("sha256.php");
        $_hex = sha256($_hex_org);

        $_url = "http://".$SSO_URL."/underground/info/" . $userid . "/?service=" . $SERVICE_NAME . "&key=" . $_hex;
        $FILE = fopen ($_url, "r");
        $read = fread($FILE, 4096);


        $ret = new DOMDocument();
        $ret->loadXML($read);
        $x = $ret->documentElement;
        $_error_code = "0";
        $_error_str = "";
        $_userinfo = array();
        foreach ($x->childNodes AS $item)
        {
            switch ($item->nodeName)
            {
                case "error_code":
                    $_error_code = $item->nodeValue;
                    break;
                case "error_str":
                    $_error_str = $item->nodeValue;
                    break;
                case "datas":
                    foreach ($item->childNodes AS $item2)
                    {
                        $_userinfo[$item2->nodeName] = $item2->nodeValue;
                    }
                    break;
                    
            }
        }
        
        if ($_error_code != 0)
        {
            return $_error_code;
        }
        else
        {
            return $_userinfo;
        }
        
    }
    
    function USN_regist_servce($userid)
    {
        global $SSO_URL, $SECRET_KEY, $SERVICE_NAME;
        $_hex_org = $SECRET_KEY.$userid;
        include_once ("sha256.php");
        $_hex = sha256($_hex_org);

        $_url = "http://".$SSO_URL."/regist_service/" . $SERVICE_NAME . "/" . $userid . "/?key=" . $_hex;
        $FILE = fopen ($_url, "r");
        $read = fread($FILE, 4096);


        $ret = new DOMDocument();
        $ret->loadXML($read);
        $x = $ret->documentElement;
        $_error_code = "0";
        $_error_str = "";
        $_userinfo = array();
        foreach ($x->childNodes AS $item)
        {
            switch ($item->nodeName)
            {
                case "error_code":
                    $_error_code = $item->nodeValue;
                    break;
                case "error_str":
                    $_error_str = $item->nodeValue;
                    break;
                case "datas":
                    foreach ($item->childNodes AS $item2)
                    {
                        $_userinfo[$item2->nodeName] = $item2->nodeValue;
                    }
                    break;
                    
            }
        }
        
        return $_error_code;
    }

    function USN_drop_servce($userid)
    {
        global $SSO_URL, $SECRET_KEY, $SERVICE_NAME;
        $_hex_org = $SECRET_KEY.$userid;
        include_once ("sha256.php");
        $_hex = sha256($_hex_org);

        $_url = "http://".$SSO_URL."/drop_service/" . $SERVICE_NAME . "/" . $userid . "/?key=" . $_hex;
        $FILE = fopen ($_url, "r");
        $read = fread($FILE, 4096);


        $ret = new DOMDocument();
        $ret->loadXML($read);
        $x = $ret->documentElement;
        $_error_code = "0";
        $_error_str = "";
        $_userinfo = array();
        foreach ($x->childNodes AS $item)
        {
            switch ($item->nodeName)
            {
                case "error_code":
                    $_error_code = $item->nodeValue;
                    break;
                case "error_str":
                    $_error_str = $item->nodeValue;
                    break;
                case "datas":
                    foreach ($item->childNodes AS $item2)
                    {
                        $_userinfo[$item2->nodeName] = $item2->nodeValue;
                    }
                    break;
                    
            }
        }
        
        return $_error_code;        
    }
    
    function USN_iframe()
    {
        global $SSO_URL, $IS_LOGIN, $SERVICE_NAME, $SESSION_KEY;
        
        if ($IS_LOGIN)
            $logged = "true";
        else
            $logged = "false";
        
        $ret = "<iframe src=\"http://".$SSO_URL."/iframe/?loggedin=".$logged."&service=".$SERVICE_NAME."&sk=".$SESSION_KEY."&url=http://".$_SERVER["HTTP_HOST"].$_SERVER["REQUEST_URI"]."\" width=\"0\" height=\"0\" border=\"0\" frameborder=\"0\" scrolling=\"no\"></iframe>";
        
        print $ret;
    }


    
    function USN_logout($_id)
    {
        global $SSO_URL, $SESSION_KEY;
        $FILE = fopen ("http://".$SSO_URL."/underground/logout/?id=".$_id."&sk=".$SESSION_KEY, "r");
        $read = fread($FILE, 4096);
    }
    
    
?>