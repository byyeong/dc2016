<?

class Startup_service_model extends Model
{
    var $tablename = "startup_service";
    
    function add($_arr)
    {
       // $this->debug();
        $c = new Query();
        if (array_key_exists("startup_id", $_arr)) $c->value("startup_id", $_arr["startup_id"]);
        if (array_key_exists("name", $_arr)) $c->value("name", $_arr["name"]);
        if (array_key_exists("des_ele", $_arr)) $c->value("des_ele", $_arr["des_ele"]);
        if (array_key_exists("des_pro", $_arr)) $c->value("des_pro", $_arr["des_pro"]);
        if (array_key_exists("des_sol", $_arr)) $c->value("des_sol", $_arr["des_sol"]);
        if (array_key_exists("web_url", $_arr)) $c->value("web_url", $_arr["web_url"]);
        if (array_key_exists("ios_url", $_arr)) $c->value("ios_url", $_arr["ios_url"]);
        if (array_key_exists("and_url", $_arr)) $c->value("and_url", $_arr["and_url"]);
        if (array_key_exists("founded", $_arr)) $c->value("founded", $_arr["founded"]);
        if (array_key_exists("sales", $_arr)) $c->value("sales", $_arr["sales"]);
        if (array_key_exists("revenue", $_arr)) $c->value("revenue", $_arr["revenue"]);
        if (array_key_exists("etc", $_arr)) $c->value("etc", $_arr["etc"]);
        if (array_key_exists("target", $_arr)) $c->value("target", $_arr["target"]);
        if (array_key_exists("img1", $_arr) && $_arr["img1"]) $c->value("img1", $_arr["img1"]);
        $c->value("img2", $_arr["img2"]);
        $c->value("img3", $_arr["img3"]);
        $c->value("img4", $_arr["img4"]);
        $c->value("img1_thumb", $_arr["img1_thumb"]);
        $c->value("img2_thumb", $_arr["img2_thumb"]);
        $c->value("img3_thumb", $_arr["img3_thumb"]);
        $c->value("img4_thumb", $_arr["img4_thumb"]);
        $c->value("movie1", $_arr["movie1"]);
        $c->value("movie2", $_arr["movie2"]);
        $c->value("movie3", $_arr["movie3"]);
        $c->value("movie4", $_arr["movie4"]);
        $c->value("movie1_type", $_arr["movie1_type"]);
        $c->value("movie2_type", $_arr["movie2_type"]);
        $c->value("movie3_type", $_arr["movie3_type"]);
        $c->value("movie4_type", $_arr["movie4_type"]);
        $c->value("movie1_thumb", $_arr["movie1_thumb"]);
        $c->value("movie2_thumb", $_arr["movie2_thumb"]);
        $c->value("movie3_thumb", $_arr["movie3_thumb"]);
        $c->value("movie4_thumb", $_arr["movie4_thumb"]);
        $c->value("bm", $_arr["bm"]);
        $c->value("skill", $_arr["skill"]);
        $c->value("gr1", $_arr["gr1"]);
        $c->value("gr2", $_arr["gr2"]);
        $c->value("gr3", $_arr["gr3"]);
        $c->value("gr4", $_arr["gr4"]);
        $c->value("gr1_thumb", $_arr["gr1_thumb"]);
        $c->value("gr2_thumb", $_arr["gr2_thumb"]);
        $c->value("gr3_thumb", $_arr["gr3_thumb"]);
        $c->value("gr4_thumb", $_arr["gr4_thumb"]);
        $c->value("gr1_title", $_arr["gr1_title"]);
        $c->value("gr2_title", $_arr["gr2_title"]);
        $c->value("gr3_title", $_arr["gr3_title"]);
        $c->value("gr4_title", $_arr["gr4_title"]);
        $c->value("startup_name", $_arr["startup_name"]);
        $c->value("user_id_bz", $_arr["user_id_bz"]);
        if ($_arr["id"]) {
            $c->where_eq("id", $_arr["id"]);
            $c->value("date_updated", "now()", 1);
            $this->update($c);
            $id = $_arr["id"];
        }
        else {
            $c->value("date_created", "now()", 1);
            $c->value("date_updated", "now()", 1);
            $this->insert($c);
            $id = $this->last_id();
        }
        
        // $this->del_cache($_arr['startup_id']);
        return $id;
    }
    
    function add2($_arr)
    {
       // $this->debug();
        $c = new Query();
        if ($_arr["startup_id"]) $c->value("startup_id", $_arr["startup_id"]);
        if ($_arr["name"]) $c->value("name", $_arr["name"]);
        if ($_arr["des_ele"]) $c->value("des_ele", $_arr["des_ele"]);
        if ($_arr["des_pro"]) $c->value("des_pro", $_arr["des_pro"]);
        if ($_arr["des_sol"]) $c->value("des_sol", $_arr["des_sol"]);

        if ($_arr["id"]) {
            $c->where_eq("id", $_arr["id"]);
            $this->update($c);
            $id = $_arr["id"];
        }
        else {
            $this->insert($c);
            $id = $this->last_id();
        }
        
        return $id;
    }

    function add_picture($_id, $_pic)
    {
        $c = new Query();
        $c->value("img1", $_pic);
        $c->where_eq("id", $_id);
        $this->update($c);
    }
    
    function list_($_id = '', $_where = '', $_order = '', $_page = '', $_pagesize = '') 
    {
        // $this->debug();
        $c = new Query();
        if ($_id) $c->where_eq("startup_id", $_id);
        if ($_where) $c->where($_where);
        if ($_order) $c->order=$_order;
        else $c->order="id ASC";
        if ($_page && $_pagesize) {
            $c->page = $_page;
            $c->page_size = $_pagesize;
        }
        $res = $this->fetch("*", $c);
        
        return $res;
    }

    function list_w_startup_date($_page = '', $_pagesize = '', $_where = '', $_order = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="startup_service ss, startup_service_date sd";
        $c->where("ss.id = sd.service_id");
        if ($_where) $c->where($_where);
        if ($_page && $_pagesize) {
            $c->page = $_page;
            $c->page_size = $_pagesize;
        }
        if ($_order) $c->order=$_order;
        $res = $this->fetch("ss.*, sd.date, sd.type", $c);

        return $res;
    }

    function list_w_startup_category($_page = '', $_pagesize = '', $_where = '', $_order = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="startup_service ss, startup_service_category sc, code c";
        $c->where("ss.id = sc.service_id");
        $c->where("c.id = sc.category_id");
        if ($_where) $c->where($_where);
        if ($_page && $_pagesize) {
            $c->page = $_page;
            $c->page_size = $_pagesize;
        }
        if ($_order) $c->order=$_order;
        $res = $this->fetch("ss.*, sc.category_id, c._value", $c);

        return $res;
    }
    
    function delete_by_user($_id)
    {
        $c = new Query();
        $c->where_eq("startup_id", $_id);
        $this->delete_cond($c);
    }
    
    function del_cache($_id)
    {
        $this->cache->delete("startup_service_".$_id, "ALL");
    }

    function cnt($_where)
    {
        $c = new Query();
        if($_where) $c->where($_where);
        $res = $this->counts($c);

        return $res; 
    }

    function edit_status($_arr)
    {
        $c = new Query();
        $c->value("status_bz", $_arr["status_bz"]);
        $c->value("status_bz_des", $_arr["status_bz_des"]);
        $c->where_eq("id", $_arr["id"]);
        $this->update($c);
    }

    function get_next($_type, $_id='', $_sid='', $_where='', $_order='')
    {
        // $this->debug();
        $c = new Query();
        if ($_sid) $c->where_eq("startup_id", $_sid);
        if ($_type == 1) {
            $c->where("id < ".$_id);
            if($_order) $c->order=$_order;
            $res = $this->fetch_one("MAX(id) id", $c);
        }
        else {
            $c->where("id > ".$_id);
            if($_order) $c->order=$_order;
            $res = $this->fetch_one("MIN(id) id", $c);
        }

        return $res["id"];
    }

    function get_ser_date($_page = '', $_pagesize = '', $_where = '', $_order = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="startup_service s, (
                SELECT MAX(DATE) date, service_id FROM startup_service_date GROUP BY service_id) d";
        $c->where("s.id = d.service_id");
        if ($_where) $c->where($_where);
        if ($_page && $_pagesize) {
            $c->page = $_page;
            $c->page_size = $_pagesize;
        }
        if($_order) $c->order=$_order;
        $res = $this->fetch("*", $c);

        return $res;
    }

    function search($_page, $_pagesize, $_key, $_where = '')
    {
        //$this->debug();
        $c = new Query();
        $c->from = "startup_service ss, startup_service_category sc";
        $c->where("ss.id = sc.service_id");
        $c->where("(ss.name like '%".$_key."%' or ss.startup_name like '%".$_key."%')");
        $c->order = "ss.id DESC";
        if ($_where) $c->where($_where);
        $c->page = $_page;
        $c->page_size = $_pagesize;

        $res = $this->fetch("ss.*, DATE_FORMAT(ss.date_created, '%Y-%m-%d') date_created", $c);

        return $res;
    }

    function get_by_search_cnt($_key, $_where = ''){
        $c = new Query();
        $c->from = "startup_service ss, startup_service_category sc";
        $c->where("ss.id = sc.service_id");
        $c->where("(ss.name like '%".$_key."%' or ss.startup_name like '%".$_key."%')");
        if ($_where) $c->where($_where);

        $res = $this->counts($c);

        return $res;
    }


// Startup_service_category

    function get_by_cat_cnt($_id, $_where = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="startup_service ss, startup_service_category sc";
        $c->where("ss.id = sc.service_id");
        $c->where_eq("category_id", $_id);
        if ($_where) $c->where($_where);
        return $this->counts($c);
    }

    function get_category($_id)
    {
        $c = new Query();
        $c->from="code c, startup_service_category sc";
        $c->where("c.id = sc.category_id");
        $c->where_eq("service_id", $_id);
        $res = $this->fetch("c.*", $c);

        return $res;
    }

    function del_category($_id)
    {
        $c = new Query();
        $c->from="startup_service_category";
        $c->where_eq("service_id", $_id);
        $this->delete_cond($c);
    }

    function add_category($_id, $_cat)
    {
        $c = new Query();
        $c->from="startup_service_category";
        $c->value("category_id", $_cat);
        $c->value("service_id", $_id);
        $this->insert($c);
    }

    function get_by_cat_date($_page = '', $_pagesize = '', $_where = '', $_order = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="startup_service s, startup_service_category sc";
        $c->where("s.id = sc.service_id");
        if ($_where) $c->where($_where);
        if ($_page && $_pagesize) {
            $c->page = $_page;
            $c->page_size = $_pagesize;
        }
        $c->group="sc.service_id";
        if($_order) $c->order=$_order;
        $res = $this->fetch("s.*, sc.service_id", $c);

        return $res;
    }

    function get_cnt_cat($_page = '', $_pagesize = '', $_where = '', $_order = '') 
    {
        $c = new Query();
        $c->from="startup_service_category";
        if ($_where) $c->where($_where);
        if ($_page && $_pagesize) {
            $c->page = $_page;
            $c->page_size = $_pagesize;
        }
        if ($_order) $c->order=$_order;
        $res = $this->fetch("service_id", $c);

        return $res;
    }

    function get_list_ser_cat($_page = '', $_pagesize = '', $_where = '', $_order = '') 
    {
        // $this->debug();
        $c = new Query();
        $c->from="startup_service s, startup_service_category c, ( 
            SELECT MAX(DATE) date, service_id FROM startup_service_date GROUP BY service_id) d ";
        $c->where("s.id = d.service_id");
        $c->where("s.id = c.service_id");
        if ($_where) $c->where($_where);
        if ($_page && $_pagesize) {
            $c->page = $_page;
            $c->page_size = $_pagesize;
        }
        if ($_order) $c->order=$_order;
        $res = $this->fetch("d.*", $c);

        return $res;
    }

// Startup_service_date
    function get_by_date_cat($_page = '', $_pagesize = '', $_where = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from="startup_service s, startup_service_date sd";
        $c->where("s.id = sd.service_id");
        if ($_where) $c->where($_where);
        if ($_page && $_pagesize) {
            $c->page = $_page;
            $c->page_size = $_pagesize;
        }
        $c->group="sd.service_id";
        $c->order="date DESC";
        $res = $this->fetch("sd.service_id, sd.date", $c);

        return $res;
    }

    function get_list_by_date($_page = '', $_pagesize = '', $_where = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from = "startup_service_date";
        if ($_where) $c->where($_where);
        $c->order = "type ASC";
        if ($_page && $_pagesize) {
            $c->page = $_page;
            $c->page_size = $_pagesize;
        }
        $res = $this->fetch("distinct(service_id)", $c);

        return $res;
    }

    function get_last_date($_id, $_type = '')
    {
        // $this->debug();
        $c = new Query();
        $c->from = "startup_service_date";
        $c->where("date <= '".date("Y.m.d")."'");
        $c->where_eq("service_id", $_id);
        if ($_where) if ($_where) $c->where($_where); 
        $c->order = "date DESC";
        $c->limit = 1;
        $res = $this->fetch_one("date, type", $c);

        return $res;
    }

    function get_dates($_id, $_type)
    {
        // $this->debug();
        $c = new Query();
        $c->from="startup_service_date";
        $c->where_eq("service_id", $_id);
        $c->where_eq("type", $_type);
        $c->order="date DESC";
        $res = $this->fetch("*", $c);

        return $res;
    }

    function del_date($_id)
    {
        $c = new Query();
        $c->from="startup_service_date";
        $c->where_eq("service_id", $_id);
        $this->delete_cond($c);
    }
    
    function add_date($_id, $_date, $_type, $_des = '')
    {
        $c = new Query();
        $c->from="startup_service_date";
        $c->value("type", $_type);
        $c->value("date", $_date);
        $c->value("description", $_des);
        $c->value("service_id", $_id);
        $this->insert($c);
    }

// Startup_service_article
    function get_article($_id)
    {
        $c = new Query();
        $c->from = "startup_service_article";
        $c->where_eq("service_id", $_id);
        $c->order="id ASC";
        $res = $this->fetch("*", $c);

        return $res;
    }

    function del_article($_id)
    {
        $c = new Query();
        $c->from="startup_service_article";
        $c->where_eq("service_id", $_id);
        $this->delete_cond($c);
    }
    
    function add_article($_id, $_article, $_title)
    {
        $c = new Query();
        $c->from="startup_service_article";
        $c->value("article", $_article);
        $c->value("title", $_title);
        $c->value("service_id", $_id);
        $this->insert($c);
    }
}

$current_controller->Startup_service = new Startup_service_model($settings);

?>
