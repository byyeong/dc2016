<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * 
 * violet@userstorylab.com
 */

class Admin_contents extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "admin";
    var $use_models = array("Content", "Content_category", "Members", "Startup_member"
            , "Banner");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "contents";
        $this->assigns_layout["gnb_title"] = "Blog 관리";
        if (($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1){
            header("Location: /login");
        }
        $this->assigns_layout["s"] = $_SESSION["s"];
        $this->assigns["s"] = $_SESSION["s"];
    }

    public function index($_page = 1)
    {
        $this->assigns_layout["gnb_left"] = "contents";
        
        $pagesize = 10;
        if ($_REQUEST["sort"] && array_key_exists("order", $_REQUEST)) {
            $where = $_REQUEST["sort"]."=".$_REQUEST["order"];
            if ($_REQUEST['order'] == 99) $where = '';
        }
        $res = $this->Content->list_($_page, $pagesize, $where);
        $res_cnt = $this->Content->cnt($where);
        $this->assigns["res"] = $res;
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);  
        $this->assigns["order"] = $_REQUEST["order"];
    }

    public function edit($_id = '')
    {
        $this->assigns_layout["gnb_left"] = "contents";
        
        if ($_REQUEST["subject"]) {
            
            $content_parsed = parse_html($_REQUEST["contents"]);
            foreach ($content_parsed as $c)
            {
                if (strtolower(substr($c,0,4)) == "<img")
                {
                    $t = tag_barase($c);
                    if ($t["src"])
                    {
                        $_REQUEST["img"] = $t["src"];
                        break;
                    }
                }
            }
            
            $_id = $this->Content->add($_REQUEST);

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
                $copy_file = $this->settings->root_path.'media/contents/'.$_id.$file_ext;
                
                GD2_make_thumb_x(300, "", $original_file);

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/contents/'.$_id.$file_ext;
                $this->Content->add_picture($_id, $_pic);
            }
            header("Location: /admin_contents");
        }
        
        if ($_id) {
            $this->assigns["res"] = $this->Content->get($_id);
        }
        
        $this->assigns["cat"] = $this->Content_category->list_(1, 100);
    }
    
    public function category()
    {
        $this->assigns_layout["gnb_left"] = "category";
        $res = $this->Content_category->list_();
        for ($i=0; $i<sizeof($res); $i++) {
            $users = $this->Content_category->get_user_by_cat($res[$i]["id"]);
            $res[$i]["users"] = $users;
        }
        $this->assigns["res"] = $res;
    }

    public function category_info($_id = '')
    {
        $this->assigns_layout["gnb_left"] = "category";
        
        if ($_REQUEST["name"]) {
            $_id = $this->Content_category->add($_REQUEST);
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
                $copy_file = $this->settings->root_path.'media/contents/'.$_id.$file_ext;

                GD2_make_thumb_x(750, "", $original_file);

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/contents/'.$_id.$file_ext;
                $this->Content_category->add_picture($_id, $_pic);
            }
            $this->assigns["msg"] = "수정되었습니다.";
        }
        
        if ($_id) {
            $this->assigns["res"] = $this->Content_category->get($_id);
        }
    }
    
    public function category_edit($_id)
    {
        $this->assigns_layout["gnb_left"] = "category";
        
        if ($_REQUEST["q"]) {
            $res = $this->Members->search_by_entrancee($_REQUEST["q"]);
            for ($i=0; $i<sizeof($res); $i++) {
                $com = $this->Startup_member->get_by_user($res[$i]["id"]);
                $res[$i]["company"] = $com["name"];
            }
            $this->assigns["res"] = $res;
            $this->assigns["q"] = $_REQUEST["q"];
        }
        $this->assigns["cat"] = $_id;
        $res_alr = $this->Content_category->get_user_by_cat($_id);
        for ($j=0; $j<sizeof($res_alr); $j++) {
            $com = $this->Startup_member->get_by_user($res_alr[$j]["id"]);
            $res_alr[$j]["company"] = $com["name"];
            $res_alr[$j]["cnt"] = $this->Content->cnt("c.category_id = ".$_id.". and c.user_id = ".$res_alr[$j]["id"]);
            $res_alr[$j]["last_con"] = $this->Content->last_content($res_alr[$j]["id"], "category_id = ".$_id);
        }
        $this->assigns["res_alr"] = $res_alr;
    }

    public function edit_pic()
    {
        // $this->Banner->debug();
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
                $copy_file = $this->settings->root_path.'media/banner/blog_'.$_id.$file_ext;

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/banner/blog_'.$_id.$file_ext;
                $this->Banner->add_picture('pic_1', $_pic, $_id);
            }
            $this->assigns["msg"] = "수정되었습니다.";
        }
        $this->assigns["res"] = $this->Banner->get_one(7);
        $this->assigns["res"]["pic_1"] = $this->assigns["res"]["pic_1"]."?".date("is");
    }
}
?>
