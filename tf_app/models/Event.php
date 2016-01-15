<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Event_model extends Model
{
    var $tablename = "event";

    function get($_id)
    {
//        $this->debug();
        $c = new Query();
        $c->from = "event e, space_ s";
        $c->where("e.space_id = s.id");
        $c->where_eq("e.id", $_id);
        $res = $this->fetch_one(" s.name sname, s.opt, e.*", $c);

        return $res;
    }
    
    function add($_arr)
    {
        // $this->debug();
        $c = new Query();
        $c->value("user_id", $_arr["user_id"]);
        $c->value("user_name", $_arr["user_name"]);
        $c->value("date", $_arr["date"]);
        $c->value("date_e", $_arr["date_e"]);
        $c->value("category", $_arr["category"]);
        if ($_arr["picture"]) $c->value("picture", $_arr["picture"]);
        $c->value("space_id", $_arr["space_id"]);
        $c->value("space_etc", $_arr["space_etc"]);
        $c->value("type_id", $_arr["type_id"]);
        $c->value("title", $_arr["title"]);
        $c->value("start", $_arr["start"]);
        $c->value("end", $_arr["end"]);
        if ($_REQUEST["apply_start"]) {
            $c->value("apply_start", $_REQUEST["apply_start"]." ".$_REQUEST["apply_s_time"]);
        }
        if ($_REQUEST["apply_end"]) {
            $c->value("apply_end", $_REQUEST["apply_end"]." ".$_REQUEST["apply_e_time"]);
        }
        $c->value("cnt", $_arr["cnt"]);
        $c->value("summary", $_arr["summary"]);
        $c->value("contents", $_arr["contents"]);
        $c->value("price", $_arr["price"]);
        $c->value("payment", $_arr["payment"]);
        $c->value("enroll", $_arr["enroll"]);
        $c->value("enroll_url", $_arr["enroll_url"]);
        $c->value("enroll_type", $_arr["enroll_type"]);
        $c->value("visible_list", $_arr["visible_list"]);
        $c->value("open", $_arr["open"]);
        $c->value("info_tel", $_arr["info_tel"]);
        $c->value("info_email", $_arr["info_email"]);
        $c->value("info_noti", $_arr["info_noti"]);
        $c->value("state", $_arr["state"]);
        $c->value("state_des", $_arr["state_des"]);
        $c->value("date_edited", "now()", 1);
        $c->value("is_profile", $_arr["is_profile"]);
        if ($_arr["p_space"]) $c->value("p_space", $_arr["p_space"]);
        if ($_REQUEST["id"]) {
            $c->where_eq("id", $_REQUEST["id"]);
            $this->update($c);
            
            $last = $_REQUEST["id"];
        }
        else {
            $c->value("date_created", "now()", 1);
            $this->insert($c);
            
            $last = $this->last_id();
        }
        return $last;
    }

    function search($_page, $_pagesize, $_key)
    {
        //$this->debug();
        $c = new Query();
        $c->from = "space_ s, event e members m";
        $c->where("(e.title like '%".$_key."%' or e.summary like '%".$_key."%')");
        $c->where("e.user_id = m.id");
        $c->where("e.space_id = s.id");
        $c->where_eq("state", 1);
        $c->order = "e.id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;

        $res = $this->fetch("CONCAT_WS(' ', e.date, e.start) ss, s.name sname, s.opt, e.title, e.apply_start, e.apply_end, e.cnt, e.summary, e.id, e.picture, m.name mname, DATE_FORMAT(e.date_created, '%Y-%m-%d')", $c);

        return $res;
    }

    function get_by_search_cnt($_key){
        $c = new Query();
        $c->from = "event";
        $c->where("(title like '%".$_key."%' or summary like '%".$_key."%')");
        $c->where_eq("status", 1);

        $res = $this->counts($c);

        return $res;
    }
    
    function add_picture($_id, $_pic)
    {
        $c = new Query();
        $c->value("picture", $_pic);
        $c->where_eq("id", $_id);
        $this->update($c);
    }

    function add_file($_id, $_file, $_file_name = "")
    {
        $c = new Query();
        $c->value("file", $_file);
        if ($_file_name) $c->value("filename", $_file_name);
        $c->where_eq("id", $_id);
        $this->update($c);
    }
    
    function get_detail($_id)
    {
//        $this->debug();
        $c = new Query();
        $c->from = "members m, space_ s, event_type et, event e";
        $c->where("e.user_id = m.id");
        $c->where("e.space_id = s.id");
        $c->where("e.type_id = et.id");
        $c->where_eq("e.id", $_id);
        $res = $this->fetch_one("m.id mid, m.ids, m.name mname, m.email memail, m.picture mpicture, s.name sname, s.opt, et.name ename, et.id eid ,e.*,
            (SELECT COUNT(*) FROM event_reserve WHERE event_id = ".$_id.") rcnt", $c);
        
        return $res;
    }
            
    function list_($_page, $_pagesize, $_where = '', $_is_c_cnt = '', $_order = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from = "members m, space_ s, event e, event_type et";
        $c->where("e.user_id = m.id");
        $c->where("e.space_id = s.id");
        $c->where("e.type_id = et.id");
        if ($_where) $c->where ($_where);
        if ($_order) $c->order=$_order;
        else $c->order = "e.id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        if ($_is_c_cnt) {
            $res = $this->fetch("CONCAT_WS(' ', e.date_e, e.end) ee, m.name mname, m.ids, m.picture mpicture, s.name sname, s.opt, et.name ename, et.id eid, e.*,"
                    ."(SELECT COUNT(*) FROM event_reserve WHERE event_id = e.id) rcnt", $c);
        }
        else {
            $res = $this->fetch("CONCAT_WS(' ', e.date, e.start) ss, m.name mname, m.ids, m.picture mpicture, s.name sname, s.opt, et.name ename, e.*", $c);
        }
        
        return $res;
    }
    
    function cnt($_where = '')
    {
       // $this->debug();
        $c = new Query();
        if ($_where) $c->where ($_where);
        return $this->counts($c);
    }
    
    function cnt_($_where = '')
    {
       // $this->debug();
        $c = new Query();
        $c->from = "members m, space_ s, event e, event_type et";
        $c->where("e.user_id = m.id");
        $c->where("e.space_id = s.id");
        $c->where("e.type_id = et.id");
        if ($_where) $c->where ($_where);
        return $this->counts($c);
    }

    function edit($_arr)
    {
        $c = new Query();
        $c->value("state", $_arr["state"]);
        if ($_arr["state"] == 2)
            $c->value("state_des", $_arr["state_des"]);
        else
            $c->value("state_des", "");
        $c->where_eq("id", $_arr["id"]);
        $this->update($c);
    }
    
    function get_by_date($_date)
    {
        $c = new Query();
        $c->from = "members m, space_ s, event e, event_type et";
        $c->where("e.user_id = m.id");
        $c->where("e.space_id = s.id");
        $c->where("e.type_id = et.id");
        $c->where_eq("date", $_date);
        $c->order="rcnt DESC";
        $res = $this->fetch("m.name mname, s.name sname, s.opt, et.name ename, e.*,"
                    ."(SELECT COUNT(*) FROM event_reserve WHERE event_id = e.id) rcnt", $c);
        return $res;
    }
    
    function get_by_member($_id)
    {
        $c = new Query();
        $c->from = "members m, space_ s, event e, event_type et";
        $c->where("e.user_id = m.id");
        $c->where("e.space_id = s.id");
        $c->where("e.type_id = et.id");
        $c->where_eq("e.user_id", $_id);
        $c->order="e.date_created DESC";
        $res = $this->fetch("m.name mname, s.name sname, s.opt, et.name ename, e.*,"
                    ."(SELECT COUNT(*) FROM event_reserve WHERE event_id = e.id) rcnt", $c);
        return $res;
    }
    
    function get_by_date_o_space($_where)
    {
//        $this->debug();
        $c = new Query();
        $c->from = "space_ s, event e";
        $c->where("e.space_id = s.id");
        if ($_where) $c->where ($_where);
        $res = $this->fetch("s.name sname, s.opt, e.id, e.title, e.start, e.end", $c);
        return $res;
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

    /* Use event_star */
    function check_star($_id, $_uid)
    {
        $c = new Query();
        $c->from="event_star";
        $c->where_eq("event_id", $_id);
        $c->where_eq("user_id", $_uid);
        $res = $this->fetch_one("id", $c);

        return $res;
    }

    function add_star($_id, $_uid, $_star)
    {
        $c = new Query();
        $c->from="event_star";
        $c->value("event_id", $_id);
        $c->value("user_id", $_uid);
        $c->value("star", $_star);
        $this->insert($c);
    }

    function get_average_star($_id)
    {
        $c = new Query();
        $c->from="event_star";
        $c->where_eq("event_id", $_id);
        $res = $this->fetch_one("IFNULL(SUM(star)/COUNT(id), 0) star, COUNT(id) cnt", $c);

        return $res;
    }

    function signout($_id)
    {
        $c = new Query();
        $c->where_eq("user_id", $_id);
        $this->delete_cond($c);
    }



//    function get_by_date_o_space($_date, $_space)
//    {
//        $this->debug();
//        $c = new Query();
//        $c->from = "space s, event e";
//        $c->where("e.space_id = s.id");
//        $c->where_eq("date", $_date);
//        $c->where_eq("space_id", $_space);
//        $res = $this->fetch("s.name sname, s.opt, e.title, e.start, e.end", $c);
//        return $res;
//    }
}

$current_controller->Event = new Event_model($settings);
?>
