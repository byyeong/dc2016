<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Competitions_model extends Model
{
    var $tablename = "competitions";

    function add($_arr)
    {
       // $this->debug();
        $c = new Query();
        if(array_key_exists('status',$_arr)) 
            $c->value ("status", $_arr["status"]);
        if(array_key_exists('status_des',$_arr)) 
            $c->value ("status_des", $_arr["status_des"]);
        if(array_key_exists('user_id',$_arr) && $_arr["user_id"]) 
            $c->value ("user_id", $_arr["user_id"]);
        if(array_key_exists('subject',$_arr) && $_arr["subject"]) 
            $c->value ("subject", $_arr["subject"]);
        if(array_key_exists('organized',$_arr) && $_arr["organized"]) 
            $c->value ("organized", $_arr["organized"]);
        if(array_key_exists('date_s',$_arr) && $_arr["date_s"]) 
            $c->value ("date_s", $_arr["date_s"]);
        if(array_key_exists('date_e',$_arr) && $_arr["date_e"]) 
            $c->value ("date_e", $_arr["date_e"]);
        if(array_key_exists('time_s',$_arr) && $_arr["time_s"]) 
            $c->value ("time_s", $_arr["time_s"]);
        if(array_key_exists('time_e',$_arr) && $_arr["time_e"]) 
            $c->value ("time_e", $_arr["time_e"]);
        if(array_key_exists('announce_d',$_arr) && $_arr["announce_d"])
            $c->value ("announce_d", $_arr["announce_d"]);
        if(array_key_exists('announce_t',$_arr) && $_arr["announce_t"])
            $c->value ("announce_t", $_arr["announce_t"]);
        if(array_key_exists('public',$_arr)) 
            $c->value ("public", $_arr["public"]);
        if(array_key_exists('contents',$_arr) && $_arr["contents"]) 
            $c->value ("contents", $_arr["contents"]);
        if(array_key_exists('summary',$_arr) && $_arr["summary"]) 
            $c->value ("summary", $_arr["summary"]);
        if(array_key_exists('img',$_arr) && $_arr["img"]) 
            $c->value ("img", $_arr["img"]);
        if(array_key_exists('file',$_arr) && $_arr["file"]) 
            $c->value ("file", str_replace(" ", "", $_arr["file"]));
        if(array_key_exists('platform',$_arr)) 
            $c->value ("platform", $_arr["platform"]);
        if(array_key_exists('platform_out',$_arr) && $_arr["platform_out"]) 
            $c->value ("platform_out", $_arr["platform_out"]);
        if(array_key_exists('open',$_arr)) 
            $c->value ("open", $_arr["open"]);
        if(array_key_exists('score',$_arr) && $_arr["score"]) 
            $c->value ("score", $_arr["score"]);
        if(array_key_exists('form',$_arr) && $_arr["form"]) 
            $c->value ("form", rtrim(ltrim($_arr["form"])));
        if(array_key_exists('winner',$_arr)) 
            $c->value ("winner", $_arr["winner"]);
        if(array_key_exists('winner_open',$_arr)) 
            $c->value ("winner_open", $_arr["winner_open"]);

        if(array_key_exists('url',$_arr) && $_arr["url"]) 
            $c->value ("url", $_arr["url"]);
        if(array_key_exists('parent',$_arr)) 
            $c->value ("parent", $_arr["parent"]);
        if(array_key_exists('did',$_arr) && $_arr["did"]) 
            $c->value ("did", $_arr["did"]);
        if(array_key_exists('department',$_arr) && $_arr["department"]) 
            $c->value ("department", $_arr["department"]);
        if(array_key_exists('logined',$_arr) && $_arr["logined"]) 
            $c->value ("logined", $_arr["logined"]);
        if(array_key_exists('top_img',$_arr) && $_arr["top_img"]) 
            $c->value ("top_img", $_arr["top_img"]);
        if(array_key_exists('top_title',$_arr) && $_arr["top_title"]) 
            $c->value ("top_title", $_arr["top_title"]);
        if(array_key_exists('top_sub',$_arr) && $_arr["top_sub"]) 
            $c->value ("top_sub", $_arr["top_sub"]);
        if(array_key_exists('basic',$_arr)) 
            $c->value ("basic", $_arr["basic"]);
        if(array_key_exists('backing',$_arr)) 
            $c->value ("backing", $_arr["backing"]);
        if(array_key_exists('semi_cont',$_arr)) 
            $c->value ("semi_cont", $_arr["semi_cont"]);

        if ($_arr["id"]) {
            $c->where_eq("id", $_arr["id"]);
            $this->update($c);
            $_id = $_arr["id"];
        } else {
            $c->value ("date_created", "now()", 1);
            $this->insert ($c);
            $_id = $this->last_id();
        }
        return $_id;
    }
    
    function get($_id)
    {
       // $this->debug();
        $c = new Query();
        $c->from="competitions c, members m";
        $c->where("c.user_id = m.id");
        $c->where_eq("c.id", $_id);
        $res = $this->fetch_one("c.*, m.name, m.picture, m.ids, m.email memail, concat(announce_d, announce_t) announce
                , concat(date_s, time_s) sdate, concat(date_e, time_e) edate", $c);
        
        return $res;
    }

    function get_by_url($_url, $_id = '')
    {
       // $this->debug();
        $c = new Query();
        $c->from="competitions c, members m";
        $c->where("c.user_id = m.id");
        $c->where("(c.url = '".$_url."' or c.id = '".$_url."')");
        if ($_id) $c->where("c.id != ".$_id);
        $res = $this->fetch_one("c.*, m.name, m.picture, m.ids, concat(announce_d, announce_t) announce
                , concat(date_s, time_s) sdate, concat(date_e, time_e) edate", $c);
        
        return $res;
    }
            
    function add_pic($_id, $_pic, $_ext = '')
    {
        $c = new Query();
        if ($_ext)
            $c->value($_ext, $_pic);
        else 
            $c->value("img", $_pic);
        $c->where_eq("id", $_id);
        $this->update($c);
    }
    
    function add_file($_id, $_file, $_file_n = "")
    {
        $c = new Query();
        $c->value("file_url", $_file);
        $c->value("file", $_file_n);
        $c->where_eq("id", $_id);
        $this->update($c);
    }
    
    function get_list($_page, $_pagesize, $_where = '', $_order = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="competitions c, members m";
        $c->where("c.user_id = m.id");
        if ($_where) $c->where ($_where);
        if ($_order) $c->order=$_order;
        else $c->order = "c.id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $res = $this->fetch("c.*, m.name, m.ids, m.picture, concat(announce_d, announce_t) announce
                , concat(date_s, time_s) sdate, concat(date_e, time_e) edate", $c);
        
        return $res;
    }

    function search($_page = 1, $_pagesize = 10, $_key)
    {
        //$this->debug();
        $c = new Query();
        $c->from = "competitions c, members m";
        $c->where("c.user_id = m.id");
        $c->where("(c.subject like '%".$_key."%' or c.summary like '%".$_key."%')");
        $c->where_eq("c.status", 1);
        $c->order = "c.id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;

        $res = $this->fetch("c.id, c.subject, c.organized, c.img, DATE_FORMAT(c.date_created, '%Y-%m-%d') date_created, concat(c.announce_d, c.announce_t) announce, concat(c.date_s, c.time_s) sdate, concat(c.date_e, c.time_e) edate, m.name", $c);

        return $res;
    }

    function get_by_search_cnt($_key){
        $c = new Query();
        $c->from = "competitions";
        $c->where("(subject like '%".$_key."%' or summary like '%".$_key."%')");
        $c->where_eq("status", 1);

        $res = $this->counts($c);

        return $res;
    }
    
    function get_by_user($_page, $_pagesize, $_id)
    {
        $c = new Query();
        $c->where_eq("user_id", $_id);
        $c->order="id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $res = $this->fetch("*, concat(announce_d, announce_t) announce, concat(date_s, time_s) sdate, concat(date_e, time_e) edate", $c);
        
        return $res; 
    }
    
    function get_by_user_cnt($_id)
    {
        $c = new Query();
        $c->where_eq("user_id", $_id);
        $res = $this->counts($c);
        
        return $res; 
    }

    function cnt($_where = '')
    {
        $c = new Query();
        if($_where) $c->where($_where);
        $res = $this->counts($c);
        
        return $res;
    }

    function pageview($_id)
    {
        $c = new Query;
        $c->value("v_cnt", "v_cnt+1", 1);
        $c->where_eq("id", $_id);
        $this->update($c);
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

    function get_department_group($_id)
    {
        $c = new Query();
        $c->where_eq("did", $_id);
        $c->order="id ASC";
        $res = $this->fetch("department", $c);

        return $res;        
    }

    function get_group($_id)
    {
        // $this->debug();
        $c = new Query();
        $c->where_eq("parent", $_id);
        $res = $this->fetch("*", $c);

        return $res;
    }

    function set_ex_confirm($_id)
    {
        //$this->debug();
        $c = new Query();
        $c->value("ex_confirm", 1);
        $c->where_eq("id", $_id);
        $this->update($c);
    }

    function edit_ex_noti($_id, $_noti)
    {
        $c = new Query();
        $c->value("ex_notice", $_noti);
        $c->where_eq("id", $_id);
        $this->update($c);
    }

    function signout($_id)
    {
        $c = new Query();
        $c->where_eq("user_id", $_id);
        $this->delete_cond($c);
    }

// competitions_a_file

    function get_a_file($_cid = '', $_fid = '')
    {
        $c = new Query();
        $c->from="competitions_a_file";
        if ($_fid) {
            $c->where_eq("id", $_fid);
            $res = $this->fetch_one("*", $c);
        }
        else {
            $c->where_eq("competitions_id", $_cid);
            $res = $this->fetch("*", $c);
        }
        return $res;
    }

    function edit_a_file($_cid, $_file, $_name)
    {
        $c = new Query();
        $c->from="competitions_a_file";
        $c->value("competitions_id", $_cid);
        $c->value("file", $_file);
        $c->value("name", str_replace(" ", "", $_name));
        $this->insert($c);
    }

    function del_a_file($_cid)
    {
        $c = new Query();
        $c->from="competitions_a_file";
        $c->where_eq("competitions_id", $_cid);
        $this->delete_cond($c);
    }

    function del_a_file_per($_cid)
    {
        $c = new Query();
        $c->from="competitions_a_file";
        $c->where_eq("id", $_cid);
        $this->delete_cond($c);
    }
}

$current_controller->Competitions = new Competitions_model($settings);
?>
