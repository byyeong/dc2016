<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Competitions_form_model extends Model
{
    var $tablename = "competitions_form";

    function add($_arr)
    {
        $c = new Query();
        $c->value("competition_id", $_arr["competition_id"]);
        $c->value("type", $_arr["type"]);
        $c->value("title", $_arr["title"]);
        $c->value("sub", $_arr["sub"]);
        $c->value("opt", $_arr["opt"]);
        $c->value("required", $_arr["required"]);
        if(isset($_arr["order_no"])) $c->value("order_no", $_arr["order_no"]);
        if ($_arr["id"]) {
            $c->where_eq("id", $_arr["id"]);
            $this->update($c);
            $_id = $_arr["id"];
        }
        else {
            $this->insert($c);
            $_id = $this->last_id();
        }
        return $_id;
    }
    
    function get_by_comp($_id)
    {
       // $this->debug();
        $c = new Query();
        $c->where_eq("competition_id", $_id);
        $c->order="order_no ASC, id ASC";
        $res = $this->fetch("*", $c);
        
        return $res;
    }

    function del_form($_cid)
    {
        $c = new Query();
        $c->where_eq("competition_id", $_cid);
        $this->delete_cond($c);
    }

// competition_form_res

    function res_add($_arr)
    {
        // $this->debug();
        $c = new Query();
        $c->from="competitions_form_res";
        $c->value("apply_id", $_arr["apply_id"]);
        $c->value("c_form_id", $_arr["c_form_id"]);
        $c->value("res", $_arr["res"]);
        $this->insert($c);
    }

    function get_by_form_user($_fid, $_aid)
    {
        // $this->debug();
        $c = new Query();
        $c->from="competitions_form_res";
        $c->where_eq("c_form_id", $_fid);
        $c->where_eq("apply_id", $_aid);
        $res = $this->fetch_one("*", $c);

        return $res;
    }

    function get_by_form_res_user($_fid, $_aid)
    {
        // $this->debug();
        $c = new Query();
        $c->from="competitions_form_res cfr, competitions_form cf";
        $c->where("cf.id = cfr.c_form_id");
        $c->where_eq("c_form_id", $_fid);
        $c->where_eq("apply_id", $_aid);
        $res = $this->fetch_one("*", $c);

        return $res;
    }

    function del_form_res($_aid)
    {
        $c = new Query();
        $c->from="competitions_form_res";
        $c->where_eq("apply_id", $_aid);
        $this->delete_cond($c);
    }
}

$current_controller->Competitions_form = new Competitions_form_model($settings);
?>
