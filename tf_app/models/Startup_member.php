<?

class Startup_member_model extends Model
{
    var $tablename = "startup_member";
    
    function add($_st, $_user, $_id = '', $_role='', $_start='', $_end='', $_is_ing='', $_state='') 
    {
        // $this->debug();
        $c = new Query();
        $c->where_eq("startup_id", $_st);
        $c->where_eq("user_id", $_user);
        $res = $this->fetch_one("id", $c);

        if ($res) $_id = $res["id"];

        $d = new Query();
        if ($_st) $d->value("startup_id", $_st);
        if ($_user) $d->value("user_id", $_user);
        if ($_role) $d->value ("role", $_role);
        if ($_start) $d->value ("start", $_start);
        if ($_end) $d->value ("end", $_end);
        if ($_state) $d->value ("status", $_state);
        $d->value ("is_ing", $_is_ing);
        if ($_id) {
            $d->where_eq("id", $_id);
            $this->update($d);
            $id = $_id;
        } else {
            $d->value("date_created", "now()", 1);
            $this->insert($d);
            $id = $this->last_id();
        }
        return $id;
    }

    function get_by_startup($_st, $_is = '', $_where = '')
    {
//        $res = $this->cache->get('st_mem_get_by_startup'.$_st.'_'.$_is.'_'.$_where);
//        
//        if (!$res) {
            $c = new Query();
            $c->from="members m, startup_member sm";
            $c->where("m.id = sm.user_id");
            if ($_is) $c->where ("status != 3");
            if ($_where) $c->where ($_where);
            $c->where_eq("startup_id", $_st);
            $c->order="status DESC, sm.id ASC";
            $res = $this->fetch("sm.id smid, sm.status, sm.role, m.id mid, m.ids, m.name, m.email memail, m.company_role, m.picture", $c);
            
//            $this->cache->set('st_mem_get_by_startup'.$_st.'_'.$_is.'_'.$_where, $res, 0);
//        }
        
        return $res;
    }

    function get_list_by_user($_id, $_where = '')
    {
       // $this->debug();
        $c = new Query();
        $c->from="members m, startup_member sm, startup s";
        $c->where("m.id = sm.user_id");
        $c->where("sm.startup_id = s.id");
        if($_where) $c->where ($_where);
        $c->where_eq("user_id", $_id);
        $c->order="is_ing DESC, start ASC";
        $res = $this->fetch("s.id, s.name sname, s.logo, s.bio, s.founded, s.number, s.email, s.description
             , sm.id smid, sm.*, m.id mid, m.ids, m.name, m.company_role, m.picture", $c);
        
        return $res;
    }
    
    function check_by_user_st($_user, $_st){
        $c = new Query();
        $c->where_eq("user_id", $_user);
        $c->where_eq("startup_id", $_st);
        return $this->fetch_one("*", $c);
    }

    function del_by_user($_user)
    {
        $c = new Query();
        $c->where_eq("user_id", $_user);
        $this->delete_cond($c);
    }

    function del_by_user_st($_id)
    {
        $c = new Query();
        $c->where_eq("id", $_id);
        $this->delete_cond($c);
    }
    
    function get_by_user($_user)
    {
        $c = new Query();
        $c->from="startup_member sm, startup s";
        $c->where("sm.startup_id = s.id");
        $c->where_eq("user_id", $_user);
        $c->order="is_ing DESC, start DESC";
        return $this->fetch_one("sm.id, s.name, s.id sid, s.logo, sm.role", $c);
    }
    
    function edit_state($_id, $_st)
    {
        $c = new Query();
        $c->value("status", $_st);
        $c->where_eq("id", $_id);
        $this->update($c);
    }
    
    function get_first($_id, $_mem, $_where)
    {
        // $res = $this->cache->get('get_first_'.$_id.'_'.$_mem);
        // if (!$res) {
            $c = new Query();
            $c->where("status = 1");
            $c->where_eq("startup_id", $_id);
            $c->where_eq("user_id", $_mem);
            if($_where) $c->where ($_where);
            $res = $this->fetch_one("*", $c);
            
        //     $this->cache->set('get_first_'.$_id.'_'.$_mem, $res, 0);
        // }
        return $res;
    }
    
    function check_member($_st, $_mem)
    {
        $c = new Query();
        $c->where_eq("startup_id", $_st);
        $c->where_eq("user_id", $_mem);
        $res = $this->fetch_one("id", $c);
        
        return $res;        
    }
    
    function get_detail($_id)
    {
//        $this->debug();
        $c = new Query();
        $c->from="startup_member sm, members m, startup s";
        $c->where("sm.user_id = m.id");
        $c->where("sm.startup_id = s.id");
        $c->where_eq("sm.id", $_id);
        $res = $this->fetch_one("m.id mid, m.name mname, m.ids, s.id sid, s.name sname", $c);
        
        return $res;
    }
    
    
// startup_member_req
    function add_req($_st, $_user, $_name, $_email, $_email_user, $_state = '', $_id = '') 
    {
//        $this->debug();
        $d = new Query();
        $d->from="startup_member_req";
        if ($_st) $d->value("startup_id", $_st);
        if ($_user) $d->value("user_id", $_user);
        if ($_name) $d->value ("name", $_name);
        if ($_email) $d->value ("email", $_email);
        if ($_email_user) $d->value ("email_user", $_email_user);
        if ($_state) $d->value ("status", $_state);
        if ($_id) {
            $d->where_eq("id", $_id);
            $this->update($d);
            $id = $_id;
        } else {
            $d->value("date_created", "now()", 1);
            $this->insert($d);
            $id = $this->last_id();
        }
        return $id;
    }
    
    function get_by_startup_req($_st, $_where = '')
    {
        $c = new Query();
        $c->from="startup_member_req";
        if ($_where) $c->where ($_where);
        $c->where_eq("startup_id", $_st);
        $c->order="id ASC";
        $res = $this->fetch("*", $c);
        return $res;
    }
    
    function get_by_email_req($_email, $_where = '')
    {
        $c = new Query();
        $c->from="startup_member_req";
        if ($_where) $c->where ($_where);
        $c->where_eq("email", $_email);
        $c->order="id ASC";
        $res = $this->fetch("*", $c);
        return $res;
    }
    
    function check_by_user_st_req($_user, $_st)
    {
        $c = new Query();
        $c->from="startup_member_req";
        $c->where_eq("email", $_user);
        $c->where_eq("startup_id", $_st);
        return $this->fetch_one("*", $c);
    }
    
    function edit_state_req($_email, $_state)
    {
//        $this->debug();
        $c = new Query();
        $c->from="startup_member_req";
        $c->value("state", $_state);
        $c->where_eq("email", $_email);
        $this->update($c);
    }

    function signout($_id)
    {
        $c = new Query();
        $c->where_eq("user_id", $_id);
        $this->delete_cond($c);
    }
}

$current_controller->Startup_member = new Startup_member_model($settings);

?>
