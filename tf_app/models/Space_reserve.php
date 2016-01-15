<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Space_reserve_model extends Model
{
    var $tablename = "space_reserve";

    function add($_arr)
    {
        // $this->debug();
        $c = new Query();
        $c->value("user_id", $_arr["user_id"]);
        $c->value("user_name", $_arr["user_name"]);
        $c->value("space_id", $_arr["space_id"]);
        $c->value("start", $_arr["start"]);
        $c->value("end", $_arr["end"]);
        $c->value("date", $_arr["date"]);
        $c->value("rel_url", $_arr["rel_url"]);
        $c->value("purpose", $_arr["purpose"]);
        $c->value("purpose_des", $_arr["purpose_des"]);
        $c->value("cnt", $_arr["cnt"]);
        $c->value("user_type", $_arr["user_type"]);
        $c->value("user_bio", $_arr["user_bio"]);
        $c->value("group_bio", $_arr["group_bio"]);
        $c->value("group_web", $_arr["group_web"]);
        $c->value("users_info", $_arr["users_info"]);
        $c->value("paid", $_arr["paid"]);
        $c->value("paid_des", $_arr["paid_des"]);
        $c->value("meal", $_arr["meal"]);
        $c->value("Invit", $_arr["Invit"]);
        $c->value("tel", $_arr["tel"]);
        $c->value("email", $_arr["email"]);
        $c->value("state", $_arr["state"]);
        $c->value("state_des", $_arr["state_des"]);
        if ($_arr["reserved"]) $c->value("reserved", $_arr["reserved"]);
        if ($_arr["id"]) {
            if ($_arr["date_created"]) $c->value("date_created", "now()", 1);
            $c->where_eq("id", $_arr["id"]);
            $this->update($c);
            
            $id = $_arr["id"];
        }
        else {
            $c->value("date_created", "now()", 1);
            $this->insert($c);
            
            $id = $this->last_id();
        }
        return $id;
    }
    
    function list_($_page, $_pagesize, $_where = '', $_order = '')
    {
       // $this->debug();
        $c = new Query();
        $c->from="members m, space_ s, space_reserve sr";
        $c->where("sr.user_id = m.id");
        $c->where("sr.space_id = s.id");
        if ($_where) $c->where ($_where);
        if ($_order) $c->order = $_order;
        else $c->order = "sr.date_created DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $res = $this->fetch("CONCAT_WS(' ', sr.date, sr.start) ss, m.id mid, m.ids, m.name mname, m.membership, s.type stype, s.id sid, s.name, s.opt, sr.*", $c);
        
        return $res;
    }
    
    function cnt($_where = '')
    {
        $c = new Query();
        $c->from="members m, space_ s, space_reserve sr";
        $c->where("sr.user_id = m.id");
        $c->where("sr.space_id = s.id");
        if ($_where) $c->where ($_where);
        return $this->counts($c);
    }
    
    function get_detail($_id)
    {
//        $this->debug();
        $c = new Query();
        $c->from="members m, space_ s, space_reserve sr";
        $c->where("sr.user_id = m.id");
        $c->where("sr.space_id = s.id");
        $c->where_eq("sr.id", $_id);
        $res = $this->fetch_one("m.id mid, m.ids, m.name mname, m.email memail, s.id sid, s.name, s.opt, s.type, sr.start sstart, sr.end send, sr.*", $c);
        
        return $res;
    }
    
    function permit($_id, $_arr)
    {
//        $this->debug();
        $c = new Query();
        $c->where_eq("id", $_id);
        $c->value("state", $_arr["state"]);
        $c->value("state_des", $_arr["state_des"]);
        $this->update($c);
    }
    
    function get_by_date($_date, $_where = '')
    {
//        $this->debug();
        $c = new Query();
        $c->from="space_reserve sr, space_ s";
        if ($_where) $c->where ($_where);
        $c->where("sr.space_id = s.id");
        $c->where_eq("date", $_date);
        $c->order="sr.space_id ASC, start ASC";
        $res = $this->fetch("s.name, s.opt, s.type stype, sr.*", $c);
        
        return $res;
    }
    
    function get_by_date_space($_date, $_space, $_id = '')
    {
//        $this->debug();
        $c = new Query();
        $c->from="space_reserve sr, space_ s";
        $c->where("sr.space_id = s.id");
        $c->where_eq("space_id", $_space);
        $c->where_eq("date", $_date);
        $c->where_eq("state", 1);
        if ($_id) $c->where ("sr.id != ".$_id);
        $res = $this->fetch("sr.*", $c);
        
        return $res;
    }
    
    function get_by_date_o_space($_where)
    {
        // $this->debug();
        $c = new Query();
        $c->from = "space_ s, space_reserve sr";
        $c->where("sr.space_id = s.id");
        if ($_where) $c->where ($_where);
        $c->order="sr.start ASC";
        $res = $this->fetch("s.name sname, s.type stype, s.opt, sr.*", $c);
        return $res;
    }

    function get_info_by_reserve($_where)
    {
        // $this->debug();
        $c = new Query();
        $c->from = "space_ s, space_reserve sr, members m";
        $c->where("sr.space_id = s.id");
        $c->where("sr.user_id = m.id");
        if ($_where) $c->where ($_where);
        $c->order="sr.start ASC";
        $res = $this->fetch("m.name mname, m.picture, s.name sname, s.type stype, s.opt, sr.*", $c);
        return $res;
    }

    function edit_rel_url ($_arr)
    {
        $c = new Query();
        $c->value("rel_url", $_arr["rel_url"]);
        $c->where_eq("id", $_arr["id"]);
        $this->update($c);
    }

    function day_per()
    {
        $c = new Query();
        $c->where_eq("state", 1);
        $c->group="date";
        $c->order="date ASC";
        $res = $this->fetch("COUNT(*) cnt, REPLACE(date, '.', '-') date", $c);

        return $res;
    }

    function signout($_id)
    {
        $c = new Query();
        $c->where_eq("user_id", $_id);
        $this->delete_cond($c);
    }
}

$current_controller->Space_reserve = new Space_reserve_model($settings);
?>
