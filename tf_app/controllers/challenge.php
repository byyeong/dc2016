<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Challenge extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "default";
    var $use_models = array("Competitions", "Competitions_score", "Competitions_examiner"
            , "Competitions_apply", "Startup_member", "Competitions_scoring", "Competitions_file"
            , "Competitions_files", "Activity", "Members", "Competitions_form", "Banner"
            , "Startup_service", "Event", "Event_reserve", "Entrance", "Board");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "competition";
        $this->assigns_layout["gnb_title"] = "competition";
        $this->assigns_layout["con"] = get_contents_category();
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns_layout["s"] = $_SESSION["s"];
    }

    public function index($_status = 'ing', $_page = 1)
    {
        $_pagesize = 10;
        $where = "c.status = 1 and c.open = 1 ";
        if ($_status == 'ing') $where = $where .' and concat(date_e, time_e) >= "'. date('Y.m.dH:i').'"';
        else if ($_status == 'end') $where = $where .' and  concat(date_e, time_e) < "'. date('Y.m.dH:i').'"';

        $order = "c.date_created DESC";
        if ($_REQUEST["type"]) $order = "concat(date_e, time_e) DESC";;  

        $res = $this->Competitions->get_list($_page, $_pagesize, $where, $order);
        for ($j=0; $j<sizeof($res); $j++) {
            if (date("Y.m.dH:i") > $res[$j]["date_s"].$res[$j]["time_s"] && date("Y.m.dH:i") < $res[$j]["date_e"].$res[$j]["time_e"]) 
                $res[$j]["is_ing"] = 1;
        }

        $this->assigns["res"] = $res;
        $this->assigns["page"] = $_page;
        $this->assigns["status"] = $_status;
        $this->assigns["type"] = $_REQUEST["type"];
        $this->assigns["banner"] = $this->Banner->get_one(3);
        
        // lounge box
        $today_ev_users = $this->Event_reserve->list_(1, 100, "e.space_id > 0 and er.state = 1 and date = '".date("Y.m.d")."'");
        $today_dcamp_users = $this->Entrance->list_('', '', '', 'date_out IS NULL and date_in LIKE "'.date("Y-m-d").'%" GROUP BY m.id ');

        $comments = $this->Board->list_(Board_model::EVENT_TYPE, 0, 1, 5);
        for ( $i=0; $i<sizeof($comments); $i++ ){
            if ($comments[$i]["p_id"] > 0 ) {
                $e = $this->Event->get($comments[$i]["p_id"]);
                $comments[$i]["p_name"] = $e["title"];
                
            }
            $com = $this->Board->get_comment($_type = 3, $comments[$i]["id"]);
            $comments[$i]["com"] = sizeof($com); 
            $comments[$i]["like"] = $this->Board->get_like_cnt($comments[$i]["id"]);
        }
        
        $this->assigns["lounge"] = $comments;
        $this->assigns["u_cnt"] = sizeof($today_ev_users) + sizeof($today_dcamp_users);
        // lounge box

        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }

    private function sub()
    {
        $sub = $this->Competitions->get_list(1, 5, 'c.status = 1 and c.open = 1');
        $this->assigns["sub"] = $sub;
    }

    public function views($_id)
    {
        if (!$_id) header("Location: /error_404");
        $this->Competitions->pageview($_id);
        $res = $this->Competitions->get($_id);
        
        if (!$res) {
            $res = $this->Competitions->get_by_url($_id);
            $_id = $res["id"];
        }

        if (!$res) {
            header("Location: /error_404");
        }
        
        $this->Competitions->pageview($_id);
        $res["a_file"] = $this->Competitions->get_a_file($_id);
        $res["group"] = $this->Competitions->get_group($_id);
        $my = $this->Competitions_apply->get_by_user($_id, $_SESSION["s"]["id"]);
        if ($res["ex_confirm"])
            $ex = $this->Competitions_examiner->get_by_user($_SESSION["s"]["id"], "ce.competition_id = ".$_id." and ce.status = 1");
        $op = $this->Competitions_examiner->operator_check($_id, $_SESSION["s"]["id"]);
        $this->assigns["res"] = $res;
        $this->assigns["my"] = $my;
        $this->assigns["ex"] = $ex;
        $this->assigns["op"] = $op;
        $this->sub();
        $this->assigns["ev"] = $this->Event->list_(1, 5, 'e.id != '.$_id.' and e.state = 1 and e.open = 1 and e.apply_end > "'.date("Y.m.d H:i").'"');

        $og["type"] = 'article';
        $og["url"] = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
        $og["title"] = $res["subject"]." on D.CAMP";
        $og["description"] = strip_tags($res["contents"]);
        if (strlen(strip_tags($res["contents"])) > 150) $og["description"] 
                = mb_substr(strip_tags($res["contents"]), 0, 150, 'UTF-8').'...';
        $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].$res["img"];
        if (!$res["img"]) $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].$this->assigns["res"]["mpicture"];
        $this->assigns_layout["og"] = $og;
        $this->assigns["g_start"] = date("YmdHi00",strtotime ("-9 hour", strtotime(str_replace(".", "", $res["date_s"]).str_replace(":", "", $res["time_s"]))));
        $this->assigns["g_end"] = date("YmdHi00",strtotime ("-9 hour", strtotime(str_replace(".", "", $res["date_e"]).str_replace(":", "", $res["time_e"])))); 
        
        // lounge box
        $today_ev_users = $this->Event_reserve->list_(1, 100, "e.space_id > 0 and er.state = 1 and date = '".date("Y.m.d")."'");
        $today_dcamp_users = $this->Entrance->list_('', '', '', 'date_out IS NULL and date_in LIKE "'.date("Y-m-d").'%" GROUP BY m.id ');

        $comments = $this->Board->list_(Board_model::EVENT_TYPE, 0, 1, 5);
        for ( $i=0; $i<sizeof($comments); $i++ ){
            if ($comments[$i]["p_id"] > 0 ) {
                $e = $this->Event->get($comments[$i]["p_id"]);
                $comments[$i]["p_name"] = $e["title"];
                
            }
            $com = $this->Board->get_comment($_type = 3, $comments[$i]["id"]);
            $comments[$i]["com"] = sizeof($com); 
            $comments[$i]["like"] = $this->Board->get_like_cnt($comments[$i]["id"]);
        }
        
        $this->assigns["lounge"] = $comments;
        $this->assigns["u_cnt"] = sizeof($today_ev_users) + sizeof($today_dcamp_users);
        // lounge box

        if (!strpos($_SERVER["HTTP_REFERER"], "dcamp.kr")) {
            $this->assigns_layout["cards"] = bottom_main();
        }
        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }
    
    public function apply($_id, $_per = '')
    {
        if (!$_id) header("Location: /error_404");

        if ($_id == 133 || $_id == 132) {
            header("Location: /competition/apply/".$_id."/".$_per);
        }

        $res = $this->Competitions->get($_id);
        $my = $this->Competitions_apply->get_by_user($_id, $_SESSION["s"]["id"]);

        if ($_per) {
            $per = $this->Competitions_apply->get($_per);

            if ($per["user_id"] != $_SESSION["s"]["id"]) {
                header("Location: /error_404");
            }

            if ($_REQUEST["req"] == 'del') {
                if ($per["user_id"] == $_SESSION["s"]["id"]) {
                    $this->Competitions_apply->delete($_per);
                    $fi = $this->Competitions_files->get_by_apply($_per);
                    for ($ff=0; $ff<sizeof($fi); $ff++) {
                        unlink("media/comp_file/".$fi[$ff]["file"]);
                    }
                    header("Location: /member/edit_challenge");
                }
                else {
                    $this->assigns_layout["msg"] = "삭제 권한이 없습니다.";
                }
            }

            
        }
        else {
            $per["user_id"] = $_SESSION["s"]["id"];
            $per["f_name"] = $_SESSION["s"]["name"];
            $per["f_tel"] = $_SESSION["s"]["tel"];
            $per["f_email"] = $_SESSION["s"]["email"];
            $per["f_des"] = $_SESSION["s"]["bio"];
        }
        $this->assigns["per"] = $per;

        $forms = $this->Competitions_form->get_by_comp($_id);
        if ($forms) {
            for ($f=0; $f<sizeof($forms); $f++) {
                if ($forms[$f]["type"] == "query") {
                    $forms[$f]["opts"] = explode(",", $forms[$f]["opt"]);
                }
                if ($per["id"]) {
                    $fr = $this->Competitions_form->get_by_form_user($forms[$f]["id"], $_per);
                    $forms[$f]["ress"] = $fr["res"];
                }
            }
        }

        $file = $this->Competitions_file->get_by_comp($_id);
        if ($file) {
            for ($j=0; $j<sizeof($file); $j++) {
                $f = $this->Competitions_files->get_by_file_user($file[$j]["id"], $_per);
                $file[$j][val] = $f["file"];
            }
        }    

        $st = $this->Startup_member->get_list_by_user($_SESSION["s"]["id"], "sm.status = 1");

        $this->assigns["st"] = $st;
        $this->assigns["st_f"] = $st[0];

        $res["form_file"] = $file;
        $res["forms"] = $forms;
        $this->assigns["res"] = $res;
        $this->assigns["pre"] = $_REQUEST["preview"];
        $this->sub();

        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }

        if ($my && ! $_per) {
            $_SESSION["msg"] = "이미 참가신청이 접수되었습니다.";
            header("Location: /challenge/views/".$_id);
        }

        if ( ! $res["logined"] && ! $_per && ! $_SESSION["s"]["id"]) 
        {
            $_SESSION["msg"] = "D.CAMP 회원이시면 누구나 신청 가능 합니다. 로그인 해주세요. ^^";
            header("Location: /challenge/views/".$_id);
        }
    }

    public function save_apply()
    {
        $this->tpl_name = "";
        if ($_REQUEST["competition_id"]) {
            $this->Competitions_apply->debug();
            $_id = $this->Competitions_apply->add($_REQUEST);
            
            $form = $this->Competitions_form->get_by_comp($_REQUEST["competition_id"]);
            if ($form) {
                $this->Competitions_form->del_form_res($_id);
                for ($f=0; $f<sizeof($form); $f++) {
                    if ($_REQUEST["form".$form[$f]["id"]]) {
                        $arr["apply_id"] = $_id;
                        $arr["c_form_id"] = $form[$f]["id"];
                        $arr["res"] = $_REQUEST["form".$form[$f]["id"]];
                        $this->Competitions_form->res_add($arr);
                    }
                }
            }
            $file = $this->Competitions_file->get_by_comp($_REQUEST["competition_id"]);
            if ($file) {
                $file_date_dir = $_REQUEST["competition_id"];
                if(! is_dir($this->settings->upload_path."/media/comp_file/".$file_date_dir)){
                    @mkdir($this->settings->upload_path."/media/comp_file/".$file_date_dir, 0777);
                    exec("chmod 777 ".$this->settings->upload_path."/media/comp_file/".$file_date_dir);
                }
                $len_file = sizeof($file);
                for ($i=0; $i<$len_file; $i++) {
                    $f = null;
                    if ($_FILES["file_".$file[$i]["id"]]["name"]) {
                        $f = make_upload("/media/comp_file/".$file_date_dir.'/', "file_".$file[$i]["id"]);
                        $_ar["file"] = $f;
                        $_ar["c_file_id"] = $file[$i]["id"];
                        $_ar["apply_id"] = $_id;
                        $this->Competitions_files->add($_ar);

                        if ($_REQUEST["o_file_".$file[$i]["id"]]) {
                            unlink($this->settings->root_path."media/comp_file/".$file_date_dir.'/'.$_REQUEST["o_file_".$file[$i]["id"]]);
                        }
                    }
                }
            }

            if ($_REQUEST["f_s_des"] && $_REQUEST["f_service"] && $_REQUEST["ser_id"]) {
                $arr3["startup_id"] = $_REQUEST["st_id"];
                $arr3["id"] = $_REQUEST["ser_id"];
                $arr3["name"] = $_REQUEST["f_service"];
                $arr3["des_ele"] = $_REQUEST["f_s_des"];
                $this->Startup_service->add2($arr3);
            }

            // activity
            // if (!$_REQUEST["id"])
            //     add_activity(1, $_REQUEST["user_id"], 1, $_REQUEST["user_id"], 0, "", Activity_model::E_TYPE_COMPETITION, $_REQUEST["competition_id"], 0);

            $_SESSION["msg"] = "경진 대회 참가 신청이 접수되었습니다.";
            if ($_SESSION["s"]["id"])
                header("Location: /member/edit_challenge/");
            else 
                header("Location: /challenge/views/".$_REQUEST["competition_id"]);

            exit(1);
        }     
    }

    public function applied_list($_id, $_page = 1)
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }
        if (!$_id) header("Location: /error_404");

        $examiner = $this->Competitions_examiner->get_by_comp_user_ex($_id, $_SESSION["s"]["id"], "c.ex_confirm = 1 and ce.status = 1");
        $op = $this->Competitions_examiner->operator_check($_id, $_SESSION["s"]["id"]);
        $pagesize = 10;
        $sort = $_REQUEST["sort"];
        if (!$sort) $sort = 1;
        $res = $this->Competitions->get($_id);
        $where = "ca.competition_id = ".$_id;
        if ($_SESSION["s"]["id"] != $res["user_id"] && $examiner) $where = $where." and ca.status = 1";
        if ($_REQUEST["search"]) $where = $where." and (f_name like '%".$_REQUEST["search"]."%' or f_team like '%".$_REQUEST["search"]."%')";
        
        if ($_REQUEST["alig"] == "up") $_sort = "score ASC";
        else if ($_REQUEST["alig"] == "down") $_sort = "score DESC";
        if ( ($_SESSION["s"]["id"] == $res["user_id"]) || $op) {
            $list = $this->Competitions_apply->list_info($_page, $pagesize, $where, "", $_sort);
        }
        else if ($examiner) {
            $list = $this->Competitions_apply->list_info_by_user($_page, $pagesize, $where, $_SESSION["s"]["id"], $_sort);
        }

        for ($i=0; $i<sizeof($list); $i++) {
            $u = $this->Members->get($list[$i]["user_id"]);
            $list[$i]["ids"] = $u["ids"];
            $list[$i]["name"] = $u["name"];
            $list[$i]["memail"] = $u["email"];
            $list[$i]["bio"] = $u["bio"];
            $list[$i]["picture"] = $u["picture"];
        }

        // dashboard
        $_sDate = str_replace(".", "-", $res["date_s"]);
        $_eDate = str_replace(".", "-", $res["date_e"]);
        if ($_eDate > date("Y-m-d")) $_eDate = date("Y-m-d");
        $term = dateDiff($_eDate, $_sDate, "-");
        // echo $term;
        for ($d=0; $d<$term+1; $d++) {
            $day = date("Y-m-d", strtotime("+$d day", strtotime($_sDate))); 
            $d_list[$d]["day"] = str_replace("-", ".", $day);
            $d_list[$d]["all"] = $this->Competitions_apply->cnt_out("ca.date_created like '".$day."%' and ca.competition_id = ".$_id);
            $d_list[$d]["rej"] = $this->Competitions_apply->cnt_out("ca.status = 2 and ca.date_created like '".$day."%' and ca.competition_id = ".$_id);
        }

        $this->assigns["d_list"] = array_reverse($d_list);
        $this->assigns["alig"] = $_REQUEST["alig"];
        $list_cnt = $this->Competitions_apply->cnt_out($where);
        $this->assigns["res"] = $res;
        $this->assigns["list"] = $list;
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["list_cnt"] = $list_cnt;
        $this->assigns["list_cnt_reject"] = $this->Competitions_apply->cnt_out("ca.status = 2 and ca.competition_id = ".$_id);
        $this->assigns["paging"] = get_paging_dot2($_page, $list_cnt, $pagesize);
        $this->assigns["sort"] = abs($sort);
        $this->sub();
        $this->assigns["tab"] = $_REQUEST["tab"];
        $this->assigns["m_list"] = $this->Competitions->get_list(1, 5, "c.user_id = ".$_SESSION["s"]["id"]);
        $this->assigns["e_list"] = $this->Competitions_examiner->list_all(1, 5, "ce.user_id = ".$_SESSION["s"]["id"]);
        $this->assigns["a_list"] = $this->Competitions_apply->list_all(1, 5, "ca.user_id = ".$_SESSION["s"]["id"]);
        $this->assigns["op"] = $op;
        $this->assigns["ex"] = $examiner;
        $this->assigns["search"] = $_REQUEST["search"];
        $this->get_process($res);

        if ($_SESSION["s"]["id"] != $res["user_id"] && !$examiner && !$op) 
            header("Location: /error_404");
    }

    public function applied_view($_id)
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }

        if (!$_id) header("Location: /error_404");

        $per = $this->Competitions_apply->get($_id);
        $per["com"] = $this->Startup_member->get_by_user($per["user_id"]);
        $res = $this->Competitions->get($per["competition_id"]);

        $file = $this->Competitions_file->get_by_comp($res["id"]);
        if ($file) {
            for ($j=0; $j<sizeof($file); $j++) {
                $f = $this->Competitions_files->get_by_file_user($file[$j]["id"], $_id);
                $file[$j][val] = $f["file"];
            }
        }
        $forms = $this->Competitions_form->get_by_comp($res["id"]);
        if ($forms) {
            for ($f=0; $f<sizeof($forms); $f++) {
                if ($forms[$f]["type"] == "query") {
                    $forms[$f]["opts"] = explode(",", $forms[$f]["opt"]);
                }
                if ($per["id"]) {
                    $fr = $this->Competitions_form->get_by_form_user($forms[$f]["id"], $_id);
                    $forms[$f]["ress"] = $fr["res"];
                }
            }
        }
        $res["form_file"] = $file;
        $res["forms"] = $forms;
        
        $examiner = $this->Competitions_examiner->get_by_comp_user_ex($res["id"], $_SESSION["s"]["id"], "c.ex_confirm = 1 and ce.status = 1");
        $op = $this->Competitions_examiner->operator_check($res["id"], $_SESSION["s"]["id"]);
        $score = $this->Competitions_score->get_by_comp($res["id"]);
        for ($i=0; $i<sizeof($score); $i++) {
            $scoring = $this->Competitions_scoring->get_scoring($_SESSION["s"]["id"], $per["id"], $score[$i]["id"]);
            $score[$i]["scoring"] = $scoring["score"];
            $score[$i]["memo"] = $scoring["memo"];
        }
        
        $this->assigns["res"] = $res;
        $this->assigns["per"] = $per;
        $this->assigns["examiner"] = $examiner;
        $this->assigns["op"] = $op;
        $this->assigns["score"] = $score;
        if ($examiner) {
            $this->assigns["cnt_all"] = $this->Competitions_apply->cnt_out('competition_id ='.$res["id"]." and ca.status = 1");
            $c = $this->Competitions_scoring->get_apply_by_ex_score_out($res["id"], $_SESSION["s"]["id"]);
            $this->assigns["cnt_end"] = sizeof($c);
        }
        if ($_SESSION["s"]["id"] == $res["user_id"] || $op) {
            // 심사결과
            $ex_user = $this->Competitions_examiner->get_by_comp($res["id"], "", "", "ce.status = 1");
            for ($e=0; $e<sizeof($ex_user); $e++) {
                $total_ = 0;
                for ($s=0; $s<sizeof($score); $s++) {
                    $scoring = $this->Competitions_scoring->get_scoring($ex_user[$e]["user_id"], $per["id"], $score[$s]["id"]);
                    $total_ = $total_ + $scoring["score"];
                    $ex_user[$e]["score"][$s]["name"] = $score[$s]["name"];
                    $ex_user[$e]["score"][$s]["scoring"] = $scoring["score"];
                    $ex_user[$e]["score"][$s]["memo"] = $scoring["memo"];
                    $ex_user[$e]["total"] = $total_;
                }
            }
            $this->assigns["ex_user"] = $ex_user;
            $this->assigns["prev"] = $this->Competitions_apply->get_current($_id, $res["id"], 0);
            $this->assigns["next"] = $this->Competitions_apply->get_current($_id, $res["id"], 1);

            $this->assigns["cnt_a_all"] = $this->Competitions_apply->cnt_out( "ca.competition_id =".$res["id"]);
            $this->assigns["cnt_a_suc"] = $this->Competitions_apply->cnt_out("ca.status = 1 and ca.competition_id =".$res["id"]);
            $this->assigns["cnt_a_pre"] = $this->Competitions_apply->cnt_out("ca.status = 0 and ca.competition_id =".$res["id"]);
            $this->assigns["cnt_a_rej"] = $this->Competitions_apply->cnt_out("ca.status = 2 and ca.competition_id =".$res["id"]);
        }
        if($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
        $this->sub();
        
        if ($_SESSION["s"]["id"] != $per["user_id"] && !$examiner && $_SESSION["s"]["id"] != $res["user_id"] && !$op) 
            header("Location: /error_404");
    }

    public function examiner($_id = '')
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }
        if (!$_id) header("Location: /error_404");

        $examiner = $this->Competitions_examiner->get_by_comp_user_ex($_id, $_SESSION["s"]["id"], "c.ex_confirm = 1 and ce.status = 1");
        $op = $this->Competitions_examiner->operator_check($_id, $_SESSION["s"]["id"]);
        $pagesize = 10;
        $sort = $_REQUEST["sort"];
        if (!$sort) $sort = 1;
        $res = $this->Competitions->get($_id);
        $where = "ca.competition_id = ".$_id;
        if ($_SESSION["s"]["id"] != $res["user_id"] && $examiner) $where = $where." and ca.status = 1";
        
        if ($_REQUEST["alig"] == "up") $_sort = "score ASC";
        else if ($_REQUEST["alig"] == "down") $_sort = "score DESC";
        if ( ($_SESSION["s"]["id"] == $res["user_id"]) || $op) {
            $list = $this->Competitions_apply->list_info($_page, $pagesize, $where, "", $_sort);
        }
        else if ($examiner) {
            $list = $this->Competitions_apply->list_info_by_user($_page, $pagesize, $where, $_SESSION["s"]["id"], $_sort);
        }


        $this->assigns["res"] = $res;
        $this->sub();

        $this->assigns["m_list"] = $this->Competitions->get_list(1, 5, "c.user_id = ".$_SESSION["s"]["id"]);
        $this->assigns["e_list"] = $this->Competitions_examiner->list_all(1, 5, "ce.user_id = ".$_SESSION["s"]["id"]);
        $this->assigns["a_list"] = $this->Competitions_apply->list_all(1, 5, "ca.user_id = ".$_SESSION["s"]["id"]);
        $this->assigns["op"] = $op;
        $this->assigns["ex"] = $examiner;
        if ($_SESSION["s"]["id"] != $res["user_id"] && !$examiner && !$op) 
            header("Location: /error_404");

        $opr = $this->Competitions_examiner->operator_check($res["id"], $_SESSION["s"]["id"]);
        
        $this->get_process($res);
        
        if ($_SESSION["s"]["id"] != $res["user_id"] && !$opr) 
            header("Location: /error_404");
    }

    public function operator($_id = '')
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }
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
        $this->sub();

        $this->assigns["m_list"] = $this->Competitions->get_list(1, 5, "c.user_id = ".$_SESSION["s"]["id"]);
        $this->assigns["e_list"] = $this->Competitions_examiner->list_all(1, 5, "ce.user_id = ".$_SESSION["s"]["id"]);
        $this->assigns["a_list"] = $this->Competitions_apply->list_all(1, 5, "ca.user_id = ".$_SESSION["s"]["id"]);
        $this->assigns["op"] = $op;

        $opr = $this->Competitions_examiner->operator_check($res["id"], $_SESSION["s"]["id"]);
        
        $this->get_process($res);
        
        if ($_SESSION["s"]["id"] != $res["user_id"] && !$opr) 
            header("Location: /error_404");
    }

    public function winner($_id = '')
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }

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
        $result = $this->Competitions->get($_id);
        $this->assigns["res"] = $result;
        $this->sub();

        $this->assigns["m_list"] = $this->Competitions->get_list(1, 5, "c.user_id = ".$_SESSION["s"]["id"]);
        $this->assigns["e_list"] = $this->Competitions_examiner->list_all(1, 5, "ce.user_id = ".$_SESSION["s"]["id"]);
        $this->assigns["a_list"] = $this->Competitions_apply->list_all(1, 5, "ca.user_id = ".$_SESSION["s"]["id"]);
        $this->assigns["op"] = $op;

        $opr = $this->Competitions_examiner->operator_check($result["id"], $_SESSION["s"]["id"]);
        
        $this->get_process($result);
        
        if ($_SESSION["s"]["id"] != $result["user_id"] && !$opr) 
            header("Location: /error_404");
    }

//create

    public function edit($_id = '')
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }

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

            for ($d=2; $d<$_REQUEST["dpt_cnt"]+1; $d++) {
                if ($_REQUEST["dpt".$d]) {
                    $this->Competitions->debug();
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
                
            $_SESSION["msgt"] = 1;
            header("Location: /member/edit_challenge_m");
        }
        
        if ($_id) {
            $res = $this->Competitions->get($_id);
            $res["a_file"] = $this->Competitions->get_a_file($_id);
            $res["dpt_l"] = $this->Competitions->get_department_group($_id);
            
            $opr = $this->Competitions_examiner->operator_check($res["id"], $_SESSION["s"]["id"]);
            
            $this->assigns["res"] = $res;

            if ($_SESSION["s"]["id"] != $res["user_id"] && !$opr) 
                header("Location: /error_404");

            $this->get_process($res);
        }
    }

    public function edit_next($_id = '')
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }

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
            
            $opr = $this->Competitions_examiner->operator_check($res["id"], $_SESSION["s"]["id"]);
            
            $this->assigns["res"] = $res;

            if ($_SESSION["s"]["id"] != $res["user_id"] && !$opr) 
                header("Location: /error_404");

            $this->get_process($res);
        }

        if($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }

    public function apply_info($_id = '')
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }

        if (!$_id) header("Location: /error_404");

        // template add
        if ($_REQUEST["template"]) {
            $t = $this->Competitions->get($_REQUEST["template"]);
            if (! $t) {
                $_SESSION["msg"] = "적용할 수 없는 템플릿 입니다.";
                header("Location: /challenge/apply_info/".$_id);
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
        $opr = $this->Competitions_examiner->operator_check($res["id"], $_SESSION["s"]["id"]);
        
        $this->assigns["res"] = $res;
        $this->get_process($res);
        
        if ($_SESSION["s"]["id"] != $res["user_id"] && !$opr) 
            header("Location: /error_404");

        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }

        if ($_SESSION["msgt"]) {
            $this->assigns["msgt"] = 1;
            unset($_SESSION["msgt"]);
        }
    }
    
    public function score_info($_id = '')
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }

        if (!$_id) header("Location: /error_404");
        
        if ($_REQUEST["score"]) {
            $this->Competitions->add($_REQUEST);
            $this->assigns["msgt"] = 1;
        }
        $res = $this->Competitions->get($_id);
        $opr = $this->Competitions_examiner->operator_check($res["id"], $_SESSION["s"]["id"]);
        
        $this->assigns["res"] = $res;

        $score = $this->Competitions_score->get_by_comp($_id);
        $this->assigns["score"] = $score;
        
        $this->get_process($res);
        
        if ($_SESSION["s"]["id"] != $res["user_id"] && !$opr) 
            header("Location: /error_404");
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

    public function pending() 
    {

        $res = $this->Competitions->get($_REQUEST["id"]);
        $user[0] = $this->Competitions_examiner->get_by_email($_REQUEST["e"], $_REQUEST["id"]);
        $this->assigns["is_expired"] = true;
        if (!$user[0]) 
            $user = $this->Competitions_examiner->get_by_comp($_REQUEST["id"], '', '', 'm.email = "'.$_REQUEST["e"].'"');
        if($res["date_e"] >= date("Y.m.d")) $this->assigns["is_expired"] = false;
        if ( $res && $user[0]) {
            $this->assigns["res"] = $res;
            $this->assigns["u"] = $user[0];
        }
        else {
            header("Location: /error_404");
        }
    }

    public function pending_pool($_id)
    {
        $res = $this->Competitions_examiner->get($_id);
        if ($res) {
            $ch = $this->Competitions_examiner->cnt_outer("ce.id = ".$_id." and (m.email = '".$_REQUEST["e"]."' or ce.email = '".$_REQUEST["e"]."')");
            if ($ch) {
                $u = $this->Competitions_examiner->list_outer(1, 1, 'ce.id = '.$_id);
                $this->assigns["u"] = $u[0];
            }
            else {
                header("Location: /error_404");
            }
        }
        else {
            header("Location: /error_404");
        } 
    }

    public function applied_excel_old($_id)
    {
        $r = $this->Competitions->get($_id);
        if (! $_SESSION["s"]["id"]){
            header("Location: /");
        }

        $this->layout = "";
        $ex = $this->Competitions_examiner->get_by_comp_user($_id, $_SESSION["s"]["id"]);
        if ($ex && $r["user_id"] != $_SESSION["s"]["id"]) {
            $res = $this->Competitions_apply->list_out(1,1000, "ca.status = 1 and ca.competition_id = ".$_id);
        }
        else 
            $res = $this->Competitions_apply->list_out(1,1000, "ca.competition_id = ".$_id);
        $score = $this->Competitions_score->get_by_comp($_id);
        $len_res = sizeof($res);

        header( "Content-type: application/vnd.ms-excel; charset=euc-kr" );
        header( "Content-Disposition: attachment; filename=competition_applied_list_".$_id.".xls" );
        header( "Content-Description: PHP4 Generated Data" );
        Print("<Meta Http-Equiv=\"Content-Type\" Content=\"Application/Vnd.Ms-Excel; Charset=UTF-8\">");

        echo "
        <table>
        <tr>
        <td>id</td>
        <td>신청자</td>
        <td>신청자 이메일</td>
        <td>회사/팀</td>
        <td>신청일자</td>
        <td>접수상태</td>
        <td>반려사유</td>
        
        ";
        if (sizeof($score) > 0) {
            for ($k=0; $k<sizeof($score); $k++) {
                echo "<td>[점수]".$score[$k]["name"]."</td>";
            }
            echo "<td>[점수] 총점</td>";
        }
        echo "
        <td>파일</td>
        </tr>";

        for($i=0; $i<$len_res; $i++) {
            if (!$res[$i]["status"])$res[$i]["status_kr"] = "접수대기";
            else if ($res[$i]["status"] == 1)$res[$i]["status_kr"] = "접수";
            else if ($res[$i]["status"] == 2)$res[$i]["status_kr"] = "반려";

            if (! $res[$i]["name"]) $res[$i]["name"] = $res[$i]["f_name"];
            if (! $res[$i]["memail"]) $res[$i]["memail"] = $res[$i]["f_email"];
            if (! $res[$i]["team"]) $res[$i]["team"] = $res[$i]["f_team"];
            
            echo "<tr><td>".$res[$i]["id"]."</td><td>".$res[$i]["name"]."</td><td>".$res[$i]["memail"]."</td><td>".$res[$i]["team"]."</td><td>".$res[$i]["date_created"]."</td><td>".$res[$i]["status_kr"]."</td><td>".$res[$i]["status_des"]."</td>";

            if (sizeof($score) > 0) {
                $tot = 0;
                for ($l=0; $l<sizeof($score); $l++) {
                    $s = $this->Competitions_scoring->get_only_score($res[$i]["id"], $score[$l]["id"]);
                    $tot = $tot + $s["score"];
                    echo "<td>".$s["score"]."</td>";
                }
                echo "<td>".$tot."</td>";
            }

            $file = $this->Competitions_files->get_by_apply($res[$i]["id"]);
            for ($j=0; $j<sizeof($file); $j++) {
                if ($file[$j]["file"]) echo "<td>".$this->settings->main_service_url."/challenge/get_source/?file=".$file[$j]["file"]."</td>";
            }
            echo "</tr>";
        }

        echo "
        </table>
        ";
        exit(1);

    }

    public function applied_excel($_id)
    {
        $r = $this->Competitions->get($_id);
        if (! $_SESSION["s"]["id"]){
            header("Location: /");
        }

        $this->layout = "";
        $ex = $this->Competitions_examiner->get_by_comp_user($_id, $_SESSION["s"]["id"]);
        if ($ex && $r["user_id"] != $_SESSION["s"]["id"]) {
            $res = $this->Competitions_apply->list_out(1,1000, "ca.status = 1 and ca.competition_id = ".$_id);
        }
        else 
            $res = $this->Competitions_apply->list_out(1,1000, "ca.competition_id = ".$_id);
        $score = $this->Competitions_score->get_by_comp($_id);
        $len_res = sizeof($res);

        require_once "../tf_app/ext/php_excel/PHPExcel.php";        
        $objPHPExcel = new PHPExcel();
         
        //기본 속성
        $objPHPExcel->getDefaultStyle()->getFont()->setName(iconv("EUC-KR","UTF-8"));
        
        // //시트명
        $objPHPExcel->setActiveSheetIndex(0);
        $objPHPExcel->getActiveSheet()->setTitle("참가자 기본 정보");

        //값 입력
        $objPHPExcel->getActiveSheet()->setCellValue('A1', '회원 ID')
                                      ->setCellValue('B1', '회원명')
                                      ->setCellValue('C1', '등록 이메일')
                                      ->setCellValue('D1', '접수상태')
                                      ->setCellValue('E1', '반려사유')
                                      ->setCellValue('F1', '평가 총점');
        
        for ($i=0; $i<$len_res; $i++)
        {    
            
            if ($res[$i]["status"] == 0) $res[$i]["status_kr"] = "접수대기";
            else if ($res[$i]["status"] == 1) $res[$i]["status_kr"] = "접수";
            else if ($res[$i]["status"] == 2) $res[$i]["status_kr"] = "반려";

            if (! $res[$i]["name"]) $res[$i]["name"] = $res[$i]["f_name"];
            if (! $res[$i]["memail"]) $res[$i]["memail"] = $res[$i]["f_email"];
            if (! $res[$i]["team"]) $res[$i]["team"] = $res[$i]["f_team"];

            if (sizeof($score) > 0) {
                $tot = 0;
                for ($l=0; $l<sizeof($score); $l++) {
                    $s = $this->Competitions_scoring->get_only_score($res[$i]["id"], $score[$l]["id"]);
                    $tot = $tot + $s["score"];
                }
            }
            $j = $i+2;    
            // Add some data
            $objPHPExcel->setActiveSheetIndex(0)
                        ->setCellValue("A$j", $res[$i]["ids"])
                        ->setCellValue("B$j", $res[$i]["name"])
                        ->setCellValue("C$j", $res[$i]["memail"])
                        ->setCellValue("D$j", $res[$i]["status_kr"])
                        ->setCellValue("E$j", $res[$i]["status_des"])
                        ->setCellValue("F$j", $tot);
        } 

        // Create a new worksheet, after the default sheet
        $objPHPExcel->createSheet();
        
        //시트명
        $objPHPExcel->setActiveSheetIndex(1);
        $objPHPExcel->getActiveSheet()->setTitle("지원서 내용");
        
        //값 입력
        $cols = array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N'
                , 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');

        $or = 0;
        if (($r["basic"] & 1) == 1) {
            $objPHPExcel->getActiveSheet()->setCellValue($cols[$or].'1', '참가자 이름');    
            $col1 = $cols[$or];
            $or++;
        }
        if (($r["basic"] & 2) == 2) {
            $objPHPExcel->getActiveSheet()->setCellValue($cols[$or].'1', '휴대폰 번호');    
            $col2 = $cols[$or];
            $or++;
        }
        if (($r["basic"] & 4) == 4) {
            $objPHPExcel->getActiveSheet()->setCellValue($cols[$or].'1', '이메일 주소');    
            $col4 = $cols[$or];
            $or++;
        }
        if (($r["basic"] & 8) == 8) {
            $objPHPExcel->getActiveSheet()->setCellValue($cols[$or].'1', '간단한 자기소개');    
            $col8 = $cols[$or];
            $or++;
        }
        if (($r["basic"] & 16) == 16) {
            $objPHPExcel->getActiveSheet()->setCellValue($cols[$or].'1', '팀 소개');    
            $col16 = $cols[$or];
            $or++;
        }
        if (($r["basic"] & 32) == 32) {
            $objPHPExcel->getActiveSheet()->setCellValue($cols[$or].'1', '참가회사 / 팀명');    
            $col32 = $cols[$or];
            $or++;
        }
        if (($r["basic"] & 64) == 64) {
            $objPHPExcel->getActiveSheet()->setCellValue($cols[$or].'1', '제품/서비스명');    
            $col64 = $cols[$or];
            $or++;
        }
        if (($r["basic"] & 128) == 128) {
            $objPHPExcel->getActiveSheet()->setCellValue($cols[$or].'1', '제품/서비스 한 줄 소개');    
            $col128 = $cols[$or];
            $or++;
        }

        $form = $this->Competitions_form->get_by_comp($r["id"]);
        for ($f=0; $f<sizeof($form); $f++) {
            $objPHPExcel->getActiveSheet()->setCellValue($cols[$or].'1', $form[$f]["title"]);  
            $col[$form[$f]["id"]] = $cols[$or];  
            $or++;
        }
        $file = $this->Competitions_file->get_by_comp($r["id"]);
        for ($f=0; $f<sizeof($file); $f++) {
            $objPHPExcel->getActiveSheet()->setCellValue($cols[$or].'1', $file[$f]["title"]);    
            $col[$file[$f]["id"].'_f'] = $cols[$or];
            $or++;
        }
        // exit(1);
        $row = 2;
        for ($ii=0; $ii<$len_res; $ii++)
        {        
            if (($r["basic"] & 1) == 1) {
                $objPHPExcel->setActiveSheetIndex(1)
                        ->setCellValue($col1."$row", $res[$ii]["f_name"]);    
            }
            if (($r["basic"] & 2) == 2) {
                $objPHPExcel->setActiveSheetIndex(1)
                        ->setCellValue($col2."$row", $res[$ii]["f_tel"]);
            }
            if (($r["basic"] & 4) == 4) {
                $objPHPExcel->setActiveSheetIndex(1)
                        ->setCellValue($col4."$row", $res[$ii]["f_email"]);
            }
            if (($r["basic"] & 8) == 8) {
                $objPHPExcel->setActiveSheetIndex(1)
                        ->setCellValue($col8."$row", $res[$ii]["f_des"]);
            }
            if (($r["basic"] & 16) == 16) {
                $objPHPExcel->setActiveSheetIndex(1)
                        ->setCellValue($col16."$row", $res[$ii]["f_t_des"]);
            }
            if (($r["basic"] & 32) == 32) {
                $objPHPExcel->setActiveSheetIndex(1)
                        ->setCellValue($col32."$row", $res[$ii]["f_team"]);
            }
            if (($r["basic"] & 64) == 64) {
                $objPHPExcel->setActiveSheetIndex(1)
                        ->setCellValue($col64."$row", $res[$ii]["f_service"]);
            }
            if (($r["basic"] & 128) == 128) {
                $objPHPExcel->setActiveSheetIndex(1)
                        ->setCellValue($col128."$row", $res[$ii]["f_s_des"]);
            }

            for ($f=0; $f<sizeof($form); $f++) {
                $f_r = $this->Competitions_form->get_by_form_res_user($form[$f]["id"], $res[$ii]["id"]);
                if ($f_r["type"] == 'query') {
                    $ar = explode(",", $f_r["opt"]);
                    $f_r["ress"] = $ar[$f_r["res"] - 1];
                    $f_r["res"] = $f_r["res"].". ".$f_r["ress"];
                }
                if ($f_r)
                    $objPHPExcel->setActiveSheetIndex(1)
                        ->setCellValue($col[$form[$f]["id"]].$row, $f_r["res"]);
            }

            for ($ff=0; $ff<sizeof($file); $ff++) {
                $ff_r = $this->Competitions_files->get_by_file_user($file[$ff]["id"], $res[$ii]["id"]);
                if ($ff_r)
                    $objPHPExcel->setActiveSheetIndex(1)
                        ->setCellValue($col[$file[$ff]["id"].'_f'].$row, 'http://dcamp.kr/challenge/get_source?cp='.$r["id"].'&file='.$ff_r["file"]);
            }

            $row++;
            
        } 

        $filename = "competition_applied_list_".$_id;
         
        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition: attackment;filename="'.$filename.'.xls"');
        header('Cashe-Control: max-age=0');
        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'EXCEL5');
        $objWriter->save('php://output');
         
        exit(1);

    }

    public function examine_excel($_id)
    {
        $this->layout = "";

        $ex_user = $this->Competitions_examiner->get_by_comp($_id);
        for ($e=0; $e<sizeof($ex_user); $e++) {
            $total_ = 0;
            for ($s=0; $s<sizeof($score); $s++) {
                $scoring = $this->Competitions_scoring->get_scoring($ex_user[$e]["user_id"], $per["id"], $score[$s]["id"]);
                $total_ = $total_ + $scoring["score"];
                $ex_user[$e]["total"] = $total_;
            }
        }
        $ex = "";
        for ($l=0; $l<sizeof($ex_user); $l++) {
            $ex = $ex . "<td>".$ex_user[$l]["name"]."</td>";
        }

        $res = $this->Competitions_apply->list_out(1,1000, "ca.competition_id = ".$_id." and status = 1");
        $score = $this->Competitions_score->get_by_comp($_id);
        $len_res = sizeof($res);

        header( "Content-type: application/vnd.ms-excel; charset=euc-kr" );
        header( "Content-Disposition: attachment; filename=competition_examine_list_".$_id.".xls" );
        header( "Content-Description: PHP4 Generated Data" );
        Print("<Meta Http-Equiv=\"Content-Type\" Content=\"Application/Vnd.Ms-Excel; Charset=UTF-8\">");

        echo "
        <table>
        <tr>
        <td>no</td>
        <td>회사 / 참가자</td>
        <td>심사항목 \ 심사위원</td>
        ".$ex."
        <td>최종점수</td>
        <td>순위</td>        
        </tr>";

        $len_e_sc = sizeof($score) + 1;
        $len = $len_res * $len_e_sc;

        for($i=0; $i<$len; $i++) {
            echo "<tr>";

            if ($i % $len_e_sc == 0) {
                $o = floor($i / $len_e_sc) + 1;
                if (! $res[$i / $len_e_sc]["team"]) $res[$i / $len_e_sc]["team"] = $res[$i / $len_e_sc]["f_team"];
                if (! $res[$i / $len_e_sc]["name"]) $res[$i / $len_e_sc]["name"] = $res[$i / $len_e_sc]["f_name"];
                echo "<td rowspan=".$len_e_sc.">".$o."</td><td rowspan=".$len_e_sc.">".$res[$i / $len_e_sc]["team"]."/".$res[$i / $len_e_sc]["name"]."</td>";
            }
            // else {
            //     echo "<td></td><td></td>";
            // }
            // $o = floor($i / 5) + 1;
            // echo "<td>".$o."</td><td>".$res[$i / 5]["team"]."/".$res[$i / 5]["name"]."</td>";

                if (($i+1) % $len_e_sc != 0) {
                    echo "<td>".$score[$i%$len_e_sc]["name"]."</td>";
                } else {
                    echo "<td>합계</td>";
                }

                // 심사위원별 점수
                for ($n=0; $n<sizeof($ex_user); $n++) {
                    if (($i+1) % $len_e_sc != 0) {
                        $s = $this->Competitions_scoring->get_scoring($ex_user[$n]["user_id"], $res[$i / $len_e_sc]["id"], $score[$i%$len_e_sc]["id"]);
                        echo "<td>".$s["score"]."</td>";
                    }
                    else {
                        $s = $this->Competitions_scoring->get_tot_score($res[$i / $len_e_sc]["id"], $ex_user[$n]["user_id"]);
                        echo "<td>".$s."</td>";
                    }
                }

            if ($i % $len_e_sc == 0) {
                $ss = $this->Competitions_scoring->get_tot_score($res[$i / $len_e_sc]["id"]);
                echo "<td rowspan=".$len_e_sc.">".$ss."</td><td rowspan=".$len_e_sc."></td>";
                echo "</tr>";
            }
            // else {
            //     echo "<td></td><td></td>";
            // }
            // $ss = $this->Competitions_scoring->get_tot_score($res[$i / 5]["id"]);
            // echo "<td>".$ss."</td><td></td>";
            // echo "</tr>";
        }

        echo "
        </table>
        ";
        exit(1);
    } 

    public function get_source()
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }
        
        $this->tpl_name = "";
        
        $filename = trim($_REQUEST["file"]); 
        $file = "./media/comp_file/".$_REQUEST["cp"]."/$filename"; 
        $file_size = filesize($file); 
        $filename = urlencode("$filename");

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

        if (is_file("$file")) { 
        $fp = fopen("$file", "r"); 
        if (!fpassthru($fp)) 
        fclose($fp); 
        }
    }

    public function get_cp_source()
    {
        $this->tpl_name = "";
        $cp = $this->Competitions->get($_REQUEST["cp"]);

        $filename = trim($cp["file_url"]); 
        $file = "./media/comp_file/$filename"; 
        $file_size = filesize($file); 
        $filename = urlencode("$filename");

        if( strpos($_SERVER['HTTP_USER_AGENT'], 'MSIE') || strpos($_SERVER['HTTP_USER_AGENT'], 'Trident') ) { 
        
        $_REQUEST['file'] = iconv('utf-8', 'euc-kr', $_REQUEST['file']);

        header("Content-Type: doesn/matter"); 
        Header("Content-Length: ".filesize("$file"));
        Header("Content-Disposition: attachment; filename=".trim($_REQUEST['file'])); 
        header("Content-Transfer-Encoding: binary"); 
        header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
        header('Pragma: public');
        header("Expires: 0"); 
        
        } else { 

        Header("Content-type: file/unknown"); 
        Header("Content-Disposition: attachment; filename=".trim($_REQUEST['file'])); 
        Header("Content-Transfer-Encoding: binary");
        Header("Content-Length: ".filesize($file));
        Header("Content-Description: PHP3 Generated Data"); 
        header("Pragma: no-cache"); 
        header("Expires: 0"); 
        } 

        if (is_file("$file")) { 
        $fp = fopen("$file", "r"); 
        if (!fpassthru($fp)) 
        fclose($fp); 
        }
    }
    

    public function get_cp_file()
    {
        $this->tpl_name = "";
        $cp = $this->Competitions->get_a_file($_REQUEST["cid"], $_REQUEST["fid"]);

        $filename = trim($cp["file"]); 
        $file = "./media/comp_file/$filename"; 
        $file_size = filesize($file); 
        $filename = urlencode("$filename");

        if( strpos($_SERVER['HTTP_USER_AGENT'], 'MSIE') || strpos($_SERVER['HTTP_USER_AGENT'], 'Trident') ) { 
            $_REQUEST['file'] = iconv('utf-8', 'euc-kr', $_REQUEST['file']);
            header("Content-Type: doesn/matter"); 
            Header("Content-Length: ".filesize("$file"));
            Header("Content-Disposition: attachment; filename=".trim($_REQUEST['file'])); 
            header("Content-Transfer-Encoding: binary"); 
            header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
            header('Pragma: public');
            header("Expires: 0"); 
        } else { 
            Header("Content-type: file/unknown"); 
            Header("Content-Disposition: attachment; filename=".trim($_REQUEST['file'])); 
            Header("Content-Transfer-Encoding: binary");
            Header("Content-Length: ".filesize($file));
            Header("Content-Description: PHP3 Generated Data"); 
            header("Pragma: no-cache"); 
            header("Expires: 0"); 
        } 

        if (is_file("$file")) { 
        $fp = fopen("$file", "r"); 
        if (!fpassthru($fp)) 
        fclose($fp); 
        }
    }     

    public function applied_files($_id)
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }

        // zip create
        require_once('../tf_app/ext/pclzip.lib.php');
        $archive = new PclZip('../web/media/test/challenge_'.$_id.'.zip');

        $v_dir = getcwd()."/media/comp_file";
        $v_folder = "/".$_id;

        $v_list = $archive->create($v_dir.$v_folder,
                PCLZIP_OPT_REMOVE_PATH, $v_dir,
                PCLZIP_OPT_ADD_TEMP_FILE_ON);
        if ($v_list == 0) {
            die("Error : ".$archive->errorInfo(true));
        }

        // zip download
        $filename = 'challenge_'.$_id.'.zip'; 
        $file = "./media/test/$filename"; 
        $file_size = filesize($file); 
        $filename = urlencode("$filename");

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

        if (is_file("$file")) { 
            $fp = fopen("$file", "r"); 
            if (!fpassthru($fp)) 
                echo 11;fclose($fp);
        }

        unlink("media/test/$filename");
    }   
}
?>
