<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Main_model extends Model
{
    
    var $tablename = "main";

    function list_($_order = '', $_where = '')
    {
       // $this->debug();
        $c = new Query();
        if ($_where) $c->where($_where);
        if ($_order) $c->order="id DESC";
        else $c->order="id ASC";
        return $this->fetch("*", $c);        
    }

    function edit($_id, $_type, $_cid)
    {
        $c = new Query();
        $c->value("type", $_type);
        $c->value("cid", $_cid);
        $c->where_eq("id", $_id);
        $this->update($c);
    }
}

$current_controller->Main = new Main_model($settings);
?>

