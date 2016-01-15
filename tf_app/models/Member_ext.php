<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Member_ext_model extends Model
{
    const ALL_TYPE = 0;
    const FACEBOOK_TYPE = 1;
    const TWITTER_TYPE = 2;
        
    var $tablename = "member_ext";
    
    function get_by_ids_type($_id, $_type)
    {
        $c = new Query();
        $c->where_eq("ids", $_id);
        $c->where_eq("type", $_type);
        return $this->fetch("*", $c);
    }
    
    function get_by_user_id_type($_uid, $_type)
    {
        $c = new Query();
        $c->where_eq("user_id", $_uid);
        $c->where_eq("type", $_type);
        return $this->fetch_one("*", $c);
    }
    
    function add($_arr)
    {
        $c = new Query();
        $c->value("user_id", $_arr["user_id"]);
        $c->value("type", $_arr["type"]);
        $c->value("ids", $_arr["ids"]);
        $c->value("key_", $_arr["key"]);
        $c->value("secret", $_arr["secret"]);
        $c->value("date_created", "now()", 1);
        $this->insert($c);
    }

    function edit($_arr)
    {
        $c = new Query();
        $c->value("ids", $_arr["ids"]);
        $c->value("key_", $_arr["key"]);
        $c->value("secret", $_arr["secret"]);
        $c->value("date_created", "now()", 1);
        $c->where_eq("user_id", $_arr["user_id"]);
        $c->where_eq("type", $_arr["type"]);
        $this->update($c);
    }

    function edit_by_fb($_arr)
    {
        $c = new Query();
        $c->value("ids", $_arr["ids"]);
        $c->value("secret", $_arr["secret"]);
        $c->value("date_created", "now()", 1);
        if ($_arr["public"]) $c->value("public", $_arr["public"]);
        $c->where_eq("user_id", $_arr["user_id"]);
        $c->where_eq("type", $_arr["type"]);
        $this->update($c);
    }

}

$current_controller->Member_ext = new Member_ext_model($settings);
?>
