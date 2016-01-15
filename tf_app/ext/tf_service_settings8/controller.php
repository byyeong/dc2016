<?
    class Tf_service_settings8 extends Controller
    {
        var $assigns = array();
        var $assigns_layout = array();
        var $layout = "default";
        var $use_models = array();
        


        function admin()
        {
            global $settings, $service_settings, $service_settings_pw;
            
            if (!$_SESSION["tf_service_settings_login"] && $service_settings_pw)
                header ("Location: /tf_service_settings/login/");
            
            if (array_key_exists("jobtype", $_REQUEST) && $_REQUEST["jobtype"] == "modify")
            {
                $ss2 = array();
                
                foreach ($service_settings as $svs)
                {
                    $k = $svs["key"];
                    $v = $svs["value"];
                    $d = $svs["description"];
                    
                    $v = $_REQUEST["key_" . $k];
                    
                    if (!$_REQUEST["todel_" . $k])
                    {
                        $new_svs = array();
                        $new_svs["key"] = $k;
                        $new_svs["value"] = $v;
                        $new_svs["description"] = $d;
                        
                        $ss2[] = $new_svs;
                        
                    }
                    
                    
                }
                $service_settings = $ss2;
                
            if ($ss2)
                ss_save($ss2, $service_settings_pw);
            }
            
            if (array_key_exists("new_key", $_REQUEST))
            {
                $ss2 = array();
                
                $ss2["key"] = $_REQUEST["new_key"];
                $ss2["value"] = $_REQUEST["new_value"];
                $ss2["description"] = $_REQUEST["new_desc"];
                
                $service_settings[] = $ss2;
                ss_save($service_settings, $service_settings_pw);
            }
            
            if (array_key_exists("pw", $_REQUEST))
            {
                ss_save($service_settings, $_REQUEST["pw"]);
            }
            
            
            
            $this->assigns["service_settings"] = $service_settings;
            //if ($ss2)
            //  $this->assigns["service_settings"] = $ss2;
            
            
            $this->tpl_name = "tf_service_settings8/views/admin";
            $this->layout = "";

			
        }
        
        function login()
        {
            global $service_settings_pw;
            $this->layout = "";
            $this->tpl_name = "tf_service_settings8/views/login";
            if ($_REQUEST["pw"] == $service_settings_pw)
            {
                $_SESSION["tf_service_settings_login"] = true;
                header ("Location: /tf_service_settings/admin/");
            }
            
        }

        function logout()
        {
            $_SESSION["tf_service_settings_login"] = null;
            header ("Location: /");
        }
        
    }

    function ss_save($ss, $pw)
    {
        $pw = str_replace("\"","\\\"",$pw);
        
        $file = fopen ("../tf_app/ext/tf_service_settings8/settings.php", "w");
        fputs($file, "<?php\n");
        fputs($file, "    // This is auto-generated file. DO NOT edit this!\n");
        fputs($file, "    \$service_settings = array(\n");
        foreach ($ss as $svs)
        {
            $k = str_replace("\"","\\\"",$svs["key"]);
            $v = str_replace("\"","\\\"",$svs["value"]);
            $d = str_replace("\"","\\\"",$svs["description"]);
            fputs($file, "        array(\"key\"=>\"$k\", \"value\"=>\"$v\", \"description\"=>\"$d\"),\n");
        }
        
        fputs($file, "            );\n");
        fputs($file, "    \$service_settings_pw=\"$pw\";\n");
        fputs($file, "?>");
        fclose($file);
    }
    
    
?>