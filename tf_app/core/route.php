<?php

    /*
        TF CORE
        Name: route
        Author: Binseop Ko
        Description: 프레임웍 URL 라우팅.
        
        Version: 0.8.0
        Last modified: 2011-06-14
        
        Version history _____________
        Jun. 14, 2011 (0.8.0)
        Jul. 15, 2010 (0.7.0)
        Feb.  6, 2010 (0.6.1)
        
        Contact: binseop@gmail.com
    
    */
    

    function set_route($trail)
    {
        // parse url
        $trail->_url_inputted = $trail->_url;
        if (substr($trail->_url,strlen($trail->_url)-1,1) == '/')
            $trail->_url = substr($trail->_url,0,strlen($trail->_url)-1);
            // 가장 뒤에 있는 슬래시는 무시
    
        $argv = explode('/', $trail->_url);
        
        $pass_auto_route = false;
        
        if ($trail->_settings->use_routing)
        {
            
            foreach ($trail->_settings->route as $key => $value)
            {
                $org = explode('/', $key);
                $tgt = explode('/', $value);
                if (sizeof($org) != sizeof($argv)) continue;
                $found = true;
                for ($i=0; $i<sizeof($org); $i++)
                {
                    if (substr($org[$i],0,1) != "%" && $org[$i] != $argv[$i])
                    {
                        $found = false;
                        break;
                    }
                    
                }
                
                if ($found)
                {
                    $vars = array();
                    for ($i=0; $i<sizeof($org); $i++)
                    {
                        if (substr($org[$i],0,1) == "%")
                        {
                            $vars[$org[$i]] = $argv[$i];
                        }
                    }
        
                    for ($i=0; $i<sizeof($tgt); $i++)
                    {
                        if (substr($tgt[$i],0,1) == "%")
                        {
                            $tgt[$i] = $vars[$tgt[$i]];
                        }
                    }
                    
                    
                    $argv = $tgt;
                    
                    if ($argv[0] == "*component*")
                    {
                        $use_component = true;
                        $argv = array_slice($argv, 1, sizeof($argv));
                    }
                    
                    $pass_auto_route = true;
                    break;
                }
                
            }
        }
        
        if (!$pass_auto_route)
        {
            if ($trail->_url == '')
            {   // url이 전혀 지정되지 않았을 경우
                $argv = array('root', 'index');
            }
            else
            {   // url이 하나만 지정되었을 경우 - method 는 index
                if (sizeof($argv) == 1)
                    $argv[] = 'index';
                
            }
        }
        
        // 콘트롤러 로딩
        $class_filename = "controllers/" . $argv[0];
        if ($use_component)
            $class_filename = "ext/" . $argv[0] . "/controller";
            
        if (file_exists('../tf_app/'.$class_filename.'.php') || $use_component)
        {// 콘트롤러 파일 존재
            if (file_exists('../tf_app/'.$class_filename.'.php'))
                include_once ('../tf_app/'.$class_filename.'.php');
            
            // 콘트롤러 인스턴스 생성
            $trail->_current_controller = new $argv[0]($trail->_settings);
            
            // 클래스 이름 할당
            $trail->_current_controller->_class_name = $argv[0];
            
            // arguments 초기화
            $args = array();
            
            if (!method_exists($trail->_current_controller, $argv[1]))
            {// 메써드 가 없을 경우 index 로 가정하고 arg를 한칸씩 밀어둔다.
                $tried = $argv[1];
                $argv = array_merge(array($argv[0], 'index'), array_slice($argv, 1, sizeof($argv)));
            }
            
            if (!method_exists($trail->_current_controller, $argv[1]))
            {// 메써드 미존재, 에러
                return 404;
                /*
                if (!$tried) $tried = $argv[1];
                if ($trail->_settings->page_404 != '')
                    header('Location: '.$trail->_settings->page_404.'?url='.$trail->_url);
                else
                    echo ('404 Error: The method \''.$tried.'\' could not be found.<br/><a href=\'/\'>HOME</a>');
                exit(0);
                */
            }
            
        }
        else
        {// 클래스 미존재, 에러
            // 혹시 root?
            
            include_once ('../tf_app/controllers/root.php');
            
            // 콘트롤러 인스턴스 생성
            $trail->_current_controller = new Root($trail->_settings);
            
            // 클래스 이름 할당
            $trail->_current_controller->_class_name = 'Root';
            
            // arguments 초기화
            $args = array();
            
            if (method_exists($trail->_current_controller, $argv[0]))
            {// 메써드 가 있을 경우
                $argv = array_merge(array('root', $argv[0]), array_slice($argv, 1, sizeof($argv)));
                
            }
            else
            {// 메써드가 없을경우
                
                return 404;
                /*
                if ($trail->_settings->page_404 != '')
                    header('Location: '.$trail->_settings->page_404.'?url='.$trail->_url);
                else
                {
                    echo ('404 Error: The class \''.$argv[0].'\' could not be found.<br/><a href=\'/\'>HOME</a>');
                    exit(0);
                }
                */
    
            }
        }

        $trail->_arguments_all = $argv;
        $trail->_use_component = $use_component;
        $trail->_current_controller->_trail = $trail;
    }
         
?>