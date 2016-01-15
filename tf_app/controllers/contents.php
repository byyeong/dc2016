<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Contents extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "default";
    var $use_models = array("Content", "Content_category", "Startup_member", "Banner");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "contents";
        $this->assigns_layout["gnb_title"] = "contents";
        $this->assigns_layout["con"] = get_contents_category();
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns_layout["s"] = $_SESSION["s"];
    }
    
    public function index($_id = 0)
    {
        $cat = $this->Content_category->get($_id);
        if ($_id)
            $res = $this->Content->list_(1, 10, 'c.en = 0 and c.state = 1 and c.hidden = 0 and cc.hidden = 0 and c.category_id ='.$_id);
        else {
            if ($_REQUEST["key"]) {
                $res = $this->Content->search($_REQUEST["key"], 'c.en = 0 and c.state = 1 and c.hidden = 0 and cc.hidden = 0', 1, 10);
            }
            else {
                $res = $this->Content->list_(1, 10, 'c.en = 0 and c.state = 1 and c.hidden = 0 and cc.hidden = 0');    
            }
            
        }
        $this->assigns["cat"] = $cat;
        $this->assigns["res"] = $res;
        $this->assigns["cid"] = $_id;
        
        $cat_list = $this->Content_category->list_('', '', 'hidden = 0');
        for ($i=0; $i<sizeof($cat_list); $i++) {
            $cat_list[$i]["cnt"] = $this->Content->cnt("c.en = 0 and c.state = 1 and c.hidden = 0 and category_id = ".$cat_list[$i]["id"]);
        }
        $this->assigns["cat_list"] = $cat_list;
        $this->assigns["hot_cont"] = $this->Content->list_(1, 5, 'c.en = 0 and c.state = 1 and c.hidden = 0', 'v_cnt DESC');
        $this->assigns["curr_cont"] = $this->Content->list_(1, 5, 'c.en = 0 and c.state = 1 and c.hidden = 0');
        $this->assigns["acnt"] = $this->Content->cnt("c.en = 0 and c.state = 1 and c.hidden = 0");
        $this->assigns["key"] = $_REQUEST["key"];
        if (! $_id)
            $this->assigns["banner"] = $this->Banner->get_one(7);
    }
        
    public function views($_id)
    {
        $res = $this->Content->get($_id);
        if ($res["state"] == 1 && $res["hidden"] == 0) {
            $this->Content->pageview($_id);
            $res["com"] = $this->Startup_member->get_by_user($res["user_id"]);
            $this->assigns["res"] = $res;
            
            $cat_list = $this->Content_category->list_('', '', 'hidden = 0');
            for ($i=0; $i<sizeof($cat_list); $i++) {
                $cat_list[$i]["cnt"] = $this->Content->cnt("c.state = 1 and c.hidden = 0 and category_id = ".$cat_list[$i]["id"]);
            }
            $this->assigns["cat_list"] = $cat_list;
            $this->assigns["curr_cont"] = $this->Content->list_(1, 5, 'c.state = 1 and c.hidden = 0');
            $this->assigns["hot_cont"] = $this->Content->list_(1, 5, 'c.en = 0 and c.state = 1 and c.hidden = 0', 'v_cnt DESC');
            
            $og["type"] = 'article';
            $og["url"] = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
            $og["title"] = $res["subject"]." on D.CAMP";
            $og["description"] = strip_tags($res["contents"]);
            if (strlen(strip_tags($res["contents"])) > 150) $og["description"] 
                    = mb_substr(strip_tags($res["contents"]), 0, 150, 'UTF-8').'...';
            if ($res["cpic"]) $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].$res["cpic"];
            if (!$res["cpic"]) $og["image"] = check_url($res["img"], '');
            $this->assigns_layout["og"] = $og;

            $this->assigns["acnt"] = $this->Content->cnt("c.state = 1 and c.hidden = 0");

            if (!strpos($_SERVER["HTTP_REFERER"], "dcamp.kr")) {
                $this->assigns_layout["cards"] = bottom_main();
            }
        }
        else header("Location: /error_404");
            
    }

    public function edit($_id = '')
    {
        if (!$_SESSION["s"]) header("Location: /404_error");
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

            header("Location: /member/edit_contents");
        }
        
        $this->assigns["cate"] = $this->Content_category->get_cat_by_user($_SESSION["s"]["id"], 'cc.hidden = 0');
        
        if ($_id) {
            $res = $this->Content->get($_id);
            if ($res["user_id"] != $_SESSION["s"]["id"]) {
                $this->assigns["cate"] = null;
            } else { 
                $this->assigns["res"] = $res;
            }
        }
    }
}
?>
