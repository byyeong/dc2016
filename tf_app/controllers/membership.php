<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Membership extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "default";
    var $use_models = array("Members","Startup","Recommend");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "membership";
        $this->assigns_layout["gnb_title"] = "멤버십";
        $this->assigns_layout["con"] = get_contents_category();
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns_layout["s"] = $_SESSION["s"];
    }
    
    public function index()
    {
        $res = $this->Recommend->get_by_user($_SESSION['s']['id']);
        $this->assigns["res"] = $res;
    }
    
    public function complete()
    {
        if ($_REQUEST["user_id"]) {
            $mem = $this->Members->get_by_name(trim($_REQUEST["recommended_1"]));
            $com = $this->Startup->get_by_name(trim($_REQUEST["company_1"]));
            
            $_REQUEST["rec_mem"] = $mem["id"];
            $_REQUEST["rec_com"] = $com["id"];
            $this->Recommend->add($_REQUEST);
            header("Location: /membership/complete_");
        }
        else
            header("Location: /");
    }

    public function complete_()
    {

    }

}
?>
