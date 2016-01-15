<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * 
 * violet@userstorylab.com
 */

class Admin_notice extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "admin";
    var $use_models = array("Notice");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "notice";
        $this->assigns_layout["gnb_title"] = "공지사항";
        if (($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1){
            header("Location: /login");
        }
        $this->assigns_layout["s"] = $_SESSION["s"];
        $this->assigns["s"] = $_SESSION["s"];
    }

    public function index($_page = 1)
    {
        $this->assigns_layout["gnb_left"] = "notice";
        
        $pagesize = 10;
        $res = $this->Notice->list_($_page, $pagesize);
        $res_cnt = $this->Notice->cnt();
        $this->assigns["res"] = $res;
        $this->assigns["page"] = $_page;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);
    }

    public function add($_id = '')
    {
//        echo $this->settings->root_path;
        $this->assigns_layout["gnb_left"] = "add";
        
        if ($_REQUEST["title"]) {
            if ($_REQUEST["writer_type"] == 1) {
                $_REQUEST["writer"] = $_SESSION["s"]["name"];
            }
            if ($_REQUEST["contents"]) {
                 $_REQUEST["contents"] = str_replace('"../../', '"'.'/', $_REQUEST["contents"]);
                 $_REQUEST["contents"] = str_replace('"../', '"'.'/', $_REQUEST["contents"]);
            }

            $_id = $this->Notice->add($_REQUEST);
            
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
                $copy_file = $this->settings->root_path.'media/news/'.$_id.$file_ext;

                GD2_make_thumb_x(300, "", $original_file);
                
                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/news/'.$_id.$file_ext;
                $this->Notice->add_picture($_id, $_pic);
            }
            header("Location: /admin_notice");
        }
        
        
        
        if ($_id) {
            $this->assigns["res"] = $this->Notice->get($_id);
        }
    }

}
?>
