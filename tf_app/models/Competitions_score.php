<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Competitions_score_model extends Model
{
    var $tablename = "competitions_score";

    function add($_arr)
    {
        $c = new Query();
        $c->value("competition_id", $_arr["competition_id"]);
        $c->value("name", $_arr["name"]);
        $c->value("score", $_arr["score"]);
        if ($_arr["id"]) {
            $c->where_eq("id", $_arr["id"]);
            $this->update($c);
            $_id = $_arr["s_id"];
        }
        else {
            $this->insert($c);
            $_id = $this->last_id();
        }
        return $_id;
    }
    
    function get_by_comp($_id)
    {
//        $this->debug();
        $c = new Query();
        $c->where_eq("competition_id", $_id);
        $c->order="id ASC";
        $res = $this->fetch("*", $c);
        
        return $res;
    }
 }

$current_controller->Competitions_score = new Competitions_score_model($settings);
?>
