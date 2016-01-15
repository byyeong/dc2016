<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Member extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "default_member";
    var $use_models = array("Members", "Member_local", "Member_skill", "Member_interist"
            , "Activity", "Event", "Space_reserve", "Startup", "Startup_member", "Member_ext"
            , "Follow", "Local", "Code", "Event", "Member_reference", "Member_market"
            , "Member_inv", "Startup_reference", "Event_reserve", "Content", "Competitions"
            , "Competitions_examiner", "Competitions_apply", "Competitions_scoring"
            , "Member_project", "Member_education", "Board", "Office_hours_apply"
            , "Office_hours", "Program", "Program_apply", "Startup_service", "Space", "Recruit");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "member";
        $this->assigns_layout["gnb_title"] = "회원정보관리";
        $this->assigns_layout["con"] = get_contents_category();
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns_layout["s"] = $_SESSION["s"];
        //신청내역 있는 항목만 노출시키기위해 작성한 것인데, 보류.
        /*$this->assigns_layout["event_reserve_cnt"] = $this->Event_reserve->cnt('user_id ='.$_SESSION["s"]["id"]);
        $this->assigns_layout["event_host_cnt"] = $this->Event->cnt('user_id ='.$_SESSION["s"]["id"]);
        $this->assigns_layout["space_reserve_cnt"] = $this->Space_reserve->cnt('user_id = '.$_SESSION["s"]["id"]);
        $this->assigns_layout["challenge_apply_cnt"] = $this->Competitions_apply->get_by_user_cnt($_SESSION["s"]["id"]);
        $this->assigns_layout["challenge_host_cnt"] = $this->Competitions->get_by_user_cnt($_SESSION["s"]["id"]);
        $this->assigns_layout["challenge_examiner_cnt"] = $this->Competitions_examiner->get_by_user_cnt($_SESSION["s"]["id"], "ce.status = 1");
        $this->assigns_layout["office_apply_cnt"] = $this->Office_hours_apply->cnt('', 'user_id = '.$_SESSION["s"]["id"]);
        $this->assigns_layout["benefit_apply_cnt"] = $this->Program->get_by_user_cnt($_SESSION["s"]["id"]);
        $this->assigns_layout["recruit_cnt"] = $this->Recruit->list_s_cnt('user_id ='.$_SESSION["s"]["id"]);
        $this->assigns_layout["referemce_cnt"] = $this->Activity->get_by_com_cnt(1, $_SESSION["s"]["id"], 'target_type = '.Activity_model::E_TYPE_REFERENCE);*/
    }
    
    public function index($_id = '')
    {
        if (!$_id) {
            header("Location: /");
        }
        $this->layout = "profile";
        
        $res = $this->Members->get_by_ids($_id);

        if ($res && $res["state"] == 1) {
            $this->assigns["res"] = $res;
            $this->assigns["tw"] = $this->Member_ext->get_by_user_id_type($res["id"], Member_ext_model::TWITTER_TYPE);
            $this->assigns["fb"] = $this->Member_ext->get_by_user_id_type($res["id"], Member_ext_model::FACEBOOK_TYPE);
            $p_skill = $this->Member_skill->get_by_member_c($res["id"]);
            $this->assigns["skill"] = $p_skill;
            if ($res["utype"] == 1) {
                $p_local = $this->Member_local->get_by_member($res["id"]);
                $p_inter = $this->Member_interist->get_by_member_c($res["id"]);
                $this->assigns["local"] = $p_local;
                $this->assigns["inter"] = $p_inter;
            } else if ($res["utype"] == 2) {
                $this->assigns["market"] = $this->Member_market->get_by_member_c($res["id"]);
                $this->assigns["invest"] = $this->Member_inv->get_by_member($res["id"]);
            }
            
            $this->assigns["follow"] = $this->Follow->check_follow($_SESSION["s"]["id"], $res["id"], 1);
            //$this->assigns["event"] = $this->Event->list_(1, 100, 'e.user_id ='.$res["id"].' and e.state < 9 and date_e >= "'.date('Y.m.d').'"');
            //$this->assigns["space"] = $this->Space_reserve->list_(1, 100, 'user_id = '.$res["id"].' and sr.state < 9 and date >= "'.date('Y.m.d').'"');

            $fl = $this->Follow->get_folling(1, $res["id"]);
            $fi = $this->Follow->get_follower('', $res["id"]);
            for($i=0; $i<sizeof($fl); $i++) {
                if ($fl[$i]["type"] == 1) {
                    $re_fl[$i] = $this->Members->get($fl[$i]["follower"]); 
                    $re_fl[$i]['type'] = 1;
                }
                else {
                    $re_fl[$i] = $this->Startup->get($fl[$i]["follower"]); 
                    $re_fl[$i]['type'] = 2;
                }
            }

            for($j=0; $j<sizeof($fi); $j++) {
                if ($fi[$j]["type"] == 1) {
                    $re_fi[$j] = $this->Members->get($fi[$j]["following"]); 
                    $re_fi[$j]['type'] = 1;
                }
                else {
                    $re_fi[$j] = $this->Startup->get($fi[$j]["following"]); 
                    $re_fi[$j]['type'] = 2;
                }
            }

            $this->assigns["fl"] = $re_fl;
            $this->assigns["fi"] = $re_fi;
            
            $og["type"] = 'profile';
            $og["url"] = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
            $og["title"] = $res["name"]." on D.CAMP";
            $og["description"] = $res["bio"];
            if (strlen($res["bio"]) > 150) $og["description"] = mb_substr($res["bio"], 0, 150, 'UTF-8').'...';
            $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].$res["picture"];
            $this->assigns_layout["og"] = $og;
            
            $cur_act = $this->Activity->get_by_com(1, $res["id"], 1, 10, 'date_created DESC', 'act_id = '.$res["id"]);
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
                    else if ($cur_act[$k]["target_type"] == Activity_model::E_TYPE_COMPETITION) {
                        $cur_act[$k]["data"] = $this->Competitions->get($cur_act[$k]["target_id"]);
                        $cur_act[$k]["mem"] = $this->Members->get($cur_act[$k]["act_id"]);
                    }
                    else if ($cur_act[$k]["target_type"] == Activity_model::O_TYPE_OFFICE_HOURS) {
                        $cur_act[$k]["res"] = $this->Office_hours->get($cur_act[$k]["target_id"]);
                        $cur_act[$k]["mem"] = $this->Members->get($cur_act[$k]["act_id"]);
                    }
                }
            }
            $this->assigns["cur_act"] = $cur_act;
            
            $flw_act = $this->Activity->get_by_com(1, $res["id"], 1, 5, 'date_created DESC', 'act_id != '.$res["id"]);
            for ($l=0; $l<sizeof($flw_act); $l++) {
                if ($flw_act[$l]["msg"]) {
                    if ($flw_act[$l]["act_type"] == 1) {
                        $ow = $this->Members->get($flw_act[$l]["act_id"]);
                        $flw_act[$l]["ow_ids"] = $ow["ids"];
                        $flw_act[$l]["ow_picture"] = $ow["picture"];
                        $flw_act[$l]["ow_name"] = $ow["name"];
                    }
                    else if ($flw_act[$l]["act_type"] == 2){
                        $ow = $this->Startup->get($flw_act[$l]["act_id"]);
                        $flw_act[$l]["ow_id"] = $ow["id"];
                        $flw_act[$l]["ow_logo"] = $ow["logo"];
                        $flw_act[$l]["ow_name"] = $ow["name"];
                    }
                }
                else {
                    if ($flw_act[$l]["target_type"] == Activity_model::A_TYPE_EVENT) {
                        $flw_act[$l]["data"] = $this->Event->get($flw_act[$l]["target_id"]);
                        $flw_act[$l]["mem"] = $this->Members->get($flw_act[$l]["act_id"]);
                    }
                    else if ($flw_act[$l]["target_type"] == Activity_model::A_TYPE_SPACE) {
                        $flw_act[$l]["data"] = $this->Space_reserve->get_detail($flw_act[$l]["target_id"]);
                        $flw_act[$l]["mem"] = $this->Members->get($flw_act[$l]["act_id"]);
                    }
                    else if ($flw_act[$l]["target_type"] == Activity_model::E_TYPE_COMPETITION) {
                        $flw_act[$l]["data"] = $this->Competitions->get($flw_act[$l]["target_id"]);
                        $flw_act[$l]["mem"] = $this->Members->get($flw_act[$l]["act_id"]);
                    }
                }
            }
            $this->assigns["flw_act"] = $flw_act;
            // $ref = $_SESSION["s"]["email"];
            // $this->assigns["ref"] = $this->Member_reference->request_ref($res["id"], $ref);
            $tab = false;
            if ($_REQUEST["tab"]) {
                $tab = $_REQUEST["tab"];
                $this->assigns["tab"] = $tab;
            }

            
            if ($_SESSION["s"]["id"] == $res["id"]) {
                if (!$_COOKIE["ref_".$res["id"]]) {
                    $ref_u = $this->Member_reference->request_ref_by_email($_SESSION["s"]["email"], 'mrr.state = 0');
                    $ref_s = $this->Startup_reference->request_ref_by_email($_SESSION["s"]["email"], 'mrr.state = 0');
                    $ref_cnt = sizeof($ref_u) + sizeof($ref_s);
                    if ($ref_cnt > 0) $this->assigns["ref_al"] = $ref_cnt."건의 레퍼런스 요청이 있습니다.<br > 취소를 클릭하면 일주일간 보이지 않아요.";
                }

                if (!$_COOKIE["progress_mem_".$res["id"]]) {
                    $p_edu = $this->Member_education->list_($res["id"]);
                    $p_com = $this->Startup_member->get_by_user($res["id"]);
                    $p_pj = $this->Member_project->list_($res["id"]);
                    $point = 0;
                    if ($res["name"]) $point++;
                    if ($res["bio"]) $point++;
                    if (sizeof($p_local) > 0) $point++;
                    if (sizeof($p_inter) > 0) $point++;
                    if (sizeof($p_skill) > 0) $point++;
                    if (sizeof($p_edu) > 0) $point++;
                    if (sizeof($p_com) > 0) $point++;
                    if (sizeof($p_pj) > 0) $point++;
                    $this->assigns["point"] = round($point / 8 * 100); 
                }
                else $this->assigns["point"] = 100;
            }
            $this->assigns["p_show"] = true;
            $this->assigns["a_show"] = true;
            $this->assigns["u_show"] = true;
            $this->assigns["r_show"] = true;
            
            # other profile
            if ($res["id"] != $_SESSION["s"]["id"]) {
                if (sizeof($cur_act) < 1) $this->assigns["a_show"] = false; 
                
                $w1 = "user_id = ".$res["id"];
                $up = $this->Board->list_(1, $res["id"], '', '', $w1);
                if (sizeof($up) < 1) $this->assigns["u_show"] = false; 

                $e = $this->Member_education->list_($res["id"]);
                $j = $this->Startup_member->get_list_by_user($res["id"]);
                $j2 = $this->Startup_member->get_list_by_user($res["id"]);
                $p = $res = $this->Member_project->list_($res["id"]);

                if (sizeof($e) < 1 && sizeof($j) < 1 && sizeof($j2) < 1 && sizeof($p) < 1) {
                    $this->assigns["p_show"] = false;
                }
            }

        }
        else {
            header("Location: /");
        }
        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }

    public function edit()
    {
        $this->assigns_layout["sideb"] = "edit";
        if (!$_SESSION["s"]) {
            header("Location: /login?next=/member/edit");
        }
        
        if ($_REQUEST["email"]) {
            $_REQUEST["public_act"] = 0;
            if ($_REQUEST["public_act1"]) $_REQUEST["public_act"] = $_REQUEST["public_act"] + 1;
            if ($_REQUEST["public_act2"]) $_REQUEST["public_act"] = $_REQUEST["public_act"] + 2;

            $_id = $this->Members->add($_REQUEST);

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
                $copy_file = $this->settings->root_path.'media/member/'.$_id.$file_ext;

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/member/'.$_id.$file_ext;
                $this->Members->add_picture($_id, $_pic);
            }
            if ($_REQUEST["local"]) {
                if($_REQUEST["id"]) {
                    $this->Member_local->delete_by_user($_REQUEST["id"]);
                }
                $local = explode(",", $_REQUEST["local"]);
                $len_local = sizeof($local);
                for($i=0; $i<$len_local; $i++) {
                    if (trim($local[$i]))
                        $this->Member_local->add($_id, trim($local[$i]));
                }
            }

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
            // activity
            $m = "<a href='/member/".$_REQUEST["ids"]."'>".$_REQUEST["name"]."</a>님이 프로필 정보를 수정하였습니다.";
            add_activity(1, $_REQUEST["id"], 1, $_REQUEST["id"], "", $m);

            unset($_SESSION["s"]);
            $_SESSION["s"] = $this->Members->get($_id);
            $_SESSION["s"]["fb"] = $this->Member_ext->get_by_user_id_type($_id, 1);
            $_SESSION["s"]["tw"] = $this->Member_ext->get_by_user_id_type($_id, 2);
            $this->assigns_layout["msg"] = "수정되었습니다.";
        }
        $res = $this->Members->get($_SESSION["s"]["id"]);
        $this->assigns["res"] = $res;
        $this->assigns["tw"] = $this->Member_ext->get_by_user_id_type($_SESSION["s"]["id"], Member_ext_model::TWITTER_TYPE);
        $this->assigns["fb"] = $this->Member_ext->get_by_user_id_type($_SESSION["s"]["id"], Member_ext_model::FACEBOOK_TYPE);
        $res_lo = $this->Member_local->get_by_member($_SESSION["s"]["id"]);
        $this->assigns["res_sk"] = $this->Member_skill->get_by_member_c($_SESSION["s"]["id"]);
        if ($res["utype"] == 1) {
            $this->assigns["res_in"] = $this->Member_interist->get_by_member_c($_SESSION["s"]["id"]);
            $inv = $this->Code->get_by_key('inv');
            for ($v=0; $v<sizeof($inv); $v++) {
                for ($vv=0; $vv<sizeof($this->assigns["res_in"]); $vv++) {
                    if ($inv[$v]["id"] == $this->assigns["res_in"][$vv]["interist_id"]) {
                        $inv[$v]['checked'] = true; 
                    }
                }
            }
            $this->assigns["inv"] = $inv;
        }
        else if ($res["utype"] == 2) {
            $this->assigns["res_mk"] = $this->Member_market->get_by_member_c($res["id"]);
            $this->assigns["res_in"] = $this->Member_inv->get_by_member($res["id"]);
        }
        $loc = $this->Code->get_by_key('local');
        for ($l=0; $l<sizeof($loc); $l++) {
            for ($ll=0; $ll<sizeof($res_lo); $ll++) {
                if ($loc[$l]["id"] == $res_lo[$ll]["local_id"]) {
                    $loc[$l]['checked'] = true; 
                }
            }
        }
        $this->assigns["local"] = $loc;
        $this->assigns["res_lo"] = $res_lo;
        
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
        $_key3 = 'market';
        $result3 = $this->Code->get_by_key($_key3);
        $items3 = array();
        for ($j=0; $j<sizeof($result3); $j++) {
            array_push($items3, $result3[$j]["_value"]);
        }
        $this->assigns["market"] =  json_encode($items3);
        $this->assigns["job"] =  json_encode($items2);
        $this->assigns["skill"] =  json_encode($items2);
    }
    
    public function activity()
    {
        $this->assigns_layout["sideb"] = "activity";
        if (!$_SESSION["s"]) {
            header("Location: /login?next=/member/activity");
        }
        $this->Activity->edit_alarm(1, $_SESSION["s"]["id"], 1);
        $_SESSION["s"]["acnt"] = 0;
        $this->assigns_layout["s"] = $_SESSION["s"];
        $res = $this->Activity->get_by_com(1, $_SESSION["s"]["id"], 1, 10, 'date_created DESC');
        for ($i=0; $i<sizeof($res); $i++) {
            if ($res[$i]["msg"]) {
                if ($res[$i]["act_type"] == 1) {
                    $ow = $this->Members->get($res[$i]["act_id"]);
                    $res[$i]["ow_ids"] = $ow["ids"];
                    $res[$i]["ow_picture"] = $ow["picture"];
                    $res[$i]["ow_name"] = $ow["name"];
                }
                else if ($res[$i]["act_type"] == 2){
                    $ow = $this->Startup->get($res[$i]["act_id"]);
                    $res[$i]["ow_id"] = $ow["id"];
                    $res[$i]["ow_logo"] = $ow["logo"];
                    $res[$i]["ow_name"] = $ow["name"];
                }
            }
            else {
                if ($res[$i]["target_type"] == Activity_model::A_TYPE_EVENT) {
                    $res[$i]["data"] = $this->Event->get($res[$i]["target_id"]);
                    $res[$i]["mem"] = $this->Members->get($res[$i]["act_id"]);
                }
                else if ($res[$i]["target_type"] == Activity_model::A_TYPE_SPACE) {
                    $res[$i]["data"] = $this->Space_reserve->get_detail($res[$i]["target_id"]);
                    $res[$i]["mem"] = $this->Members->get($res[$i]["act_id"]);
                }
                else if ($res[$i]["target_type"] == Activity_model::E_TYPE_COMPETITION) {
                    $res[$i]["data"] = $this->Competitions->get($res[$i]["target_id"]);
                    $res[$i]["mem"] = $this->Members->get($res[$i]["act_id"]);
                }
                else if ($res[$i]["target_type"] == Activity_model::O_TYPE_OFFICE_HOURS) {
                    $res[$i]["res"] = $this->Office_hours->get($res[$i]["target_id"]);
                    $res[$i]["mem"] = $this->Members->get($res[$i]["act_id"]);
                }
            }
        }
        $this->assigns["res"] = $res;
    }
    
    public function edit_contents($_page = 1)
    {
        $this->assigns_layout["sideb"] = "contents";
        if (!$_SESSION["s"]) {
            header("Location: /login?next=/member/edit_contents");
        }
        $pagesize = 10;
        $this->assigns["res"] = $this->Content->list_($_page, $pagesize, 'c.user_id = '.$_SESSION["s"]["id"]);
        $res_cnt = $this->Content->cnt('c.user_id = '.$_SESSION["s"]["id"]);
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize); 
    }
    
    public function edit_event($_page = 1)
    {
        $this->assigns_layout["sideb"] = "event";
        if (!$_SESSION["s"]) {
            header("Location: /login?next=/member/edit_event");
        }
        $pagesize = 10;
        $apply = $this->Event_reserve->list_($_page, $pagesize, 'er.user_id ='.$_SESSION["s"]["id"]);
        for ($i=0; $i<sizeof($apply); $i++) {
            $apply[$i]["ev"] = $this->Event->get($apply[$i]["event_id"]);
        }
        $this->assigns["apply"] = $apply;
        $res_cnt = $this->Event_reserve->cnt('user_id ='.$_SESSION["s"]["id"]);
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize); 
    }

    public function edit_event_m($_page = 1)
    {
        $this->assigns_layout["sideb"] = "event";
        if (!$_SESSION["s"]) {
            header("Location: /login?next=/member/edit_event");
        }
        $pagesize = 10;
        $this->assigns["event"] = $this->Event->list_($_page, $pagesize, 'e.user_id ='.$_SESSION["s"]["id"]);
        $res_cnt = $this->Event->cnt('user_id ='.$_SESSION["s"]["id"]);
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize); 

    }
    
    public function edit_space($_page = 1)
    {
        $this->assigns_layout["sideb"] = "space";
        if (!$_SESSION["s"]) {
            header("Location: /login?next=/member/edit_space");
        }
        $pagesize = 10;
        $this->assigns["space"] = $this->Space_reserve->list_($_page, $pagesize, 'user_id = '.$_SESSION["s"]["id"]);
        $res_cnt = $this->Space_reserve->cnt('user_id = '.$_SESSION["s"]["id"]);
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize); 

        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }
    
    public function edit_competition($_page = 1)
    {
        $this->assigns_layout["sideb"] = "competition";
        if (!$_SESSION["s"]) {
            header("Location: /login?next=/member/edit_competition");
        }
        $pagesize = 10;
        $applied = $this->Competitions_apply->get_by_user_all($_page, $pagesize, $_SESSION["s"]["id"]);
        $res_cnt = $this->Competitions_apply->get_by_user_cnt($_SESSION["s"]["id"]);

        $make = $this->Competitions->get_by_user_cnt($_SESSION["s"]["id"]);
        $examine = $this->Competitions_examiner->get_by_user_cnt($_SESSION["s"]["id"]);

        $this->assigns["make"] = $make;
        $this->assigns["examine"] = $examine;
        $this->assigns["applied"] = $applied;

        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize); 

        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }

    public function edit_competition_m($_page = 1)
    {
        $this->assigns_layout["sideb"] = "competition";
        if (!$_SESSION["s"]) {
            header("Location: /login?next=/member/edit_competition_m");
        }
        $pagesize = 10;
        $make = $this->Competitions->get_by_user($_page, $pagesize, $_SESSION["s"]["id"]);
        $res_cnt = $this->Competitions->get_by_user_cnt($_SESSION["s"]["id"]);

        $examine = $this->Competitions_examiner->get_by_user_cnt($_SESSION["s"]["id"]);
        $applied = $this->Competitions_apply->get_by_user_cnt($_SESSION["s"]["id"]);
        
        $len_make = sizeof($make);
        for ($i=0; $i<$len_make; $i++) { 
            $make[$i]["cnt"] = $this->Competitions_apply->cnt('ca.competition_id = '.$make[$i]["id"]);
            $exm = $this->Competitions_examiner->get_by_comp($make[$i]["id"]);
            $make[$i]["exm"] = sizeof($exm);
        }
        
        $this->assigns["make"] = $make;
        $this->assigns["examine"] = $examine;
        $this->assigns["applied"] = $applied;

        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize); 

    }

    public function edit_competition_ex($_page = 1)
    {
        $this->assigns_layout["sideb"] = "competition";
        if (!$_SESSION["s"]) {
            header("Location: /login?next=/member/edit_competition_ex");
        }
        $pagesize = 10;
        $examine = $this->Competitions_examiner->get_by_user_page($_page, $pagesize, $_SESSION["s"]["id"]);
        $res_cnt = $this->Competitions_examiner->get_by_user_cnt($_SESSION["s"]["id"]);

        $make = $this->Competitions->get_by_user_cnt($_SESSION["s"]["id"]);
        $applied = $this->Competitions_apply->get_by_user_cnt($_SESSION["s"]["id"]);
        
        $len_examine = sizeof($examine);
        for ($j=0; $j<$len_examine; $j++) {
            $examine[$j]["apply_cnt"] = $this->Competitions_apply->cnt('ca.status = 1 and ca.competition_id = '.$examine[$j]["id"]);
            $ex = $this->Competitions_scoring->get_score_by_apply('ci.score != 0 and cs.competition_id ='.$examine[$j]["id"]." and ci.user_id = ".$_SESSION["s"]["id"]);
            $examine[$j]["examine_cnt"] = sizeof($ex);
        }
        
        $this->assigns["make"] = $make;
        $this->assigns["examine"] = $examine;
        $this->assigns["applied"] = $applied;

        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize); 
    }

    public function edit_challenge($_page = 1)
    {
        $this->assigns_layout["sideb"] = "challenge";
        if (!$_SESSION["s"]) {
            header("Location: /login?next=/member/edit_challenge");
        }
        $pagesize = 10;
        $applied = $this->Competitions_apply->get_by_user_all($_page, $pagesize, $_SESSION["s"]["id"]);
        $res_cnt = $this->Competitions_apply->get_by_user_cnt($_SESSION["s"]["id"]);

        $make = $this->Competitions->get_by_user_cnt($_SESSION["s"]["id"]);
        $op = $this->Competitions_examiner->operator_by_user($_SESSION["s"]["id"]);
        $examine = $this->Competitions_examiner->get_by_user_cnt($_SESSION["s"]["id"], "c.ex_confirm = 1 and ce.status = 1");

        $this->assigns["make"] = $make;
        $this->assigns["op"] = sizeof($op);
        $this->assigns["examine"] = $examine;
        $this->assigns["applied"] = $applied;

        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize); 

        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }
    
    public function edit_challenge_m($_page = 1)
    {
        $this->assigns_layout["sideb"] = "challenge";
        if (!$_SESSION["s"]) {
            header("Location: /login?next=/member/edit_challenge_m");
        }
        $pagesize = 10;
        $make = $this->Competitions->get_by_user($_page, $pagesize, $_SESSION["s"]["id"]);
        $res_cnt = $this->Competitions->get_by_user_cnt($_SESSION["s"]["id"]);
        $op = $this->Competitions_examiner->operator_by_user($_SESSION["s"]["id"]);
        $examine = $this->Competitions_examiner->get_by_user_cnt($_SESSION["s"]["id"], "c.ex_confirm = 1 and ce.status = 1");
        $applied = $this->Competitions_apply->get_by_user_cnt($_SESSION["s"]["id"]);
        
        $len_make = sizeof($make);
        for ($i=0; $i<$len_make; $i++) { 
            $make[$i]["cnt"] = $this->Competitions_apply->cnt_out('ca.competition_id = '.$make[$i]["id"]);
            // $make[$i]["cnt"] = $this->Competitions_apply->cnt('ca.competition_id = '.$make[$i]["id"]);
            $exm = $this->Competitions_examiner->get_by_comp($make[$i]["id"], '', '', "ce.status = 1");
            $make[$i]["exm"] = sizeof($exm);
        }
        
        $this->assigns["make"] = $make;
        $this->assigns["op"] = sizeof($op);
        $this->assigns["examine"] = $examine;
        $this->assigns["applied"] = $applied;

        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize); 
        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
        if ($_SESSION["msgt"]) {
            $this->assigns["msgt"] = $_SESSION["msgt"];
            unset($_SESSION["msgt"]);
        }

        if (! $res_cnt) {
            header("Location: /member/edit_challenge");
        }
    }

    public function edit_challenge_op($_page = 1)
    {
        $this->assigns_layout["sideb"] = "challenge";
        if (!$_SESSION["s"]) {
            header("Location: /login?next=/member/edit_challenge_m");
        }
        $pagesize = 10;
        $make = $this->Competitions->get_by_user($_page, $pagesize, $_SESSION["s"]["id"]);
        
        $op = $this->Competitions_examiner->operator_by_user($_SESSION["s"]["id"]);
        if (! $op) {
            $_SESSION["msg"] = "운영진 위촉 경진대회가 없습니다.";
            header("Location: /member/edit_challenge");
        }
        $res_cnt = $this->Competitions_examiner->operator_cnt("user_id = ".$_SESSION["s"]["id"]);

        $examine = $this->Competitions_examiner->get_by_user_cnt($_SESSION["s"]["id"], "c.ex_confirm = 1 and ce.status = 1");
        $applied = $this->Competitions_apply->get_by_user_cnt($_SESSION["s"]["id"]);
        
        $len_make = sizeof($op);
        for ($i=0; $i<$len_make; $i++) { 
            // $op[$i]["cnt"] = $this->Competitions_apply->cnt('ca.competition_id = '.$op[$i]["id"]);
            $op[$i]["cnt"] = $this->Competitions_apply->cnt_out('ca.competition_id = '.$op[$i]["id"]);
            $exm = $this->Competitions_examiner->get_by_comp($op[$i]["id"]);
            $op[$i]["exm"] = sizeof($exm);
        }
        
        $this->assigns["make"] = $make;
        $this->assigns["op"] = $op;
        $this->assigns["examine"] = $examine;
        $this->assigns["applied"] = $applied;

        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize); 

    }

    public function edit_challenge_ex($_page = 1)
    {
        $this->assigns_layout["sideb"] = "challenge";
        if (!$_SESSION["s"]) {
            header("Location: /login?next=/member/edit_challenge_ex");
        }
        $pagesize = 10;
        $examine = $this->Competitions_examiner->get_by_user_page($_page, $pagesize, $_SESSION["s"]["id"], "c.ex_confirm = 1 and ce.status = 1");
        if (! $examine) {
            $_SESSION["msg"] = "심사위원 위촉 경진대회가 없습니다.";
            header("Location: /member/edit_challenge");
        }
        $res_cnt = $this->Competitions_examiner->get_by_user_cnt($_SESSION["s"]["id"], "ce.status = 1");

        $make = $this->Competitions->get_by_user_cnt($_SESSION["s"]["id"]);
        $op = $this->Competitions_examiner->operator_by_user($_SESSION["s"]["id"]);
        $applied = $this->Competitions_apply->get_by_user_cnt($_SESSION["s"]["id"]);
        
        $len_examine = sizeof($examine);
        for ($j=0; $j<$len_examine; $j++) {
            // $examine[$j]["apply_cnt"] = $this->Competitions_apply->cnt('ca.status = 1 and ca.competition_id = '.$examine[$j]["id"]);
            $examine[$j]["apply_cnt"] = $this->Competitions_apply->cnt_out('ca.status = 1 and ca.competition_id = '.$examine[$j]["id"]);
            $ex = $this->Competitions_scoring->get_score_by_apply('ci.score != 0 and cs.competition_id ='.$examine[$j]["id"]." and ci.user_id = ".$_SESSION["s"]["id"]);
            $examine[$j]["examine_cnt"] = sizeof($ex);
        }
        
        $this->assigns["make"] = $make;
        $this->assigns["op"] = sizeof($op);
        $this->assigns["examine"] = $examine;
        $this->assigns["applied"] = $applied;

        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize); 
    }

    public function edit_benefit_m($_page = 1)
    {
        $this->assigns_layout["sideb"] = "benefits";
        if (!$_SESSION["s"]) {
            header("Location: /login?next=/member/edit_benefit_m");
        }
        $pagesize = 10;
        $make = $this->Program->get_by_user($_page, $pagesize, $_SESSION["s"]["id"]);
        $res_cnt = $this->Program->get_by_user_cnt($_SESSION["s"]["id"]);
        if (! $res_cnt) {
            header("Location: /member/edit_benefit");
        }

        $applied = $this->Program_apply->get_by_user_cnt($_SESSION["s"]["id"]);
        
        $len_make = sizeof($make);
        for ($i=0; $i<$len_make; $i++) { 
            $make[$i]["cnt"] = $this->Program_apply->cnt_out('ca.program_id = '.$make[$i]["id"]);
        }
        
        $this->assigns["make"] = $make;
        $this->assigns["op"] = sizeof($op);
        $this->assigns["applied"] = $applied;

        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize); 
        
        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
        if ($_SESSION["msgt"]) {
            $this->assigns["msgt"] = $_SESSION["msgt"];
            unset($_SESSION["msgt"]);
        }

        
    }

    public function edit_benefit($_page = 1)
    {
        $this->assigns_layout["sideb"] = "benefits";
        if (!$_SESSION["s"]) {
            header("Location: /login?next=/member/edit_benefit");
        }
        $pagesize = 10;
        $applied = $this->Program_apply->get_by_user_all($_page, $pagesize, $_SESSION["s"]["id"]);
        $res_cnt = $this->Program_apply->get_by_user_cnt($_SESSION["s"]["id"]);

        $make = $this->Program->get_by_user_cnt($_SESSION["s"]["id"]);
        $this->assigns["make"] = $make;

        $this->assigns["applied"] = $applied;
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize); 

        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }

    public function edit_recruit($_page = 1)
    {
        $this->assigns_layout["sideb"] = "recruit";
        if (!$_SESSION["s"]) {
            header("Location: /login?next=/member/edit_recruit");
        }
        $pagesize = 10;
        $res = $this->Recruit->list_s_($_page, $pagesize, 'r.user_id ='.$_SESSION["s"]["id"]);

        $this->assigns["res"] = $res;
        $res_cnt = $this->Recruit->list_s_cnt('user_id ='.$_SESSION["s"]["id"]);
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);
    }
    public function edit_reference($_page = 1)
    {
        $this->assigns_layout["sideb"] = "reference";
        if (!$_SESSION["s"]) {
            header("Location: /login?next=/member/edit_competition_ex");
        }
        $pagesize = 10;
        $res = $this->Activity->get_by_com(1, $_SESSION["s"]["id"], $_page, $pagesize, '', 'target_type = '.Activity_model::E_TYPE_REFERENCE);
        for ($i=0; $i<sizeof($res); $i++) {
            if ($res[$i]["msg"]) {
                if ($res[$i]["act_type"] == 1) {
                    $ow = $this->Members->get($res[$i]["act_id"]);
                    $res[$i]["ow_ids"] = $ow["ids"];
                    $res[$i]["ow_picture"] = $ow["picture"];
                    $res[$i]["ow_name"] = $ow["name"];
                }
                else if ($res[$i]["act_type"] == 2){
                    $ow = $this->Startup->get($res[$i]["act_id"]);
                    $res[$i]["ow_id"] = $ow["id"];
                    $res[$i]["ow_logo"] = $ow["logo"];
                    $res[$i]["ow_name"] = $ow["name"];
                }
            }
        }
        $this->assigns["res"] = $res;
        $this->assigns["page"] = $_page;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize); 
    }

    public function edit_office($_page = 1) 
    {
        $this->assigns_layout["sideb"] = "office";
        if (!$_SESSION["s"]) {
            header("Location: /login?next=/member/edit_office");
        }

        $pagesize = 10;
        $res = $this->Office_hours_apply->get_by_user($_page, $pagesize, 'user_id = '.$_SESSION["s"]["id"]);
        $res_cnt = $this->Office_hours_apply->cnt('', 'user_id = '.$_SESSION["s"]["id"]);
        // for ($i=0; $i<sizeof($res); $i++) {
        //     $res[$i]["tot"] = $this->Office_hours_apply->cnt($res[$i]["id"]);
        // }
        $this->assigns["res"] = $res;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);

    }

    public function edit_showcase($_page = 1)
    {
        $this->assigns_layout["sideb"] = "showcase";
        if (!$_SESSION["s"]) {
            header("Location: /login?next=/member/edit_showcase");
        }
        $pagesize = 10;
        $order = "date_created DESC";
        $where = "user_id_bz = ".$_SESSION["s"]["id"];
        $res = $this->Startup_service->list_('', $where, $order, $_page, $pagesize);
        for ($r=0; $r<sizeof($res); $r++) {
            $res[$r]["cats"] = $this->Startup_service->get_category($res[$r]["id"]);
            $res[$r]["s"] = $this->Startup->get($res[$r]["startup_id"]);
            $res[$r]["com"] = $this->Board->cnt("p_type = 9 and p_id = ".$res[$r]["id"]);
        }
        $this->assigns["res"] = $res;
    }

    public function edit_rsv1($_page = 1)
    {
        $this->assigns_layout["sideb"] = "rsv1";
        if ($this->Code->check("rep1", $_SESSION["s"]["id"])) {
            $pagesize = 10;
            $where = 's.type < 3';
            $order = 'sr.id DESC';
            $res = $this->Space_reserve->list_($_page, $pagesize, $where, $order);
            $res_cnt = $this->Space_reserve->cnt($where);
            $this->assigns["res"] = $res;
            $this->assigns["res_cnt"] = $res_cnt;
            $this->assigns["page"] = $_page;
            $this->assigns["pagesize"] = $pagesize;
            $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);

            if ($_SESSION["msg"]) {
                $this->assigns_layout["msg"] = $_SESSION["msg"];
                unset($_SESSION["msg"]);
            }
        }
        else {
            $_SESSION["msg"] = "권한이 없는 접근입니다.";
            header("Location: /");
        } 

    }

    public function edit_rsv2($_page = 1)
    {
        $this->assigns_layout["sideb"] = "rsv2";
        if ($this->Code->check("rep2", $_SESSION["s"]["id"])) {
            $pagesize = 10;
            $where = 's.type = 3';
            $order = 'sr.id DESC';
            $res = $this->Space_reserve->list_($_page, $pagesize, $where, $order);
            $res_cnt = $this->Space_reserve->cnt($where);
            $this->assigns["res"] = $res;
            $this->assigns["res_cnt"] = $res_cnt;
            $this->assigns["page"] = $_page;
            $this->assigns["pagesize"] = $pagesize;
            $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);

            if ($_SESSION["msg"]) {
                $this->assigns_layout["msg"] = $_SESSION["msg"];
                unset($_SESSION["msg"]);
            }
        }
        else {
            $_SESSION["msg"] = "권한이 없는 접근입니다.";
            header("Location: /");
        }
    }

    public function edit_rsv_apr($_id)
    {
        $this->assigns_layout["sideb"] = "edit";
        $res = $this->Space_reserve->get_detail($_id);
        if ($res["type"] == 3) {
            if ($this->Code->check("rep2", $_SESSION["s"]["id"])) {
                
                if (array_key_exists("state", $_REQUEST)) {
                    $this->Space_reserve->permit($_REQUEST["id"], $_REQUEST);
                    $res["state"] = $_REQUEST["state"];

                    if ($_REQUEST["state"] == 1) {
                        $arr["act_type"] = Activity_model::C_TYPE_MEMBER;
                        $arr["act_id"] = $res["user_id"];
                        $arr["target_type"] = Activity_model::A_TYPE_SPACE;
                        $arr["target_id"] = $_REQUEST["id"];
                        $arr["act_result"] = 1;
                        $this->Activity->edit($arr);
                        
                        $m = new TF_mailer($this->settings);
                        $m->mailto = $res["memail"];
                        $m->subject = "[D.CAMP] 공간 예약이 승인되었습니다.";
                        $m->tpl_name = "space";
                        $m->assigns["res"] = $res;
                        $m->assigns["main_service_url"] = $this->globals->my_host;
                        $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                        $m->send();
                    }

                    if ($_REQUEST["state"] == 2) {
                        $arr["act_type"] = Activity_model::C_TYPE_MEMBER;
                        $arr["act_id"] = $res["user_id"];
                        $arr["target_type"] = Activity_model::A_TYPE_SPACE;
                        $arr["target_id"] = $_REQUEST["id"];
                        $arr["act_result"] = 2;
                        $this->Activity->edit($arr);
                        
                        // if (date("Y.m.d")<$res["date"]) {
                            $m = new TF_mailer($this->settings);
                            $m->mailto = $res["memail"];
                            $m->subject = "[D.CAMP] 공간 예약이 반려되었습니다.";
                            $m->tpl_name = "space";
                            $m->assigns["res"] = $res;
                            $m->assigns["main_service_url"] = $this->globals->my_host;
                            $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                            $m->send();
                        // }
                    }
                    $_SESSION["msg"] = "공간 예약 승인 상태가 저장되었습니다.";
                    header("Location: /member/edit_rsv2");
                }
                $this->assigns["res"] = $res;
            }
            else {
                $_SESSION["msg"] = "권한이 없는 접근입니다.";
                header("Location: /");
            }
        }
        else {
            if ($this->Code->check("rep1", $_SESSION["s"]["id"])) {
                $this->assigns["res"] = $res;
                $this->assigns["space"] = $this->Space->list_(1, 100, "visible = 1");

                if (array_key_exists("state", $_REQUEST)) {
                    $this->Space_reserve->permit($_REQUEST["id"], $_REQUEST);
                    $res["state"] = $_REQUEST["state"];

                    if ($_REQUEST["state"] == 1) {
                        $arr["act_type"] = Activity_model::C_TYPE_MEMBER;
                        $arr["act_id"] = $res["user_id"];
                        $arr["target_type"] = Activity_model::A_TYPE_SPACE;
                        $arr["target_id"] = $_REQUEST["id"];
                        $arr["act_result"] = 1;
                        $this->Activity->edit($arr);
                        
                        $m = new TF_mailer($this->settings);
                        $m->mailto = $res["memail"];
                        $m->subject = "[D.CAMP] 공간 예약이 승인되었습니다.";
                        $m->tpl_name = "space";
                        $m->assigns["res"] = $res;
                        $m->assigns["main_service_url"] = $this->globals->my_host;
                        $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                        $m->send();
                    }

                    if ($_REQUEST["state"] == 2) {
                        $arr["act_type"] = Activity_model::C_TYPE_MEMBER;
                        $arr["act_id"] = $res["user_id"];
                        $arr["target_type"] = Activity_model::A_TYPE_SPACE;
                        $arr["target_id"] = $_REQUEST["id"];
                        $arr["act_result"] = 2;
                        $this->Activity->edit($arr);
                        
                        // if (date("Y.m.d")<$res["date"]) {
                            $m = new TF_mailer($this->settings);
                            $m->mailto = $res["memail"];
                            $m->subject = "[D.CAMP] 공간 예약이 반려되었습니다.";
                            $m->tpl_name = "space";
                            $m->assigns["res"] = $res;
                            $m->assigns["main_service_url"] = $this->globals->my_host;
                            $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                            $m->send();
                        // }
                    }
                    $_SESSION["msg"] = "공간 예약 승인 상태가 저장되었습니다.";
                    header("Location: /member/edit_rsv1");
                }
            }
            else {
                $_SESSION["msg"] = "권한이 없는 접근입니다.";
                header("Location: /");
            }
        }
    }
}
?>
