<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Notices extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "default";
    var $use_models = array("Notice", "Members");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "notice";
        $this->assigns_layout["gnb_title"] = "Notice";
        $this->assigns_layout["con"] = get_contents_category();
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns_layout["s"] = $_SESSION["s"];
    }

    public function startup()
    {
        
    }
    
    public function index($_page = 1)
    {
        $_pagesize = 10;
        
        $res = $this->Notice->list_($_page, $_pagesize, '','','visible = 1');
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            $res[$i]["wr"] = $this->Members->get($res[$i]["writer_id"]);
        }
        $this->assigns["res"] = $res;
        $this->assigns["page"] = $_page;
    }
    
    public function index_o($_page = 1)
    {
        $_type = 1;
        $_pagesize = 10;
        
        $this->assigns["res"] = $this->Notice->list_($_page, $_pagesize, $_type,'','visible = 1');
        $this->assigns["type"] = $_type;
        
        if ($_pagesize == sizeof($this->assigns["res"])) {
            $this->assigns["more"] = TRUE;
            $this->assigns["n_page"] = $_page+1;
        }
    }

    public function notice($_page = 1)
    {
        $_type = 3;
        $_pagesize = 10;
        
        $this->assigns["res"] = $this->Notice->list_($_page, $_pagesize, $_type,'','visible = 1');
        $this->assigns["type"] = $_type;
        
        if ($_pagesize == sizeof($this->assigns["res"])) {
            $this->assigns["more"] = TRUE;
            $this->assigns["n_page"] = $_page+1;
        }
    }
    
    public function views($_type, $_id)
    {
        $res = $this->Notice->get($_id);
        if ($res) {
            $this->Notice->pageview($_id);
            $res["wr"] = $this->Members->get($res["writer_id"]);
            $this->assigns["res"] = $res;
            if (!$this->assigns["res"]) header("Location: /");
            $this->assigns["type"] = $_type;
            
            $this->assigns["s_res"] = $this->Notice->list_(1, 10, $_type,'','visible = 1');
            
            $og["type"] = 'article';
            $og["url"] = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
            $og["title"] = $this->assigns["res"]["title"]." on D.CAMP";
            $og["description"] = strip_tags($this->assigns["res"]["contents"]);
            if (strlen(strip_tags($this->assigns["res"]["contents"])) > 148) $og["description"] = mb_substr(strip_tags($this->assigns["res"]["contents"]), 0, 148, 'UTF-8').'...';
    //        $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].$this->assigns["res"]["main"];
    //        if (!$this->assigns["res"]["main"]) 
    //            if ($this->assigns["res"]["type"] == 1) $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].'/img/default-img-news.png';
    //            else if ($this->assigns["res"]["type"] == 3) $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].'/img/default-img-notice.png';
            $this->assigns_layout["og"] = $og;
        }
        else header("Location: /error_404");
    }
}
?>
