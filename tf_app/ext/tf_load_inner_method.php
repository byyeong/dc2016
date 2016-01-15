<?
    function load_inner_method($url)
    {
        global $settings;
        // parse url
        if (substr($url,strlen($url)-1,1) == '/')
            $url = substr($url,0,strlen($url)-1);
            // 가장 뒤에 있는 슬래시는 무시
    
        $argv = explode('/', $url);
    
        $pass_auto_route = false;
        
        if ($settings->use_routing)
        {
            
            
            foreach ($settings->route as $key => $value)
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
            if ($url == '')
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
        if (file_exists('../tf_app/'.$class_filename.'.php'))
        {// 콘트롤러 파일 존재
            include_once ('../tf_app/'.$class_filename.'.php');
            
            // 콘트롤러 인스턴스 생성
            $current_controller = new $argv[0]($settings);
            
            // 클래스 이름 할당
            $current_controller->_class_name = $argv[0];
            
            // arguments 초기화
            $args = array();
            
            if (!method_exists($current_controller, $argv[1]))
            {// 메써드 가 없을 경우 index 로 가정하고 arg를 한칸씩 밀어둔다.
                $tried = $argv[1];
                $argv = array_merge(array($argv[0], 'index'), array_slice($argv, 1, sizeof($argv)));
            }
            
            if (!method_exists($current_controller, $argv[1]))
            {// 메써드 미존재, 에러
                if (!$tried) $tried = $argv[1];
                if ($settings->page_404 != '')
                    header('Location: '.$settings->page_404.'?url='.$url);
                else
                    echo ('404 Error: The method \''.$tried.'\' could not be found.<br/><a href=\'/\'>HOME</a>');
                exit(0);
            }
            
        }
        else
        {// 클래스 미존재, 에러
            // 혹시 root?
            
            include_once ('../tf_app/controllers/root.php');
            
            // 콘트롤러 인스턴스 생성
            $current_controller = new Root($settings);
            
            // 클래스 이름 할당
            $current_controller->_class_name = 'Root';
            
            // arguments 초기화
            $args = array();
            
            if (method_exists($current_controller, $argv[0]))
            {// 메써드 가 있을 경우
                $argv = array_merge(array('root', $argv[0]), array_slice($argv, 1, sizeof($argv)));
                
            }
            else
            {// 메써드가 없을경우
                if ($settings->page_404 != '')
                    header('Location: '.$settings->page_404.'?url='.$url);
                else
                {
                    echo ('404 Error: The class \''.$argv[0].'\' could not be found.<br/><a href=\'/\'>HOME</a>');
                    exit(0);
                }
    
            }
        }   
        
        // default tpl 및 arguments 할당
        $current_controller->tpl_name = $argv[1];
        $args = array_slice($argv, 2, sizeof($argv));
        
        ob_start();
        
        // new @ 0.7.1
        for ($i=sizeof($settings->before_calling_ext)-1;$i>=0;$i--)
            call_user_func($settings->before_calling_ext[$i], $settings, $current_controller);
    
        // invoke
        $current_controller->before_calling();
    
    
        // 0.5 버전과의 호환성을 유지하기 위해 다음 두 가지의 문장을 선택적으로 커멘트 아웃 합니다
        // 아래 코드는 0.6 전용의 코드입니다. 0.5와의 하위 호환성 유지를 위해서는 커멘트 시킵니다.
        call_user_func_array(array($current_controller, $argv[1]), $args);
        // 아래 커멘트 된 코드는 0.5 전용의 코드입니다.
        // 0.5와의 하위 호환성 유지를 위해 커멘트를 제거합니다.
        // call_user_func_array(array($current_controller, $argv[1]), $argv);
    
        $current_controller->before_render();
        
        for ($i=sizeof($settings->before_render_calls)-1;$i>=0;$i--)
            call_user_func($settings->before_render_calls[$i], $settings, $current_controller);
        
        $current_controller->render();
        
        for ($i=sizeof($settings->last_calls)-1;$i>=0;$i--)
            call_user_func($settings->last_calls[$i], $settings, $current_controller);
        
        $ob = ob_get_contents();ob_end_clean();
        
        return $ob;
    }
?>
