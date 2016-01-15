<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Faq_model extends Model
{
    var $tablename = "faq";

    function add($_arr)
    {
        // $this->debug();
        $c = new Query();
        if (array_key_exists("type", $_arr)) $c->value("type", $_arr["type"]);
        if (array_key_exists("title", $_arr)) $c->value("title", $_arr["title"]);
        if (array_key_exists("content", $_arr)) $c->value("content", $_arr["content"]);
        if (array_key_exists("open", $_arr)) $c->value("open", $_arr["open"]);

        if (array_key_exists("user_id", $_arr)) $c->value("user_id", $_arr["user_id"]);
        if (array_key_exists("name", $_arr)) $c->value("name", $_arr["name"]);
        if (array_key_exists("tel", $_arr)) $c->value("tel", $_arr["tel"]);
        if (array_key_exists("email", $_arr)) $c->value("email", $_arr["email"]);
        if (array_key_exists("cat", $_arr)) $c->value("cat", $_arr["cat"]);
        if (array_key_exists("parent", $_arr)) $c->value("parent", $_arr["parent"]);
        if (array_key_exists("re_suc", $_arr)) $c->value("re_suc", $_arr["re_suc"]);

        if ($_arr["id"]) {
            $c->where_eq("id", $_arr["id"]);
            $this->update($c);
            $id = $_arr["id"];
        }
        else {
            $c->value("date_created", "now()", 1);
            if ($_arr["type"] == 1) {
                $c->value("ord", $this->max_ord() + 1);
            }
            $this->insert($c);
            $id = $this->last_id();
        }
        
        return $id;
    }
    
    function list_($_type, $_page, $_pagesize, $_where = '', $_order = '')
    {
        $c = new Query();
        $c->from="faq f, faq_category c";
        $c->where("f.cat = c.id");
        $c->where_eq("type", $_type);
        if ($_where) $c->where($_where);
        $c->page = $_page;
        $c->page_size = $_pagesize;
        if ($_order) $c->order=$_order; 
        else $c->order="id DESC";
        $res = $this->fetch("f.*, c.category", $c);
        
        return $res;
    }

    function cnt($_where = '', $_type = '')
    {
        $c = new Query();
        $c->from="faq f, faq_category c";
        $c->where("f.cat = c.id");
        if ($_type == 2) {
            $c->from="faq f, faq_category c";
            $c->where("f.cat = c.id");
        }
        if ($_type) $c->where_eq("type", $_type);
        if ($_where) $c->where($_where);
        $res = $this->counts($c);
        return $res;
    }

    function get_reply($_id)
    {
        $c = new Query();
        $c->where_eq("parent", $_id);
        $res = $this->fetch_one("*", $c);

        return $res;
    }

    function max_ord()
    {
        $c = new Query();
        $res = $this->fetch_one("MAX(ord) ord", $c);
        if ($res)
            return $res["ord"];
        else
            return 1;
    }

    function min_ord()
    {
        $c = new Query();
        $res = $this->fetch_one("MIN(ord) ord", $c);
        if ($res)
            return $res["ord"];
        else
            return 1;
    }

    function get_order($_ord, $_type)
    {
        $c = new Query();
        if ($_type) {
            $c->where("ord > ". $_ord);
            $c->order="ord ASC";
        }
        else {
            $c->where("ord < ". $_ord);
            $c->order="ord DESC";
        }
        $c->limit=1;
        $res = $this->fetch_one("ord", $c);
        return $res["ord"];
    }

    function reorder($_id, $_ord, $_type)
    {
        if (! $_type && $_ord == $this->min_ord() ) {
            return;
        }

        if ($_type && $this->max_ord() <= $_ord) {
            return;
        }

        if ($_type) {
            // +
            $p = $this->get_order($_ord, 1);

            $b = new Query();
            $b->value("ord", 0);
            $b->where_eq("ord", $p);
            $this->update($b);

            $c = new Query();
            $c->value("ord", $p);
            $c->where_eq("id", $_id);
            $this->update($c);

            $d = new Query();
            $d->value("ord", $_ord);
            $d->where_eq("ord", 0);
            $this->update($d);

        }
        else {
            // -
            $m = $this->get_order($_ord, 0);

            $b = new Query();
            $b->value("ord", 0);
            $b->where_eq("ord", $m);
            $this->update($b);

            $c = new Query();
            $c->value("ord", $m);
            $c->where_eq("id", $_id);
            $this->update($c);

            $d = new Query();
            $d->value("ord", $_ord);
            $d->where_eq("ord", 0);
            $this->update($d);
        }
        
    }

    function signout($_id)
    {
        $c = new Query();
        $c->where_eq("user_id", $_id);
        $this->delete_cond($c);
    }

//Q&A category
    function add_category($_arr) 
    {
        $c = new Query();
        $c->from="faq_category";
        $c->value("category", $_arr["category"]);
        $c->value("user_id", $_arr["user_id"]);
        $c->value("c_type", $_arr["c_type"]);
        if ($_arr["id"]) {
            $c->where_eq("id", $_arr["id"]);
            $this->update($c);
            $id = $_REQUEST["id"];
        }
        else {
            $this->insert($c);
            $id = $this->last_id();
        }
        
        return $id;
    }

    function get_category($_id, $_type)
    {
        $c = new Query();
        if ($_type == 2) {
            $c->from="faq_category c, members m";
            $c->where("m.id = c.user_id");
            $c->where_eq("c.id", $_id);
        }
        else {
            $c->from="faq_category c";
            $c->where_eq("id", $_id);
        }
        $c->where_eq("c_type", $_type);
        if ($_type == 2) {
            $res = $this->fetch_one("c.*, m.ids, m.name, m.gender, m.birth, m.tel, m.email", $c);
        }
        else {
            $res = $this->fetch_one("*", $c);   
        }
        return $res;
    }


    function list_category($_page, $_pagesize, $_type = '', $_where = '', $_order = '')
    {
        $c = new Query();
        if ($_type == 2) {
            $c->from="faq_category c, members m";
            $c->where("m.id = c.user_id");
        }
        else {
            $c->from="faq_category c";
        }
        if ($_type) $c->where_eq("c_type", $_type);
        if ($_where) $c->where($_where);
        $c->page = $_page;
        $c->page_size = $_pagesize;
        if ($_order) $c->order=$_order; 
        else $c->order="id DESC";
        if ($_type == 2) 
            $res = $this->fetch("c.*, m.ids, m.name, m.gender, m.birth, m.tel", $c);
        else
            $res = $this->fetch("*", $c);

        return $res;
    }

    function cnt_category($_type = '', $_where = '')
    {
        $c = new Query();
        if ($_type == 2) {
            $c->from="faq_category c, members m";
            $c->where("m.id = c.user_id");
        }
        else {
            $c->from="faq_category c";
        }
        if ($_type) $c->where_eq("c_type", $_type);
        if ($_where) $c->where($_where);
        $res = $this->counts($c);
        return $res;
    }

    function del_category($_id)
    {
        $c = new Query();
        $c->from="faq_category";
        $c->where_eq("id", $_id);
        $this->delete_cond($c);
    }

    function check_cat_u($_id, $_cat = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="faq_category";
        $c->where_eq("user_id", $_id);
        if ($_cat) $c->where_eq("id", $_cat);
        $res = $this->fetch_one("id", $c);

        return $res["id"];
    }
 }

$current_controller->Faq = new Faq_model($settings);
?>
