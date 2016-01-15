<?

    class EXT_Log_uniqueview_model extends Model
    {
        
        var $tablename = "log_uniqueview";
        
        function update_uv()
        {
            if (array_key_exists("uv_key", $_COOKIE))
            {
                $uvk = $_COOKIE["uv_key"];
            }
            else
            {
                $c = new Query();
                $id = $this->fetch("max(id)+1 idx", $c);
                if ($id && $id[0]["id"])
                    $uvk = $id[0]["id"];
                else
                    $uvk = 1;
                setcookie("uv_key", $uvk,time() + 120960000, "/");
            }
            
            $q = new Query();
            $dat = date("Y-m-d", time());
            $q->where("id_uv = " . $uvk);
            $q->where("date8 = '$dat'");
            if ($this->counts($q) < 1)
            {
                $q = new Query();
                $q->value("id_uv", $uvk);
                $q->value("date8", $dat);
                $this->insert($q);
            }
            
            
        }
        
        function get_range($st, $ed = null)
        {
            
            $c = new Query();
            if (!$ed)
            {
                $c->where("date8 = '" . $st . "'");
            }
            else
            {
                $c->where("date8 >= '" . $st . "'");
                $c->where("date8 <= '" . $ed . "'");
            }
            $r = $this->fetch("count(distinct id_uv) cnt", $c);
            if ($r && $r[0]["cnt"])
                return $r[0]["cnt"];
            else
                return 0;
            
        }
            
        
        function site_logs()
        {
            $c = new Query();
            $c->where ("url <> ''");
            $c->limit = "20";
            $c->group = "url";
            $c->order = "count desc";
            return $this->fetch("sum(cnt) count, url", $c);
        }
    }

    $log_uv = new EXT_Log_uniqueview_model($settings);
    load_ext_model("Log_uniqueview", $log_uv);

    class EXT_Log_ref_model extends Model
    {
        
        var $tablename = "log_ref";
        
        function update_ref($_site)
        {
            
            $q = new Query();
            $dat = date("Y-m-d", time());
            $q->where("url = '$_site'");
            $q->where("date8 = '$dat'");
            
            if ($this->counts($q))
            {
                $q->value("count", "count+1", 1);

                $this->update($q);
            }
            else
            {
                $q = new Query();
                $q->value("url", $_site);
                $q->value("count", "1");
                $q->value("date8", $dat);
                $this->insert($q);
            }
            
        }
        
        
        function site_logs()
        {
            $c = new Query();
            $c->where ("url <> ''");
            $c->limit = "20";
            $c->group = "url";
            $c->order = "count desc";
            return $this->fetch("sum(count) count, url", $c);
        }
    }

    $log_ref = new EXT_Log_ref_model($settings);
    load_ext_model("Log_ref", $log_uv);

    class EXT_Log_pageview_model extends Model
    {
        
        var $tablename = "log_pageview";
        
        function update_pageview($_url)
        {
            
            $q = new Query();
            $dat = date("Y-m-d", time());
            $q->where("url = '$_url'");
            $q->where("date8 = '$dat'");
            
            if ($this->counts($q))
            {
                $q->value("count", "count+1", 1);

                $this->update($q);
            }
            else
            {
                $q = new Query();
                $q->value("url", $_url);
                $q->value("count", "1");
                $q->value("date8", $dat);
                $this->insert($q);
            }
            
        }
        
    }

    $log_pageview = new EXT_Log_pageview_model($settings);
    load_ext_model("Log_pageview", $log_pageview);    
    
?>
