<?
class Ajax_v3 extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "";
    var $use_models = array("Competitions_form", "Competitions_file", "Competitions"
            , "Competitions_examiner", "Startup_member", "Members", "Startup_service"
            , "Competitions_apply", "Competitions_scoring", "Competitions_files"
            , "Competitions_score", "Recruit", "Recruit_opt", "Banner", "Activity"
            , "Program", "Program_file", "Program_form", "Program_apply", "Startup"
            , "Board", "Code", "Space_reserve", "Event", "Office_hours");

    public function before_calling()
    {
        $this->assigns["s"] = $_SESSION["s"];
    }
    
// challenge

    public function get_service_list($_id)
    {
        $this->assigns["res"] = $this->Startup_service->list_($_id);
    }

    public function more_challenge($_status , $_type = '' , $_page = '')
    {
        $_pagesize = 10;
        $where = "c.status = 1 and c.open = 1 ";
        if ($_status == 'ing') $where = $where .' and concat(date_e, time_e) >= "'. date('Y.m.dH:i').'"';
        else if ($_status == 'end') $where = $where .' and  concat(date_e, time_e) < "'. date('Y.m.dH:i').'"';

        $order = "c.date_created DESC";
        if ($_type) $order = "concat(date_e, time_e) DESC";;  

        $res = $this->Competitions->get_list($_page, $_pagesize, $where, $order);

        $this->assigns["res"] = $res;
    }

    public function get_ex_list_all($_id, $_type, $_page, $_div)
    {
        $pagesize = 5;
        if ($_type == 'all') {
            $res = $this->Competitions_apply->list_out($_page, $pagesize, "ca.competition_id = ".$_id." and ca.status = 1");
            for ($ee=0; $ee<sizeof($res); $ee++) {
                $res[$ee]["score"] = $this->Competitions_scoring->get_tot_score($res[$ee]["id"], $_SESSION["s"]["id"]);
            }
            $res_cnt = $this->Competitions_apply->cnt_out("ca.competition_id = ".$_id." and ca.status = 1");
        }
        else if ($_type == 'end') {
            $res = $this->Competitions_scoring->get_apply_by_ex_score_out($_id, $_SESSION["s"]["id"], $_page, $pagesize);
            $r_c = $this->Competitions_scoring->get_apply_by_ex_score_out($_id, $_SESSION["s"]["id"]);
            $res_cnt = sizeof($r_c);
        }
        else if ($_type == 'yet') {
            $s = $this->Competitions_scoring->get_apply_by_ex_score_out($_id, $_SESSION["s"]["id"], '', '', 'ca.id');
            $a_l = '';
            for ($i=0; $i<sizeof($s); $i++) {
                if ($i == 0) $a_l = $s[$i]["id"];
                else $a_l = $a_l. "," .$s[$i]["id"];
            }
            $w = "status = 1 and competition_id = ".$_id. " and ca.id NOT IN (" .$a_l. ")";
            if ($a_l == '') $w = "status = 1 and competition_id = ".$_id;
            $res = $this->Competitions_apply->list_out($_page, $pagesize, $w);
            $res_cnt  = $this->Competitions_apply->cnt_out($w);
        }
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["res"] = $res;
        $this->assigns["id"] = $_id;
        $this->assigns["div"] = $_div;
        $this->assigns["type"] = $_type;
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["paging"] = get_paging_dot3($_page, $res_cnt, $pagesize);
    }

    public function get_apply($_id)
    {

        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }

        if (!$_id) header("Location: /error_404");

        $per = $this->Competitions_apply->get($_id);
        $per["com"] = $this->Startup_member->get_by_user($per["user_id"]);
        $res = $this->Competitions->get($per["competition_id"]);
        if ($res["id"] > 134) {
            $this->tpl_name = "get_apply_ch";
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
                $this->assigns["cnt_all"] = $this->Competitions_apply->cnt('competition_id ='.$res["id"]." and ca.status = 1");
                $c = $this->Competitions_scoring->get_apply_by_ex_score($res["id"], $_SESSION["s"]["id"]);
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

                $this->assigns["cnt_a_all"] = $this->Competitions_apply->cnt( "ca.competition_id =".$res["id"]);
                $this->assigns["cnt_a_suc"] = $this->Competitions_apply->cnt("ca.status = 1 and ca.competition_id =".$res["id"]);
                $this->assigns["cnt_a_pre"] = $this->Competitions_apply->cnt("ca.status = 0 and ca.competition_id =".$res["id"]);
                $this->assigns["cnt_a_rej"] = $this->Competitions_apply->cnt("ca.status = 2 and ca.competition_id =".$res["id"]);
            }
        }
        else {
            $examiner = $this->Competitions_examiner->get_by_comp_user($res["id"], $_SESSION["s"]["id"]);
            $op = $this->Competitions_examiner->operator_check($res["id"], $_SESSION["s"]["id"]);

            if ($_SESSION["s"]["id"] != $res["user_id"] && !$examiner && !$op) {
                header("Location: /error_404");
            }
                

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
                $this->assigns["prev"] = $this->Competitions_apply->get_current($_id, $res["id"], 0, 'status = 1');
                $this->assigns["next"] = $this->Competitions_apply->get_current($_id, $res["id"], 1, 'status = 1');

                $this->assigns["cnt_all"] = $this->Competitions_apply->cnt('competition_id ='.$res["id"]." and ca.status = 1");
                $c = $this->Competitions_scoring->get_apply_by_ex_score($res["id"], $_SESSION["s"]["id"]);
                $this->assigns["cnt_end"] = sizeof($c);
            }
            if ($_SESSION["s"]["id"] == $res["user_id"]) {
                // 심사결과
                $ex_user = $this->Competitions_examiner->get_by_comp($res["id"]);
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

                $this->assigns["cnt_a_all"] = $this->Competitions_apply->cnt( "ca.competition_id =".$res["id"]);
                $this->assigns["cnt_a_suc"] = $this->Competitions_apply->cnt("ca.status = 1 and ca.competition_id =".$res["id"]);
                $this->assigns["cnt_a_pre"] = $this->Competitions_apply->cnt("ca.status = 0 and ca.competition_id =".$res["id"]);
                $this->assigns["cnt_a_rej"] = $this->Competitions_apply->cnt("ca.status = 2 and ca.competition_id =".$res["id"]);
            }
        }
    }

    public function add_comp_form($_id = '')
    {
        if ($_REQUEST["title"]) {
            if ($_REQUEST["opt"]) {
                $_REQUEST["opts"] = explode(",", $_REQUEST["opt"]);
            }
            $this->assigns["ress"] = $_REQUEST;
        }
        if ($_id) $this->assigns["ress"]["competition_id"] = $_id;
    }

    public function add_comp_form_file($_id = '')
    {
        if ($_REQUEST["title"]) {
            $this->assigns["ress"] = $_REQUEST;
        }
        if ($_id) $this->assigns["ress"]["competition_id"] = $_id;
    }

    public function edit_comp_form()
    {
        if ($_REQUEST["type"] == 'file') {
            $_id = $this->Competitions_file->add($_REQUEST);    
        }
        else {
            if ($_REQUEST["type"] == 'query') {
                $_REQUEST["opt"] = '';
                $j = 0;
                for ($i=1; $i<$_REQUEST["query_cnt"]+1; $i++) {
                    if ($_REQUEST["option_con_".$i]) {
                        $_REQUEST["opt"] = $_REQUEST["opt"].",".$_REQUEST["option_con_".$i];
                        $_REQUEST["opts"][$j] = $_REQUEST["option_con_".$i];
                        $j++;
                    }
                }
                if ($_REQUEST["opt"]) $_REQUEST["opt"] = substr($_REQUEST["opt"], 1); 
            }
            $_id = $this->Competitions_form->add($_REQUEST);
        }
        $_REQUEST["id"] = $_id;
        $this->assigns["res"] = $_REQUEST;
    }

    public function del_comp_form($_id)
    {
        $this->tpl_name = '';
        $this->Competitions_form->delete($_id);
    }

    public function del_comp_form_file($_id)
    {
        $this->tpl_name = '';
        $this->Competitions_file->delete($_id);
    }

    public function save_comp_form()
    {
        $this->tpl_name = '';
        $basic = 0;

        //체크박스 사용
        if(array_key_exists('basic1',$_REQUEST)) $basic = $basic | 1;
        else                                           $basic = $basic & (~1);

        if(array_key_exists('basic2',$_REQUEST)) $basic = $basic | 2;
        else                                                $basic = $basic & (~2);

        if(array_key_exists('basic3',$_REQUEST)) $basic = $basic | 4;
        else                                              $basic = $basic & (~4);

        if(array_key_exists('basic4',$_REQUEST)) $basic = $basic | 8;
        else                                           $basic = $basic & (~8);

        if(array_key_exists('basic5',$_REQUEST)) $basic = $basic | 16;
        else                                           $basic = $basic & (~16);

        if(array_key_exists('basic6',$_REQUEST)) $basic = $basic | 32;
        else                                           $basic = $basic & (~32);

        if(array_key_exists('basic7',$_REQUEST)) $basic = $basic | 64;
        else                                           $basic = $basic & (~64);

        if(array_key_exists('basic8',$_REQUEST)) $basic = $basic | 128;
        else                                           $basic = $basic & (~128);

        if(array_key_exists('basic9',$_REQUEST)) $basic = $basic | 256;
        else                                           $basic = $basic & (~256);

        $_REQUEST['basic'] = $basic;

        $_id = $this->Competitions->add($_REQUEST);
        $_SESSION["msgt"] = 1;
    }

    public function get_my_oc() 
    {
        $res = $this->Competitions->get_by_user(1, 1000, $_SESSION["s"]["id"]);
        $this->assigns["res"] = $res;
    }

    public function get_examiner_pool($_page, $_cid = '')
    {
        $pagesize = 5;
        $where = 'ce.public = 1 and ce.status = 1';
        $res = $this->Competitions_examiner->list_($_page, $pagesize, $where);
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            $res[$i]["com"] = $this->Startup_member->get_by_user($res[$i]["user_id"]);
            if($_cid) $res[$i]["ex"] = $this->Competitions_examiner->get_by_comp_user($_cid, $res[$i]["user_id"]);
            $comp = $this->Competitions_examiner->get_by_user($res[$i]["user_id"], 'ce.status = 1', 1);
            $last = sizeof($comp);
            if ($last) {    
                $lastt = $last - 1;
                $res[$i]["comp"] = $comp[$last-1]["subject"] . " - 외 ".$lastt."건";
                if ($last == 1) $res[$i]["comp"] = $comp[$last-1]["subject"];
            }
        }
        $res_cnt = $this->Competitions_examiner->cnt($where);
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize); 
        $this->assigns["res"] = $res;
        $this->assigns["page"] = $_page;
    }

    public function get_examiner_per($_id)
    {
        $res = $this->Members->get($_id);
        $res["com"] = $this->Startup_member->get_by_user($res["id"]);
        $res["comp"] = $this->Competitions_examiner->get_by_user($res["id"], 'ce.status = 1', 1);
        $res["op"] = $this->Competitions_examiner->operator_by_user($res["id"]);
        $this->assigns["res"] = $res;
    }

    public function get_examiner($_id = '')
    {
        if ($_REQUEST["tpl"]) {
            $_page = $_REQUEST["page"];
            if (array_key_exists("pagesize", $_REQUEST)) $pagesize = $_REQUEST["pagesize"];
            else $pagesize = 10;
            $res = $this->Competitions_examiner->get_by_comp($_id, $_page, $pagesize, "ce.status = 1");
            for ($i=0; $i<sizeof($res); $i++) {
                $c = $this->Competitions_scoring->get_score_by_comp($_id, $res[$i]["user_id"]);
                $res[$i]["end"] = sizeof($c);
            }
            $this->tpl_name = $_REQUEST["tpl"];
            $res_cnt = $this->Competitions_examiner->cnt('competition_id = '.$_id.' and status = 1');
            $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize); 
            $this->assigns["res_cnt"] = $res_cnt;
            $this->assigns["page"] = $_page;
            $this->assigns["pagesize"] = $pagesize;
            $this->assigns["apply_cnt"] = $this->Competitions_apply->cnt_out("ca.status = 1 and ca.competition_id = ".$_id);
        }
        else {
            $res = $this->Competitions_examiner->get_by_comp_outer($_id);
            $len_res = sizeof($res);
            for ($i=0; $i<$len_res; $i++) {
                $res[$i]["com"] = $this->Startup_member->get_by_user($res[$i]["user_id"]);
                $comp = $this->Competitions_examiner->get_by_user($res[$i]["user_id"], 'ce.status = 1', 1);
                $last = sizeof($comp);
                if ($last) {    
                    $lastt = $last - 1;
                    $res[$i]["comp"] = $comp[0]["subject"] . " - 외 ".$lastt."건";
                    if ($last == 1) $res[$i]["comp"] = $comp[0]["subject"];
                }
            }
            $this->assigns["cc"] = $this->Competitions->get($_id);
        }
        $this->assigns["res"] = $res;
        $this->assigns["cid"] = $_id;
    }
    
    public function delete_examiner($_id)
            {
        $this->tpl_name = '';
        $this->Competitions_examiner->delete($_id);
    }

    public function invitation_email()
    {
        $this->tpl_name = '';
        if ($_REQUEST["ex_email"]) {
            $_email = explode(",", $_REQUEST["ex_email"]);
            if ($_email) {
                $len_email = sizeof($_email);
                for ($i=0; $i<$len_email; $i++) {
                    $e = rtrim(ltrim($_email[$i]));
                    $_exn = $this->Members->get_by_email($e);
                    $arr["competition_id"] = $_REQUEST["competition_id"];
                    $arr["user_id"] = $_exn["id"];
                    if (!$_exn) $arr["email"] = $e;

                    $_ex = $this->Competitions_examiner->examiner_check($e, $_REQUEST["competition_id"]);
                    
                    //mailing
                    if (email_valid($e) && ! $_ex) {

                            $this->Competitions_examiner->add($arr);

                            $res = $this->Competitions->get($_REQUEST["competition_id"]);
                            $us = $this->Members->get($res["user_id"]);
                            $m = new TF_mailer($this->settings);
                            $m->mailto = $e;
                            $m->subject = "[D.CAMP] ".$us["name"]."님이 경진대회 심사위원으로 초대하였습니다.";
                            $m->tpl_name = "competition_invite";
                            $m->assigns["res"] = $res;
                            $m->assigns["user"] = $us;
                            $m->assigns["cont"] = $_REQUEST["ex_cont"];
                            $m->assigns["e"] = $e;
                            $m->assigns["main_service_url"] = $this->globals->my_host;
                            $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                            $m->send();
                    }
                    else {
                        echo "error";
                    }
                }
                
            }
        }
    }

    public function get_startup()
    {
        $res = $this->Startup_service->list_($_REQUEST["id"]);
        if ($_REQUEST["service"]) {
            $ser = $this->Startup_service->list_($_REQUEST["id"], "name = '".$_REQUEST["service"]."'");
            $this->assigns["ser"] = $ser[0];
        }

        $this->assigns["res"] = $res; 
        $this->assigns["res_f"] = $res[0];        
        $this->assigns["id"] = $_REQUEST["id"];
    }

    public function get_service_des($_id)
    {
        $this->tpl_name = "";
        $res = $this->Startup_service->get($_id);
        
        echo json_encode($res);
    }

    public function add_examiner()
    {
        $this->tpl_name = '';
        if ($_REQUEST["competition_id"] && $_REQUEST["users"]) {
            $users = explode(",", $_REQUEST["users"]);
            $len_users = sizeof($users);
            for ($i=0; $i<$len_users; $i++) {
                if ($users[$i]) {
                    $arr["competition_id"] = $_REQUEST["competition_id"];
                    $arr["user_id"] = $users[$i];
                    $check = $this->Competitions_examiner->get_by_user($arr["user_id"], 'c.id = '.$arr["competition_id"]);
                    if (! $check) {
                        $this->Competitions_examiner->add($arr);
                        
                        //mailing
                        $per = $this->Members->get($users[$i]);
                        $res = $this->Competitions->get($_REQUEST["competition_id"]);
                        $us = $this->Members->get($res["user_id"]);
                        $m = new TF_mailer($this->settings);
                        $m->mailto = $per["email"];
                        $m->subject = "[D.CAMP] ".$us["name"]."님이 경진대회 심사위원으로 초대하였습니다.";
                        $m->tpl_name = "competition_invite";
                        $m->assigns["res"] = $res;
                        $m->assigns["user"] = $us;
                        $m->assigns["cont"] = $_REQUEST["cont"];
                        $m->assigns["e"] = $per["email"];
                        $m->assigns["main_service_url"] = $this->globals->my_host;
                        $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                        $m->send();

                        //activity
                        $arr["com_type"] = 1;
                        $arr["com_id"] = $per["id"];
                        $arr["act_type"] = 1;
                        $arr["act_id"] = $us["id"];
                        $arr["msg"] = "<a href='/challenge/views/".$res["id"]."'>".$res["subject"]."</a> 의 <a href='/challenge/pending?id=".$res["id"]."&amp;e=".$per["email"]."'>심사위원</a> 으로 초대되셨습니다. ";
                        $this->Activity->add($arr);
                    }
                    else {
                        echo 'error';
                    }
                }
            }
        }
    }

    public function edit_examiner_status()
    {
        $this->tpl_name = "";
        $this->Competitions_examiner->add($_REQUEST);
    }

    public function get_examiner_comp($_id, $_com = '')
    {
        if ($_com) {
            $re = $this->Competitions_examiner->get_by_comp_outer($_com, '', '', 'ce.id = '. $_id);
            
        }
        else {
            $re = $this->Competitions_examiner->list_(1, 1, 'ce.id = '. $_id);
        }
        $res = $re[0];
        $res["com"] = $this->Startup_member->get_by_user($res["id"]);
        $this->assigns["res"] = $res;
    }

    public function get_reception($_id, $_page)
    {
        $pagesize = 5;
        $where = "ca.competition_id = ".$_id;
        if ($_REQUEST["search"]) $where = $where." and (f_name like '%".$_REQUEST["search"]."%' or f_team like '%".$_REQUEST["search"]."%')";
        $res = $this->Competitions_apply->list_info($_page, $pagesize, $where);
        for ($i=0; $i<sizeof($res); $i++) {
            $u = $this->Members->get($res[$i]["user_id"]);
            $res[$i]["name"] = $u["name"];
        }
        $res_cnt = $this->Competitions_apply->cnt($where);
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize); 

        $this->assigns["res"] = $res;
        $this->assigns["page"] = $_page;
        $this->assigns["cid"] = $_id;
        $this->assigns["r"]= $this->Competitions->get($_id);
    }

    public function get_winner($_id)
    {
        $where = "ca.win = 1 and ca.competition_id = ".$_id;
        $res = $this->Competitions_apply->list_info(1, 1000, $where);
        for ($i=0; $i<sizeof($res); $i++) {
            $u = $this->Members->get($res[$i]["user_id"]);
            $res[$i]["name"] = $u["name"];
        }

        $this->assigns["res"] = $res;
        $this->assigns["r"]= $this->Competitions->get($_id);
    }

    public function add_winner()
    {
        $this->tpl_name = '';
        if ($_REQUEST["competition_id"] && $_REQUEST["users"]) {
            $users = explode(",", $_REQUEST["users"]);
            $len_users = sizeof($users);
            for ($i=0; $i<$len_users; $i++) {
                if ($users[$i]) {
                    $arr["id"] = $users[$i];
                    $arr["win"] = 1;
                    $this->Competitions_apply->add($arr);
                }
            }
        }
    }

    public function del_winner()
    {
        $this->tpl_name = '';
        if ($_REQUEST["competition_id"] && $_REQUEST["users"]) {
            $users = explode(",", $_REQUEST["users"]);
            $len_users = sizeof($users);
            for ($i=0; $i<$len_users; $i++) {
                if ($users[$i]) {
                    $arr["id"] = $users[$i];
                    $arr["win"] = 0;
                    $this->Competitions_apply->add($arr);
                }
            }
        }
    }

    public function get_operator($_id)
    {
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
    }

    public function invitation_operator()
    {
        $this->tpl_name = '';
        if ($_REQUEST["ex_email"]) {
            $_email = explode(",", $_REQUEST["ex_email"]);
            if ($_email) {
                $len_email = sizeof($_email);
                for ($i=0; $i<$len_email; $i++) {
                    $e = rtrim(ltrim($_email[$i]));
                    $_exn = $this->Members->get_by_email($e);
                    $_che = $this->Competitions_examiner->operator_check($_REQUEST["competition_id"], $_exn["id"]);
                        
                    if ($_exn && !$_che) {
                        $arr["competition_id"] = $_REQUEST["competition_id"];
                        $arr["user_id"] = $_exn["id"];
                        $this->Competitions_examiner->operator_add($arr);
                        
                        // mail, activity
                        if (email_valid($e)) {
                            //mailing
                            
                            $res = $this->Competitions->get($_REQUEST["competition_id"]);
                            $m = new TF_mailer($this->settings);
                            $m->mailto = $e;
                            $m->subject = "[D.CAMP] 경진대회 운영진으로 초대되었습니다.";
                            $m->tpl_name = "competition_invite_op";
                            $m->assigns["res"] = $res;
                            $m->assigns["cont"] = $_REQUEST["ex_cont"];
                            $m->assigns["main_service_url"] = $this->globals->my_host;
                            $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                            $m->send();
                        }
                    }
                    else
                        echo "error";
                }
                
            }
        }
    }

    public function delete_operator($_cid, $_uid)
    {
        $this->tpl_name = "";
        $u = $this->Competitions->get($_cid);
        $o = $this->Competitions_examiner->operator_check($_cid, $_uid);
        if ($u || $o) {
            $this->Competitions_examiner->operator_del($_cid, $_uid);
        }
    }

    public function check_c_url()
    {
        $this->tpl_name = "";
        $text = array("applied_list", "applied_view", "apply", "apply_info", "edit"
            , "examiner", "index", "operator", "pending", "pending_pool"
            , "score_info", "views", "winner");
        $key = in_array($_REQUEST["url"], $text);
        $res = $this->Competitions->get_by_url($_REQUEST["url"], $_REQUEST["id"]);
        if ($res || $key) {
            echo 1;
        }
    }

    public function del_c_a_file($_id)
    {
        $this->tpl_name = "";
        $r = $this->Competitions->get_a_file('', $_id);
        if ($r) {
            unlink($this->settings->root_path."media/comp_file/".$r["file"]);
            $this->Competitions->del_a_file_per($_id);    
        }
        
    }

    public function examiner_confirm()
    {
        $this->tpl_name = "";
        if ($_REQUEST["competition_id"] && $_REQUEST["users"]) {
            $this->Competitions_examiner->confirm($_REQUEST["competition_id"], $_REQUEST["users"]);
            $this->Competitions->set_ex_confirm($_REQUEST["competition_id"]);
            
            $res = $this->Competitions->get($_REQUEST["competition_id"]);
            $ex = $this->Competitions_examiner->get_by_comp_outer($res["id"], 1, 100, "ce.status = 1");
            for ($i=0; $i<sizeof($ex); $i++) {
                //mailing
                $e = $ex[$i]["memail"];
                if (!$e) $e = $ex[$i]["email"];

                $us = $this->Members->get($res["user_id"]);
                $m = new TF_mailer($this->settings);
                $m->mailto = $e;
                if ($ex[$i]["name"])
                    $m->subject = "[D.CAMP] ".$ex[$i]["name"]."님이 경진대회 심사위원으로 최종 선정되었습니다.";
                else
                    $m->subject = "[D.CAMP] 경진대회 심사위원으로 최종 선정되었습니다.";
                $m->tpl_name = "competition_invite_fix";
                $m->assigns["res"] = $res;
                $m->assigns["user"] = $ex[$i]["name"];
                $m->assigns["main_service_url"] = $this->globals->my_host;
                $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                $m->send();
            }
        }
    }

    public function edit_ex_notice()
    {
        $this->tpl_name = "";
        if ($_REQUEST["id"] && $_REQUEST["cont"]) {
            $this->Competitions->edit_ex_noti($_REQUEST["id"], $_REQUEST["cont"]);    
        }
    }

    public function newsletter_recruit($_html = "")
    {
        // $where = 'r.en < 2 and r.state = 1 and r.end > "'.date("Y.m.d").'"';
        // $res = $this->Recruit->list_s_mail($where, 'r.date_edited DESC');
        // $len_res = sizeof($res);
        // for ($i=0; $i<$len_res; $i++) {
        //     $res[$i]["inv"] = $this->Recruit->detail_opt($res[$i]["sid"], 7, $where);
        //     $res[$i]["term"] = $this->Recruit_opt->get_detail($res[$i]["id"], 4);
        //     $res[$i]["terms"] = "";
        //     for ($j=0; $j<sizeof($res[$i]["term"]); $j++) {
        //         $res[$i]["terms"] =  $res[$i]["terms"].$res[$i]["term"][$j]["_value"].", ";
        //     }
        // }
        // $this->assigns["res"] = $res;
        // $this->assigns["header"] = $this->Banner->recruit();
        // if ($_html) $this->tpl_name = "newsletter_recruit_html";


        $where = 'r.en < 2 and r.state = 1 and r.end > "'.date("Y.m.d").'"';
        $res = $this->Recruit->list_s_mail($where, 'r.date_edited DESC');
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {

            $r = $this->Recruit->list_s_('', '', 'r.en < 2 and r.state = 1 and s.id = '.$res[$i]["sid"].' and r.end > "'.date("Y.m.d").'"', 'r.date_edited DESC');
            $len_r = sizeof($r);
            for ($ii=0; $ii<$len_r; $ii++) {
                $r[$ii]["inv"] = $this->Recruit_opt->get_detail($r[$ii]["rid"], 7);
                $r[$ii]["term"] = $this->Recruit_opt->get_detail($r[$ii]["rid"], 4);
                $r[$ii]["job"] = $this->Recruit_opt->get_detail($r[$ii]["rid"], 6);
            }
            $res[$i]["rec"] = $r;
        }
        $this->assigns["res"] = $res;
        $this->assigns["header"] = $this->Banner->recruit();
        if ($_html) $this->tpl_name = "newsletter_recruit_html";
    }

// challenge


// Program    

    public function add_pro_form($_id = '')
    {
        if ($_REQUEST["title"]) {
            if ($_REQUEST["opt"]) {
                $_REQUEST["opts"] = explode(",", $_REQUEST["opt"]);
            }
            $this->assigns["ress"] = $_REQUEST;
        }
        if ($_id) $this->assigns["ress"]["program_id"] = $_id;
    }

    public function add_pro_form_file($_id = '')
    {
        if ($_REQUEST["title"]) {
            $this->assigns["ress"] = $_REQUEST;
        }
        if ($_id) $this->assigns["ress"]["program_id"] = $_id;
    }

    public function edit_pro_form()
    {
        if ($_REQUEST["type"] == 'file') {
            $_id = $this->Program_file->add($_REQUEST);    
        }
        else {
            if ($_REQUEST["type"] == 'query') {
                $_REQUEST["opt"] = '';
                $j = 0;
                for ($i=1; $i<$_REQUEST["query_cnt"]+1; $i++) {
                    if ($_REQUEST["option_con_".$i]) {
                        $_REQUEST["opt"] = $_REQUEST["opt"].",".$_REQUEST["option_con_".$i];
                        $_REQUEST["opts"][$j] = $_REQUEST["option_con_".$i];
                        $j++;
                    }
                }
                if ($_REQUEST["opt"]) $_REQUEST["opt"] = substr($_REQUEST["opt"], 1); 
            }
            $_id = $this->Program_form->add($_REQUEST);
        }
        $_REQUEST["id"] = $_id;
        $this->assigns["res"] = $_REQUEST;
    }

    public function del_pro_form($_id)
    {
        $this->tpl_name = '';
        $this->Program_form->delete($_id);
    }

    public function del_pro_form_file($_id)
    {
        $this->tpl_name = '';
        $this->Program_file->delete($_id);
    }

    public function save_pro_form()
    {
        $this->tpl_name = '';
        $basic = 0;

        //체크박스 사용
        if(array_key_exists('basic1',$_REQUEST)) $basic = $basic | 1;
        else                                           $basic = $basic & (~1);

        if(array_key_exists('basic2',$_REQUEST)) $basic = $basic | 2;
        else                                                $basic = $basic & (~2);

        if(array_key_exists('basic3',$_REQUEST)) $basic = $basic | 4;
        else                                              $basic = $basic & (~4);

        if(array_key_exists('basic4',$_REQUEST)) $basic = $basic | 8;
        else                                           $basic = $basic & (~8);

        if(array_key_exists('basic5',$_REQUEST)) $basic = $basic | 16;
        else                                           $basic = $basic & (~16);

        if(array_key_exists('basic6',$_REQUEST)) $basic = $basic | 32;
        else                                           $basic = $basic & (~32);

        if(array_key_exists('basic7',$_REQUEST)) $basic = $basic | 64;
        else                                           $basic = $basic & (~64);

        if(array_key_exists('basic8',$_REQUEST)) $basic = $basic | 128;
        else                                           $basic = $basic & (~128);

        if(array_key_exists('basic9',$_REQUEST)) $basic = $basic | 256;
        else                                           $basic = $basic & (~256);

        $_REQUEST['basic'] = $basic;

        $_id = $this->Program->add($_REQUEST);
        $_SESSION["msgt"] = 1;
    }

    public function del_program($_id)
    {
        $this->tpl_name = '';
        $r = $this->Program->get($_id);
        if ($r["user_id"] == $_SESSION["s"]["id"])
            $this->Program->delete($_id);
    }

    public function get_apply_p($_id)
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /error_404");
        }

        if (!$_id) header("Location: /error_404");

        $per = $this->Program_apply->get($_id);
        $per["com"] = $this->Startup_member->get_by_user($per["user_id"]);
        $res = $this->Program->get($per["program_id"]);

        $file = $this->Program_file->get_by_comp($res["id"]);
        if ($file) {
            for ($j=0; $j<sizeof($file); $j++) {
                $f = $this->Program_file->get_by_file_user_res($file[$j]["id"], $_id);
                $file[$j][val] = $f["file"];
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
        
        if ($_SESSION["s"]["id"] != $per["user_id"]  && $_SESSION["s"]["id"] != $res["user_id"] ) 
            header("Location: /error_404");
    }

    public function get_pro_list_all($_id, $_type, $_page, $_div)
    {
        $pagesize = 5;
        $res = $this->Program_apply->list_($_page, $pagesize, "ca.program_id =".$_id);
        $res_cnt = $this->Program_apply->cnt( "ca.program_id =".$_id);

        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["res"] = $res;
        $this->assigns["id"] = $_id;
        $this->assigns["div"] = $_div;
        $this->assigns["type"] = $_type;
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["paging"] = get_paging_dot3($_page, $res_cnt, $pagesize);
    }

    public function more_program($_status = 'ing', $_page = 1)
    {
        $_pagesize = 12;
        $where = "c.status = 1 and c.open = 1 ";
        if ($_status == 'ing') $where = $where .' and ( a_start = "" or a_start IS NULL or a_start <= "'. date('Y.m.d H:i').'" and a_end > "'. date('Y.m.d H:i').'")';
        else if ($_status == 'end') $where = $where .' and a_start != "" and a_start IS NOT NULL and a_end < "'. date('Y.m.d H:i').'"';

        if ($_REQUEST["type"]) $where = $where." and cat_id = ".$_REQUEST["type"];

        $order = "";  
        if ($_REQUEST["order"]) $order= 'a_end = "" ASC, a_end ASC';

        $res = $this->Program->get_list($_page, $_pagesize, $where, $order);

        $this->assigns["res"] = $res;
    }    

// Program    

// Showcase

    public function save_bz()
    {
        $this->tpl_name = "";
        if ($_REQUEST["movie"]) {
            $video_info = get_video_id($_REQUEST["movie"]);
            if ($video_info['id']) {
                $video_data = get_video_data($video_info['id'], $video_info['type']);
                $_REQUEST["movie1"] = $video_info['id'];
                $_REQUEST["movie1_type"] = $video_info['type'];
                $_REQUEST["movie1_thumb"] = $video_data['b_thumbnail'];
            }
        }
        if ($_REQUEST["startup_name"]) $_REQUEST["startup_id"] = "";
        if ($_REQUEST["s_id"] > 0) $_REQUEST["id"] = $_REQUEST["s_id"];
        $_REQUEST["user_id_bz"] = $_SESSION["s"]["id"];
        $_id = $this->Startup_service->add($_REQUEST);
        if ($_id) {
            $this->Startup_service->del_category($_id);
            if ($_REQUEST["market_1"]) $this->Startup_service->add_category($_id, $_REQUEST["market_1"]);
            if ($_REQUEST["market_2"]) $this->Startup_service->add_category($_id, $_REQUEST["market_2"]);
            if ($_REQUEST["market_3"]) $this->Startup_service->add_category($_id, $_REQUEST["market_3"]);

            $this->Startup_service->del_date($_id);
            if ($_REQUEST["founded"]) $this->Startup_service->add_date($_id, $_REQUEST["founded"], 0);
            for ($d=1; $d<$_REQUEST["cnt_date"]+1; $d++) {
                if ($_REQUEST["update_".$d])
                    $this->Startup_service->add_date($_id, $_REQUEST["update_".$d], 1, $_REQUEST["update_des_".$d]);
            }

            $this->Startup_service->del_article($_id);
            for ($a=1; $a<$_REQUEST["cnt_article"]+1; $a++) {
                if ($_REQUEST["article_".$a])
                    $this->Startup_service->add_article($_id, $_REQUEST["article_".$a], $_REQUEST["article_t_".$a]);
            }

            if ($_REQUEST["pic_1"]) {
                $img_temp_name = str_replace(" ","",$_REQUEST['pic_1']);

                $ck = substr($img_temp_name, 0, 1);
                if($ck=='/'){
                    $img_temp_name = substr($img_temp_name, 1, strlen($img_temp_name) -1 );
                }

                $file_ext = explode('.',$img_temp_name);
                $file_ext = '.'.$file_ext[sizeof($file_ext)-1];

                $original_file = $this->settings->root_path.$img_temp_name;
                $copy_file = $this->settings->root_path.'media/service/1_'.$_id.$file_ext;

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/service/1_'.$_id.$file_ext;
                $this->Startup_service->add_picture($_id, $_pic);
            }
            $res["id"] = $_id;
            echo json_encode($res);
        }
        
    }   

    public function more_betazone($_page)
    {
        $cat = $this->Code->get_by_key("bz_market");
        $pagesize = 10;

        $where = 'status_bz = 1 and user_id_bz IS NOT NULL';
        // $where = 'status_bz = 1 and user_id_bz IS NOT NULL and user_id_bz != 0';
        if ($_REQUEST["status"] == 'archived') {
            
            $where = $where." and date < '".date('Y.m.d',strtotime('-1 month'))."'";
            for ($c=0; $c<sizeof($cat); $c++) {
                $where_c = $where.' and category_id = '.$cat[$c]["id"];
                $cc = $this->Startup_service->get_list_ser_cat('', '', $where_c);
                $cat[$c]["cnt"] = sizeof($cc);

            }

            $t = $this->Startup_service->get_ser_date('', '', $where);
            $tot = sizeof($t); 

            if ($_REQUEST["category"]) {
                $where = $where.' and category_id = '.$_REQUEST["category"];
                $res = $this->Startup_service->get_list_ser_cat($_page, $pagesize, $where, 'date DESC');
            }
            else {
                $res = $this->Startup_service->get_ser_date($_page, $pagesize, $where, 'date DESC');  
            }
        }
        else if ($_REQUEST["status"] == 'ready') {

            $where = $where." and date > '".date("Y.m.d")."'";
            for ($c=0; $c<sizeof($cat); $c++) {
                $where_c = $where.' and category_id = '.$cat[$c]["id"];
                $cc = $this->Startup_service->get_list_ser_cat('', '', $where_c);
                $cat[$c]["cnt"] = sizeof($cc);

            }

            $t = $this->Startup_service->get_ser_date('', '', $where);
            $tot = sizeof($t); 

            if ($_REQUEST["category"]) {
                $where = $where.' and category_id = '.$_REQUEST["category"];
                $res = $this->Startup_service->get_list_ser_cat($_page, $pagesize, $where, 'date DESC');
            }
            else {
                $res = $this->Startup_service->get_ser_date($_page, $pagesize, $where, 'date DESC');  
            }
        }
        else {
            $_REQUEST["status"] = 'just_launched';
            
            $where = $where.' and date <= "'.date("Y.m.d").'" and date >= "'.date('Y.m.d',strtotime('-1 month')).'"';
            // category
            $where_c = 'service_id IN ('
                    .'SELECT sd.service_id FROM startup_service s, startup_service_date sd '
                    .'WHERE s.id = sd.service_id AND '.$where.' GROUP BY sd.service_id ORDER BY DATE DESC'
                    .') AND category_id = ';
            for ($c=0; $c<sizeof($cat); $c++) {
                $cnt = $this->Startup_service->get_cnt_cat('', '', $where_c.$cat[$c]["id"]);
                $cat[$c]["cnt"] = sizeof($cnt);
            }
            // result
            if ($_REQUEST["category"]) {
                $where_c = 'service_id IN ('
                    .'SELECT sd.service_id FROM startup_service s, startup_service_date sd '
                    .'WHERE s.id = sd.service_id AND '.$where.' GROUP BY sd.service_id ORDER BY DATE DESC'
                    .') AND category_id = ';
                $res = $this->Startup_service->get_cnt_cat('', '', $where_c.$_REQUEST["category"]);
            }
            else {
                $res = $this->Startup_service->get_by_date_cat($_page, $pagesize, $where);
            }

            $t = $this->Startup_service->get_by_date_cat('', '', $where);
            $tot = sizeof($t);
        }

        for ($r=0; $r<sizeof($res); $r++) {
            $date = $res[$r]["date"];
            $res[$r] = $this->Startup_service->get($res[$r]["service_id"]);
            if ($res[$r]["status_bz"] == 1) {
                $res[$r]["cats"] = $this->Startup_service->get_category($res[$r]["id"]);
                $res[$r]["s"] = $this->Startup->get($res[$r]["startup_id"]);
                $res[$r]["com"] = $this->Board->cnt("p_type = 9 and p_id = ".$res[$r]["id"]);
                if ($_REQUEST["status"] == 'just_launched') {
                    $dates = $this->Startup_service->get_last_date($res[$r]["id"]);
                    $res[$r]["date"] = $dates["date"];
                    $res[$r]["type"] = $dates["type"];
                    $res[$r]["diff"] = dateDiff(date("Y.m.d"), $res[$r]["date"], '.');
                }
                else { $res[$r]["date"] = $date; }
            }
            else { unset($res[$r]); }      
        }

        $this->assigns["res"] = $res;
        $this->assigns["today"] = date("Y.m.d");
        $this->assigns["status"] = $_REQUEST["status"];
    } 

    public function get_service_bz($_id)
    {
        $res = $this->Startup_service->get($_id);
        $dates = $this->Startup_service->get_last_date($_id);
        $res["date"] = $dates["date"];
        $res["type"] = $dates["type"];
        $res["cats"] = $this->Startup_service->get_category($_id);
        $res["s"] = $this->Startup->get($res["startup_id"]);
        $res["art"] = $this->Startup_service->get_article($_id);

        $this->assigns["res"] = $res;
        $this->assigns["today"] = date("Y.m.d");

    }

    public function startup_get_service($_id) 
    {
        $order = "date_created DESC";
        $res = $this->Startup_service->list_($_id, $where, $order, '', '');
        for ($r=0; $r<sizeof($res); $r++) {
            $res[$r]["cats"] = $this->Startup_service->get_category($res[$r]["id"]);
            $res[$r]["s"] = $this->Startup->get($res[$r]["startup_id"]);
            $res[$r]["com"] = $this->Board->cnt("p_type = 9 and p_id = ".$res[$r]["id"]);
        }

        $this->assigns["res"] = $res;
        $this->assigns["edi"] = $this->Startup_member->get_first($_id, $_SESSION["s"]["id"]);
        $this->assigns["sid"] = $_id;
    }

    public function edit_service($_id, $_sid = '')
    {
        $this->assigns["st"] = $this->Startup_member->get_list_by_user($_SESSION["s"]["id"], "sm.status = 1");
        $this->assigns["market"] = $this->Code->get_by_key("bz_market");
        $this->assigns["sid"] = $_sid;
        
        if ($_id > 0) {
            $res = $this->Startup_service->get($_id);
            $edi = $this->Startup_member->get_first($res["startup_id"], $_SESSION["s"]["id"]);
            if ($res["user_id_bz"] == $_SESSION["s"]["id"] || $edi["user_id"] == $_SESSION["s"]["id"]) {
                $res["dates"] = $this->Startup_service->get_dates($_id, 1);
                $cats = $this->Startup_service->get_category($_id);
                $res["cat1"] = $cats[0]["id"];
                $res["cat2"] = $cats[1]["id"];
                $res["cat3"] = $cats[2]["id"];
                $res["s"] = $this->Startup->get($res["startup_id"]);
                $res["art"] = $this->Startup_service->get_article($_id);

                $this->assigns["res"] = $res;
            }
        }
    }

    public function get_service_old($_id) 
    {
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
        if ($_REQUEST["where"] == 'st') {
            $this->assigns["prev"] = $this->Startup_service->get_next(1, $_id, $_REQUEST["opt"], '', $order);
            $this->assigns["next"] = $this->Startup_service->get_next(0, $_id, $_REQUEST["opt"], '', $order);
        }
        if ($_REQUEST["next"]) $this->assigns["where"] = 1;
    }

    public function get_service($_id) 
    {
        $_page = $_REQUEST["page"];
        $_type = $_REQUEST["type"];
        $_opt = $_REQUEST["opt"];

        $pagesize = 10;

        // $where = 'status_bz = 1 and user_id_bz IS NOT NULL';
        // if ($_type == 'archived') {
        //     if ($_REQUEST["opt"]) {
        //         $where = $where.' and category_id = '.$_REQUEST["opt"];
        //         $res = $this->Startup_service->get_by_cat_date($_page, $pagesize, $where, 'date_updated DESc');
        //     }
        //     else {
        //         $res = $this->Startup_service->list_('', $where, 'date_updated DESc', $_page, $pagesize);   
        //     }
        // }
        // else if ($_type == 'just_launched') {
            
        //     $where = $where.' and date <= "'.date("Y.m.d").'" and date >= "'.date('Y.m.d',strtotime('-1 month')).'"';

        //     $where_c = 'service_id IN ('
        //             .'SELECT sd.service_id FROM startup_service s, startup_service_date sd '
        //             .'WHERE s.id = sd.service_id AND '.$where.' GROUP BY sd.service_id ORDER BY DATE DESC'
        //             .') AND category_id = ';
        //     // result
        //     if ($_REQUEST["opt"]) {
        //         $where_c = 'service_id IN ('
        //             .'SELECT sd.service_id FROM startup_service s, startup_service_date sd '
        //             .'WHERE s.id = sd.service_id AND '.$where.' GROUP BY sd.service_id ORDER BY DATE DESC'
        //             .') AND category_id = ';
        //         $res = $this->Startup_service->get_cnt_cat('', '', $where_c.$_REQUEST["opt"]);
        //     }
        //     else {
        //         $res = $this->Startup_service->get_by_date_cat($_page, $pagesize, $where);
        //     }
            
        // }
        // else if ($_type == 'startup') {
        //     $res = $this->Startup_service->list_($_opt);
        // }

        // for ($r=0; $r<sizeof($res); $r++) {
        //     if ($_type == 'just_launched')
        //         $res[$r] = $this->Startup_service->get($res[$r]["service_id"]);
        //     $res[$r]["cats"] = $this->Startup_service->get_category($res[$r]["id"]);
        //     $res[$r]["s"] = $this->Startup->get($res[$r]["startup_id"]);
        //     $res[$r]["com"] = $this->Board->cnt("p_type = 9 and p_id = ".$res[$r]["id"]);
        //     $dates = $this->Startup_service->get_last_date($res[$r]["id"]);
        //     $res[$r]["date"] = $dates["date"];
        //     $res[$r]["type"] = $dates["type"];
        //     $res[$r]["diff"] = dateDiff(date("Y.m.d"), $res[$r]["date"], '.');
        //     $res[$r]["update"] = $this->Startup_service->get_dates($res[$r]["id"], 1);
        //     $res[$r]["art"] = $this->Startup_service->get_article($res[$r]["id"]);
        // }

        // $where = 'status_bz = 1 and user_id_bz IS NOT NULL and user_id_bz != 0';
        $where = 'status_bz = 1 and user_id_bz IS NOT NULL';
        if ($_type == 'archived') {
            
            $where = $where." and date < '".date('Y.m.d',strtotime('-1 month'))."'";

            $t = $this->Startup_service->get_ser_date('', '', $where);
            $tot = sizeof($t); 

            if ($_opt) {
                $where = $where.' and category_id = '.$_opt;
                $res = $this->Startup_service->get_list_ser_cat($_page, $pagesize, $where, 'date DESC');
            }
            else {
                $res = $this->Startup_service->get_ser_date($_page, $pagesize, $where, 'date DESC');  
            }
        }
        else if ($_type == 'ready') {

            $where = $where." and date > '".date("Y.m.d")."'";

            $t = $this->Startup_service->get_ser_date('', '', $where);
            $tot = sizeof($t); 

            if ($_opt) {
                $where = $where.' and category_id = '.$_opt;
                $res = $this->Startup_service->get_list_ser_cat($_page, $pagesize, $where, 'date DESC');
            }
            else {
                $res = $this->Startup_service->get_ser_date($_page, $pagesize, $where, 'date DESC');  
            }
        }
        else if ($_type == 'just_launched') {
            
            $where = $where.' and date <= "'.date("Y.m.d").'" and date >= "'.date('Y.m.d',strtotime('-1 month')).'"';

            // result
            if ($_opt) {
                $where_c = 'service_id IN ('
                    .'SELECT sd.service_id FROM startup_service s, startup_service_date sd '
                    .'WHERE s.id = sd.service_id AND '.$where.' GROUP BY sd.service_id ORDER BY DATE DESC'
                    .') AND category_id = ';
                $res = $this->Startup_service->get_cnt_cat('', '', $where_c.$_opt);
            }
            else {
                $res = $this->Startup_service->get_by_date_cat($_page, $pagesize, $where);
            }

            $t = $this->Startup_service->get_by_date_cat('', '', $where);
            $tot = sizeof($t);
        }
        else if ($_type == 'startup') {
            $res = $this->Startup_service->list_($_opt);
        }

        for ($r=0; $r<sizeof($res); $r++) {
            $date = $res[$r]["date"];
            if ($_type != 'startup') $res[$r] = $this->Startup_service->get($res[$r]["service_id"]);
            if ($_type == 'startup' or $res[$r]["status_bz"] == 1) {
                $res[$r]["cats"] = $this->Startup_service->get_category($res[$r]["id"]);
                $res[$r]["s"] = $this->Startup->get($res[$r]["startup_id"]);
                $res[$r]["com"] = $this->Board->cnt("p_type = 9 and p_id = ".$res[$r]["id"]);
                $res[$r]["update"] = $this->Startup_service->get_dates($res[$r]["id"], 1);
                $res[$r]["art"] = $this->Startup_service->get_article($res[$r]["id"]);
                if ($_type == 'just_launched') {
                    $dates = $this->Startup_service->get_last_date($res[$r]["id"]);
                    $res[$r]["date"] = $dates["date"];
                    $res[$r]["type"] = $dates["type"];
                    $res[$r]["diff"] = dateDiff(date("Y.m.d"), $res[$r]["date"], '.');
                }
                else { $res[$r]["date"] = $date; }
            }
            else { unset($res[$r]); }      
        }

        $this->assigns["type"] = $_type;
        $this->assigns["res"] = $res;
        $this->assigns["target"] = $_id;
        $this->assigns["today"] = date("Y.m.d");
    }

    public function del_code($_id)
    {
        if ( ($_SESSION["s"]["per"] & $this->settings->permission1) == $this->settings->permission1 ) {
            $this->tpl_name = "";
            $this->Code->delete($_id);
        }
    } 

    public function more_bz_my($_page)
    {
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

    public function test_cal(){
        // $email = '334086275725-8opcgunu149lta5svhg08p8ur609uv62@developer.gserviceaccount.com';
        // $password = 'password';

        // require_once 'Google/Calendar.php';
        // $service = new Google_Calendar;

        // session_start();
        // if (!isset($_SESSION['tokens'])) {
        // $_SESSION['tokens'] = array();
        // }
        // if (!isset($_SESSION['tokens']['calendar'])) {
        // if (!$service->requestClientLogin($email, $password)) {
        // exit("ClientLogin has failed.n".$service->getResponseBody());
        // }
        // $_SESSION['tokens']['calendar'] = array(
        // $service->token,
        // $service->authType
        // );
        // }
        // var_dump($_SESSION['tokens']);



        // require_once '../tf_app/google-api/Google_Client.php';
        // require_once '../tf_app/google-api/contrib/Google_CalendarService.php';

        // session_start();

        // const CLIENT_ID = '334086275725-8opcgunu149lta5svhg08p8ur609uv62.apps.googleusercontent.com';
        // const SERVICE_ACCOUNT_NAME = '334086275725-8opcgunu149lta5svhg08p8ur609uv62@developer.gserviceaccount.com';
        // const KEY_FILE = '../tf_app/google-api/test-calendar-ee631eb64350.p12';//notasecret 

        // $client = new Google_Client();
        // $client->setApplicationName("test-calendar");
        // $client->setUseObjects(true); //IF USING SERVICE ACCOUNT (YES)


        // if (isset($_SESSION['token'])) {
        // $client->setAccessToken($_SESSION['token']);
        // }

        // /* This next snippet of code is commonly written wrong, be sure to use the correct URL specified as below: */

        // $key = file_get_contents(KEY_FILE);
        // $client->setClientId(CLIENT_ID);
        // $client->setAssertionCredentials(new Google_AssertionCredentials(
        // SERVICE_ACCOUNT_NAME, 'https://www.google.com/calendar/feeds/3h37pgh9qvtvd9r7jun88elhfk@group.calendar.google.com/private/full/',
        // $key)
        // );

        // $client->setClientId(CLIENT_ID);
        // $cal = new Google_CalendarService($client);
        // $event = new Google_Event();
        // $event->setSummary('test11111111');
        // $event->setLocation('<PUT-A-LOCATION-HERE-OR-PASSED-VARIABLE>');
    }

    public function oauth2callback2(){
        $this->tpl_name = "";


        // print_r($_SERVER);
        // // exit(1);
        // echo $_REQUEST["access_token"];
        


// 1.

        $url = "https://www.googleapis.com/calendar/v3/calendars/3h37pgh9qvtvd9r7jun88elhfk%40group.calendar.google.com/events";
        $post_data = array(
            'access_token' => $_REQUEST["access_token"],
            'summary' => "hi test",
            "start" => array(
                "dateTime" => "2015-07-25"
            ),
            "end" => array(
                "dateTime" => "2015-07-31"
            ),
        );

        // $url = "https://accounts.google.com/o/oauth2/auth?response_type=token&client_id=334086275725-f15a3bl6bm7kbhfkm66u9va1si5bb9ia.apps.googleusercontent.com&redirect_uri=http://localhost.me:8006/ajax_v3/oauth2callback/&scope=https://www.googleapis.com/auth/calendar&state=profile";
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POST, 1);
        // curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
        curl_setopt($session, CURLOPT_HEADER, false);
        curl_setopt($session, CURLOPT_RETURNTRANSFER, true);
        //curl_setopt($session, CURLOPT_VERBOSE, true);
        curl_setopt($session, CURLINFO_HEADER_OUT, true);
        curl_setopt($session, CURLOPT_HTTPHEADER, array('Content-Type:  application/json','Authorization:  Bearer ' . $_REQUEST["access_token"],'X-JavaScript-User-Agent:  Mount Pearl Tennis Club Bookings'));
        // ob_start();
        // $res = curl_exec($ch);
        // curl_close($ch);
        // $cont=ob_get_contents();ob_end_clean();

        // $js = json_decode($cont);
        // print_r($js);

        $buffer = curl_exec ($ch);
        $cinfo = curl_getinfo($ch);
        curl_close($curlsession);
        print_r($cinfo);

        if ($cinfo['http_code'] != 200)
        {
            echo "1";
        }
        echo $buffer;
    





// 2.

        // $_REQUEST["access_token"] = "ya29.wwEQ70y67cRDely9Ldzrk8IYMHuVYB_XqDXkzwugWYw6Mio2lQN_70p9KMvS3wp0GSjrYA";
        // $this->tpl_name = "";

        // $url = "https://www.googleapis.com/calendar/v3/calendars/3h37pgh9qvtvd9r7jun88elhfk%40group.calendar.google.com/events";
        // $post_data = array(
        //     'access_token' => $_REQUEST["access_token"],
        //     'key' => "AIzaSyDG3_w9d7KfjTZq8PH4boPMDzAwoOS8Zoc",
        //     'summary' => "hi test",
        //     "start" => array(
        //         "dateTime" => "2015-07-25"
        //     ),
        //     "end" => array(
        //         "dateTime" => "2015-07-31"
        //     ),
        // );
        // // print_r($post_data);
        // // $url = "https://accounts.google.com/o/oauth2/auth?response_type=token&client_id=334086275725-f15a3bl6bm7kbhfkm66u9va1si5bb9ia.apps.googleusercontent.com&redirect_uri=http://localhost.me:8006/ajax_v3/oauth2callback/&scope=https://www.googleapis.com/auth/calendar&state=profile";
        // $ch = curl_init();
        // curl_setopt($ch, CURLOPT_URL, $url);
        // curl_setopt($ch, CURLOPT_POST, 1);
        // // curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        // curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
        // curl_setopt($ch, CURLOPT_HEADER, false);
        // curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        // //curl_setopt($session, CURLOPT_VERBOSE, true);
        // curl_setopt($ch, CURLINFO_HEADER_OUT, true);
        // curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:  application/json','Authorization:  Bearer ' . $_REQUEST["access_token"],'X-JavaScript-User-Agent:  Mount Pearl Tennis Club Bookings'));
        // ob_start();
        // $res = curl_exec($ch);
        // curl_close($ch);
        // $cont=ob_get_contents();ob_end_clean();


        // $js = json_decode($cont);
        // $buffer = curl_exec ($ch);
        // $cinfo = curl_getinfo($ch);
        // curl_close($ch);
        // print_r($cinfo);

        // if ($cinfo['http_code'] != 200)
        // {
        //     echo "1";
        // }
        // echo $buffer;
    }

    public function oauth_o(){
        $this->tpl_name = "";
        require_once '../tf_app/ext/google/autoload.php';
        session_start(); 

        // ********************************************************  //
        // Get these values from https://console.developers.google.com
        // Be sure to enable the Analytics API
        // ********************************************************    //
        $client_id = '334086275725-f15a3bl6bm7kbhfkm66u9va1si5bb9ia.apps.googleusercontent.com';
        $client_secret = 'FbKWozz_ZNmlk5PUEXPC2BUO';
        $redirect_uri = 'http://localhost.me:8006/ajax_v3/oauth2callback/';

        $client = new Google_Client();
        $client->setApplicationName("test-calendar");
        $client->setClientId($client_id);
        $client->setClientSecret($client_secret);
        $client->setRedirectUri($redirect_uri);
        $client->setAccessType('offline');   // Gets us our refreshtoken

        $client->setScopes(array('https://www.googleapis.com/auth/calendar'));


        //For loging out.
        if (isset($_GET['logout'])) {
        unset($_SESSION['token']);
        }


        // Step 2: The user accepted your access now you need to exchange it.
        if (isset($_GET['code'])) {
        
        $client->authenticate($_GET['code']);  
        $_SESSION['token'] = $client->getAccessToken();
        $redirect = 'http://' . $_SERVER['HTTP_HOST'] . $_SERVER['PHP_SELF'];
        header('Location: ' . filter_var($redirect, FILTER_SANITIZE_URL));
        }

        // Step 1:  The user has not authenticated we give them a link to login    
        if (!isset($_SESSION['token'])) {

        $authUrl = $client->createAuthUrl();

        print "<a class='login' href='$authUrl'>Connect Me!</a>";
        }    


        // Step 3: We have access we can now create our service
        if (isset($_SESSION['token'])) {
        $client->setAccessToken($_SESSION['token']);
        print "<a class='logout' href='http://www.daimto.com/Tutorials/PHP/GCOAuth.php?logout=1'>LogOut</a><br>";   
        
        $service = new Google_Service_Calendar($client);    
        
        $calendarList  = $service->calendarList->listCalendarList();;

        while(true) {
            foreach ($calendarList->getItems() as $calendarListEntry) {

                echo $calendarListEntry->getSummary()."<br>\n";


                // get events 
                $events = $service->events->listEvents($calendarListEntry->id);


                foreach ($events->getItems() as $event) {
                    echo "-----".$event->getSummary()."<br>";
                }
            }
            $pageToken = $calendarList->getNextPageToken();
            if ($pageToken) {
                $optParams = array('pageToken' => $pageToken);
                $calendarList = $service->calendarList->listCalendarList($optParams);
            } else {
                break;
            }
        }
        }
    }


    public function oauth2callback_o(){
        $this->tpl_name = "";
        require_once '../tf_app/ext/google/autoload.php';
        session_start(); 

        // ********************************************************  //
        // Get these values from https://console.developers.google.com
        // Be sure to enable the Analytics API
        // ********************************************************    //
        $client_id = '334086275725-f15a3bl6bm7kbhfkm66u9va1si5bb9ia.apps.googleusercontent.com';
        $client_secret = 'FbKWozz_ZNmlk5PUEXPC2BUO';
        $redirect_uri = 'http://localhost.me:8006/ajax_v3/oauth2callback/';
        $primary = '3h37pgh9qvtvd9r7jun88elhfk@group.calendar.google.com';

        $client = new Google_Client();
        $client->setApplicationName("test-calendar");
        $client->setClientId($client_id);
        $client->setClientSecret($client_secret);
        $client->setRedirectUri($redirect_uri);
        $client->setAccessType('offline');   // Gets us our refreshtoken

        $client->setScopes(array('https://www.googleapis.com/auth/calendar'));

        //For loging out.
        if (isset($_GET['logout'])) {
        unset($_SESSION['token']);
        }

        // Step 2: The user accepted your access now you need to exchange it.
        if (isset($_GET['code'])) {
        
        $client->authenticate($_GET['code']);  
        $_SESSION['token'] = $client->getAccessToken();
        $redirect = 'http://' . $_SERVER['HTTP_HOST'] . $_SERVER['PHP_SELF'];
        header('Location: ' . filter_var($redirect, FILTER_SANITIZE_URL));
        }

        // $_SESSION["token"]["access_token"] = "ya29.xAFLnfAz9X-h7LWyUF6258cMbOzcUljurQPw0UMPdnpP15fiz5SWY0yJXvKvfaupQuYCPA";
        // Step 1:  The user has not authenticated we give them a link to login    
        if (!isset($_SESSION['token'])) {

        $authUrl = $client->createAuthUrl();

        print "<a class='login' href='$authUrl'>Connect Me!</a>";
        }    

        // $tk->access_token = "ya29.xAGoNKEYi56hQXikJVDs52BTGoNX37iWNjSBBD7i-X0LvZbnMS8f2UX6L4n4iZUgSAp_6w";
        // $tk->token_type = "Bearer";
        // // $tk->expires_in = "ya29.xAGoNKEYi56hQXikJVDs52BTGoNX37iWNjSBBD7i-X0LvZbnMS8f2UX6L4n4iZUgSAp_6w";
        // $tk->created = "1438572083";
        // $_SESSION["token"] = json_encode($tk);
        // print_r($_SESSION);
        // Step 3: We have access we can now create our service
        if (isset($_SESSION['token'])) {
            $client->setAccessToken($_SESSION['token']);
            $token = json_decode($_SESSION['token']);
            echo "Access Token = " . $token->access_token . '<br/>';
            echo "Refresh Token = " . $token->refresh_token . '<br/>';
            echo "Token type = " . $token->token_type . '<br/>';
            echo "Expires in = " . $token->expires_in . '<br/>';
            echo "ID Token = " . $token->id_token . '<br/>';
            echo "Created = " . $token->created . '<br/>';

            print "<a class='logout' href='http://localhost.me:8006/ajax_v3/oauth2callback?logout=1'>LogOut</a><br>";   
            
            $service = new Google_Service_Calendar($client);    
            
            // $calendarList  = $service->calendarList->listCalendarList();;

            // while(true) {
            //     foreach ($calendarList->getItems() as $calendarListEntry) {

            //         echo $calendarListEntry->getSummary()."<br>\n";


            //         // get events 
            //         $events = $service->events->listEvents($calendarListEntry->id);


            //         foreach ($events->getItems() as $event) {
            //             echo "-----".$event->getSummary()."<br>";
            //         }
            //     }
            //     $pageToken = $calendarList->getNextPageToken();
            //     if ($pageToken) {
            //         $optParams = array('pageToken' => $pageToken);
            //         $calendarList = $service->calendarList->listCalendarList($optParams);
            //     } else {
            //         break;
            //     }
            // }




            // $event = new Google_Service_Calendar_Event(array(
            //   'summary' => 'Google I/O 2015 2232',
            //   'description' => 'A chance to hear more about Google\'s developer products.',
            //   'start' => array(
            //     'date' => '2015-08-01'
            //   ),
            //   'end' => array(
            //     'date' => '2015-08-05'
            //   ),
            // ));

            // $calendarId = '3h37pgh9qvtvd9r7jun88elhfk@group.calendar.google.com';
            // $event = $service->events->insert($calendarId, $event);
            // printf('Event created: %s\n', $event->htmlLink);
            



            // Remove
            // $events = $service->events->listEvents($primary);

            // while(true) {
            //   foreach ($events->getItems() as $event) {
            //     echo $event->getSummary();
            //     $service->events->delete($primary, $event->id);
            //   }
            //   $pageToken = $events->getNextPageToken();
            //   if ($pageToken) {
            //     $optParams = array('pageToken' => $pageToken);
            //     $events = $service->events->listEvents('primary', $optParams);
            //   } else {
            //     break;
            //   }
            // }


            // reservation
            // $rsv = $this->Space_reserve->list_(1, 1000, 'sr.state = 1 and sr.date > "'.date('Y.m.d', strtotime('-1 month')).'"');
            // $len_rsv = sizeof($rsv);
            // for ($r=0; $r<$len_rsv; $r++) {
            //     $rsv[$r]["s"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", $rsv[$r]["date"]).$rsv[$r]["start"])), 'T', 10, 0);
            //     $rsv[$r]["e"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", $rsv[$r]["date"]).$rsv[$r]["end"])), 'T', 10, 0);
            //     $rsv[$r]["summary"] = "[Reservation] ".$rsv[$r]["purpose"];
            //     $rsv[$r]["location"] =  "D.CAMP ".$rsv[$r]["opt"]."F ".$rsv[$r]["name"];
            // }

            // event
            // $ev = $this->Event->list_(1, 10000, 'e.state = 1 and open = 1 and e.date > "'.date('Y.m.d', strtotime('-1 month')).'"');
            // $len_ev = sizeof($ev);
            // for ($r=0; $r<$len_ev; $r++) {
            //     $ev[$r]["s"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", $ev[$r]["date"]).$ev[$r]["start"])), 'T', 10, 0);
            //     $ev[$r]["e"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", $ev[$r]["date_e"]).$ev[$r]["end"])), 'T', 10, 0);
            //     $ev[$r]["summary"] = "[Event] ".$ev[$r]["title"];
            //     if ($ev[$r]["space_id"] == 0)
            //         $ev[$r]["location"] =  $ev[$r]["space_etc"];
            //     else
            //         $ev[$r]["location"] =  "D.CAMP ".$ev[$r]["opt"]."F ".explode_ext($ev[$r]["sname"], '('); 
            // }

            // office_hours
            // $off = $this->Office_hours->list_(1, 1000, 'o.status = 1 and o.is_open = 1 and o.e_start > "'.date('Y.m.d', strtotime('-1 month')).'"');
            // $len_off = sizeof($off);
            // for ($r=0; $r<$len_off; $r++) {
            //     $off[$r]["s"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", str_replace(" ", "", $off[$r]["e_start"])))), 'T', 10, 0);
            //     $off[$r]["e"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", str_replace(" ", "", $off[$r]["e_end"])))), 'T', 10, 0);
            //     $off[$r]["summary"] = "[Office Hours] ".$off[$r]["subject"];
            //     $off[$r]["location"] =  "D.CAMP ".$off[$r]["place"];
            // }
            
            // challenge
            $ch = $this->Competitions->get_list(1, 1000, 'c.status = 1 and c.open = 1 and c.date_s > "'.date('Y.m.d', strtotime('-1 month')).'"');
            $len_ch = sizeof($ch);
            for ($r=0; $r<$len_ch; $r++) {
                $ch[$r]["s"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", $ch[$r]["date_s"]).$ch[$r]["time_s"])), 'T', 10, 0);
                $ch[$r]["e"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", $ch[$r]["date_e"]).$ch[$r]["time_e"])), 'T', 10, 0);
                $ch[$r]["summary"] = "[Challenge] ".$ch[$r]["subject"];
                $ch[$r]["location"] =  "";
            }


            $fo = $ch;
            $len_fo = sizeof($fo);
            for ($i=0; $i<$len_fo; $i++) {
                $event = new Google_Service_Calendar_Event(array(
                  'summary' => $fo[$i]["summary"],
                  // 'description' => 'A chance to hear more about Google\'s developer products.',
                  'location' => $fo[$i]["location"],
                  'start' => array(
                    'dateTime' => $fo[$i]["s"],
                    'timeZone' => "Asia/Seoul"
                  ),
                  'end' => array(
                    'dateTime' => $fo[$i]["e"],
                    'timeZone' => "Asia/Seoul"
                  ),
                ));

                $calendarId = '3h37pgh9qvtvd9r7jun88elhfk@group.calendar.google.com';
                $event = $service->events->insert($calendarId, $event);
                // printf('<br>Event created: %s\n', $event->htmlLink);
            }
        }
    }

    public function oauth(){
        $this->tpl_name = "";
        require_once '../tf_app/ext/google/autoload.php';
        session_start(); 

        // ********************************************************  //
        // Get these values from https://console.developers.google.com
        // Be sure to enable the Analytics API
        // ********************************************************    //
        $client_id = '334086275725-f15a3bl6bm7kbhfkm66u9va1si5bb9ia.apps.googleusercontent.com';
        $client_secret = 'FbKWozz_ZNmlk5PUEXPC2BUO';
        $redirect_uri = 'http://localhost.me:8006/ajax_v3/oauth2callback';

        $client = new Google_Client();
        $client->setApplicationName("test-calendar");
        $client->setClientId($client_id);
        $client->setClientSecret($client_secret);
        $client->setRedirectUri($redirect_uri);
        $client->setAccessType('offline');   // Gets us our refreshtoken
        $client->setScopes(array('https://www.googleapis.com/auth/calendar'));

        //For loging out.
        if (isset($_GET['logout'])) {
        unset($_SESSION['token']);
        }

        // Step 2: The user accepted your access now you need to exchange it.
        if (isset($_GET['code'])) {
        
        $client->authenticate($_GET['code']);  
        $_SESSION['token'] = $client->getAccessToken();
        $redirect = 'http://' . $_SERVER['HTTP_HOST'] . $_SERVER['PHP_SELF'];
        header('Location: ' . filter_var($redirect, FILTER_SANITIZE_URL));
        }

        // $_SESSION["token"]["access_token"] = "ya29.xAFLnfAz9X-h7LWyUF6258cMbOzcUljurQPw0UMPdnpP15fiz5SWY0yJXvKvfaupQuYCPA";
        // Step 1:  The user has not authenticated we give them a link to login    
        if (!isset($_SESSION['token'])) {

        $authUrl = $client->createAuthUrl();

        print "<a class='login' href='$authUrl'>Connect Me!</a>";
        }    

        // Step 3: We have access we can now create our service
        if (isset($_SESSION['token'])) {
            header('Location: ' . $redirect_uri);
        }
    }

    public function oauth2callback_test(){
        require_once '../tf_app/ext/google/autoload.php';
        $client_id = '334086275725-f15a3bl6bm7kbhfkm66u9va1si5bb9ia.apps.googleusercontent.com';
        $client_secret = 'FbKWozz_ZNmlk5PUEXPC2BUO';
        $redirect_uri = 'http://localhost.me:8006/ajax_v3/oauth2callback';

        $client = new Google_Client();
        $client->setApplicationName("test-calendar");
        $client->setClientId($client_id);
        $client->setClientSecret($client_secret);
        $client->setRedirectUri($redirect_uri);
        $client->setAccessType('offline');   // Gets us our refreshtoken
        $client->setScopes(array('https://www.googleapis.com/auth/calendar'));

        $t["access_token"] = "ya29.xAGoNKEYi56hQXikJVDs52BTGoNX37iWNjSBBD7i-X0LvZbnMS8f2UX6L4n4iZUgSAp_6w"; 
        $_SESSION['token'] = json_encode($t);
        $client->setAccessToken($_SESSION['token']);

        $service = new Google_Service_Calendar($client);    
            
        $calendarList  = $service->calendarList->listCalendarList();;

        while(true) {
            foreach ($calendarList->getItems() as $calendarListEntry) {

                echo $calendarListEntry->getSummary()."<br>\n";


                // get events 
                $events = $service->events->listEvents($calendarListEntry->id);


                foreach ($events->getItems() as $event) {
                    echo "-----".$event->getSummary()."<br>";
                }
            }
            $pageToken = $calendarList->getNextPageToken();
            if ($pageToken) {
                $optParams = array('pageToken' => $pageToken);
                $calendarList = $service->calendarList->listCalendarList($optParams);
            } else {
                break;
            }
        }
    }

    public function oauth2callback(){
        $this->tpl_name = "";
        require_once '../tf_app/ext/google/autoload.php';
        session_start(); 

        // ********************************************************  //
        // Get these values from https://console.developers.google.com
        // Be sure to enable the Analytics API
        // ********************************************************    //
        $client_id = '334086275725-f15a3bl6bm7kbhfkm66u9va1si5bb9ia.apps.googleusercontent.com';
        $client_secret = 'FbKWozz_ZNmlk5PUEXPC2BUO';
        $redirect_uri = 'http://localhost.me:8006/ajax_v3/oauth2callback';

        $client = new Google_Client();
        $client->setApplicationName("test-calendar");
        $client->setClientId($client_id);
        $client->setClientSecret($client_secret);
        $client->setRedirectUri($redirect_uri);
        $client->setAccessType('offline');   // Gets us our refreshtoken
        $client->setScopes(array('https://www.googleapis.com/auth/calendar'));

        //For loging out.
        if (isset($_GET['logout'])) {
        unset($_SESSION['token']);
        }

        // Step 2: The user accepted your access now you need to exchange it.
        if (isset($_GET['code'])) {
        
        $client->authenticate($_GET['code']);  
        $_SESSION['token'] = $client->getAccessToken();
        $redirect = 'http://' . $_SERVER['HTTP_HOST'] . $_SERVER['PHP_SELF'];
        header('Location: ' . filter_var($redirect, FILTER_SANITIZE_URL));
        }

        // $_SESSION["token"]["access_token"] = "ya29.xAFLnfAz9X-h7LWyUF6258cMbOzcUljurQPw0UMPdnpP15fiz5SWY0yJXvKvfaupQuYCPA";
        // Step 1:  The user has not authenticated we give them a link to login    
        if (!isset($_SESSION['token'])) {

        $authUrl = $client->createAuthUrl();

        print "<a class='login' href='$authUrl'>Connect Me!</a>";
        }    

        // Step 3: We have access we can now create our service
        if (isset($_SESSION['token'])) {
            // $client->refreshToken($refreshToken);
            

            $client->setAccessToken($_SESSION['token']);
            $refresh_token = $client->getRefreshToken();
            $_SESSION['refresh_token'] = $refresh_token;
            $token = json_decode($_SESSION['token']);
            // echo "Access Token = " . $token->access_token . '<br/>';
            // echo "Refresh Token = " . $token->refresh_token . '<br/>';
            // echo "Token type = " . $token->token_type . '<br/>';
            // echo "Expires in = " . $token->expires_in . '<br/>';
            // echo "ID Token = " . $token->id_token . '<br/>';
            // echo "Created = " . $token->created . '<br/>';

            print "<a class='logout' href='http://localhost.me:8006/ajax_v3/oauth2callback?logout=1'>LogOut</a><br>";   
            // print_r($_SESSION);
            $service = new Google_Service_Calendar($client);    


            $calendarList  = $service->calendarList->listCalendarList();;

            while(true) {
                foreach ($calendarList->getItems() as $calendarListEntry) {

                    echo $calendarListEntry->getSummary()."<br>\n";


                    // get events 
                    $events = $service->events->listEvents($calendarListEntry->id);


                    foreach ($events->getItems() as $event) {
                        echo "-----".$event->getSummary()."<br>";
                    }
                }
                $pageToken = $calendarList->getNextPageToken();
                if ($pageToken) {
                    $optParams = array('pageToken' => $pageToken);
                    $calendarList = $service->calendarList->listCalendarList($optParams);
                } else {
                    break;
                }
            }
        

            // reservation
            if ($_REQUEST["type"] == "r") {
                $rsv = $this->Space_reserve->list_(1, 1000, 'sr.state = 1 and sr.date > "'.date('Y.m.d', strtotime('-1 month')).'"');
                $len_rsv = sizeof($rsv);
                for ($r=0; $r<$len_rsv; $r++) {
                    $rsv[$r]["s"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", $rsv[$r]["date"]).$rsv[$r]["start"])), 'T', 10, 0);
                    $rsv[$r]["e"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", $rsv[$r]["date"]).$rsv[$r]["end"])), 'T', 10, 0);
                    $rsv[$r]["summary"] = "[".$rsv[$r]["opt"]."F ".explode_ext($rsv[$r]["name"], '(')."] ".$rsv[$r]["purpose"];
                    $rsv[$r]["location"] =  $rsv[$r]["opt"]."F ".explode_ext($rsv[$r]["name"], '(');
                }
                $_calId = '6er2bdtm0ojetsnn09uj6plbq8@group.calendar.google.com';
                $fo = $rsv;
            }
                

            // event
            if ($_REQUEST["type"] == "e") {
                $ev = $this->Event->list_(1, 10000, 'e.state = 1 and open = 1 and (e.date > "'.date('Y.m.d', strtotime('-1 month')).'" or e.date_e > "'.date('Y.m.d', strtotime('-1 month')).'")');
                $len_ev = sizeof($ev);
                for ($r=0; $r<$len_ev; $r++) {
                    $ev[$r]["s"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", $ev[$r]["date"]).$ev[$r]["start"])), 'T', 10, 0);
                    $ev[$r]["e"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", $ev[$r]["date_e"]).$ev[$r]["end"])), 'T', 10, 0);
                    $ev[$r]["summary"] = "[Event] ".$ev[$r]["title"];
                    if ($ev[$r]["space_id"] == 0)
                        $ev[$r]["location"] =  $ev[$r]["space_etc"];
                    else
                        $ev[$r]["location"] =  "D.CAMP ".$ev[$r]["opt"]."F ".explode_ext($ev[$r]["sname"], '('); 
                }
                $_calId = '3h37pgh9qvtvd9r7jun88elhfk@group.calendar.google.com';
                $fo = $ev;
            }

            // office_hours
            if ($_REQUEST["type"] == "o") {
                $off = $this->Office_hours->list_(1, 1000, 'o.status = 1 and o.is_open = 1 and o.e_start > "'.date('Y.m.d', strtotime('-1 month')).'"');
                $len_off = sizeof($off);
                for ($r=0; $r<$len_off; $r++) {
                    $off[$r]["s"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", str_replace(" ", "", $off[$r]["e_start"])))), 'T', 10, 0);
                    $off[$r]["e"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", str_replace(" ", "", $off[$r]["e_end"])))), 'T', 10, 0);
                    $off[$r]["summary"] = "[Office Hours] ".$off[$r]["subject"];
                    $off[$r]["location"] =  "D.CAMP ".$off[$r]["place"];
                }
                $_calId = 'nimj7bsr657bed4tvbs9e2f0v8@group.calendar.google.com';
                $fo = $off;
            }
            
            // challenge
            if ($_REQUEST["type"] == "c") {
                $ch = $this->Competitions->get_list(1, 1000, 'c.status = 1 and c.open = 1 and (c.date_s > "'.date('Y.m.d', strtotime('-1 month')).'" or c.date_e > "'.date('Y.m.d', strtotime('-1 month')).'")');
                $len_ch = sizeof($ch);
                for ($r=0; $r<$len_ch; $r++) {
                    $ch[$r]["s"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", $ch[$r]["date_s"]).$ch[$r]["time_s"])), 'T', 10, 0);
                    $ch[$r]["e"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", $ch[$r]["date_e"]).$ch[$r]["time_e"])), 'T', 10, 0);
                    $ch[$r]["summary"] = "[Challenge] ".$ch[$r]["subject"];
                    $ch[$r]["location"] =  "";
                }
                $_calId = 'og6984e1dnfuvjdgrv9j52f95o@group.calendar.google.com';
                $fo = $ch;
            }

            // Remove
            if ($_REQUEST["remove"]) {
                // $primary = 'og6984e1dnfuvjdgrv9j52f95o@group.calendar.google.com';
                $events = $service->events->listEvents($_calId);
                
                while(true) {
                  foreach ($events->getItems() as $event) {
                    echo $event->getSummary();
                    $service->events->delete($_calId, $event->id);
                  }
                  $pageToken = $events->getNextPageToken();
                  if ($pageToken) {
                    $optParams = array('pageToken' => $pageToken);
                    $events = $service->events->listEvents($_calId, $optParams);
                  } else {
                    break;
                  }
                }
            }
            else {
                if ($fo) {
                    $len_fo = sizeof($fo);
                    for ($i=0; $i<$len_fo; $i++) {
                        $event = new Google_Service_Calendar_Event(array(
                          'summary' => $fo[$i]["summary"],
                          // 'description' => 'A chance to hear more about Google\'s developer products.',
                          'location' => $fo[$i]["location"],
                          'start' => array(
                            'dateTime' => $fo[$i]["s"],
                            'timeZone' => "Asia/Seoul"
                          ),
                          'end' => array(
                            'dateTime' => $fo[$i]["e"],
                            'timeZone' => "Asia/Seoul"
                          ),
                        ));

                        $calendarId = $_calId;
                        $event = $service->events->insert($calendarId, $event);
                        // printf('<br>Event created: %s\n', $event->htmlLink);
                    }
                }         
            }      
        }
    }
}
?>