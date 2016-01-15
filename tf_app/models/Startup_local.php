<?

class Startup_local_model extends Model
{
    var $tablename = "startup_local";

    function get_by_member($_user) 
    {
        $c = new Query();
        $c->from="startup_local sl, local l";
        $c->where("sl.local_id = l.id");
        $c->where_eq("startup_id", $_user);
        $res = $this->fetch("*", $c);
        
        return $res;
    }
    
    function add($_user, $_local) 
    {
//        $this->debug();
        $c = new Query();
        $c->from="local";
        $c->where_eq("local", $_local);;
        $res = $this->fetch_one("*", $c);
        
        if (!$res) {
            $a = new Query();
            $a->from="local";
            $a->value("local", $_local);
            $this->insert($a);
            
            $res["id"] = $this->last_id();
        }

        $d = new Query();
        $d->value("startup_id", $_user);
        $d->value("local_id", $res["id"]);
        $this->insert($d);
    }
    
    function delete_by_user($_user)
    {
        $c = new Query();
        $c->where_eq("startup_id", $_user);
        $this->delete_cond($c);
    }
}

$current_controller->Startup_local = new Startup_local_model($settings);

?>
