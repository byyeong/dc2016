<?

class Startup_incubating_model extends Model
{
    var $tablename = "startup_incubating";

    function add($_startup_id, $_incubator, $_description, $_email, $_start, $_end, $_id = '')
    {
        $c = new Query();
        $c->value("startup_id", $_startup_id);
        $c->value("incubator", $_incubator);
        $c->value("description", $_description);
        $c->value("email", $_email);
        $c->value("start", $_start);
        $c->value("end", $_end);
        if ($_id) {
            $c->where_eq("id", $_id);
            $this->update($c);
        }
        else {
            $this->insert($c);
        }
    }
    
    function list_($_user)
    {
//        $res = $this->cache->get('startup_incubating_'.$_user);
//        if (!$res) {
            $c = new Query();
            $c->where_eq("startup_id", $_user);
            $c->order = "id ASC";
            $res = $this->fetch("*", $c);
        
//            $this->cache->set('startup_incubating_'.$_user, $res, 0);
//        }
        return $res;
    }
    
    function del($_user)
    {
        $c = new Query();
        $c->where_eq("startup_id", $_user);
        $this->delete_cond($c);
    }
}

$current_controller->Startup_incubating = new Startup_incubating_model($settings);

?>
