<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Competitions_file_model extends Model
{
    var $tablename = "competitions_file";

    function add($_arr)
    {
        $c = new Query();
        $c->value("competition_id", $_arr["competition_id"]);
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
        $c->where_eq("competition_id", $_id);
        $c->order="id ASC";
        $res = $this->fetch("*", $c);
        
        return $res;
    }

    function del_file($_cid)
    {
        $c = new Query();
        $c->where_eq("competition_id", $_cid);
        $this->delete_cond($c);
    }
 }

$current_controller->Competitions_file = new Competitions_file_model($settings);
?>
