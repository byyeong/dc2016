<?

class Member_market_model extends Model
{
    var $tablename = "member_market";
    
    function get_by_member_c($_user) {
        $c = new Query();
        $c->from="member_market ms, code c";
        $c->where("ms.market_id = c.id");
        $c->where_eq("user_id", $_user);
        $res = $this->fetch("*", $c);
        
        return $res;
    }
    
    function add_c($_user, $_skill)
    {
        $d = new Query();
        $d->value("user_id", $_user);
        $d->value("market_id", $_skill);
        $this->insert($d);
    }
            
    function delete_by_user($_user)
    {
        $c = new Query();
        $c->where_eq("user_id", $_user);
        $this->delete_cond($c);
    }
}

$current_controller->Member_market = new Member_market_model($settings);

?>
