<?
class Ajax_v2 extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "";
    var $use_models = array("Office_mento", "Office_hours", "Office_hours_apply"
            , "Office_mento_bios", "Office_mento_article", "Members", "Startup_member"
            , "Office_hours_apply_etc", "Office_hours_apply_form", "Office_mento_form"
            , "Office_alarm", "Office_label", "Office_hours_terms", "Activity", "Startup_service"
            , "Newsletter", "Recruit", "Recruit_opt", "Event", "Content", "Competitions"
            , "Faq", "Board", "Entrance", "Program");

    public function before_calling()
    {
        $this->assigns["s"] = $_SESSION["s"];
    }
    
    public function save_mento()
    {
        if ( ($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1 ) {
            echo "error";
        }

        $this->tpl_name = "";
        $id = $this->Office_mento->add($_REQUEST);
        if ($_REQUEST["picture"]) {
            $file_ext = explode('.',$_REQUEST["picture"]);
            $file_ext = '.'.$file_ext[sizeof($file_ext)-1];
            $original_file = $this->settings->root_path.substr($_REQUEST["picture"], 1);
            $copy_file = $this->settings->root_path.'media/office/mento/'.$id.$file_ext;
            copy($original_file, $copy_file);
            if ($_REQUEST["picture"] != '/img/default-img-member.png') 
                unlink($original_file); 

            $arr["id"] = $id;
            $arr["picture"] = '/media/office/mento/'.$id.$file_ext;
            $this->Office_mento->add($arr);
        }
        $c = new Query();
        $c->where_eq("mento_id", $id);
        $this->Office_mento_bios->delete_cond($c);
        $this->Office_mento_article->delete_cond($c);
        for ($b=0; $b<$_REQUEST["b_cnt"]+1; $b++) {
            if ($_REQUEST["bios".$b]) {
                $this->Office_mento_bios->add($id, $_REQUEST["bios".$b]);
            }
        }
        for ($a=0; $a<$_REQUEST["a_cnt"]+1; $a++) {
            if ($_REQUEST["an".$a]) {
                $this->Office_mento_article->add($id, $_REQUEST["an".$a], $_REQUEST["al".$a]);
            }
        }
        if ($_REQUEST["label_t"]) {
            $l = $this->Office_label->add($_REQUEST["label_t"]);
            $ar["id"] = $id;
            $ar["label"] = $l;
            $this->Office_mento->add($ar);
        }
        echo $id;
    }

    // public function get_mento()
    // {
    //     $res = $this->Office_mento->list_();
    //     $this->assigns["res"] = $res;
    // }

    public function save_oh()
    {
        $this->tpl_name = "";
        $m = $this->Office_mento->check_mento($_SESSION["s"]["id"]);
        if ( $m["id"] || (($_SESSION["s"]["per"] & $this->settings->permission1) == $this->settings->permission1) ) {

            $_REQUEST["e_start"] = $_REQUEST["e_start"]." ".$_REQUEST["e_start_t"];
            $_REQUEST["e_end"] = $_REQUEST["e_end"]." ".$_REQUEST["e_end_t"];
            $_REQUEST["a_start"] = $_REQUEST["a_start"]." ".$_REQUEST["a_start_t"];
            $_REQUEST["a_end"] = $_REQUEST["a_end"]." ".$_REQUEST["a_end_t"];
            $_REQUEST["r_date"] = $_REQUEST["r_date"]." ".$_REQUEST["r_date_t"];
            if ( ! $_REQUEST["mento_id"]) $_REQUEST["mento_id"] = $m["id"];
            $id = $this->Office_hours->add($_REQUEST);

            if ($_REQUEST["picture"]) {
                $file_ext = explode('.',$_REQUEST["picture"]);
                $file_ext = '.'.$file_ext[sizeof($file_ext)-1];
                $original_file = $this->settings->root_path.substr($_REQUEST["picture"], 1);
                $copy_file = $this->settings->root_path.'media/office/hours/'.$id.$file_ext;
                copy($original_file, $copy_file);
                if ($_REQUEST["picture"] != '/img/default-img-pic.png') 
                    unlink($original_file); 

                $arr["id"] = $id;
                $arr["picture"] = '/media/office/hours/'.$id.$file_ext;
                $this->Office_hours->add($arr);
            }

            if ( $_REQUEST["start"] && $_REQUEST["ing"] && $_REQUEST["hue"] && $_REQUEST["cnt"]) {
                $this->Office_hours_terms->delete_by_oh($id);
                $st = str_replace(":", "", $_REQUEST["start"]);
                $ing = $_REQUEST["ing"];
                $hue = $_REQUEST["hue"];
                $cnt = $_REQUEST["cnt"];
                for ($i=0; $i<$cnt; $i++) {
                    $t = ($ing + $hue) * $i;
                    $s = date("H:i",strtotime ("+".$t." minutes", strtotime('20150101'.$st)));
                    $e = date("H:i",strtotime ("+".$ing." minutes", strtotime('20150211'.$s)));
                    $this->Office_hours_terms->add($id, $s, $e);
                }    
            } 

            echo $id;
     
        }
            
    }

    public function save_oh_form()
    {
        $this->tpl_name = "";
        if ( (($_SESSION["s"]["per"] & $this->settings->permission1) == $this->settings->permission1) 
            || ($this->Office_mento->check_mento($_SESSION["s"]["id"])) ) {
                
            $c= new Query();
            $c->where_eq("oh_id", $_REQUEST["id"]);
            $this->Office_hours_apply_form->delete_cond($c);
            
            for ($i=1; $i<$_REQUEST["q_cnt"]+1; $i++) {
                if ($_REQUEST["q".$i]) {
                    $this->Office_hours_apply_form->add($_REQUEST["id"], $_REQUEST["q".$i]);
                }
            }
        }
    }

    public function save_mento_form()
    {
        $this->tpl_name = "";
        if ( (($_SESSION["s"]["per"] & $this->settings->permission1) == $this->settings->permission1) 
            || ($this->Office_mento->check_mento($_SESSION["s"]["id"])) ) {
             
            $c= new Query();
            $c->where_eq("mento_id", $_REQUEST["id"]);
            $this->Office_mento_form->delete_cond($c);
            
            for ($i=1; $i<$_REQUEST["q_cnt"]+1; $i++) {
                if ($_REQUEST["q".$i]) {
                    $this->Office_mento_form->add($_REQUEST["id"], $_REQUEST["q".$i]);
                }
            }
        }
    }

    public function edit_apply_status()
    {
        $this->tpl_name = "";
        $apply = $this->Office_hours_apply->get($_REQUEST["id"]);
        $oh = $this->Office_hours->get($apply["oh_id"]);
        if ( ($oh["mid"] == $_SESSION["s"]["id"]) || (($_SESSION["s"]["per"] & $this->settings->permission1) == $this->settings->permission1) ) {
            if ( $_REQUEST["status"] != "2" ) $_REQUEST["rec_desc"] = ""; 
            $res = $this->Office_hours_apply->edit_status($_REQUEST);
            $this->Office_hours_terms->reset($oh["id"], $apply["id"]);
            if ($_REQUEST["status"] == "1" && $_REQUEST["times"]) {
                $this->Office_hours_terms->add_apply($_REQUEST["times"], $oh["id"], $apply["id"]);
            }
            if ($res) echo $res;
        }
        else {
            echo "error";
        }
    }

    public function edit_oh_status($_id)
    {
        $this->tpl_name = '';
        $oh = $this->Office_hours->get($_id);
        if ( ($oh["mid"] == $_SESSION["s"]["id"]) || (($_SESSION["s"]["per"] & $this->settings->permission1) == $this->settings->permission1) ) {
            $this->Office_hours_apply->set_status($_id, 0, 2);
            $o = $this->Office_hours->fix_status($_id);
            $res = $this->Office_hours_apply->list_($_id, 1, 1000);
            for ($i=0; $i<sizeof($res); $i++) {
                if ($res[$i]["status"] == 1) {
                    $res[$i]["time"] = $this->Office_hours_terms->get_by_apply($res[$i]["id"]);
                    $u = $this->Members->get($res[$i]["user_id"]);
                    $oh = $this->Office_hours->get($res[$i]["oh_id"]);
                    
                    // mail
                    $m = new TF_mailer($this->settings);
                    $m->mailto = $res[$i]["email"];
                    $m->subject = "[D.CAMP] ".$res[$i]["name"]."님, Office Hours 상담 대상으로 선정되셨습니다.";
                    $m->tpl_name = "mail-officehours-approval";
                    $m->assigns["oh"] = $oh;
                    $m->assigns["res"] = $res[$i];
                    $m->assigns["m"] = $this->Office_mento->get($oh["mento_id"]);
                    $m->assigns["main_service_url"] = $this->globals->my_host;
                    $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                    $m->send();

                }
                else if ($res[$i]["status"] == 2) {
                    $u = $this->Members->get($res[$i]["user_id"]);
                    $oh = $this->Office_hours->get($res[$i]["oh_id"]);

                    $m = new TF_mailer($this->settings);
                    $m->mailto = $res[$i]["email"];
                    $m->subject = "Office hours ".$oh["subject"]." 선정 결과를 안내드립니다.";
                    $m->tpl_name = "mail-officehours-reject";
                    $m->assigns["u"] = $u;
                    $m->assigns["oh"] = $oh;
                    $m->assigns["res"] = $res[$i];
                    $m->assigns["main_service_url"] = $this->globals->my_host;
                    $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                    $m->send();
                }

                if ($res[$i]["status"] > 0) {

                    //activity
                    $arr["act_type"] = Activity_model::C_TYPE_MEMBER;
                    $arr["act_id"] = $res[$i]["user_id"];
                    $arr["target_type"] = Activity_model::O_TYPE_OFFICE_HOURS;
                    $arr["target_id"] = $oh["id"];
                    $arr["act_result"] = $res[$i]["status"];
                    $this->Activity->edit($arr);
                }
            }
            if ($o) echo $o;
        }
    }

    public function search_member()
    {
        $res = $this->Members->search_by_entrancee($_REQUEST["q"]);
        for ($i=0; $i<sizeof($res); $i++) {
            $res[$i]["com"] = $this->Startup_member->get_by_user($res[$i]["id"]);
        }
        $this->assigns["res"] = $res;
        if ($_REQUEST["rep"]) $this->assigns["rep"] = $_REQUEST["rep"];
    }

    public function save_apply()
    {
        $this->tpl_name = "";
        if ($_SESSION["s"]) {
            if ($_FILES["file"]) {
                $_REQUEST["file"] = make_upload("/media/office/hours/", "file");
            }
            $_REQUEST["user_id"] = $_SESSION["s"]["id"];
            $id = $this->Office_hours_apply->add($_REQUEST);
            $form = $this->Office_hours_apply_form->get_by_oh($_REQUEST["oh_id"]);
            if ($form) {
                for ($i=0; $i<sizeof($form); $i++) {
                    $arr["apply_id"] = $id;
                    $arr["form_id"] = $form[$i]["id"];
                    $arr["contents"] = $_REQUEST["form_".$form[$i]["id"]];
                    $this->Office_hours_apply_etc->add($arr);
                }
            }
            if ( ! $_REQUEST["id"]) {
                // activity
                $arr["com_type"] = 1;
                $arr["com_id"] = $_SESSION["s"]["id"];
                $arr["act_type"] = Activity_model::C_TYPE_MEMBER;
                $arr["act_id"] = $_SESSION["s"]["id"];
                $arr["target_type"] = Activity_model::O_TYPE_OFFICE_HOURS;
                $arr["target_id"] = $_REQUEST["oh_id"];
                $arr["is_made"] = 0;
                $arr["act_result"] = 0;
                $act->add($arr);
            }
                
        }
            
    }

    public function delete_apply($_id)
    {
        $this->tpl_name = "";
        if ( $_SESSION["s"]["id"] ) {
            $a = $this->Office_hours_apply->get($_id);
            if ($a["user_id"] == $_SESSION["s"]["id"]) {
                $this->Office_hours_apply->delete($_id);
            }
            else {
                echo "error_perm";
            }
        }
        else {
            echo "error_session";
        }
    }

    public function get_mento()
    {
        if ( ($_SESSION["s"]["per"] & $this->settings->permission1) == $this->settings->permission1 ) {
            $res = $this->Office_mento->list_(1, 1000);
            $this->assigns["res"] = $res;
        }
    }

    public function del_mentor($_id)
    {
        if ( ($_SESSION["s"]["per"] & $this->settings->permission1) == $this->settings->permission1 ) {
            $res = $this->Office_mento->delete($_id);
            $this->tpl_name = "";
        }
    }

    public function add_mento_alarm($_id)
    {
        $this->tpl_name = "";
        if ($_SESSION["s"]["id"]) {
            $this->Office_alarm->add($_id, $_SESSION["s"]["id"], $_SESSION["s"]["email"]);
        }
    }

    public function del_oh($_id)
    {
        if ( ($_SESSION["s"]["per"] & $this->settings->permission1) == $this->settings->permission1 ) {
            $res = $this->Office_hours->delete($_id);
            $this->tpl_name = "";
        }
    }

    public function get_record($_mid, $_uid)
    {
        $this->assigns["res"] = $this->Office_hours_apply->get_hours_by_mento_user($_mid, $_uid);
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

    public function newsletter($_id, $_type = '', $_is_temp = 0)
    {
        $res = $this->Newsletter->get($_id);
        $conts = $this->Newsletter->get_by_newsl($_id);
        for ($i=0; $i<sizeof($conts); $i++) {
            if ($conts[$i]["type"] == 1) {
                $t = $this->Event->get($conts[$i]["cont_id"]);
                if ($t) {
                    $conts[$i]["title"] = $t["title"];
                    $conts[$i]["pic"] = $t["picture"];
                    $conts[$i]["category"] = "Event";
                    $conts[$i]["url"] = "http://dcamp.kr/event/apply/".$t["id"];
                }
            }
            else if ($conts[$i]["type"] == 3) {
                $t = $this->Competitions->get($conts[$i]["cont_id"]);
                if ($t) {
                    $conts[$i]["title"] = $t["subject"];
                    $conts[$i]["pic"] = $t["img"];
                    $conts[$i]["category"] = "Challenge";
                    $conts[$i]["url"] = "http://dcamp.kr/challenge/views/".$t["id"];
                }
            }
        }

        $oh = $this->Office_hours->list_(1, 100, "o.id IN (".$res["o_ids"].")");
        for ($l=0; $l<sizeof($oh); $l++) {
            $oh[$l]["title"] = $oh[$l]["subject"];
            $oh[$l]["pic"] = $oh[$l]["picture"];
            $oh[$l]["url"] = "http://dcamp.kr/office_hours/views/".$oh[$l]["id"];
        }

        $ben = $this->Program->get_list(1, 100, "c.id IN (".$res["b_ids"].")");
        for ($b=0; $b<sizeof($ben); $b++) {
            $ben[$b]["title"] = $ben[$b]["title"];
            $ben[$b]["pic"] = $ben[$b]["img"];
            $ben[$b]["url"] = "http://dcamp.kr/benefits/views/".$ben[$b]["id"];
        }

        $con = $this->Content->list_(1, 100, "c.id IN (".$res["c_ids"].")");
        for ($k=0; $k<sizeof($con); $k++) {
            $con[$k]["title"] = $con[$k]["subject"];
            $con[$k]["pic"] = $con[$k]["picture"];
            if (!$con[$k]["pic"]) $con[$k]["pic"] = $con[$k]["img"];
            $con[$k]["url"] = "http://dcamp.kr/contents/views/".$con[$k]["id"];
        }

        $recr = $this->Recruit->list_s_(1, 100, "r.id IN (".$res["r_ids"].")");
        for ($j=0; $j<sizeof($recr); $j++) {
            $recr[$j]["inv"] = $this->Recruit_opt->get_detail($recr[$j]["id"], 7);
            $recr[$j]["term"] = $this->Recruit_opt->get_detail($recr[$j]["id"], 4);
            $recr[$j]["job"] = $this->Recruit_opt->get_detail($recr[$j]["id"], 6);
        }

        $this->assigns["res"] = $res;
        $this->assigns["conts"] = $conts;
        $this->assigns["oh"] = $oh;
        $this->assigns["ben"] = $ben;
        $this->assigns["con"] = $con;
        $this->assigns["recr"] = $recr;
        if ($_type) $this->tpl_name = "newsletter_html";
        if ($_is_temp) {
            $this->Newsletter->delete($_id);
            $this->Newsletter->del_cont($_id);
        }
    }

    public function get_cont($_id)
    {
        $this->assigns["id"] = $_id;
    }

    public function temp_newsletter()
    {
        $this->tpl_name = "";
        unset($_REQUEST["id"]);
        $_id = $this->Newsletter->add($_REQUEST);
        if ($_REQUEST["cont_cnt"]) {
            $this->Newsletter->del_cont($_id);
            for ($i=1; $i<$_REQUEST["cont_cnt"]+1; $i++) {
                if ($_REQUEST["cont_id_".$i]) {
                    $this->Newsletter->add_cont($_id, $_REQUEST["type_".$i], $_REQUEST["cont_id_".$i]);
                }
            }
        }
        $res["id"] = $_id;
        echo json_encode($res);
    }

    public function send_newsletter($_id, $_is_temp = 0)
    {
        $this->tpl_name = "";
        if ($_REQUEST["emails"]) {

            $res = $this->Newsletter->get($_id);
            $conts = $this->Newsletter->get_by_newsl($_id);
            for ($i=0; $i<sizeof($conts); $i++) {
                if ($conts[$i]["type"] == 1) {
                    $t = $this->Event->get($conts[$i]["cont_id"]);
                    if ($t) {
                        $conts[$i]["title"] = $t["title"];
                        $conts[$i]["pic"] = $t["picture"];
                        $conts[$i]["category"] = "Event";
                        $conts[$i]["url"] = "http://dcamp.kr/event/apply/".$t["id"];
                    }
                }
                else if ($conts[$i]["type"] == 3) {
                    $t = $this->Competitions->get($conts[$i]["cont_id"]);
                    if ($t) {
                        $conts[$i]["title"] = $t["subject"];
                        $conts[$i]["pic"] = $t["img"];
                        $conts[$i]["category"] = "Challenge";
                        $conts[$i]["url"] = "http://dcamp.kr/challenge/views/".$t["id"];
                    }
                }
            }

            $oh = $this->Office_hours->list_(1, 100, "o.id IN (".$res["o_ids"].")");
            for ($l=0; $l<sizeof($oh); $l++) {
                $oh[$l]["title"] = $oh[$l]["subject"];
                $oh[$l]["pic"] = $oh[$l]["picture"];
                $oh[$l]["url"] = "http://dcamp.kr/office_hours/views/".$oh[$l]["id"];
            }

            $con = $this->Content->list_(1, 100, "c.id IN (".$res["c_ids"].")");
            for ($k=0; $k<sizeof($con); $k++) {
                $con[$k]["title"] = $con[$k]["subject"];
                $con[$k]["pic"] = $con[$k]["img"];
                $con[$k]["category"] = "Contents";
                $con[$k]["url"] = "http://dcamp.kr/contents/views/".$con[$k]["id"];
            }

            $recr = $this->Recruit->list_s_(1, 100, "r.id IN (".$res["r_ids"].")");
            for ($j=0; $j<sizeof($recr); $j++) {
                $recr[$j]["inv"] = $this->Recruit_opt->get_detail($recr[$j]["id"], 7);
                $recr[$j]["term"] = $this->Recruit_opt->get_detail($recr[$j]["id"], 4);
                $recr[$j]["job"] = $this->Recruit_opt->get_detail($recr[$j]["id"], 6);
            }

            $ben = $this->Program->get_list(1, 100, "c.id IN (".$res["b_ids"].")");
            for ($b=0; $b<sizeof($ben); $b++) {
                $ben[$b]["title"] = $ben[$b]["title"];
                $ben[$b]["pic"] = $ben[$b]["img"];
                $ben[$b]["url"] = "http://dcamp.kr/benefits/views/".$ben[$b]["id"];
            }

            $this->assigns["res"] = $res;
            $this->assigns["conts"] = $conts;
            $this->assigns["oh"] = $oh;
            $this->assigns["con"] = $con;
            $this->assigns["recr"] = $recr;
            $this->assigns["ben"] = $ben;

            if ($_is_temp) {
                $this->Newsletter->delete($_id);
                $this->Newsletter->del_cont($_id);
            }

            $email = explode(",", $_REQUEST["emails"]);
            $len_e = sizeof($email);
            for ($i=0; $i<$len_e; $i++) {

                $email[$i] = rtrim(ltrim($email[$i]));
                if ($email[$i]) {
                    $m = new TF_mailer($this->settings);
                    $m->mailto = $email[$i];
                    $m->subject = "[D.CAMP] ".$_REQUEST["subject"];
                    $m->tpl_name = "newsletter";
                    $m->assigns["res"] = $res;
                    $m->assigns["conts"] = $conts;
                    $m->assigns["oh"] = $oh;
                    $m->assigns["con"] = $con;
                    $m->assigns["recr"] = $recr;
                    $m->assigns["ben"] = $ben;
                    $m->assigns["main_service_url"] = $this->globals->my_host;
                    $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                    $m->send();
                }
            }

            $res["id"] = $_id;
            echo json_encode($res);
        }
    }

    public function get_oh_apply_list($_id, $_admin = 0)
    {
        $_page = 1;
        $_pagesize = 5;
        $oh = $this->Office_hours->get($_id);
        if ( ($oh["mid"] == $_SESSION["s"]["id"]) || (($_SESSION["s"]["per"] & $this->settings->permission1) == $this->settings->permission1) ) {
            $all = $this->Office_hours_apply->list_u($_id, 1, $_pagesize);
            $aft = $this->Office_hours_apply->list_u($_id, 1, $_pagesize, 'status > 0');
            $yet = $this->Office_hours_apply->list_u($_id, 1, $_pagesize, 'status = 0');

            $all_c = $this->Office_hours_apply->cnt($_id);
            $aft_c = $this->Office_hours_apply->cnt($_id, 'status > 0');
            $yet_c = $this->Office_hours_apply->cnt($_id, 'status = 0');

            $this->assigns["all"] = $all;
            $this->assigns["aft"] = $aft;
            $this->assigns["yet"] = $yet;

            $this->assigns["all_c"] = $all_c;
            $this->assigns["aft_c"] = $aft_c;
            $this->assigns["yet_c"] = $yet_c;

            $this->assigns["paging1"] = get_paging_dot2($_page, $all_c, $_pagesize);
            $this->assigns["paging2"] = get_paging_dot2($_page, $aft_c, $_pagesize);
            $this->assigns["paging3"] = get_paging_dot2($_page, $yet_c, $_pagesize);
            $this->assigns["page"] = $_page;
            $this->assigns["id"] = $_id;
            $this->assigns["admin"] = $_admin;
        }
    }

    public function get_oh_apply_list_de($_type, $_id, $_page, $_admin = 0)
    {
        $_pagesize = 5;
        $oh = $this->Office_hours->get($_id);
        if ( ($oh["mid"] == $_SESSION["s"]["id"]) || (($_SESSION["s"]["per"] & $this->settings->permission1) == $this->settings->permission1) ) {
            
            if ($_type == 1) {
                $res = $this->Office_hours_apply->list_u($_id, $_page, $_pagesize);
                $res_c = $this->Office_hours_apply->cnt($_id);
            }
                
            else if ($_type == 2) {
                $res = $this->Office_hours_apply->list_u($_id, $_page, $_pagesize, 'status > 0');
                $res_c = $this->Office_hours_apply->cnt($_id, 'status > 0');
            }
                
            else if ($_type == 3) {
                $res = $this->Office_hours_apply->list_u($_id, $_page, $_pagesize, 'status = 0');
                $res_c = $this->Office_hours_apply->cnt($_id, 'status = 0');
            }

            $this->assigns["res"] = $res;
            $this->assigns["res_c"] = $res_c;

            $this->assigns["paging"] = get_paging_dot2($_page, $res_c, $_pagesize);
            $this->assigns["page"] = $_page;
            $this->assigns["id"] = $_id;
            $this->assigns["type"] = $_type;
            $this->assigns["admin"] = $_admin;
        }
    }

    public function delete_faq($_id) {
        $this->tpl_name = "";
        if ( ($_SESSION["s"]["per"] & $this->settings->permission1) == $this->settings->permission1 ) {
            $f = $this->Faq->get($_id);
            if ($f) 
                $this->Faq->delete($_id);    
            else
                echo "error";
        }
        else {
            echo "error";
        }
    }

    public function get_faq($_id = '') {
        $res = $this->Faq->list_(1, 1, 100, '', 'ord ASC');
        
        $this->assigns["res"] = $res;
    }

    public function reorder_faq($_id, $_ord, $_type) {
        $this->tpl_name = "";
        $this->Faq->reorder($_id, $_ord, $_type);
    }

    public function del_qna_category($_id, $_type) {
        $this->tpl_name = "";
        if ( ($_SESSION["s"]["per"] & $this->settings->permission1) == $this->settings->permission1 ) {
            $f = $this->Faq->get_category($_id, $_type);
            if ($f) 
                $this->Faq->del_category($_id);    
            else
                echo "error1";
        }
        else {
            echo "error2";
        }
    }

    public function change_cat_qna($_id, $_cat) {
        $this->tpl_name = "";

        if ( (($_SESSION["s"]["per"] & $this->settings->permission1) == $this->settings->permission1) ||
            $this->Faq->check_cat_u($_SESSION["s"]["id"]) ) {

            $_arr["id"] = $_id;
            $_arr["cat"] = $_cat;
            $id = $this->Faq->add($_arr);

            if ($id) {
                $cat = $this->Faq->get_category($_cat, 2);
                if ($cat) {
                    $m = new TF_mailer($this->settings);
                    $m->mailto = $cat["email"];
                    $m->subject = "[D.CAMP] 새로운 Q&A가 등록되었습니다.";
                    $m->tpl_name = "support_qna";
                    $m->assigns["res"] = $this->Faq->get($_id);
                    $m->assigns["id"] = $_id;
                    $m->assigns["cat"] = $cat["category"];
                    $m->assigns["main_service_url"] = $this->globals->my_host;
                    $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                    $m->send();

                    $_SESSION["msg"] = "담당자가 변경되었습니다.";
                }
                else
                    echo "error1";
                    
            } 
            else 
                echo "error2";    
        }
        else
            echo "error3";
    }

    public function del_newsletter($_id) {
        $this->tpl_name = "";
        if ( ($_SESSION["s"]["per"] & $this->settings->permission1) == $this->settings->permission1 ) {
            $f = $this->Newsletter->get($_id);
            if ($f) 
                $this->Newsletter->delete($_id);    
            else
                echo "error1";
        }
        else {
            echo "error2";
        }
    }

    public function check_tv($_cur = '') {
        $this->tpl_name = "";
        $result = "";

        if ($_cur) {
            $read = file("../tf_app/ext/tf_data.php");
            $hot = $read[0];

            if ($_cur < $hot) {
                $res = $this->Board->get_hot($_cur);        
            }
        }
        else {
            $res = $this->Board->get_hot('', 't.date_created like "'.date("Y-m-d H:i").'%"');
            // $res = $this->Board->get_hot('', 't.date_created like "'.date("Y-m-d H").'%"');
            // $res = $this->Board->get_hot('', 't.date_created like "'.date("Y-m-d").'%"');
            if (!$res) {
                $one = $this->Board->get_hot('', '');
                $result["id"] = $one["id"];
            }
        }
        
        if ($res) {
            $result["id"] = $res["id"];
            $result["name"] = $res["name"];
            $result["pic"] = $res["picture"];
            $result["date"] = trans_date_ago($res["date_created"]);
            $result["content"] = $res["contents"];
        }

        echo json_encode($result);
    }

    public function update_tv() {
        $users = $this->Entrance->list_('', '', '', 'date_out IS NULL and  date_in LIKE "'.date("Y-m-d").'%" GROUP BY m.id ');
        for($i=0; $i<sizeof($users); $i++) {
            $users[$i]["com"] = $this->Startup_member->get_by_user($users[$i]["id"]);
            $users[$i]["msg"] = "";
            $msg = $this->Board->list_(3, '', 1, 1, 'b.date_created like "'.date("Y-m-d").'%" and b.user_id = '.$users[$i]["user_id"]);
            $users[$i]["msg"] = $msg[0]["contents"];
        }
        
        $this->assigns["users"] = $users;
    }
}
?>