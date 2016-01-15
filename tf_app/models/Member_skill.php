<?

class Member_skill_model extends Model
{
    var $tablename = "member_skill";

    function get_by_member($_user) {
        $c = new Query();
        $c->from="member_skill ms, skills s";
        $c->where("ms.skill_id = s.id");
        $c->where_eq("user_id", $_user);
        $res = $this->fetch("*", $c);
        
        return $res;
    }
    
    function get_by_member_c($_user) {
        $c = new Query();
        $c->from="member_skill ms, code c";
        $c->where("ms.skill_id = c.id");
        $c->where_eq("user_id", $_user);
        $res = $this->fetch("*", $c);
        
        return $res;
    }
    
    function add($_user, $_skill) 
    {
//        $this->debug();
        $c = new Query();
        $c->from="skills";
        $c->where_eq("skill", $_skill);;
        $res = $this->fetch_one("*", $c);
        
        if (!$res) {
            $a = new Query();
            $a->from="skills";
            $a->value("skill", $_skill);
            $this->insert($a);
            
            $res["id"] = $this->last_id();
        }

        $d = new Query();
        $d->value("user_id", $_user);
        $d->value("skill_id", $res["id"]);
        $this->insert($d);
    }
    
    function add_c($_user, $_skill)
    {
//        $this->debug();
        $d = new Query();
        $d->value("user_id", $_user);
        $d->value("skill_id", $_skill);
        $this->insert($d);
    }
            
    function delete_by_user($_user)
    {
        $c = new Query();
        $c->where_eq("user_id", $_user);
        $this->delete_cond($c);
    }
}

$current_controller->Member_skill = new Member_skill_model($settings);

?>
