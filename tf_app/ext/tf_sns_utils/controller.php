<?php
    class Tf_sns_utils extends Controller
    {
        var $assigns = array();
        var $assigns_layout = array();
        var $layout = "";
        var $use_models = array();
        var $use_components = array();
        
        function twitter_auth()
        {
            global $twitter_consumer_key, $twitter_consumer_secret;
            
            require_once('../tf_app/ext/tf_sns_utils/twitteroauth.php');
            $connection = new TwitterOAuth($twitter_consumer_key, $twitter_consumer_secret);
            $request_token = $connection->getRequestToken($this->_trail->_server_url . "tf_sns_utils/twitter_auth_res/");

            $_SESSION['oauth_token'] = $token = $request_token['oauth_token'];
            $_SESSION['oauth_token_secret'] = $request_token['oauth_token_secret'];
             
            switch ($connection->http_code) {
                case 200:
                    $url = $connection->getAuthorizeURL($token);
                    header('Location: ' . $url);
                    break;
                default:
                    echo 'Could not connect to Twitter. Refresh the page or try again later.';
                    break;
            }
            
        }
        
        function twitter_auth_res()
        {
            global $twitter_consumer_key, $twitter_consumer_secret, $twitter_callback;


            require_once('../tf_app/ext/tf_sns_utils/twitteroauth.php');

            // twitter connection
            $connection = new TwitterOAuth($twitter_consumer_key, $twitter_consumer_secret, $_SESSION['oauth_token'], $_SESSION['oauth_token_secret']);
            
            // get token
            $access_token = $connection->getAccessToken($_REQUEST['oauth_verifier']);
            $token = $access_token["oauth_token"];
            $token_secret = $access_token["oauth_token_secret"];

            // connect with user
            $connection = new TwitterOAuth($this->settings->TWITTER_COMSUMER_KEY, $this->settings->TWITTER_COMSUMER_SECRET, $token, $token_secret);
            
            // get user profile
            $user = $connection->get('account/verify_credentials');
            
            // save to session
            $ret = array();
            $ret["tid"] = $user->id;
            $ret["screen_name"] = $user->screen_name;
            $ret["photo_url"] = $user->profile_image_url;
            
            $ret["twitter_key"] = $token;
            $ret["twitter_secret"] = $token_secret;
            $_SESSION["tf_twitter"] = $ret;
            
            header("location: " . $twitter_callback);
                        
        }

        public function facebook_auth()
        {
            global $facebook_consumer_key;
            
            $args = "client_id=" . $facebook_consumer_key . "&redirect_uri=" . $this->_trail->_server_url . "tf_sns_utils/facebook_auth_res/";
            $uri = "https://graph.facebook.com/oauth/authorize?scope=publish_stream,offline_access&" . $args;
            
            header ("location: " . $uri);
            
        }

        public function facebook_auth_res()
        {
            global $facebook_consumer_key, $facebook_consumer_secret, $facebook_callback;

            $args = "client_id=" . $facebook_consumer_key . "&redirect_uri=" . $this->_trail->_server_url . "tf_sns_utils/facebook_auth_res/"
            . "&client_secret=" . $facebook_consumer_secret
            . "&code=" . $_REQUEST["code"];
            
            $uri = "https://graph.facebook.com/oauth/access_token?" . $args;


            $fp = fopen($uri, 'r');
            $contents = fread($fp,4096);
            if (substr($contents,0,12) == "access_token")
            {
                $token = substr($contents,13);
                
                $ret = array();
                $ret["facebook_secret"] = $token;
                
                $ch = curl_init();
                curl_setopt($ch, CURLOPT_URL, "https://graph.facebook.com/me?access_token=" . $token);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
                ob_start();
                curl_exec ($ch); 
                $res = ob_get_contents();
                ob_end_clean();
                curl_close($ch);
                
                $js = json_decode($res);
                //print_r($js);
                $facebook_id = $js->id;
                $ret["id"] = $facebook_id;
                
                $_SESSION["tf_facebook"] = $ret;

                header("location: " . $facebook_callback);
            }
            

        }
                
        public function me2day_auth()
        {
            global $me2day_key;
            $uri = "http://me2day.net/api/get_auth_url.json?akey=" . $me2day_key;
            $fp = fopen($uri, 'r');
            $contents = fread($fp,4096);
            
            $jo = json_decode($contents);
            
            header ("location: " . $jo->url);
            
        }
        
        public function me2day_auth_res()
        {
            global $me2day_callback;
            $ret = array();
            $ret["me2day_id"] = $_REQUEST["user_id"];
            $ret["me2day_apikey"] = $_REQUEST["user_key"];
            
            $_SESSION["tf_me2day"] = $ret;
            
            header("location: " . $me2day_callback);
        }
    }
    
?>