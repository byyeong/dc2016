<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Startup extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "default";
    var $use_models = array("Startup", "Startup_bussiness", "Startup_tech", "Startup_member"
            , "Recruit","Recruit_opt", "Local", "Code", "Follow", "Members", "Startup_investment"
            , "Startup_service", "Activity", "Startup_reference", "Startup_incubating", "Board");

    public function before_calling()
    {
//        $this->assigns_layout["gnb"] = "event";
//        $this->assigns_layout["gnb_title"] = "이벤트 관리";
        $this->assigns_layout["con"] = get_contents_category();
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns_layout["s"] = $_SESSION["s"];
    }
    
    public function index($_id = '')
    {
        if (!$_id) {
            header("Location: /");
        }
        $this->layout = "profile";
        // $this->tpl_name = "index_2014";
        $res = $this->Startup->get($_id);
        
        if ($res && $res["state"] < 2) {
            $edi = $this->Startup_member->get_first($_id, $_SESSION["s"]["id"], 'is_ing = 1');
            $this->assigns["edi"] = $edi;
            $this->assigns["res"] = $res;
            $p_bis = $this->Startup_bussiness->get_by_member_c($_id);
            $p_tech = $this->Startup_tech->get_by_member_c($_id);
            $this->assigns["bis"] = $p_bis;
            $this->assigns["tech"] = $p_tech;
            $this->assigns["users"] = $this->Startup_member->get_by_startup($_id, 1, "is_ing = 1");
            $this->assigns["users_req"] = $this->Startup_member->get_by_startup_req($_id, "state = 0");
            $this->assigns["follow"] = $this->Follow->check_follow($_SESSION["s"]["id"], $res["id"], 2);
            
            $ser = $this->Startup_service->list_($_id);
            $this->assigns["ser_c"] = sizeof($ser);
            if ($res["stype"] == 1) {
                $inv = $this->Startup_investment->list_($_id);
                $this->assigns["inv_c"] = sizeof($inv);
                $inc = $this->Startup_incubating->list_($_id);
                $this->assigns["inc_c"] = sizeof($inc);
            }
            if ($_SESSION["s"] && $edi) {
                if (!$_COOKIE["progress_".$res["id"]."_".$_SESSION["s"]["id"]]) {
                    $point = 0;
                    if ($res["name"]) $point++;
                    if ($res["description"]) $point++;
                    if ($res["bio"]) $point++;
                    if ($res["logo"]) $point++;
                    if ($res["founded"]) $point++;
                    if ($res["number"]) $point++;
                    if ($res["website"]) $point++;
                    if ($res["email"]) $point++;
                    if ($res["addr"]) $point++;
                    if ($res["tel"]) $point++;
                    if (sizeof($p_bis) > 0) $point++;
                    if (sizeof($p_tech) > 0) $point++;

                    for($ss=0; $ss<sizeof($ser); $ss++) {
                        if ($ser[$ss]["name"]) $_s_name = 1;
                        if ($ser[$ss]["des_ele"]) $_s_pitch = 1;
                        if ($ser[$ss]["des_pro"]) $_s_pro = 1;
                        if ($ser[$ss]["des_sol"]) $_s_sol = 1;
                        if ($ser[$ss]["img1"] || $ser[$ss]["img2"] || $ser[$ss]["img3"] || $ser[$ss]["img4"] || 
                                $ser[$ss]["movie1"] || $ser[$ss]["movie2"] || $ser[$ss]["movie3"] || $ser[$ss]["movie4"] )
                            $_s_pic = 1;
                        if ($ser[$ss]["web_url"] || $ser[$ss]["and_url"] || $ser[$ss]["and_url"])
                            $_s_link = 1;
                    }

                    if ($_s_name) $point++;
                    if ($_s_pitch) $point++;
                    if ($_s_pro) $point++;
                    if ($_s_sol) $point++;
                    if ($_s_pic) $point++;
                    if ($_s_link) $point++;
                    $this->assigns["point"] = round($point / 18 * 100); 
                }
                else $this->assigns["point"] = 100;
            }

            $fl = $this->Follow->get_folling(2, $res["id"]);
            for($i=0; $i<sizeof($fl); $i++) {
                $re_fl[$i] = $this->Members->get($fl[$i]["follower"]); 
            }

            $this->assigns["fl"] = $re_fl;

            $jobs = $this->Recruit->cnt('', "start <= '".date("Y.m.d")."' and end >= '".date("Y.m.d")."' and state = 1 and startup_id = ".$_id);
            $this->assigns["jobs"] = $jobs;
            
            $this->assigns["mem"] = $this->Startup_member->check_member($_id, $_SESSION["s"]["id"]);
            if ($_SESSION["msg"]) {
                $this->assigns_layout["msg"] = $_SESSION["msg"];
                unset($_SESSION["msg"]);
            }
            $og["type"] = 'profile';
            $og["url"] = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
            $og["title"] = $res["name"]." on D.CAMP";
            $og["description"] = $res["description"];
            if (strlen($res["description"]) > 148) $og["description"] = mb_substr($res["description"], 0, 148, 'UTF-8').'...';
            $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].$res["logo"];
            $this->assigns_layout["og"] = $og;
            
            $cur_act = $this->Activity->get_by_com(2, $res["id"], 1, 5, 'date_created DESC', 'act_id = '.$res["id"]);
            for ($k=0; $k<sizeof($cur_act); $k++) {
                if ($cur_act[$k]["msg"]) {
                    if ($cur_act[$k]["act_type"] == 1) {
                        $ow = $this->Members->get($cur_act[$k]["act_id"]);
                        $cur_act[$k]["ow_ids"] = $ow["ids"];
                        $cur_act[$k]["ow_picture"] = $ow["picture"];
                        $cur_act[$k]["ow_name"] = $ow["name"];
                    }
                    else if ($cur_act[$k]["act_type"] == 2){
                        $ow = $this->Startup->get($cur_act[$k]["act_id"]);
                        $cur_act[$k]["ow_id"] = $ow["id"];
                        $cur_act[$k]["ow_logo"] = $ow["logo"];
                        $cur_act[$k]["ow_name"] = $ow["name"];
                    }
                }
                else {
                    if ($cur_act[$k]["target_type"] == Activity_model::A_TYPE_EVENT) {
                        $cur_act[$k]["data"] = $this->Event->get($cur_act[$k]["target_id"]);
                        $cur_act[$k]["mem"] = $this->Members->get($cur_act[$k]["act_id"]);
                    }
                    else if ($cur_act[$k]["target_type"] == Activity_model::A_TYPE_SPACE) {
                        $cur_act[$k]["data"] = $this->Space_reserve->get_detail($cur_act[$k]["target_id"]);
                        $cur_act[$k]["mem"] = $this->Members->get($cur_act[$k]["act_id"]);
                    }
                }
            }
            $this->assigns["cur_act"] = $cur_act;
            
            // $ref = $_SESSION["s"]["email"];
            // $ref = $_REQUEST["ref"];
            // $this->assigns["ref"] = $this->Startup_reference->request_ref($res["id"], $ref);
            $tab = false;
            if ($_REQUEST["tab"]) {
                $tab = $_REQUEST["tab"];
                $this->assigns["tab"] = $tab;
            }
            
            $w1 = "user_id IN (SELECT user_id FROM startup_member WHERE startup_id = ".$res["id"]." AND STATUS = 1)";
            $this->assigns["up"] = $this->Board->list_(2, $res["id"], '', '', $w1);
            $this->assigns["con"] = "startup";
        }
        else {
            header("Location: /");
        }

        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }
    
    public function edit($_id)
    {
        if ( ! $this->Startup_member->get_first($_id, $_SESSION["s"]["id"])) {
            header("Location: /startup/" . $_id);
        }

        if ($_REQUEST["id"]) {
            if ($_REQUEST["name"] && $_REQUEST["bio"]) $_REQUEST["state"] = 1;
            $_id = $this->Startup->add($_REQUEST);

            $this->Startup_tech->delete_by_user($_REQUEST["id"]);
            $len_sk = $_REQUEST["cnt_sk"];
            for($j=1; $j<$len_sk+1; $j++) {
                $tmp = "skill_".$j;
                if (trim($_REQUEST[$tmp])) {
                    $val = $this->Code->get_value(trim($_REQUEST[$tmp]), 'jobs');
                    $this->Startup_tech->add_c($_id, $val['id']);
                }
            }
            $this->Startup_bussiness->delete_by_user($_REQUEST["id"]);
            $len_int = $_REQUEST["cnt_int"];
            for($k=1; $k<$len_int+1; $k++) {
                $tmp = "inter_".$k;
                if (trim($_REQUEST[$tmp])) {
                    $val = $this->Code->get_value(trim($_REQUEST[$tmp]), 'field');
                    $this->Startup_bussiness->add_c($_id, $val['id']);
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
            
            $mem = $this->Startup->get($_REQUEST["id"]);
            $m = "<a href='/startup/".$mem["id"]."'>".$mem["name"]."</a>님이 프로필 정보를 수정하였습니다.";
            add_activity(2, $mem["id"], 2, $mem["id"], "", $m);
        
            $_SESSION["msg"] = "수정되었습니다.";
            header("Location: /startup/".$_REQUEST["id"]);
            
        }
        $res = $this->Startup->get($_id);
        $this->assigns["res"] = $res;
        $this->assigns["res_sk"] = $this->Startup_tech->get_by_member_c($_id);
        $this->assigns["res_in"] = $this->Startup_bussiness->get_by_member_c($_id);
        
        $_key = 'field';
        $result = $this->Code->get_by_key($_key);
        $items = array();
        for ($i=0; $i<sizeof($result); $i++) {
            $result[$i]["value"] = $result[$i]["_value"];
            array_push($items, $result[$i]);
        }
        $_key2 = 'jobs';
        $result2 = $this->Code->get_by_key($_key2);
        $items2 = array();
        for ($j=0; $j<sizeof($result2); $j++) {
            $result2[$j]["value"] = $result2[$j]["_value"];
            array_push($items2, $result2[$j]);
        }
        $this->assigns["job"] =  json_encode($items2);
        $this->assigns["skill"] =  json_encode($items1);
    }
    
    public function test()
    {
//        $xml = simplexml_load_file('E:\workspace\dcamp_svn\tf_app\controllers\company_data.xml','SimpleXMLElement',LIBXML_NOCDATA); 
//        
//        foreach($xml->children() as $child)
//        {
//            $arr['is_rocket'] = 1;
//            $arr['description'] = $child->overview;
//            $arr['twitter'] = $child->twitter;
//            $arr['logo'] = "http://rocketpun.ch".$child->logo;
//            $arr['blog'] = $child->blog;
//            $arr['founded'] = str_replace("-",".",$child->found_date);
//            $arr['addr'] = $child->offices->item->address1 ." ".$child->offices->item->address2;
//            $arr['website'] = $child->homepage;
//            $arr['email'] = $child->email;
//            $arr['bio'] = $child->description;
//            $arr['tel'] = $child->phone;
//            $arr['name'] = $child->name;
//            $arr['number'] = $child->employees;
//            $arr['state'] = 1;
//            $_id = $this->Startup->add($arr);
//            
//            foreach($child->fundings->children() as $fundings)
//            {
//                $inv["startup_id"] = $_id;
//                $inv["date"] = str_replace("-",".",$fundings->date);
//                $inv["investor"] = $fundings->content;
//                $inv["investment"] = $fundings->raised;
//                $this->Startup_investment->add($inv["startup_id"], $inv["investor"], "",
//                            $inv["date"], $inv["investment"], "");
//            }
//            
//            foreach($child->products->children() as $products)
//            {
//                $pro["startup_id"] = $_id;
//                $pro["name"] = $products->name;
//                $pro["web_url"] = $products->product_url;
//                $pro["des_ele"] = $products->overview;
//                $pro["ios_url"] = $products->appstore_url;
//                $pro["and_url"] = $products->googleplay_url;
//                $this->Startup_service->add($pro);
//            }
//        }        
        
        $res = $this->Startup->test();
        for ($i=0; $i<sizeof($res); $i++)
        {
            $lo = explode(".", $res[$i]['logo']);
            $log = $lo[2];
            $logo = "/media/startup/".$res[$i]["id"].".".$log;
//            echo $logo;
            $this->Startup->test2($res[$i]["id"], $logo);
        }
        
        exit(1);
    }
}
?>
