<?
    
    include_once("../tf_app/ext/captcha/settings.php");
    class captcha extends Controller
    {

        var $assigns = array();
        var $assigns_layout = array();
        var $layout = "";
        var $use_models = array();

        function captcha()
        {
            global $captcha_seed, $captcha_session_key;
        
            // 캡챠 글자 생성
        	        
        	//$captcha_str = substr( str_shuffle($captcha_seed), 0, 5 );
        	//$captcha_str = "한글입니다";
        	//$captcha_str = iconv("EUC-KR", "UTF-8",$captcha_str) ;
        
            $captcha_str = $captcha_seed[rand(0,sizeof($captcha_seed)-1)];
            $_SESSION[$captcha_session_key] = $captcha_str;
            
            // background
            $NewImage =imagecreatefromjpeg("../tf_app/ext/captcha/captcha_back.jpg");
            
            // settings
            $c1 = rand(150,255);
            $c2 = rand(150,255);
            $c3 = rand(150,255);
            $LineColor = imagecolorallocate($NewImage,$c1,$c2,$c3);
            
            
            
            // 라인
            $a = $radius = rand(20,60);
            $b = $radius = rand(20,60);
            $c = $radius = rand(80,130);
            $d = $radius = rand(110,200);
            imageline($NewImage,1,1,$a,$b,$LineColor);
        
            $c1 = rand(150,255);
            $c2 = rand(150,255);
            $c3 = rand(150,255);
            $LineColor = imagecolorallocate($NewImage,$c1,$c2,$c3);
            imageline($NewImage,1,$c,60,0,$LineColor);
        
            $c1 = rand(150,255);
            $c2 = rand(150,255);
            $c3 = rand(150,255);
            $LineColor = imagecolorallocate($NewImage,$c1,$c2,$c3);
            imageline($NewImage,$c,1,$d,30,$LineColor);
        
            $c1 = rand(150,255);
            $c2 = rand(150,255);
            $c3 = rand(150,255);
            $LineColor = imagecolorallocate($NewImage,$c1,$c2,$c3);
            imageline($NewImage,$c,30,$d,1,$LineColor);
            
            // 스트링 그리기
            //imagettftext($NewImage, 12,$radius,5+$i*5,20, $TextColor, 'MALGUN.TTF', mb_substr($captcha_str,0,1,'utf-8'));
            for ($i=0;$i<strlen($captcha_str);$i++)
            {
                $radius = rand(-20,20);
                $size = rand(13,17);
                $spacing = rand(-2,2);
                $top = rand(16,21);
        
                $c1 = rand(150,255);
                $c2 = rand(150,255);
                $c3 = rand(150,255);
                $TextColor = imagecolorallocate($NewImage, $c1, $c2, $c3);
        
                imagettftext($NewImage, $size,$radius,5+$i*20+$spacing,$top, $TextColor, '../tf_app/ext/captcha/MALGUN.TTF', mb_substr($captcha_str,$i,1,'utf-8'));
            }
            
            // printout
            header("Content-type: image/jpeg");
            imagejpeg($NewImage);//Output image to browser 
        }
    }
?>