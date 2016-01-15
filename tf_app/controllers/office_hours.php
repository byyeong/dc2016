<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * 
 * violet@userstorylab.com
 */

class Office_hours extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "default";
    var $use_models = array("Office_mento", "Office_mento_bios", "Office_mento_article"
            , "Office_mento_form", "Office_hours", "Office_hours_apply"
            , "Office_hours_apply_form", "Office_hours_apply_etc", "Office_mento_bios"
            , "Office_mento_article", "Members", "Startup_member", "Office_label"
            , "Office_alarm", "Office_hours_terms", "Activity", "Startup_service");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "office";
        $this->assigns_layout["gnb_title"] = "Office Hours";
        $this->assigns_layout["con"] = get_contents_category();
        $this->assigns_layout["s"] = $_SESSION["s"];
        $this->assigns["s"] = $_SESSION["s"];
    }
    
    public function index($_page = 1)
    {
        // office hours list
        $res = $this->Office_mento->list_(1, 100, 'hide = 1');
        for ($i=0; $i<sizeof($res); $i++) {
            $open = $this->Office_hours->get_open_by_mento($res[$i]["id"]);
            if ($open) {
                $res[$i]["open"] = $open["id"];
                $me = $this->Office_hours_apply->get_by_user_oh($open["id"], $_SESSION["s"]["id"]);
                if ($me) $res[$i]["me"] = 1;
            }
            if ($res[$i]["label"]) {
                $l = $this->Office_label->get($res[$i]["label"]);
                $res[$i]["labeln"] = $l["label"];
            }
        }

        $this->assigns["res"] = $res;
    }

    public function views($_id = '')
    {
        // office hours detail
        if ($_id) {
            $res = $this->Office_hours->get($_id);
            
            $mento = $this->Office_mento->get($res["mento_id"]);
            $bios = $this->Office_mento_bios->get_by_mento($mento["id"]);
            $article = $this->Office_mento_article->get_by_mento($mento["id"]);
            $other = $this->Office_hours->get_open();

            $this->assigns["mento"] = $mento;
            $this->assigns["bios"] = $bios;
            $this->assigns["article"] = $article;
            $this->assigns["res"] = $res;
            $this->assigns["other"] = $other;
            $this->assigns["done"] = $this->Office_hours_apply->get_by_user_oh($_id, $_SESSION["s"]["id"]);
            $this->assigns["g_start"] = date("YmdHi00",strtotime ("-9 hour", strtotime(str_replace(".", "", str_replace(":", "", str_replace(" ", "", $res["e_start"]))))));
            $this->assigns["g_end"] = date("YmdHi00",strtotime ("-9 hour", strtotime(str_replace(".", "", str_replace(":", "", str_replace(" ", "", $res["e_end"]))))));

            $og["type"] = 'article';
            $og["url"] = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
            $og["title"] = $res["subject"]." on D.CAMP";
            $og["description"] = mb_substr(strip_tags($res["description"]));
            if (strlen(strip_tags($res["description"])) > 150) $og["description"] = mb_substr(strip_tags($res["description"]), 0, 150, 'UTF-8').'...';
            $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].$res["picture"];
            if (!$this->assigns["res"]["picture"]) $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].$res["mpicture"];
            $this->assigns_layout["og"] = $og;
        }
        if (!strpos($_SERVER["HTTP_REFERER"], "dcamp.kr")) {
            $this->assigns_layout["cards"] = bottom_main();
        }
    }

    public function mentor($_id = '')
    {
        // office hours detail
        $mento = $this->Office_mento->get($_id);
        $oh = $this->Office_hours->get_open_by_mento($_id);
        if ($oh) {
            header("Location: /office_hours/views/".$oh["id"]);
        }
        if ($mento) {
            $bios = $this->Office_mento_bios->get_by_mento($_id);
            $article = $this->Office_mento_article->get_by_mento($_id);
            $other = $this->Office_hours->get_open();

            $this->assigns["mento"] = $mento;
            $this->assigns["bios"] = $bios;
            $this->assigns["article"] = $article;

            $this->assigns["other"] = $other;
            $this->assigns["done"] = $this->Office_hours_apply->get_by_user_oh($_id, $_SESSION["s"]["id"]);
        }
    }

    public function apply($_id, $_aid = '')
    {
        // office hours apply
        $res = $this->Office_hours->get($_id);
        if (! $res ) {
            header("Location: /error_404");
        }
        if (! $_SESSION["s"] ) {
            header("Location: /office_hours/views/".$_id);
        }
        $form = $this->Office_hours_apply_form->get_by_oh($_id);
        $other = $this->Office_hours->get_open();

        if ($_aid) {
            $a = $this->Office_hours_apply->get($_aid);
            if ($a["user_id"] == $_SESSION["s"]["id"]) {
                if ($form) {
                    for ($i=0; $i<sizeof($form); $i++) {
                        $con = $this->Office_hours_apply_etc->get_by_form($_aid, $form[$i]["id"]);
                        $form[$i]["contents"] = $con["contents"];
                    }
                } 
                $this->assigns["app"] = $a;
            }
            else {
                header("Location: /error_404");
            }
                
        }
        else {
            $a = $this->Members->get($_SESSION["s"]["id"]);
            unset($a["id"]);
            $this->assigns["app"] = $a;
        }

        $st = $this->Startup_member->get_list_by_user($_SESSION["s"]["id"], "sm.status = 1");

        $this->assigns["st"] = $st;
        $this->assigns["st_f"] = $st[0];
        $this->assigns["res"] = $res;
        $this->assigns["form"] = $form;
        $this->assigns["other"] = $other;
        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }

    public function save_apply()
    {
        $this->tpl_name = "";
        if ($_SESSION["s"]) {
            if ($_FILES["file"]) {
                $_REQUEST["file"] = make_upload("/media/office/hours/", "file");
                $_REQUEST["filename"] = str_replace(" ", "", $_FILES["file"]["name"]);
            }
            $_REQUEST["user_id"] = $_SESSION["s"]["id"];
            $id = $this->Office_hours_apply->add($_REQUEST);
            $form = $this->Office_hours_apply_form->get_by_oh($_REQUEST["oh_id"]);
            if ($form) {
                for ($i=0; $i<sizeof($form); $i++) {
                    if ($_REQUEST["form_".$form[$i]["id"]]) {
                        $arr["apply_id"] = $id;
                        $arr["form_id"] = $form[$i]["id"];
                        $arr["contents"] = $_REQUEST["form_".$form[$i]["id"]];
                        $this->Office_hours_apply_etc->add($arr);
                    }
                }
            }

            if ( ! $_REQUEST["id"]) {
                // activity
                $arr2["com_type"] = 1;
                $arr2["com_id"] = $_SESSION["s"]["id"];
                $arr2["act_type"] = Activity_model::C_TYPE_MEMBER;
                $arr2["act_id"] = $_SESSION["s"]["id"];
                $arr2["target_type"] = Activity_model::O_TYPE_OFFICE_HOURS;
                $arr2["target_id"] = $_REQUEST["oh_id"];
                $arr2["is_made"] = 0;
                $arr2["act_result"] = 0;
                $this->Activity->add($arr2);
            }

            if ($_REQUEST["s_description"] || $_REQUEST["s_description_p"] || $_REQUEST["s_description_s"]) {
                $arr3["startup_id"] = $_REQUEST["st_id"];
                $arr3["id"] = $_REQUEST["ser_id"];
                $arr3["name"] = $_REQUEST["s_subject"];
                $arr3["des_ele"] = $_REQUEST["s_description"];
                $arr3["des_pro"] = $_REQUEST["s_description_p"];
                $arr3["des_sol"] = $_REQUEST["s_description_s"];
                $this->Startup_service->add2($arr3);
            }

            if ($_REQUEST["id"]) $_SESSION["msg"] = "수정되었습니다.";
            else $_SESSION["msg"] = "상담 신청이 성공적으로 완료되었습니다.";
            
            // exit(1);
            header("Location: /office_hours/apply/".$_REQUEST["oh_id"]."/".$id);
        }
        else {
            header("Location: /error_404");
        }       
    }

    public function m_list($_page = 1)
    {
        if ( $this->Office_mento->check_mento($_SESSION["s"]["id"]) ) {
            $pagesize = 10;
            $res = $this->Office_hours->list_o($_page, $pagesize, 'user_id = '.$_SESSION["s"]["id"]);
            $res_cnt = $this->Office_hours->cnt_o('user_id = '.$_SESSION["s"]["id"]);
            for ($i=0; $i<sizeof($res); $i++) {
                $res[$i]["tot"] = $this->Office_hours_apply->cnt($res[$i]["id"]);
                $res[$i]["app"] = $this->Office_hours_apply->cnt($res[$i]["id"], 'status = 1');
            }
            $this->assigns["res"] = $res;
            $this->assigns["res_cnt"] = $res_cnt;
            $this->assigns["page"] = $_page;
            $this->assigns["pagesize"] = $pagesize;
            $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);
        }
        else {
            header("Location: /error_404");
        }
    }

    public function m_info()
    {
        if ( $this->Office_mento->check_mento($_SESSION["s"]["id"]) ) {
            $res = $this->Office_mento->get_by_user_id($_SESSION["s"]["id"]);
            $bios = $this->Office_mento_bios->get_by_mento($res["id"]);
            $article = $this->Office_mento_article->get_by_mento($res["id"]);
            $form = $this->Office_mento_form->get_by_mento($res["id"]);
            $label = $this->Office_label->list_();
            $this->assigns["res"] = $res;
            $this->assigns["bios"] = $bios;
            $this->assigns["article"] = $article;
            $this->assigns["form"] = $form;
            $this->assigns["label"] = $label;
        }
        else {
            header("Location: /error_404");
        }
    }

    public function m_add($_id = '')
    {
        if ( $this->Office_mento->check_mento($_SESSION["s"]["id"]) ) {
            if ($_id) {
                $res = $this->Office_hours->get($_id);
                $form = $this->Office_hours_apply_form->get_by_oh($_id);
                $this->assigns["res"] = $res;
                $this->assigns["form"] = $form;
            }
            else {
                $m = $this->Office_mento->get_by_user_id($_SESSION["s"]["id"]);
                $m_form = $this->Office_mento_form->get_by_mento($m["id"]);
                $this->assigns["m"] = $m;
                $this->assigns["m_form"] = $m_form;
            }
        }
        else {
            header("Location: /error_404");
        }
    }

    public function m_apply_list($_id, $_page = 1)
    {
        if ( $this->Office_mento->check_mento($_SESSION["s"]["id"]) ) {

            $pagesize = 10;
            $oh = $this->Office_hours->get($_id);
            $res = $this->Office_hours_apply->list_($_id, $_page, $pagesize);
            for ($i=0; $i<sizeof($res); $i++) {
                $res[$i]["suc"] = $this->Office_hours_apply->cnt_w_mento('', 'a.status = 1 and a.user_id = '.$res[$i]["user_id"]." and h.mento_id = ".$oh["mento_id"]);
                $res[$i]["tot"] = $this->Office_hours_apply->cnt_w_mento('', 'a.user_id = '.$res[$i]["user_id"]." and h.mento_id = ".$oh["mento_id"]); 
                if ($res[$i]["status"] == 1) {
                    $res[$i]["suc_t"] = $this->Office_hours_terms->get_by_apply($res[$i]["id"]);
                }
            }
            $res_cnt = $this->Office_hours_apply->cnt($_id);
            
            $this->assigns["oh"] = $oh;
            
            $this->assigns["res"] = $res;
            $this->assigns["res_cnt"] = $res_cnt;
            $this->assigns["page"] = $_page;
            $this->assigns["pagesize"] = $pagesize;
            $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);
        }
        else {
            header("Location: /error_404");
        }
    }

    public function m_apply($_id)
    {
        if ( $this->Office_mento->check_mento($_SESSION["s"]["id"]) ) {
            if ($_id) {

                $res = $this->Office_hours_apply->get($_id);
                if ($res["status"] == 1) $res["suc_t"] = $this->Office_hours_terms->get_by_apply($res["id"]);
                $etc = $this->Office_hours_apply_form->get_by_oh($res["oh_id"]);
                for ($i=0; $i<sizeof($etc); $i++) {
                    $con = $this->Office_hours_apply_etc->get_by_form($_id, $etc[$i]["id"]);
                    $etc[$i]["contents"] = $con["contents"];
                }
                $oh = $this->Office_hours->get($res["oh_id"]);

                $pre = $this->Office_hours_apply->get_next($res["oh_id"], $_id, 0);
                $next = $this->Office_hours_apply->get_next($res["oh_id"], $_id, 1);

                $this->assigns["res"] = $res;
                $this->assigns["etc"] = $etc;
                $this->assigns["oh"] = $oh;
                $this->assigns["pre"] = $pre;
                $this->assigns["next"] = $next;

                $this->assigns["tot"] = $this->Office_hours_apply->cnt($oh["id"]);
                $this->assigns["suc"] = $this->Office_hours_apply->cnt($oh["id"], "status = 1");
                $this->assigns["rec"] = $this->Office_hours_apply->cnt($oh["id"], "status = 2");
                $this->assigns["times"] = $this->Office_hours_terms->get_by_oh($oh["id"]);
            }
            else {
                header("Location: /error_404");    
            }
        }
        else {
            header("Location: /error_404");
        }
    }

    public function m_apply_all($_page = 1)
    {
        $m = $this->Office_mento->check_mento($_SESSION["s"]["id"]);
        if ( $m ) {
            $_pagesize = 10;
            $res = $this->Office_hours_apply->list_by_mentor($m["id"], $_page, $_pagesize);
            $res_cnt = $this->Office_hours_apply->list_by_mentor_cnt($m["id"]);
            for ($i=0; $i<sizeof($res); $i++) {

                $res[$i]["i"] = $this->Office_hours_apply->get_by_mento_last($m["id"], $res[$i]["user_id"]);
                $res[$i]["url"] = $this->Members->get($res[$i]["i"]["user_id"]);
                $res[$i]["suc"] = $this->Office_hours_apply->cnt_w_mento('', 'a.status = 1 and a.user_id = '.$res[$i]["user_id"]." and h.mento_id = ".$m["id"]);
                $res[$i]["tot"] = $this->Office_hours_apply->cnt_w_mento('', 'a.user_id = '.$res[$i]["user_id"]." and h.mento_id = ".$m["id"]); 
            }

            $this->assigns["res"] = $res;
            $this->assigns["res_cnt"] = $res_cnt;
            $this->assigns["page"] = $_page;
            $this->assigns["pagesize"] = $_pagesize;
            $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $_pagesize);
        }
    }

    public function get_source()
    {
        if (! $_SESSION["s"] ) {
            exit(1);
        }

        $this->tpl_name = "";
        $ev = $this->Office_hours_apply->get($_REQUEST["apply_id"]);
        
        $filename = trim($ev["file"]); 
        $file = "./media/office/hours/$filename"; 
        $file_size = filesize($file); 
        $filename = urlencode("$filename");


        if( strpos($_SERVER['HTTP_USER_AGENT'], 'MSIE') || strpos($_SERVER['HTTP_USER_AGENT'], 'Trident') ) { 
        
            $_REQUEST['file'] = iconv('utf-8', 'euc-kr', $ev['filename']);

            header("Content-Type: doesn/matter"); 
            Header("Content-Length: ".filesize("$file"));
            Header("Content-Disposition: attachment; filename=".trim($ev['filename'])); 
            header("Content-Transfer-Encoding: binary"); 
            header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
            header('Pragma: public');
            header("Expires: 0"); 
        
        } else { 

            Header("Content-type: file/unknown"); 
            Header("Content-Disposition: attachment; filename=".trim($ev['filename'])); 
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

    public function alarm()
    {
        $res = $this->Office_hours->list_('', '', "SUBSTR(a_start, 1, 10) = '".date("Y.m.d")."'");
        for ($i=0; $i<sizeof($res); $i++) {
            $l = $this->Office_alarm->list_('', '', "mentor_id = ".$res[$i]["mento_id"]);
            for ($j=0; $j<sizeof($l); $j++) {
                
                $m = new TF_mailer($this->settings);
                $m->mailto = $l[$j]["email"];
                $m->subject = "[D.CAMP] 알림 등록된 Office Hours의 신청이 시작되었습니다.";
                $m->tpl_name = "mail-officehours-notify";
                $m->assigns["title"] = "알림 등록된 Office Hours의 신청이 시작되었습니다.";
                $m->assigns["oh"] = $res[$i];
                $m->assigns["m"] = $this->Office_mento->get($res[$i]["mento_id"]);
                $m->assigns["main_service_url"] = $this->globals->my_host;
                $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                $m->send();
                $this->Office_alarm->delete($l[$j]["id"]);

                echo $l[$j]["mentor_id"]."/".$l[$j]["email"]."<br>";
            }
        }
        $this->layout = "";
        $this->tpl_name = "";
    }

    public function notice() 
    {   
        $res = $this->Office_hours->list_('', '', "a_end like '".date("Y.m.d",strtotime("-1 day"))."%'");
        for ($i=0; $i<sizeof($res); $i++) {
            $mento = $this->Office_mento->get_by_member($res[$i]["mento_id"]);

            $m = new TF_mailer($this->settings);
            $m->mailto = $mento["email"];
            $m->subject = "[D.CAMP] ".date_to_kr($res[$i]["e_start"])." 진행 예정인 Office hours의 신청자 접수가 마감되었습니다.";
            $m->tpl_name = "mail-officehours-notify";
            $m->assigns["title"] = date_to_kr($res[$i]["e_start"])." 진행 예정인 Office hours의 신청자 접수가 마감되었습니다. 상담을 진행할 기업 선정을 부탁드립니다.";
            $m->assigns["oh"] = $res[$i];
            $m->assigns["m"] = $mento;
            $m->assigns["main_service_url"] = $this->globals->my_host;
            $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
            $m->send();
        }
        $this->layout = "";
        $this->tpl_name = "";
    }

    public function confirm($_oh, $_ap)
    {
        $oh = $this->Office_hours->get($_oh);
        $ap = $this->Office_hours_apply->get($_ap);
        if ($oh && $ap["status"] == 1) {
            $this->Office_hours_apply->confirm($_oh, $_ap);
        }
        else 
            header("Location: /error_404");
    }

}
?>
