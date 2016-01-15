<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Support extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "default";
    var $use_models = array("Faq", "Activity");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "support";
        $this->assigns_layout["gnb_title"] = "MEMBER SUPPORT";
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns_layout["s"] = $_SESSION["s"];
    }
    
    public function index($_page = 1) 
    {
        $_pagesize = 10;
        $faq = $this->Faq->list_(1, $_page, $_pagesize, 'open = 1', 'ord ASC');
        $faq_c = $this->Faq->cnt('open = 1', 1);

        $this->assigns["faq"] = $faq;
        $this->assigns["faq_c"] = $faq_c;
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $_pagesize;
        $this->assigns["paging"] = get_paging_dot2($_page, $faq_c, $_pagesize);

        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }

    public function qna($_page = 1) 
    {
        $_pagesize = 10;
        $category = $this->Faq->list_category(1, 1000, 2);
        $w = "";

        if ($_REQUEST["q"] && $_REQUEST["category"]) {
            $w = $w."cat = ".$_REQUEST["category"]." and (title like '%".$_REQUEST["q"]."%' or content like '%".$_REQUEST["q"]."%' or name like '%".$_REQUEST["q"]."%')"; 
            $this->assigns["q"] = $_REQUEST["q"];
            $this->assigns["c"] = $_REQUEST["category"];
        }
        else if ($_REQUEST["category"]) {
            $w = $w."cat = ".$_REQUEST["category"]; 
            $this->assigns["c"] = $_REQUEST["category"];
        }

        if ($_REQUEST["me"]) {
            if ($w != "") $w = $w." and ";
            $w = $w."f.user_id = ".$_SESSION["s"]["id"];
        }

        $qna = $this->Faq->list_(2, $_page, $_pagesize, $w);
        $qna_c = $this->Faq->cnt($w, 2);

        $this->assigns["category"] = $category;
        $this->assigns["qna"] = $qna;
        $this->assigns["qna_c"] = $qna_c;
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $_pagesize;
        $this->assigns["paging"] = get_paging_dot2($_page, $qna_c, $_pagesize);
        $this->assigns["me"] = $_REQUEST["me"];

        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }

    public function add($_id = '')
    {
        $category = $this->Faq->list_category(1, 1000, 2);

        if ($_REQUEST["name"]) {
            $_id = $this->Faq->add($_REQUEST);
            
            //mailling
            $cat = $this->Faq->get_category($_REQUEST["cat"], 2);
            $m = new TF_mailer($this->settings);
            $m->mailto = $cat["email"];
            $m->subject = "[D.CAMP] 새로운 Q&A가 등록되었습니다.";
            $m->tpl_name = "support_qna";
            $m->assigns["res"] = $_REQUEST;
            $m->assigns["id"] = $_id;
            $m->assigns["cat"] = $cat["category"];
            $m->assigns["main_service_url"] = $this->globals->my_host;
            $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
            $m->send();

            //activity
            $ar["com_type"] = 1;
            $ar["com_id"] = $_REQUEST["user_id"];
            $ar["act_type"] = 1;
            $ar["act_id"] = $_REQUEST["user_id"];
            $ar["msg"] = "<a href='/support/views/".$_id."'>Q&A</a>를 등록되었습니다.";
            $this->Activity->add($ar);
            
            $_SESSION["msg"] = "Q&A가 작성되었습니다.";
            header("Location: /support/qna");
        }
        
        if ($_id) {
            $res = $this->Faq->get($_id);
            if ($_SESSION["s"]["id"] != $res["user_id"]) {
                $_SESSION["msg"] = "잘못된 접근입니다.";
                header("Location: /support/qna");
            }
            $this->assigns["res"] = $res;
        }
        
        $this->assigns["category"] = $category;
    }

    public function views($_id) 
    {
        $res = $this->Faq->get($_id);
        if ( ! $res) {
            header("Location: /support");
        }
        if ($res["type"] == 1) {
            $res["cat"] = $this->Faq->get_category($res["cat"], 1);
            $this->assigns["res"] = $res;
        }
        elseif($res["type"] == 2) {
            $check = $this->Faq->check_cat_u($_SESSION["s"]["id"], $res["cat"]);
            if ( $res["open"] == 0 && $res["user_id"] != $_SESSION["s"]["id"] && ! $check) {
                $_SESSION["msg"] = "접근 권한이 없습니다.";
                header("Location: /support/qna");
            }

            if ($_REQUEST["content"] && $check) {
                
                // parent
                $_a["id"] = $_REQUEST["parent"];
                $_a["re_suc"] = 1;
                $this->Faq->add($_a);
                // reply
                $_aa["content"] = $_REQUEST["content"];
                $_aa["parent"] = $_REQUEST["parent"];
                $_aa["id"] = $_REQUEST["p_id"];
                $an = $this->Faq->add($_aa);
                $_SESSION["msg"] = "답변이 저장되었습니다.";

                //maliing
                $q = $this->Faq->list_(2, 1, 1, "f.id = ".$_REQUEST["parent"]);
                $staff = $this->Faq->get_category($q[0]["cat"], 2);

                $m = new TF_mailer($this->settings);
                $m->mailto = $_REQUEST["emailer"];
                $m->subject = "[D.CAMP] 작성하신 Q&A의 답변이 등록되었습니다.";
                $m->tpl_name = "support_qna_re";
                $m->assigns["res"] = $q[0];
                $m->assigns["cat"] = $q[0]["category"];
                $m->assigns["s"] = $staff;
                $m->assigns["ans"]["content"] = $_REQUEST["content"];
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

                header("Location: /support/qna");
            }

            $res["cat"] = $this->Faq->get_category($res["cat"], 2);
            $res["act"] = $this->Faq->get_reply($_id);
            $category = $this->Faq->list_category(1, 1000, 2);

            $this->assigns["res"] = $res;
            $this->assigns["category"] = $category;
        }
            
    }

}
?>
