<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * 
 * violet@userstorylab.com
 */

class Admin_newsletter extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "admin";
    var $use_models = array("Newsletter");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "newsletter";
        $this->assigns_layout["gnb_title"] = "뉴스레터";
        if (($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1){
            header("Location: /login");
        }
        $this->assigns_layout["s"] = $_SESSION["s"];
        $this->assigns["s"] = $_SESSION["s"];
    }
    
    public function index($_page = 1)
    {
        $this->assigns_layout["gnb_left"] = "newsletter";

        $pagesize = 10;
        $res = $this->Newsletter->list_($_page, $pagesize);
        $res_cnt = $this->Newsletter->cnt();
        
        $this->assigns["res"] = $res;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);
    }
    
    public function add($_id = '')
    {
        $this->assigns_layout["gnb_left"] = "newsletter";
        
        if ($_REQUEST["subject"]) {
            $_id = $this->Newsletter->add($_REQUEST);
            if ($_REQUEST["cont_cnt"]) {
                $this->Newsletter->del_cont($_id);
                for ($i=1; $i<$_REQUEST["cont_cnt"]+1; $i++) {
                    if ($_REQUEST["cont_id_".$i]) {
                        $this->Newsletter->add_cont($_id, $_REQUEST["type_".$i], $_REQUEST["cont_id_".$i]);
                    }
                }
            }
            header("Location: /admin_newsletter/add/".$_id);
        }

        if ($_id)
        {
            $res = $this->Newsletter->get($_id);
            $cont = $this->Newsletter->get_by_newsl($_id);

            $this->assigns["res"] = $res;
            $this->assigns["cont"] = $cont;
        }
    }

}
?>
