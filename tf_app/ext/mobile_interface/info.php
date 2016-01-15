<?
    // mobile interface
    
    include_once("../tf_app/ext/mobile_interface/model.php");
    include_once("../tf_app/ext/mobile_interface/controller.php");    
    include_once("../tf_app/ext/sha256.php");    


    function session_auth()
    {
        
        if (array_key_exists("testid", $_REQUEST))
        {
            return $_REQUEST["testid"];
        }
        
        
        $uri = $_SERVER["REQUEST_URI"];
        $session_id = $_REQUEST["session_id"];
        $session_key = $_REQUEST["session_key"];
        
        $pos = strpos($uri, "session_id=");
        if ($pos > 0)
        {
            $urix = substr($uri, 0, $pos) . substr($uri, $pos + 12 + strlen($session_id), strlen($uri));
            $uri = $urix;
        }
        
        if ($pos < 1)
        {
            $result = array("error_code"=>"403.1","error_desc"=>"SESSION ID is missing.");
            echo json_encode($result);
            exit(0);
        }
        
        $pos = strpos($uri, "session_key=");
        if ($pos > 0)
        {
            $urix = substr($uri, 0, $pos) . substr($uri, $pos + 13 + strlen($session_key), strlen($uri));
            $uri = $urix;
        }

        if ($pos < 1)
        {
            $result = array("error_code"=>"403.2","error_desc"=>"SESSION KEY is missing.");
            echo json_encode($result);
            exit(0);
        }
        
        if (substr($uri, strlen($uri)-1,1) == "&" || substr($uri, strlen($uri)-1,1) == "?") $uri = substr($uri, 0,strlen($uri)-1);
        
        $es = load_ext_model("Mobile_sessions");
        
        $sess = $es->get_session($session_id);
        
        if (!$sess)
        {
            $result = array("error_code"=>"403.3","error_desc"=>"Expired session.");
            echo json_encode($result);
            exit(0);            
        }
        
        $auth_value = sha256($uri . $sess["session_key"]);
        
        if ($session_key != $auth_value) 
        {
            $result = array("error_code"=>"403.4","error_desc"=>"Invalid SESSION KEY.");
            echo json_encode($result);
            exit(0);
        }
        
        
        if (array_key_exists("session_expire_expand", $_GET))
        {
            $exp_date = $_GET["session_expire_expand"];
            $es->extend($session_id, $exp_date);
        }
        
        return $sess["id_users"];
        

    }
        
     
?>
