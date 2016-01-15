<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Program_form_model extends Model
{
    var $tablename = "program_form";

    function add($_arr)
    {
        $c = new Query();
        $c->value("program_id", $_arr["program_id"]);
        $c->value("type", $_arr["type"]);
        $c->value("title", $_arr["title"]);
        $c->value("sub", $_arr["sub"]);
        $c->value("opt", $_arr["opt"]);
        $c->value("required", $_arr["required"]);
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
        $c->where_eq("program_id", $_id);
        $c->order="id ASC";
        $res = $this->fetch("*", $c);
        
        return $res;
    }

    function del_form($_cid)
    {
        $c = new Query();
        $c->where_eq("program_id", $_cid);
        $this->delete_cond($c);
    }

// program_form_res

    function res_add($_arr)
    {
        // $this->debug();
        $c = new Query();
        $c->from="program_form_res";
        $c->value("apply_id", $_arr["apply_id"]);
        $c->value("c_form_id", $_arr["c_form_id"]);
        $c->value("res", $_arr["res"]);
        $this->insert($c);
    }

    function get_by_form_user($_fid, $_aid)
    {
        // $this->debug();
        $c = new Query();
        $c->from="program_form_res";
        $c->where_eq("c_form_id", $_fid);
        $c->where_eq("apply_id", $_aid);
        $res = $this->fetch_one("*", $c);

        return $res;
    }

    function del_form_res($_aid)
    {
        $c = new Query();
        $c->from="program_form_res";
        $c->where_eq("apply_id", $_aid);
        $this->delete_cond($c);
    }
}

$current_controller->Program_form = new Program_form_model($settings);
?>
