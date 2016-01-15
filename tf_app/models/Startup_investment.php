<?

class Startup_investment_model extends Model
{
    var $tablename = "startup_investment";

    function add($_startup_id, $_investor, $_email, $_date, $_investment, $_type, $_id = '')
    {
        $c = new Query();
        $c->value("startup_id", $_startup_id);
        $c->value("investor", $_investor);
        $c->value("email", $_email);
        $c->value("date", $_date);
        $c->value("investment", $_investment);
        $c->value("type", $_type);
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
//        $res = $this->cache->get('startup_investment_'.$_user);
//        if (!$res) {
            $c = new Query();
            $c->where_eq("startup_id", $_user);
            $c->order = "id ASC";
            $res = $this->fetch("*", $c);
        
//            $this->cache->set('startup_investment_'.$_user, $res, 0);
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

$current_controller->Startup_investment = new Startup_investment_model($settings);

?>
