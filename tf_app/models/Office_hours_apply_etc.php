<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Office_hours_apply_etc_model extends Model
{
    var $tablename = "office_hours_apply_etc";

    function add($_arr)
    {
        $this->debug();
        $c = new Query();
        $c->value("apply_id", $_arr["apply_id"]);
        $c->value("form_id", $_arr["form_id"]);
        $c->value("contents", $_arr["contents"]);
        $this->insert($c);
    }

    function get_by_form($_aid, $_eid)
    {
        // $this->debug();
        $c = new Query();
        $c->where_eq("apply_id", $_aid);
        $c->where_eq("form_id", $_eid);
        $res = $this->fetch_one("*", $c);

        return $res;
    }
 }

$current_controller->Office_hours_apply_etc = new Office_hours_apply_etc_model($settings);
?>
