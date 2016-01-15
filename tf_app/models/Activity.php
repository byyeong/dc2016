<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Activity_model extends Model
{
    const C_TYPE_MEMBER = 1;
    const C_TYPE_STARTUP = 2;
    const A_TYPE_EVENT = 1;
    const A_TYPE_SPACE = 2;
    const A_TYPE_RECRUIT = 3;
    const A_TYPE_FOLLOW = 4;
    const A_TYPE_COMPANY = 7;
    const A_TYPE_REFERENCE = 6;
    const B_TYPE_SERVICE = 7;
    const B_TYPE_TECH = 8;
    const B_TYPE_INVESTMENT = 9;
    const B_TYPE_INCUBATING = 10;
    const E_TYPE_COMPETITION= 11;
    const E_TYPE_REFERENCE= 12;
    const O_TYPE_OFFICE_HOURS = 13; 
    const TYPE_QNA = 14;    

    var $tablename = "activity";

    function add($_arr)
    {
//        $this->debug();
        if ($_arr["com_id"]) {
            $c = new Query();
            $c->value("com_type", $_arr["com_type"]);
            $c->value("com_id", $_arr["com_id"]);
            $c->value("act_type", $_arr["act_type"]);
            $c->value("act_id", $_arr["act_id"]);
            $c->value("target_type", $_arr["target_type"]);
            $c->value("target_id", $_arr["target_id"]);
            $c->value("is_made", $_arr["is_made"]);
            $c->value("act_result", $_arr["act_result"]);
            $c->value("msg", $_arr["msg"]);
            $c->value("date_created", "now()", 1);
            $this->insert($c);

            return $this->last_id();
        }
    }

    function edit($_arr)
    {
       // $this->debug();
        $c = new Query();
        $c->where_eq("target_type", $_arr["target_type"]);
        $c->where_eq("target_id", $_arr["target_id"]);
        $c->where_eq("act_type", $_arr["act_type"]);
        $c->where_eq("act_id", $_arr["act_id"]);
        $c->where_eq("is_made", $_arr["is_made"]);
        $c->value("act_result", $_arr["act_result"]);
        $c->value("date_created", "now()", 1);
        $c->value('alarm', 0);
        $this->update($c);
    }
    
    function get_by_com($_type, $_id, $_page, $_pagesize, $_order = '', $_where = '')
    {
       // $this->debug();
        $c = new Query();
        $c->where_eq("com_type", $_type);
        $c->where_eq("com_id", $_id);
        if ($_where) $c->where ($_where);
        if ($_order) $c->order=$_order;
        else $c->order="id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $res = $this->fetch("*", $c);
        
        return $res;
    }

    function get_by_com_cnt($_type, $_id, $_where = ''){
        $c = new Query();
        $c->where_eq("com_type", $_type);
        $c->where_eq("com_id", $_id);
        if ($_where) $c->where ($_where);

        $res = $this->counts($c);

        return $res;
    }
    
    function get_a_cnt($_type, $_id, $_alarm)
    {
//        $this->debug();
        $c = new Query();
        $c->where_eq("com_type", $_type);
        $c->where_eq("com_id", $_id);
        $c->where_eq ("alarm", $_alarm);
        $res = $this->counts($c);
        
        return $res;
    }
    
    function edit_alarm($_type, $_id, $_res)
    {
        $c = new Query();
        $c->where_eq("com_type", $_type);
        $c->where_eq("com_id", $_id);
        $c->value("alarm", $_res);
        $this->update($c);
    }

    function signout($_id)
    {
        $c = new Query();
        $c->where_eq("act_id", $_id);
        $this->delete_cond($c);
    }
}

$current_controller->Activity = new Activity_model($settings);
?>
