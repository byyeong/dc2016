<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 *
 * violet@userstorylab.com
 */

class Admin_event extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "admin";
    var $use_models = array("Event", "Event_reserve", "Space", "Event_type", "Activity"
            , "Startup_member", "Books", "Banner");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "event";
        $this->assigns_layout["gnb_title"] = "이벤트 관리";
        if (($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1){
            header("Location: /login");
        }
        $this->assigns_layout["s"] = $_SESSION["s"];
        $this->assigns["s"] = $_SESSION["s"];
    }
    
    public function index($_page = 1)
    {
        $this->assigns_layout["gnb_left"] = "event";
        
        $pagesize = 10;
        $where = '';
        if  (!$_REQUEST["sort"])  {
            $_REQUEST["sort"] = "state";
            $_REQUEST["order"] = 0;
        }
        $where = "e.".$_REQUEST["sort"]."=".$_REQUEST["order"];
        if ($_REQUEST['order'] == 99) {
            $where = '';
        }
        if ($_REQUEST["search"]) {
            if  ($where != '') $where = $where . " and ";
            $where = $where.'(title like "%'.$_REQUEST["search"].'%" or contents like "%'.$_REQUEST["search"].'%"
                     or m.name like "%'.$_REQUEST["search"].'%" or s.name like "%'.$_REQUEST["search"].'%"
                     or e.space_etc like "%'.$_REQUEST["search"].'%")';
        }
        $order = 'e.date DESC';
        if ($_REQUEST["order_e"]) $order = "ss ".$_REQUEST["order_e"];
        $res = $this->Event->list_($_page, $pagesize, $where, '', $order);
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            if ($res[$i]["state"] == 1) {
                $tmp_s = $res[$i]["date"]. " ".$res[$i]["start"];
                $tmp_e = $res[$i]["date"]. " ".$res[$i]["end"];
                $tmp_c = date("Y-m-d H:i");
                if ($tmp_c > $tmp_e)
                    $res[$i]["state_expand"] = "end";
                else if ($tmp_c > $tmp_s && $tmp_c < $tmp_e)
                    $res[$i]["state_expand"] = "ing";
                else
                    $res[$i]["state_expand"] = "before";
            }
        }
        $res_cnt = $this->Event->cnt_($where);
        $this->assigns["res"] = $res;
        $this->assigns["page"] = $_page;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);
        $this->assigns["search"] = $_REQUEST["search"];
        $this->assigns["order"] = $_REQUEST["order"];
        $this->assigns["sort"] = $_REQUEST["sort"];
        $this->assigns["order_t"] = $_REQUEST["order_t"];
        $this->assigns["order_e"] = 'DESC';
        if ($_REQUEST["order_e"] )$this->assigns["order_e"] = $_REQUEST["order_e"];
    }
    
    public function approve($_id)
    {
        $this->assigns_layout["gnb_left"] = "event";
        
        if ($_REQUEST["id"]) {
            $this->Event->edit($_REQUEST);
            
            if ($_REQUEST["state"] > 0) {
                $ev = $this->Event->get_detail($_REQUEST["id"]);
                
                $arr["act_type"] = Activity_model::C_TYPE_MEMBER;
                $arr["act_id"] = $ev["user_id"];
                $arr["target_type"] = Activity_model::A_TYPE_EVENT;
                $arr["target_id"] = $ev["id"];
                $arr["is_made"] = 1;
                $arr["act_result"] = $_REQUEST["state"];
                $this->Activity->edit($arr);
                
                if ($ev["state"] == 2 && date("Y.m.d")>$ev["date"]) {}
                else {
                    $st = "승인";
                    if ($ev["state"] == 2) $st = "반려";
                    $m = new TF_mailer($this->settings);
                    $m->mailto = $ev["memail"];
                    $m->subject = "[D.CAMP] ".$ev["mname"]."님의 이벤트가 ".$st."되었습니다.";
                    $m->tpl_name = "event_approve";
                    $m->assigns["res"] = $ev;
                    $m->assigns["main_service_url"] = $this->globals->my_host;
                    $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                    $m->send();
                }
            }
            
            $this->assigns["msg"] = "수정되었습니다.";
        }
        $this->assigns["res"] = $this->Event->get_detail($_id);
    }
    
    public function info($_id)
    {
        $this->assigns_layout["gnb_left"] = "event";
        
        $this->assigns["res"] = $this->Event->get_detail($_id);
    }
    
    public function add($_id = '')
    {
        $this->assigns_layout["gnb_left"] = "add";
        
        $this->assigns["space"] = $this->Space->list_(1,1000, $order="visible = 1");
        $this->assigns["type"] = $this->Event_type->list_(1,1000, $order="visible = 1");
        
        if ($_id) {
            $this->assigns["res"] = $this->Event->get_detail($_id);
        }

    }
    
    public function add_process()
    {
            
        $payment = 0;
        if(array_key_exists('payment1',$_REQUEST)) $payment = $payment | $this->settings->payment1;
        else $payment = $payment & (~$this->settings->payment1);
        if(array_key_exists('payment2',$_REQUEST)) $payment = $payment | $this->settings->payment2;
        else $payment = $payment & (~$this->settings->payment2);
        if(array_key_exists('payment3',$_REQUEST)) $payment = $payment | $this->settings->payment3;
        else $payment = $payment & (~$this->settings->payment3);
        if(array_key_exists('payment4',$_REQUEST)) $payment = $payment | $this->settings->payment4;
        else $payment = $payment & (~$this->settings->payment4);
        $_REQUEST['payment'] = $payment;
        if ($_REQUEST["space"] == 0) {
            $_REQUEST["space_id"] = 0;
        }
        else {
            $_REQUEST["space_etc"] = null;
        }

        $_id = $this->Event->add($_REQUEST);

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
            $copy_file = $this->settings->root_path.'media/event/'.$_id.$file_ext;
            
            GD2_make_thumb_x(300, "", $original_file);

            //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
            copy($original_file, $copy_file);
            unlink($original_file); 

            $_pic = '/media/event/'.$_id.$file_ext;
            $this->Event->add_picture($_id, $_pic);
        }

        if ($_REQUEST["del_file"]) {
            $this->Event->add_file($_id, '');
            unlink('media/event_file/'.$_REQUEST["del_file"]);
        }
        if ($_FILES["file"]["name"]) {
            $file = make_upload("/media/event_file/", "file");
            if ($file) $this->Event->add_file($_id, $file, $_FILES["file"]["name"]);
        }

        // if ($_REQUEST["id"]) {
        //     $apply = $this->Event_reserve->cnt("event_id = ".$_REQUEST["id"]);
        //     if ($apply <= $_REQUEST["cnt"]) {
        //         $this->Event_reserve->edit_state_by_cnt($_REQUEST["id"], $_REQUEST["cnt"]);
        //     }
        // }
        
        header("Location: /admin_event");
    }

        public function type()
    {
        $this->assigns_layout["gnb_left"] = "type";

        $this->assigns["res"] = $this->Event_type->list_(1, 1000);
    }
    
    public function type_add($_id = '')
    {
        $this->assigns_layout["gnb_left"] = "type";
        
        if ($_REQUEST["name"]) {
            $_id = $this->Event_type->add($_REQUEST);
            header("Location: /admin_event/type");
        }
        
        if ($_id) { 
            $this->assigns["res"] = $this->Event_type->get($_id);
        }
    }
    
    public function calendar()
    {
        $this->assigns_layout["gnb_left"] = "calendar";
    }

    public function book()
    {
        $this->assigns_layout["gnb_left"] = "book";
        $this->assigns["res"] = $this->Books->list_();
    }

    public function book_add($_id = '')
    {
        $this->assigns_layout["gnb_left"] = "book";
        if ($_REQUEST["dates"]) {
            $_REQUEST["img"] = $_REQUEST["pic2"];
            $_REQUEST["mento_img"] = $_REQUEST["pic"];
            $_id = $this->Books->add($_REQUEST);
            // if ($_REQUEST["mento_img"]) GD2_make_thumb_x(64, "", $this->settings->root_path.substr($_REQUEST["mento_img"], 1));
            header("Location: /admin_event/book_add/".$_id);

        }

        if ($_id) {
            $res = $this->Books->get($_id);
        }

        if ($_REQUEST["del"]) {
            if ($res["img"]) unlink(substr($res["img"], 1));
            if ($res["mento_img"]) unlink(substr($res["mento_img"], 1));
            $this->Books->delete($_id);
            header("Location: /admin_event/book");
        }

        $this->assigns["res"] = $res;
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
                $copy_file = $this->settings->root_path.'media/banner/event_'.$_id.$file_ext;

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/banner/event_'.$_id.$file_ext;
                $this->Banner->add_picture('pic_1', $_pic, $_id);
            }
            $this->assigns["msg"] = "수정되었습니다.";
        }
        $this->assigns["res"] = $this->Banner->get_one(5);
        $this->assigns["res"]["pic_1"] = $this->assigns["res"]["pic_1"]."?".date("is");
    }
}
?>
