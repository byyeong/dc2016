<?


    class Twitter extends Controller
    {
        var $assigns = array();
        var $assigns_layout = array();
        var $layout = "default";
        var $use_models = array("Members","Member_ext");

        public function before_calling(){
            
        }

        public function index($ref = '')
        { // 트위터 인증
            if ($_REQUEST["id"])
                $_SESSION["temp"] = $_REQUEST["id"];

            require_once('../tf_app/ext/twitter/twitteroauth.php');
            $connection = new TwitterOAuth($this->settings->TWITTER_COMSUMER_KEY, $this->settings->TWITTER_COMSUMER_SECRET);
            $request_token = $connection->getRequestToken("http://".$_SERVER["HTTP_HOST"]."/twitter/callback/");

            $_SESSION['oauth_token'] = $token = $request_token['oauth_token'];
            $_SESSION['oauth_token_secret'] = $request_token['oauth_token_secret'];
             
            /* If last connection fails don't display authorization link */
            switch ($connection->http_code) {
                case 200:
                    /* Build authorize URL */
                    $url = $connection->getAuthorizeURL($token);
                    header('Location: ' . $url); 
                    break;
                default:
                    echo 'Could not connect to Twitter. Refresh the page or try again later.';
                    break;
            }
            exit(0);
        }
        
        public function callback()
        { // 트위터 인증 콜백
            
            require_once('../tf_app/ext/twitter/twitteroauth.php');
            
            // twitter connection
            $connection = new TwitterOAuth($this->settings->TWITTER_COMSUMER_KEY, $this->settings->TWITTER_COMSUMER_SECRET, $_SESSION['oauth_token'], $_SESSION['oauth_token_secret']);
            
            // get token
            $access_token = $connection->getAccessToken($_REQUEST['oauth_verifier']);
            $token = $access_token["oauth_token"];
            $token_secret = $access_token["oauth_token_secret"];

            // connect with user
            $connection = new TwitterOAuth($this->settings->TWITTER_COMSUMER_KEY, $this->settings->TWITTER_COMSUMER_SECRET, $token, $token_secret);
            
            // get user profile
            $user = $connection->get('account/verify_credentials');
            
            
            $screen_name = $user->screen_name;  //스크린 네임을 안 가져올 경우
            if($screen_name) //스크린 이름이 있는지 확인
            {
                $users_ext = $this->Member_ext->get_by_ids_type($screen_name, Member_ext_model::TWITTER_TYPE);
            }
            print_r($users_ext);
            if( ! $users_ext )
            {echo "a";
                if( ! $this->Member_ext->get_by_user_id_type($_SESSION["temp"], Member_ext_model::TWITTER_TYPE) )
                {
                    echo "b";
                    $_arr["user_id"] = $_SESSION["temp"];
                    $_arr["type"] = 2;
                    $_arr["ids"] = $user->screen_name;
                    $_arr["key"] = $token;
                    $_arr["secret"] = $token_secret;
                    $this->Member_ext->add($_arr);
                    unset($_SESSION["temp"]);
                    $this->assigns["tw"] = $user->screen_name;
                    $_SESSION["s"]["tw"] = $this->Member_ext->get_by_user_id_type($_SESSION["temp"], 2);
                }
                else {
                    echo "c";
                    $_arr["user_id"] = $_SESSION["temp"];
                    $_arr["type"] = 2;
                    $_arr["ids"] = $user->screen_name;
                    $_arr["key"] = $token;
                    $_arr["secret"] = $token_secret;
                    $this->Member_ext->edit($_arr);
                    unset($_SESSION["temp"]);
                    $this->assigns["tw"] = $user->screen_name;
                    $_SESSION["s"]["tw"] = $this->Member_ext->get_by_user_id_type($_SESSION["temp"], 2);
                }
            }
            else
            {
                echo "d";
                $this->assigns["error"] = "aleady";
            }
         
        }
        
    }
?>