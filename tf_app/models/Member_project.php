<?

class Member_project_model extends Model
{
    var $tablename = "member_project";
    
    function add($_user, $_startup_id, $_project, $_start, $_end, $_role = '', $_ing = '', $_id = '')
    {
        $c = new Query();
        $c->value("user_id", $_user);
        $c->value("startup_id", $_startup_id);
        $c->value("project", $_project);
        $c->value("role", $_role);
        $c->value("start", $_start);
        $c->value("end", $_end);
        $c->value("is_ing", $_ing);
        if ($_id) {
            $c->where_eq("id", $_id);
            $this->update($c);
            $id = $_id;
        }
        else {
            $this->insert($c);
            $id = $this->last_id();
        }
        return $id;
    }
    
    function list_($_user)
    {
        $c = new Query();
        $c->from="member_project mp, startup s";
        $c->where("mp.startup_id = s.id");
        $c->where_eq("user_id", $_user);
        $c->order = "mp.id ASC";
        $res = $this->fetch("mp.*, s.name", $c);
        
        return $res;
    }
    
    function del($_user)
    {
        $c = new Query();
        $c->where_eq("user_id", $_user);
        $this->delete_cond($c);
    }
    
    function del_by_user($_cid, $_uid)
    {$this->debug();
        $c = new Query();
        $c->where_eq("user_id", $_uid);
        $c->where_eq("id", $_cid);
        $this->delete_cond($c);
    }
}

$current_controller->Member_project = new Member_project_model($settings);

?>
