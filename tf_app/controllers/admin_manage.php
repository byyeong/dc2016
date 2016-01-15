<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * 
 * violet@userstorylab.com
 */

class Admin_manage extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "admin";
    var $use_models = array("Faq", "Members", "Startup_member", "Activity");

    public function before_calling()
    {
        if (($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1){
            header("Location: /login");
        }
        $this->assigns_layout["s"] = $_SESSION["s"];
        $this->assigns["s"] = $_SESSION["s"];
    }
    
    public function index($_page = 1)
    {
        $this->assigns_layout["gnb"] = "faq";
        $this->assigns_layout["gnb_title"] = "FAQ";
        $this->assigns_layout["gnb_left"] = "faq";
        
        $_pagesize = 10;
        $res = $this->Faq->list_(1, $_page, $_pagesize);
        $res_c = $this->Faq->cnt('', 1);
        
        $this->assigns["res"] = $res;
        $this->assigns["res_c"] = $res_c;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_c, $_pagesize);

        if ($_SESSION["msg"]) {
            $this->assigns["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }

    public function edit_faq($_id = '')
    {
        $this->assigns_layout["gnb"] = "faq";
        $this->assigns_layout["gnb_title"] = "FAQ";
        $this->assigns_layout["gnb_left"] = "faq";

        if ($_REQUEST["title"]) {
            $_id = $this->Faq->add($_REQUEST);
            $_SESSION["msg"] = "FAQ가 저장되었습니다.";
            header("Location: /admin_manage");
        }

        if ($_id) {
            $res = $this->Faq->get($_id);
            $this->assigns["res"] = $res;
        }
        $category = $this->Faq->list_category(1, 1000, 1);
        $this->assigns["cat"] = $category;
    }

    public function faq_category($_page = 1)
    {
        $this->assigns_layout["gnb"] = "faq";
        $this->assigns_layout["gnb_title"] = "FAQ";
        $this->assigns_layout["gnb_left"] = "faq_c";

        $_pagesize = 10;
        $res = $this->Faq->list_category($_page, $_pagesize, 1);
        $res_c = $this->Faq->cnt_category(1);
        
        $this->assigns["res"] = $res;
        $this->assigns["res_c"] = $res_c;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_c, $_pagesize);

        if ($_SESSION["msg"]) {
            $this->assigns["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }

    public function edit_faq_category($_id = '')
    {
        $this->assigns_layout["gnb"] = "faq";
        $this->assigns_layout["gnb_title"] = "FAQ";
        $this->assigns_layout["gnb_left"] = "faq_c";

        if ($_REQUEST["category"]) {
            $_id = $this->Faq->add_category($_REQUEST);
            $_SESSION["msg"] = "저장되었습니다.";
            header("Location: /admin_manage/faq_category");
        }

        // default 
        $USER = 1516;
        $u = $this->Members->get($USER);
        $u["com"] = $this->Startup_member->get_by_user($USER);

        if ($_id) {
            $res = $this->Faq->get_category($_id, 1);
            $u = $this->Members->get($res["user_id"]);
            $u["com"] = $this->Startup_member->get_by_user($res["user_id"]);
            
            $this->assigns["res"] = $res;
        }
        $this->assigns["u"] = $u;
    }

    public function qna($_page = 1)
    {
        $this->assigns_layout["gnb"] = "qna";
        $this->assigns_layout["gnb_title"] = "Q&A";
        $this->assigns_layout["gnb_left"] = "qna";

        $_pagesize = 10;
        $where = '';
        if (array_key_exists("order", $_REQUEST)) {
            if ($_REQUEST['order'] == 0)
                $where = "re_suc = 0";
            else if ($_REQUEST['order'] == 1)
                $where = "re_suc = 1";
        }
        else {
            $_REQUEST["order"] = 99;
        }
        $qna = $this->Faq->list_(2, $_page, $_pagesize, $where);
        $qna_c = $this->Faq->cnt($where, 2);

        $this->assigns["qna"] = $qna;
        $this->assigns["qna_c"] = $qna_c;
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $_pagesize;
        $this->assigns["paging"] = get_paging_dot2($_page, $qna_c, $_pagesize);
        $this->assigns["order"] = $_REQUEST["order"];
    }

    public function edit_qna($_id)
    {
        $this->assigns_layout["gnb"] = "qna";
        $this->assigns_layout["gnb_title"] = "Q&A";
        $this->assigns_layout["gnb_left"] = "qna";

        if ($_REQUEST["content"]) {
            $_a["id"] = $_REQUEST["parent"];
            $_a["open"] = $_REQUEST["open"];
            $_a["re_suc"] = 1;
            $this->Faq->add($_a);

            $_REQUEST["id"] = $_REQUEST["p_id"];
            $this->Faq->add($_REQUEST);
            $_SESSION["msg"] = "답변이 저장되었습니다.";

            //maliing

            $q = $this->Faq->list_(2, 1, 1, "f.id = ".$_id);
            $staff = $this->Faq->get_category($q[0]["cat"], 2);
            $ans = $this->Faq->get_reply($_id);

            $m = new TF_mailer($this->settings);
            $m->mailto = $_REQUEST["emailer"];
            $m->subject = "[D.CAMP] 작성하신 Q&A의 답변이 등록되었습니다.";
            $m->tpl_name = "support_qna_re";
            $m->assigns["res"] = $q[0];
            $m->assigns["cat"] = $q[0]["category"];
            $m->assigns["s"] = $staff;
            $m->assigns["ans"] = $ans;
            $m->assigns["main_service_url"] = $this->globals->my_host;
            $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
            $m->send();

            //activity
            $ar["com_type"] = 1;
            $ar["com_id"] = $q[0]["user_id"];
            $ar["act_type"] = 1;
            $ar["act_id"] = $q[0]["user_id"];
            $ar["msg"] = "<a href='/support/views/".$q[0]["id"]."'>Q&A</a>의 답변이 등록되었습니다.";
            $this->Activity->add($ar);
        }
        $category = $this->Faq->list_category(1, 1000, 2);
        $q = $this->Faq->list_(2, 1, 1, "f.id = ".$_id);
        $staff = $this->Faq->get_category($q[0]["cat"], 2);
        $ans = $this->Faq->get_reply($_id);

        $this->assigns["cat"] = $category;
        $this->assigns["q"] = $q[0];
        $this->assigns["s"] = $staff;
        $this->assigns["ans"] = $ans;

        if ($_SESSION["msg"]) {
            $this->assigns["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }

    public function qna_category($_page = 1)
    {
        $this->assigns_layout["gnb"] = "qna";
        $this->assigns_layout["gnb_title"] = "Q&A";
        $this->assigns_layout["gnb_left"] = "qna_c";

        $_pagesize = 10;
        $res = $this->Faq->list_category($_page, $_pagesize, 2, '', 'id ASC');
        $res_c = $this->Faq->cnt_category(2);
        
        $this->assigns["res"] = $res;
        $this->assigns["res_c"] = $res_c;
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $_pagesize;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_c, $_pagesize);

        if ($_SESSION["msg"]) {
            $this->assigns["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }

    public function edit_qna_category($_id = '')
    {
        $this->assigns_layout["gnb"] = "qna";
        $this->assigns_layout["gnb_title"] = "Q&A";
        $this->assigns_layout["gnb_left"] = "qna_c";

        if ($_REQUEST["category"]) {
            $_id = $this->Faq->add_category($_REQUEST);
            $_SESSION["msg"] = "저장되었습니다.";
            header("Location: /admin_manage/qna_category");
        }

        // default 
        $USER = 1516;
        $u = $this->Members->get($USER);
        $u["com"] = $this->Startup_member->get_by_user($USER);

        if ($_id) {
            $res = $this->Faq->get_category($_id, 2);
            $u = $this->Members->get($res["user_id"]);
            $u["com"] = $this->Startup_member->get_by_user($res["user_id"]);
            
            $this->assigns["res"] = $res;
        }
        $this->assigns["u"] = $u;
    }
}
?>
