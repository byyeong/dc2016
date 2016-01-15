<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Office_alarm_model extends Model
{
    var $tablename = "office_alarm";

    function add($_id, $_uid, $_email) {
        // $this->debug();
        $c = new Query();
        $c->value("mentor_id", $_id);
        $c->value("user_id", $_uid);
        $c->value("email", $_email);
        $this->insert($c);
    }

    function list_($_page = '', $_pagesize = '', $_where = '', $_order = '') {
        $c = new Query();
        if ($_where) $c->where($_where);
        if ($_page) $c->page = $_page;
        if ($_pagesize) $c->page_size = $_pagesize;
        if ($_order) $c->order=$_order;
        $res = $this->fetch("*", $c);
        return $res;
    }

 }

$current_controller->Office_alarm = new Office_alarm_model($settings);
?>
