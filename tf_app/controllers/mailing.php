<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Mailing extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "default";
    var $use_models = array("Event","Event_reserve", "Event_type", "Members");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "event";
        $this->assigns_layout["gnb_title"] = "이벤트";
        $this->assigns_layout["con"] = get_contents_category();
        $this->assigns_layout["s"] = $_SESSION["s"];
        $this->assigns["s"] = $_SESSION["s"];
    }

    public function event_eve()
    {
// $this->Event->debug();
// $this->Event_reserve->debug();
        $date = date('Y.m.d');
        $_date = date("Y.m.d", strtotime(str_replace(".", "-", $date)." +1 day"));

        $res = $this->Event->list_($_page, $pagesize, 'e.date = "'.$_date.'" and e.state = 1 and e.open = 1');
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
echo $res[$i]["title"];
            $ap = $this->Event_reserve->list_(1, 1000, 'er.state = 1 and event_id = '.$res[$i]["id"]);
            $len_ap = sizeof($ap);
            for ($a=0; $a<$len_ap; $a++) {
echo $ap[$a]["email"]."<br>";

                $m = new TF_mailer($this->settings);
                $m->mailto = $ap[$a]["email"];
                $m->subject = "[D.CAMP] <".$res[$i]["title"].">, 내일입니다. 꼭 참석해주세요.";
                $m->tpl_name = "event_apply";
                $m->assigns["res"] = $res[$i];
                $m->assigns["main_service_url"] = $this->globals->my_host;
                $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                $m->send();
                    
            }
        }
        echo "<br>".date('Y-m-d H:i');
        exit(1);
        # 낮 12시 발송
    }

    public function event_preview()
    {
// $this->Event->debug();
// $this->Event_reserve->debug();
        $this->tpl_name = "";
        $date = date('Y.m.d H:i');
        $_date = date("Y.m.d H:i", strtotime(str_replace(".", "-", $date)." +10 min"));
        $res = $this->Event->list_($_page, $pagesize, 'CONCAT_WS(" ", e.date, e.start) = "'.$_date.'" and e.state = 1 and e.open = 1');

        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
echo $res[$i]["title"];
            $ap = $this->Event_reserve->list_(1, 1000, 'er.state = 1 and event_id = '.$res[$i]["id"]);
            $len_ap = sizeof($ap);
            for ($a=0; $a<$len_ap; $a++) {
echo $ap[$a]["email"]."<br>";

                $m = new TF_mailer($this->settings);
                $m->mailto = $ap[$a]["email"];
                $m->subject = "[D.CAMP] <".$res[$i]["title"].">, 곧 시작됩니다. 실시간으로 질문하고 사람들과 이야기를 나누세요.";
                $m->tpl_name = "event_preview";
                $m->assigns["res"] = $res[$i];
                $m->assigns["main_service_url"] = $this->globals->my_host;
                $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                $m->send();
            }
        }
        echo "<br>".date('Y-m-d H:i');
        exit(1);
        # 매 시, 20분, 50분
    }

    public function event_review()
    {
// $this->Event->debug();
// $this->Event_reserve->debug();
        $this->tpl_name = "";
        $date = date('Y.m.d H:i');
        $_date = date("Y.m.d H:i", strtotime(str_replace(".", "-", $date)." -30 min"));
        $res = $this->Event->list_($_page, $pagesize, 'CONCAT_WS(" ", e.date_e, e.end) = "'.$_date.'" and e.state = 1 and e.open = 1');

        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
echo $res[$i]["title"];
            $ap = $this->Event_reserve->list_(1, 1000, 'er.state = 1 and event_id = '.$res[$i]["id"]);
            $len_ap = sizeof($ap);
            for ($a=0; $a<$len_ap; $a++) {
echo $ap[$a]["email"]."<br>";

                $m = new TF_mailer($this->settings);
                $m->mailto = $ap[$a]["email"];
                $m->subject = "[D.CAMP] <".$res[$i]["title"].">, 어떠셨나요? 후기와 피드백을 남겨주세요.";
                $m->tpl_name = "event_review2";
                $m->assigns["res"] = $res[$i];
                $m->assigns["main_service_url"] = $this->globals->my_host;
                $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                $m->send();
            }
        }
        echo "<br>".date('Y-m-d H:i');
        exit(1);
        # 매 시, 20분, 50분
    }

    // public function dormant()
    // {
    //     $this->layout = "";
    //     $this->tpl_name = "";

    //     $res = $this->Members->list_m('', '', "date_edited <= '".date("Y-m-d", strtotime(date("Y-m-d")." -1 year"))."' AND (last_login <= '".date("Y-m-d", strtotime(date("Y-m-d")." -1 year"))."' OR last_login IS NULL)");
    //     $len_res = sizeof($res);
    //     for ($i=0; $i<$len_res; $i++) {
            
    //         if ($res[$i]["email"]) {
    //             $m = new TF_mailer($this->settings);
    //             $m->mailto = $res[$i]["email"];
    //             $m->subject = "D.CAMP 장기 미사용 계정의 회원정보 휴면 파기안내";
    //             $m->tpl_name = "dormant-account";
    //             $m->send();

    //             echo $res[$i]["email"]."/".$res[$i]["last_login"]."<br>";
    //         }
    //     }
    //     echo $len_res;

    //     // $m = new TF_mailer($this->settings);
    //     // $m->mailto = 'violet@userstorylab.com';
    //     // $m->subject = "D.CAMP 장기 미사용 계정의 회원정보 휴면 파기안내";
    //     // $m->tpl_name = "dormant-account";
    //     // $m->send();
    // }

    public function dormant($_i)
    {
        $this->layout = "";
        $this->tpl_name = "";

        if ($_i == 7) {
            // // mailling
            $day = date("Y-m-d", strtotime(date(date("Y-m-d", strtotime(date("Y-m-d")." -1 year")))." +7 day"));
            $res = $this->Members->list_m('', '', "last_login LIKE '".$day."%'");
            $len_res = sizeof($res);
            for ($i=0; $i<$len_res; $i++) {
                
                if ($res[$i]["email"]) {
                    $m = new TF_mailer($this->settings);
                    $m->mailto = $res[$i]["email"];
                    $m->subject = "D.CAMP 장기 미사용 계정의 회원정보 휴면 파기안내";
                    $m->tpl_name = "dormant-account";
                    $m->assigns["day"] = date_to_kr(date("Y-m-d", strtotime(date(date("Y-m-d", strtotime(date("Y-m-d")." -1 year")))." +7 day")));
                    $m->assigns["t_day"] = date_to_kr(date("Y-m-d", strtotime(date("Y-m-d")." +7 day")));
                    $m->send();
                }
            }
        }
        else if ($_i == 1) {
            // q 
            $d_day = date("Y-m-d", strtotime(date(date("Y-m-d", strtotime(date("Y-m-d")." -1 year")))." -2 day"));
            $this->Members->dormant($d_day);

            // mailling
            $day = date("Y-m-d", strtotime(date(date("Y-m-d", strtotime(date("Y-m-d")." -1 year")))." +1 day"));
            $res = $this->Members->list_m('', '', "last_login LIKE '".$day."%'");
            $len_res = sizeof($res);
            for ($i=0; $i<$len_res; $i++) {
                
                if ($res[$i]["email"]) {
                    $m = new TF_mailer($this->settings);
                    $m->mailto = $res[$i]["email"];
                    $m->subject = "D.CAMP 장기 미사용 계정의 회원정보 휴면 파기안내";
                    $m->tpl_name = "dormant-account";
                    $m->assigns["day"] = date_to_kr(date("Y-m-d", strtotime(date(date("Y-m-d", strtotime(date("Y-m-d")." -1 year")))." +1 day")));
                    $m->assigns["t_day"] = date_to_kr(date("Y-m-d", strtotime(date("Y-m-d")." +1 day")));
                    $m->send();
                }
            }
        }
    }
}
?>
