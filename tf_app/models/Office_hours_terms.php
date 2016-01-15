<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Office_hours_terms_model extends Model
{
    var $tablename = "office_hours_terms";

    function add($_id, $_st, $_en) {
        // $this->debug();
        $c = new Query();
        $c->value("oh_id", $_id);
        $c->value("start", $_st);
        $c->value("end", $_en);
        $this->insert($c);
    }

    function delete_by_oh($_id) {
        $c = new Query();
        $c->where_eq("oh_id", $_id);
        $this->delete_cond($c);
    }

    function get_by_oh($_id, $_where = '') {
        $c = new Query();
        $c->where_eq("oh_id", $_id);
        if ($_where) $c->where($_where);
        $c->order="id ASC";
        $res = $this->fetch("*", $c);
        return $res;
    }

    function get_by_apply($_id, $_where = '') {
        $c = new Query();
        $c->where_eq("apply_id", $_id);
        $res = $this->fetch_one("*", $c);
        return $res;
    }

    function add_apply($_id, $_oh, $_aid) {
        $c = new Query();
        $c->value("apply_id", $_aid);
        $c->where_eq("oh_id", $_oh);
        $c->where_eq("id", $_id);
        $this->update($c);
    }

    function reset($_oh, $_aid) {
        $c = new Query();
        $c->value("apply_id", "");
        $c->where_eq("oh_id", $_oh);
        $c->where_eq("apply_id", $_aid);
        $this->update($c);
    }
 }

$current_controller->Office_hours_terms = new Office_hours_terms_model($settings);
?>
