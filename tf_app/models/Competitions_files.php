<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Competitions_files_model extends Model
{
    var $tablename = "competitions_files";

    function add($_arr)
    {
        $d = new Query();
        $d->where_eq("c_file_id", $_arr["c_file_id"]);
        $d->where_eq("apply_id", $_arr["apply_id"]);
        $res = $this->fetch_one("id", $d);

        if ($res) {
            $c = new Query();
            $c->value("file", $_arr["file"]);
            $c->where_eq("id", $res["id"]);
            $this->update($c);
            $_id = $res["s_id"];
        }
        else {
            $c = new Query();
            $c->value("c_file_id", $_arr["c_file_id"]);
            $c->value("apply_id", $_arr["apply_id"]);
            $c->value("file", $_arr["file"]);
            $this->insert($c);
            $_id = $this->last_id();
        }
        
        return $_id;
    }
    
    function get_by_file_user($_id, $_user)
    {
        $c = new Query();
        $c->where_eq("c_file_id", $_id);
        $c->where_eq("apply_id", $_user);
        $res = $this->fetch_one("*", $c);
        
        return $res;
    }

    function get_by_apply($_id)
    {
        $c = new Query();
        $c->where_eq("apply_id", $_id);
        $c->order="id ASC";
        $res = $this->fetch("file", $c);
        
        return $res;
    }
 }

$current_controller->Competitions_files = new Competitions_files_model($settings);
?>
