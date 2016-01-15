<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class News extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "default";
    var $use_models = array("Board", "Startup");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "news";
        $this->assigns_layout["gnb_title"] = "News";
        $this->assigns_layout["con"] = get_contents_category();
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns_layout["s"] = $_SESSION["s"];
    }
    
    public function index($_page = 1) 
    {
        $pagesize = 10;
        $res = $this->Board->list_news($_page, $pagesize, 'is_hidden = 0');
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            $res[$i]["comm"] = $this->Board->get_comment('', $res[$i]["id"]);
            if ($res[$i]["p_type"] == 2) {
                $s = $this->Startup->get($res[$i]["p_id"]);
                $res[$i]["picture"] = $s["logo"];
                $res[$i]["name"] = $s["name"];
            }
        }
        $editors = $this->Board->get_editors(3, "is_news = 1");
        $this->assigns["editors"] = $editors;
        $this->assigns["page"] = $_page;
        $this->assigns["res"] = $res;
    }

}
?>
