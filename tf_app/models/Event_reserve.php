<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Event_reserve_model extends Model
{
    var $tablename = "event_reserve";

    function add($_arr)
    {
//        $this->debug();
        $c = new Query();
        $c->value("user_id", $_arr["user_id"]);
        $c->value("event_id", $_arr["event_id"]);
        $c->value("company", $_arr["company"]);
        $c->value("state", $_arr["state"]);
        $c->value("date_created", "now()", 1);
        $this->insert($c);
        
        return $this->last_id();
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
            
    function list_($_page = '', $_pagesize = '', $_where = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="(select @rnum:=0) a, members m, member_grade mg , event_reserve er, event e";
        $c->where("er.user_id = m.id");
        $c->where("m.grade = mg.id");
        $c->where("er.event_id = e.id");
        if ($_where) $c->where($_where);
        $c->order = "rownum DESC";
        if ($_page) $c->page = $_page;
        if ($_pagesize) $c->page_size = $_pagesize;
        $res = $this->fetch("@rnum:=@rnum+1 rownum, m.ids, m.picture, m.name mname, m.membership, m.email, m.tel, mg.name mgname, er.*", $c);
        
        return $res;
    }

    function cnt($_where = '')
    {
       // $this->debug();
        $c = new Query();
        if($_where) $c->where ($_where);
        return $this->counts($c);
    }
    
    function edit_state($_id, $_state)
    {
        $c = new Query();
        $c->value("state", $_state);
        $c->where_eq("id", $_id);
        $this->update($c);
    }

    function edit_state_by_cnt($_id, $_cnt)
    {
        // $this->debug();
        $c = new Query();
        $c->value("state", 1);
        $c->where_eq("event_id", $_id);
        $c->limit = $_cnt;
        $c->order = "id ASC";
        $this->update($c);
    }
    
    function check($_id, $_user)
    {
        $c = new Query();
        $c->where_eq("user_id", $_user);
        $c->where_eq("event_id", $_id);
        return $this->fetch_one("*", $c);
    }

    function signout($_id)
    {
        $c = new Query();
        $c->where_eq("user_id", $_id);
        $this->delete_cond($c);
    }
}

$current_controller->Event_reserve = new Event_reserve_model($settings);
?>
