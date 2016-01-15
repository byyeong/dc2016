<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Newsletter_model extends Model
{
    var $tablename = "newsletter";

    function add($_arr)
    {
        // $this->debug();
        $c = new Query();
        if (array_key_exists("subject", $_arr)) $c->value("subject", $_arr["subject"]);
        if (array_key_exists("date", $_arr)) $c->value("date", $_arr["date"]);
        if (array_key_exists("body", $_arr)) $c->value("body", $_arr["body"]);
        if (array_key_exists("c_ids", $_arr)) $c->value("c_ids", $_arr["c_ids"]);
        if (array_key_exists("r_ids", $_arr)) $c->value("r_ids", $_arr["r_ids"]);
        if (array_key_exists("o_ids", $_arr)) $c->value("o_ids", $_arr["o_ids"]);
        if (array_key_exists("b_ids", $_arr)) $c->value("b_ids", $_arr["b_ids"]);
        
        if ($_arr["id"]) {
            $c->where_eq("id", $_arr["id"]);
            $this->update($c);
            $id = $_arr["id"];
        }
        else {
            $this->insert($c);
            $id = $this->last_id();
        }
        return $id;
    }

    function list_($_page, $_pagesize, $_where = '', $_order = '')
    {
        // $this->debug();
        $c = new Query();
        if ($_where) $c->where($_where);
        $c->page = $_page;
        $c->page_size = $_pagesize;
        if ($_order) $c->order=$_order;
        else $c->order="id DESC";
        $res = $this->fetch("*", $c);

        return $res;
    }

    function cnt($_where = '')
    {
        // $this->debug();
        $c = new Query();
        if ($_where) $c->where($_where);
        $res = $this->counts($c);

        return $res;
    }
    
    function add_cont($_n_id, $_type, $_cont_id)
    {
//        $this->debug();
        $c = new Query();
        $c->from="newsletter_cont";
        if ($_n_id) $c->value("newsl_id", $_n_id);
        if ($_type) $c->value("type", $_type);
        if ($_cont_id) $c->value("cont_id", $_cont_id);
        $this->insert($c);

        $id = $this->last_id();
        return $id;
    }

    function get_by_newsl($_id)
    {
        // $this->debug();
        $c = new Query();
        $c->from="newsletter_cont";
        $c->where_eq("newsl_id", $_id);
        $c->order="id ASC";
        $res = $this->fetch("*", $c);

        return $res;
    }

    function del_cont($_id)
    {
        // $this->debug();
        $c = new Query();
        $c->from="newsletter_cont";
        $c->where_eq("newsl_id", $_id);
        $this->delete_cond($c);
    }
    
 }

$current_controller->Newsletter = new Newsletter_model($settings);
?>
