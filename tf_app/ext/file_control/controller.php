<?
    class File_control extends Controller
    {
        var $assigns = array();
        var $assigns_layout = array();
        var $layout = "";
        var $use_models = array('*Tf_image_sync');
        var $use_components = array();
        var $ue_cnt = 0;
        
        
        public function sync()
        {
            global $trail;
            
            $servers = $trail->_settings->ext_file_control_server;

            $action = $_REQUEST["action"];
            $path = $_REQUEST["path"];
            $org = $_REQUEST["org"];
            //$hash = $_REQUEST["hash"];


    	    $approved = false;

    	        //print($_SERVER["REMOTE_ADDR"]);
    	        
    	            	    
    	    foreach ($servers as $k => $v)
    	    {
    	        if (strpos($v, $_SERVER["REMOTE_ADDR"])) $approved = true;
    	    }

    	    if (!$approved)
    	    {
    	        header("HTTP/1.0 403");
    	        exit(0);
    	    }
    	    
    	    
    	    if ($action == 'remove')
    	    {
    	        if (file_exists($trail->_root_dir . '/web' . $path))
    	        {
    	            unlink($trail->_root_dir . '/web' . $path);
    	        }
    	    
    	        exit(0);
    	    }
    	    else
    	    {
        		$file = file_get_contents($org . $path);
                if(gettype($file)=="array"){
        			echo 'ERROR : ';
        			//print_r($file);
        		}else{
        
        			//echo $file;
        
        			if($file){
                        $fp = @fopen($trail->_root_dir . '/web' . $path, 'w');
                        if ($fp)
                        {
                            fwrite($fp, $file);
                            fclose($fp);
                            exit(0);
                        }
    
    
        			}
        		}
        		
        		header("HTTP/1.0 500");
        		exit(0);
        	}


        }
        
        public function retry($count=100)
        {
            $c = new Query();
            $c->where('<', 'error_cnt', 10);
            $c->order = 'id asc';
            //$this->Tf_image_sync->debug();
            $ret = $this->Tf_image_sync->fetch("*", $c);
            
            foreach ($ret as $r)
            {
                $ch = curl_init();
                curl_setopt($ch, CURLOPT_URL, $r['url']);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER,true);
                curl_setopt($ch, CURLOPT_HEADER, true);
                curl_exec($ch);
            
                if(!curl_errno($ch))
                {
                    $info = curl_getinfo($ch);
                    $this->Tf_image_sync->delete($r['id']);
                
                }else{
                    // Àº(´Â) fail
                    $this->Tf_image_sync->add_error($r['id']);
                    
                }
                curl_close($ch);
                
            }
            exit(0);
        }
        
    }
    
?>