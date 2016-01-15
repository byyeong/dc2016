<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Event_type_model extends Model
{
    var $tablename = "event_type";

    function add($_arr)
    {
        $c = new Query();
        $c->value("name", $_arr["name"]);
        $c->value("description", $_arr["description"]);
        $c->value("visible", $_arr["visible"]);
        
        if ($_arr["id"]) {
            $c->where_eq("id", $_arr["id"]);
            $this->update($c);
            $_id = $this->last_id();
        }
        else {
            $this->insert($c);
            $_id = $_arr["id"];
        }
        return $_id;
    }
    
    function get_detail($_id)
    {
//        $this->debug();
        $c = new Query();
        $c->from = "members m, space_ s, event e";
        $c->where("e.user_id = m.id");
        $c->where("e.space_id = s.id");
        $c->where_eq("e.id", $_id);
        $res = $this->fetch_one("*", $c);
        
        return $res;
    }
            
    function list_($_page, $_pagesize, $_where = '')
    {
//        $this->debug();
        $c = new Query();
        if ($_where) $c->where($_where);
        $c->order = "id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $res = $this->fetch("*", $c);
        
        return $res;
    }
    
    function cnt()
    {
        $c = new Query();
        return $this->counts();
    }
    
    function check($_type)
    {
        $c = new Query();
        $c->where_eq("name", $_type);
        $res = $this->fetch_one("id", $c);
        
        return $res;
    }
}

$current_controller->Event_type = new Event_type_model($settings);
?>
