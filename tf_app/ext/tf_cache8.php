<?php

/*

    TF External Apps
    Name: tf_cache8
    Author: Binseop Ko
    Description: 멤캐시(memcache) 사용 유틸리티 v0.8 용
    
    Version: 2010-06-20
    VersionMin: 0.8.0
    VersionMax: -
    

*/
        

    class Cache
    {
        var $memcache = array();
        var $cache_settings;
        var $availiable = array();
        
        function Cache($settings)
        {
            $this->cache_settings = $settings->cache_server;
        }
        
        function connect($_server_name = "DEFAULT")
        {
            $_cache_setting = $this->cache_settings[$_server_name];

            ob_start();
            $this->memcache[$_server_name] = new Memcache;
            $this->memcache[$_server_name]->connect($_cache_setting["IP"],$_cache_setting["PORT"]);
            $this->availiable[$_server_name] = 1;
            $c = ob_get_contents();ob_end_clean();
            
            if ($c)
            {
                $this->availiable[$_server_name] = 0;
            }
        }
        
        function get($_key, $_server_name = "DEFAULT")
        {
            if (array_key_exists($_server_name, $this->availiable))
            {
                if ($this->availiable[$_server_name])
                {
                    return $this->memcache[$_server_name]->get($_key);
                }
                else
                {
                    return false;
                }
                
            }
            else
            {
                $this->connect($_server_name);
                return $this->get($_key, $_server_name);
            }
        }
        
        function set($_key, $_value, $_exp, $_server_name = "DEFAULT")
        {
            if ($_server_name == "ALL")
            {
                foreach ($this->cache_settings as $cache_setting=>$value)
                {
                    if ($cache_setting != "TIMEOUT")
                        $this->set($_key, $_value, $_exp, $cache_setting);
                }
            }
            else
            {
                if (array_key_exists($_server_name, $this->availiable))
                {
                    if ($this->availiable[$_server_name])
                    {
                        return $this->memcache[$_server_name]->set($_key, $_value, 0, $_exp);
                    }
                    else
                    {
                        return false;
                    }
                    
                }
                else
                {
                    $this->connect($_server_name);
                    return $this->set($_key, $_value, $_exp, $_server_name);
                }
            }
            
        }

        function delete($_key, $_server_name = "DEFAULT")
        {
            if ($_server_name == "ALL")
            {
                if ($this->cache_settings)
                foreach ($this->cache_settings as $cache_setting=>$value)
                {
                    if ($cache_setting != "TIMEOUT")
                        $this->delete($_key, $cache_setting);
                }
            }
            else
            {
                if (array_key_exists($_server_name, $this->availiable))
                {
                    if ($this->availiable[$_server_name])
                    {
                        return $this->memcache[$_server_name]->delete($_key);
                    }
                    else
                    {
                        return false;
                    }
                    
                }
                else
                {
                    $this->connect($_server_name);
                    return $this->delete($_key, $_server_name);
                }
            }
        }
        

    }
    
    $trail->cache = new Cache($trail->_settings);
    
    
    function ready_models($trail)
    {
        
        $trail->_current_controller->cache = $trail->cache;
        foreach ($trail->_current_controller->use_models as $use_model)
        {
            $trail->_current_controller->$use_model->cache = $trail->_current_controller->cache;
    
        }
    }

    function init_global($trail)
    {   
        if( $_SESSION["s"] ){ 
            return; 
        }

        //자동 로그인
        $next = $_REQUEST['next'];
        $id_save = $_COOKIE['dcamp_id_save'];
        if(! $_SESSION["s"] && $id_save){

            $users = load_model("Members");
            $users_info = $users->get($id_save);

            if($users_info && $users_info['auto_login'] == 1 ){
                $akey = $_COOKIE['dcamp_akey'];
                //$current_time = date('Y-m-d H:i:s',time());
                $users_auto = load_model("Member_auto");
                //자동 설정 되어 있고 세션에 키가 있으면
                $users_auto_info = $users_auto->get_by_id_user_akey($id_save,$akey);
                if( $users_auto_info ){

                    $_SESSION["s"] = $users_info;
                    if (!$_SESSION["s"]["picture"]) $_SESSION["s"]["picture"] = '/img/default-img-member.png';
                    $act = load_model("Activity");
                    $_SESSION["s"]["acnt"] = $act->get_a_cnt(1, $_SESSION["s"]["id"], '0');
                    $m_ext = load_model("Member_ext");
                    $_SESSION["s"]["fb"] = $m_ext->get_by_user_id_type($_SESSION["s"]["id"], 1);
                    $_SESSION["s"]["tw"] = $m_ext->get_by_user_id_type($_SESSION["s"]["id"], 2);

                    $cc = load_model("Content_category");
                    $con = $cc->get_cat_by_user($_SESSION["s"]["id"], 'cc.hidden = 0');
                    if (sizeof($con) > 0) {
                        $_SESSION["s"]["con"] = $con;
                    }
                    $om = load_model("Office_mento");
                    $mt = $om->cnt("user_id = ".$_SESSION["s"]["id"]);
                    if ($mt > 0) {
                        $_SESSION["s"]["mento"] = true;
                    }

                    setcookie("dcamp_id_save", $users_info['id'],time()+ 1209600,"/");
                    setcookie("dcamp_akey", $users_auto_info['akey'] ,time()+ 1209600,"/");
                }
            }
        }   
        
    }

    $trail->add_event_list("before_calling", "init_global", init_global);
    $trail->add_event_list("before_calling", "cache_register", ready_models);
    
?>