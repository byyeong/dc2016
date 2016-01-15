<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Competitions_scoring_model extends Model
{
    var $tablename = "competitions_scoring";

    function add($_arr)
    {
        $res = $this->get_scoring($_arr["user_id"], $_arr["apply_id"], $_arr["score_id"]);
        
        if ($res) {
            $d = new Query();
            $d->value("score", $_arr["score"]);
            $d->value("memo", $_arr["memo"]);
            $d->where_eq("id", $res["id"]);
            $this->update($d);
        } else {
            $d = new Query();
            $d->value("user_id", $_arr["user_id"]);
            $d->value("apply_id", $_arr["apply_id"]);
            $d->value("score_id", $_arr["score_id"]);
            $d->value("score", $_arr["score"]);
            $d->value("memo", $_arr["memo"]);
            $d->value("date_created", "now()", 1);
            $this->insert($d);
        }
    }
    
    function cnt($_where = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="competitions_score cs, competitions_scoring ci";
        $c->where("ci.score_id = cs.id");
        if ($_where) $c->where($_where);
        $res = $this->counts($c);
        
        return $res;
    }
    
    function get_score_by_apply($_where = '')
    {
//        $this->debug();
        $c = new Query();
        $c->from="competitions_score cs, competitions_scoring ci";
        $c->where("ci.score_id = cs.id");
        if ($_where) $c->where($_where);
        $c->group="apply_id";
        $res = $this->fetch("cs.id", $c);
        
        return $res;
    }
    
    function get_tot_score($_apply, $_user = '')
    {
        // $this->debug();
        $c = new Query();
        $c->where_eq("apply_id", $_apply);
        if ($_user) $c->where_eq("user_id", $_user);
        $res = $this->fetch_one("IFNULL(SUM(score), 0) score", $c);
        
        return $res["score"];
    }
  
    function get_scoring($_user, $_apply, $_score_id)
    {
       // $this->debug();
        $c = new Query();
        $c->where_eq("user_id", $_user);
        $c->where_eq("apply_id", $_apply);
        $c->where_eq("score_id", $_score_id);
        $res = $this->fetch_one("id, score, memo", $c);
        
        return $res;
    }

    function get_only_score($_apply, $_score_id)
    {
//        $this->debug();
        $c = new Query();
        $c->where_eq("apply_id", $_apply);
        $c->where_eq("score_id", $_score_id);
        $res = $this->fetch_one("IFNULL(SUM(score), 0) score", $c);
        
        return $res;
    }

    function get_score_by_comp($_comp, $_user, $_page = '', $_pagesize = '')
    {
        // $this->debug();
        $c = new Query();
        $c->where_eq("user_id", $_user);
        $c->where("score != 0 and apply_id IN (SELECT id FROM competitions_apply WHERE status = 1 and competition_id = ".$_comp.")");
        if ($_page) $c->page = $_page;
        if ($_pagesize) $c->page_size = $_pagesize;
        $c->group="apply_id";
        $res = $this->fetch("id, apply_id", $c);

        return $res;
    }

    function get_apply_by_ex_score($_comp, $_user, $_page = '', $_pagesize = '', $_param = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="competitions_scoring cs, competitions_apply ca, members m";
        $c->where("cs.apply_id = ca.id");
        $c->where("ca.user_id = m.id");
        $c->where("score != 0");
        $c->where_eq("status", 1);
        $c->where_eq("cs.user_id", $_user);
        $c->where_eq("competition_id", $_comp);
        $c->order="score DESC";
        $c->group="apply_id";
        if ($_page) $c->page = $_page;
        if ($_pagesize) $c->page_size = $_pagesize;
        if ($_param) $res = $this->fetch($_param, $c);
        else $res = $this->fetch("ca.*,SUM(score) score, m.name, m.picture", $c);
        
        return $res;
    }

    function get_apply_by_ex_score_out($_comp, $_user, $_page = '', $_pagesize = '', $_param = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="competitions_scoring cs, competitions_apply ca";
        $c->where("cs.apply_id = ca.id");
        $c->where("score != 0");
        $c->where_eq("status", 1);
        $c->where_eq("cs.user_id", $_user);
        $c->where_eq("competition_id", $_comp);
        $c->order="score DESC";
        $c->group="apply_id";
        if ($_page) $c->page = $_page;
        if ($_pagesize) $c->page_size = $_pagesize;
        if ($_param) $res = $this->fetch($_param, $c);
        else $res = $this->fetch("ca.*,SUM(score) score", $c);
        
        return $res;
    }
 }

$current_controller->Competitions_scoring = new Competitions_scoring_model($settings);
?>
