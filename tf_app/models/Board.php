<?

class Board_model extends Model
{
    const EVENT_TYPE = 3;
    /*
    type 1: member
    type 2: startup
    type 3: event
    type 4: recruit
    type 5: notice
    type 6: contents(blog)
    type 7: competition(challenge)
    type 8: office hours
    type 9: benefit 
    type 10: showcase
    */

    var $tablename = "board";

    function add($_arr)
    {
        // $this->debug();
        $c = new Query();
        $c->value("p_type", $_arr["p_type"]);
        $c->value("p_id", $_arr["p_id"]);
        $c->value("user_id", $_arr["user_id"]);
        $c->value("contents", $_arr["contents"]);
        $c->value("sub", ltrim(str_replace("Entfernen", 'Entfernen" style="display: none;', $_arr["sub"])));
        $c->value("parent", $_arr["parent"]);
        $c->value("depth", $_arr["depth"]);
        $c->value("is_hidden", $_arr["is_hidden"]);
        $c->value("is_news", $_arr["is_news"]);
        $c->value("is_press", $_arr["is_press"]);
        if ($_arr["id"]) {
            $c->where_eq("id", $_arr["id"]);
            $this->update($c);
            $id = $_REQUEST["id"];
        }
        else {
            $c->value("date_created", "now()", 1);
            $this->insert($c);
            $id = $this->last_id();
        }
        
        // board_tv add
        if ($_arr["p_type"] == 3 && !$_arr["parent"]) {
            $d = new Query();
            $d->from="entrance e";
            $d->where_eq("user_id", $_arr["user_id"]);
            $d->where("date_in LIKE '".date("Y-m-d")."%' and date_out IS NULL GROUP BY user_id");
            $ent = $this->fetch_one("user_id", $d);

            if ($ent) {
                $e = new Query();
                $e->from="board_tv";
                $e->value("board_id", $id);
                $e->value("date_created", "now()", 1);
                $this->insert($e);

                $file = fopen("../tf_app/ext/tf_data.php","w+");
                if(!$file) die();
                fwrite($file, $id);
                fclose($file);
            }
        }
        return $id;
    }

    function add_image($_arr)
    {
        $c = new Query();
        $c->value("image", $_arr["image"]);
        $c->where_eq("id", $_arr["id"]);
        $this->update($c);
    }
    
    function list_($_type, $_pid = '', $_page = '', $_pagesize = '', $_where = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="members m, board b";
        $c->where("b.user_id = m.id");
        if ($_pid) $c->where_eq("p_id", $_pid);
        $c->where_eq("p_type", $_type);
        $c->where_eq("depth", 0);
        if ($_where) $c->where ($_where);
        if ($_page) $c->page = $_page;
        if ($_pagesize) $c->page_size = $_pagesize;
        $c->order = "b.id DESC";
        $res = $this->fetch("*, b.id as bid", $c);
        
        return $res;
    }

    function list_in($_pid = '', $_page = '', $_pagesize = '', $_where = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="members m, board b";
        $c->where("b.user_id = m.id");
        if ($_pid) $c->where_eq("p_id", $_pid);
        $c->where_eq("depth", 0);
        if ($_where) $c->where ($_where);
        if ($_page) $c->page = $_page;
        if ($_pagesize) $c->page_size = $_pagesize;
        $c->order = "b.id DESC";
        $res = $this->fetch("*, b.id as bid", $c);
        
        return $res;
    }
    
    function cnt($_where, $_from = '')
    {
        $c = new Query();
        if ($_from) $c->from=$_from;
        if ($_where) $c->where($_where);
        $res = $this->counts($c);

        return $res;
    }
    
    function list_news($_page, $_pagesize, $_where = '')
    {
        $c = new Query();
        $c->from="members m, board b";
        $c->where("b.user_id = m.id");
        $c->where_eq("is_news", 1);
        if ($_where) $c->where ($_where);
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $c->order = "b.id DESC";
        $res = $this->fetch("*, b.id bid, b.date_created bdate_created", $c);
        
        return $res;
    }

    function list_press($_page, $_pagesize, $_where = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="members m, board b";
        $c->where("b.user_id = m.id");
        $c->where_eq("is_press", 1);
        if ($_where) $c->where ($_where);
        $c->page = $_page;
        $c->page_size = $_pagesize;
        $c->order = "b.id DESC";
        $res = $this->fetch("*, b.id bid, b.date_created bdate_created", $c);
        
        return $res;
    }
        
    function get_comment($_type = '', $_pid = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="members m, board b";
        $c->where("b.user_id = m.id");
        if ($_type) $c->where_eq("p_type", $_type);
        $c->where_eq("parent", $_pid);
        $c->order = "b.id ASC";
        $res = $this->fetch("*, b.id as bid", $c);
        
        return $res;
    }

    function get_comment_user($_type = '', $_pid = '')
    {
        $c = new Query();
        $c->from="members m, board b";
        $c->where("b.user_id = m.id");
        if ($_type) $c->where_eq("p_type", $_type);
        $c->where_eq("parent", $_pid);
        $c->group="b.user_id";
        $res = $this->fetch("*", $c);
        
        return $res;
    }
    
    function get_editors($_cnt, $_where = '')
    {
        $c = new Query();
        $c->from="members m, board b";
        $c->where("b.user_id = m.id");
        $c->group="user_id";
        $c->order="cnt DESC";
        $c->limit=$_cnt;
        if ($_where) $c->where ($_where);
        return $this->fetch("m.ids, m.name, m.picture ,COUNT(*) cnt", $c);
    }
            
    function get_detail($_id)
    {
        $c = new Query();
        $c->from="members m, board b";
        $c->where("b.user_id = m.id");
        $c->where_eq("b.id", $_id);
        $res = $this->fetch_one("*, b.id bid, b.date_created bdate", $c);
        
        return $res;
    }
    
    function del_com($_id, $_dep) 
    {
        $this->delete($_id);
        if ($_dep) {
            $c = new Query();
            $c->where ("parent = ".$_id);
            $this->delete_cond($c);
        }
    }

    function signout($_id)
    {
        $c = new Query();
        $c->where_eq("user_id", $_id);
        $this->delete_cond($c);
    }

    /* Use Board_like */
    function get_like_cnt($_id)
    {
        $c = new Query();
        $c->from="board_like";
        $c->where_eq("b_id", $_id);

        return $this->counts($c);
    }

    function get_like_this($_bid, $_uid)
    {
        $c = new Query();
        $c->from="board_like";
        $c->where_eq("b_id", $_bid);
        $c->where_eq("user_id", $_uid);
        $res = $this->fetch_one("id", $c);

        if ($res) 
            return 1;
        else 
            return 0;
    }

    function check_like($_bid, $_uid)
    {
        // $this->debug();
        $c = new Query();
        $c->from="board_like";
        $c->where_eq("b_id", $_bid);
        $c->where_eq("user_id", $_uid);
        return $this->fetch_one("id", $c);
    }

    function add_like($_bid, $_uid)
    {
        $c = new Query();
        $c->from="board_like";
        $c->value("b_id", $_bid);
        $c->value("user_id", $_uid);
        $this->insert($c);
    }

    function delete_like($_bid, $_uid)
    {
        $c = new Query();
        $c->from="board_like";
        $c->where_eq("b_id", $_bid);
        $c->where_eq("user_id", $_uid);
        $this->delete_cond($c);
    }

    function get_like_user($_id)
    {
        // $this->debug();
        $c = new Query();
        $c->from="board_like b, members m";
        $c->where("b.user_id = m.id");
        $c->where_eq("b_id", $_id);
        $res = $this->fetch("m.*", $c);

        return $res;
    }

    // board_tv
    function get_hot($_cur = '', $_where = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="board b, board_tv t, members m";
        $c->where("t.board_id = b.id");
        $c->where("m.id = b.user_id");
        if ($_cur)
            $c->where("t.board_id > ".$_cur);
        if ($_where)
            $c->where($_where);
        $c->limit=1;
        if ($_cur)
            $c->order="id ASC";
        else
            $c->order="id DESC";
        $res = $this->fetch_one("b.*, m.picture, m.name", $c);
        return $res;
    }
}

$current_controller->Board = new Board_model($settings);

?>
