<?

class Member_reference_model extends Model
{
    var $tablename = "member_reference";

    function add($_user_id, $_email, $_email_user, $_contents)
    {
//        $this->debug();
        $c = new Query();
        $c->from="member_reference_req";
        $c->value("user_id", $_user_id);
        $c->value("email_user", $_email_user);
        $c->value("email", $_email);
        $c->value("contents", $_contents);
        $c->value("date_created", "now()", 1);
        $this->insert($c);
    }
    
    function request_ref($_user, $_email)
    {
        $c = new Query();
        $c->from="member_reference_req";
        $c->where_eq("email", $_email);
        $c->where_eq("user_id", $_user);
        return $this->fetch_one("id", $c);
    }
    
    function request_ref_by_email($_email, $_where = '')
    {
//        $this->debug();
        $c = new Query();
        $c->from="member_reference_req mrr, members m";
        $c->where('mrr.user_id = m.id');
        $c->where_eq("mrr.email", $_email);
        if($_where)$c->where ($_where);
        return $this->fetch("mrr.*, m.id mid, m.ids, m.name", $c);
    }
            
    function add_ref($_user_id, $_req_id, $_reference)
    {
//        $this->debug();
        $c = new Query();
        $c->value("user_id", $_user_id);
        $c->value("req_id", $_req_id);
        $c->value("reference", $_reference);
        $c->value("date_created", "now()", 1);
        $this->insert($c);
    }
    
    function edit_state_ref($_user, $_email, $_state)
    {
//        $this->debug();
        $c = new Query();
        $c->from="member_reference_req";
        $c->value("state", $_state);
        $c->where_eq("user_id", $_user);
        $c->where_eq("email", $_email);
        $this->update($c);
    }
            
    function list_($_user)
    {
//        $this->debug();
        $c = new Query();
        $c->from="member_reference mr, members m";
        $c->where("mr.user_id = m.id");
        $c->where_eq("req_id", $_user);
        $c->order = "mr.date_created DESC";
        $res = $this->fetch("*, mr.date_created mr_created, mr.id mrid", $c);
        
        return $res;
    }
    
    function del($_user)
    {
        $c = new Query();
        $c->where_eq("user_id", $_user);
        $this->delete_cond($c);
    }
}

$current_controller->Member_reference = new Member_reference_model($settings);

?>
