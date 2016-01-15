<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Office_hours_apply_model extends Model
{
    var $tablename = "office_hours_apply";

    function add($_arr) {
        // $this->debug();
        $c = new Query();
        if (array_key_exists("oh_id", $_arr)) $c->value("oh_id", $_arr["oh_id"]);
        if (array_key_exists("user_id", $_arr)) $c->value("user_id", $_arr["user_id"]);
        if (array_key_exists("name", $_arr)) $c->value("name", $_arr["name"]);
        if (array_key_exists("tel", $_arr)) $c->value("tel", $_arr["tel"]);
        if (array_key_exists("email", $_arr)) $c->value("email", $_arr["email"]);
        if (array_key_exists("team", $_arr)) $c->value("team", $_arr["team"]);
        if (array_key_exists("profile_url", $_arr)) $c->value("profile_url", $_arr["profile_url"]);
        if (array_key_exists("s_subject", $_arr)) $c->value("s_subject", $_arr["s_subject"]);
        if (array_key_exists("s_description", $_arr)) $c->value("s_description", $_arr["s_description"]);
        if (array_key_exists("s_description_p", $_arr)) $c->value("s_description_p", $_arr["s_description_p"]);
        if (array_key_exists("s_description_s", $_arr)) $c->value("s_description_s", $_arr["s_description_s"]);
        if (array_key_exists("m_description", $_arr)) $c->value("m_description", $_arr["m_description"]);
        if (array_key_exists("t_description", $_arr)) $c->value("t_description", $_arr["t_description"]);
        if (array_key_exists("topic", $_arr)) $c->value("topic", $_arr["topic"]);
        if (array_key_exists("pre", $_arr)) $c->value("pre", $_arr["pre"]);
        if ($_arr["file"]) $c->value("file", $_arr["file"]);
        if ($_arr["filename"]) $c->value("filename", $_arr["filename"]);
        if (array_key_exists("file_link", $_arr)) $c->value("file_link", $_arr["file_link"]);
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

    function list_($_id, $_page, $_pagesize, $_where = '', $_order = '')
    {
        // $this->debug();
        $c = new Query();
        $c->where_eq("oh_id", $_id);
        if ($_where) $c->where($_where);
        $c->page = $_page;
        $c->page_size = $_pagesize;
        if ($_order) $c->order=$_order;
        else $c->order="id DESC";
        $res = $this->fetch("*", $c);

        return $res;
    }

    function list_u($_id, $_page, $_pagesize, $_where = '', $_order = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="office_hours_apply a, members m";
        $c->where("m.id = a.user_id");
        $c->where_eq("oh_id", $_id);
        if ($_where) $c->where($_where);
        $c->page = $_page;
        $c->page_size = $_pagesize;
        if ($_order) $c->order=$_order;
        else $c->order="id DESC";
        $res = $this->fetch("a.*, m.picture", $c);

        return $res;
    }

    function cnt($_id = '', $_where = '')
    {
        // $this->debug();
        $c = new Query();
        if ($_id) $c->where_eq("oh_id", $_id);
        if ($_where) $c->where($_where);
        $res = $this->counts($c);

        return $res;
    }

    function cnt_w_mento($_id = '', $_where = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="office_hours h, office_hours_apply a, office_mento m";
        $c->where("a.oh_id = h.id");
        $c->where("h.mento_id = m.id");
        if ($_id) $c->where_eq("oh_id", $_id);
        if ($_where) $c->where($_where);
        $res = $this->counts($c);

        return $res;
    }

    function edit_status($_arr)
    {
        // $this->debug();
        $c = new Query();
        $c->value("status", $_arr["status"]);
        $c->value("rec_desc", $_arr["rec_desc"]);
        $c->where_eq("id", $_arr["id"]);
        $res = $this->update($c);

        return $res;
    }

    function get_next($_ohid, $_id, $_opt)
    {
        // $this->debug();
        $c = new Query();
        $c->where_eq("oh_id", $_ohid);
        if ($_opt) {
            $c->where("id > ".$_id);
            $c->order="id ASC";
        }
        else {
            $c->where("id < ".$_id);
            $c->order="id DESC";
        }
        $c->limit=1;
        $res = $this->fetch_one("*", $c);

        return $res;
    }

    function get_by_user($_page, $_pagesize, $_where = '', $_order = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="office_hours h, office_hours_apply a";
        $c->where("a.oh_id = h.id");
        if ($_where) $c->where($_where);
        $c->page = $_page;
        $c->page_size = $_pagesize;
        if ($_order) $c->order=$_order;
        else $c->order="id DESC";
        $res = $this->fetch("h.*, a.id aid, a.status astatus", $c);

        return $res;
    }

    function get_by_user_oh($_id, $_user)
    {
        $c = new Query();
        $c->where_eq("oh_id", $_id);
        $c->where_eq("user_id", $_user);
        $res = $this->fetch_one("id", $c);

        return $res;
    }

    function list_by_mentor($_mid, $_page, $_pagesize)
    {
        // $this->debug();
        $c = new Query();
        $c->from="office_hours h, office_mento m, office_hours_apply a";
        $c->where("m.id = h.mento_id");
        $c->where("h.id = a.oh_id");
        $c->where_eq("h.mento_id", $_mid);
        $c->group="a.user_id";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $res = $this->fetch("a.user_id, h.mento_id", $c);
        return $res;
    }

    function list_by_mentor_cnt($_mid)
    {
        // $this->debug();
        $c = new Query();
        $c->from="office_hours h, office_mento m, office_hours_apply a";
        $c->where("m.id = h.mento_id");
        $c->where("h.id = a.oh_id");
        $c->where_eq("h.mento_id", $_mid);
        $res = $this->fetch_one("COUNT(DISTINCT(a.user_id)) cnt", $c);
        return $res["cnt"];
    }

    function get_by_mento_last($_mid, $_uid)
    {
        $c = new Query();
        $c->from="office_hours h, office_hours_apply a";
        $c->where("h.id = a.oh_id");
        $c->where_eq("mento_id", $_mid);
        $c->where_eq("user_id", $_uid);
        $c->limit=1;
        $c->order="a.id DESC";
        $res = $this->fetch_one("a.*", $c);
        return $res;
    }

    function get_hours_by_mento_user($_mid, $_uid)
    {
        // $this->debug();
        $c = new Query();
        $c->from="office_hours h, office_hours_apply a";
        $c->where("h.id = a.oh_id");
        $c->where_eq("mento_id", $_mid);
        $c->where_eq("user_id", $_uid);
        $c->order="h.id DESC";
        $res = $this->fetch("h.*, a.status astatus", $c);
        return $res;
    }

    function set_status($_id, $_ori, $_up)
    {
        $c = new Query();
        $c->where_eq("oh_id", $_id);
        $c->where_eq("status", $_ori);
        $c->value("status", $_up);
        $this->update($c);
    }

    function confirm($_oh, $_ap)
    {
        // $this->debug();
        $c = new Query();
        $c->value("confirm", 1);
        $c->where_eq("oh_id", $_oh);
        $c->where_eq("id", $_ap);
        $res = $this->update($c);

        return $res;
    }

    function signout($_id)
    {
        $c = new Query();
        $c->where_eq("user_id", $_id);
        $this->delete_cond($c);
    }
 }

$current_controller->Office_hours_apply = new Office_hours_apply_model($settings);
?>
