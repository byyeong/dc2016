<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Program_model extends Model
{
    var $tablename = "program";

    function add($_arr)
    {
        $c = new Query();
        if (array_key_exists("user_id", $_arr)) 
            $c->value("user_id", $_arr["user_id"]);
        if (array_key_exists("cat_id", $_arr)) 
            $c->value("cat_id", $_arr["cat_id"]); 
        if (array_key_exists("agency", $_arr)) 
            $c->value("agency", $_arr["agency"]);
        if (array_key_exists("title", $_arr)) 
            $c->value("title", $_arr["title"]);
        if (array_key_exists("a_start", $_arr)) 
            $c->value("a_start", $_arr["a_start"]);
        if (array_key_exists("a_end", $_arr)) 
            $c->value("a_end", $_arr["a_end"]);
        if (array_key_exists("cnt", $_arr)) 
            $c->value("cnt", $_arr["cnt"]);
        if (array_key_exists("summary", $_arr)) 
            $c->value("summary", $_arr["summary"]);
        if (array_key_exists("content", $_arr)) 
            $c->value("content", $_arr["content"]);
        if (array_key_exists("tel", $_arr)) 
            $c->value("tel", $_arr["tel"]);
        if (array_key_exists("addr", $_arr)) 
            $c->value("addr", $_arr["addr"]);
        if (array_key_exists("file", $_arr)) 
            $c->value("file", $_arr["file"]);
        if (array_key_exists("filename", $_arr)) 
            $c->value("filename", $_arr["filename"]);
        if (array_key_exists("basic", $_arr)) 
            $c->value("basic", $_arr["basic"]);
        if (array_key_exists("status", $_arr)) 
            $c->value("status", $_arr["status"]);
        if (array_key_exists("status_des", $_arr)) 
            $c->value("status_des", $_arr["status_des"]);
        if (array_key_exists("open", $_arr)) 
            $c->value("open", $_arr["open"]);
        if (array_key_exists("app", $_arr)) 
            $c->value("app", $_arr["app"]);

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
        $c = new Query();
        $c->from="program c, program_category pc";
        $c->where("pc.id = c.cat_id");
        $c->where_eq("c.id", $_id);
        $res = $this->fetch_one("c.*, pc.category", $c);

        return $res;
    }

    function get_by_user($_page, $_pagesize, $_id)
    {
        $c = new Query();
        $c->where_eq("user_id", $_id);
        $c->order="id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $res = $this->fetch("*", $c);
        
        return $res; 
    }
    
    function get_by_user_cnt($_id)
    {
        $c = new Query();
        $c->where_eq("user_id", $_id);
        $res = $this->counts($c);
        
        return $res; 
    }

    function get_list($_page, $_pagesize, $_where = '', $_order = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="program c, members m, program_category pc";
        $c->where("c.user_id = m.id");
        $c->where("pc.id = c.cat_id");
        if ($_where) $c->where ($_where);
        if ($_order) $c->order=$_order;
        else $c->order = "c.id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $res = $this->fetch("c.*, m.name, m.ids, m.picture, pc.category, m.email memail", $c);
        
        return $res;
    }

    function get_list_cnt($_where = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="program c, members m, program_category pc";
        $c->where("c.user_id = m.id");
        $c->where("pc.id = c.cat_id");
        if ($_where) $c->where ($_where);
        $res = $this->counts($c);
        
        return $res;
    }

    function search($_page, $_pagesize, $_key)
    {
        $c = new Query();
        $c->from = "program c, members m, program_category pc";
        $c->where("c.user_id = m.id");
        $c->where("pc.id = c.cat_id");
        $c->where("(c.title like '%".$_key."%' or c.summary like '%".$_key."%'
                or c.content like '%".$_key."%')");
        $c->where_eq("open", 1);
        $c->where_eq("status", 1);
        $c->order = "id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;

        $res = $this->fetch("c.id, c.title, c.summary, c.agency, c.a_start, c.a_end, c.img, DATE_FORMAT(c.date_created, '%Y-%m-%d') date_created, pc.category category, m.name", $c);

        return $res;

    }

    function get_by_search_cnt($_key){
        $c = new Query();
        $c->from = "program";
        $c->where("(title like '%".$_key."%' or summary like '%".$_key."%'
                or content like '%".$_key."%')");
        $c->where_eq("open", 1);
        $c->where_eq("status", 1);

        $res = $this->counts($c);

        return $res;
    }

    function add_picture($_id, $_pic)
    {
        $c = new Query();
        $c->value("img", $_pic);
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

// Bacup_category

    function get_category($_where = '')
    {
        $c = new Query();
        $c->from="program_category";
        if ($_where) $c->where ($_where);
        $res = $this->fetch("*", $c);

        return $res;
    }

    function add_category($_arr)
    {
        // $this->debug();
        $c = new Query();
        $c->from="program_category";
        $c->value("category", $_arr["category"]);
        $c->value("visible", $_arr["visible"]);
        if ($_arr["id"]) {
            $c->where_eq("id", $_arr["id"]);
            $this->update($c);
            $_id = $this->last_id();
        }
        else {
            $this->insert($c);
            $_id = $_arr["id"];
        }
        return $_id;
    }

    function get_category_one($_id)
    {
        $c = new Query();
        $c->from="program_category";
        $c->where_eq("id", $_id);
        $res = $this->fetch_one("*", $c);

        return $res;
    }

    function get_hot($_page, $_pagesize, $_where = '')
    {
        $c = new Query();
        $c->from="program p LEFT OUTER JOIN (SELECT COUNT(id) cnt, program_id FROM program_apply GROUP BY program_id) a ON p.id = a.program_id";
        if ($_where) $c->where ($_where);
        if ($_order) $c->order=$_order;
        else $c->order = "a.cnt DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $res = $this->fetch("p.*", $c);
        
        return $res;
    }

}

$current_controller->Program = new Program_model($settings);
?>
