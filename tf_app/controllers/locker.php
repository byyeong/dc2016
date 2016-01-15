<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Locker extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "default";
    var $use_models = array("Locker_month", "Entrance", "Members", "Code");

    public function before_calling()
    {
        $this->assigns_layout["con"] = get_contents_category();
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns_layout["s"] = $_SESSION["s"];
    }
    
    public function index($_date = '')
    {
           // if (!$_date || date('d') < 25) {
           //     header("Location: /error_404");
           // }
     
        if ($_REQUEST["user_id"]) {
            $this->Locker_month->edit_state($_date, $_REQUEST["user_id"], 1);
            $res = $this->Locker_month->get_by_month_user($_date, $_REQUEST["email"]);
            $this->assigns["res"] = $res;
        }
        else {
            $res = $this->Locker_month->get_by_month_user($_date, $_REQUEST["email"]);
            if ($res) {
                $pre = $this->Locker_month->get_by_month_user(date('Y-m'), $_REQUEST["email"], "l.state = 1");
                if (!$pre) {
                    $em = $this->Locker_month->get_empty($_date, 'locker > 18');
                    $pre["locker_id"] = $em[0]["locker"];
                }
                $this->Locker_month->edit_locker($_date, $res["user_id"], $pre["locker_id"]);
                $res = $this->Locker_month->get_by_month_user($_date, $_REQUEST["email"]);
                $this->assigns["res"] = $res;
            }
            // else header("Location: /error_404");
        }
        
        
        $this->assigns["date_"] = $_date;
        $this->assigns["email"] = $_REQUEST["email"];
    }
    
    public function month_calc()
    {
        $this->tpl_name = '';
        $time = time(); 
        $n_date = date('Y-m', strtotime("+1 month", $time));
        $s_date = date('Y-m', strtotime("-1 month", $time));
        $e_date = date('Y-m-20');
        
        $m_locker = $this->Code->get_by_key('m_locker', "_value");
        $cnt = $m_locker[0]["_value"];
        
        $res = $this->Entrance->get_by_period($s_date, $e_date, 1, $cnt);
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            $user = $this->Members->get($res[$i]["user_a"]);
            if (!$user)$user = $this->Members->get($res[$i]["user_b"]);
            $pre = $this->Locker_month->get_by_month_user($e_date, $user["email"], "l.state = 1");
            $arr["locker_id"] = '';
            if ($pre) $arr["locker_id"] = $pre["locker_id"];
            $arr["user_id"] = $user["id"];
            $arr["date"] = $n_date;
            $this->Locker_month->add($arr);
            
            // mail
            $m = new TF_mailer($this->settings);
            $m->mailto = $user["email"];
//            $m->mailto = 'violet@userstorylab.com';
            $m->subject = "[D.CAMP] 월간 사물함 사용 신청을 받습니다.";
            $m->tpl_name = "locker";
            $m->assigns["user"] = $user;
            $m->assigns["date"] = $n_date;
            $m->assigns["pdate"] = date('Y-m');
            $m->assigns["main_service_url"] = $this->globals->my_host;
            $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
            $m->send();
        }
        $this->close();
    }
    
    public function less_calc()
    {
        $this->tpl_name = '';
        $time = time(); 
        $n_date = date('Y-m', strtotime("+1 month", $time));
        $s_date = date('Y-m', strtotime("-1 month", $time));
        $e_date = date('Y-m-20');
        
        $cnt = $this->Locker_month->get_cnt($n_date, 'state = 1');
        
        $m_locker = $this->Code->get_by_key('m_locker', "_value");
        $or_cnt = $m_locker[0]["_value"];
        
        $res = $this->Entrance->get_by_period($s_date, $e_date, 1, $or_cnt);
        $len_res = $or_cnt - $cnt;
        for ($i=0; $i<$len_res; $i++) {
            $user = $this->Members->get($res[$i]["user_a"]);
            if (!$user)$user = $this->Members->get($res[$i]["user_b"]);
            $pre = $this->Locker_month->get_by_month_user($e_date, $user["email"], "l.state = 1");
            $arr["locker_id"] = '';
            if ($pre) $arr["locker_id"] = $pre["locker_id"];
            $arr["user_id"] = $user["id"];
            $arr["date"] = $n_date;
            $this->Locker_month->add($arr);
            
            echo $i.":".$user["id"]."/".$res[$i]["cnt_al"]."<br />";
            // mail
            $m = new TF_mailer($this->settings);
            $m->mailto = $user["email"];
//            $m->mailto = 'violet@userstorylab.com';
            $m->subject = "[D.CAMP] 월간 사물함 사용 신청을 받습니다.";
            $m->tpl_name = "locker";
            $m->assigns["user"] = $user;
            $m->assigns["date"] = $n_date;
            $m->assigns["pdate"] = date('Y-m');
            $m->assigns["end_day"] = "5";
            $m->assigns["main_service_url"] = $this->globals->my_host;
            $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
            $m->send();
        }

    }
    
    public function close()
    {
        $this->tpl_name = '';
        $time = time(); 
        $n_date = date('Y-m', strtotime("+1 month", $time));

        $res = $this->Locker_month->get_by_month(1, 100, date('Y-m'), 'l.state = 1');
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            $tmp = $this->Locker_month->get_by_month_user_id($n_date, $res[$i]["user_id"]);
            if (!$tmp) {
                $m = new TF_mailer($this->settings);
                $m->mailto = $res[$i]["email"];
//                $m->mailto = 'violet@userstorylab.com';
                $m->subject = "[D.CAMP] 월간 사물함 사용기간 만료 안내입니다.";
                $m->tpl_name = "locker_close";
                $m->assigns["res"] = $res[$i];
                $m->assigns["main_service_url"] = $this->globals->my_host;
                $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                $m->send();
            }
        }

    }
}
?>