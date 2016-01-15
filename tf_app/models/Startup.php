<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Startup_model extends Model
{
    var $tablename = "startup";

    function add($_arr)
    {
       // $this->debug();
        $c = new Query();
        if ($_arr["stype"]) $c->value("stype", $_arr["stype"]);
        if ($_arr["name"]) $c->value("name", $_arr["name"]);
        if ($_arr["bio"]) $c->value("bio", $_arr["bio"]);
        if ($_arr["description"]) $c->value("description", $_arr["description"]);
        
        if ($_arr["ceo"]) $c->value("ceo", $_arr["ceo"]);
        if ($_arr["founded"]) {
            $fo = str_replace("/", ".", $_arr["founded"]);
            $fo = str_replace("-", ".", $fo);
            $c->value("founded", $fo);
        }
        if ($_arr["number"]) $c->value("number", $_arr["number"]);
        if ($_arr["website"]) $c->value("website", $_arr["website"]);
        if ($_arr["blog"]) $c->value("blog", $_arr["blog"]);
        if ($_arr["twitter"]) $c->value("twitter", $_arr["twitter"]);
        if ($_arr["facebook"]) $c->value("facebook", $_arr["facebook"]);
        if ($_arr["email"]) $c->value("email", $_arr["email"]);
        if ($_arr["tel"]) $c->value("tel", $_arr["tel"]);
        if ($_arr["addr"]) $c->value("addr", $_arr["addr"]);
        if ($_arr["bm_des"]) $c->value("bm_des", $_arr["bm_des"]);
        if ($_arr["bm_tech"]) $c->value("bm_tech", $_arr["bm_tech"]);
        if(array_key_exists("state", $_arr)) $c->value("state", $_arr["state"]);
        if($_arr["last_edit"]) $c->value("last_edit", $_arr["last_edit"]);
        if($_arr["is_rocket"]) $c->value("is_rocket", $_arr["is_rocket"]);
        if(array_key_exists("slide_1", $_arr)) $c->value("slide_1", $_arr["slide_1"]);
        if(array_key_exists("slide_2", $_arr)) $c->value("slide_2", $_arr["slide_2"]);
        if(array_key_exists("slide_3", $_arr)) $c->value("slide_3", $_arr["slide_3"]);
        if(array_key_exists("slide_4", $_arr)) $c->value("slide_4", $_arr["slide_4"]);
        $c->value("date_edited", "now()", 1);
        if ($_arr["id"]) {
            if ($_arr["logo"]) $c->value("logo", $_arr["logo"]);
            $c->where_eq("id", $_arr["id"]);
            $this->update($c);
            
            $_id = $_REQUEST["id"];
        }
        else {
            if ($_arr["name"]) {
                if ($_arr["logo"]) $c->value("logo", $_arr["logo"]);
                else $c->value("logo", '/img/default-img-company.png');
                $c->value("date_created", "now()", 1);
                $this->insert($c);

                $_id = $this->last_id();
            }
        }
        
        return $_id;
    }
    
    function add_picture($_id, $_pic)
    {
//        $this->debug();
        $c = new Query();
        $c->value("logo", $_pic);
        $c->where_eq("id", $_id);
        $this->update($c);
    }
    
    function list_($_page, $_pagesize, $_where = '', $_order = '')
    {
//        $this->debug();
        $c = new Query();
        if ($_where) $c->where ($_where);
        if ($_order) $c->order=$_order;
        else $c->order = "id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $res = $this->fetch("*", $c);
        
        return $res;
    }
    
    function cnt($_where = '')
    {
        $c = new Query();
        if ($_where) $c->where ($_where);
        return $this->counts($c);
    }
    
    function get_search($_key, $_stype = '')
    {
        $c = new Query();
        $c->where("(name like '".$_key."%' or bio like '".$_key."%' or description like '".$_key."%')");
        if ($_stype) $c->where_eq ("stype", $_stype);
        else $c->where_eq ("stype", 1);
        $c->where_eq("state", 1);
        $res = $this->fetch("*", $c);
        
        return $res;
    }
    
    function get_by_name($_key)
    {
        $c = new Query();
        $c->where_eq("name", $_key);
        $res = $this->fetch_one("*", $c);
        
        return $res;
    }
    
    function search($_page = 1, $_pagesize = 10, $_key)
    {
        //$this->debug();
        $c = new Query();
        $c->where("(name like '%".$_key."%' or bio like '%".$_key."%' or addr like '%".$_key."%')");
        $c->where_eq("state", 1);
        $c->order = "id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;

        $res = $this->fetch("*", $c);
        
        return $res;
    }

    function get_by_search_cnt($_key){
        $c = new Query();
        $c->where("(name like '%".$_key."%' or bio like '%".$_key."%' or addr like '%".$_key."%')");
        $c->where_eq("state", 1);

        $res = $this->counts($c);

        return $res;
    }
    
//    function test()
//    {
//        $c = new Query();
//        $c->where("id > 25");
//        $res = $this->fetch("id, logo", $c);
//        
//        return $res;
//    }
    
    function test2($id, $logo)
    {
        $c = new Query();
        $c->value("logo", $logo);
        $c->where_eq("id", $id);
        $this->update($c);
    }


    function test()
    {
        $c = new Query();
        $c->where("id > 4");
        $res = $this->fetch("id, logo", $c);
        
        return $res;
    }
}

$current_controller->Startup = new Startup_model($settings);
?>
