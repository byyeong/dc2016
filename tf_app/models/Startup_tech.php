<?

class Startup_tech_model extends Model
{
    var $tablename = "startup_tech";

    function get_by_member($_user) 
    {
        $c = new Query();
        $c->from="startup_tech st, skills s";
        $c->where("st.tech_id = s.id");
        $c->where_eq("startup_id", $_user);
        $res = $this->fetch("*", $c);
        
        return $res;
    }
    
    function get_by_member_c($_user) 
    {
//        $res = $this->cache->get('st_tech_get_by_member_c'.$_user);
//        if (!$res) {
            $c = new Query();
            $c->from="startup_tech st, code c";
            $c->where("st.tech_id = c.id");
            $c->where_eq("startup_id", $_user);
            $res = $this->fetch("*", $c);
        
//            $this->cache->set('st_tech_get_by_member_c'.$_user, $res, 0);
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
        $d->value("tech_id", $res["id"]);
        $this->insert($d);
    }
    
    function add_c($_user, $_c) 
    {
//        $this->debug();
        $d = new Query();
        $d->value("startup_id", $_user);
        $d->value("tech_id", $_c);
        $this->insert($d);
    }
    
    function delete_by_user($_user)
    {
        $c = new Query();
        $c->where_eq("startup_id", $_user);
        $this->delete_cond($c);
    }
}

$current_controller->Startup_tech = new Startup_tech_model($settings);

?>
