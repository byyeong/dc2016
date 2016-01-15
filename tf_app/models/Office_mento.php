<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Office_mento_model extends Model
{
    var $tablename = "office_mento";

    function get_by_user_id($_id) {
        $c = new Query();
        $c->where_eq('user_id', $_id);
        $res = $this->fetch_one("*", $c);
        return $res;
    }

    function get_by_member($_id) {
        $c = new Query();
        $c->from="office_mento om, members m";
        $c->where("om.user_id = m.id");
        $c->where_eq('om.id', $_id);
        $res = $this->fetch_one("om.*, m.email", $c);
        return $res;
    }

    function add($_arr) {
        // $this->debug();
        $c = new Query();
        if (array_key_exists("name", $_arr) && $_arr["name"]) 
            $c->value("name", $_arr["name"]);
        if (array_key_exists("department", $_arr) && $_arr["department"]) 
            $c->value("department", $_arr["department"]);
        if (array_key_exists("position", $_arr) && $_arr["position"]) 
            $c->value("position", $_arr["position"]);
        if (array_key_exists("picture", $_arr) && $_arr["picture"]) 
            $c->value("picture", $_arr["picture"]);
        if (array_key_exists("user_id", $_arr) && $_arr["user_id"]) 
            $c->value("user_id", $_arr["user_id"]);
        if (array_key_exists("description", $_arr) && $_arr["description"]) 
            $c->value("description", $_arr["description"]);
        if (array_key_exists("hosted", $_arr) && $_arr["hosted"]) 
            $c->value("hosted", $_arr["hosted"]);
        if (array_key_exists("subject", $_arr) && $_arr["subject"]) 
            $c->value("subject", $_arr["subject"]);
        if (array_key_exists("oh_description", $_arr) && $_arr["oh_description"]) 
            $c->value("oh_description", $_arr["oh_description"]);
        if (array_key_exists("label", $_arr) && $_arr["label"]) 
            $c->value("label", $_arr["label"]);
        if (array_key_exists("hide", $_arr)) 
            $c->value("hide", $_arr["hide"]);
        
        if ($_arr["id"]) 
        {
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

    function list_($_page, $_pagesize, $_where = '', $_order = '')
    {
        // $this->debug();
        $c = new Query();
        // $c->from="office_mento o, members m";
        // $c->where("m.id = o.user_id");
        if ($_where) $c->where($_where);
        $c->page = $_page;
        $c->page_size = $_pagesize;
        if ($_order) $c->order=$_order;
        else $c->order="id DESC";
        $res = $this->fetch("*", $c);

        return $res;
    }

    function list_o($_page, $_pagesize, $_where = '', $_order = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="office_mento o, members m";
        $c->where("m.id = o.user_id");
        if ($_where) $c->where($_where);
        $c->page = $_page;
        $c->page_size = $_pagesize;
        if ($_order) $c->order=$_order;
        else $c->order="id DESC";
        $res = $this->fetch("m.name mname, m.ids, o.*", $c);

        return $res;
    }

    function cnt($_where = '')
    {
        $c = new Query();
        if ($_where) $c->where($_where);
        $res = $this->counts($c);

        return $res;
    }

    function cnt_o($_where = '')
    {
        $c = new Query();
        $c->from="office_mento o, members m";
        $c->where("m.id = o.user_id");
        if ($_where) $c->where($_where);
        $res = $this->counts($c);

        return $res;
    }

    function check_mento($_id)
    {
        $c = new Query();
        $c->where_eq("user_id", $_id);
        $res = $this->fetch_one("id", $c);

        return $res;
    }

    /* Use event_star */
    function check_star($_id, $_uid)
    {
        $c = new Query();
        $c->from="office_mento_star";
        $c->where_eq("mento_id", $_id);
        $c->where_eq("user_id", $_uid);
        $res = $this->fetch_one("id", $c);

        return $res;
    }

    function add_star($_id, $_uid, $_star)
    {
        $c = new Query();
        $c->from="office_mento_star";
        $c->value("mento_id", $_id);
        $c->value("user_id", $_uid);
        $c->value("star", $_star);
        $this->insert($c);
    }

    function get_average_star($_id)
    {
        $c = new Query();
        $c->from="office_mento_start";
        $c->where_eq("mento_id", $_id);
        $res = $this->fetch_one("IFNULL(SUM(star)/COUNT(id), 0) star, COUNT(id) cnt", $c);

        return $res;
    }

    function signout($_id)
    {
        $c = new Query();
        $c->where_eq("user_id", $_id);
        $this->delete_cond($c);
    }
 }

$current_controller->Office_mento = new Office_mento_model($settings);
?>
