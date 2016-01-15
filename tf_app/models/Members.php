<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Members_model extends Model
{
    var $tablename = "members";
    
    function get($_id)
    {
//        $this->debug();
        $c = new Query();
        $c->from="members m, member_grade mg";
        $c->where("m.grade = mg.id");
        $c->where_eq("m.id", $_id);
        $res = $this->fetch_one("m.utype, m.id, m.name, m.ids, m.email, m.picture, m.education, m.education_sp
            , m.education_st, m.company, m.company_role, m.bio, m.tel, m.email_rec, m.sms_rec, m.grade
            , m.state, m.state_des, m.admin_des, m.membership, m.confirm_key, m.date_created
            , m.last_edit, m.last_login, m.birth, m.gender, m.wanted, m.homepage, m.blog, m.linkedin
            , m.auto_login, m.public_act, mg.name mgname, mg.permission per", $c);
        if ($res["per"] == '1') $res["admin"] = TRUE;
        return $res;
    }
    
    function add($_arr)
    {
       // $this->debug();        
        $c = new Query();
        if($_arr["utype"]) $c->value("utype", $_arr["utype"]);
        if($_arr["ids"]) $c->value("ids", $_arr["ids"]);
        if($_arr["name"]) $c->value("name", $_arr["name"]);
        if($_arr["pwd"]) $c->value("pwd", sha256($_arr["pwd"]));
        if($_arr["email"]) $c->value("email", $_arr["email"]);
        if($_arr["birth"]) $c->value("birth", $_arr["birth"]);
        if($_arr["gender"]) $c->value("gender", $_arr["gender"]);
        $c->value("education", $_arr["education"]);
        $c->value("education_sp", $_arr["education_sp"]);
        $c->value("education_st", $_arr["education_st"]);
        if($_arr["company"]) $c->value("company", $_arr["company"]);
        if($_arr["company_role"]) $c->value("company_role", $_arr["company_role"]);
        if($_arr["bio"]) $c->value("bio", $_arr["bio"]);
        if($_arr["tel"]) $c->value("tel", $_arr["tel"]);
        $c->value("email_rec", $_arr["email_rec"]);
        $c->value("sms_rec", $_arr["sms_rec"]);
        if(array_key_exists('grade',$_arr)) $c->value("grade", $_arr["grade"]);
        if(array_key_exists('state',$_arr)) $c->value("state", $_arr["state"]);
        if($_arr["state_des"]) $c->value("state_des", $_arr["state_des"]);
        if($_arr["admin_des"]) $c->value("admin_des", $_arr["admin_des"]);
        if($_arr["last_edit"]) $c->value("last_edit", $_arr["last_edit"]);
        if(array_key_exists('wanted', $_arr)) $c->value("wanted", $_arr["wanted"]);
        if(array_key_exists('homepage', $_arr)) $c->value("homepage", $_arr["homepage"]);
        if(array_key_exists('blog', $_arr)) $c->value("blog", $_arr["blog"]);
        if(array_key_exists('linkedin', $_arr)) $c->value("linkedin", $_arr["linkedin"]);
        $c->value("public_act", $_arr["public_act"]);
        $c->value("date_edited", "now()", 1);
        if ($_arr["id"]) {
            if($_arr["picture"]) $c->value("picture", $_arr["picture"]);
            $c->where_eq("id", $_arr["id"]);
            $this->update($c);
            
            return $_arr["id"];
        }
        else if (!$_arr["id"] && $_arr["ids"]) {
            if($_arr["picture"]) $c->value("picture", $_arr["picture"]);
            else $c->value("picture", '/img/default-img-member.png');
            $confirm_key = sha256(make_code().$_arr["ids"]);
            $c->value("confirm_key", $confirm_key);
            $c->value("date_created", "now()", 1);
            $this->insert($c);

            return $res = $this->last_id();
        }
        
    }
    
    function add_picture($_id, $_pic)
    {
//        $this->debug();
        $c = new Query();
        $c->value("picture", $_pic);
        $c->where_eq("id", $_id);
        $this->update($c);
    }
            
    function list_($_page, $_pagesize, $_where = '', $_order = '')
    {
       // $this->debug();
        $c = new Query();
        $c->from="members m, member_grade mg";
        $c->where("mg.id = m.grade");
        if ($_where) $c->where ($_where);
        if ($_order) $c->order=$_order;
        else $c->order = "m.id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $res = $this->fetch("m.*, mg.name gname", $c);
        
        return $res;
    }

    function list_m($_page='', $_pagesize='', $_where = '', $_order = '')
    {
       // $this->debug();
        $c = new Query();
        if ($_where) $c->where ($_where);
        if ($_order) $c->order=$_order;
        else $c->order = "id DESC";
        if ($_page) $c->page = $_page;
        if ($_pagesize) $c->page_size = $_pagesize;
        $res = $this->fetch("*", $c);
        
        return $res;
    }
    
    function cnt($_where = '')
    {
        $c = new Query();
        $c->from="members m";
        if ($_where) $c->where($_where);
        return $this->counts($c);
    }
    
    function approve($_arr)
    {
        $c = new Query();
        $c->value("grade", $_arr["grade"]);
        $c->value("state", $_arr["state"]);
        if($_REQUEST["state"] == 2)
            $c->value ("state_des", $_arr["state_des"]);
        $c->where_eq("id", $_arr["id"]);
        $this->update($c);
    }

    function signout($_arr)
    {
        $c = new Query();
        $c->value("name", "q");
        $c->value("grade", $_arr["grade"]);
        $c->value("state", $_arr["state"]);
        if($_REQUEST["state"] == 2)
            $c->value ("state_des", $_arr["state_des"]);
        $c->value("email", "");
        $c->value("birth", "");
        $c->value("gender", "");
        $c->value("bio", "");
        $c->value("tel", "");
        $c->value("homepage", "");
        $c->value("blog", "");
        $c->value("linkedin", "");

        $c->where_eq("id", $_arr["id"]);
        $this->update($c);
    }
    
    function get_by_ids($_ids)
    {
        $c = new Query();
        $c->where_eq("ids", $_ids);
        $res = $this->fetch_one("utype, id, name, ids, email, picture, education, education_sp
            , education_st, company, company_role, bio, tel, email_rec, sms_rec, grade
            , state, state_des, membership, birth, gender, wanted, homepage, blog, linkedin
            , public_act", $c);
        
        return $res;
    }
    
    function get_by_email($_ids)
    {
//        $this->debug();
        $c = new Query();
        $c->where_eq("email", $_ids);
        $res = $this->fetch_one("utype, id, name, ids, email, picture, education, education_sp
            , education_st, company, company_role, bio, tel, email_rec, sms_rec, grade
            , state, state_des, membership, birth, gender", $c);
        
        return $res;
    }
    
    function get_by_ids2($_ids)
    {
        $c = new Query();
        $c->from="members m, startup s, startup_member sm";
        $c->where("sm.user_id = m.id");
        $c->where("sm.startup_id = s.id");
        $c->where_eq("ids", $_ids);
        $res = $this->fetch_one("m.utype, m.id, m.name, m.ids, m.email, m.picture, m.education, m.education_sp
            , m.education_st, m.company, m.company_role, m.bio, m.tel, m.email_rec, m.sms_rec, m.grade
            , m.state, membership, s.id sid, s.name sname, s.logo", $c);
        
        return $res;
    }
    
    function get_by_name($_key)
    {
        $c = new Query();
        $c->where_eq("name", $_key);
        $res = $this->fetch_one("*", $c);
        
        return $res;
    }
    
    function login($_arr)
    {
        $c = new Query();
        $c->where_eq("ids", $_arr["ids"]);
        $res = $this->fetch_one("*", $c);
        
        if (!$res) {
            $result = "error_404";
        }
        else {
            if ($res["state"] != 1) {
                $result = "error_300";
            }
            else if ($res["pwd"] == sha256($_arr["password"])) {
                $result = $res["id"];
                
                $this->log_login($res["id"]);
            }
            else if ($res["pwd"] == NULL) {
                $result = "error_200";
            }
            else {
                $result = "error_9";
            }
        }
        return $result;
    }
    
    function log_login($_id)
    {
//        $this->debug();
        $c = new Query();
        $c->value("last_login", "now()", 1);
        $c->where_eq("id", $_id);
        $this->update($c);
        
        $d = new Query();
        $d->from="log_login";
        $d->where_eq("date", date("Y-m-d"));
        $d->where_eq("user_id", $_id);
        $res = $this->fetch_one("id", $d);

        if ($res) {
            $e = new Query();
            $e->from="log_login";
            $e->value("cnt", "cnt + 1", 1);
            $e->where_eq("id", $res['id']);
            $this->update($e);
        }
        else {
            $e = new Query();
            $e->from="log_login";
            $e->value("cnt", 1);
            $e->value("user_id", $_id);
            $e->value("date", date("Y-m-d"));
            $this->insert($e);
        }
    }
    
    function find_id_by_name($_arr)
    {
        $c = new Query();
        $c->where_eq("name", $_arr["ids"]);
        $c->where_eq("email", $_arr["email"]);
        $res = $this->fetch_one("id, ids, email", $c);
        
        return $res;
    }
    
    function find_id($_arr)
    {
        $c = new Query();
        $c->where_eq("ids", $_arr["ids"]);
        $c->where_eq("email", $_arr["email"]);
        $res = $this->fetch_one("id, ids, email", $c);
        
        return $res;
    }

    function edit_pwd($_arr)
    {
        $c = new Query();
        $c->where_eq("id", $_arr["id"]);
        $res = $this->fetch_one("pwd", $c);
        
        if ($res) {
            
            if ($res["pwd"] == sha256($_REQUEST["c_pwd"])) {
                $d = new Query();
                $d->where_eq("id", $_arr["id"]);
                $d->value("pwd", sha256($_arr["pwd"]));
                $this->update($d);
                $result = 0;
            }
            else {
                $result = 9;
            }
        }
        else {
            $result = 404;
        }
        return $result;
    }
    
    function edit_pwd_by_mail($_id, $_pwd)
    {
//        $this->debug();
        $c = new Query();
        $c->value("pwd", sha256($_pwd));
        $c->where_eq("id", $_id);
        $this->update($c);
    }
    
    function get_search($_key)
    {
//        $this->debug();
        $c = new Query();
        $c->where("(ids like '".$_key."%' or name like '".$_key."%')");
        $res = $this->fetch("ids, name, email", $c);
        
        return $res;
    }
    
    function search($_page = 1, $_pagesize = 10, $_key)
    {
        // $this->debug();
        $c = new Query();
        $c->where("(name like '%".$_key."%' or ids like '%".$_key."%')");
        $c->where_eq("state", 1);
        $c->order = "id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;

        $res = $this->fetch("utype, id, name, ids, email, picture, education, education_sp
            , education_st, company, company_role, bio, tel, email_rec, sms_rec, grade
            , state, state_des, admin_des, date_created", $c);
        
        return $res;
    }

    function get_by_search_cnt($_key){
        $c = new Query();
        $c->where("(name like '%".$_key."%' or ids like '%".$_key."%')");
        $c->where_eq("state", 1);

        $res = $this->counts($c);

        return $res;
    }
    
    function get_by_key($_ids, $_key)
    {
        $c = new Query();
        $c->where_eq("ids", $_ids);
        $c->where_eq("confirm_key", $_key);
        $res = $this->fetch_one("id", $c);
        
        if ($res) {
            $d = new Query();
            $d->value("state", 1);
            $d->where_eq("ids", $_ids);
            $d->where_eq("confirm_key", $_key);
            $this->update($d);
        }
        
        return $this->get($res["id"]);
    }
    
    function search_by_entrancee($_q)
    {
       // $this->debug();
        $c = new Query();
        $c->from="members m,(SELECT id, REPLACE(tel, '-', '') phone, REPLACE(birth, '.', '') bir FROM members) p";
        $c->where("m.id = p.id");
        $c->where("name != 'q' and (ids like '%".$_q."%' or name like '%".$_q."%' or phone like '%".$_q."%' OR birth LIKE '%".$_q."%' OR bir LIKE '%".$_q."%')");
        $c->order="m.id ASC";
        $res = $this->fetch("*", $c);
        
        return $res;
    }
    
    function get_log_login($_id, $_where = '')
    {
//        $this->debug();
        $c = new Query();
        $c->from="log_login";
        $c->where_eq("user_id", $_id);
        if ($_where) $c->where ($_where);
        $res = $this->fetch_one("SUM(cnt) cnt", $c);
        
        return $res;
    }
    
    function edit_info($_id, $_key, $_value, $_q = 0)
    {
        // $this->debug();
        $c = new Query();
        $c->value($_key, $_value, $_q);
        $c->where_eq("id", $_id);
        $this->update($c);
    }
    
    function add_etc($_id, $_key, $_value)
    {
        $c = new Query();
        $c->from="member_etc";
        $c->value("user_id", $_id);
        $c->value("_key", $_key);
        $c->value("_value", $_value);
        $this->insert($c);
    }
        
    function get_etc($_where)
    {
//        $this->debug();
        $c = new Query();
        $c->from="member_etc";
        $c->where($_where);
        $c->limit=1;
        $c->order="id DESC";
        $res = $this->fetch_one("*", $c);
        
        return $res;
    }

    function log_mail($_email, $_tpl, $_contents)
    {
        $c = new Query();
        $c->from="log_mail";
        $c->value("email", $_email);
        $c->value("tpl", $_tpl);
        $c->value("contents", $_contents);
        $c->value("date_created", "now()", 1);
        $this->insert($c);
    }

    function update_by_key($_key, $_value, $_id)
    {
        $c = new Query();
        $c->value($_key, $_value);
        $c->where_eq("id", $_id);
        $this->update($c);
    }

    function dormant($_date)
    {
        $c = new Query();
        $c->value("name", "q");
        $c->value("email", "");
        $c->value("birth", "");
        $c->value("picture", "");
        $c->value("tel", "");
        $c->value("date_edited", $_date);
        $c->value("state", 3);
        $c->value("state_des", '장기휴면 계정');
        $c->where("last_login like '".$_date."%'");
        $this->update($c);
    }

    function add_login($_id)
    {
        $c = new Query();
        $c->value("last_login", "now()", 1);
        $c->where_eq("id", $_id);
        $this->update($c);
    }
}

$current_controller->Members = new Members_model($settings);
?>
