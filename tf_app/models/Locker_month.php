<?php

class Locker_month_model extends Model
{
    var $tablename = "locker_month";
    
    function add($_arr)
    {
        $c = new Query();
        $c->value("user_id", $_arr["user_id"]);
        $c->value("locker_id", $_arr["locker_id"]);
        $c->value("date", $_arr["date"]);
        $c->value("state", $_arr["state"]);
        $c->value("date_created", "now()", 1);
        $this->insert($c);
        
        return $this->last_id();
    }
    
    function get_cnt($_date, $_where = '')
    {
//        $this->debug();
        $c = new Query();
        $c->where_eq("date", $_date);
        if ($_where) $c->where ($_where);
        $res = $this->counts($c);
        
        return $res;
    }
    
    function get_by_month($_page, $_pagesize, $_date, $_where = '')
    {
//        $this->debug();
        $c = new Query();
        $c->from="locker_month l, members m";
        $c->where("l.user_id = m.id");
        $c->where_eq("date", $_date);
        if ($_where) $c->where ($_where);
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $c->order="l.date_created DESC";
        $res = $this->fetch("l.id, l.locker_id, l.date, l.user_id, m.id mid, m.name, m.membership, m.email, m.membership", $c);
        
        return $res;
    }
    
    function get_by_month_cnt($_date, $_where = '')
    {
//        $this->debug();
        $c = new Query();
        $c->where_eq("date", $_date);
        if ($_where) $c->where ($_where);
        $res = $this->counts($c);
        
        return $res;
    }
    
    function get_by_month_user($_date, $_email, $_where = '')
    {
//        $this->debug();
        $c = new Query();
        $c->from="locker_month l, members m";
        $c->where("l.user_id = m.id");
        $c->where_eq('date', $_date);
        $c->where_eq("email", $_email);
        if ($_where) $c->where ($_where);
        $res = $this->fetch_one("l.*, m.name", $c);
        
        return $res;
    }
    
    function get_by_month_user_id($_date, $_user, $_where = '')
    {
//        $this->debug();
        $c = new Query();
        $c->from="locker_month l, members m";
        $c->where("l.user_id = m.id");
        $c->where_eq('date', $_date);
        $c->where_eq("user_id", $_user);
        if ($_where) $c->where ($_where);
        $res = $this->fetch_one("l.*, m.name, m.email", $c);
        
        return $res;
    }
    
    function edit_state($_date, $_user, $_state) 
    {
//        $this->debug();
        $c = new Query();
        $c->value("state", $_state);
        $c->where_eq("date", $_date);
        $c->where_eq("user_id", $_user);
        $this->update($c);
    }
    
    function edit_locker($_date, $_user, $_locker) 
    {
//        $this->debug();
        $c = new Query();
        $c->value("locker_id", $_locker);
        $c->where_eq("date", $_date);
        $c->where_eq("user_id", $_user);
        $this->update($c);
    }
    
    function get_empty($_date = '', $_where = '')
    {
        $this->debug();
        if (!$_date) $_date = date('Y-m');
        $c = new Query();
        $c->from="(SELECT * FROM locker) a LEFT OUTER JOIN (SELECT * FROM locker_month WHERE DATE = '".$_date."' AND locker_id != 0) b ON a.locker = b.locker_id";
        $c->where("b.locker_id IS NULL");
        if ($_where) $c->where ($_where);
        $res = $this->fetch("locker", $c);
        
        return $res;
    }
}

$current_controller->Locker_month = new Locker_month_model($settings);
?>