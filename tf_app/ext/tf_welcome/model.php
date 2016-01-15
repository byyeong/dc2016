<?

    class EXT_Mobile_tickets_model extends Model
    {
        
        var $tablename = "mobile_tickets";

        function get_login_ticket($id)
        {
            $c = new Query();
            $c->where("id_user = " . $id);
            $c->where("expires > now()");
            return $this->fetch_one("*", $c);
        }
        
        function issue_new_ticket($id)
        {
            $ret = "";
            
            $c = new Query();
            $c->value("id_user", $id);
            $this->delete_cond($c);

            for ($i=0; $i<64; $i++)
            {
                $r = rand(0,61);
                
                if ($r>35)
                    $r = $r + 61;
                if ($r>9 and $r<36)
                    $r = $r + 55;
                if ($r<10)
                    $r = $r + 48;
        
                $ret = $ret . chr($r);
            }
            
            $c = new Query();
            $c->where("login_ticket = '" . $ret . "'");
            if ($this->fetch_one("id_user", $c)) return new_confirm_key();
            
            $c = new Query();
            $c->value("id_user", $id);
            $c->value("expires", "date_add(now(), interval 1 hour)", 1);
            $c->value("login_ticket", $ret);
            $this->insert($c);
            return $ret;
        }

    }
    
    $log_lt = new EXT_Mobile_tickets_model($settings);
    load_ext_model("Mobile_tickets", $log_lt);

    class EXT_Mobile_sessions_model extends Model
    {
        
        var $tablename = "mobile_sessions";
        
        function new_session($id)
        {
            $ret = "";
            
            //$c = new Query();
            //$c->value("id_user", $id);
            //$this->delete_cond($c);

            for ($i=0; $i<128; $i++)
            {
                $r = rand(0,61);
                
                if ($r>35)
                    $r = $r + 61;
                if ($r>9 and $r<36)
                    $r = $r + 55;
                if ($r<10)
                    $r = $r + 48;
        
                $ret = $ret . chr($r);
            }
            
            $c = new Query();
            $c->where("session_key = '" . $ret . "'");
            if ($this->fetch_one("id_user", $c)) return new_confirm_key();
            
            $c = new Query();
            $c->value("id_user", $id);
            $c->value("expires", "date_add(now(), interval 1 hour)", 1);
            $c->value("session_key", $ret);
            $this->insert($c);
            
            $c = new Query();
            $c->where("id_user = " . $id);
            $c->where("session_key = '" . $ret . "'");
            return $this->fetch_one("id, id_user, session_key, unix_timestamp(expires) expires", $c);
        }
        
        function get_session($id)
        {
            $c = new Query();
            $c->where("id = " .  $id);
            $c->where("expires > now()");
            return $this->fetch_one("id_user, session_key, unix_timestamp(expires) expires", $c);            
        }
        
        function extend($id, $dat)
        {
            $c = new Query();
            $c->where("id = " .  $id);
            $c->value("expires", $dat);
            $this->update($c);
        }

    }

    $log_es = new EXT_Mobile_sessions_model($settings);
    load_ext_model("Mobile_sessions", $log_es);
    
?>
