<?php

    /*
        TF CORE
        Name: object_trail
        Author: Binseop Ko
        Description: Trail Class
        
        Version: 0.8.0
        Last modified: 2011-06-14

        Contact: binseop@gmail.com
        
    */


    class Trail
    {
        const BEFORE_CALLING = "before_calling";
        const BEFORE_RENDER = "before_render";
        const AFTER_RENDER = "after_render";
        
        var $_model_pool    = array();
        var $_arguments     = null;
        var $_arguments_all = null;
        
        var $_url;
        var $_settings;
        var $_current_controller;
        
        var $_use_component;

        var $before_render  = array();
        var $after_render   = array();
        var $after_routing  = array();
        var $_root_dir       = "";

        
        function Trail($url)
        {
            if (substr($url,0,1) == '/') $url = substr($url,1);
            
            chdir("..");
            $this->_root_dir = getcwd();
            chdir("web");
            
            
            $this->_url = $url;
            $this->_server_url = "http://" . $_SERVER["HTTP_HOST"] . "/";

            // load settings
            include_once('../tf_app/settings/settings.php');

            if (file_exists('../tf_app/settings/settings_local.php'))
            { //local settings 여부 확인 및 로딩
                include_once('../tf_app/settings/settings_local.php');
                $this->_settings = new Settings_local();
            }
            else
            {
                $this->_settings = new Settings();
            }
            
        }
        
        function work_through()
        {
            $this->load_global_components();
            $this->set_route();
            $this->load_components();
            $this->load_models();
        }
        
        function set_route()
        {
            $ret = set_route($this);
            if ($ret == 404) $this->_throw(404);
            
        }
        
        function _throw($_code)
        {
            if ($_code == 404)
            {
                $handler = $this->_settings->page_404;
                header("HTTP/1.0 404 Not Found");
                
                if (!$handler)
                {
                    print("404 Not Found.");
                }
                else if (is_callable($handler))
                {
                    $handler($this->_url);
                }
                else
                {
                    header("location: " . $handler);
                }
                exit(0);
            }
        }
        
        function load_global_components()
        {
            $trail = $this;
            $settings = $this->_settings;
            foreach ($this->_settings->bootstrap_apps as $component_name)
            {
                include_once('../tf_app/ext/' . $component_name . '.php');
            }
        }

        function load_components()
        {
            $settings = $this->_settings;
            if (!$this->_use_component)
            {
                if ($this->_current_controller->use_components) foreach ($this->_current_controller->use_components as $component_name)
                {
                    include_once('../tf_app/ext/' . $component_name . '.php');
                    
                }
                
            }
        }
        
        function load_model($model_name)
        {
            $model_classname = $model_name . '_model';
    
            if (substr($model_name,0,1) == "*")
            {
                load_ext_model(substr($model_name,1));
                $model_name = substr($model_name,1);
            }
            else
            {
                if (file_exists('../tf_app/models/' . $model_name . '.php'))
                {
                    include_once ('../tf_app/models/' . $model_name . '.php');
                    $this->_current_controller->$model_name = new $model_classname($this->_settings);
                }
                else
                {//since 0.8.0
                    $this->_current_controller->$model_name = new model($this->_settings);
                    $this->_current_controller->$model_name->tablename = strtolower($model_name);
                    
                }
                
                
            }
            
            // model pool에 추가
            $this->_model_pool[$model_name] = $this->_current_controller->$model_name;
            
            return $this->_current_controller->$model_name;
            
        }
        
        function load_models()
        {
            $settings = $this->_settings;
            foreach ($this->_current_controller->use_models as $model_name)
            {
                $model_classname = $model_name . '_model';
        
                if (substr($model_name,0,1) == "*")
                {
                    load_ext_model(substr($model_name,1));
                }
                else
                {
                    if (file_exists('../tf_app/models/' . $model_name . '.php'))
                    {
                        include_once ('../tf_app/models/' . $model_name . '.php');
                        $this->_current_controller->$model_name = new $model_classname($this->_settings);
                    }
                    else
                    {//since 0.8.0
                        $this->_current_controller->$model_name = new model($this->_settings);
                        $this->_current_controller->$model_name->tablename = strtolower($model_name);
                        
                    }
                    
                    
                }
                
                // model pool에 추가
                $this->_model_pool[$model_name] = $this->_current_controller->$model_name;
            }            
        }
        
        function add_event_list($_type, $_name, $_method)
        {
            if ($_type == Trail::BEFORE_CALLING)
            {
                $this->after_routing[$_name] = $_method;
            }
            else if ($_type == Trail::BEFORE_RENDER)
            {
                $this->before_render[$_name] = $_method;
            }
            else if ($_type == Trail::AFTER_RENDER)
            {
                $this->after_render[$_name] = $_method;
            }
        }
        
        function remove_event_list($_type, $_name)
        {
            if ($_type == Trail::AFTER_ROUTING)
            {
                unset($this->after_routing[$_name]);
            }
            else if ($_type == Trail::BEFORE_RENDER)
            {
                unset($this->before_render[$_name]);
            }
            else if ($_type == Trail::AFTER_RENDER)
            {
                unset($this->after_render[$_name]);
            }            
        }
                
        function add_ext_route($_org, $_target)
        {
            if (!$this->_settings->route)
            {
                $this->_settings->route = array();
            }
            
            $this->_settings->use_routing = true;
            
            $k = array($_org=>$_target);
            $this->_settings->route = array_merge($k, $this->_settings->route);
        }
        
        function method_invoke($_to_string = false)
        {

            // default tpl 및 arguments 할당
            $this->_current_controller->tpl_name = $this->_arguments_all[1];
            $this->_arguments = array_slice($this->_arguments_all, 2, sizeof($this->_arguments_all));
            
            // ext before calling
            foreach($this->after_routing as $m)
                call_user_func($m, $this);
        
            // controller class 공통 method
            $this->_current_controller->before_calling();
        
            // invoke
            call_user_func_array(array($this->_current_controller, $this->_arguments_all[1]), $this->_arguments);
        
            // controller class 공통 method
            $this->_current_controller->before_render();
            
            // ext before_render
            foreach($this->before_render as $m)
                call_user_func($m, $this);
            
            if ($_to_string)
                $ret = $this->_current_controller->render_to_string();
            else
                $this->_current_controller->render();
            
            // ext after_render
            foreach($this->after_render as $m)
                call_user_func($m, $this);
        
            if ($_to_string) return $ret;
        }
    }
    
?>