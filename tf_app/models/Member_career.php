<?

class Member_career_model extends Model
{
    var $tablename = "member_career";

    function add($_user, $_company, $_startup_id, $_role, $_start, $_end, $_ing, $_ids = '')
    {
        $c = new Query();
        $c->value("user_id", $_user);
        $c->value("company", $_company);
        $c->value("startup_id", $_startup_id);
        $c->value("role", $_role);
        $c->value("start", $_start);
        $c->value("end", $_end);
        $c->value("is_ing", $_ing);
        if (!$_ids) {
            $this->insert($c);
            $_id = $this->last_id();
        }
        else { 
            $c->where_eq ("id", $_ids);
            $this->update($c);
            $_id = $_user;
        }
        return $_id;
    }
    
    function list_($_user)
    {
        $c = new Query();
        $c->where_eq("user_id", $_user);
        $c->order = "id ASC";
        $res = $this->fetch("*", $c);
        
        return $res;
    }
    
    function del($_user)
    {
        $c = new Query();
        $c->where_eq("user_id", $_user);
        $this->delete_cond($c);
    }
    
    function del_by_user($_cid, $_uid)
    {
//        $this->debug();
        $c = new Query();
        $c->where_eq("user_id", $_uid);
        $c->where_eq("id", $_cid);
        $this->delete_cond($c);
    }
}

$current_controller->Member_career = new Member_career_model($settings);

?>
