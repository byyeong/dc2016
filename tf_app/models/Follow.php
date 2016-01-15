<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Follow_model extends Model
{
    
    var $tablename = "follow";

    function add($_arr)
    {
//        $this->debug();
        $c = new Query();
        $c->value("following", $_arr["following"]);
        $c->value("follower", $_arr["follower"]);
        $c->value("type", $_arr["type"]);
        $c->value("date_created", "now()", 1);
        $this->insert($c);
        
        return $this->last_id();
    }

    function check_follow($_f1, $_f2, $_type)
    {
//        $this->debug();
        $c = new Query();
        $c->where_eq("follower", $_f1);
        $c->where_eq("following", $_f2);
        $c->where_eq("type", $_type);
        return $this->fetch_one("id", $c);
    }
    
    function del($_arr)
    {
//        $this->debug();
        $c = new Query();
        $c->where_eq("following", $_arr["following"]);
        $c->where_eq("follower", $_arr["follower"]);
        $c->where_eq("type", $_arr["type"]);
        $this->delete_cond($c);
    }
    
    function get_folling($_type = '', $_id = '')
    {
//        $this->debug();
        $c = new Query();
        $c->where_eq("following", $_id);
        if ($_type) $c->where_eq("type", $_type);
        $res = $this->fetch("*", $c);
        
        return $res;
    }

    function get_folling_w_mem($_type = '', $_id = '', $_where = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="follow f, members m";
        $c->where("f.follower = m.id");
        $c->where_eq("following", $_id);
        if ($_type) $c->where_eq("f.type", $_type);
        if ($_where) $c->where($_where);
        $res = $this->fetch("f.*", $c);
        
        return $res;
    }
    
    function get_follower($_type = '', $_id = '')
    {
//        $this->debug();
        $c = new Query();
        $c->where_eq("follower", $_id);
        if ($_type) $c->where_eq("type", $_type);
        $res = $this->fetch("*", $c);
        
        return $res;
    }

    function cnt($_where, $_from = '')
    {
        $c = new Query();
        if ($_from) $c->from=$_from;
        if ($_where) $c->where($_where);
        $res = $this->counts($c);

        return $res;
    }

    function signout($_id)
    {
        $c = new Query();
        $c->where("(following = ".$_id." or follower = ".$_id.")");
        $this->delete_cond($c);
    }
    
}

$current_controller->Follow = new Follow_model($settings);
?>
