<?php

/*

    TF External Apps
    Name: SNS Utils
    Author: byyeong


*/

    include_once("../tf_app/ext/tf_sns_utils/controller.php");
    include_once("../tf_app/ext/tf_sns_utils/settings.php");

    $trail->add_ext_route("tf_sns_utils/twitter_auth", "*component*/Tf_sns_utils/twitter_auth");
    $trail->add_ext_route("tf_sns_utils/twitter_auth_res", "*component*/Tf_sns_utils/twitter_auth_res");

    $trail->add_ext_route("tf_sns_utils/me2day_auth", "*component*/Tf_sns_utils/me2day_auth");
    $trail->add_ext_route("tf_sns_utils/me2day_auth_res", "*component*/Tf_sns_utils/me2day_auth_res");

    $trail->add_ext_route("tf_sns_utils/facebook_auth", "*component*/Tf_sns_utils/facebook_auth");
    $trail->add_ext_route("tf_sns_utils/facebook_auth_res", "*component*/Tf_sns_utils/facebook_auth_res");



    function facebook_post($token_secret, $message, $link='')
    {

        if( $link ){

            $post_data = array(
                'access_token' => $token_secret,
                'message' => $message,
        		'link' => $link
                );

        }else{

            $post_data = array(
				'access_token' => $token_secret,
				'message' => $message
            );

        }

        $uri = "https://graph.facebook.com/me/feed?" . $postdata;

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, "https://graph.facebook.com/me/feed");
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
        ob_start();
        $res = curl_exec($ch);
        curl_close($ch);
        $cont=ob_get_contents();ob_end_clean();

        $js = json_decode($cont);
        $id = $js->id;
        if ($id)
        {
            $id_a = explode("_", $id);
            if($id_a[1])
                return $id_a[1];
        }
        else {
            
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, "https://graph.facebook.com/me/feed");
            curl_setopt($ch, CURLOPT_POST, 1);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
            ob_start();
            $res = curl_exec($ch);
            curl_close($ch);
            $cont=ob_get_contents();ob_end_clean();

            $js = json_decode($cont);
            $id = $js->id;
            if ($id)
            {
                $id_a = explode("_", $id);
                if($id_a[1])
                    return $id_a[1];
            }
            else {
                
                $ch = curl_init();
                curl_setopt($ch, CURLOPT_URL, "https://graph.facebook.com/me/feed");
                curl_setopt($ch, CURLOPT_POST, 1);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
                curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
                ob_start();
                $res = curl_exec($ch);
                curl_close($ch);
                $cont=ob_get_contents();ob_end_clean();

                $js = json_decode($cont);
                $id = $js->id;
                if ($id)
                {
                    $id_a = explode("_", $id);
                    if($id_a[1])
                        return $id_a[1];
                }
            }
        }

        return false;
    }

    function facebook_friend_post($token_secret, $msg, $description, $target, $link='')
    {

        if( $link ){

            $post_data = array(
                'access_token' => $token_secret,
                'message' => $msg,
        		'link' => $link,
                'description' => $description
                );

        }else{

            $post_data = array(
				'access_token' => $token_secret,
				'message' => $msg,
                'description' => $description
            );

        }

        $uri = "https://graph.facebook.com/".$target."/feed?" . $postdata;

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, "https://graph.facebook.com/".$target."/feed");
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
        ob_start();
        $res = curl_exec($ch);
        curl_close($ch);
        $cont=ob_get_contents();ob_end_clean();

        $js = json_decode($cont);
        $id = $js->id;
        if ($id)
        {
            $id_a = explode("_", $id);
            if($id_a[1])
                return $id_a[1];
        }
        else
        {
            error_log("ERROR_FACEBOOK_RESULT: " . $cont);

        }
        return false;


    }

    function facebook_action($_token, $_action, $_object, $_url, $_message = '')
    {
        $args = array('access_token' => $_token);
        $args[$_object] = $_url; 
//        if ($_action == 'comment')$args['message'] = $_message;


        if ($_action == 'follows')
            $uri = "https://graph.facebook.com/me/og." .$_action;
        else
            $uri = "https://graph.facebook.com/me/petlovesme:" .$_action;
//        $uri = "https://graph.facebook.com/me/petlovesme:" .$_action."?access_token=".$_token."&".$_object."=".$_url;

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $uri);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $args);
        ob_start();
        $res = curl_exec($ch);
        curl_close($ch);
        $cont=ob_get_contents();
        ob_end_clean();

        $js = json_decode($cont);
//        print_r($js);exit(1);
        $id = $js->id;
        if ($id)
        {
            $id_a = explode("_", $id);
            if($id_a[1])
                return $id_a[1];
        }
        else
        {
            
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $uri);
            curl_setopt($ch, CURLOPT_POST, 1);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $args);
            ob_start();
            $res = curl_exec($ch);
            curl_close($ch);
            $cont=ob_get_contents();
            ob_end_clean();

            $js = json_decode($cont);
            $id = $js->id;
            if ($id)
            {
                $id_a = explode("_", $id);
                    if($id_a[1])
                        return $id_a[1];
            }
            else {   
                $ch = curl_init();
                curl_setopt($ch, CURLOPT_URL, $uri);
                curl_setopt($ch, CURLOPT_POST, 1);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
                curl_setopt($ch, CURLOPT_POSTFIELDS, $args);
                ob_start();
                $res = curl_exec($ch);
                curl_close($ch);
                $cont=ob_get_contents();
                ob_end_clean();

                $js = json_decode($cont);
                $id = $js->id;
                if ($id)
                {
                    $id_a = explode("_", $id);
                    if($id_a[1])
                        return $id_a[1];
                }
            }

        }

        return false;
    }

    function facebook_photo ($_token, $folder, $id, $con)
    {
        $args = array('message' => $con);
        $args['access_token'] = $_token;
        $args['image'] = '@' . realpath('media/'.$folder.'/'.$id.'.jpg');

        $uri = "https://graph.facebook.com/me/photos";

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $uri);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $args);
        ob_start();
        $res = curl_exec($ch);
        curl_close($ch);
        $cont=ob_get_contents();ob_end_clean();

        $js = json_decode($cont);
        $id = $js->id;
        if ($id)
        {
            return $id;
        }

        return false;
    }

    function facebook_get_albums($fb_id, $fb_access_token) {

        $uri = "https://graph.facebook.com/".$fb_id."/albums?access_token=".$fb_access_token;

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $uri);
//        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, RE, $args);
        ob_start();
        $res = curl_exec($ch);
        curl_close($ch);
        $cont=ob_get_contents();ob_end_clean();

        $js = json_decode($cont, true);

        return $js['data'];

    }

    function facebook_friend ($_token, $is_app = false)
    {
        $uri = "https://graph.facebook.com/me/friends?access_token=".$_token;
        if ($is_app) $uri = "https://graph.facebook.com/me/friends?limit=100&access_token=".$_token;

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $uri);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        ob_start();
        $res = curl_exec($ch);
        curl_close($ch);
        $cont=ob_get_contents();ob_end_clean();

        $js = json_decode($cont, true);
//        print_r($js);
        
        return $js['data'];
    }

    function facebook_me ($_token)
    {
        $uri = "https://graph.facebook.com/me?access_token=".$_token;

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $uri);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        ob_start();
        $res = curl_exec($ch);
        curl_close($ch);
        $cont=ob_get_contents();ob_end_clean();

        $js = json_decode($cont, true);
//        print_r($js);exit(1);

        return $js;
    }

    function facebook_picture ($_token)
    {
        $uri = "https://graph.facebook.com/me?fields=picture.width(150)&access_token=".$_token;

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $uri);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        ob_start();
        $res = curl_exec($ch);
        curl_close($ch);
        $cont=ob_get_contents();ob_end_clean();

        $js = json_decode($cont, true);

        return $js['picture']['data']['url'];
    }

    function me2day_post($me2id, $me2key, $cont, $_file_path='')
    {
        global $trail;
		$me2day_key = $trail->_settings->METODAY_API_KEY;
        $nonce = "AAAAAAAA";
        $auth = $me2id . ":" . $nonce . md5($nonce . $me2key);
        $auth = "Basic  " . base64_encode($auth);

        $content_type = 'application/x-www-form-urlencoded';
        $accept = 'text/plain';

        if( $_file_path ){
            $content_type = 'multipart/form-data';
            $accept = 'text/html';
        }

        $http_header = array("User-Agent:" . "Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)"
        , "Timeout:" . "100"
        , "Host:" . "me2day.net"
        , "Content-type:" . $content_type
        , "Accept:" . $accept
        , "Authorization:" . $auth);

        $_url = "http://me2day.net/api/create_post/" . $me2id . ".xml?"
        . "akey=" . $me2day_key . "&post[body]=" . urlencode($cont);

        $ch = curl_init();

        curl_setopt($ch, CURLOPT_HTTPHEADER, $http_header);
        curl_setopt($ch, CURLOPT_URL, $_url);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_HEADER, 0);

        if( $_file_path ){

            $post = array(
					"attachment"=>'@'.$_file_path
            );

            curl_setopt($ch, CURLOPT_VERBOSE, 0);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        }

        ob_start();
        $res = curl_exec($ch);
        curl_close($ch);
        $cont=ob_get_contents();ob_end_clean();
        //$cont = "xxxxx<hhh>hhhhh";

        ob_start();
        $doc = new DOMDocument();
        $doc->loadXML($cont);
        $itemlist = $doc->getElementsByTagName("permalink");
        $item = $itemlist->item(0);
        $error=ob_get_contents();ob_end_clean();

        if ($item && !$error)
        {
            $k = $item->firstChild;
            if ($k == null)
                return false;
            else
                if ($k->data != "null")
                    return $k->data;
                else
                    return false;

        }

        error_log("ERROR_ME2DAY_RESULT: " . $cont);

        return false;

    }


    function twitter_post($token_key, $token_secret, $cont)
    {
        global $trail;
		$twitter_consumer_key = $trail->_settings->TWITTER_COMSUMER_KEY;
                $twitter_consumer_secret = $trail->_settings->TWITTER_COMSUMER_SECRET;

        require_once('../tf_app/ext/tf_sns_utils/twitteroauth.php');

        $cont = strip_tags($cont);
        //$cont = cut_multi($cont, 140);

//        $parameters = array('status' => $cont);
        $parameters = array('status' => $cont);
        $connection = new TwitterOAuth($twitter_consumer_key, $twitter_consumer_secret, $token_key, $token_secret);
        $status = $connection->post('statuses/update', $parameters);

        if ($status->error)
        {
            return false;
            error_log("ERROR_TWITTER_RESULT: " . $status->error);
        }
        return $status->id_str;

    }

    function twitter_friend ($token_key, $token_secret, $is_app = false)
    {
        global $trail;
		$twitter_consumer_key = $trail->_settings->TWITTER_COMSUMER_KEY;
                $twitter_consumer_secret = $trail->_settings->TWITTER_COMSUMER_SECRET;

        require_once('../tf_app/ext/tf_sns_utils/twitteroauth.php');

        $connection = new TwitterOAuth($twitter_consumer_key, $twitter_consumer_secret, $token_key, $token_secret);
        $parameters = array('count' => '5000', 'cursor' => '-1');
        $status = $connection->get('followers/ids', $parameters);
//        print_r($status);
        $js = $status->ids;
        if ($js) {
            $data = array();
            $len_ids = sizeof($js);
            $roop_ids = ceil($len_ids / 100);
            if ($is_app) $roop_ids = 1;

            for ($i=0; $i<$roop_ids; $i++) {
                
                $ids_t = array_slice ($js, 100 * $i, 100);
                $ids = implode($ids_t,",");
                $parameters = array('user_id' => $ids);
                $fr = $connection->get('users/lookup', $parameters);
                $fr = objectToArray($fr);
                $data = array_merge($data, $fr);
            }
//            print_r($data);
            return $data;
        }
    }

    //유진우 와글 포스트 추가
    function wagle_post($access_token,$message)
    {

        //SNS의 settings 에서 global 이 작동하지 않으므로 전체 settings를 이용한다.
    	global $trail;
        $settings = $trail->_current_controller->settings;


//        error_log($settings->WAGGLE_APPID.'  '.$settings->WAGGLE_AKEY.'   '.$access_token);

		$app_agent = 'Etc;Etc;Etc;'.$settings->WAGGLE_APPID.';1.0;Etc;LAN';

//		$message = cut_multi($message, 1000); //최대 1000자 까지 가능

		$http_header = array
		(
            "Timeout: " . "300"
           ,"App-Agent: " . $app_agent
           ,"AKey: ".$settings->WAGGLE_AKEY
           ,"accessToken: " . $access_token
           ,"Content-type: " . "application/x-www-form-urlencoded"
		);

		$_url = $settings->WAGLE_URLS[$settings->WAGLE_URL_INDEX].'/v3.0/statuses/update';

		/*
		$post_data = array(
		'accessType' => '020'       //접속유형 (필수): 010 단말 / 020 유선
		                            //        / 030 from twitter / 040 from facebook / 050 from meeting
		,'text' => $message         //글 내용 최대 1000자(필수)
		,'parentId' => ''           //댓글의 상위 글 아이디
		,'source' => ''             //출처(선택)
		,'lati' => ''               //내 위치의 위도(선택)
		,'longi' => ''              //내 위치의 경도(선택)
		,'address' => ''            //내 위치의 주소(선택)
		,'placeLati' => ''          //장소 위치의 위도(선택)
		,'placeLongi' => ''         //장소 위치의 경도(선택)
		,'placeAddress' => ''       //장소 위치의 주소(선택)
		,'twitterAccessToken' => '' //트위터 접근 토큰#보안키(선택)
		,'facebookAccessToken' => ''//페이스북접근토큰(선택)
		,'makeShortUrl' => ''       //짧은 url 생성 여부(선택)
		,'files' => ''              //파일 리스트 (최대 3개)(선택)
		);
		*/

		$ch = curl_init();
		curl_setopt($ch, CURLOPT_HTTPHEADER, $http_header);
		curl_setopt($ch, CURLOPT_URL, $_url);
		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_POSTFIELDS, 'accessType=020&text='.$message);
		curl_setopt($ch, CURLOPT_HEADER, 0);

		ob_start();
		$res = curl_exec($ch);
		curl_close($ch);
		$cont=ob_get_contents();
		ob_end_clean();

		$json_obj = json_decode($cont,1);
		if(!$json_obj)
		{
			error_log("ERROR_WAGLE_CODE: -1  ERROR_WAGLE_RESULT: NON JSON OBJ");
			return false;
		}
        if($json_obj['resultCode'] != 0)
        {
			error_log("ERROR_WAGLE_CODE: ".$json_obj['resultCode']."  ERROR_WAGLE_RESULT: " . $json_obj['resultMsg']);
			return false;
        }
        return true;
    }

    function cut_multi($str,$max)
    {
    	$substr = substr($str, 0, $max*2);
    	$multi_max = preg_match_all('/[\x80-\xff]/', $substr, $multi_chars);

    	if($multi_max >0)
    	$max = $max + intval($multi_max/3)-1;

    	if(strlen($str)>$max)
    	{
    		$str = substr($str, 0, $max-2);
    		$str = preg_replace('/(([\x80-\xff]{3})*?)([\x80-\xff]{0,2})$/', '$1', $str);
    		$str .= '...';
    	}

    	return $str;

    }
?>