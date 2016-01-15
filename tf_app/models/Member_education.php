<?

class Member_education_model extends Model
{
    var $tablename = "member_education";

    function add($_user_id, $_education, $_education_sp, $_education_st, $_id = '')
    {
        $c = new Query();
        $c->value("user_id", $_user_id);
        $c->value("education", $_education);
        $c->value("education_sp", $_education_sp);
        $c->value("education_st", $_education_st);
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
       // $this->debug();
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
}

$current_controller->Member_education = new Member_education_model($settings);

?>
