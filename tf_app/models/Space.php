<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Space_model extends Model
{
    var $tablename = "space_";

    function add($_arr)
    {
        $c = new Query();
        $c->value("type", $_arr["type"]);
        $c->value("name", $_arr["name"]);
        $c->value("opt", $_arr["opt"]);
        $c->value("start", $_arr["start"]);
        $c->value("end", $_arr["end"]);
        $c->value("days", $_arr["days"]);
        $c->value("visible", $_arr["visible"]);
        
        if ($_REQUEST["id"]) {
            $c->where_eq("id", $_REQUEST["id"]);
            $this->update($c);
        }
        else {
            $c->value("date_created", "now()", 1);
            $this->insert($c);
        }
        
    }
    
    function list_($_page = '', $_pagesize = '', $_where = '')
    {
//        $this->debug();
        $c = new Query();
        if ($_where) $c->where($_where);
        $c->order = "opt ASC";
        if ($_page) $c->page = $_page;
        if ($_pagesize) $c->page_size = $_pagesize;
        $res = $this->fetch("*", $c);
        
        return $res;
    }
    
    function cnt($_where)
    {
        $c = new Query();
        if ($_where) $c->where ($_where);
        return $this->counts();
    }
    
}

$current_controller->Space = new Space_model($settings);
?>
