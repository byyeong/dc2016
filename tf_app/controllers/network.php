<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Network extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "default";
    var $use_models = array("Startup", "Members", "Follow", "Code", "Member_interist");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "notice";
        $this->assigns_layout["gnb_title"] = "Notice";
        $this->assigns_layout["con"] = get_contents_category();
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns_layout["s"] = $_SESSION["s"];
    }

    public function startup($_page = 1)
    {
        $pagesize = 20;
        $res = $this->Startup->list_($_page, $pagesize, 'state = 1 and bio != "" and logo != ""', 'date_edited DESC');
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            $ch = $this->Follow->check_follow($_SESSION["s"]["id"], $res[$i]["id"], 2);
            if ($ch) $res[$i]["fw"] = 1;
        }
        $this->assigns["page"] = $_page;
        $this->assigns["res"] = $res;
        $this->assigns["c"] = 'startup';
    }
    
    public function people($_page = 1, $_inv = '')
    {
        $pagesize = 15;
        if ($_inv) $res = $this->Member_interist->list_($_page, $pagesize, 'state = 1 and utype = 1 and interist_id = '.$_inv, 'date_edited DESC');
        else $res = $this->Members->list_($_page, $pagesize, 'state = 1 and utype = 1', 'date_edited DESC');
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            $ch = $this->Follow->check_follow($_SESSION["s"]["id"], $res[$i]["id"], 1);
            if ($ch) $res[$i]["fw"] = 1;
        }
        $this->assigns["page"] = $_page;
        $this->assigns["res"] = $res;
        $this->assigns["c"] = 'people';

        $inv = $this->Code->get_by_key('inv');
        $len_inv = sizeof($inv);
        for ($j=0; $j<$len_inv; $j++) {
            $inv[$j]["cnt"] = $this->Member_interist->get_by_inv_cnt("utype = 1 and interist_id = ". $inv[$j]["id"]);
        }
        $this->assigns["inv"] = $inv;
        $this->assigns["ucnt"] = $this->Members->cnt('utype =2 and state = 1');
        if ($_inv) $this->assigns["c_inv"] = $this->Code->get($_inv);
    }

    public function suporter($_page = 1, $_inv = '')
    {
        $pagesize = 15;
        if ($_inv) $res = $this->Member_interist->list_($_page, $pagesize, 'state = 1 and utype = 2 and interist_id = '.$_inv, 'date_edited DESC');
        else $res = $this->Members->list_($_page, $pagesize, 'state = 1 and utype = 2', 'date_edited DESC');
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            $ch = $this->Follow->check_follow($_SESSION["s"]["id"], $res[$i]["id"], 1);
            if ($ch) $res[$i]["fw"] = 1;
        }
        $this->assigns["page"] = $_page;
        $this->assigns["res"] = $res;
        $this->assigns["c"] = 'suporter';

        $inv = $this->Code->get_by_key('inv');
        $len_inv = sizeof($inv);
        for ($j=0; $j<$len_inv; $j++) {
            $inv[$j]["cnt"] = $this->Member_interist->get_by_inv_cnt("utype = 1 and interist_id = ". $inv[$j]["id"]);
        }
        $this->assigns["inv"] = $inv;
        $this->assigns["ucnt"] = $this->Members->cnt('utype =2 and state = 1');
    }
}
?>
