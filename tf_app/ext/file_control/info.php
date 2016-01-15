<?php
    
/*

    TF External Apps
    Name: file_control
    Author: Binseop Ko
    Description: 파일 컴포넌트
    
    Version: 2011-08-02
    VersionMin: 0.8.0
    VersionMax: -
    
    
    2010/08/02 첫 버전
    
    

    model script:
    CREATE TABLE `tf_image_sync` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `path` varchar(512) DEFAULT NULL,
      `org` varchar(64) DEFAULT NULL,
      `action` varchar(16) DEFAULT NULL,
      `error_cnt` int(11) DEFAULT '1',
      `date_created` datetime DEFAULT NULL,
      PRIMARY KEY (`id`),
      KEY `error_cnt` (`error_cnt`,`id`)
    ) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1

*/
    
    include_once("../tf_app/ext/file_control/controller.php");
    include_once("../tf_app/ext/file_control/model.php");

    $trail->add_ext_route("tf/file_control/sync", "*component*/file_control/sync");
    $trail->add_ext_route("tf/file_control/retry", "*component*/file_control/retry/100");
    $trail->add_ext_route("tf/file_control/retry/%retry_count", "*component*/file_control/retry/%retry_count");

    class Tf_image
    {
        var $this_server;
        var $file_full_path;
        var $file_web_path;
        var $file_id;
        var $file_name_safe;
        var $_error = '';
        
        public function Tf_image($_id_or_file, $_target_path = null, $_force_file_name = null)
        {// Tf_image('file1','/media/users/'), Tf_image('file1','/media/users/', '1.jpg') or Tf_image('/media/users/1.jpg')
            global $trail;
            
            if ($_target_path)
            {
                $this->file_id = $_id_or_file;
                $this->make_upload($_target_path, $_force_file_name);
            }
            else
            {
                $this->file_web_path = $_id_or_file;
            }
            
            $this->file_full_path = $trail->_root_dir . '/web' . $this->file_web_path;
            
        }
        
        public function sync()
        {
            $this->do_sync($this->file_web_path);
        }

        public function remove_and_sync($_path)
        {
            global $trail;
            unlink($trail->_root_dir . '/web' . $_path);
            $this->do_sync($_path, 'remove');
        }
                

        private function do_sync($_path, $_action = null)
        {
            global $trail;
            
            $servers = $trail->_settings->ext_file_control_server;

            $current = $servers['current'];
            
            if (!$current)
            {
                $server_addr = $_SERVER['SERVER_ADDR'];
                $server_port = $_SERVER['SERVER_PORT'];
                
                if ($server_port == 443)
                    $current = 'https://' . $server_addr . ':' . $server_port;
                else if ($server_port == 80)
                    $current = 'http://' . $server_addr;
                else
                    $current = 'http://' . $server_addr . ':' . $server_port;
            }
            
            
            
            foreach ($servers as $k=>$v)
            {
                if ($k != 'current' && $v != $current)
                {
                    $_url = $v . '/tf/file_control/sync/?org=' . $current . '&path=' . $_path;
                    if ($_action) $_url = $_url . '&action=' . $_action;
                    $ch = curl_init();
                    curl_setopt($ch, CURLOPT_URL, $_url);
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER,true);
                    curl_setopt($ch, CURLOPT_HEADER, true);
                    curl_exec($ch);
                
                    if(!curl_errno($ch))
                    {
                        // success
                        $info = curl_getinfo($ch);
                        //print($info);
                    
                    }else{
                        // fail
                        $tis = $trail->load_model("*Tf_image_sync");
                        $tis->add($_url);
                        
                    }
                    curl_close($ch);
                    
                    
                }
                
                    
            }
            
        }

        
        private function make_upload($_target_path, $_force_file_name)
        {
            global $trail;
            
        	$upload_file = "";
        	if (array_key_exists($this->file_id,$_FILES) && $_FILES[$this->file_id]["name"] != "")
        	{
        		$dir = $trail->_root_dir . '/web' . $_target_path;
        		$upload_file = $_FILES[$this->file_id]["tmp_name"];
        		if (strtolower(substr($ufn,strlen($ufn)-4)) == '.php')
        		{
        		    $this->_error = 'php';
        		    return;
        		}
        		$ufn = htmlentities(urlencode($_FILES[$this->file_id]["name"]));
        		$ufn = str_replace("%","",$ufn);
        		
        		if ($_force_file_name)
        		{
        		    $dest = $dir.$_force_file_name;
        		    $ufn = $_force_file_name;
        		}
        		else
        		{
            		$dest=$dir.$ufn;
            		$pfx = 0;
            		$ufn2 = $ufn;
            		while(file_exists($dest))
            		{
            			$pfx++;
            			$ufn = $pfx.$ufn2;
            			$dest=$dir.$ufn;
            		}
            	}
            	
        		move_uploaded_file($upload_file,$dest);
        		if (file_exists($dest))
        		{
        			$this->file_name_safe = $ufn;
        			$this->file_web_path = $_target_path . $ufn;
        		}
        
        		
        	}
        
        }
    }    

?>