<?

    class Recruit_opt_model extends Model
    {
        var $tablename = "recruit_opt";
        
        function delete_by_recruit($_id) 
        {
            $c = new Query();
            $c->where_eq("recruit_id", $_id);
            $this->delete_cond($c);
        }
        
        function add($_id, $_value, $_type)
        {
//            $this->debug();
            $c = new Query();
            $c->value("recruit_id", $_id);
            $c->value("code_id", $_value);
            $c->value("code_type", $_type);
            $this->insert($c);
        }
        
        function get_detail($_id, $_type, $_is_row = '') 
        {
//            $this->debug();
            $c = new Query();
            $c->from="recruit_opt ro, code c";
            $c->where("ro.code_id = c.id");
            $c->where_eq("recruit_id", $_id);
            $c->where_eq("code_type", $_type);
            if ($_is_row) $res = $this->fetch_one("GROUP_CONCAT(_value SEPARATOR '/') _value", $c);
            else $res = $this->fetch("*", $c);
            
            return $res;
        }

        function cnt_by_opt($_tid, $_cid, $_where = '')
        {
            // $this->debug();
            $c = new Query();
            $c->from="recruit r, recruit_opt ro";
            $c->where("ro.recruit_id = r.id");
            $c->where_eq("code_type", $_tid);
            $c->where_eq("code_id", $_cid);
            if ($_where) $c->where($_where);
            $res = $this->counts($c);

            return $res;
        }

    }

    $current_controller->Recruit_opt = new Recruit_opt_model($settings);

?>
