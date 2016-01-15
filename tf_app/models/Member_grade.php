<?

class Member_grade_model extends Model
{
    var $tablename = "member_grade";

    function get_name($_name)
    {
        $c = new Query();
        $c->where_eq("name", $_name);
        $res = $this->fetch_one("id", $c);

        return $res;
    }
    
    function add($_arr)
    {
//        $this->debug();
        $c = new Query();
        $c->value("name", $_arr["name"]);
        $c->value("description", $_arr["description"]);
        if ($_arr["image"]) $c->value("image", $_arr["image"]);
        if ($_arr["icon"]) $c->value("icon", $_arr["icon"]);
        $c->value("permission", $_arr["permission"]);
        $c->value("visible", $_arr["visible"]);
        
        if (array_key_exists("id", $_arr)) {
            $c->where_eq("id", $_arr["id"]);
            $this->update($c);
            return $_arr["id"];
        }
        else {
            $this->insert($c);
            
            $d = new Query();
            $res = $this->fetch_one("Max(id) id", $d);
            return $res["id"];
        }
    }
    
    function add_picture($_id, $_img = '', $_ico = '')
    {
        $c = new Query();
        if ($_img) $c->value("image", $_img);
        if ($_ico) $c->value("icon", $_ico);
         $c->where_eq("id", $_id);
        $this->update($c);
    }
            
    function list_($_page, $_pagesize, $_where = 1)
    {
        $c = new Query();
        if ($_where) $c->where ($_where);
        $c->order = "id DESC";
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $res = $this->fetch("*", $c);
        
        return $res;
    }
    
    function cnt()
    {
        $c = new Query();
        return $this->counts();
    }
    
    function edit($_id, $_state)
    {
        $c = new Query();
        $c->value("visible", $_state);
        $c->where_eq("id", $_id);
        $this->update($c);
    }
}

$current_controller->Member_grade = new Member_grade_model($settings);

?>
