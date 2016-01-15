<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Content_model extends Model
{
    var $tablename = "content";

    function add($_arr)
    {
//        $this->debug();
        $c = new Query();
        if (array_key_exists("user_id", $_arr)) $c->value("user_id", $_arr["user_id"]);
        if (array_key_exists("category_id", $_arr)) $c->value("category_id", $_arr["category_id"]);
        if (array_key_exists("subject", $_arr)) $c->value("subject", $_arr["subject"]);
        if (array_key_exists("contents", $_arr)) $c->value("contents", $_arr["contents"]);
        if (array_key_exists("img", $_arr) && $_arr["img"]) $c->value("img", $_arr["img"]);
        if (array_key_exists("hidden", $_arr) ) $c->value("hidden", $_arr["hidden"]);
        if (array_key_exists("state", $_arr) ) $c->value("state", $_arr["state"]);
        if ($_arr["id"]) {
            $c->where_eq ("id", $_arr["id"]);
            $this->update($c);
        }
        else {
            $c->value("date_created", "now()", 1);
            $this->insert($c);
            $_arr["id"] = $this->last_id();
        }
        
        return $_arr["id"];
    }
    
    function get($_id)
    {
//        $this->debug();
        $c = new Query();
        $c->from="content c, content_category cc, members m";
        $c->where("c.user_id = m.id");
        $c->where("c.category_id = cc.id");
        $c->where_eq("c.id", $_id);
        $res = $this->fetch_one("c.*, c.picture cpic, cc.id cid, cc.name cname, m.id mid, m.name, m.ids, m.picture, m.email memail", $c);
        return $res;
    }
    
    function list_($_page = '', $_pagesize = '', $_where = '', $_order = '')
    {
        $c = new Query();
        $c->from="content c, content_category cc, members m";
        $c->where("c.user_id = m.id");
        $c->where("c.category_id = cc.id");
        if ($_where) $c->where ($_where);
        if ($_page) $c->page = $_page;
        if ($_pagesize) $c->page_size = $_pagesize;
        if ($_order) $c->order = $_order;
        else $c->order = "id DESC";
        $res = $this->fetch("c.*, cc.id cid, cc.name cname, m.name mname, m.id mid, m.ids, m.bio, m.name mname, m.picture mpicture", $c);
        
        return $res;
    }
    
    function cnt($_where = '')
    {
//        $this->debug();
        $c = new Query();
        $c->from="content c, content_category cc, members m";
        $c->where("c.user_id = m.id");
        $c->where("c.category_id = cc.id");
        if ($_where) $c->where ($_where);
        $res = $this->counts($c);
        
        return $res;
    }
    
    function last_content($_user, $_where = "")
    {
        $c = new Query();
        $c->where_eq("user_id", $_user);
        if($_where) $c->where($_where);
        $c->limit=1;
        $c->order="id DESC";
        $res = $this->fetch_one("id, date_created", $c);
        
        return $res;
    }

    function get_where($_where, $_order)
    {
        $c = new Query();
        $c->from="content c, content_category cc";
        $c->where("c.category_id = cc.id");
        if ($_where) $c->where ($_where);
        if ($_order) $c->order=$_order;
        $c->limit=1;
        $res = $this->fetch_one($c);
        
        return $res;
    }

    function pageview($_id)
    {
        $c = new Query;
        $c->value("v_cnt", "v_cnt+1", 1);
        $c->where_eq("id", $_id);
        $this->update($c);
    }

    function edit_main($_ids)
    {
        $d = new Query();
        $d->value("is_main", 0);
        $this->update($d);

        $e = new Query();
        $e->value("is_main", 1);
        $e->where("id IN (".$_ids.")");
        $this->update($e);
    }

    function add_picture($_id, $_pic)
    {
        $c = new Query();
        $c->value("picture", $_pic);
        $c->where_eq("id", $_id);
        $this->update($c);
    }

    function signout($_id)
    {
        $c = new Query();
        $c->where_eq("user_id", $_id);
        $this->delete_cond($c);
    }

    function search($_page, $_pagesize, $_key, $_where = '')
    {
        $c = new Query();
        $c->from="content c, content_category cc, members m";
        $c->where("c.user_id = m.id");
        $c->where("c.category_id = cc.id");
        $c->where("(c.subject like '%".$_key."%' or c.contents like '%".$_key."%' or m.name like '%".$_key."%')");
        if ($_where) $c->where ($_where);
        if ($_page) $c->page = $_page;
        if ($_pagesize) $c->page_size = $_pagesize;
        $c->order="id DESC";

        $res = $this->fetch("c.id, c.subject, c.contents, c.picture, cc.id cid, cc.name cname, m.name mname, m.id mid, m.ids, m.bio, m.name mname, m.picture mpicture, DATE_FORMAT(c.date_created, '%Y-%m-%d') date_created", $c);

        return $res;
    }

    function get_by_search_cnt($_key, $_where = ''){
        $c = new Query();
        $c->from="content c, content_category cc, members m";
        $c->where("c.user_id = m.id");
        $c->where("c.category_id = cc.id");
        $c->where("(c.subject like '%".$_key."%' or c.contents like '%".$_key."%' or m.name like '%".$_key."%')");
        if ($_where) $c->where ($_where);

        $res = $this->counts($c);

        return $res;
    }
 }

$current_controller->Content = new Content_model($settings);
?>
