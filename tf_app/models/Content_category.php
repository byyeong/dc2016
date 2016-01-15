<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Content_category_model extends Model
{
    var $tablename = "content_category";

    function add($_arr)
    {
        if (!$_arr["id"]) {    
            $d = new Query();
            $max = $this->fetch_one("Max(ord) ord", $d);
            if (!$max) $max["ord"] = 0;
        }
        
        $c = new Query();
        if (array_key_exists("name", $_arr)) $c->value("name", $_arr["name"]);
        if (array_key_exists("des", $_arr)) $c->value("des", $_arr["des"]);
        if (array_key_exists("picture", $_arr) && $_arr["picture"]) $c->value("picture", $_arr["picture"]);
        if (array_key_exists("hidden", $_arr) ) $c->value("hidden", $_arr["hidden"]);
        if (array_key_exists("id", $_arr) && $_arr["id"]) {
            $c->where_eq ("id", $_arr["id"]);
            $this->update($c);
        }
        else {
            $c->value("ord", $max["ord"] + 1);
            $c->value("date_created", "now()", 1);
            $this->insert($c);
            $_arr["id"] = $this->last_id();
        }
        
        return $_arr["id"];
    }
    
    function add_picture($_id, $_pic)
    {
        $c = new Query();
        $c->value("picture", $_pic);
        $c->where_eq("id", $_id);
        $this->update($c);
    }
    
    function list_($_page = '', $_pagesize = '', $_where = '')
    {
        $c = new Query();
        if ($_where) $c->where ($_where);
        if ($_page) $c->page = $_page;
        if ($_pagesize) $c->page_size = $_pagesize;
        $c->order = "ord ASC";
        $res = $this->fetch("*", $c);
        
        return $res;
    }
    
    function edit_user($_cat, $_user, $_del = '')
    {
//        $this->debug();
        $c = new Query();
        $c->from="content_cat_user";
        if ($_del) {
            $c->where_eq("category_id", $_cat);
            $c->where_eq("user_id", $_user);
            $this->delete_cond($c);
        }
        else {
            $c->value("category_id", $_cat);
            $c->value("user_id", $_user);
            $this->insert($c);
        }
    }
    
    function get_user_by_cat($_cat)
    {
//        $this->debug();
        $c = new Query();
        $c->from="content_cat_user ccu, members m";
        $c->where("ccu.user_id = m.id");
        $c->where_eq("category_id", $_cat);
        $c->order="id DESC";
        $res = $this->fetch("m.membership, m.id, m.name, m.ids, m.tel, m.admin_des, m.gender, m.birth", $c);
        
        return $res;
    }
    
    function get_cat_by_user($_user, $_where = '')
    {
//        $this->debug();
        $c = new Query();
        $c->from="content_category cc, content_cat_user ccu";
        $c->where("ccu.category_id = cc.id");
        if ($_where) $c->where ($_where);
        $c->where_eq("ccu.user_id", $_user);
        $c->order="ccu.id DESC";
        $res = $this->fetch("cc.name, cc.id", $c);
        
        return $res;
    }
    
    function set_ord($_ord, $_type)
    {
        $d = new Query();
        $d->value("ord", 0);
        $d->where_eq("ord", $_ord);
        $this->update($d);
        
        if ($_type == 1) {
            $c = new Query();
            $c->value("ord", $_ord);
            $c->where_eq("ord", $_ord - 1);
            $this->update($c);
            
            $e = new Query();
            $e->value("ord", $_ord - 1);
            $e->where_eq("ord", 0);
            $this->update($e);
        }
        else {
            $c = new Query();
            $c->value("ord", $_ord);
            $c->where_eq("ord", $_ord + 1);
            $this->update($c);
            
            $e = new Query();
            $e->value("ord", $_ord + 1);
            $e->where_eq("ord", 0);
            $this->update($e);
        }
    }
 }

$current_controller->Content_category = new Content_category_model($settings);
?>
