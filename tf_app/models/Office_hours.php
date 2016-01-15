<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Office_hours_model extends Model
{
    var $tablename = "office_hours";

    function get($_id)
    {
        // $this->debug();
        $c = new Query();
        $c->from="office_hours o, office_mento m";
        $c->where("m.id = o.mento_id");
        $c->where_eq("o.id", $_id);    
        $res = $this->fetch_one("o.*, m.name mname, m.picture mpicture, m.user_id mid", $c);

        return $res;
    }

    function get_detail($_id)
    {
        // $this->debug();
        $c = new Query();
        $c->from="office_hours o, office_mento m, members mm";
        $c->where("m.id = o.mento_id");
        $c->where("m.user_id = mm.id");
        $c->where_eq("m.id", $_id);    
        $res = $this->fetch_one("o.*, m.name mname, m.picture mpicture, m.user_id mid, m.position mposition, mm.email memail", $c);

        return $res;
    }

    function add($_arr) {
        // $this->debug();
        $c = new Query();
        if ($_arr["mento_id"]) $c->value("mento_id", $_arr["mento_id"]);
        if ($_arr["subject"]) $c->value("subject", $_arr["subject"]);
        if ($_arr["hosted"]) $c->value("hosted", $_arr["hosted"]);
        if ($_arr["place"]) $c->value("place", $_arr["place"]);
        if ($_arr["e_start"]) $c->value("e_start", $_arr["e_start"]);
        if ($_arr["e_end"]) $c->value("e_end", $_arr["e_end"]);
        if ($_arr["a_start"]) $c->value("a_start", $_arr["a_start"]);
        if ($_arr["a_end"]) $c->value("a_end", $_arr["a_end"]);
        if ($_arr["r_date"]) $c->value("r_date", $_arr["r_date"]);
        if ($_arr["description"]) $c->value("description", $_arr["description"]);
        if ($_arr["picture"]) $c->value("picture", $_arr["picture"]);
        if ($_arr["start"]) $c->value("start", $_arr["start"]);
        if ($_arr["ing"]) $c->value("ing", $_arr["ing"]);
        if ($_arr["hue"]) $c->value("hue", $_arr["hue"]);
        if ($_arr["cnt"]) $c->value("cnt", $_arr["cnt"]);
        if (array_key_exists("is_open", $_arr)) $c->value("is_open", $_arr["is_open"]);
        
        if ($_arr["id"]) 
        {
            $c->value("date_updated", "now()", 1);
            $c->where_eq("id", $_arr["id"]);
            $this->update($c);
            $id = $_arr["id"];
        }
        else 
        {
            $c->value("date_created", "now()", 1);
            $this->insert($c);
            $id = $this->last_id();
        }

        return $id;
    }

    function search($_page, $_pagesize, $_key)
    {
        //$this->debug();
        $c = new Query();
        $c->from = "office_hours o, office_mento om";
        $c->where("(o.subject like '%".$_key."%' or o.description like '%".$_key."%')");
        $c->where("om.id = o.mento_id");
        $c->order = "o.id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;

        $res = $this->fetch("om.name, o.id, o.subject, o.description, o.hosted, o.date_created, o.e_start, o.e_end, o.a_start, o.a_end, o.r_date, o.picture", $c);

        return $res;
    }

    function get_by_search_cnt($_key){
        $c = new Query();
        $c->from = "office_hours";
        $c->where("(subject like '%".$_key."%' or description like '%".$_key."%')");

        $res = $this->counts($c);

        return $res;
    }

    function list_($_page, $_pagesize, $_where = '', $_order = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="office_hours o, office_mento om";
        $c->where("om.id = o.mento_id");
        if ($_where) $c->where($_where);
        $c->page = $_page;
        $c->page_size = $_pagesize;
        if ($_order) $c->order=$_order;
        else $c->order="id DESC";
        $res = $this->fetch("om.name, o.*", $c);

        return $res;
    }

    function list_o($_page, $_pagesize, $_where = '', $_order = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="office_hours o, office_mento om, members m";
        $c->where("om.id = o.mento_id");
        $c->where("m.id = om.user_id");
        if ($_where) $c->where($_where);
        $c->page = $_page;
        $c->page_size = $_pagesize;
        if ($_order) $c->order=$_order;
        else $c->order="id DESC";
        $res = $this->fetch("m.name, o.*", $c);

        return $res;
    }

    function cnt($_where = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="office_hours o, members m";
        $c->where("m.id = o.mento_id");
        if ($_where) $c->where($_where);
        $res = $this->counts($c);

        return $res;
    }

    function cnt_o($_where = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="office_hours o, office_mento om, members m";
        $c->where("om.id = o.mento_id");
        $c->where("m.id = om.user_id");
        if ($_where) $c->where($_where);
        $res = $this->counts($c);

        return $res;
    }

    function fix_status($_id)
    {
        // $this->debug();
        $c = new Query();
        $c->value("status", 1);
        $c->where_eq("id", $_id);
        $res = $this->update($c);
        return $res;
    }

    function get_open_by_mento($_id)
    {
        // $this->debug();
        $c =  new Query();
        $c->where("a_start <= '".date("Y.m.d H:i")."' and a_end > '".date("Y.m.d H:i")."'");
        $c->where_eq("is_open", 1);
        $c->where_eq("mento_id", $_id);
        $res = $this->fetch_one("*", $c);

        return $res;
    }

    function get_open()
    {
        // $this->debug();
        $c = new Query();
        $c->from="office_hours h, office_mento m";
        $c->where("m.id = h.mento_id");
        $c->where_eq("is_open", 1);
        $c->where("a_start <= '".date("Y.m.d H:i")."' and a_end > '".date("Y.m.d H:i")."'");
        $res = $this->fetch("m.*, h.id hid", $c);

        return $res;
    }

    function signout($_id)
    {
        $c = new Query();
        $c->from="office_hours h, office_mento m";
        $c->where("m.id = h.mento_id");
        $c->where_eq("m.user_id", $_id);
        $this->delete_cond($c);
    }
 }

$current_controller->Office_hours = new Office_hours_model($settings);
?>
