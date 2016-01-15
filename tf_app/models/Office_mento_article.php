<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Office_mento_article_model extends Model
{
    var $tablename = "office_mento_article";

    function add($_id, $_an, $_al){
        $c = new Query();
        $c->value("mento_id", $_id);
        $c->value("title", $_an);
        $c->value("url", $_al);
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

$current_controller->Office_mento_article = new Office_mento_article_model($settings);
?>
