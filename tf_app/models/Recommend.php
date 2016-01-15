<?

class Recommend_model extends Model
{
    var $tablename = "recommend";
    
    function add_($_type, $_rec, $_user) 
    {
//        $this->debug();
        $d = new Query();
        $d->value("type", $_type);
        $d->value("rec_id", $_rec);
        $d->value("user_id", $_user);
        $d->value("date_created", "now()", 1);
        $this->insert($d);
    }
    
    function add($_arr) 
    {
//        $this->debug();
        $d = new Query();
        $d->value("user_id", $_arr["user_id"]);
        $d->value("rec_mem", $_arr["rec_mem"]);
        $d->value("rec_com", $_arr["rec_com"]);
        $d->value("act", $_arr["act"]);
        $d->value("career", $_arr["career"]);
        $d->value("state", $_arr["state"]);
        $d->value("date_edited", "now()", 1);
        if ($_arr["id"]) {
            $d->value("state_des", "");
            $d->where_eq("id", $_arr["id"]);
            $this->update($d);
        }
        else {
            $d->value("date_created", "now()", 1);
            $this->insert($d);
        }
    }
    
    function list_($_page, $_pagesize, $_where = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="recommend r, members m, member_grade mg";
        $c->where("m.id = r.user_id");
        $c->where("m.grade = mg.id");
        if ($_where) $c->where($_where);
//        $c->group="user_id";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $c->order="r.id DESC";
        $res = $this->fetch("mg.name mgname,m.id, m.name, m.ids, m.email, m.tel, m.email_rec, m.sms_rec, m.state mstate, r.*", $c);
        
        return $res;
    }

    function cnt($_where = '')
    {
        $c = new Query();
        $c->from="(SELECT mg.name mgname, m.name, m.ids, r.date_created, r.state, m.id FROM recommend r, members m, member_grade mg  
                WHERE 1  AND m.id = r.user_id AND m.grade = mg.id ) a";
        if ($_where) {
            $c->from="(SELECT mg.name mgname, m.name, m.ids, r.date_created, r.state, m.id FROM recommend r, members m, member_grade mg  
                WHERE ".$_where." AND m.id = r.user_id AND m.grade = mg.id ) a";
        }
        $res = $this->counts($c);
        
        return $res;
    }
    
    function list_search($_page, $_pagesize, $_key, $_cnt = '')
    {
//        $this->debug();
        $c = new Query();
        $c->from="recommend r, members m, member_grade mg";
        $c->where("m.id = r.user_id");
        $c->where("m.grade = mg.id");
        $c->where("(m.name LIKE '%".$_key."%' OR m.ids LIKE '%".$_key."%' OR referee LIKE '%".$_key."%' 
                OR r.id IN (SELECT id FROM recommend WHERE TYPE = 2 AND rec_id IN (SELECT id FROM members WHERE NAME LIKE '%".$_key."%')) 
                OR r.id IN (SELECT id FROM recommend WHERE TYPE = 1 AND rec_id IN (SELECT id FROM startup WHERE NAME LIKE '%".$_key."%')))");
//        $c->group="user_id";
        if ($_cnt) {
            $res = $this->counts($c);
        }
        else {
            $c->page = $_page;
            $c->page_size = $_pagesize;
            $c->order="r.id DESC";
            $res = $this->fetch("mg.name mgname,m.id, m.name, m.ids, r.*", $c);
        }
        return $res;
    }
    
    function cnt_search($_key)
    {
        $c = new Query();
        $c->from="(SELECT r.id FROM recommend r, members m, member_grade mg WHERE m.id = r.user_id AND m.grade = mg.id AND 
                (m.name LIKE '%".$_key."%' OR m.ids LIKE '%".$_key."%' OR referee LIKE '%".$_key."%' 
                OR r.id IN (SELECT id FROM recommend WHERE TYPE = 2 AND rec_id IN (SELECT id FROM members WHERE NAME LIKE '%".$_key."%')) 
                OR r.id IN (SELECT id FROM recommend WHERE TYPE = 1 AND rec_id IN (SELECT id FROM startup WHERE NAME LIKE '%".$_key."%'))) GROUP BY user_id) a";
        $res = $this->counts($c);
        
        return $res;
    }
    
    function permit($_id, $_user, $_state, $_des = '')
    {
//        $this->debug();
        $c = new Query();
        $c->where_eq("id", $_id);
        $c->value("state", $_state);
        $c->value("state_des", $_des);
        $c->value("date_edited", "now()", 1);
        $this->update($c);
        
        if ($_state == 1) {
            $d = new Query();
            $d->from="members";
            $d->where_eq("id", $_user);
            $d->value("membership", $_state);
            $d->value("grade", 2);
            $this->update($d);

            $e = new Query();
            $e->where("id != ".$_id);
            $e->where_eq("user_id", $_user);
            $this->delete_cond($e);
        }
        else {
            $d = new Query();
            $d->from="members";
            $d->where_eq("id", $_user);
            $d->value("membership", $_state);
            $d->value("grade", 1);
            $this->update($d);
        }
    }
    
    function get_rec_by_type($_type, $_id)
    {
//        $this->debug();
        $c = new Query();
        if ($_type == 1) {
            $c->from="recommend r, startup s";
            $c->where("s.id = r.rec_id");
        }
        else if ($_type == 2) {
            $c->from="recommend r, members m";
            $c->where("m.id = r.rec_id");
        }
        $c->where_eq("type", $_type);
        $c->where_eq("user_id", $_id);
        $res = $this->fetch_one("GROUP_CONCAT(name) name", $c);
        
        return $res["name"];
    }
    
    function get_by_user($_id, $_where = '')
    {
       // $this->debug();
        $c = new Query();
        $c->where_eq("user_id", $_id);
        if ($_where) $c->where($_where);
        $c->order="id DESC";
        return $this->fetch_one("*", $c);
    }
    
    function get_detail($_id)
    {
//        $this->debug();
        $c = new Query();
        $c->from="recommend r, members m";
        $c->where("m.id = r.user_id");
        $c->where_eq("user_id", $_id);
        $res = $this->fetch_one("r.*, m.ids, m.name, m.bio, m.picture", $c);
        return $res;
    }

    function get_detail_by_rec($_id)
    {
//        $this->debug();
        $c = new Query();
        $c->from="recommend r, members m";
        $c->where("m.id = r.user_id");
        $c->where_eq("r.id", $_id);
        $res = $this->fetch_one("r.*, m.ids, m.name, m.bio, m.picture", $c);
        return $res;
    }
}

$current_controller->Recommend = new Recommend_model($settings);

?>
