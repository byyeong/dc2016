<?

class Startup_founder_model extends Model
{
    var $tablename = "startup_founder";

    function add($_startup_id, $_founder)
    {
        $c = new Query();
        $c->value("startup_id", $_startup_id);
        $c->value("founder", $_founder);
        $this->insert($c);
    }
    
    function list_($_user)
    {
        $c = new Query();
        $c->where_eq("startup_id", $_user);
        $c->order = "id ASC";
        $res = $this->fetch("*", $c);
        
        return $res;
    }
    
    function del($_user)
    {
        $c = new Query();
        $c->where_eq("startup_id", $_user);
        $this->delete_cond($c);
    }
}

$current_controller->Startup_founder = new Startup_founder_model($settings);

?>
