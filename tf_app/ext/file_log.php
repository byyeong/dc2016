<?php
    Class File_log
    {
    	
    	const ALARM_ERROR_DIR = '/var/log/apache2/all_debug.log';
    	const FEEDS_ERROR_DIR = '/var/log/apache2/all_debug.log';
    	const FRIENDS_ERROR_DIR = '/var/log/apache2/all_debug.log';
    	const PETS_COMMENTS_DIR = '/var/log/apache2/all_debug.log';
    	const PETS_LIKES_DIR = '/var/log/apache2/all_debug.log';
    	const UPDATES_LIKES_DIR = '/var/log/apache2/all_debug.log';
    	const UPDATES_COMMENTS_DIR = '/var/log/apache2/all_debug.log';
    	const USERS_EXT_DIR = '/var/log/apache2/all_debug.log';
    	
    	
    	/*
    	const ALARM_ERROR_DIR = 'C:\APM_Setup\Server\Apache\logs\all_debug.log';
        const FEEDS_ERROR_DIR = 'C:\APM_Setup\Server\Apache\logs\all_debug.log';
        const FRIENDS_ERROR_DIR = 'C:\APM_Setup\Server\Apache\logs\all_debug.log';
        const PETS_COMMENTS_DIR = 'C:\APM_Setup\Server\Apache\logs\all_debug.log';
        const PETS_LIKES_DIR = 'C:\APM_Setup\Server\Apache\logs\all_debug.log';
        const UPDATES_LIKES_DIR = 'C:\APM_Setup\Server\Apache\logs\all_debug.log';
        const UPDATES_COMMENTS_DIR = 'C:\APM_Setup\Server\Apache\logs\all_debug.log';
        const USERS_EXT_DIR = 'C:\APM_Setup\Server\Apache\logs\all_debug.log';
        
        */
        
        const FILE_LOG_TYPE = 3;
    	
    	private $gubun_str = '[MOBILE]';
    	private $f_name = '';
    	private $global_id = '';
    	private $ip = '';
    	
    	
    	private $is_debug = false;
    	
    	public function File_log($_session,$_f_name,$_gubun_str = 'MOBILE')
    	{
    	   $this->f_name = '['.$_f_name.']';
    	   $this->gubun_str = '['.$_gubun_str.']';
           $this->global_id = serialize($_session);
    	    if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
		        //check ip from share internet
		        $ip=$_SERVER['HTTP_CLIENT_IP'];
		    } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
		        //to check ip is pass from proxy
		        $ip=$_SERVER['HTTP_X_FORWARDED_FOR'];
		    } else {
		        $ip=$_SERVER['REMOTE_ADDR'];
		    }
		    $this->ip = '['.$ip.']';
    	}
    	
    	//알람 에러
    	public function alarm($msg)
    	{
    		if(!$this->debug)
    		{
                return;    			
    		}
    		$date = date('Y-m-d H:i:s'); 
            $log = $this->ip.$this->gubun_str.$this->f_name.$msg."   |  Date:  ".$date."  | Session_id: ".$this->global_id." | ALARM |\n"; 
            error_log($log, self::FILE_LOG_TYPE, self::ALARM_ERROR_DIR); 
    	}
    	
    	//피드 에러
    	public function feeds($msg)
    	{
    		          if(!$this->is_debug)
            {
                return;             
            }
    		
            $date = date('Y-m-d H:i:s'); 
            $log = $this->ip.$this->gubun_str.$this->f_name.$msg."   |  Date:  ".$date."  | Session_id: ".$this->global_id." | FEEDS |\n"; 
            error_log($log, self::FILE_LOG_TYPE, self::FEEDS_ERROR_DIR); 
    		
    	}
    	
    	//친구 에러
    	public function friends($msg)
    	{
    		          if(!$this->is_debug)
            {
                return;             
            }
    		
            $date = date('Y-m-d H:i:s'); 
            $log = $this->ip.$this->gubun_str.$this->f_name.$msg."   |  Date:  ".$date."  | Session_id: ".$this->global_id." | FRIENDS |\n"; 
            error_log($log, self::FILE_LOG_TYPE, self::FRIENDS_ERROR_DIR); 
    		
    	}
    	
    	//팻 댓글
        public function pets_comments($msg)
        {
        	           if(!$this->is_debug)
            {
                return;             
            }
        	
            $date = date('Y-m-d H:i:s'); 
            $log = $this->ip.$this->gubun_str.$this->f_name.$msg."   |  Date:  ".$date."  | Session_id: ".$this->global_id." | PETS_COMMENTS |\n"; 
            error_log($log, self::FILE_LOG_TYPE, self::PETS_COMMENTS_DIR); 
        	
        }
        
        //팻 예뻐요
        public function pets_likes($msg)
        {
        	           if(!$this->is_debug)
            {
                return;             
            }
        	
            $date = date('Y-m-d H:i:s'); 
            $log = $this->ip.$this->gubun_str.$this->f_name.$msg."   |  Date:  ".$date."  | Session_id: ".$this->global_id." | PETS_LIKES |\n"; 
            error_log($log, self::FILE_LOG_TYPE, self::PETS_LIKES_DIR); 
        	
        }
        
        //글 좋아요
        public function updates_likes($msg)
        {
        	           if(!$this->is_debug)
            {
                return;             
            }
        	
        	$date = date('Y-m-d H:i:s'); 
            $log = $this->ip.$this->gubun_str.$this->f_name.$msg."   |  Date:  ".$date."  | Session_id: ".$this->global_id." | UPDATES_LIKES |\n"; 
            error_log($log, self::FILE_LOG_TYPE, self::UPDATES_LIKES_DIR); 
        	
        }
        
        //글 댓글
        public function updates_comments($msg)
        {
        	           if(!$this->is_debug)
            {
                return;             
            }
        	
            $date = date('Y-m-d H:i:s'); 
            $log = $this->ip.$this->gubun_str.$this->f_name.$msg."   |  Date:  ".$date."  | Session_id: ".$this->global_id." | UPDATES_COMMENTS |\n"; 
            error_log($log, self::FILE_LOG_TYPE, self::UPDATES_COMMENTS_DIR); 
            
        }
        
    
    }

?>