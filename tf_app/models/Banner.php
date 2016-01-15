<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Banner_model extends Model
{
    var $tablename = "banner";
    /* type
    1: main
    2: recruit
    3: challenge
    4: showcase
    5: event
    6: benefit
    7: blog
    */

    function add($_arr)
    {
        $c = new Query();
        if ($_arr["pic_1"]) $c->value("pic_1", $_arr["pic_1"]);
        $c->value("url_1", $_arr["url_1"]);
        $c->value("target_1", $_arr["target_1"]);
        if ($_arr["pic_2"]) $c->value("pic_2", $_arr["pic_2"]);
        $c->value("url_2", $_arr["url_2"]);
        $c->value("target_2", $_arr["target_2"]);
        if ($_arr["pic_3"]) $c->value("pic_3", $_arr["pic_3"]);
        $c->value("url_3", $_arr["url_3"]);
        $c->value("target_3", $_arr["target_3"]);
        $c->value("des_1", $_arr["des_1"]);
        $c->value("des_2", $_arr["des_2"]);
        $c->value("des_3", $_arr["des_3"]);
        $c->value("active_1", $_arr["act_1"]);
        $c->value("active_2", $_arr["act_2"]);
        $c->value("active_3", $_arr["act_3"]);
        $c->value("type", $_arr["type"]);
        
        if ($_arr["id"]) {
            $c->where_eq("id", $_arr["id"]);    
            $this->update($c);
            $id = $_arr["id"];
        }
        else {
            $this->insert($c);
            $id = $this->last_id();
        }
        return $id;
    }
    
    function add_picture($_key, $_pic, $_id)
    {
//        $this->debug();
        $c = new Query();
        $c->value($_key, $_pic);
        $c->where_eq("id", $_id);
        $this->update($c);
    }
    
    function all()
    {
        $c = new Query();
        $c->where_eq("type", 1);
        return $this->fetch_one("*", $c);
    }

    function recruit()
    {
        $c = new Query();
        $c->where_eq("type", 2);
        return $this->fetch_one("*", $c);
    }

    function get_one($_id)
    {
        $c = new Query();
        $c->where_eq("type", $_id);
        return $this->fetch_one("*", $c);
    }
 }

$current_controller->Banner = new Banner_model($settings);
?>
