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
    var $use_models = array("Notice");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "news";
        $this->assigns_layout["gnb_title"] = "News";
        
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns_layout["s"] = $_SESSION["s"];
    }
    
    public function index($_page = 1) 
    {
        
    }
    
    public function views($_id) 
    {
        
    }

//    public function startup()
//    {
//        
//    }
//    
//    public function index($_page = 1)
//    {
//        $_type = 1;
//        $_pagesize = 10;
//        
//        $this->assigns["res"] = $this->Notice->list_($_page, $_pagesize, $_type,'','visible = 1');
//        $this->assigns["type"] = $_type;
//        
//        if ($_pagesize == sizeof($this->assigns["res"])) {
//            $this->assigns["more"] = TRUE;
//            $this->assigns["n_page"] = $_page+1;
//        }
//    }
//    
//    public function notice($_page = 1)
//    {
//        $_type = 3;
//        $_pagesize = 10;
//        
//        $this->assigns["res"] = $this->Notice->list_($_page, $_pagesize, $_type,'','visible = 1');
//        $this->assigns["type"] = $_type;
//        
//        if ($_pagesize == sizeof($this->assigns["res"])) {
//            $this->assigns["more"] = TRUE;
//            $this->assigns["n_page"] = $_page+1;
//        }
//    }
//    
//    public function views($_type, $_id)
//    {
//        $this->assigns["res"] = $this->Notice->get($_id);
//        if (!$this->assigns["res"]) header("Location: /");
//        $this->assigns["type"] = $_type;
//        
//        $this->assigns["s_res"] = $this->Notice->list_(1, 10, $_type,'','visible = 1');
//        
//        $og["type"] = 'article';
//        $og["url"] = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
//        $og["title"] = $this->assigns["res"]["title"]." on D.CAMP";
//        $og["description"] = strip_tags($this->assigns["res"]["contents"]);
//        if (strlen(strip_tags($this->assigns["res"]["contents"])) > 148) $og["description"] = substr(strip_tags($this->assigns["res"]["contents"]), 0, 148).'...';
////        $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].$this->assigns["res"]["main"];
////        if (!$this->assigns["res"]["main"]) 
////            if ($this->assigns["res"]["type"] == 1) $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].'/img/default-img-news.png';
////            else if ($this->assigns["res"]["type"] == 3) $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].'/img/default-img-notice.png';
//        $this->assigns_layout["og"] = $og;
//    }
}
?>
