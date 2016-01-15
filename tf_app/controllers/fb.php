<?php

use Facebook\FacebookCurl;
use Facebook\FacebookCurlHttpClient;
use Facebook\FacebookSession;                         //
use Facebook\FacebookRedirectLoginHelper;             //
use Facebook\FacebookRequest;
use Facebook\FacebookResponse;
use Facebook\FacebookSDKException;
use Facebook\FacebookRequestException;
use Facebook\FacebookOtherException;
use Facebook\FacebookAuthorizationException;
use Facebook\GraphObject;
use Facebook\GraphUser;
use Facebook\GraphSessionInfo;

class Fb extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "";
    var $use_models = array("Members", "Member_ext", "Activity", "Content_category", "Office_mento"
            , "Code");


    public function before_calling(){

    }

    public function index($_public = "")
    {
        if(array_key_exists('next',$_REQUEST)) $_SESSION["n"] = remove_tags($_REQUEST["next"]);
        if(array_key_exists('returl_url',$_REQUEST)) $_SESSION["r"] = remove_tags($_REQUEST["returl_url"]);

        $APP_ID = $this->settings->FACEBOOK_API_KEY;
        $APP_SECRET = $this->settings->FACEBOOK_SECRET;
        FacebookSession::setDefaultApplication( $APP_ID, $APP_SECRET );

        $helper = new FacebookRedirectLoginHelper( 'http://'.$_SERVER["HTTP_HOST"].'/fb' );
        try {
            $session = $helper->getSessionFromRedirect();
        }
        catch (Exception $e) {
            echo $e->getMessage();
        }

        if ($_public) {
            $permissions = array(
                // 'email',
                'publish_actions'
            );
            $_SESSION["n"] = "/public";
        }
        else {
            $permissions = array(
                'email',
                // 'publish_actions'
            );
        }

        // Session based API call.
        if ( isset( $session ) ) {
            // Save the session
            unset($_SESSION["access_token"]);
            $access_token = $session->getToken();
            $_SESSION["access_token"] = $access_token;
            // Create session using saved token or the new one we generated at login
            $session = new FacebookSession( $access_token );

            // graph api request for user data
            $request = new FacebookRequest( $session, 'GET', '/me' );
            $response = $request->execute();
            
            // get response
            $graphObject = $response->getGraphObject()->asArray();
            // print_r($_REQUEST['q']);
            // print_r($graphObject);

            $uid = $graphObject["id"];
            $next = $_SESSION["n"];
            unset($_SESSION["n"]);
            if($next == '/login'){   //페이스북 로그인 이라면

                $users_ext = $this->Member_ext->get_by_ids_type($uid, Member_ext_model::FACEBOOK_TYPE);
                if ($users_ext) {
                    
                    $user = $this->Members->get($users_ext[0]["user_id"]);
                    $arr["ids"] = $uid;
                    $arr["secret"] = $access_token;
                    $arr["user_id"] = $user["id"];
                    $arr["type"] = 1;
                    $this->Member_ext->edit_by_fb($arr);
                    $this->Members->log_login($user["id"]);
                    
                    $_SESSION["s"] = $user;
                    $_SESSION["s"]["fb"] = $this->Member_ext->get_by_user_id_type($user["id"], 1);
                    $_SESSION["s"]["tw"] = $this->Member_ext->get_by_user_id_type($user["id"], 2);
                    if (!$_SESSION["s"]["picture"]) $_SESSION["s"]["picture"] = '/img/default-img-member.png';
                    $_SESSION["s"]["acnt"] = $this->Activity->get_a_cnt(1, $_SESSION["s"]["id"], '0');
                    
                    $con = $this->Content_category->get_cat_by_user($_SESSION["s"]["id"], 'cc.hidden = 0');
                    if (sizeof($con) > 0) {
                        $_SESSION["s"]["con"] = $con;
                    }
                    $mt = $this->Office_mento->cnt("user_id = ".$_SESSION["s"]["id"]);
                    if ($mt > 0) {
                        $_SESSION["s"]["mento"] = true;
                    }
                    $_SESSION["s"]["rep1"] = $this->Code->check('rep1', $_SESSION["s"]["id"]);
                    $_SESSION["s"]["rep2"] = $this->Code->check('rep2', $_SESSION["s"]["id"]);

                    if($_SESSION["r"]){
                        $_temp_r = $_SESSION["r"];
                        unset($_SESSION["r"]);
                        header("Location: ".$_temp_r);
                    }
                    else {
                        header("Location: /");
                    }

                } else {
                    $_SESSION["error"] = "no_fb";
                    header("Location: ".$next);
                }

            } 
            else if ($next == '/regist'){

                $users_ext = $this->Member_ext->get_by_ids_type($uid, Member_ext_model::FACEBOOK_TYPE);
                if ($users_ext) {
                    $this->assigns["error"] = "already";
                } else {

                    $graphObject["picture"] = "https://graph.facebook.com/v2.2/".$graphObject["id"]."/picture?redirect=1&type=large";
                    $graphObject["secret"] = $access_token;
                    $_SESSION["is_f"] = TRUE;
                    $this->assigns["fb"] = $graphObject;
                }
                $this->assigns["type"] = 'regist';
            }
            else if ($next == '/public'){

                $arr["ids"] = $uid;
                $arr["secret"] = $access_token;
                $arr["public"] = 1;
                $arr["user_id"] = $_SESSION["s"]["id"];
                $arr["type"] = 1;
                
                $this->Member_ext->edit_by_fb($arr);
                $_SESSION["s"]["fb"] = $this->Member_ext->get_by_user_id_type($_SESSION["s"]["id"], 1);
                $this->assigns["type"] = 'public';
            }
            else {

                $users_ext = $this->Member_ext->get_by_ids_type($uid, Member_ext_model::FACEBOOK_TYPE);
                if ($users_ext) {
                    $arr["ids"] = $uid;
                    $arr["secret"] = $access_token;
                    $arr["user_id"] = $users_ext["user_id"];
                    $arr["type"] = 1;
                    $this->Member_ext->edit_by_fb($arr);
                    $this->assigns["error"] = "already";
                } else {

                    $graphObject["picture"] = "https://graph.facebook.com/v2.2/".$graphObject["id"]."/picture?redirect=1&type=large";
                    $graphObject["secret"] = $access_token;
                    $_arr["user_id"] = $_SESSION["s"]["id"];
                    $_arr["type"] = 1;
                    $_arr["ids"] = $graphObject["id"];
                    $_arr["secret"] = $access_token;
                    $this->Member_ext->add($_arr);
                    $this->assigns["fb"] = $graphObject;
                    $_SESSION["s"]["fb"] = $this->Member_ext->get_by_ids_type($_SESSION["s"]["id"], 1);
                }
                $this->assigns["type"] = 'step';
            }
        }
        else {
            $loginUrl = $helper->getLoginUrl( $permissions );
            header ("location: " . $loginUrl);
        }
    }

    public function index1()
    { // 페이스북 인증

        if(array_key_exists('next',$_REQUEST)) $next = remove_tags($_REQUEST["next"]);
        $q = explode('=',$next);
        if($q) {
            $_REQUEST['q'] = $q[1];
        }

        require_once('../tf_app/ext/facebook/facebook.php');
        $facebook = new Facebook(array(
            'appId'  => $this->settings->FACEBOOK_API_KEY,
            'secret' => $this->settings->FACEBOOK_SECRET,
            'cookie' => false,
        ));

        $uid = $facebook->getUser();

          // login or logout url will be needed depending on current user state.
        if ($uid) {
            $logUrl = $facebook->getLogoutUrl();
        } else {
            $params = array(
              'scope' => $this->settings->FACEBOOK_AUTH
            );
            $logUrl = $facebook->getLoginUrl($params);//뒤에권한 파라미터가 붙게됨
        }

        if($uid){

            $access_token = $facebook->getAccessToken();


            if($uid) //스크린 이름이 있는지 확인
            {
               $users_ext = $this->Member_ext->get_by_ids_type($uid,Member_ext_model::FACEBOOK_TYPE);
            }

            if($next == '/login'){   //페이스북 로그인 이라면

               $users_ext = $this->Member_ext->get_by_ids_type($uid,Member_ext_model::FACEBOOK_TYPE);
               if ($users_ext) {
                   $user = $this->Members->get($users_ext[0]["user_id"]);
                   $this->Members->log_login($user["id"]);
                   $_SESSION["s"] = $user;
                   $_SESSION["s"]["fb"] = $this->Member_ext->get_by_user_id_type($user["id"], 1);
                   $_SESSION["s"]["tw"] = $this->Member_ext->get_by_user_id_type($user["id"], 2);
                   if (!$_SESSION["s"]["picture"]) $_SESSION["s"]["picture"] = '/img/default-img-member.png';
                   $_SESSION["s"]["acnt"] = $this->Activity->get_a_cnt(1, $_SESSION["s"]["id"], '0');
                   $con = $this->Content_category->get_cat_by_user($_SESSION["s"]["id"], 'cc.hidden = 0');
                    if (sizeof($con) > 0) {
                        $_SESSION["s"]["con"] = $con;
                    }
                   if($_REQUEST["returl_url"]){
                        header("Location: ".$_REQUEST["returl_url"]);
                    }
                    else {
                        header("Location: /member/".$user["ids"]);
                    }

                } else {
                    $_SESSION["error"] = "no_fb";
                    header("Location: ".$next);
               }

           } else if ($next == '/regist'){

               $users_ext = $this->Member_ext->get_by_ids_type($uid,Member_ext_model::FACEBOOK_TYPE);
               if ($users_ext) {
                   $this->assigns["error"] = "already";
                } else {

                    $me = facebook_me($access_token);
                    // $me["picture"] = facebook_picture($access_token);
                    $me["picture"] = "https://graph.facebook.com/".$me["id"]."/picture?type=large";
                    $me["secret"] = $access_token;
                    $_SESSION["is_f"] = TRUE;
                    $this->assigns["fb"] = $me;
               }
               $this->assigns["type"] = 'regist';
           }
           else {

               $users_ext = $this->Member_ext->get_by_ids_type($uid,Member_ext_model::FACEBOOK_TYPE);
               if ($users_ext) {
                   $this->assigns["error"] = "already";
                } else {

                    $me = facebook_me($access_token);
                    // $me["picture"] = facebook_picture($access_token);
                    $me["picture"] = "https://graph.facebook.com/".$me["id"]."/picture?type=large";
                    $me["secret"] = $access_token;
                    $_arr["user_id"] = $_REQUEST["id"];
                    $_arr["type"] = 1;
                    $_arr["ids"] = $me["id"];
                    $_arr["secret"] = $access_token;
                    $this->Member_ext->add($_arr);
                    $this->assigns["fb"] = $me;
                    $_SESSION["s"]["fb"] = $this->Member_ext->get_by_ids_type($_REQUEST["id"], 1);
               }
               $this->assigns["type"] = 'step';
           }
           
        }
        if (!$access_token) 
            header("Location: ".$logUrl);
    }
}

?>