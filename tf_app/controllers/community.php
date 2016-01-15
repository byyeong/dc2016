<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Community extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "default";
    var $use_models = array("Startup", "Startup_bussiness", "Startup_tech", "Members",
            "Member_local", "Member_interist", "Member_skill", "Recruit", "Startup_member"
            ,"Member_ext");

    public function before_calling()
    {
        $this->assigns_layout["con"] = get_contents_category();
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns_layout["s"] = $_SESSION["s"];
    }
    
    public function index($_id)
    {
        $res = $this->Members->get_by_ids($_id);
        $st_m = $this->Startup_member->get_by_user($res["id"]);
        if ($st_m) $res = $this->Members->get_by_ids2($_id);
        
        if ($res) {
        $this->assigns["res"] = $res;
        $this->assigns["tw"] = $this->Member_ext->get_by_user_id_type($res["id"], Member_ext_model::TWITTER_TYPE);
        $this->assigns["fb"] = $this->Member_ext->get_by_user_id_type($res["id"], Member_ext_model::FACEBOOK_TYPE);
        $this->assigns["local"] = $this->Member_local->get_by_member($res["id"]);
        $this->assigns["inter"] = $this->Member_interist->get_by_member($res["id"]);
        $this->assigns["skill"] = $this->Member_skill->get_by_member($res["id"]);
//        $this->assigns["bis"] = $this->Startup_bussiness->get_by_member($_id);
//        $this->assigns["tech"] = $this->Startup_tech->get_by_member($_id);
        }
        else {
            header("Location: /");
        }
    }
    
    public function startup($_id)
    {
        $res = $this->Startup->get($_id);
        if ($res) {
            $this->assigns["edi"] = $this->Startup_member->get_first($_id, $_SESSION["s"]["id"]);
            $this->assigns["res"] = $res;
            $this->assigns["bis"] = $this->Startup_bussiness->get_by_member($_id);
            $this->assigns["tech"] = $this->Startup_tech->get_by_member($_id);
            $this->assigns["users"] = $this->Startup_member->get_by_startup($_id, 1);
            $this->assigns["jobs"] = $this->Recruit->get_by_startup($_id);
            $this->assigns["mem"] = $this->Startup_member->check_member($_id, $_SESSION["s"]["id"]);
        }
        else {
            header("Location: /");
        }
    }


}
?>
