<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Regist extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "regist";
    var $use_models = array("Members", "Member_local", "Member_skill", "Member_interist"
            , "Startup_member", "Startup", "Startup_bussiness", "Startup_tech"
            , "Member_ext", "Activity", "Code", "Member_inv", "Member_market"
            , "Member_reference", "Startup_reference", "Content_category", "Competitions_examiner"
            , "Office_mento", "Member_auto", "Competitions", "Board", "Competitions"
            , "Competitions_apply", "Content", "Event_reserve", "Event", "Faq", "Follow"
            , "Office_hours", "Office_hours_apply", "Office_mento", "Recruit", "Space_reserve");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "event";
        $this->assigns_layout["gnb_title"] = "이벤트 관리";
        
    }
    
    public function index()
    {
        if ($_SESSION["s"]) {
            header("Location: /member/".$_SESSION["s"]["ids"]);
        }
        if ($_REQUEST["e"]) $this->assigns["e"] = $_REQUEST["e"];
    }
    
    public function step2()
    {
        if ($_SESSION["s"]) {
            header("Location: /member/".$_SESSION["s"]["ids"]);
        }
        
        if ($_REQUEST["ids"]) {
            if ($_REQUEST["fb_ids"]) $_REQUEST["state"] = 1;
            $_id = $this->Members->add($_REQUEST);

            if ($_REQUEST["img"]) {
                if (strstr($_REQUEST["img"], 'http')) {
                    $_pic = $_REQUEST["img"];
                } else {
                    $img_temp_name = str_replace(" ","",$_REQUEST['img']);

                    $ck = substr($img_temp_name, 0, 1);
                    if($ck=='/'){
                        $img_temp_name = substr($img_temp_name, 1, strlen($img_temp_name) -1 );
                    }

                    $file_ext = explode('.',$img_temp_name);
                    //$filename = basename($_FILES['file']['name']);
                    $file_ext = '.'.$file_ext[sizeof($file_ext)-1];

                    $original_file = $this->settings->root_path.$img_temp_name;
                    $copy_file = $this->settings->root_path.'media/member/'.$_id.$file_ext;

                    //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                    copy($original_file, $copy_file);
                    unlink($original_file); 

                    $_pic = '/media/member/'.$_id.$file_ext;
                }
                
                $this->Members->add_picture($_id, $_pic);
            }
            
            if ($_REQUEST["fb_ids"]) {
                $_arr["user_id"] = $_id;
                $_arr["type"] = 1;
                $_arr["ids"] = $_REQUEST["fb_ids"];
                $_arr["secret"] = $_REQUEST["secret"];
                $this->Member_ext->add($_arr);
                $this->assigns["fb_ids"] = $_REQUEST["fb_ids"];
            }
            
            $this->assigns["id"] = $_id;
            $this->assigns["utype"] = $_REQUEST["utype"];
            
            if ($_REQUEST["utype"] == 1) {
                $this->assigns["local"] = $this->Code->get_by_key('local');
                $this->assigns["inv"] = $this->Code->get_by_key('inv');
            }
            else if ($_REQUEST["utype"] == 2) {
                
                
                $_key3 = 'market';
                $result3 = $this->Code->get_by_key($_key3);
                $items3 = array();
                for ($j=0; $j<sizeof($result3); $j++) {
                    array_push($items3, $result3[$j]["_value"]);
                }
                $this->assigns["market"] =  json_encode($items3);
            }
            
            $_key = 'jobs';
            $result = $this->Code->get_by_key($_key);
            $items = array();
            for ($i=0; $i<sizeof($result); $i++) {
                $result[$i]["value"] = $result[$i]["_value"];
                array_push($items, $result[$i]);
            }
            $_key2 = 'field';
            $result2 = $this->Code->get_by_key($_key2);
            $items2 = array();
            for ($j=0; $j<sizeof($result2); $j++) {
                array_push($items2, $result2[$j]["_value"]);
            }
            
            $this->assigns["job"] =  json_encode($items);
            $this->assigns["skill"] =  json_encode($items2);
        
        } else {
            header("Location: /");
        }

    }
    
    public function step3() 
    {
        if ($_SESSION["s"]) {
            header("Location: /member/".$_SESSION["s"]["ids"]);
        }
        
        if ($_REQUEST["id"]) {
            $_id = $this->Members->add($_REQUEST);
            
            if($_REQUEST["id"]) {
                $this->Member_local->delete_by_user($_REQUEST["id"]);
                $this->Member_interist->delete_by_user($_REQUEST["id"]);
                $this->Member_inv->delete_by_user($_REQUEST["id"]);
                $this->Member_skill->delete_by_user($_REQUEST["id"]);
                $this->Member_market->delete_by_user($_REQUEST["id"]);
            }
            
            // utype == 1
            if ($_REQUEST["local"]) {
                $local = explode(",", $_REQUEST["local"]);
                $len_local = sizeof($local);
                for($i=0; $i<$len_local; $i++) {
                    if (trim($local[$i]))
                        $this->Member_local->add($_id, trim($local[$i]));
                }
            }
            if ($_REQUEST["inter_"]) {
                $int = explode(",", $_REQUEST["inter_"]);
                $len_int = sizeof($int);
                for($n=0; $n<$len_int; $n++) {
                    if (trim($int[$n]))
                        $this->Member_interist->add_c($_id, trim($int[$n]));
                }
            }
            $len_sk = $_REQUEST["cnt_sk"];
            for($j=1; $j<$len_sk+1; $j++) {
                $tmp = "skill_".$j;
                if (trim($_REQUEST[$tmp])) {
                    $val = $this->Code->get_value(trim($_REQUEST[$tmp]), 'jobs');
                    $this->Member_skill->add_c($_id, $val['id']);
                }
            }
            
            // utype == 2
            $len_int = $_REQUEST["cnt_fl_i"];
            for($k=1; $k<$len_int+1; $k++) {
                $tmp = "field_".$k;
                if (trim($_REQUEST[$tmp])) {
                    $val = $this->Code->get_value(trim($_REQUEST[$tmp]), 'jobs');
                    $this->Member_inv->add($_id, $val['id']);
                }
            }
            $len_sk_i = $_REQUEST["cnt_sk_i"];
            for($l=1; $l<$len_sk_i+1; $l++) {
                $tmp = "skill_".$l;
                if (trim($_REQUEST[$tmp])) {
                    $val = $this->Code->get_value(trim($_REQUEST[$tmp]), 'jobs');
                    $this->Member_skill->add_c($_id, $val['id']);
                }
            }
            $len_mk_i = $_REQUEST["cnt_mk_i"];
            for($m=1; $m<$len_mk_i+1; $m++) {
                $tmp = "market_".$m;
                if (trim($_REQUEST[$tmp])) {
                    $val = $this->Code->get_value(trim($_REQUEST[$tmp]), 'market');
                    $this->Member_market->add_c($_id, $val['id']);
                }
            }
            
            $user = $this->Members->get($_id);
	        if (!$_SESSION["is_f"]) {		 
                $m = new TF_mailer($this->settings);
                $m->mailto = $user["email"];
                $m->subject = '[D.CAMP] 가입인증 메일입니다.';
                $m->tpl_name = 'regist_auth';
                $m->assigns["login_name"] = $user["ids"];
                $m->assigns["nickname"] = $user["name"];
                $m->assigns["confirm_key"] = $user["confirm_key"];
                $m->assigns["main_service_url"] = $this->globals->my_host;
                $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                $m->assigns['pass_ssl'] = $this->settings->pass_ssl;
                $m->send();
            }
            else {
                $_SESSION["s"] = $user;
                $this->assigns["is_f"] = TRUE;
                unset($_SESSION["is_f"]);
            }
            
            // reference check
            $ref_c = $this->Member_reference->request_ref_by_email($user["email"]);
            if (sizeof($ref_c) > 0) {
                $len_ref_c = sizeof($ref_c);
                for ($r=0; $r<$len_ref_c; $r++) {
                    $m = "<a href='/member/".$ref_c[$r]["ids"]."'>".$ref_c[$r]["name"]."</a>님이 D.CAMP의 프로필/이력 페이지에 당신을 레퍼런스로 추가하고자 합니다. <a href='/member/".$ref_c[$r]["ids"]."'>".$ref_c[$r]["name"]."</a>님에 대한 추천사를 남겨주세요.";
                    $arr["com_type"] = 1;
                    $arr["com_id"] = $user["id"];
                    $arr["act_type"] = 1;
                    $arr["act_id"] = $ref_c[$r]["mid"];
                    $arr["act_result"] = '';
                    $arr["target_type"] = Activity_model::E_TYPE_REFERENCE;
                    $arr["target_id"] = '';
                    $arr["is_made"] = '';
                    $arr["msg"] = $m;
                    $this->Activity->add($arr);
                }
            }
            $ref_s = $this->Startup_reference->request_ref_by_email($user["email"]);
            if (sizeof($ref_s) > 0) {
                $len_ref_c = sizeof($ref_s);
                for ($rs=0; $rs<$len_ref_c; $rs++) {
                    $m = "<a href='/startup/".$ref_s[$rs]["startup_id"]."'>".$ref_s[$rs]["name"]."</a>님이 D.CAMP의 프로필/이력 페이지에 당신을 레퍼런스로 추가하고자 합니다. <a href='/startup/".$ref_s[$rs]["startup_id"]."'>".$ref_s[$rs]["name"]."</a>님에 대한 추천사를 남겨주세요.";
                    $arr["com_type"] = 1;
                    $arr["com_id"] = $user["id"];
                    $arr["act_type"] = 2;
                    $arr["act_id"] = $ref_s[$rs]["mid"];
                    $arr["act_result"] = '';
                    $arr["target_type"] = Activity_model::E_TYPE_REFERENCE;
                    $arr["target_id"] = '';
                    $arr["is_made"] = '';
                    $arr["msg"] = $m;
                    $this->Activity->add($arr);
                }
            }
            
            // startup staff apply check
            $mem_app = $this->Startup_member->get_by_email_req($user["email"]);
            if ($mem_app) {
                $len_mem_app = sizeof($mem_app);
                for ($m=0; $m<$len_mem_app; $m++) {
                    $s = $this->Startup->get($mem_app[$m]["startup_id"]);
                    $msg = "<a href='/startup/".$s["id"]."'>".$s["name"]."</a> 구성원으로 초대되었습니다. 기업 정보를 수정할 수 있습니다.";
                    $arr["com_type"] = 1;
                    $arr["com_id"] = $user["id"];
                    $arr["act_type"] = 1;
                    $arr["act_id"] = $mem_app[$m]["mid"];
                    $arr["act_result"] = '';
                    $arr["target_type"] = '';
                    $arr["target_id"] = '';
                    $arr["is_made"] = '';
                    $arr["msg"] = $msg;
                    $this->Activity->add($arr);
                    $this->Startup_member->add($s["id"], $user["id"], ""
                        , "", "", "", 1, 1);
                }
                $this->Startup_member->edit_state_req($user["email"], 1);
            }
            
            // challenge invitation check
            $this->Competitions_examiner->update_by_email($user["email"], $user["id"]);
            $com = $this->Competitions_examiner->list_outer('', '', "ce.email = '".$user["email"]."'");
            for ($cc=0; $cc<sizeof($com); $cc++) {
                $res = $this->Competitions->get($com[$cc]["competition_id"]);
                $arr["com_type"] = 1;
                $arr["com_id"] = $user["id"];
                $arr["act_type"] = 1;
                $arr["act_id"] = $user["id"];
                $arr["msg"] = "<a href='/challenge/views/".$res["id"]."'>".$res["subject"]."</a> 의 <a href='/challenge/pending?id=".$res["id"]."&amp;e=".$per["email"]."'>심사위원</a> 으로 초대되셨습니다. ";
                $this->Activity->add($arr);
            }
                
            // challenge operator invitation check
            $this->Competitions_examiner->operator_update_by_email($user["email"], $user["id"]);

            $this->assigns["user"] = $user;
            $_SESSION["user_id"] = $user["id"]; 
        }
        else {
            header("Location: /");
        }
    }
    
    public function startup()
    {
    }
    public function startup_connected($_st, $_user)
    {
        $this->Startup_member->add($_st, $_user);
        $this->assigns["res"] = $this->Startup->get($_st);
    }
    
    public function startup_info()
    {
        $this->assigns["name"] = $_REQUEST["name"];
    }
    
    public function startup_entered()
    {
//        if ($_REQUEST["name"]) {
            $_id = $this->Startup->add($_REQUEST);
            $this->Startup_member->add($_id, $_SESSION["user_id"]);
            if ($_REQUEST["bussiness"]) {
                if($_REQUEST["id"]) {
                    $this->Startup_bussiness->delete_by_user($_REQUEST["id"]);
                }
                $bussiness = explode(",", $_REQUEST["bussiness"]);
                $len_bussiness = sizeof($bussiness);
                for($i=0; $i<$len_bussiness; $i++) {
                    if (trim($bussiness[$i]))
                        $this->Startup_bussiness->add($_id, trim($bussiness[$i]));
                }
            }
            if ($_REQUEST["tech"]) {
                if($_REQUEST["id"]) {
                    $this->Startup_tech->delete_by_user($_REQUEST["id"]);
                }
                $tech = explode(",", $_REQUEST["tech"]);
                $len_tech = sizeof($tech);
                for($j=0; $j<$len_tech; $j++) {
                    if (trim($tech[$j]))
                        $this->Startup_tech->add($_id, trim($tech[$j]));
                }
            }

            if ($_REQUEST["img"]) {
                $img_temp_name = str_replace(" ","",$_REQUEST['img']);

                $ck = substr($img_temp_name, 0, 1);
                if($ck=='/'){
                    $img_temp_name = substr($img_temp_name, 1, strlen($img_temp_name) -1 );
                }

                $file_ext = explode('.',$img_temp_name);
                //$filename = basename($_FILES['file']['name']);
                $file_ext = '.'.$file_ext[sizeof($file_ext)-1];

                $original_file = $this->settings->root_path.$img_temp_name;
                $copy_file = $this->settings->root_path.'media/startup/'.$_id.$file_ext;

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/startup/'.$_id.$file_ext;
                $this->Startup->add_picture($_id, $_pic);
            }
            
            $this->assigns["s_name"] = $_REQUEST["name"];
//        }
//        else {
//            header("Location: /");
//        }
    }
    
    public function investment()
    {
        
    }
    
    public function investment_connected($_st, $_user)
    {
        $this->Startup_member->add($_st, $_user);
        $this->assigns["res"] = $this->Startup->get($_st);
    }
    
    public function investment_info()
    {
        $this->assigns["name"] = $_REQUEST["name"];
    }
    
    public function investment_entered()
    {
//        if ($_REQUEST["name"]) {
            $_id = $this->Startup->add($_REQUEST);
            $this->Startup_member->add($_id, $_SESSION["user_id"]);
            if ($_REQUEST["bussiness"]) {
                if($_REQUEST["id"]) {
                    $this->Startup_bussiness->delete_by_user($_REQUEST["id"]);
                }
                $bussiness = explode(",", $_REQUEST["bussiness"]);
                $len_bussiness = sizeof($bussiness);
                for($i=0; $i<$len_bussiness; $i++) {
                    if (trim($bussiness[$i]))
                        $this->Startup_bussiness->add($_id, trim($bussiness[$i]));
                }
            }
            if ($_REQUEST["tech"]) {
                if($_REQUEST["id"]) {
                    $this->Startup_tech->delete_by_user($_REQUEST["id"]);
                }
                $tech = explode(",", $_REQUEST["tech"]);
                $len_tech = sizeof($tech);
                for($j=0; $j<$len_tech; $j++) {
                    if (trim($tech[$j]))
                        $this->Startup_tech->add($_id, trim($tech[$j]));
                }
            }

            if ($_REQUEST["img"]) {
                $img_temp_name = str_replace(" ","",$_REQUEST['img']);

                $ck = substr($img_temp_name, 0, 1);
                if($ck=='/'){
                    $img_temp_name = substr($img_temp_name, 1, strlen($img_temp_name) -1 );
                }

                $file_ext = explode('.',$img_temp_name);
                //$filename = basename($_FILES['file']['name']);
                $file_ext = '.'.$file_ext[sizeof($file_ext)-1];

                $original_file = $this->settings->root_path.$img_temp_name;
                $copy_file = $this->settings->root_path.'media/startup/'.$_id.$file_ext;

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/startup/'.$_id.$file_ext;
                $this->Startup->add_picture($_id, $_pic);
            }
            
            $this->assigns["s_name"] = $_REQUEST["name"];
//        }
//        else {
//            header("Location: /");
//        }
    }
    
    public function login()
    {
        if ($_SESSION["s"]) {
            header("Location: /member/".$_SESSION["s"]["ids"]);
        }
        
        if ($_REQUEST["ids"]) {
            $check = $this->Members->login($_REQUEST);
//            print_r($check); exit(1);
            if ($check == "error_9") {
                $this->assigns["ids"] = $_REQUEST["ids"];
                $this->assigns_layout["msg"] = "비밀번호를 확인해주세요.";
            }
            else if ($check == "error_404") {
                $this->assigns_layout["msg"] = "아이디를 확인해주세요.";
            }
            else if ($check == "error_300") {
                $this->assigns_layout["msg"] = "회원 인증이 완료되지 않았습니다.<br />인증메일을 확인해주세요.";
            }
            else if ($check == "error_200") {
                $u = $this->Members->get_by_ids($_REQUEST["ids"]);
                $new_pw = make_code();
                $this->Members->edit_pwd_by_mail($u["id"],$new_pw);

                $m = new TF_mailer($this->settings);
                $m->mailto = $u["email"];
                $m->subject = "[D.CAMP] 비밀번호 찾기 메일입니다.";
                $m->tpl_name = "pw_renew";
                $m->assigns["userid"] = $u["ids"];
                $m->assigns["new_pw"] = $new_pw;
                $m->assigns["main_service_url"] = $this->globals->my_host;
                $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                $m->send();
                
                $this->assigns_layout["msg"] = "안녕하세요. D.CAMP입니다.<br />D.CAMP의 새로운 홈페이지에 오신 것을 환영합니다.<br />홈페이지 이전과 함께 기존 가입자의 경우 등록하신 메일(".$u["email"].")로 새로운 임시 비밀번호를 발송해드렸습니다.<br />메일을 확인하시고 임시 비밀번호로 로그인해주세요. (멤버십 등 기존에 이용하시던 데이터는 이전 후에도 계속 유지됩니다)";
            }
            else {
                $_SESSION["s"] = $this->Members->get($check);
                if (!$_SESSION["s"]["picture"]) $_SESSION["s"]["picture"] = '/img/default-img-member.png';
                $_SESSION["s"]["acnt"] = $this->Activity->get_a_cnt(1, $_SESSION["s"]["id"], '0');
                $_SESSION["s"]["fb"] = $this->Member_ext->get_by_user_id_type($_SESSION["s"]["id"], 1);
                $_SESSION["s"]["tw"] = $this->Member_ext->get_by_user_id_type($_SESSION["s"]["id"], 2);
                
                // auto_login
                if (array_key_exists("auto_login", $_REQUEST) && $_REQUEST["auto_login"] == "1")
                {
                    $auto_login = $_REQUEST['auto_login'];
                    $auto_login = remove_tags($auto_login);

                    //자동로그인 업데이트
                    $this->Members->update_by_key('auto_login', 1, $_SESSION["s"]["id"]);
                    $akey = $this->Member_auto->add($_SESSION["s"]['id'], $_SESSION["s"]['ids']);
                    $_SESSION["s"]["auto_login"] = 1;
                    setcookie("dcamp_id_save", $_SESSION["s"]['id'],time()+ 1209600,"/");
                    setcookie("dcamp_akey", $akey ,time()+ 1209600,"/");
                    $_SESSION["msg"] = "현재 &#039;로그인 유지&#039; 기능을 이용중입니다. 다른 이용자들과 함께 사용하는 PC인 경우 이용 후 반드시 로그아웃을 해 주세요!";
                }

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
                $return_url = remove_tags($_REQUEST['returl_url']);
                                
                if ($return_url)
                    header("Location: ".$return_url);
                else 
                    header("Location: /");
            }
        }
        if(array_key_exists('url_next',$_GET) ){
            $next = $_GET['url_next'];
            $next = remove_tags($next);
        }
        
        if ($next)
            $this->assigns['returl_url'] = $next;
        else
            $this->assigns['returl_url'] = get_return_url( $_SERVER['HTTP_REFERER'], remove_tags($_REQUEST['returl_url']) );
        if ($_REQUEST["next"]) $this->assigns["next"] = $_REQUEST["next"];
        if ($_SESSION["error"]) {
            if ($_SESSION["error"] == "no_fb") {
                unset($_SESSION["error"]);
                $this->assigns_layout["msg"] = "연동된 페이스북 계정이 없습니다.";
            }
        }
    }
    
    public function logout()
    {
        // if($_SESSION["s"]['auto_login'] == 1){
            $this->Members->update_by_key('auto_login', 0, $_SESSION["s"]['id']);
            $this->Member_auto->delete_by_id_user($_SESSION["s"]['id']);
            setcookie('dcamp_id_save', null, -1, '/');
            setcookie('dcamp_akey', null, -1, '/');
        // }
        unset($_SESSION["s"]);
        // session_start();
        // session_unset();
        // session_destroy();
        header("Location: /");
    }
    
    public function signout()
    {
        $arr["id"] = $_SESSION["s"]["id"];
        $arr["state"] = 3;
        $arr["grade"] = $_SESSION["s"]["grade"];
        $this->Members->signout($arr);

        $this->Activity->signout($_SESSION["s"]["id"]);
        $this->Board->signout($_SESSION["s"]["id"]);
        $this->Competitions->signout($_SESSION["s"]["id"]);
        $this->Competitions_apply->signout($_SESSION["s"]["id"]);
        $this->Content->signout($_SESSION["s"]["id"]);
        $this->Event->signout($_SESSION["s"]["id"]);
        $this->Event_reserve->signout($_SESSION["s"]["id"]);
        $this->Faq->signout($_SESSION["s"]["id"]);
        $this->Follow->signout($_SESSION["s"]["id"]);
        $this->Office_hours->signout($_SESSION["s"]["id"]);
        $this->Office_mento->signout($_SESSION["s"]["id"]);
        $this->Office_hours_apply->signout($_SESSION["s"]["id"]);
        $this->Recruit->signout($_SESSION["s"]["id"]);
        $this->Space_reserve->signout($_SESSION["s"]["id"]);
        $this->Startup_member->signout($_SESSION["s"]["id"]);

        unset($_SESSION["s"]);
        header("Location: /");
    }

    public function find_id()
    {
        if ($_SESSION["s"]) {
            header("Location: /member/".$_SESSION["s"]["ids"]);
        }
    }
    
    public function find_pwd()
    {
        if ($_SESSION["s"]) {
            header("Location: /member/".$_SESSION["s"]["ids"]);
        }
    }
    
    public function e_check()
    {
        $res = $this->Members->get_by_key($_REQUEST["id"], $_REQUEST["confirm_key"]);
        if ($res) {
            $_SESSION['s'] = $res;
            $this->assigns["res"] = $res['id'];
        }
        else {
            $this->assigns["res"] = 0;
        }
        
    }
}
?>
