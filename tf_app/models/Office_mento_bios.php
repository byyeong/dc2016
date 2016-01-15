<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Office_mento_bios_model extends Model
{
    var $tablename = "office_mento_bios";

    function add($_id, $_b){
        $c = new Query();
        $c->value("mento_id", $_id);
        $c->value("bios", $_b);
        $this->insert($c);
    }

    function get_by_mento($_id) {
        $c = new Query();
        $c->where_eq("mento_id", $_id);
        $c->order="id ASC";
        $res = $this->fetch("*", $c);

        return $res;
    }

 }

$current_controller->Office_mento_bios = new Office_mento_bios_model($settings);
?>
