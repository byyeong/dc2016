<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Office_hours_apply_form_model extends Model
{
    var $tablename = "office_hours_apply_form";

    function add($_id, $_q)
    {
        // $this->debug();
        $c = new Query();
        $c->value("oh_id", $_id);
        $c->value("subject", $_q);
        $this->insert($c);
    }

    function get_by_oh($_id)
    {
        // $this->debug();
        $c = new Query();
        $c->where_eq("oh_id", $_id);
        $res = $this->fetch("*", $c);

        return $res;
    }

 }

$current_controller->Office_hours_apply_form = new Office_hours_apply_form_model($settings);
?>
