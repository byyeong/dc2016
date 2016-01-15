<?php
    /*
        TF CORE
        Name: controller
        Author: Binseop Ko
        Description: 프레임웍 콘트롤러.
        
        Version: 0.8.0
        Last modified: 2011-06-14
        
        Version history _____________
        Jun. 14, 2011 (0.8.0)
        Jul. 15, 2010 (0.7.0)
        Apr.  6, 2010 (0.6.1)
        Jan. 13, 2010 (0.6)
        Apr.  7, 2009 (0.5)
        
        Contact: binseop@gmail.com
    
    */


    class Controller
    {
        var $use_models = array();
        var $defines = array();
        var $defines_layout = array();
        
        public function Controller($setting)
        {
            $this->settings = $setting;
        }

        
        public function before_render()        
        {
        }

        public function before_calling()
        {
        }
        
        public function include_tpl($_identifier, $_tpl_name, $position="body")
        {
            if (substr($_tpl_name,0,2) == "//")
                $_tname = "views" . substr($_tpl_name,1).'.tpl';
            else if ($this->_trail->_use_component)
                $_tname = "ext/" . $_tpl_name . '.tpl';
            else if (substr($_tpl_name,0,1) == "/")
                $_tname = "views" . $_tpl_name .'.tpl';
            else
                $_tname = "views/" . $this->_class_name.'/'.$_tpl_name.'.tpl';
            
            if ($position="layout")
                $this->defines[$_identifier] = $_tpl_name;
            else
                $this->defines_layout[$_identifier] = $_tpl_name;
            
        }

        public function render()
        {
            
            include_once '../tf_app/template_/Template_.class.php';
            if ($this->tpl_name)
            {
                $tpl = new Template_;
                if (substr($this->tpl_name,0,2) == "//")
                    $tpl_location = "views" . substr($this->tpl_name,1);
                else if ($this->_trail->_use_component)
                    $tpl_location = "ext/" . $this->tpl_name;
                else if (substr($this->tpl_name,0,1) == "/")
                    $tpl_location = "views" . $this->tpl_name;
                else
                    $tpl_location = "views/" . $this->_class_name.'/'.$this->tpl_name;

                $tpl->define('body', $tpl_location . ".tpl");
                
                $this->assigns["settings"] = $this->settings;
                $this->assigns["tpl_name"] = $this->tpl_name;
                
                $tpl->assign($this->assigns);
                $tpl->define($this->defines);
                
            }

            if ($this->layout)
            {
                $layout = new Template_;

                if (substr($this->layout,0,2) == "//")
                    $tpl_location = "views" . substr($this->layout,1);
                else if ($this->_trail->_use_component)
                    $tpl_location = "ext/" . $this->layout;
                else if (substr($this->layout,0,1) == "/")
                    $tpl_location = "views" . $this->layout;
                else
                    $tpl_location = 'views/layouts/'.$this->layout;

                $layout->define('layout', $tpl_location . '.tpl');
                
                $this->assigns_layout["contents_for_layout"] = $tpl->fetch('body');
                
                $this->assigns_layout["settings"] = $this->settings;
                $layout->assign($this->assigns_layout);
                $layout->define($this->defines_layout);
                $layout->print_('layout');
            }
            else if ($this->tpl_name)
            {
                $tpl->print_('body');
            }
            
            
            
        }

        public function render_to_string()
        {
            ob_start();
            $this->render();
            $ret=ob_get_contents();ob_end_clean();
            
            return $ret;
            
        }
        
    }


?>