<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Notice_model extends Model
{
    var $tablename = "notice";

    function add($_arr)
    {
//        $this->debug();
        $c = new Query();
        $c->value("type", $_arr["type"]);
        $c->value("title", $_arr["title"]);
        $c->value("contents", $_arr["contents"]);
        $c->value("visible", $_arr["visible"]);
        $c->value("writer_id", $_arr["writer_id"]);
        $c->value("writer", $_arr["writer"]);
        $c->value("date_edited", "now()", 1);
        if ($_REQUEST["main"]) $c->value ("main", $_REQUEST);
        if ($_REQUEST["id"]) {
            $c->where_eq("id", $_REQUEST["id"]);
            $this->update($c);
            $id = $_REQUEST["id"];
        }
        else {
            $c->value("date_created", "now()", 1);
            $this->insert($c);
            $id = $this->last_id();
        }
        return $id;
    }
    
    function add_picture($_id, $_pic)
    {
        $c = new Query();
        $c->value("main", $_pic);
        $c->where_eq("id", $_id);
        $this->update($c);
    }
    
    function list_($_page, $_pagesize, $_type = '', $_writer = '', $_where = '', $_order = '')
    {
       // $this->debug();
        $c = new Query();
        if ($_writer) {
            $c->from="notice n, members m";
            $c->where("n.writer_id = m.id");
        }
        if ($_type) $c->where_eq ("type", $_type);
        if ($_where) $c->where($_where);
        if ($_writer) {
            
            if ($_order) $c->order=$_order;
            else $c->order = "n.id DESC";
        }
        else {
            if ($_order) $c->order=$_order;
            else $c->order = "id DESC";
            
        }
        $c->page = $_page;
        $c->page_size = $_pagesize;
        if ($_writer) {
            $res = $this->fetch("n.*, m.ids, m.name, m.picture", $c);
        }
        else {
            $res = $this->fetch("*", $c);
        }
        
        return $res;
    }
    
    function get_detail($_id, $_writer = '', $_where = '')
    {
       // $this->debug();
        $c = new Query();
        if ($_writer) {
            $c->from="notice n, members m";
            $c->where("n.writer = m.name");
        }
        if ($_where) $c->where($_where);
        if ($_writer) $c->where_eq("n.id", $_id);
        else $c->where_eq("id", $_id);
        if ($_writer) {
            $res = $this->fetch_one("n.*, m.ids, m.name, m.picture", $c);
        }
        else {
            $res = $this->fetch_one("*", $c);
        }
        
        return $res;
    }
    
    function cnt($_where = '')
    {
//        $this->debug();
        $c = new Query();
        if ($_where) $c->where($_where);
        return $this->counts($c);
    }
    
    function edit($_id, $_state)
    {
        $c = new Query();
        $c->value("visible", $_state);
        $c->where_eq("id", $_id);
        $this->update($c);
    }
    
    function edit_all($_list, $_state)
    {
        $c = new Query();
        $c->value("visible", $_state);
        $c->where("id IN (".$_list.")");
        $this->update($c);
    }
    
    function delete_all($_list)
    {
        $c = new Query();
        $c->where("id IN (".$_list.")");
        $this->delete_cond($c);
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

    function pageview($_id)
    {
        $c = new Query;
        $c->value("v_cnt", "v_cnt+1", 1);
        $c->where_eq("id", $_id);
        $this->update($c);
    }
}

$current_controller->Notice = new Notice_model($settings);
?>
