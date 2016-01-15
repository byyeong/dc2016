<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Books_model extends Model
{
    var $tablename = "books";

    function add($_arr)
    {
       // $this->debug();
        $c = new Query();
        $c->value("dates", $_arr["dates"]);
        $c->value("times", $_arr["times"]);
        $c->value("url", $_arr["url"]);
        $c->value("img", $_arr["img"]);
        $c->value("title", str_replace('\'', '\'', $_arr["title"]));
        $c->value("subtitle", str_replace('\'', '\'', $_arr["subtitle"]));
        $c->value("author", str_replace('\'', '\'', $_arr["author"]));
        $c->value("publisher", str_replace('\'', '\'', $_arr["publisher"]));
        $c->value("c_date", $_arr["c_date"]);
        $c->value("tags", str_replace('\'', '\'', $_arr["tags"]));
        $c->value("mento_img", $_arr["mento_img"]);
        $c->value("mento_name", str_replace('\'', '\'', $_arr["mento_name"]));
        $c->value("mento_endor", str_replace('\'', '\'', $_arr["mento_endor"]));
        if ($_arr["id"]) {
            $c->where_eq("id", $_arr["id"]);
            $this->update($c);
            $id = $_REQUEST["id"];
        }
        else {
            $this->insert($c);
            $id = $this->last_id();
        }
        
        return $id;
    }
    
    function list_($_where = '', $_order = '')
    {
       // $this->debug();
        $c = new Query();
        if ($_where) $c->where($_where);
        if ($_order) $c->order=$_order; 
        else $c->order="dates ASC";
        $res = $this->fetch("*", $c);
        return $res;
    }
 }

$current_controller->Books = new Books_model($settings);
?>
