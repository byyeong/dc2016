<?

class Member_local_model extends Model
{
    var $tablename = "member_local";

    function get_by_member($_user) 
    {
        $c = new Query();
        $c->from="member_local ml, code c";
        $c->where("ml.local_id = c.id");
        $c->where_eq("user_id", $_user);
        $res = $this->fetch("*", $c);
        
        return $res;
    }

    function get_by_member_c($_user) {
        $c = new Query();
        $c->from="member_local ml, code c";
        $c->where("ml.local_id = c.id");
        $c->where_eq("user_id", $_user);
        $res = $this->fetch("*", $c);
        
        return $res;
    }
    
    function add($_user, $_local) 
    {
//        $this->debug();
//        $c = new Query();
//        $c->from="local";
//        $c->where_eq("local", $_local);;
//        $res = $this->fetch_one("*", $c);
//        
//        if (!$res) {
//            $a = new Query();
//            $a->from="local";
//            $a->value("local", $_local);
//            $this->insert($a);
//            
//            $res["id"] = $this->last_id();
//        }

        $d = new Query();
        $d->value("user_id", $_user);
        $d->value("local_id", $_local);
        $this->insert($d);
    }
    
    function delete_by_user($_user)
    {
        $c = new Query();
        $c->where_eq("user_id", $_user);
        $this->delete_cond($c);
    }
}

$current_controller->Member_local = new Member_local_model($settings);

?>
