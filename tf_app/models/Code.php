<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Code_model extends Model
{
    var $tablename = "code";

    function get_by_key($_key, $_return='', $_where = '', $_order = '')
    {
       // $this->debug();
        $c = new Query();
        if ($_where) $c->where($_where);
        $c->where_eq("_key", $_key);
        if ($_order)
            $c->order=$_order;
        else
            $c->order="id ASC";
        if ($_return)
            $res = $this->fetch($_return, $c);
        else
            $res = $this->fetch("*", $c);
        
        return $res;
    }
    
    function get_value($_val, $_key)
    {
       // $this->debug();
        $c = new Query();
        $c->where_eq("_key", $_key);
        $c->where_eq("_value", $_val);
        $res = $this->fetch_one("*", $c);
        
        if (!$res) {
            $d = new Query();
            $d->value("_key", $_key);
            $d->value("_value", $_val);
            $this->insert($d);
            $res['id'] = $this->last_id();
        }
        return $res;
    }
    
    function set_value($_id, $_val)
    {
//        $this->debug();
        $c = new Query();
        $c->value("_value", $_val);
        $c->where_eq("id", $_id);
        $this->update($c);
    }

    function delete_c($_key, $_value)
    {
        $c = new Query();
        $c->where_eq("_key", $_key);
        $c->where_eq("_value", $_value);
        $this->delete_cond($c);
    }

    function add($_arr)
    {
        $c = new Query();
        $c->value("_key", $_arr["_key"]);
        $c->value("_value", $_arr["_value"]);

        if ($_arr["id"]) {
            $c->where_eq("id", $_arr["id"]);    
            $this->update($c);
            $id = $_arr["id"];
        }
        else {
            $this->insert($c);
            $id = $this->last_id();
        }
        return $id;
    }

    function ins($_arr)
    {
        $c = new Query();
        $c->where_eq("_key", $_arr["_key"]);
        $res = $this->fetch_one("id", $c);

        if ($res) {
            $_arr["id"] = $res["id"];
        }
        
        $this->add($_arr);
    }

    function check($_key, $_val)
    {
        $c = new Query();
        $c->where_eq("_key", $_key);
        $c->where_eq("_value", $_val);
        $res = $this->fetch_one("*", $c);

        return $res["id"];
    }
 }

$current_controller->Code = new Code_model($settings);
?>
