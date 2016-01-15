<?
    class Samples extends Controller
    {
        var $assigns = array();
        var $assigns_layout = array();
        var $layout = "default";
        var $use_models = array();
        
        public function index()
        {
        }
        
        public function sync()
        {
            $a = new Tf_image('/media/test.jpg');
            $a->sync();
            exit(0);
        }
        
        public function upload()
        {
            
        }

        
        public function upload_process()
        {
            $f = new Tf_image("file_id", "/media/samples/");
            $f->sync();
            
            $this->assigns["file_info"] = $f;
        }
        
        public function load_controller()
        {
            // 내부 컨트롤러를 로딩하는 예제
            
            // 새 트레일 오브젝트의 생성
            $inner_trail = new Trail("/samples/load_controller_inner");
            
            // 작업 일괄 처리
            $inner_trail->work_through();
            
            // 오브젝트 assign
            $this->assigns["inner_trail"] = $inner_trail; 
            
            // 만일, 결과를 스트링으로 받는 경우. 다음과 같이 하면 됩니다.
            $this->assigns["inner_trail_rendered"] = $inner_trail->method_invoke(true);
        }
        
        public function load_controller_inner()
        {
            $this->layout = "";
            
        }
        
        public function test()
        {
            
            $_url = "http://222.231.13.38:8088/v3.0/account/login?userId=moriah&userPw=5ed2bc23d3cc1a20f80eaec2876fa458e456af76";
            //$_url = "http://222.231.13.38:8088/v3.0/account/login";

            $pw = "5ed2bc23d3cc1a20f80eaec2876fa458e456af76";
            
            $pw = base64_encode($pw);
            $post_data = array(
                'userId' => "moriah",
                'userPw' => $pw
                );
                
                
            $http_header = array("a_key:" . "8R8A+JIT1AMxzSZZw/irpuRZnN0=#Ng=="
                    , "app_id:" . "petloves"
                    , "app_agent:" . "Etc;Etc;N/A;petloves;1.0;Etc;LAN"
                    //, "app_agent:" . "App-Agent: Android;Android OS2.1.2;01035084597;petloves;3.0;SHW-M100S;WiFi"
                    , "Content-type:" . "application/x-www-form-urlencoded"
                    , "Accept:" . "text/plain");
            

            $ch = curl_init();
            curl_setopt($ch, CURLOPT_HTTPHEADER, $http_header);
            curl_setopt($ch, CURLOPT_URL, $_url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER,true);
            curl_setopt($ch, CURLOPT_HEADER, true);
            
            //curl_setopt($ch, CURLOPT_POST, 1);
            //curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
            
            
            ob_start();
            $res = curl_exec($ch);
            $errno = curl_errno($ch);
            curl_close($ch);
            $cont=ob_get_contents();ob_end_clean();
        
            print_r($res);
            print("---<br/>");
            print_r($cont);
            print("---<br/>");
            if(!$errno)
            {
                //$info = curl_getinfo($ch);
                //print_r($info);
                //$this->Tf_image_sync->delete($r['id']);
            
            }else{
                //print(curl_errno($ch));
                // 은(는) fail
                //$this->Tf_image_sync->add_error($r['id']);
                
            }
            //curl_close($ch);

                 
        }
    }      

?>