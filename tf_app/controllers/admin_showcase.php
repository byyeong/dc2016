<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * 
 * violet@userstorylab.com
 */

class Admin_showcase extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "admin";
    var $use_models = array("Startup", "Startup_member", "Startup_service", "Code", "Members"
            , "Banner");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "showcase";
        $this->assigns_layout["gnb_title"] = "Showcase 관리";
        if (($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1){
            header("Location: /login");
        }
        $this->assigns_layout["s"] = $_SESSION["s"];
        $this->assigns["s"] = $_SESSION["s"];
    }

    public function index($_page = 1)
    {
        $this->assigns_layout["gnb_left"] = "bz";
        $pagesize = 10;
        
        $where = 'user_id_bz IS NOT NULL';
        $order = 'id DESC';
        if (!array_key_exists("order", $_REQUEST)) $_REQUEST["order"] = 99;
        if ($_REQUEST["sort"] && $_REQUEST["sort"] != 'status_bz') 
            $order = $_REQUEST["sort"]." ".$_REQUEST["order"];
        if ($_REQUEST["sort"] && $_REQUEST["sort"] == 'status_bz')
            if ($_REQUEST["order"] != 99) $where = $where." and status_bz = ".$_REQUEST["order"];
        if ($_REQUEST["search"])
            $where = $where." and (name like '%".$_REQUEST["search"]."%' or des_ele like '%".$_REQUEST["search"]."%'"
                ." or startup_name like '%".$_REQUEST["search"]."%')";

        $res = $this->Startup_service->list_('', $where, $order, $_page, $pagesize);
        for ($i=0; $i<sizeof($res); $i++) {
            $res[$i]["u"] = $this->Members->get($res[$i]["user_id_bz"]);
            if ($res[$i]["startup_id"]) 
                $res[$i]["c"] = $this->Startup->get($res[$i]["startup_id"]);
        }
        
        $res_cnt = $this->Startup_service->cnt($where);

        $this->assigns["res"] = $res;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["sort"] = $_REQUEST["sort"];
        $this->assigns["order"] = $_REQUEST["order"];
        $this->assigns["search"] = $_REQUEST["search"];
    }

    public function views($_id = '')
    {
        $this->assigns_layout["gnb_left"] = "bz";

        if ($_REQUEST["id"]) {
            $this->Startup_service->edit_status($_REQUEST);
            $this->assigns["msg"] = "저장되었습니다.";
        }

        $res = $this->Startup_service->get($_id);
        $dates = $this->Startup_service->get_last_date($_id);
        $res["date"] = $dates["date"];
        $res["dates"] = $this->Startup_service->get_dates($_id, 1);
        $res["type"] = $dates["type"];
        $res["cats"] = $this->Startup_service->get_category($_id);
        $res["s"] = $this->Startup->get($res["startup_id"]);
        $res["art"] = $this->Startup_service->get_article($_id);

        $this->assigns["res"] = $res;
        $this->assigns["today"] = date("Y.m.d");
    }
    
    public function cat_index()
    {
        $this->assigns_layout["gnb_left"] = "bz_cat";

        $res = $this->Code->get_by_key("bz_market", "", "", "_value ASC");

        $this->assigns["res"] = $res;
    }

    public function cat_edit($_id = '')
    {
        $this->assigns_layout["gnb_left"] = "bz_cat";

        if ($_REQUEST["_key"]) {
            $this->Code->add($_REQUEST);
            header("Location: /admin_showcase/cat_index");
        }

        if ($_id) {
            $res = $this->Code->get($_id);
            $this->assigns["res"] = $res;
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
                $copy_file = $this->settings->root_path.'media/banner/betazone_'.$_id.$file_ext;

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/banner/betazone_'.$_id.$file_ext;
                $this->Banner->add_picture('pic_1', $_pic, $_id);
            }
            $this->assigns["msg"] = "수정되었습니다.";
        }
        $this->assigns["res"] = $this->Banner->get_one(4);
        $this->assigns["res"]["pic_1"] = $this->assigns["res"]["pic_1"]."?".date("is");
    }
}
?>
