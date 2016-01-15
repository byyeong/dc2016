<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Recruit extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "default";
    var $use_models = array("Recruit", "Code", "Recruit_opt", "Local", "Code"
            , "Startup_member", "Startup", "Startup_bussiness", "Banner");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "recruit";
        $this->assigns_layout["gnb_title"] = "채용정보";
        $this->assigns_layout["con"] = get_contents_category();
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns_layout["s"] = $_SESSION["s"];
    }
    
    public function index($_page = 1)
    {
        $pagesize = 10;
        if ($_REQUEST["ing"]) {
            $where = 'r.en < 2 and r.state = 1 '
                .'and ('
                    .'(r.start <= "'.date("Y.m.d").'" and r.end >= "'.date("Y.m.d").'") '
                    .'or (r.start <= "'.date("Y.m.d").'" and r.end = "") '
                    .'or (r.start = "" and r.end = "") '
                .') and r.startup_id = '.$_REQUEST["ing"];
        }
        else  {
            if (! $_REQUEST["status"]) $_REQUEST["status"] = 'ing';
            if ($_REQUEST["status"] == 'all') {
                $where = 'r.en < 2 and r.state = 1';
            }
            else if ($_REQUEST["status"] == 'ing') {
                $where = 'r.en < 2 and r.state = 1 '
                .'and ('
                    .'(r.start <= "'.date("Y.m.d").'" and r.end >= "'.date("Y.m.d").'") '
                    .'or (r.start <= "'.date("Y.m.d").'" and r.end = "") '
                    .'or (r.start = "" and r.end = "") '
                .')';
            }
            else if ($_REQUEST["status"] == 'end') {
                $where = 'r.en < 2 and r.state = 1 and r.end < "'.date("Y.m.d").'" and r.end != ""';
            }
        }
        if ($_REQUEST["inv"])
            $res = $this->Recruit->list_s_opt($_page, $pagesize, 7, $_REQUEST["inv"], $where, 'r.date_edited DESC');
        else
            $res = $this->Recruit->list_s_($_page, $pagesize, $where, 'r.date_edited DESC');
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            $res[$i]["inv"] = $this->Recruit_opt->get_detail($res[$i]["id"], 7);
            $res[$i]["term"] = $this->Recruit_opt->get_detail($res[$i]["id"], 4);
            $res[$i]["job"] = $this->Recruit_opt->get_detail($res[$i]["id"], 6);
            $res[$i]["bis"] = $this->Startup_bussiness->get_by_member_c($res[$i]["id"]);
        }
        $tot = $this->Recruit->list_s_cnt($where);

        $invL = $this->Code->get_by_key('inv');
        for ($v=0; $v<sizeof($invL); $v++) {
            $invL[$v]["cnt"] = $this->Recruit_opt->cnt_by_opt(7, $invL[$v]["id"], $where);
        }

        $this->assigns["res"] = $res;
        $this->assigns["tot"] = $tot;
        $this->assigns["invL"] = $invL;
        $this->assigns["status"] = $_REQUEST["status"];
        $this->assigns["inv"] = $_REQUEST["inv"];
        $this->assigns["ing"] = $_REQUEST["ing"];
        $this->assigns["banner"] = $this->Banner->get_one(2);
    }

    public function index_n($_page = 1)
    {
        $pagesize = 10;
        if ($_REQUEST["ing"]) {
            $res = $this->Recruit->list_s_($_page, $pagesize, 'r.en < 2 and r.state = 1 and s.id = '.$_REQUEST["ing"].' and r.end > "'.date("Y.m.d").'"', 'r.date_edited DESC');
            $this->assigns["ing"] = $_REQUEST["ing"];
        }
        // else  {
        //     $res = $this->Recruit->list_s_($_page, $pagesize, 'r.en < 2 and r.state = 1 and r.end > "'.date("Y.m.d").'"', 'r.date_edited DESC');
        //     $this->assigns["ing"] = 0;
        // }
        // $len_res = sizeof($res);
        // for ($i=0; $i<$len_res; $i++) {
        //     $res[$i]["inv"] = $this->Recruit_opt->get_detail($res[$i]["id"], 7);
        //     $res[$i]["term"] = $this->Recruit_opt->get_detail($res[$i]["id"], 4);
        //     $res[$i]["job"] = $this->Recruit_opt->get_detail($res[$i]["id"], 6);
        //     $res[$i]["bis"] = $this->Startup_bussiness->get_by_member_c($res[$i]["id"]);
        // }
        // $this->assigns["res"] = $res;
        
        if ($_REQUEST["ing"]) {
            // $res = $this->Recruit->list_s_($_page, $pagesize, 'r.en < 2 and r.state = 1 and s.id = '.$_REQUEST["ing"]. 
            //     'and ('
            //         .'(r.start <= "'.date("Y.m.d").'" and r.end >= "'.date("Y.m.d").'") '
            //         .'or (r.start <= "'.date("Y.m.d").'" and r.end = "") '
            //         .'or (r.start = "" and r.end = "")'
            //     .')');
            $where = 'r.en < 2 and r.state = 1 '
                .'and ('
                    .'(r.start <= "'.date("Y.m.d").'" and r.end >= "'.date("Y.m.d").'") '
                    .'or (r.start <= "'.date("Y.m.d").'" and r.end = "") '
                    .'or (r.start = "" and r.end = "") '
                .') and r.startup_id = '.$_REQUEST["ing"];
            $this->assigns["ing"] = $_REQUEST["ing"];
        }
        else {
            if (!$_REQUEST["status"]) $_REQUEST["status"] = 'ing';
            if ($_REQUEST["status"] == 'ing') {
                $where = 'r.en < 2 and r.state = 1 '
                .'and ('
                    .'(r.start <= "'.date("Y.m.d").'" and r.end >= "'.date("Y.m.d").'") '
                    .'or (r.start <= "'.date("Y.m.d").'" and r.end = "") '
                    .'or (r.start = "" and r.end = "")'
                .')';
            }
            else if ($_REQUEST["status"] == 'end') {
                $where = 'r.en < 2 and r.state = 1 and r.end < "'.date("Y.m.d").'"';
            }
            else {
                $where = 'r.en < 2 and r.state = 1';
            }
        
            $this->assigns["status"] = $_REQUEST["status"];
        }

        // $this->Recruit->debug();
        $res = $this->Recruit->list_s_mail($where, 'r.date_edited DESC', $_page, $pagesize);
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {

            $r = $this->Recruit->list_s_('', '', 's.id = '.$res[$i]["sid"].' and '.$where, 'r.date_edited DESC');
            $len_r = sizeof($r);
            for ($ii=0; $ii<$len_r; $ii++) {
                $r[$ii]["inv"] = $this->Recruit_opt->get_detail($r[$ii]["rid"], 7);
                $r[$ii]["term"] = $this->Recruit_opt->get_detail($r[$ii]["rid"], 4);
                $r[$ii]["job"] = $this->Recruit_opt->get_detail($r[$ii]["rid"], 6);
            }
            $res[$i]["rec"] = $r;
        }
            
        $this->assigns["res"] = $res;
        $this->assigns["page"] = $_page;
        
        if ($_REQUEST["status"] == 'all') {
            $tot = $this->Recruit->cnt('', 'en < 2 and state = 1');
        }
        else if ($_REQUEST["status"] == 'ing') {
            $tot = $this->Recruit->cnt('', 'en < 2 and state = 1 '
                .'and ('
                    .'(start <= "'.date("Y.m.d").'" and end >= "'.date("Y.m.d").'") '
                    .'or (start <= "'.date("Y.m.d").'" and end = "") '
                    .'or (start = "" and end = "")'
                .')');
            $i_where = 'en < 2 and state = 1 '
                .'and ('
                    .'(start <= "'.date("Y.m.d").'" and end >= "'.date("Y.m.d").'") '
                    .'or (start <= "'.date("Y.m.d").'" and end = "") '
                    .'or (start = "" and end = "")'
                .')';
        }
        else if ($_REQUEST["status"] == 'end') {
            $tot = $this->Recruit->cnt('', 'en < 2 and state = 1 and end < "'.date("Y.m.d").'"');
            $i_where = "";
        }
        else if ($_REQUEST["ing"]) {
            $tot = $this->Recruit->cnt('', 'en < 2 and state = 1 '
                .'and ('
                    .'(start <= "'.date("Y.m.d").'" and end >= "'.date("Y.m.d").'") '
                    .'or (start <= "'.date("Y.m.d").'" and end = "") '
                    .'or (start = "" and end = "") '
                .') and startup_id = '.$_REQUEST["ing"]);
            $i_where = $where;
        }
        $this->assigns["tot"] = $tot;

        $invL = $this->Code->get_by_key('inv');
        for ($v=0; $v<sizeof($invL); $v++) {
            $invL[$v]["cnt"] = $this->Recruit_opt->cnt_by_opt(7, $invL[$v]["id"], $i_where);
        }
        $this->assigns["invL"] = $invL;
        $this->assigns["inv"] = $_REQUEST["inv"];
        
        $my_st = $this->Startup_member->get_list_by_user($_SESSION["s"]["id"], 'sm.status = 1');
        if (!$my_st) {
            $this->assigns["rec"] = TRUE;
        }
    }
    
    public function views($_id)
    {
        $res = $this->Recruit->get($_id);
        if ($res && $res["state"] == 1) {
            $this->Recruit->pageview($_id);
            $res["local"] = $this->Recruit_opt->get_detail($_id, 1);
            $res["career"] = $this->Recruit_opt->get_detail($_id, 2);
            $res["term"] = $this->Recruit_opt->get_detail($_id, 4);
            $res["part"] = $this->Recruit_opt->get_detail($_id, 7);
            // $res["dev"] = $this->Recruit_opt->get_detail($_id, 3);
            // $res["lang"] = $this->Recruit_opt->get_detail($_id, 5);
            // $res["job"] = $this->Recruit_opt->get_detail($_id, 6);
            

            $this->assigns["res"] = $res;
            $st_res = $this->Recruit->list_s_(1, 5, 'r.en < 2 and r.state = 1 '
                .'and ('
                    .'(r.start <= "'.date("Y.m.d").'" and r.end >= "'.date("Y.m.d").'") '
                    .'or (r.start <= "'.date("Y.m.d").'" and r.end = "") '
                    .'or (r.start = "" and r.end = "")'
                .')', 'v_cnt DESC');
            for ($sr=0; $sr<sizeof($st_res); $sr++) {
                $st_res[$sr]["part"] = $this->Recruit_opt->get_detail($st_res[$sr]["rid"], 7);
            }
            $this->assigns["st_res"] = $st_res;
            
            $og["type"] = 'article';
            $og["url"] = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
            $og["title"] = $res["title"]." on D.CAMP";
            $og["description"] = strip_tags($res["contents"]);
            if (strlen(strip_tags($res["contents"])) > 148) $og["description"] = mb_substr(strip_tags($res["contents"]), 0, 148, 'UTF-8').'...';
            
            $content_parsed = parse_html($res["contents"]);
            foreach ($content_parsed as $c)
            {
                if (strtolower(substr($c,0,4)) == "<img")
                {
                    $t = tag_barase($c);
                    if ($t["src"])
                    {
                        $img = $t["src"];
                        break;
                    }
                }
            }

            if ($img) $og["image"] = $img;
            else $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].$res["slogo"];
            $this->assigns_layout["og"] = $og;

            if (!strpos($_SERVER["HTTP_REFERER"], "dcamp.kr")) {
                $this->assigns_layout["cards"] = bottom_main();
            }
        }
        else {
            header("Location: /");
        }
    }
    
    public function add($_id = '')
    {
        $my_st = $this->Startup_member->get_list_by_user($_SESSION["s"]["id"], 'sm.status = 1');
        if (!$my_st) {
            $this->assigns["no_permit"] = TRUE;
        }
        else {
            
            if ($_REQUEST["del"] && $_REQUEST["id"]) {
                $this->Recruit->edit_state($_REQUEST["id"], 9);
                $_SESSION["msg"] = "해당 채용공고가 삭제되었습니다.";
                header("Location: /?c=recruit");
            }

            $this->assigns["my_st"] = $my_st;
            $this->assigns["job"] = $this->Code->get_by_key('job');
            $this->assigns["local"] = $this->Code->get_by_key('local');
            $this->assigns["career"] = $this->Code->get_by_key('career');
            $this->assigns["field"] = $this->Code->get_by_key('field', '', 'id < 20');
            $this->assigns["period"] = $this->Code->get_by_key('period');
            $this->assigns["lang"] = $this->Code->get_by_key('lang');
            $this->assigns["inv"] = $this->Code->get_by_key('inv');

            $_key = 'field';
            $result = $this->Code->get_by_key($_key);
            $items = array();
            for ($i=0; $i<sizeof($result); $i++) {
                $result[$i]["value"] = $result[$i]["_value"];
                array_push($items, $result[$i]);
            }

            $this->assigns["job"] =  json_encode($items);

            if ($_REQUEST["startup_id"]) {
                if ($_REQUEST["contents"]) {
                    $_REQUEST["contents"] = str_replace('"../../', '"'.'/', $_REQUEST["contents"]);
                    $_REQUEST["contents"] = str_replace('"../', '"'.'/', $_REQUEST["contents"]);
                }
                $id = $this->Recruit->add($_REQUEST);
                $this->Recruit_opt->delete_by_recruit($id);
                
                if ($_REQUEST["t_local"]) {
                    $local = explode(",", $_REQUEST["t_local"]);
                    $len_local = sizeof($local);
                    for($i=0; $i<$len_local; $i++) {
                        if (trim($local[$i]))
                            $this->Recruit_opt->add($id, trim($local[$i]), 1);
                    }
                }
                if ($_REQUEST["t_career"]) {
                    $career = explode(",", $_REQUEST["t_career"]);
                    $len_career = sizeof($career);
                    for($j=0; $j<$len_career; $j++) {
                        if (trim($career[$j]))
                            $this->Recruit_opt->add($id, trim($career[$j]), 2);
                    }
                }
                if ($_REQUEST["t_field"]) {
                    $field = explode(",", $_REQUEST["t_field"]);
                    $len_field = sizeof($field);
                    for($k=0; $k<$len_field; $k++) {
                        if (trim($field[$k]))
                            $this->Recruit_opt->add($id, trim($field[$k]), 3);
                    }
                }
                if ($_REQUEST["t_period"]) {
                    $period = explode(",", $_REQUEST["t_period"]);
                    $len_period = sizeof($period);
                    for($l=0; $l<$len_period; $l++) {
                        if (trim($period[$l]))
                            $this->Recruit_opt->add($id, trim($period[$l]), 4);
                    }
                }
                if ($_REQUEST["t_lang"]) {
                    $lang = explode(",", $_REQUEST["t_lang"]);
                    $len_lang = sizeof($lang);
                    for($m=0; $m<$len_lang; $m++) {
                        if (trim($lang[$m]))
                            $this->Recruit_opt->add($id, trim($lang[$m]), 5);
                    }
                }
                $len_j = $_REQUEST["cnt_j"];
                for($n=1; $n<$len_j+1; $n++) {
                    $tmp = "job_".$n;
                    if (trim($_REQUEST[$tmp]))
                        $val = $this->Code->get_value(trim($_REQUEST[$tmp]), 'jobs');
                        $this->Recruit_opt->add($id, $val['id'], '6');
                }
                if ($_REQUEST["t_inv"]) {
                    $in = explode(",", $_REQUEST["t_inv"]);
                    $len_in = sizeof($in);
                    for($ii=0; $ii<$len_in; $ii++) {
                        if (trim($in[$ii]))
                            $this->Recruit_opt->add($id, trim($in[$ii]), 7);
                    }
                }
                if (!$_REQUEST["id"]) {
                    $this->assigns["ok"] = TRUE;
                    
                    $s = $this->Startup->get($_REQUEST["startup_id"]);
                    $_msg = "<a href='/startup/".$s["id"]."'>".$s["name"]."</a>에서 <a href='/recruit/views/".$id."'>채용공고</a>를 작성했습니다.";
                    add_activity(2, $_REQUEST["startup_id"], 2, $_REQUEST["startup_id"], '', $_msg);
                }
                else {
                    $this->assigns_layout["msg"] = "수정되었습니다.";
                }
            }
            
            if ($_id) {
                $res = $this->Recruit->get($_id);
                if ($res["user_id"] != $_SESSION["s"]["id"]) {
                    $this->assigns["no_permit"] = TRUE;
                }
                else {
                    $this->assigns["res"] = $res;
                    $e_lo = $this->Recruit_opt->get_detail($_id, 1, 1);
                    $e_ca = $this->Recruit_opt->get_detail($_id, 2, 1);
                    $e_fi = $this->Recruit_opt->get_detail($_id, 3, 1);
                    $e_pe = $this->Recruit_opt->get_detail($_id, 4, 1);
                    $e_la = $this->Recruit_opt->get_detail($_id, 5, 1);
                    $e_jo = $this->Recruit_opt->get_detail($_id, 6);
                    $e_in = $this->Recruit_opt->get_detail($_id, 7, 1);
                    $this->assigns["e_lo"] = $e_lo["_value"];
                    $this->assigns["e_ca"] = $e_ca["_value"];
                    $this->assigns["e_fi"] = $e_fi["_value"];
                    $this->assigns["e_pe"] = $e_pe["_value"];
                    $this->assigns["e_la"] = $e_la["_value"];
                    $this->assigns["e_jo"] = $e_jo;
                    $this->assigns["e_inv"] = $e_in["_value"];
                }
            }
            else {
                $this->assigns["con"] = '<div>
                    <div>* 아래 입력 사항을 준수하여 채용 공고를 작성해 주세요.&nbsp;</div>
                    <div>&nbsp; 정보가 부족한 경우에는 &nbsp;승인이 어렵습니다. ^^</div>
                    </div>
                    <div>&nbsp;</div>
                    <div>1. 사업 소개</div>
                    <div>&nbsp;</div>
                    <div>2. 회사 소개</div>
                    <div>&nbsp;</div>
                    <div>3. 모집 부분 및 인원, 지원 자격</div>
                    <div>&nbsp;</div>
                    <div>4. 근무 조건 및 복지제도</div>
                    <div>&nbsp;</div>
                    <div>5. 지원 방법</div>
                    <div>&nbsp;</div>
                    <div>6. 근무지역 &nbsp;</div>
                    <div>&nbsp;</div>
                    <div>7. 유의사항</div>
                    <div>&nbsp;</div>
                    <div>8. 기타</div>';                                                      
            }
            
        }
    }

    public function mailling()
    {
        // mailing
        $this->tpl_name = "";
        $code = $this->Code->get_by_key("rec_m");
        $len_code = sizeof($code);
        if ($len_code < 1) return;

        for ($i=0; $i<$len_code; $i++) {
            $em = $this->Recruit->get_email_by_interist($code[$i]["_value"], 7);
            $len_em = sizeof($em);
            for ($ee=0; $ee<$len_em; $ee++) {
                
                $_id = $code[$i]["_value"];

                $r = $this->Recruit->get($_id);
                $iv = $this->Recruit_opt->get_detail($_id, 7, 1);
                $r["inv"] = $iv["_value"];
                $local = $this->Recruit_opt->get_detail($_id, 1, 1);
                $r["local"] = $local["_value"];
                $career = $this->Recruit_opt->get_detail($_id, 2, 1);
                $r["career"] = $career["_value"];
                $dev = $this->Recruit_opt->get_detail($_id, 3, 1);
                $r["dev"] = $dev["_value"];
                $term = $this->Recruit_opt->get_detail($_id, 4, 1);
                $r["term"] = $term["_value"];
                $lang = $this->Recruit_opt->get_detail($_id, 5, 1);
                $r["lang"] = $lang["_value"];
                $job = $this->Recruit_opt->get_detail($_id, 6, 1);
                $r["job"] = $job["_value"];
                $iv = $this->Recruit_opt->get_detail($_id, 7, 1);
                $r["inv"] = $iv["_value"];

                if ($em[$ee]["email"]) {
                    $m = new TF_mailer($this->settings);
                    $m->mailto = $em[$ee]["email"];
                    $m->subject = "[D.CAMP] ".$em[$ee]["name"]."님, 업무분야에 해당하는 채용공고를 알려드립니다.";
                    $m->tpl_name = "recruit";
                    $m->assigns["us"] = $em[$ee];
                    $m->assigns["res"] = $r;
                    $m->assigns["main_service_url"] = $this->globals->my_host;
                    $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                    $m->send();

                    echo $em[$ee]["email"];
                }
                    
            }
            $this->Code->delete_c("rec_m", $code[$i]["_value"]);
        }
        exit(1);   
    }
    
}
?>
