<?
    class Root extends Controller
    {
        var $assigns = array();
        var $assigns_layout = array();
        var $layout = "default";
        var $use_models = array("Event", "Startup", "Members", "Startup_Recruit"
                ,"Notice","Recruit","Member_interist","Member_local","Member_skill"
                ,"Startup_bussiness","Startup_tech","Startup_local", "Main", "Banner"
                ,"Startup_member", "Competitions", "Content", "Board", "Recruit_opt"
                , "Competitions", "Follow", "Space_reserve", "Event_reserve", "Entrance"
                , "Office_hours", "Code", "Program", "Startup_service", "Member_education", "Recommend");
        var $use_components = array('simple_html_dom');
        public function before_calling()
        {
            $this->assigns_layout["gnb"] = $this->tpl_name;
            $this->assigns_layout["con"] = get_contents_category();
            $this->assigns_layout["s"] = $_SESSION["s"];
            $this->assigns["s"] = $_SESSION["s"];
        }
    
        public function index($_opt = "")
        {
            $this->assigns["r"] = $_REQUEST["r"];
            $og["url"] = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
            $og["title"] = "D.CAMP – '드림뱅크' 은행권청년창업재단";
            $og["description"] = "D.CAMP – '드림뱅크' 은행권청년창업재단";
            $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].'/img/dcamp.png';
            $this->assigns_layout["og"] = $og;

            $main = $this->Main->list_("", "type > 0 and type != 3 and type != 4");
            for ($m=0; $m<sizeof($main); $m++) {
                if ($main[$m]["type"] == 1) {
                    $main[$m] = $this->Event->get_detail($main[$m]["cid"]);
                    if ($main[$m]) {
                        $main[$m]["cat"] = "event";
                    }
                    else {
                        $main[$m]["cat"] = "";
                    }
                }
                else if ($main[$m]["type"] == 2) {
                    $main[$m] = $this->Notice->get_detail($main[$m]["cid"], 1);
                    if ($main[$m]) {
                        $main[$m]["cat"] = "notice";
                    }
                    else {
                        $main[$m]["cat"] = "";
                    }
                }
                else if ($main[$m]["type"] == 5) {
                    $main[$m] = $this->Content->get($main[$m]["cid"]);
                    if ($main[$m]) {
                        $main[$m]["cat"] = "content";
                    }
                    else {
                        $main[$m]["cat"] = "";
                    }
                }
                else if ($main[$m]["type"] == 7) {
                    $main[$m] = $this->Competitions->get($main[$m]["cid"]);
                    if ($main[$m]) {
                        $main[$m]["cat"] = "competition";
                    }
                    else {
                        $main[$m]["cat"] = "";
                    }
                }
                else if ($main[$m]["type"] == 8) {
                    $main[$m] = $this->Office_hours->get($main[$m]["cid"]);
                    $main[$m]["u"] = $this->Members->get($main[$m]["mid"]);
                    if ($main[$m]) {
                        $main[$m]["cat"] = "office";
                    }
                    else {
                        $main[$m]["cat"] = "";
                    }
                }
                else if ($main[$m]["type"] == 10) {
                    $main[$m] = $this->Program->get($main[$m]["cid"]);
                    $main[$m]["u"] = $this->Members->get($main[$m]["user_id"]);
                    if ($main[$m]) {
                        $main[$m]["cat"] = "benefits";
                    }
                    else {
                        $main[$m]["cat"] = "";
                    }
                }
            }
            # new
            if ($_opt) {
                $l_main = sizeof($main);
                if ($l_main < $_opt) {
                    $tt = 0;
                    for ($t=$l_main; $t<$_opt; $t++) {
                        $main[$t] = $main[$tt];
                        $tt++;
                        if ($tt == $l_main) $tt = 0;
                    }
                }
                else {
                    $main = array_slice($main, 0, $_opt);
                }
            }
            $this->assigns["main"] = $main;
            $eve = $this->Event->list_(1, 6, 'e.picture != "" and e.apply_start < "'. date("Y.m.d H:i").'" and e.apply_end >"'. date("Y.m.d H:i").'" and e.state = 1 and e.is_main = 0', 1);
            for ($ev=0; $ev<sizeof($eve); $ev++) {
                $eve[$ev]["r_cnt"] = $this->Board->cnt("p_type = 3 and p_id = ".$eve[$ev]["id"]);
            }
            $this->assigns["event"] = $eve;
            $rec = $this->Recruit->list_s_(1, 6, 'r.state = 1 and r.end > "'. date("Y.m.d").'"');
            $len_rec = sizeof($rec);
            for ($r=0; $r<$len_rec; $r++) {
                $rec[$r]["inv"] = $this->Recruit_opt->get_detail($rec[$r]["id"], 7);
                $rec[$r]["job"] = $this->Recruit_opt->get_detail($rec[$r]["id"], 6);
                $rec[$r]["r_cnt"] = $this->Board->cnt("p_type = 5 and p_id = ".$rec[$r]["id"]);
            }
            $this->assigns["recruit"] = $rec;
            
            $cont = $this->Content->list_(1, 6, 'cc.hidden = 0 and c.hidden = 0 and c.state = 1 and c.is_main = 0');
            for ($ct=0; $ct<sizeof($cont); $ct++) {
                $cont[$ct]["r_cnt"] = $this->Board->cnt("p_type = 6 and p_id = ".$cont[$ct]["id"]);
            }
            $this->assigns["contents"] = $cont;
            
            // $comp = $this->Competitions->get_list(1, 5, 'c.is_main = 0 and c.open = 1 and c.status = 1 and date_s <= "'.date("Y.m.d").'" and date_e >= "'.date("Y.m.d").'"');
            $comp = $this->Competitions->get_list(1, 6, 'c.is_main = 0 and c.open = 1 and c.status = 1', 'id DESC');

            for ($cp=0; $cp<sizeof($comp); $cp++) {
                $comp[$cp]["r_cnt"] = $this->Board->cnt("p_type = 7 and p_id = ".$comp[$cp]["id"]);
            }
            $this->assigns["competition"] = $comp;

            $this->assigns["news1"] = $this->Board->list_news(1, 6, 'is_hidden = 0');
            
            
            $this->assigns["ma"] = $this->Banner->all();
            $_date =  date("Y.m.d", strtotime(date('Y-m-d')." +7 day"));
            $this->assigns["reserve"] = $this->Space_reserve->list_(1, 100
                    , "sr.state = 1 and date >= '".date('Y.m.d')."' and date < '".$_date."'", "sr.date ASC");

            $today_ev_users = $this->Event_reserve->list_(1, 100, "e.space_id > 0 and er.state = 1 and CONCAT(date, ' ', start) < '".date("Y.m.d H:i")."' AND CONCAT(date_e, ' ', end) > '".date("Y.m.d H:i")."'");
            $today_dcamp_users = $this->Entrance->list_('', '', '', 'date_out is NULL and date_in LIKE "'.date("Y-m-d").'%" GROUP BY m.id ');
            
            $this->assigns["en_cnt"] = sizeof($today_dcamp_users);
            $this->assigns["ev_cnt"] = sizeof($today_ev_users);
            $this->assigns["lounge_cnt"] = sizeof($today_dcamp_users) + sizeof($today_ev_users);
            if ($_SESSION["msg"]) {
                $this->assigns_layout["msg"] = $_SESSION["msg"];
                unset($_SESSION["msg"]);
            }

            $this->assigns["con"] = $this->assigns_layout["con"];
        }

        public function index_2014()
        {
            $this->layout = 'default';
            $this->assigns["r"] = $_REQUEST["r"];
            $og["url"] = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
            $og["title"] = "D.CAMP – '드림뱅크' 은행권청년창업재단";
            $og["description"] = "D.CAMP – '드림뱅크' 은행권청년창업재단";
            $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].'/img/dcamp.png';
            $this->assigns_layout["og"] = $og;

            $main = $this->Main->list_();
            for ($m=0; $m<sizeof($main); $m++) {
                if ($main[$m]["type"] == 1) {
                    $main[$m] = $this->Event->get_detail($main[$m]["cid"]);
                    $main[$m]["cat"] = "event";
                    $main[$m]["r_cnt"] = $this->Board->cnt("p_type = 3 and p_id = ".$main[$m]["id"]);
                }
                else if ($main[$m]["type"] == 2) {
                    $main[$m] = $this->Notice->get_detail($main[$m]["cid"], 1);
                    $main[$m]["cat"] = "notice";
                    $main[$m]["r_cnt"] = $this->Board->cnt("p_type = 5 and p_id = ".$main[$m]["id"]);
                }
                else if ($main[$m]["type"] == 3) {
                    $main[$m] = $this->Members->get_by_ids($main[$m]["cid"]);
                    $main[$m]["cat"] = "people";
                    $ch = $this->Follow->check_follow($_SESSION["s"]["id"], $main[$m]["id"], 1);
                    if ($ch) $main[$m]["fw"] = 1;
                }
                else if ($main[$m]["type"] == 4) {
                    $main[$m] = $this->Startup->get($main[$m]["cid"]);
                    $main[$m]["cat"] = "startup";
                    $ch = $this->Follow->check_follow($_SESSION["s"]["id"], $main[$m]["id"], 2);
                    if ($ch) $main[$m]["fw"] = 1;
                }
                else if ($main[$m]["type"] == 7) {
                    $main[$m] = $this->Competitions->get($main[$m]["cid"]);
                    $main[$m]["cat"] = "competition";
                    $main[$m]["r_cnt"] = $this->Board->cnt("p_type = 7 and p_id = ".$main[$m]["id"]);
                }

            }
            $this->assigns["main"] = $main;
            $eve = $this->Event->list_(1, 10, 'e.picture != "" and e.apply_start < "'. date("Y.m.d H:i").'" and e.apply_end >"'. date("Y.m.d H:i").'" and e.state = 1 and e.is_main = 0', 1);
            for ($ev=0; $ev<sizeof($eve); $ev++) {
                $eve[$ev]["r_cnt"] = $this->Board->cnt("p_type = 3 and p_id = ".$eve[$ev]["id"]);
            }
            $this->assigns["event"] = $eve;
            $rec = $this->Recruit->list_s_(1, 10, 'r.state = 1 and r.end > "'. date("Y.m.d").'"');
            $len_rec = sizeof($rec);
            for ($r=0; $r<$len_rec; $r++) {
                $rec[$r]["inv"] = $this->Recruit_opt->get_detail($rec[$r]["id"], 7);
                $rec[$r]["job"] = $this->Recruit_opt->get_detail($rec[$r]["id"], 6);
                $rec[$r]["r_cnt"] = $this->Board->cnt("p_type = 5 and p_id = ".$rec[$r]["id"]);
            }
            $this->assigns["recruit"] = $rec;
            
            $cont = $this->Content->list_(1, 10, 'cc.hidden = 0 and c.hidden = 0 and c.state = 1 ');
            for ($ct=0; $ct<sizeof($cont); $ct++) {
                $cont[$ct]["r_cnt"] = $this->Board->cnt("p_type = 6 and p_id = ".$cont[$ct]["id"]);
            }
            $this->assigns["contents"] = $cont;
            
            $comp = $this->Competitions->get_list(1, 10, 'c.is_main =0 and c.open = 1 and c.status = 1 and date_s <= "'.date("Y.m.d").'" and date_e >= "'.date("Y.m.d").'"');
            for ($cp=0; $cp<sizeof($comp); $cp++) {
                $comp[$cp]["r_cnt"] = $this->Board->cnt("p_type = 7 and p_id = ".$comp[$cp]["id"]);
            }
            $this->assigns["competition"] = $comp;

            $this->assigns["news1"] = $this->Board->list_news(1, 9, 'is_hidden = 0');
            
            $this->assigns["cnt_news"] = $this->Notice->cnt('visible = 1');
            $this->assigns["cnt_st"] = $this->Startup->cnt('state = 1');
            $this->assigns["cnt_mem"] = $this->Members->cnt('state = 1');
            $this->assigns["cnt_ev"] = $this->Event->cnt('state = 1');
            $this->assigns["cnt_rec"] = $this->Recruit->cnt('', 'state = 1');
            $this->assigns["cnt_cont"] = $this->Content->cnt('cc.hidden = 0 and c.hidden = 0 and c.state = 1');
            $this->assigns["cnt_comp"] = $this->Competitions->cnt('open = 1 and status = 1 and date_s <= "'.date("Y.m.d").'" and date_e >= "'.date("Y.m.d").'"');
            $this->assigns["banner"] = $this->Banner->all();
            $_date =  date("Y.m.d", strtotime(date('Y-m-d')." +7 day"));
            $this->assigns["reserve"] = $this->Space_reserve->list_(1, 100
                    , "sr.state = 1 and date >= '".date('Y.m.d')."' and date < '".$_date."'", "sr.date ASC");

            $today_ev_users = $this->Event_reserve->list_(1, 100, "er.state = 1 and CONCAT(date, ' ', start) < '".date("Y.m.d H:i")."' AND CONCAT(date_e, ' ', end) > '".date("Y.m.d H:i")."'");
            $today_dcamp_users = $this->Entrance->list_('', '', '', 'date_out is NULL and date_in LIKE "'.date("Y-m-d").'%" GROUP BY m.id ');
            
            $this->assigns["en_cnt"] = sizeof($today_dcamp_users);
            $this->assigns["ev_cnt"] = sizeof($today_ev_users);
            $this->assigns["lounge_cnt"] = sizeof($today_dcamp_users) + sizeof($today_ev_users);
            if ($_SESSION["msg"]) {
                $this->assigns_layout["msg"] = $_SESSION["msg"];
                unset($_SESSION["msg"]);
            }
        }
        
        public function search($cat = "event", $_page = 1)
        {
            $og["url"] = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
            $og["title"] = "검색 – '드림뱅크' 은행권청년창업재단";
            if ($_REQUEST['key']) $og["title"] = "검색 – '".$_REQUEST["key"]."'"; 
            $og["description"] = "D.CAMP – '드림뱅크' 은행권청년창업재단";
            $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].'/img/dcamp.png';
            $this->assigns_layout["og"] = $og;

            $pagesize = 20;
            $this->layout = 'default';
            $this->assigns["key"] = $_REQUEST["key"];
            $this->assigns["cat"] = $_REQUEST["cat"];

            //count
            $event_cnt = $this->Event->get_by_search_cnt($_REQUEST["key"]);
            $challenge_cnt = $this->Competitions->get_by_search_cnt($_REQUEST["key"]);
            $office_hours_cnt = $this->Office_hours->get_by_search_cnt($_REQUEST["key"]);
            $recruit_cnt = $this->Recruit->get_by_search_cnt($_REQUEST["key"]);
            $benefit_cnt = $this->Program->get_by_search_cnt($_REQUEST["key"]);
            $blog_cnt = $this->Content->get_by_search_cnt($_REQUEST["key"], 'c.en = 0 and c.state = 1 and cc.hidden = 0');
            $showcase_cnt = $this->Startup_service->get_by_search_cnt($_REQUEST["key"], 'status_bz = 1 and user_id_bz IS NOT NULL and img1 is not null and img1 != "" and des_ele is not null and des_ele != "" and des_pro is not null and des_pro != "" ');
            $startup_cnt = $this->Startup->get_by_search_cnt($_REQUEST["key"]);
            $people_cnt = $this->Members->get_by_search_cnt($_REQUEST["key"]);



            //resource
            if ($_REQUEST["key"]) {

                if ($cat == "event") {
                    $event = $this->Event->search($_page, $pagesize, $_REQUEST["key"]);
                    $this->assigns["event"] = $event;
                    $res_cnt = $event_cnt;
                }
                else if ($cat == "challenge") {
                    $challenge = $this->Competitions->search($_page, $pagesize, $_REQUEST["key"]);
                    $this->assigns["challenge"] = $challenge;
                    $res_cnt = $challenge_cnt;
                }
                else if ($cat == "office_hours") {
                    $office_hours = $this->Office_hours->search($_page, $pagesize, $_REQUEST["key"]);
                    $this->assigns["office_hours"] = $office_hours;
                    $res_cnt = $office_hours_cnt;
                }
                else if ($cat == "recruit") {
                    $recruit = $this->Recruit->search($_page, $pagesize, $_REQUEST["key"]);
                    $this->assigns["recruit"] = $recruit;
                    $res_cnt = $recruit_cnt;
                }
                else if ($cat == "benefit") {
                    $benefit = $this->Program->search($_page, $pagesize, $_REQUEST["key"]);
                    $this->assigns["benefit"] = $benefit;
                    $res_cnt = $benefit_cnt;
                }
                else if ($cat == "blog") {
                    $blog = $this->Content->search($_page, $pagesize, $_REQUEST["key"], 'c.en = 0 and c.state = 1 and cc.hidden = 0');
                    $this->assigns["blog"] = $blog;
                    $res_cnt = $blog_cnt;
                }
                else if ($cat == "showcase") {
                    $showcase = $this->Startup_service->search($_page, $pagesize, $_REQUEST["key"], 'status_bz = 1 and user_id_bz IS NOT NULL and img1 is not null and img1 != "" and des_ele is not null and des_ele != "" and des_pro is not null and des_pro != "" ');
                    $this->assigns["showcase"] = $showcase;
                    $res_cnt = $showcase_cnt;
                }
                else if ($cat == "startup") {
                    $startup = $this->Startup->search($_page, $pagesize, $_REQUEST["key"]);
                    $this->assigns["startup"] = $startup;
                    $res_cnt = $startup_cnt;
                }
                else if ($cat == "people") {
                    $people = $this->Members->search($_page, $pagesize, $_REQUEST["key"]);
                    $this->assigns["people"] = $people;
                    $res_cnt = $people_cnt;
                }

                $loc = $this->Code->get_by_key('local');

                if ($people) {
                    for ($i=0; $i<sizeof($people); $i++) {
                        $people[$i]["lc"] = $this->Member_local->get_by_member($people[$i]["id"]);
                        $people[$i]["sk"] = $this->Member_skill->get_by_member($people[$i]["id"]);
                        $people[$i]["in"] = $this->Member_interist->get_by_member($people[$i]["id"]);
                        $people[$i]["com"] = $this->Startup_member->get_by_user($people[$i]["id"]);
                        $people[$i]["education"] = $this->Member_education->list_($people[$i]["id"]);
                        $res_lo = $this->Member_local->get_by_member($people[$i]["id"]);
                        $loc_t = "";
                        for ($l=0; $l<sizeof($loc); $l++) {
                            
                            for ($ll=0; $ll<sizeof($res_lo); $ll++) {
                                if ($loc[$l]["id"] == $res_lo[$ll]["local_id"]) {
                                    $loc_t = $loc_t.$loc[$l]['_value'].", "; 
                                }
                            }
                        }
                        $in = $this->Member_interist->get_by_member_c($people[$i]["id"]);
                        $inv = $this->Code->get_by_key('inv');
                        $inv_t = "";
                        for ($v=0; $v<sizeof($inv); $v++) {
                            
                            for ($vv=0; $vv<sizeof($in); $vv++) {
                                if ($inv[$v]["id"] == $in[$vv]["interist_id"]) {
                                    $inv_t = $inv_t.$inv[$v]['_value'].", ";
                                }
                            }
                        }

                        $people[$i]["inv"] = $inv_t;
                        $people[$i]["local"] = $loc_t;
                        $people[$i]["sk"] = $this->Member_skill->get_by_member_c($people[$i]["id"]);
                    }
                }

                if ($startup) {
                    for ($j=0; $j<sizeof($startup); $j++) {
                        $startup[$j]["bi"] = $this->Startup_bussiness->get_by_member($startup[$j]["id"]);
                        $startup[$j]["te"] = $this->Startup_tech->get_by_member($startup[$j]["id"]);
                        $startup[$j]["lo"] = $this->Startup_local->get_by_member($startup[$j]["id"]);
                    }
                }
                if ($recruit) {
                    for ($r=0; $r<sizeof($recruit); $r++) {
                        $recruit[$r]["inv"] = $this->Recruit_opt->get_detail($recruit[$r]["id"], 7);
                    }
                }

                $this->assigns["event_cnt"] = $event_cnt;
                $this->assigns["challenge_cnt"] = $challenge_cnt;
                $this->assigns["office_hours_cnt"] = $office_hours_cnt;
                $this->assigns["recruit_cnt"] = $recruit_cnt;
                $this->assigns["benefit_cnt"] = $benefit_cnt;
                $this->assigns["blog_cnt"] = $blog_cnt;
                $this->assigns["showcase_cnt"] = $showcase_cnt;
                $this->assigns["startup_cnt"] = $startup_cnt;
                $this->assigns["people_cnt"] = $people_cnt;
                $this->assigns["all_cnt"] = $event_cnt+$challenge_cnt+$office_hours_cnt+$recruit_cnt+$benefit_cnt+$blog_cnt+$showcase_cnt+$startup_cnt+$people_cnt;
                $this->assigns["cat"] = $cat;
                $this->assigns["page"] = $_page;
                $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);
            }
        }
        public function about_test()
        {
            $og["url"] = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
            $og["title"] = "D.CAMP 소개 – '드림뱅크' 은행권청년창업재단";
            $og["description"] = "D.CAMP – '드림뱅크' 은행권청년창업재단";
            $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].'/img/dcamp.png';
            $this->assigns_layout["og"] = $og;

            //press
            $_page = 1;
            $pagesize = 10;
            $res = $this->Board->list_press($_page, $pagesize, 'is_hidden = 0');
            $len_res = sizeof($res);

            for ($i=0; $i<$len_res; $i++) {
                //$res[$i]["contents"] = trans_url($res[$i]['contents'], false, "<small>/ 2015.10.05</small>");
                $html = str_get_html($res[$i]["sub"]);
                if($res[$i]["sub"] && count($html->find('a[class=title]')) > 0){
                    foreach($html->find('a[class=title]') as $element){

                        ob_start();
                        echo $element;
                        $res[$i]["sub"] = ob_get_contents();
                        ob_end_clean();
                    }
                }
            }
            $this->layout = 'blank';
            $this->assigns["res"] = $res;
        }
        public function about()
        {
            $og["url"] = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
            $og["title"] = "D.CAMP 소개 – '드림뱅크' 은행권청년창업재단";
            $og["description"] = "D.CAMP – '드림뱅크' 은행권청년창업재단";
            $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].'/img/dcamp.png';
            $this->assigns_layout["og"] = $og;

            //press
            $_page = 1;
            $pagesize = 10;
            $res = $this->Board->list_press($_page, $pagesize, 'is_hidden = 0');
            $len_res = sizeof($res);

            for ($i=0; $i<$len_res; $i++) {
                //$res[$i]["contents"] = trans_url($res[$i]['contents'], false, "<small>/ 2015.10.05</small>");
                $html = str_get_html($res[$i]["sub"]);
                if($res[$i]["sub"] && count($html->find('a[class=title]')) > 0){
                    foreach($html->find('a[class=title]') as $element){

                        ob_start();
                        echo '<a href="'.$element->href.'">'.$element->innertext.' <small>/ '.$res[$i]['date_created'].'</small></a>';
                        $res[$i]["sub"] = ob_get_contents();
                        ob_end_clean();
                    }
                }
            }
            //회원
            $activity["member"] = $this->Members->cnt("state = 1");
            //멤버쉽
            $activity["membership"] = $this->Recommend->cnt("r.state = 1");
            //스타트업
            $activity["startup"] = $this->Startup->cnt("state = 1");
            //Reservation
            $activity["reservation"] = $this->Space_reserve->cnt("sr.state = 1");
            //경진대회
            $activity["competitions"] = $this->Competitions->cnt();
            //Office Hour
            $activity["office_hours"] = $this->Office_hours->cnt();

            $this->layout = 'blank';
            $this->assigns["activity"] = $activity;
            $this->assigns["res"] = $res;
        }

        public function about_en()
        {
            $og["url"] = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
            $og["title"] = "D.CAMP 소개 – '드림뱅크' 은행권청년창업재단";
            $og["description"] = "D.CAMP – '드림뱅크' 은행권청년창업재단";
            $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].'/img/dcamp.png';
            $this->assigns_layout["og"] = $og;
            
            $this->layout = 'default';
            $this->assigns_layout["c"] = "about";
        }

        public function press($_page = 1)
        {
            $this->layout = "default";
            $pagesize = 10;
            $res = $this->Board->list_press($_page, $pagesize, 'is_hidden = 0');
            $len_res = sizeof($res);
            for ($i=0; $i<$len_res; $i++) {
                $res[$i]["comm"] = $this->Board->get_comment('', $res[$i]["id"]);
            }

            $this->assigns["page"] = $_page;
            $this->assigns["res"] = $res;
        }

        public function policy_service()
        {
            $this->layout = 'default';
        }

        public function policy_privacy()
        {
            $this->layout = 'default';
        }
        
        public function error_404()
        {
            $this->tpl_name = "404";
        }

        public function changbal()
        {
            $this->layout = '';
        }

        public function doffice()
        {
            $this->layout = '';
        }
    }      
?>