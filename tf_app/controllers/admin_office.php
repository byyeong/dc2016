<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * 
 * violet@userstorylab.com
 */

class Admin_office extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "admin";
    var $use_models = array("Office_mento", "Office_mento_bios", "Office_mento_article"
            , "Office_mento_form", "Office_hours", "Office_hours_apply"
            , "Office_hours_apply_form", "Office_hours_apply_etc", "Office_mento_bios"
            , "Office_mento_article", "Members", "Startup_member", "Office_label"
            , "Office_hours_terms");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "office";
        $this->assigns_layout["gnb_title"] = "Office Hours";
        
        if (($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1){
            header("Location: /login");
        }
        
        $this->assigns_layout["s"] = $_SESSION["s"];
        $this->assigns["s"] = $_SESSION["s"];
    }
    
    public function index($_page = 1)
    {
        // office hours list
        $this->assigns_layout["gnb_left"] = "oh";

        $pagesize = 10;
        $where = '';
        if (array_key_exists("order", $_REQUEST)) {
            if ($_REQUEST['order'] == 0)
                $where = "a_start <= '".date('Y.m.d H:i')."' && a_end > '".date('Y.m.d H:i')."'";
            else if ($_REQUEST['order'] == 1)
                $where = "a_start > '".date('Y.m.d H:i')."'";
            else if ($_REQUEST['order'] == 2)
                $where = "a_end < '".date('Y.m.d H:i')."'";
        }
        else {
            $_REQUEST["order"] = 99;
        }
        $res = $this->Office_hours->list_($_page, $pagesize, $where);
        for ($i=0; $i<sizeof($res); $i++) {
            $res[$i]["tot"] = $this->Office_hours_apply->cnt($res[$i]["id"]);
            $res[$i]["app"] = $this->Office_hours_apply->cnt($res[$i]["id"], 'status = 1');
        }
        $res_cnt = $this->Office_hours->cnt($where);
        
        $this->assigns["res"] = $res;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);
        $this->assigns["order"] = $_REQUEST["order"];
    }

    public function edit_oh($_id = '')
    {
        // edit office hours
        $this->assigns_layout["gnb_left"] = "oh";
        
        if ($_REQUEST["m"]) {
            $m = $this->Office_mento->get($_REQUEST["m"]);
            $m_form = $this->Office_mento_form->get_by_mento($_REQUEST["m"]);
            $this->assigns["m"] = $m;
            $this->assigns["form"] = $m_form;
        }
        if ($_id) {
            $res = $this->Office_hours->get($_id);
            $form = $this->Office_hours_apply_form->get_by_oh($_id);
            
            $this->assigns["form"] = $form;
            $this->assigns["res"] = $res;
        }
    }

    public function oh_apply($_id, $_page = 1)
    {
        // office hours apply list
        $this->assigns_layout["gnb_left"] = "oh";

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

    public function oh_apply_detail($_id)
    {
        // office hours apply detail
        $this->assigns_layout["gnb_left"] = "oh";

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
    }

    public function mentor($_page = 1)
    {
        // memto list
        $this->assigns_layout["gnb_left"] = "mento";

        $pagesize = 10;
        $res = $this->Office_mento->list_($_page, $pagesize);
        for ($i=0; $i<sizeof($res); $i++) {
            if ($res[$i]["user_id"]) {
                $m = $this->Members->get($res[$i]["user_id"]);
                $res[$i]["ids"] = $m["ids"];    
            }
        }
        $res_cnt = $this->Office_mento->cnt();

        $this->assigns["res"] = $res;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);

    }
    
    public function edit_mentor($_id = "")
    {
        // edit memto info
        $this->assigns_layout["gnb_left"] = "mento";

        if ($_id)
        {
            $res = $this->Office_mento->get($_id);
            $bios = $this->Office_mento_bios->get_by_mento($_id);
            $article = $this->Office_mento_article->get_by_mento($_id);
            if ($res["user_id"]) {
                $mento = $this->Members->get($res["user_id"]);
                $mento["com"] = $this->Startup_member->get_by_user($res["user_id"]);
                $this->assigns["mento"] = $mento;
            }
            $form = $this->Office_mento_form->get_by_mento($_id);
            
            $this->assigns["res"] = $res;
            $this->assigns["bios"] = $bios;
            $this->assigns["article"] = $article;
            $this->assigns["form"] = $form;
            
        }
        $label = $this->Office_label->list_();
        $this->assigns["label"] = $label;
        if ($_REQUEST["open"]) $this->assigns["open"] = $_REQUEST["open"];
    }
}
?>
