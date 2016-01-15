<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Admin_program extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "admin";
    var $use_models = array("Program", "Startup_member", "Program_form", "Program_file"
            , "Program_apply", "Startup_service", "Members", "Banner");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "program";
        $this->assigns_layout["gnb_title"] = "Benefits 관리";
        $this->assigns_layout["top_js"] = "program";
        if (($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1){
            header("Location: /login");
        }
        $this->assigns_layout["s"] = $_SESSION["s"];
        $this->assigns["s"] = $_SESSION["s"];
    }

    public function index($_status = '0', $_page = 1)
    {
        $this->assigns_layout["gnb_left"] = 'program';
        $pagesize = 10;
        
        $where = "1";
        if ($_status != '99') $where = $where." and c.status = ".$_status; 
        if ($_REQUEST["search"]) $where = $where." and (title like '%".$_REQUEST["search"]."%' or content like '%".$_REQUEST["search"]."%' or name like '%".$_REQUEST["search"]."%' or category like '%".$_REQUEST["search"]."%')";
        

        if (!$_REQUEST["order"]) $_REQUEST["order"] = "ASC";  
        if ($_REQUEST["order"] == "ASC") $order= 'a_start = "" ASC, a_start ASC';
        else if ($_REQUEST["order"] == "DESC") $order= 'a_start = "" ASC, a_start DESC';

        $res = $this->Program->get_list($_page, $pagesize, $where, $order);
        $res_cnt = $this->Program->get_list_cnt($where);

        $this->assigns["res"] = $res;
        $this->assigns["cat"] = $this->Program->get_category();
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);
        $this->assigns["status"] = $_status;
        $this->assigns["order"] = $_REQUEST["order"];
        $this->assigns["search"] = $_REQUEST["search"];
        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }        

    public function edit($_id = '')
    {
        $this->assigns_layout["gnb_left"] = 'program';

        if ($_REQUEST["title"]) {
            if ($_REQUEST["a_start"]) {
                $_REQUEST["a_start"] = $_REQUEST["a_start_d"]." ".$_REQUEST["a_start_t"];
                $_REQUEST["a_end"] = $_REQUEST["a_end_d"]." ".$_REQUEST["a_end_t"];
            }
            else {
                $_REQUEST["a_start"] = '';
                $_REQUEST["a_end"] = '';
            }
            if ($_REQUEST["cnt_c"] == 0) $_REQUEST["cnt"] = 0;
            if ($_REQUEST["status"] != 2) $_REQUEST["status_des"] = "";
            $_id = $this->Program->add($_REQUEST);

            if ($_REQUEST["img"]) {
                $img_temp_name = str_replace(" ","",$_REQUEST['img']);

                $ck = substr($img_temp_name, 0, 1);
                if($ck=='/'){
                    $img_temp_name = substr($img_temp_name, 1, strlen($img_temp_name) -1 );
                }

                $file_ext = explode('.',$img_temp_name);
                $file_ext = '.'.$file_ext[sizeof($file_ext)-1];

                $original_file = $this->settings->root_path.$img_temp_name;
                $copy_file = $this->settings->root_path.'media/program/'.$_id.$file_ext;
                
                GD2_make_thumb_x(300, "", $original_file);

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/program/'.$_id.$file_ext;
                $this->Program->add_picture($_id, $_pic);
            }
            
            if ($_REQUEST["del_file"]) {
                $this->Program->add_file($_id, '');
                unlink('media/program/'.$_REQUEST["del_file"]);
            }
            
            if ($_FILES["file"]["name"]) {
                $file = make_upload("/media/program/", "file");
                if ($file) $this->Program->add_file($_id, $file, str_replace(" ", "_", $_FILES["file"]["name"]));
            }

            if (($_REQUEST["o_status"] != $_REQUEST["status"]) && ($_REQUEST["status"] != 0)) {
                $_st = "승인";
                if ($_REQUEST["status"] == 2) $_st = "반려";
                $ev = $this->Program->get_list('', '', "c.id = ".$_id);
                $_ev = $ev[0];
                $m = new TF_mailer($this->settings);
                $m->mailto = $_ev["memail"];
                $m->subject = "[D.CAMP] ".$_ev["name"]."님의 스타트업 지원 프로그램이 ".$_st."되었습니다.";
                $m->tpl_name = "program_accept";
                $m->assigns["res"] = $_ev;
                $m->assigns["main_service_url"] = $this->globals->my_host;
                $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                $m->send();
            }

            $this->assigns["msgt"] = 1;
        }

        if ($_id)
        {
            $res = $this->Program->get($_id);
            $u = $this->Members->get($res["user_id"]);
            $u["com"] = $this->Startup_member->get_by_user($res["user_id"]);
            if (! $res) 
                header("Location: /error_404");

            $this->assigns["res"] = $res;
            $this->assigns["u"] = $u;
        }
        $this->assigns["category"] = $this->Program->get_category();
    }

    public function apply_info($_id = '')
    {
        $this->assigns_layout["gnb_left"] = 'program';

        if (!$_id) header("Location: /error_404");
        
        $res = $this->Program->get($_id);
        $forms = $this->Program_form->get_by_comp($_id);
        for ($i=0; $i<sizeof($forms); $i++) {
            if ($forms[$i]["type"] == 'query') {
                $forms[$i]["opts"] = explode(",", $forms[$i]["opt"]);
            }
        }
        $res["forms"] = $forms;
        $res["form_file"] = $this->Program_file->get_by_comp($_id);

        $this->assigns["res"] = $res;

        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }

        if ($_SESSION["msgt"]) {
            $this->assigns["msgt"] = 1;
            unset($_SESSION["msgt"]);
        }
    }

    public function applied_list($_id, $_page = 1)
    {
        $this->assigns_layout["gnb_left"] = 'program';
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }
        if (!$_id) header("Location: /error_404");

        $pagesize = 10;
        $sort = $_REQUEST["sort"];
        if (!$sort) $sort = 1;
        $res = $this->Program->get($_id);
        $where = "ca.program_id = ".$_id;
        $list = $this->Program_apply->list_out($_page, $pagesize, $where, "");

        for ($i=0; $i<sizeof($list); $i++) {
            $u = $this->Members->get($list[$i]["user_id"]);
            $list[$i]["ids"] = $u["ids"];
            $list[$i]["name"] = $u["name"];
            $list[$i]["memail"] = $u["email"];
            $list[$i]["bio"] = $u["bio"];
            $list[$i]["picture"] = $u["picture"];
        }

        // dashboard
        $_sDate = str_replace(".", "-", substr($res["a_start"], 0, 10));
        $_eDate = str_replace(".", "-", substr($res["a_end"], 0, 10));
        if ($_eDate > date("Y-m-d")) $_eDate = date("Y-m-d");
        $term = dateDiff($_eDate, $_sDate, "-");
        // echo $term;
        for ($d=0; $d<$term+1; $d++) {
            $day = date("Y-m-d", strtotime("+$d day", strtotime($_sDate))); 
            $d_list[$d]["day"] = str_replace("-", ".", $day);
            $d_list[$d]["all"] = $this->Program_apply->cnt_out("ca.date_created like '".$day."%' and ca.program_id = ".$_id);
        }

        $this->assigns["d_list"] = array_reverse($d_list);
        $this->assigns["alig"] = $_REQUEST["alig"];
        $list_cnt = $this->Program_apply->cnt_out($where);
        $this->assigns["res"] = $res;
        $this->assigns["list"] = $list;
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["list_cnt"] = $list_cnt;
        $this->assigns["list_cnt_reject"] = $this->Program_apply->cnt_out("ca.status = 2 and ca.program_id = ".$_id);
        $this->assigns["paging"] = get_paging_dot2($_page, $list_cnt, $pagesize);
        $this->assigns["sort"] = abs($sort);
        $this->assigns["tab"] = $_REQUEST["tab"];
        $this->assigns["m_list"] = $this->Program->get_list(1, 5, "c.user_id = ".$_SESSION["s"]["id"]);
        $this->assigns["a_list"] = $this->Program_apply->list_all(1, 5, "ca.user_id = ".$_SESSION["s"]["id"]);

        // if ($_SESSION["s"]["id"] != $res["user_id"]) 
        //     header("Location: /error_404");
    }

    public function applied_view($_id)
    {
        $this->assigns_layout["gnb_left"] = 'program';

        if (!$_id) header("Location: /error_404");

        $per = $this->Program_apply->get($_id);
        $per["com"] = $this->Startup_member->get_by_user($per["user_id"]);
        $res = $this->Program->get($per["program_id"]);

        $file = $this->Program_file->get_by_comp($res["id"]);
        if ($file) {
            for ($j=0; $j<sizeof($file); $j++) {
                $f = $this->Program_file->get_by_file_user_res($file[$j]["id"], $_id);
                $file[$j]["val"] = $f["file"];
                $file[$j]["fid"] = $file[$j]["id"];
            }
        }
        $forms = $this->Program_form->get_by_comp($res["id"]);
        if ($forms) {
            for ($f=0; $f<sizeof($forms); $f++) {
                if ($forms[$f]["type"] == "query") {
                    $forms[$f]["opts"] = explode(",", $forms[$f]["opt"]);
                }
                if ($per["id"]) {
                    $fr = $this->Program_form->get_by_form_user($forms[$f]["id"], $_id);
                    $forms[$f]["ress"] = $fr["res"];
                }
            }
        }
        $res["form_file"] = $file;
        $res["forms"] = $forms;
        
        $this->assigns["res"] = $res;
        $this->assigns["per"] = $per;

        if($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
        $this->sub();
        
        // if ($_SESSION["s"]["id"] != $per["user_id"]  && $_SESSION["s"]["id"] != $res["user_id"] ) 
        //     header("Location: /error_404");
    }

    public function category()
    {
        $this->assigns_layout["gnb_left"] = "program_c";

        $this->assigns["res"] = $this->Program->get_category();
    }

    public function category_edit($_id = '')
    {
        $this->assigns_layout["gnb_left"] = "program_c";
        
        if ($_REQUEST["category"]) {
            $_id = $this->Program->add_category($_REQUEST);
            header("Location: /admin_program/category");
        }
        
        if ($_id) { 
            $this->assigns["res"] = $this->Program->get_category_one($_id);
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
                $copy_file = $this->settings->root_path.'media/banner/benefit_'.$_id.$file_ext;

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/banner/benefit_'.$_id.$file_ext;
                $this->Banner->add_picture('pic_1', $_pic, $_id);
            }
            $this->assigns["msg"] = "수정되었습니다.";
        }
        $this->assigns["res"] = $this->Banner->get_one(6);
        $this->assigns["res"]["pic_1"] = $this->assigns["res"]["pic_1"]."?".date("is");
    }

    private function sub()
    {
        $sub = $this->Program->get_list(1, 5, 'c.status = 1 and a_start <= "'. date('Y.m.d H:i').'" and a_end > "'. date('Y.m.d H:i').'"');
        $this->assigns["sub"] = $sub;
    }     
}
?>