<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Program_file_model extends Model
{
    var $tablename = "program_file";

    function add($_arr)
    {
        $c = new Query();
        $c->value("program_id", $_arr["program_id"]);
        $c->value("title", $_arr["title"]);
        $c->value("sub", $_arr["sub"]);
        $c->value("req", $_arr["req"]);
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
        $res = $this->fetch("*", $c);
        
        return $res;
    }

    function del_file($_cid)
    {
        $c = new Query();
        $c->where_eq("program_id", $_cid);
        $this->delete_cond($c);
    }

// program_file_res

    function add_res($_arr)
    {
        // $this->debug();
        $d = new Query();
        $d->from="program_file_res";
        $d->where_eq("c_file_id", $_arr["c_file_id"]);
        $d->where_eq("apply_id", $_arr["apply_id"]);
        $res = $this->fetch_one("id", $d);

        if ($res) {
            $c = new Query();
            $c->from="program_file_res";
            $c->value("file", $_arr["file"]);
            $c->where_eq("id", $res["id"]);
            $this->update($c);
            $_id = $res["s_id"];
        }
        else {
            $c = new Query();
            $c->from="program_file_res";
            $c->value("c_file_id", $_arr["c_file_id"]);
            $c->value("apply_id", $_arr["apply_id"]);
            $c->value("file", $_arr["file"]);
            $this->insert($c);
            $_id = $this->last_id();
        }
        
        return $_id;
    }
    
    function get_by_file_user_res($_id, $_user)
    {
        $c = new Query();
        $c->from="program_file_res";
        $c->where_eq("c_file_id", $_id);
        $c->where_eq("apply_id", $_user);
        $res = $this->fetch_one("*", $c);
        
        return $res;
    }

    function get_by_apply_res($_id)
    {
        $c = new Query();
        $c->from="program_file_res";
        $c->where_eq("apply_id", $_id);
        $c->order="id ASC";
        $res = $this->fetch("file", $c);
        
        return $res;
    }

    function del_file_res($_cid)
    {
        $c = new Query();
        $c->from="program_file_res";
        $c->where_eq("apply_id", $_cid);
        $this->delete_cond($c);
    }
 }

$current_controller->Program_file = new Program_file_model($settings);
?>
