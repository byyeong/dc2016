<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Reservation extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "default";
    var $use_models = array("Space", "Event", "Space_reserve", "Activity", "Members");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "event";
        $this->assigns_layout["gnb_title"] = "이벤트";
        $this->assigns_layout["con"] = get_contents_category();
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns_layout["s"] = $_SESSION["s"];
    }
    
    public function index($_date = '', $_next = '')
    {
        if (!$_date) $_date = date("Y.m.d");
        if ($_next == 1) {
            $_date = date("Y.m.d", strtotime(str_replace(".", "-", $_date)." -7 day"));
        } else if ($_next == 2) {
            $_date = date("Y.m.d", strtotime(str_replace(".", "-", $_date)." +7 day"));
        }
        $year = substr($_date, 0, 4);
        $month = substr($_date, 5, 2); 
        $day = substr($_date, 8, 2); 
        $now_week_day = date("w", mktime(0,0,0, $month, $day-1, $year)); 
        $start_day = date("Y-m-d", mktime(0,0,0, $month,  $day - $now_week_day, $year)); 
        $end_day = date("Y.m.d", mktime(0,0,0,$month, $day + (6-$now_week_day), $year)); 
        
        $res[0]["day"] = "MON";
        $res[1]["day"] = "TUE";
        $res[2]["day"] = "WED";
        $res[3]["day"] = "THU";
        $res[4]["day"] = "FRI";
        $res[5]["day"] = "SAT";
        $res[6]["day"] = "SUN";
        
        $res[0]["date"] = str_replace("-", ".", $start_day);
        $res[1]["date"] = date("Y.m.d", strtotime($start_day." +1 day"));
        $res[2]["date"] = date("Y.m.d", strtotime($start_day." +2 day"));
        $res[3]["date"] = date("Y.m.d", strtotime($start_day." +3 day"));
        $res[4]["date"] = date("Y.m.d", strtotime($start_day." +4 day"));
        $res[5]["date"] = date("Y.m.d", strtotime($start_day." +5 day"));
        $res[6]["date"] = date("Y.m.d", strtotime($start_day." +6 day"));

        $sp2 = $this->Space->list_('','','opt = 2');
        $len_sp2 = sizeof($sp2);
        for ($dd=0; $dd<7; $dd++) {
            for ($e=0; $e<$len_sp2; $e++) {
                $event = $this->Space_reserve->get_info_by_reserve("space_id = ".$sp2[$e]["id"]." and date = '".$res[$dd]["date"]."' and sr.state = 1");
                $ev2[$dd]["space"][$e]["event"] = $event;
                $ev2[$dd]["space"][$e]["name"] = $event[0]["sname"];
            }
        }

        $sp4 = $this->Space->list_('','','opt = 4');
        $len_sp4 = sizeof($sp4);
        for ($d=0; $d<7; $d++) {
            for ($e=0; $e<$len_sp4; $e++) {
                $event = $this->Space_reserve->get_info_by_reserve("space_id = ".$sp4[$e]["id"]." and date = '".$res[$d]["date"]."' and sr.state = 1");
                $ev4[$d]["space"][$e]["event"] = $event;
                $ev4[$d]["space"][$e]["name"] = $event[0]["sname"];
            }
        }

        $sp5 = $this->Space->list_('','','opt = 5');
        $len_sp5 = sizeof($sp5);
        for ($f=0; $f<7; $f++) {
            for ($e=0; $e<$len_sp5; $e++) {
                $event = $this->Space_reserve->get_info_by_reserve("space_id = ".$sp5[$e]["id"]." and date = '".$res[$f]["date"]."' and sr.state = 1");
                $ev5[$f]["space"][$e]["event"] = $event;
                $ev5[$f]["space"][$e]["name"] = $event[0]["sname"];
            }
        }
        
        $sp6 = $this->Space->list_('','','opt = 6');
        $len_sp6 = sizeof($sp6);
        for ($g=0; $g<7; $g++) {
            for ($e=0; $e<$len_sp6; $e++) {
                $event = $this->Space_reserve->get_info_by_reserve("space_id = ".$sp6[$e]["id"]." and date = '".$res[$g]["date"]."' and sr.state = 1");
                $ev6[$g]["space"][$e]["event"] = $event;
                $ev6[$g]["space"][$e]["name"] = $event[0]["sname"];
            }
        }
        $this->assigns["date"] = $_date;
        $this->assigns["res"] = $res;
        if ($len_sp2 > 0) $this->assigns["ev2"] = $ev2;
        if ($len_sp4 > 0) $this->assigns["ev4"] = $ev4;
        if ($len_sp5 > 0) $this->assigns["ev5"] = $ev5;
        if ($len_sp6 > 0) $this->assigns["ev6"] = $ev6;
        
        // reserve
        if ($_REQUEST["cancel"]) {
            $this->Space_reserve->permit($arr["state"] = 9, $_SESSION["s"]["id"]);
            header("Location: /");
        }
        if ($_REQUEST["date"]) {
            $s_r_id = $this->Space_reserve->add($_REQUEST);
            $this->assigns["ok"] = 1;
            if ($s_r_id) {
                $arr["com_type"] = Activity_model::C_TYPE_MEMBER;
                $arr["act_type"] = Activity_model::A_TYPE_SPACE;
                $arr["com_id"] = $_REQUEST["user_id"];
                $arr["act_id"] = $s_r_id;
                $arr["act_result"] = 0;
                $this->Activity->add($arr);
            }
        }
        if ($_REQUEST["id"]) {
            $ress = $this->Space_reserve->get_detail($_REQUEST["id"]);
            if ($ress["user_id"] == $_SESSION["s"]["id"]) {
                $this->assigns["ress"] = $ress;
            }
            else {
                header("Location: /");
            }
        }
        $this->assigns["space"] = $this->Space->list_(1, 100, "visible = 1");
        if (($_SESSION["s"]["per"] & $this->settings->permission7) == $this->settings->permission7) {
            $tmp = $this->Members->get_etc("_key = 'permission7' and user_id = ".$_SESSION["s"]["id"]);
            $list = $this->Space_reserve->list_(1, 1000, 'user_id = '.$_SESSION["s"]["id"].' and date > "'.$tmp["_value"].'" and sr.date_created like "'.date("Y-m").'%" and sr.state = 1');
            $len_list = sizeof($list);
            if ($len_list) {
                $rest = 0;
                for ($t=0; $t<$len_list; $t++) {
                    $rest = $rest + timeDiff($list[$t]["start"], $list[$t]["end"]);
                }
                $this->assigns["rest"] = ROUND((10 - $rest / 60), 1);
                if ($rest > 600) $this->assigns["rest"] = 0;
            }
            else {
                $this->assigns["rest"] = 10;
            }
        }
        $this->assigns["rdate"] = $_REQUEST["rdate"];
        $ds = $this->Space->list_(1, 1, 'type = 3');
        $this->assigns["ds"] = $ds[0];
    }
    
    public function apply($_id = '')
    {
        if (!$_id) header("Location: /");
        $res = $this->Space_reserve->get_detail($_id);
        if ($res) {
            $this->assigns["ress"] = $res;
            $this->assigns["space"] = $this->Space->list_(1, 100, "visible = 1");
        } else {
            header("Location: /");
        }
        
    }
    
    public function reserve($_id = '')
    {
        if (!$_SESSION["s"]["membership"]) {
            header("Location: /");
        }
        
        if ($_REQUEST["date"]) {
            $this->Space_reserve->debug();
            $s_r_id = $this->Space_reserve->add($_REQUEST);
            
//            add_activity(1, $_REQUEST["user_id"], 1, $_REQUEST["user_id"], 0, "", Activity_model::A_TYPE_SPACE, $s_r_id);
//            $_SESSION["msg"] = "공간공유가 신청되었습니다.<br />관리자 승인이 완료되면 공간공유 페이지에 노출됩니다.";
            $sp = $this->Space->get($_REQUEST["space_id"]);
            if (($sp["type"] > 2) && ($_SESSION["s"]["per"] & $this->settings->permission7) == $this->settings->permission7) {
                $tmp = $this->Members->get_etc("_key = 'permission7' and user_id = ".$_SESSION["s"]["id"]);
                
                if ($_REQUEST["date"] > $tmp["_value"] && $_REQUEST["rest"] >= timeDiff($_REQUEST["start"], $_REQUEST["end"])) {
                    $this->assigns["ok"] = 2;
                    add_activity(1, $_REQUEST["user_id"], 1, $_REQUEST["user_id"], 1, "", Activity_model::A_TYPE_SPACE, $s_r_id);
                    $_SESSION["msg"] = "예약 신청되었습니다.";
                    $ar["state"] = 1;
                    $this->Space_reserve->permit($s_r_id, $ar);
                }
                else {
                    $this->assigns["ok"] = 1;
                    add_activity(1, $_REQUEST["user_id"], 1, $_REQUEST["user_id"], 0, "", Activity_model::A_TYPE_SPACE, $s_r_id);
                    $_SESSION["msg"] = "예약 신청되었습니다.<br />관리자 승인이 완료되면 Reservation 페이지에 노출됩니다.";
                }
            }
            else if (($sp["type"] == 3) && ($_SESSION["s"]["per"] & $this->settings->permission8) == $this->settings->permission8) {                
                $this->assigns["ok"] = 2;
                add_activity(1, $_REQUEST["user_id"], 1, $_REQUEST["user_id"], 1, "", Activity_model::A_TYPE_SPACE, $s_r_id);
                $_SESSION["msg"] = "예약 신청되었습니다.";
                $ar["state"] = 1;
                $this->Space_reserve->permit($s_r_id, $ar);
            }
            else {
                $this->assigns["ok"] = 1;
                add_activity(1, $_REQUEST["user_id"], 1, $_REQUEST["user_id"], 0, "", Activity_model::A_TYPE_SPACE, $s_r_id);
                $_SESSION["msg"] = "예약  신청되었습니다.<br />관리자 승인이 완료되면 Reservation 페이지에 노출됩니다.";
            }
            header("Location: /member/edit_space");
        }
        
        if ($_id) {
            $res = $this->Space_reserve->get($_id);
            if ($res["user_id"] == $_SESSION["s"]["id"]) {
                $this->assigns["res"] = $res;
            }
            else {
                header("Location: /");
            }
        }
        
        if ($_REQUEST["cancel"]) {
            $this->Space_reserve->delete($_REQUEST["cancel"]);
            header("Location: /member/edit_space");
        }
        $this->assigns["space"] = $this->Space->list_(1, 100, "visible = 1");
//        print_r($_REQUEST);
//        echo "/".timeDiff($_REQUEST["start"], $_REQUEST["end"]);
    }
}
?>
