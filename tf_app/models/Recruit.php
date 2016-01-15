<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Recruit_model extends Model
{
    var $tablename = "recruit";

    function add($_arr) 
    {
        $c = new Query();
        if ($_arr["user_id"]) $c->value("user_id", $_arr["user_id"]);
        if ($_arr["startup_id"]) $c->value("startup_id", $_arr["startup_id"]);
        $c->value("start", $_arr["start"]);
        $c->value("end", $_arr["end"]);
        $c->value("title", $_arr["title"]);
        $c->value("contents", $_arr["contents"]);
        $c->value("date_edited", "now()", 1);
        $c->value("state", $_arr["state"]);
        if ($_arr["id"]) {
            $c->where_eq("id", $_arr["id"]);
            $this->update($c);
            $id = $_arr["id"];
        } else {
            $c->value("date_created", "now()", 1);
            $this->insert($c);
            $id = $this->last_id();
        }
        return $id;
    }
    
    function list_s_($_page = '', $_pagesize = '', $_where = '', $_order = '')
    {
       // $this->debug();
        $c = new Query();
        $c->from="recruit r, startup s, members m";
        $c->where("r.startup_id = s.id");
        $c->where("r.user_id = m.id");
        if ($_where) $c->where($_where);
        if ($_page) $c->page = $_page;
        if ($_pagesize) $c->page_size = $_pagesize;
        if ($_order) $c->order=$_order;
        else $c->order="r.id DESC";
        $res = $this->fetch("r.*, r.id rid, r.state rstate , s.id sid, s.logo, s.name sname
                , s.bio, s.addr, s.tel, s.founded, s.number, m.ids, m.name mname, m.picture mpicture", $c);
        
        return $res;
    }

    function list_s_cnt($_where = '')
    {
       // $this->debug();
        $c = new Query();
        $c->from="recruit r, startup s, members m";
        $c->where("r.startup_id = s.id");
        $c->where("r.user_id = m.id");
        if ($_where) $c->where($_where);
        $res = $this->counts($c);
        
        return $res;
    }

    function list_($_page, $_pagesize, $_req = '')
    {
       // $this->debug();
        $c = new Query();
        $c->from="recruit r, startup s, code c";
        $c->where("r.startup_id = s.id");
        $c->where("r.job = c.id");
        if ($_req["job"]) $c->where_eq ("job", $_req["job"]);
        if ($_req["local"]) $c->where_eq ("local", $_req["local"]);
        if ($_req["career"]) $c->where_eq ("career", $_req["career"]);
        if ($_req["field"]) $c->where_eq ("field", $_req["field"]);
        if ($_req["period"]) $c->where_eq ("period", $_req["period"]);
        if ($_req["lang"]) $c->where_eq ("lang", $_req["lang"]);
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $c->order="r.id DESC";
        $res = $this->fetch("*, r.id AS rid", $c);
        
        return $res;
    }

    function list_s_mail($_where = '', $_order = '', $_page = '', $_pagesize = '')
    {
       // $this->debug();
        $c = new Query();
        $c->from="recruit r, startup s, members m";
        $c->where("r.startup_id = s.id");
        $c->where("r.user_id = m.id");
        if ($_where) $c->where($_where);
        $c->group="startup_id";
        if ($_order) $c->order=$_order;
        else $c->order="r.id DESC";
        if ($_page) $c->page = $_page;
        if ($_pagesize) $c->page_size = $_pagesize;
        $res = $this->fetch("r.id, s.id sid, s.logo, s.name sname
                , s.bio, s.addr, s.tel, s.founded, s.number", $c);
        
        return $res;
    }

    function list_s_opt($_page = '', $_pagesize = '', $_tid = '', $_cid = '', $_where = '', $_order = '')
    {
       // $this->debug();
        $c = new Query();
        $c->from="recruit r, recruit_opt ro, startup s, members m";
        $c->where("ro.recruit_id = r.id");
        $c->where("r.startup_id = s.id");
        $c->where("r.user_id = m.id");
        $c->where_eq("code_type", $_tid);
        $c->where_eq("code_id", $_cid);
        if ($_where) $c->where($_where);
        if ($_page) $c->page = $_page;
        if ($_pagesize) $c->page_size = $_pagesize;
        if ($_order) $c->order=$_order;
        else $c->order="r.id DESC";
        $res = $this->fetch("r.*, r.id rid, r.state rstate , s.id sid, s.logo, s.name sname
                , s.bio, s.addr, s.tel, s.founded, s.number, m.ids, m.name mname, m.picture mpicture", $c);
        
        return $res;
    }
    
    function cnt($_req = '', $_where = '')
    {
        $c = new Query();
        if ($_req["job"]) $c->where_eq ("job", $_req["job"]);
        if ($_req["local"]) $c->where_eq ("local", $_req["local"]);
        if ($_req["career"]) $c->where_eq ("career", $_req["career"]);
        if ($_req["field"]) $c->where_eq ("field", $_req["field"]);
        if ($_req["period"]) $c->where_eq ("period", $_req["period"]);
        if ($_req["lang"]) $c->where_eq ("lang", $_req["lang"]);
        if ($_where) $c->where ($_where);
        $res = $this->counts($c);
        
        return $res;
    }
    
    function get($_id)
    {
        $c = new Query();
        $c->from="recruit r, startup s, members m";
        $c->where("r.startup_id = s.id");
        $c->where("r.user_id = m.id");
        $c->where_eq("r.id", $_id);
        $res = $this->fetch_one("r.*, s.id sid, s.logo slogo, s.name, s.tel, s.email, m.name mname, m.ids, m.email memail, m.id mid", $c);
        
        return $res;
    }
            
    function get_by_startup($_st)
    {
        $c = new Query();
        $c->from="recruit r, startup s, code c";
        $c->where("r.startup_id = s.id");
        $c->where("r.job = c.id");
        $c->where_eq("startup_id", $_st);
        $c->where("end > '".date("Y.m.d")."'");
        $c->order="r.id DESC";
        $res = $this->fetch("*, s.id sid, s.logo slogo, s.name, r.id rid", $c);
        
        return $res;
    }
    
    function search($_page, $_pagesize, $_key)
    {
        // $c = new Query();
        // $c->from="recruit r, startup s";
        // $c->where("r.startup_id = s.id");
        // $c->where("(title like '%".$_key."%' or contents like '%".$_key."%')");
        // $res = $this->fetch("r.*, s.logo", $c);
        
        $c = new Query();
        $c->from = "startup s, recruit r";
        $c->where("r.startup_id = s.id");
        $c->where("(s.bio like '%".$_key."%' or s.name like '%".$_key."%'
                or title like '%".$_key."%'
                or contents like '%".$_key."%' or _value like '%".$_key."%')");
        $c->group="r.id";
        $c->order="r.id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;

        $res = $this->fetch("r.*, s.logo", $c);
        
        return $res;
     
    }

    function get_by_search_cnt($_key){
        $c = new Query();
        $c->from = "startup s, recruit r";
        $c->where("r.startup_id = s.id");
        $c->where("(s.bio like '%".$_key."%' or s.name like '%".$_key."%'
                or title like '%".$_key."%'
                or contents like '%".$_key."%' or _value like '%".$_key."%')");
        $c->group="r.id";

        $res = $this->counts($c);

        return $res;
    }
    
    function edit_state($_id, $_state)
    {
        $c = new Query();
        $c->value("state", $_state);
        $c->where_eq("id", $_id);
        $this->update($c);
    }

    function get_email_by_interist($_id, $_code)
    {
        // $this->debug();
        $c = new Query();
        $c->from="member_interist mi, members m";
        $c->where("mi.user_id = m.id");
        $c->where("m.email_rec = 1");
        $c->where("m.wanted = 1");
        $c->where("interist_id IN (SELECT code_id FROM recruit_opt WHERE recruit_id = ".$_id." AND code_type = ".$_code.")");
        $c->group="user_id";
        $res = $this->fetch("name, email", $c);

        return $res;
    }

    function pageview($_id)
    {
        $c = new Query;
        $c->value("v_cnt", "v_cnt+1", 1);
        $c->where_eq("id", $_id);
        $this->update($c);
    }

    function detail_opt($_id, $_opt, $_where)
    {
        $c = new Query();
        $c->from="(
            SELECT r.*, ro.code_id, c._value FROM recruit r, recruit_opt ro, code c 
            WHERE 1 AND r.id = ro.recruit_id AND ro.code_id = c.id 
            AND r.startup_id = ".$_id." AND ro.code_type = ".$_opt." AND ".$_where." 
            ORDER BY r.id DESC
            ) s";
        $c->group="code_id";
        $res = $this->fetch("*", $c);

        return $res;
    }

    function signout($_id)
    {
        $c = new Query();
        $c->where_eq("user_id", $_id);
        $this->delete_cond($c);
    }
 }

$current_controller->Recruit = new Recruit_model($settings);
?>
