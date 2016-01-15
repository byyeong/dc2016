<?
    class Mobile_interface extends Controller
    {
        var $assigns = array();
        var $assigns_layout = array();
        var $layout = "";
        var $use_models = array("Users", "*Mobile_sessions", "*Mobile_tickets");
        var $use_components = array("mobile_interface");
        
        public function issue_ticket($login_name)
        {
            
            $result = array("error_code"=>0,"error_desc"=>"");
            $user = $this->Users->get_by_login_name($login_name);
            
            if (!$user)
            {
                $result["error_code"] = "404";
                $result["error_desc"] = "Non-exist user";
                echo json_encode($result);
                exit(0);
            }
            
            $ticket = $this->Mobile_tickets->issue_new_ticket($user["id"]);
            $datas = array();
            $datas["login_ticket"] = $ticket;

            $result["result"] = $datas;
            echo json_encode($result);
            exit(0);
            
            
        }

        public function login($login_name)
        {
            $result = array("error_code"=>0,"error_desc"=>"");
            
            $user = $this->Users->get_by_login_name($login_name);
            
            if (!$user)
            {
                $result["error_code"] = "404";
                $result["error_desc"] = "Non-exist user";
                echo json_encode($result);
                exit(0);
            }
            
            $ticket = $this->Mobile_tickets->get_login_ticket($user["id"]);
            $datas = array();
            
            $pw_string = sha256($user["password"] . $ticket["login_ticket"]);
            $pw_input = $_REQUEST["confirm_key"];
            
            if ($pw_string == $pw_input)
            {
                $session = $this->Mobile_sessions->new_session($user["id"]);
                $datas["session_key"] = $session["session_key"];
                $datas["session_id"] = $session["id"];
            }
            else
            {
                $result["error_code"] = "403";
                $result["error_desc"] = "Key error";
                echo json_encode($result);
                exit(0);
                return;
            }
            
            $c = new Query();
            $c->where("id_users = " . $user["id"]);
            $this->Mobile_tickets->delete_cond($c);

            $result["result"] = $datas;
            echo json_encode($result);
            exit(0);
            
        }
        
        public function test_echo()
        {
            $result = array("error_code"=>0,"error_desc"=>"");
            $user_id = session_auth();

            $this->tpl_name = "//ajax_exe/ajax_result";
            $this->assigns["error_code"] = "0";

            $get = $_GET;
            unset($get["tf_url"]);
            unset($get["session_id"]);
            unset($get["session_key"]);
            $result["result"] = $get;

            echo json_encode($result);
            exit(0);
            
        }

    } 
     
?>
