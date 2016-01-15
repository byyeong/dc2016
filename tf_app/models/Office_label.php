<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Office_label_model extends Model
{
    var $tablename = "office_label";

    function add($_label) {
        // $this->debug();
        $c = new Query();
        $c->where_eq("label", $_label);
        $res = $this->fetch_one("id", $c);
        $id = $res["id"];

        if ( ! $res) {
            $d = new Query();
            $d->value("label", $_label);
            $this->insert($d);
            $id = $this->last_id();
        }
        return $id;
    }

    function list_() {
        $c = new Query();
        return $this->fetch("*", $c);
    }

 }

$current_controller->Office_label = new Office_label_model($settings);
?>
