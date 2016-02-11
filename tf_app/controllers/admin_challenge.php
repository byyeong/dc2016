<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 *
 * violet@userstorylab.com
 */

class Admin_challenge extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "admin";
    var $use_models = array("Competitions", "Competitions_score", "Competitions_examiner"
            , "Competitions_apply", "Startup_member", "Members", "Competitions_file"
            , "Competitions_form", "Banner");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "challenge";
        $this->assigns_layout["gnb_title"] = "Challenge 관리";
        if (($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1){
            header("Location: /login");
        }
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns_layout["s"] = $_SESSION["s"];
    }
    
    public function index($_page = 1)
    {
        $this->assigns_layout["gnb_left"] = "competition";
        $pagesize = 10;
        if (array_key_exists("order", $_REQUEST)) {
            if ($_REQUEST['order'] == 99) 
                $where = '';
            else if ($_REQUEST['order'] == 0)
                $where = "CONCAT(date_s, time_s) <= '".date('Y.m.dH:i')."' && CONCAT(date_e, time_e) > '".date('Y.m.dH:i')."'";
            else if ($_REQUEST['order'] == 1)
                $where = "CONCAT(date_s, time_s) > '".date('Y.m.dH:i')."'";
            else if ($_REQUEST['order'] == 2)
                $where = "CONCAT(date_e, time_e) < '".date('Y.m.dH:i')."'";
        }
        else {
            $_REQUEST["order"] = 99;
        }

        $res = $this->Competitions->get_list($_page, $pagesize, $where);
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) { 
            $res[$i]["cnt"] = $this->Competitions_apply->cnt('ca.competition_id = '.$res[$i]["id"]);
        }
        $res_cnt = $this->Competitions->cnt($where);
        
        $this->assigns["res"] = $res;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["order"] = $_REQUEST["order"];
    }

<<<<<<< HEAD
	public function index2($_page = 1)
=======
	public function index_master($_page = 1)
>>>>>>> master
    {
        $this->assigns_layout["gnb_left"] = "competition";
        $pagesize = 10;
        if (array_key_exists("order", $_REQUEST)) {
            if ($_REQUEST['order'] == 99) 
                $where = '';
            else if ($_REQUEST['order'] == 0)
                $where = "CONCAT(date_s, time_s) <= '".date('Y.m.dH:i')."' && CONCAT(date_e, time_e) > '".date('Y.m.dH:i')."'";
            else if ($_REQUEST['order'] == 1)
                $where = "CONCAT(date_s, time_s) > '".date('Y.m.dH:i')."'";
            else if ($_REQUEST['order'] == 2)
                $where = "CONCAT(date_e, time_e) < '".date('Y.m.dH:i')."'";
        }
        else {
            $_REQUEST["order"] = 99;
        }

        $res = $this->Competitions->get_list($_page, $pagesize, $where);
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) { 
            $res[$i]["cnt"] = $this->Competitions_apply->cnt('ca.competition_id = '.$res[$i]["id"]);
        }
        $res_cnt = $this->Competitions->cnt($where);
        
        $this->assigns["res"] = $res;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["order"] = $_REQUEST["order"];
    }

    public function edit($_id = '')
    {
        $this->assigns_layout["gnb_left"] = "competition";
        if ($_REQUEST["cancel"]) {
            
        }
        if ($_REQUEST["subject"]) {
            $_id = $this->Competitions->add($_REQUEST);
            
            if ($_REQUEST["pic"]) {
                $img_temp_name = str_replace(" ","",$_REQUEST['pic']);

                $ck = substr($img_temp_name, 0, 1);
                if($ck=='/'){
                    $img_temp_name = substr($img_temp_name, 1, strlen($img_temp_name) -1 );
                }

                $file_ext = explode('.',$img_temp_name);
                //$filename = basename($_FILES['file']['name']);
                $file_ext = '.'.$file_ext[sizeof($file_ext)-1];

                $original_file = $this->settings->root_path.$img_temp_name;
                $copy_file = $this->settings->root_path.'media/comp/'.$_id.$file_ext;

                GD2_make_thumb_x(300, "", $original_file);

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/comp/'.$_id.$file_ext;
                $this->Competitions->add_pic($_id, $_pic);
            }

            if ($_REQUEST["top_img"]) {
                $img_temp_name = str_replace(" ","",$_REQUEST['top_img']);

                $ck = substr($img_temp_name, 0, 1);
                if($ck=='/'){
                    $img_temp_name = substr($img_temp_name, 1, strlen($img_temp_name) -1 );
                }

                $file_ext = explode('.',$img_temp_name);
                //$filename = basename($_FILES['file']['name']);
                $file_ext = '.'.$file_ext[sizeof($file_ext)-1];

                $original_file = $this->settings->root_path.$img_temp_name;
                $copy_file = $this->settings->root_path.'media/comp/top_'.$_id.$file_ext;

                GD2_make_thumb_x(800, "", $original_file);

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/comp/top_'.$_id.$file_ext;
                $this->Competitions->add_pic($_id, $_pic, 'top_img');
            }

            // $this->Competitions->del_a_file($_id);
            for ($f=1; $f<$_REQUEST["f_cnt"]+1; $f++) {
                if ($_FILES["afile".$f]["name"]) {
                    $file = make_upload("/media/comp_file/", "afile".$f);
                    $this->Competitions->edit_a_file($_id, $file, $_FILES["afile".$f]["name"]);
                }
            }
            
            for ($d=1; $d<$_REQUEST["dpt_cnt"]+1; $d++) {
                if ($_REQUEST["dpt".$d]) {
                    if ($d == 1) {
                        $_d_arr["id"] = $_id;
                        $_d_arr["did"] = $_id;
                        $_d_arr["department"] = $_REQUEST["dpt".$d];
                        $this->Competitions->add($_d_arr);
                    }
                    else {
                        $_d_arr = $this->Competitions->get($_id);
                        $_d_arr["id"] = ""; 
                        $_d_arr["did"] = $_id;
                        $_d_arr["parent"] = $_id;
                        $_d_arr["url"] = '';
                        $_d_arr["open"] = '';
                        $_d_arr["department"] = $_REQUEST["dpt".$d];
                        $this->Competitions->add($_d_arr);
                    }
                }
            }
            $_SESSION["msgt"] = 1;

            if ($_REQUEST["status_o"] != $_REQUEST["status"] && $_REQUEST["status"] == 1) {
                // accept mail
                
                $us = $this->Members->get($_REQUEST["user_id"]);
                $res = $this->Competitions->get($_id);
                $m = new TF_mailer($this->settings);
                $m->mailto = $us["email"];
                $m->subject = "[D.CAMP] ".$us["name"]."님의 경진대회가 승인되었습니다.";
                $m->tpl_name = "competition_accept";
                $m->assigns["res"] = $res;
                $m->assigns["main_service_url"] = $this->globals->my_host;
                $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                $m->send();
            }
        }
        
        if ($_id) {
            $res = $this->Competitions->get($_id);
            $res["a_file"] = $this->Competitions->get_a_file($_id);
            $res["dpt_l"] = $this->Competitions->get_department_group($_id);
                        
            $this->assigns["res"] = $res;

            $this->get_process($res);
        }
    }

    public function edit_next($_id = '')
    {
        $this->assigns_layout["gnb_left"] = "competition";
        if ($_REQUEST["cancel"]) {
            
        }

        if ($_REQUEST["announce_d"]) {
            $_id = $this->Competitions->add($_REQUEST);
            
            if ($_REQUEST["pic"]) {
                $img_temp_name = str_replace(" ","",$_REQUEST['pic']);

                $ck = substr($img_temp_name, 0, 1);
                if($ck=='/'){
                    $img_temp_name = substr($img_temp_name, 1, strlen($img_temp_name) -1 );
                }

                $file_ext = explode('.',$img_temp_name);
                //$filename = basename($_FILES['file']['name']);
                $file_ext = '.'.$file_ext[sizeof($file_ext)-1];

                $original_file = $this->settings->root_path.$img_temp_name;
                $copy_file = $this->settings->root_path.'media/comp/'.$_id.$file_ext;

                GD2_make_thumb_x(300, "", $original_file);

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/comp/'.$_id.$file_ext;
                $this->Competitions->add_pic($_id, $_pic);
            }

            if ($_REQUEST["top_img"]) {
                $img_temp_name = str_replace(" ","",$_REQUEST['top_img']);

                $ck = substr($img_temp_name, 0, 1);
                if($ck=='/'){
                    $img_temp_name = substr($img_temp_name, 1, strlen($img_temp_name) -1 );
                }

                $file_ext = explode('.',$img_temp_name);
                //$filename = basename($_FILES['file']['name']);
                $file_ext = '.'.$file_ext[sizeof($file_ext)-1];

                $original_file = $this->settings->root_path.$img_temp_name;
                $copy_file = $this->settings->root_path.'media/comp/top_'.$_id.$file_ext;

                GD2_make_thumb_x(800, "", $original_file);

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/comp/top_'.$_id.$file_ext;
                $this->Competitions->add_pic($_id, $_pic, 'top_img');
            }

            // $this->Competitions->del_a_file($_id);
            for ($f=1; $f<$_REQUEST["f_cnt"]+1; $f++) {
                if ($_FILES["afile".$f]["name"]) {
                    $file = make_upload("/media/comp_file/", "afile".$f);
                    $this->Competitions->edit_a_file($_id, $file, $_FILES["afile".$f]["name"]);
                }
            }

            for ($d=2; $d<$_REQUEST["dpt_cnt"]+1; $d++) {
                if ($_REQUEST["dpt".$d]) {
                    
                    if ($d == 2) {
                        $_d_arr["id"] = $_id;
                        $_d_arr["did"] = $_id;
                        $_d_arr["department"] = $_REQUEST["dpt".$d];
                        $this->Competitions->add($_d_arr);
                    }
                    else {
                        $_d_arr = $this->Competitions->get($_id);
                        $_d_arr["id"] = ""; 
                        $_d_arr["did"] = $_id;
                        $_d_arr["parent"] = $_id;
                        $_d_arr["url"] = '';
                        $_d_arr["open"] = '';
                        $_d_arr["department"] = $_REQUEST["dpt".$d];
                        $this->Competitions->add($_d_arr);
                    }
                }
            }
                
            $this->assigns["msgt"] = 1;
        }
        
        if ($_id) {
            $res = $this->Competitions->get($_id);
            $res["a_file"] = $this->Competitions->get_a_file($_id);
            $res["dpt_l"] = $this->Competitions->get_department_group($_id);
            
            $this->assigns["res"] = $res;
            $this->get_process($res);
        }
    }

    public function apply_info($_id)
    {
        $this->assigns_layout["gnb_left"] = "competition";
        if (!$_id) header("Location: /error_404");

        // template add
        
        if ($_REQUEST["template"]) {
            $t = $this->Competitions->get($_REQUEST["template"]);
            if (! $t) {
                $_SESSION["msg"] = "적용할 수 없는 템플릿 입니다.";
                header("Location: /admin_challenge/apply_info/".$_id);
                exit(1);
            }
            $arr["basic"] = $t["basic"];
            $arr["id"] = $_id;
            $this->Competitions->add($arr);

            $this->Competitions_form->del_form($_id);
            $fo = $this->Competitions_form->get_by_comp($_REQUEST["template"]);
            for ($ff=0; $ff<sizeof($fo); $ff++) {
                $ar["competition_id"] = $_id;
                $ar["type"] = $fo[$ff]["type"];
                $ar["title"] = $fo[$ff]["title"];
                $ar["sub"] = $fo[$ff]["sub"];
                $ar["opt"] = $fo[$ff]["opt"];
                $ar["required"] = $fo[$ff]["required"];
                $this->Competitions_form->add($ar);
            }

            $this->Competitions_file->del_file($_id);
            $fi = $this->Competitions_file->get_by_comp($_REQUEST["template"]);
            for ($fff=0; $fff<sizeof($fi); $fff++) {
                $ar2["competition_id"] = $_id;
                $ar2["title"] = $fi[$fff]["title"];
                $ar2["sub"] = $fi[$fff]["sub"];
                $ar2["req"] = $fi[$fff]["req"];
                $this->Competitions_file->add($ar2);
            }
            header("Location: /admin_challenge/apply_info/".$_id);
        }
        
        $res = $this->Competitions->get($_id);
        $forms = $this->Competitions_form->get_by_comp($_id);
        for ($i=0; $i<sizeof($forms); $i++) {
            if ($forms[$i]["type"] == 'query') {
                $forms[$i]["opts"] = explode(",", $forms[$i]["opt"]);
            }
        }
        $res["forms"] = $forms;
        $res["form_file"] = $this->Competitions_file->get_by_comp($_id);
        $this->assigns["res"] = $res;
        $this->get_process($res);

        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }

        if ($_SESSION["msgt"]) {
            $this->assigns["msgt"] = 1;
            unset($_SESSION["msgt"]);
        }
    }
    
    public function score_info($_id)
    {
        $this->assigns_layout["gnb_left"] = "competition";
        if (!$_id) header("Location: /error_404");
        
        if ($_REQUEST["score"]) {
            $this->Competitions->add($_REQUEST);
            $this->assigns["msgt"] = 1;
        }
        $res = $this->Competitions->get($_id);
        $this->assigns["res"] = $res;

        $score = $this->Competitions_score->get_by_comp($_id);
        $this->assigns["score"] = $score;
        
        $this->get_process($res);
    }

    public function operator($_id = '')
    {
        $this->assigns_layout["gnb_left"] = "competition";
        if (!$_id) header("Location: /error_404");

        $list = $this->Competitions_examiner->operator_list($_id);
        for ($i=0; $i<sizeof($list); $i++) {
            $list[$i]["com"] = $this->Startup_member->get_by_user($list[$i]["user_id"]);
            $comp = $this->Competitions_examiner->operator_by_user($list[$i]["user_id"]);
            $last = sizeof($comp);
            if ($last) {    
                $lastt = $last - 1;
                $list[$i]["comp"] = $comp[$last-1]["subject"] . " - 외 ".$lastt."건";
                if ($last == 1) $list[$i]["comp"] = $comp[$last-1]["subject"];
            }
        }
        $this->assigns["list"] = $list;
        $res = $this->Competitions->get($_id);
        
        $this->assigns["res"] = $res;
        $this->get_process($res);

    }
    
    public function examiner($_id)
    {
        $this->assigns_layout["gnb_left"] = "competition";
        if (!$_id) header("Location: /error_404");
        $res = $this->Competitions->get($_id);
        $this->assigns["res"] = $res;
        $this->get_process($res);$this->assigns["res"] = $res;
    }
    
    public function winner($_id)
    {
        $this->assigns_layout["gnb_left"] = "competition";
        if (!$_id) header("Location: /error_404");
        
        if ($_REQUEST["winner"]) {
            $this->Competitions->add($_REQUEST);
            
            $res = $this->Competitions_apply->list_(1, 1000, "ca.win = 1 and ca.competition_id = ".$_id);
            for ($i=0; $i<sizeof($res); $i++) {

                //mailing
                $com = $this->Competitions->get($_REQUEST["id"]);
                $m = new TF_mailer($this->settings);
                $m->mailto = $res[$i]["memail"];
                $m->subject = "[D.CAMP] ".$res[$i]["name"]."님이 신청하신 경진대회의 수상자가 발표되었습니다.";
                $m->tpl_name = "competition_winner";
                $m->assigns["res"] = $com;
                $m->assigns["user"] = $res[$i];
                $m->assigns["main_service_url"] = $this->globals->my_host;
                $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                $m->send();
            }
                
        }
        $res = $this->Competitions->get($_id);
        $this->assigns["res"] = $res;
        $this->get_process($res);
    }

    private function get_process($res) 
    {
        $f = $this->Competitions_form->get_by_comp($res["id"]);
        $ff = $this->Competitions_file->get_by_comp($res["id"]);
        $sc = $this->Competitions_score->get_by_comp($res["id"]);
        $exn = $this->Competitions_examiner->get_by_comp($res["id"]);
        if (sizeof($exn)) $this->assigns["exn"] = true;
        $this->assigns["step"] = 1;
        if ($res["status"] == 1) {
            $this->assigns["step"] = 2;
            if ( ($f || $ff || $res.basic) && $sc) {
                $this->assigns["step"] = 3;
                if ($res["date_s"]." ".$res["time_s"] < date("Y.m.d H:i") && $res["date_e"]." ".$res["time_e"] > date("Y.m.d H:i")) {
                    $this->assigns["step"] = 4;
                }
                if ($res["date_e"]." ".$res["time_e"] < date("Y.m.d H:i")) {
                    $this->assigns["step"] = 5;
                    if ($res["announce_d"]." ".$res["announce_t"] < date("Y.m.d H:i") && $res["winner"]) {
                        $this->assigns["step"] = 6;
                    }
                }
            }
        }
        
        
        if ($f || $ff || $res.basic)
            $this->assigns["for"] = 1;

        $this->assigns["op"] = $this->Competitions_examiner->operator_list($res["id"]);
        $this->assigns["sco"] = $sc;
    }
    
    public function examiner_list($_page = 1)
    {
        $this->assigns_layout["gnb_left"] = "competition_pool";
        $pagesize = 10;
        $where = 'ce.public = 1';
        $res = $this->Competitions_examiner->list_outer($_page, $pagesize, $where);
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            $res[$i]["com"] = $this->Startup_member->get_by_user($res[$i]["user_id"]);
            $comp = $this->Competitions_examiner->get_by_user($res[$i]["user_id"], '', 1);
            $last = sizeof($comp);
            if ($last) {    
                $lastt = $last - 1;
                $res[$i]["comp"] = $comp[0]["subject"] . " - 외 ".$lastt."건";
                if ($last == 1) $res[$i]["comp"] = $comp[0]["subject"];
            }
        }
        $res_cnt = $this->Competitions_examiner->cnt_outer($where);
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize); 
        $this->assigns["res"] = $res;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        if($_SESSION["msg"]) {
            $this->assigns["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }
    
    public function examiner_add()
    {
        $this->assigns_layout["gnb_left"] = "competition_pool";
        
        if ($_REQUEST["ex_email"]) {
            $_email = explode(",", $_REQUEST["ex_email"]);
            if ($_email) {
                $len_email = sizeof($_email);
                for ($i=0; $i<$len_email; $i++) {
                    $_exn = $this->Members->get_by_email($_email[$i]);

                    $arr["user_id"] = $_exn["id"];
                    if (!$_exn) $arr["email"] = $_email[$i];
                    $arr["public"] = 1;
                    $check = $this->Competitions_examiner->check($arr);

                    if (!$check) {
                        $_id = $this->Competitions_examiner->add($arr);
                        
                        // mail, activity
                        if (email_valid($_email[$i])) {
                            $m = new TF_mailer($this->settings);
                            $m->mailto = $_email[$i];
                            $m->subject = "[D.CAMP] DCAMP에서 경진대회 심사위원단으로 초대하였습니다.";
                            $m->tpl_name = "competition_pool";
                            $m->assigns["id"] = $_id;
                            $m->assigns["e"] = $_email[$i];
                            $m->assigns["con"] = $_REQUEST["ex_con"];
                            $m->assigns["main_service_url"] = $this->globals->my_host;
                            $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                            $m->send();
                        }
                    }
                    else {
                        $_SESSION["msg"] = "이미 초대된 회원이 있습니다.";
                    }
                        
                }
                
            }
            header("Location: /admin_challenge/examiner_list");
        }   
    }

    public function edit_pic()
    {
        $this->assigns_layout["gnb_left"] = "pic";
        if ($_REQUEST["sid"]) {
            $_id = $this->Banner->add($_REQUEST);
            
            if ($_REQUEST["pic_1"]) {
                $img_temp_name = str_replace(" ","",$_REQUEST['pic_1']);

                $ck = substr($img_temp_name, 0, 1);
                if($ck=='/'){
                    $img_temp_name = substr($img_temp_name, 1, strlen($img_temp_name) -1 );
                }

                $file_ext = explode('.',$img_temp_name);
                //$filename = basename($_FILES['file']['name']);
                $file_ext = '.'.$file_ext[sizeof($file_ext)-1];

                $original_file = $this->settings->root_path.$img_temp_name;
                $copy_file = $this->settings->root_path.'media/banner/challenge_'.$_id.$file_ext;

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/banner/challenge_'.$_id.$file_ext;
                $this->Banner->add_picture('pic_1', $_pic, $_id);
            }
            $this->assigns["msg"] = "수정되었습니다.";
        }
        $this->assigns["res"] = $this->Banner->get_one(3);
        $this->assigns["res"]["pic_1"] = $this->assigns["res"]["pic_1"]."?".date("is");
    }

    public function get_source()
    {
        $this->tpl_name = "";
        
        $filename = trim($_REQUEST["file"]); 
        $file = "./media/comp_file/$filename"; 
        $file_size = filesize($file); 
        $filename = urlencode("$filename");

        // 접근경로 확인 
//        if (!eregi($_SERVER['HTTP_HOST'], $_SERVER['HTTP_REFERER'])) Error("외부에서는 다운로드 받으실수 없습니다."); 

        if(strstr($HTTP_USER_AGENT, "MSIE 5.5")) { 
        header("Content-Type: doesn/matter"); 
        Header("Content-Length: ".filesize("$file"));
        header("Content-Disposition: filename=$filename"); 
        header("Content-Transfer-Encoding: binary"); 
        header("Pragma: no-cache"); 
        header("Expires: 0"); 
        } else { 
        Header("Content-type: file/unknown"); 
        Header("Content-Disposition: attachment; filename=$filename"); 
        Header("Content-Transfer-Encoding: binary");
        Header("Content-Length: ".filesize($file));
        Header("Content-Description: PHP3 Generated Data"); 
        header("Pragma: no-cache"); 
        header("Expires: 0"); 
        } 

//        if( $ret == 1 ) Error("지정하신 파일이 없습니다."); 
//        if( $ret == 2 ) Error("접근불가능 파일입니다. 정상 접근 하시기 바랍니다."); 

        if (is_file("$file")) { 
        $fp = fopen("$file", "r"); 
        if (!fpassthru($fp)) 
        fclose($fp); 
        }
    }
            
}
?>