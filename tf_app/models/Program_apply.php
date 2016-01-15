<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Program_apply_model extends Model
{
    var $tablename = "program_apply";

    function add($_arr)
    {
        // $this->debug();
        $c = new Query();
        if(array_key_exists('program_id',$_arr) && $_arr["program_id"]) 
            $c->value ("program_id", $_arr["program_id"]);
        if(array_key_exists('user_id',$_arr) && $_arr["user_id"]) 
            $c->value ("user_id", $_arr["user_id"]);
        if(array_key_exists('win',$_arr)) 
            $c->value ("win", $_arr["win"]);
        if(array_key_exists('f_name',$_arr)) 
            $c->value ("f_name", $_arr["f_name"]);
        if(array_key_exists('f_tel',$_arr)) 
            $c->value ("f_tel", $_arr["f_tel"]);
        if(array_key_exists('f_email',$_arr)) 
            $c->value ("f_email", $_arr["f_email"]);
        if(array_key_exists('f_t_des',$_arr)) 
            $c->value ("f_t_des", $_arr["f_t_des"]);
        if(array_key_exists('f_des',$_arr)) 
            $c->value ("f_des", $_arr["f_des"]);
        if(array_key_exists('f_team',$_arr)) 
            $c->value ("f_team", $_arr["f_team"]);
        if(array_key_exists('f_service',$_arr)) 
            $c->value ("f_service", $_arr["f_service"]);
        if(array_key_exists('f_s_des',$_arr)) 
            $c->value ("f_s_des", $_arr["f_s_des"]);

        if ($_arr["id"]) {
            $c->where_eq("id", $_arr["id"]);
            $this->update($c);
            $_id = $_arr["id"];
        }
        else {
            $c->value("date_created", "now()", 1);
            $this->insert($c);
            $_id = $this->last_id();
        }
        return $_id;
    }
    
    function get($_id)
    {
//        $this->debug();
        $c = new Query();
        $c->from="program_apply ca LEFT OUTER JOIN members m 
                ON ca.user_id = m.id";
        $c->where_eq("ca.id", $_id);
        $res = $this->fetch_one("ca.*, m.ids, m.name, m.picture, m.id mid, m.email", $c);
        return $res;
    }
            
    function get_by_user($_comp, $_user)
    {
//        $this->debug();
        $c = new Query();
        $c->where_eq("user_id", $_user);
        $c->where_eq("program_id", $_comp);
        $res = $this->fetch_one("id", $c);
        
        return $res;
    }
    
    function get_by_user_all($_page, $_pagesize, $_user)
    {
        // $this->debug();
        $c = new Query();
        $c->from="program_apply ca, program c";
        $c->where("ca.program_id = c.id");
        $c->where_eq("ca.user_id", $_user);
        $c->order="ca.id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $res = $this->fetch("c.*, ca.id caid", $c);
        
        return $res;
    }

    function get_by_user_cnt($_user)
    {
//        $this->debug();
        $c = new Query();
        $c->from="program_apply ca, program c";
        $c->where("ca.program_id = c.id");
        $c->where_eq("ca.user_id", $_user);
        $c->order="ca.id DESC";
        $res = $this->counts($c);
        
        return $res;
    }
            
    function list_($_page, $_pagesize, $_where = '', $_order = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="program_apply ca, members m";
        $c->where("ca.user_id = m.id");
        if ($_where) $c->where($_where);
        if ($_order) $c->order=$_order;
        else $c->order = "ca.id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $res = $this->fetch("ca.*, m.ids, m.name, m.email memail, m.bio, m.picture", $c);
        
        return $res;
    }

    function list_out($_page, $_pagesize, $_where = '', $_order = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="program_apply ca LEFT OUTER JOIN members m 
                ON ca.user_id = m.id";
        if ($_where) $c->where($_where);
        if ($_order) $c->order=$_order;
        else $c->order = "ca.id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $res = $this->fetch("ca.*, m.ids, m.name, m.email memail, m.bio, m.picture", $c);
        
        return $res;
    }

    function list_info($_page, $_pagesize, $_where = '', $_user = '', $_order = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="program_scoring cs RIGHT OUTER JOIN program_apply ca ON cs.apply_id = ca.id";
        if ($_where) $c->where($_where);
        if ($_user) $c->where_eq("cs.user_id", $_user);
        if ($_order) $c->order=$_order;
        else $c->order = "ca.id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $c->group="ca.id";
        $res = $this->fetch("IFNULL(SUM(score), 0) score, ca.*", $c);
        
        return $res;
    }

    function list_info_by_user($_page, $_pagesize, $_where = '', $_user = '', $_order = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="(SELECT * FROM program_apply ca WHERE ".$_where.") a 
            LEFT OUTER JOIN 
            (SELECT IFNULL(SUM(score), 0) s, apply_id FROM program_scoring WHERE user_id = ".$_user." GROUP BY apply_id) b 
            ON a.id = b.apply_id";
        if ($_order) $c->order=$_order;
        else $c->order = "id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $res = $this->fetch("*, IFNULL(s, 0) score", $c);
        
        return $res;
    }

    function list_all($_page, $_pagesize, $_where = '', $_order = '')
    {
        $c = new Query();
        $c->from="program_apply ca, members m, program c";
        $c->where("c.user_id = m.id");
        $c->where("ca.program_id = c.id");
        if ($_where) $c->where($_where);
        if ($_order) $c->order=$_order;
        else $c->order = "ca.id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $res = $this->fetch("ca.*, m.ids, m.name, m.email memail, m.bio, c.id cid, c.subject, c.img", $c);
        
        return $res;
    }
    
    function cnt($_where = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="program_apply ca, members m";
        $c->where("ca.user_id = m.id");
        if ($_where) $c->where($_where);
        $res = $this->counts($c);
        
        return $res;
    }

    function cnt_out($_where = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="program_apply ca LEFT OUTER JOIN members m 
                ON ca.user_id = m.id";
        if ($_where) $c->where($_where);
        $res = $this->counts($c);
        
        return $res;
    }

    function get_current($_id, $_comp, $_type, $_where = '')
    {
        $c = new Query();
        if ($_type) {
            $c->where ("id > ".$_id);
            $c->order="id ASC";
        }
        else { 
            $c->where ("id < ".$_id);
            $c->order="id DESC";
        }
        if ($_where) $c->where($_where);
        $c->where_eq("program_id", $_comp);
        $c->limit=1;
        $res = $this->fetch_one("id", $c);
        
        return $res;
    }

    function get_promotions($_id)
    {
        // $this->debug();
        $c = new Query();
        $c->from="program_apply ca, members m, startup s";
        $c->where("ca.user_id = m.id");
        $c->where("ca.team = s.id");
        $c->where_eq("program_id", $_id);
        $c->order="id ASC";
        $res = $this->fetch("m.ids, m.name, m.email, s.id, s.name sname, ca.file, ca.form, ca.date_created", $c);

        return $res;
    }

    function signout($_id)
    {
        $c = new Query();
        $c->where_eq("user_id", $_id);
        $this->delete_cond($c);
    }
 }

$current_controller->Program_apply = new Program_apply_model($settings);
?>
