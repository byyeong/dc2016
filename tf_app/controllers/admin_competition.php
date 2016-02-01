<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 *
 * violet@userstorylab.com
 */

class Admin_competition extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "admin";
    var $use_models = array("Competitions", "Competitions_score", "Competitions_examiner"
            , "Competitions_apply", "Startup_member", "Members", "Competitions_file");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "competition";
        $this->assigns_layout["gnb_title"] = "경진대회 관리";
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

	public function index2($_page = 1)
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
        
//    public function views($_id)
//    {
//        $this->assigns_layout["gnb_left"] = "competition";
//        if (!$_id) header("Location: /error_404");
//        $res = $this->Competitions->get($_id);
//        $my = $this->Competitions_apply->get_by_user($_id, $_SESSION["s"]["id"]);
//        $sub = $this->Competitions->get_list(1, 10, 'date_s >= "'.date('Y.m.d').'"');
//        
//        $this->assigns["res"] = $res;
//        $this->assigns["my"] = $my;
//        $this->assigns["sub"] = $sub;
//            if ($_SESSION["msg"]) {
//                $this->assigns["msg"] = $_SESSION["msg"];
//                unset($_SESSION["msg"]);
//            }
//    }
//    
//    public function apply($_id, $_per = '')
//    {
//        $this->assigns_layout["gnb_left"] = "competition";
//        if (!$_id) header("Location: /error_404");
//
//        $res = $this->Competitions->get($_id);
//        $sub = $this->Competitions->get_list(1, 10, 'date_s >= "'.date('Y.m.d').'"');
//        if ($_REQUEST["user_id"]) {
//            if ($_FILES["file"]) {
//                $_REQUEST["file"] = make_upload("/media/comp_file/", "file");
//            }
//            $_per = $this->Competitions_apply->add($_REQUEST);
//            $_SESSION["msg"] = "경진 대회 참가 신청이 접수되었습니다.";
//        }
//        
//        if ($_per) {
//            $per = $this->Competitions_apply->get($_per);
//            $this->assigns["per"] = $per;
//        }
//        if ($_SESSION["msg"]) {
//            $this->assigns["msg"] = $_SESSION["msg"];
//            unset($_SESSION["msg"]);
//        }
//        $this->assigns["res"] = $res;
//        $this->assigns["sub"] = $sub;
//    }
//
//    public function applied_list($_id, $_page = 1)
//    {
//        $this->assigns_layout["gnb_left"] = "competition";
//        if (!$_id) header("Location: /error_404");
//        $pagesize = 10;
//        $res = $this->Competitions->get($_id);
//        $where = "ca.competition_id = ".$_id;
//
//        $list = $this->Competitions_apply->list_($_page, $pagesize, $where);
//        for ($i=0; $i<sizeof($list); $i++) {
//            $list[$i]["com"] = $this->Startup_member->get_by_user($list[$i]["user_id"]);
//        }
//        $list_cnt = $this->Competitions_apply->cnt($where);
//        $this->assigns["res"] = $res;
//        $this->assigns["list"] = $list;
//        $this->assigns["page"] = $_page;
//        $this->assigns["pagesize"] = $pagesize;
//        $this->assigns["list_cnt"] = $list_cnt;
//        $this->assigns["paging"] = get_paging_dot2($_page, $list_cnt, $pagesize);
//    }
//    
//    public function applied_view($_id)
//    {
//        $this->assigns_layout["gnb_left"] = "competition";
//        if (!$_id) header("Location: /error_404");
//        
//        $per = $this->Competitions_apply->get($_id);
//        $per["com"] = $this->Startup_member->get_by_user($per["user_id"]);
//        $res = $this->Competitions->get($per["competition_id"]);
//        
//        $this->assigns["res"] = $res;
//        $this->assigns["per"] = $per;
//    }

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
            
            if ($_FILES["source"]["name"]) {

                $file = make_upload("/media/comp_file/", "source");

                $this->Competitions->add_file($_id, $file, $_FILES["source"]["name"]);
            }
            $this->assigns["msg"] = "저장되었습니다.";
            
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
            $this->assigns["res"] = $res;
            $this->get_process($res);
        }
    }

    public function apply_info($_id)
    {
        $this->assigns_layout["gnb_left"] = "competition";
        if (!$_id) header("Location: /error_404");
        
        $res = $this->Competitions->get($_id);
        $res["form_file"] = $this->Competitions_file->get_by_comp($_id);
        $this->assigns["res"] = $res;
        $this->get_process($res);
    }
    
    public function score_info($_id)
    {
        $this->assigns_layout["gnb_left"] = "competition";
        if (!$_id) header("Location: /error_404");
        
        if ($_REQUEST["score"]) {
            $this->Competitions->add($_REQUEST);
        }
        $res = $this->Competitions->get($_id);
        $this->assigns["res"] = $res;

        $score = $this->Competitions_score->get_by_comp($_id);
        $this->assigns["score"] = $score;
        
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
        if ($_REQUEST["id"]) {
            $_REQUEST["winner"] = str_replace('"../../', '"'.'/', $_REQUEST["winner"]);
            $_REQUEST["winner"] = str_replace('"../', '"'.'/', $_REQUEST["winner"]);
            $this->Competitions->add($_REQUEST);
        }
        $res = $this->Competitions->get($_id);
        $this->assigns["res"] = $res;
        $this->get_process($res);
    }

    private function get_process($res) 
    {
        $exn = $this->Competitions_examiner->get_by_comp($res["id"]);
        if (sizeof($exn)) $this->assigns["exn"] = true;
        $this->assigns["step"] = 1;
        if ($res["status"] == 1) {
            $this->assigns["step"] = 2;
            if ($res["form"] && $res["score"] && sizeof($exn) > 0) $this->assigns["step"] = 3;
        }
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
            header("Location: /admin_competition/examiner_list");
        }   
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