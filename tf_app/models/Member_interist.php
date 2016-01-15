<?

class Member_interist_model extends Model
{
    var $tablename = "member_interist";

    function get_by_member($_user) {
        $c = new Query();
        $c->from="member_interist mi, interists i";
        $c->where("mi.interist_id = i.id");
        $c->where_eq("user_id", $_user);
        $res = $this->fetch("*", $c);
        
        return $res;
    }
    
    function get_by_member_c($_user) {
        $c = new Query();
        $c->from="member_interist mi, code c";
        $c->where("mi.interist_id = c.id");
        $c->where_eq("user_id", $_user);
        $res = $this->fetch("*", $c);
        
        return $res;
    }
    
    function add($_user, $_interist) 
    {
//        $this->debug();
        $c = new Query();
        $c->from="interists";
        $c->where_eq("interist", $_interist);;
        $res = $this->fetch_one("*", $c);
        
        if (!$res) {
            $a = new Query();
            $a->from="interists";
            $a->value("interist", $_interist);
            $this->insert($a);
            
            $res["id"] = $this->last_id();
        }

        $d = new Query();
        $d->value("user_id", $_user);
        $d->value("interist_id", $res["id"]);
        $this->insert($d);
    }
    
    function add_c($_user, $_interist)
    {
        $d = new Query();
        $d->value("user_id", $_user);
        $d->value("interist_id", $_interist);
        $this->insert($d);
    }
    
    function delete_by_user($_user)
    {
        $c = new Query();
        $c->where_eq("user_id", $_user);
        $this->delete_cond($c);
    }

    function get_by_inv_cnt($_where)
    {
        // $this->debug();
        $c = new Query();
        $c->from="member_interist mi, members m";
        $c->where("mi.user_id = m.id");
        if ($_where) $c->where($_where);
        $res = $this->counts($c);

        return $res;
    }

    function list_($_page, $_pagesize, $_where = '', $_order = '')
    {
       // $this->debug();
        $c = new Query();
        $c->from="members m, member_grade mg, member_interist mi";
        $c->where("mg.id = m.grade");
        $c->where("mi.user_id = m.id");
        if ($_where) $c->where ($_where);
        if ($_order) $c->order=$_order;
        else $c->order = "m.id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $res = $this->fetch("m.*, mg.name gname", $c);
        
        return $res;
    }
}

$current_controller->Member_interist = new Member_interist_model($settings);

?>
