<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Office_mento_form_model extends Model
{
    var $tablename = "office_mento_form";

    function add($_id, $_q)
    {
        // $this->debug();
        $c = new Query();
        $c->value("mento_id", $_id);
        $c->value("subject", $_q);
        $this->insert($c);
    }

    function get_by_mento($_id)
    {
        // $this->debug();
        $c = new Query();
        $c->where_eq("mento_id", $_id);
        $res = $this->fetch("*", $c);

        return $res;
    }
 }

$current_controller->Office_mento_form = new Office_mento_form_model($settings);
?>
