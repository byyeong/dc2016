<?

class Member_inv_model extends Model
{
    var $tablename = "member_inv";

    function get_by_member($_user) 
    {
        $c = new Query();
        $c->from="member_inv ml, code c";
        $c->where("ml.inv_id = c.id");
        $c->where_eq("user_id", $_user);
        $res = $this->fetch("*", $c);
        
        return $res;
    }
    
    function add($_user, $_local) 
    {
        $d = new Query();
        $d->value("user_id", $_user);
        $d->value("inv_id", $_local);
        $this->insert($d);
    }
    
    function delete_by_user($_user)
    {
        $c = new Query();
        $c->where_eq("user_id", $_user);
        $this->delete_cond($c);
    }
}

$current_controller->Member_inv = new Member_inv_model($settings);

?>
