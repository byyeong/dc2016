<?

class Startup_bussiness_model extends Model
{
    var $tablename = "startup_bussiness";

    function get_by_member($_user) 
    {
//        $this->debug();
        $c = new Query();
        $c->from="startup_bussiness sb, skills s";
        $c->where("sb.bussiness_id = s.id");
        $c->where_eq("startup_id", $_user);
        $res = $this->fetch("*", $c);
        
        return $res;
    }
    
    function get_by_member_c($_user) 
    {
//        $res = $this->cache->get('st_buss_get_by_member_c'.$_user);
//        if (!$res) {
            $c = new Query();
            $c->from="startup_bussiness sb, code c";
            $c->where("sb.bussiness_id = c.id");
            $c->where_eq("startup_id", $_user);
            $res = $this->fetch("*", $c);
            
//            $this->cache->set('st_buss_get_by_member_c'.$_user, $res, 0);
//        }
        
        return $res;
    }
    
    function add($_user, $_local) 
    {
//        $this->debug();
        $c = new Query();
        $c->from="skills";
        $c->where_eq("skill", $_local);;
        $res = $this->fetch_one("*", $c);
        
        if (!$res) {
            $a = new Query();
            $a->from="skills";
            $a->value("skill", $_local);
            $this->insert($a);
            
            $res["id"] = $this->last_id();
        }

        $d = new Query();
        $d->value("startup_id", $_user);
        $d->value("bussiness_id", $res["id"]);
        $this->insert($d);
    }
    
    function add_c($_user, $_c) 
    {
//        $this->debug();
        $d = new Query();
        $d->value("startup_id", $_user);
        $d->value("bussiness_id", $_c);
        $this->insert($d);
    }
    
    function delete_by_user($_user)
    {
        $c = new Query();
        $c->where_eq("startup_id", $_user);
        $this->delete_cond($c);
    }
}

$current_controller->Startup_bussiness = new Startup_bussiness_model($settings);

?>
