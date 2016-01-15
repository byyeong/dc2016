<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Competitions_examiner_model extends Model
{
    var $tablename = "competitions_examiner";

    function add($_arr)
    {
       // $this->debug();
        $c = new Query();
        if(array_key_exists('competition_id',$_arr) && $_arr["competition_id"]) 
                $c->value ("competition_id", $_arr["competition_id"]);
        if(array_key_exists('user_id',$_arr) && $_arr["user_id"]) 
                $c->value ("user_id", $_arr["user_id"]);
        if(array_key_exists('email',$_arr) && $_arr["email"]) 
                $c->value ("email", $_arr["email"]);
        if(array_key_exists('public',$_arr)) 
                $c->value ("public", $_arr["public"]);
        if(array_key_exists('status',$_arr)) 
                $c->value ("status", $_arr["status"]);
        if(array_key_exists('des',$_arr)) 
                $c->value ("des", $_arr["des"]);
        if ($_arr["id"]) {
            $c->where_eq("id", $_arr["id"]);
            $this->update($c);
            $_id = $_arr["s_id"];
        }
        else {
            $this->insert($c);
            $_id = $this->last_id();
        }
        return $_id;
    }
    
    function get_by_comp($_id, $_page='', $_pagesize='', $_where = '')
    {
       // $this->debug();
        $c = new Query();
        $c->from="competitions_examiner ce, members m";
        $c->where("ce.user_id = m.id");
        if ($_where) $c->where ($_where);
        $c->where_eq("competition_id", $_id);
        $c->order="ce.id DESC";
        if ($_page) $c->page = $_page;
        if ($_pagesize) $c->page_size = $_pagesize;
        $res = $this->fetch("ce.*, m.name, m.email memail, m.bio, m.picture", $c);
        
        return $res;
    }

    function get_by_comp_outer($_id, $_page='', $_pagesize='', $_where = '')
    {
       // $this->debug();
        $c = new Query();
        $c->from="competitions_examiner ce LEFT OUTER JOIN members m 
                ON ce.user_id = m.id";
        // $c->where("ce.user_id = m.id");
        if ($_where) $c->where ($_where);
        $c->where_eq("competition_id", $_id);
        $c->order="ce.id DESC";
        if ($_page) $c->page = $_page;
        if ($_pagesize) $c->page_size = $_pagesize;
        $res = $this->fetch("ce.*, m.ids, m.tel, m.name, m.email memail, m.bio, m.picture", $c);
        
        return $res;
    }
    
    function get_by_user($_id, $_where = '', $_cnt = '')
    {
       // $this->debug();
        $c = new Query();
        $c->from="competitions_examiner ce, competitions c";
        $c->where("ce.competition_id = c.id");
        $c->where_eq("ce.user_id", $_id);
        if ($_where) $c->where ($_where);
        $c->order="ce.id DESC";
        if ($_cnt) {
            $res = $this->fetch("c.*, ce.user_id euid, concat(announce_d, announce_t) announce, concat(date_s, time_s) sdate, concat(date_e, time_e) edate", $c);
        } else {
            $c->limit=1;
            $res = $this->fetch_one("c.*, ce.user_id euid, concat(announce_d, announce_t) announce, concat(date_s, time_s) sdate, concat(date_e, time_e) edate", $c);
        }

        return $res;
    }

    function get_by_user_page($_page, $_pagesize, $_id, $_where = '')
    {
//        $this->debug();
        $c = new Query();
        $c->from="competitions_examiner ce, competitions c";
        $c->where("ce.competition_id = c.id");
        $c->where_eq("ce.user_id", $_id);
        if ($_where) $c->where ($_where);
        $c->order="ce.id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $res = $this->fetch("c.*, concat(announce_d, announce_t) announce, concat(date_s, time_s) sdate, concat(date_e, time_e) edate", $c);

        return $res;
    }

    function get_by_user_cnt($_id, $_where = '')
    {
       // $this->debug();
        $c = new Query();
        $c->from="competitions_examiner ce, competitions c";
        $c->where("ce.competition_id = c.id");
        $c->where_eq("ce.user_id", $_id);
        if ($_where) $c->where ($_where);
        $c->order="ce.id DESC";
        $res = $this->counts($c);

        return $res;
    }
    
    function get_public_user($_where = '')
    {
        $c = new Query();
        $c->from="competitions_examiner ce, members m";
        $c->where("ce.user_id = m.id");
        if ($_where) $c->where($_where);
        $res = $this->fetch("m.name, m.email memail, m.bio", $c);
        
        return $res;
    }
    
    function list_($_page, $_pagesize, $_where = '', $_order = '')
    {
        $c = new Query();
        $c->from="competitions_examiner ce, members m";
        $c->where("ce.user_id = m.id");
        if ($_where) $c->where ($_where);
        if ($_order) $c->order=$_order;
        else $c->order = "ce.id ASC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $res = $this->fetch("ce.*,m.ids, m.name, m.email memail, m.bio", $c);
        
        return $res;
    }

    function list_outer($_page='', $_pagesize='', $_where = '')
    {
       // $this->debug();
        $c = new Query();
        $c->from="competitions_examiner ce LEFT OUTER JOIN members m 
                ON ce.user_id = m.id";
        if ($_where) $c->where ($_where);
        $c->order="ce.id DESC";
        if ($_page) $c->page = $_page;
        if ($_pagesize) $c->page_size = $_pagesize;
        $res = $this->fetch("ce.*, m.ids, m.tel, m.name, m.email memail, m.bio, m.picture", $c);
        
        return $res;
    }

    function list_all($_page, $_pagesize, $_where = '', $_order = '')
    {
        $c = new Query();
        $c->from="competitions_examiner ce, members m, competitions c";
        $c->where("c.user_id = m.id");
        $c->where("ce.competition_id = c.id");
        if ($_where) $c->where ($_where);
        if ($_order) $c->order=$_order;
        else $c->order = "c.id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $res = $this->fetch("c.subject, c.img, c.date_created, ce.competition_id, m.ids, m.name, m.email memail, m.bio", $c);
        
        return $res;
    }
    
    function cnt($_where)
    {
        $c = new Query();
        $c->from="competitions_examiner ce, members m";
        $c->where("ce.user_id = m.id");
        if ($_where) $c->where ($_where);
        $res = $this->counts($c);
        
        return $res;
    }

    function cnt_outer($_where)
    {
        $c = new Query();
        $c->from="competitions_examiner ce LEFT OUTER JOIN members m 
                ON ce.user_id = m.id";
        if ($_where) $c->where ($_where);
        $res = $this->counts($c);
        
        return $res;
    }
    
    function get_by_comp_user($_comp, $_user, $_where = '')
    {
        $c = new Query();
        $c->where_eq("user_id", $_user);
        $c->where_eq("competition_id", $_comp);
        if ($_where) $c->where ($_where);
        $res = $this->fetch_one("*", $c);
        
        return $res;
    }

    function get_by_comp_user_ex($_comp, $_user, $_where = '')
    {
        $c = new Query();
        $c->from="competitions_examiner ce, competitions c";
        $c->where("ce.competition_id = c.id");
        $c->where_eq("ce.user_id", $_user);
        $c->where_eq("ce.competition_id", $_comp);
        if ($_where) $c->where ($_where);
        $res = $this->fetch_one("ce.*", $c);
        
        return $res;
    }
    
    function update_by_email($_email, $_id)
    {
        $c = new Query();
        $c->value("user_id", $_id);
        $c->value("email", "");
        $c->where_eq("email", $_email);
        $res = $this->update($c);
    }

    function get_by_email($_email, $_comp)
    {
        $c = new Query();
        $c->where_eq("competition_id", $_comp);
        $c->where_eq("email", $_email);
        $res = $this->fetch_one("*", $c);

        return $res;
    }

    function check ($_arr)
    {
        $c = new Query();
        $c->where_eq("user_id", $_arr["user_id"]);
        $c->where_eq("public", 1);
        if ($_arr["email"]) $c->where_eq("email", $_arr["email"]);
        $res = $this->fetch_one("id", $c);
        return $res;
    }

    function examiner_check($_e, $_cid)
    {
        $c = new Query();
        $c->from="competitions_examiner ce LEFT OUTER JOIN members m 
                ON ce.user_id = m.id";
        $c->where("(ce.email = '".$_e."' or m.email = '".$_e."')");
        $c->where_eq("ce.competition_id", $_cid);
        $res = $this->fetch_one("competition_id AS id", $c);

        return $res;
    }

    function confirm($_id, $_pool)
    {
        //$this->debug();
        $c = new Query();
        $c->where("id NOT IN (".$_pool.")");
        $c->where_eq("competition_id", $_id);
        $this->delete_cond($c);
    }

// Competition_operator

    function operator_list($_id)
    {
        $c = new Query();
        $c->from="competitions_operator o, members m";
        $c->where("o.user_id = m.id");
        $c->where_eq("competition_id", $_id);
        $res = $this->fetch("o.*, m.name", $c);

        return $res;
    }

    function operator_by_user($_id)
    {
        $c = new Query();
        $c->from="competitions c, competitions_operator o";
        $c->where("o.competition_id = c.id");
        $c->where_eq("o.user_id", $_id);
        $res = $this->fetch("c.*", $c);

        return $res;
    }
    
    function operator_add($_arr)
    {
       // $this->debug();
        $c = new Query();
        $c->from="competitions_operator";
        if(array_key_exists('competition_id',$_arr)) 
            $c->value ("competition_id", $_arr["competition_id"]);
        if(array_key_exists('user_id',$_arr) && $_arr["user_id"]) 
            $c->value ("user_id", $_arr["user_id"]);

        if ($_arr["id"]) {
            $c->where_eq("id", $_arr["id"]);
            $this->update($c);
            $_id = $_arr["s_id"];
        }
        else {
            $this->insert($c);
            $_id = $this->last_id();
        }
        return $_id;
    }

    function operator_check($_com, $_id)
    {
        $c = new Query();
        $c->from="competitions_operator";
        $c->where_eq("user_id", $_id);
        $c->where_eq("competition_id", $_com);
        $res = $this->fetch_one("id", $c);

        return $res;
    }

    function operator_cnt($_where)
    {
        $c = new Query();
        $c->from="competitions_operator";
        if ($_where) $c->where ($_where);
        $res = $this->counts($c);
        
        return $res;
    }

    function operator_update_by_email($_email, $_id)
    {
        $c = new Query();
        $c->from="competitions_operator";
        $c->value("user_id", $_id);
        $c->value("email", "");
        $c->where_eq("email", $_email);
        $res = $this->update($c);
    }

    function operator_del($_cid, $_uid)
    {
        $c = new Query();
        $c->from="competitions_operator";
        $c->where_eq("user_id", $_uid);
        $c->where_eq("competition_id", $_cid);
        $this->delete_cond($c);
    }
 }

$current_controller->Competitions_examiner = new Competitions_examiner_model($settings);
?>
