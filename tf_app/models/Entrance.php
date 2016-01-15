<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Entrance_model extends Model
{
    var $tablename = "entrance";
    
    function add($_arr)
    {
//        $this->debug();
        $c = new Query();
        if ($_arr["user_id"]) $c->value ("user_id", $_arr["user_id"]);
        if ($_arr["locker"] || $_arr["locker"] == 0) $c->value ("locker", $_arr["locker"]);
        if ($_arr["pass"] || $_arr["pass"] == 0) $c->value ("pass", $_arr["pass"]);
        if ($_arr["date_in"]) $c->value ("date_in", $_arr["date_in"]);
        if ($_arr["date_out"]) $c->value ("date_out", $_arr["date_out"]);
        if ($_arr["is_mailed"]) $c->value("is_mailed", 1);
        if ($_arr["id"]) {
            $c->where_eq("id", $_arr["id"]);
            $this->update($c);
        }
        else {
            $this->insert($c);
        }
    }
            
    function list_($_page = '', $_pagesize = '', $_date = '', $_where = '')
    {
       // $this->debug();
        $c = new Query();
        $c->from="entrance e, members m";
        $c->where("e.user_id = m.id");
        if ($_where) $c->where ($_where);
        if ($_date) $c->where("date_in like '".$_date."%'");
        if ($_page) $c->page = $_page;
        if ($_pagesize) $c->page_size = $_pagesize;
        $c->order = "e.id DESC";
        $res = $this->fetch("*", $c);
        
        return $res;
    }

    function list_e($_page = '', $_pagesize = '', $_date = '', $_where = '')
    {
       // $this->debug();
        $c = new Query();
        $c->from="entrance e, members m";
        $c->where("e.user_id = m.id");
        if ($_where) $c->where ($_where);
        if ($_date) $c->where("date_in like '".$_date."%'");
        if ($_page) $c->page = $_page;
        if ($_pagesize) $c->page_size = $_pagesize;
        $c->group="m.id";
        $c->order = "e.id DESC";
        $res = $this->fetch("COUNT(m.id) cnt, m.id, m.ids, m.name, m.grade, m.tel, m.email, m.date_created, m.admin_des", $c);
        
        return $res;
    }
    
    function cnt($_date = '', $_where = '')
    {
//        $this->debug();
        $c = new Query();
        $c->from="entrance e, members m";
        $c->where("e.user_id = m.id");
        if($_where) $c->where ($_where);
        if($_date) $c->where("date_in like '".$_date."%'");
        return $this->counts($c);
    }
    
    function cnt_year($_date = '', $_where = '')
    {
//        $this->debug();
        $c = new Query();
        $c->from="entrance e, members m";
        $c->where("e.user_id = m.id");
        if($_where) $c->where ($_where);
        if($_date) $c->where("date_in like '".$_date."%'");
        return $this->counts($c);
    }
            
    function locker()
    {
//        $this->debug();
        $c = new Query();
        $c->from="entrance e RIGHT JOIN locker l ON e.locker = l.locker";
        $c->order="llocker ASC";
        $res = $this->fetch("*, l.locker llocker", $c);
        
        return $res;
    }
    
    function locker_today($_date = '')
    {
//        $this->debug();
//        $c = new Query();
//        $c->from="(SELECT * FROM entrance WHERE (date_out IS NULL OR date_out = '')) e RIGHT JOIN locker l ON e.locker = l.locker";
//        $c->order="llocker ASC";
//        $res = $this->fetch("*, l.locker llocker", $c);
        
        if (!$_date) $_date = date("Y-m");
        $c = new Query();
        $c->from="(SELECT l.locker FROM (SELECT * FROM entrance WHERE (date_out IS NULL OR date_out = '')) e RIGHT JOIN locker l 
                ON e.locker = l.locker WHERE user_id IS NULL) a
                , (SELECT locker FROM (SELECT * FROM locker) a LEFT OUTER JOIN (SELECT * FROM locker_month WHERE DATE = '".$_date."' AND locker_id != 0) b 
                ON a.locker = b.locker_id  WHERE 1  AND b.locker_id IS NULL) b";
        $c->where("a.locker = b.locker");
        $c->order="llocker ASC";
        $res = $this->fetch("a.locker llocker", $c);
        
        return $res;
    }
    
    function pass()
    {
//        $this->debug();
        $c = new Query();
        $c->from="entrance e RIGHT JOIN pass p ON e.pass = p.pass";
        $c->order="ppass ASC";
        $res = $this->fetch("*, p.pass ppass", $c);
        
        return $res;
    }
    
    function pass_today()
    {
//        $this->debug();
        $c = new Query();
        $c->from="(SELECT * FROM entrance WHERE (date_out IS NULL OR date_out = '')) e RIGHT JOIN pass p ON e.pass = p.pass";
        $c->order="ppass ASC";
        $res = $this->fetch("*, p.pass ppass", $c);
        
        return $res;
    }
    
    function get_by_pass($_pass)
    {
//        $this->debug();
        $c = new Query();
        $c->from="entrance e, members m";
        $c->where("e.user_id = m.id");
//        $c->where("date_in like '".$_date."%'");
        $c->where('(date_out is NULL or date_out = "")');
        $c->where_eq("pass", $_pass);
        return $this->fetch_one("e.*, m.name, m.tel, m.membership, m.admin_des, m.gender, m.birth", $c);
    }
    
    function add_locker($_id)
    {
//        $this->debug();
        $c =  new Query();
        $c->from="locker";
        $c->value("locker", $_id);
        $this->insert($c);
    }
    
    function del_locker($_id)
    {
        $c = new Query();
        $c->from="locker";
        $c->where_eq("locker", $_id);
        $this->delete_cond($c);
    }
            
    function add_pass($_id)
    {
        $c =  new Query();
        $c->from="pass";
        $c->value("pass", $_id);
        $this->insert($c);
    }
    
    function del_pass($_id)
    {
        $c = new Query();
        $c->from="pass";
        $c->where_eq("pass", $_id);
        $this->delete_cond($c);
    }
    
    function get_by_month($_page, $_pagesize, $_date)
    {
//        $this->debug();
        $c = new Query();
        $c->from="entrance e, members m";
        $c->where("e.user_id = m.id");
        $c->where("date_in LIKE '".$_date."%'");
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $c->group="user_id";
        $c->order="cnt DESC";
        $res = $this->fetch("COUNT(*) cnt, user_id, m.id mid, m.name, m.membership, m.email, m.membership", $c);
        
        return $res;
    }
    
    function get_cnt_by_user($_user, $_where = '')
    {
//        $this->debug();
        $c = new Query();
        $c->where_eq("user_id", $_user);
        if ($_where) $c->where($_where);
        $res = $this->counts($c);
        
        return $res;
    }
    
    function get_cnt($_where = '')
    {
//        $this->debug();
        $c = new Query();
        $c->from='(SELECT id FROM entrance WHERE date_in LIKE "'.$_where.'%" GROUP BY user_id ) a';
        $res = $this->counts($c);
        
        return $res;
    }
    
    function get_by_period($_s_date, $_e_date, $_page = 1, $_pagesize = 60)
    {
//        $this->debug();
        $c = new Query();
        $c->from='(SELECT COUNT(*) cnt_a, user_id FROM entrance WHERE date_out LIKE "'.$_s_date.'%"GROUP BY user_id) a RIGHT OUTER JOIN (SELECT COUNT(*) cnt_b, user_id FROM entrance WHERE date_out < "'.$_e_date.'" AND date_out like "'.substr($_e_date, 0, 7).'%" GROUP BY user_id) b ON a.user_id = b.user_id';
        $c->order="cnt_al DESC, cnt_b DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $res = $this->fetch("a.user_id user_a, b.user_id user_b, cnt_a, cnt_b, (cnt_b*3 ), (IFNULL(cnt_a, 0) + (cnt_b*3 ))cnt_al", $c);
        
        return $res;
    }

    function check_first($_uid)
    {
        $this->debug();
        $c = new Query();
        $c->where_eq("is_mailed", 1);
        $c->where_eq("user_id", $_uid);
        $res = $this->fetch_one("id", $c);
        return $res["id"];
    }
}
$current_controller->Entrance = new Entrance_model($settings);
?>
