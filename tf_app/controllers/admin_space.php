<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 *
 * violet@userstorylab.com
 */

class Admin_space extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "admin";
    var $use_models = array("Space", "Space_reserve", "Activity", "Code", "Members"
            , "Startup_member");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "space";
        $this->assigns_layout["gnb_title"] = "Reservation 관리";
        // if (($_SESSION["s"]["per"] & $this->settings->permission5) != $this->settings->permission5 &&
        //             ($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1){
        //     header("Location: /login");
        // }
        $this->assigns_layout["s"] = $_SESSION["s"];
        $this->assigns["s"] = $_SESSION["s"];
    }

    public function index($_page = 1)
    {
        $this->assigns_layout["gnb_left"] = "index";

        $pagesize = 10;
        $where = '';
        if  (!$_REQUEST["sort"])  {
            $_REQUEST["sort"] = "state";
            $_REQUEST["order"] = 0;
        }
        if ($_REQUEST["sort"] == "state" && $_REQUEST["order"] != 99) {
            $where = "sr.".$_REQUEST["sort"]."=".$_REQUEST["order"];
        }
        if ($_REQUEST["sort"] == "membership") $where = "m.".$_REQUEST["sort"]."=".$_REQUEST["order"];
        if ($_REQUEST["type"] && $_REQUEST["type"] != 99) {
            if  ($where != '') $where = $where . " and ";
            $where = $where. 's.type = '.$_REQUEST["type"];
        }
        if ($_REQUEST['order'] == 99) {
            if ($_REQUEST["type"]) {
                if  ($where != '') $where = $where . " and ";
                $where = $where. 's.type = '.$_REQUEST["type"];
            } 
            else $where = '';
        }
        $order = 'sr.date DESC';
        if ($_REQUEST["order_e"]) $order = "ss ".$_REQUEST["order_e"];

        $res = $this->Space_reserve->list_($_page, $pagesize, $where, $order);
        $res_cnt = $this->Space_reserve->cnt($where);
        $this->assigns["res"] = $res;
        $this->assigns["page"] = $_page;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);
        $this->assigns["type"] = $_REQUEST["type"];
        $this->assigns["order"] = $_REQUEST["order"];
        $this->assigns["sort"] = $_REQUEST["sort"];
        $this->assigns["order_t"] = $_REQUEST["order_t"];
        $this->assigns["order_e"] = 'DESC';
        if ($_REQUEST["order_e"] )$this->assigns["order_e"] = $_REQUEST["order_e"];
    }
    
    public function approve($_id)
    {
        $this->assigns_layout["gnb_left"] = "reserve";
        
        $this->assigns["res"] = $this->Space_reserve->get_detail($_id);
        
        if ($_REQUEST["state"] || $_REQUEST["state"] == "0") {
            $this->Space_reserve->permit($_id, $_REQUEST);
            
            if ($_REQUEST["state"] == 1) {
                $arr["act_type"] = Activity_model::C_TYPE_MEMBER;
                $arr["act_id"] = $this->assigns["res"]["user_id"];
                $arr["target_type"] = Activity_model::A_TYPE_SPACE;
                $arr["target_id"] = $_id;
                $arr["act_result"] = 1;
                $this->Activity->edit($arr);
                
                $ev = $this->Space_reserve->get_detail($_REQUEST["id"]);
                $m = new TF_mailer($this->settings);
                $m->mailto = $ev["memail"];
                $m->subject = "[D.CAMP] 공간 예약이 승인되었습니다.";
                $m->tpl_name = "space";
                $m->assigns["res"] = $ev;
                $m->assigns["main_service_url"] = $this->globals->my_host;
                $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                $m->send();
            }

            if ($_REQUEST["state"] == 2) {
                $arr["act_type"] = Activity_model::C_TYPE_MEMBER;
                $arr["act_id"] = $this->assigns["res"]["user_id"];
                $arr["target_type"] = Activity_model::A_TYPE_SPACE;
                $arr["target_id"] = $_id;
                $arr["act_result"] = 2;
                $this->Activity->edit($arr);
                
                $ev = $this->Space_reserve->get_detail($_REQUEST["id"]);
                if (date("Y.m.d")<$ev["date"]) {
                    $m = new TF_mailer($this->settings);
                    $m->mailto = $ev["memail"];
                    $m->subject = "[D.CAMP] 공간 예약이 반려되었습니다.";
                    $m->tpl_name = "space";
                    $m->assigns["res"] = $ev;
                    $m->assigns["main_service_url"] = $this->globals->my_host;
                    $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                    $m->send();
                }
            }
        
            header("Location: /admin_space");
        }
    }

    public function reserve($_id = '')
    {
        $this->assigns_layout["gnb_left"] = "reserve";
        
        $this->assigns["space"] = $this->Space->list_(1, 100, "visible = 1");
        if ($_REQUEST["date"]) {
            if ($_REQUEST["reserved"]) {
                if ( ! $_REQUEST["purpose"]) $_REQUEST["purpose"] = "D.CAMP 일정";
                $_REQUEST["state"] = "1";
            }
            $_id =$this->Space_reserve->add($_REQUEST);
            if($_REQUEST["id"]) {
                $this->assigns["msg"] = "수정되었습니다.";
            }
            else {
                $this->assigns["msg"] = "신청되었습니다.";
            }
        }
        
        if ($_REQUEST["cancel"]) {
            $this->Space_reserve->permit($_REQUEST["cancel"], $arr["state"] = 9);
            header("Location: /admin_space");
        }
        
        if ($_id) {
            $this->assigns["res"] = $this->Space_reserve->get_detail($_id);
        }
        $ds = $this->Space->list_(1, 1, 'type = 3');
        $this->assigns["ds"] = $ds[0];
    }

    public function list_($_page = 1)
    {
        $this->assigns_layout["gnb_left"] = "list_";

        $pagesize = 10;
        $res = $this->Space->list_($_page, $pagesize, 'visible < 2');
        $res_cnt = $this->Space->cnt('visible < 2');
        $this->assigns["res"] = $res;
        $this->assigns["page"] = $_page;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);
    }

    public function add($_id = '')
    {
        $this->assigns_layout["gnb_left"] = "add";
        
        if ($_REQUEST["name"]) {
            $days = 0;

            //체크박스 사용
            if(array_key_exists('day1',$_REQUEST)) $days = $days | $this->settings->day1;
            else $days = $days & (~$this->settings->day1);

            if(array_key_exists('day2',$_REQUEST)) $days = $days | $this->settings->day2;
            else $days = $days & (~$this->settings->day2);

            if(array_key_exists('day3',$_REQUEST)) $days = $days | $this->settings->day3;
            else $days = $days & (~$this->settings->day3);

            if(array_key_exists('day4',$_REQUEST)) $days = $days | $this->settings->day4;
            else $days = $days & (~$this->settings->day4);

            if(array_key_exists('day5',$_REQUEST)) $days = $days | $this->settings->day5;
            else $days = $days & (~$this->settings->day5);

            if(array_key_exists('day6',$_REQUEST)) $days = $days | $this->settings->day6;
            else $days = $days & (~$this->settings->day6);

            if(array_key_exists('day7',$_REQUEST)) $days = $days | $this->settings->day7;
            else $days = $days & (~$this->settings->day7);

            $_REQUEST['days'] = $days;

            $this->Space->add($_REQUEST);
            header("Location: /admin_space/list_");
        }
        
        if ($_id) {
            $this->assigns["res"] = $this->Space->get($_id);
        }
    }

    public function rep()
    {
        $this->assigns_layout["gnb_left"] = "rep";
        if ($_REQUEST["r1"]) {
            $_arr["_key"] = "rep1";
            $_arr["_value"] = $_REQUEST["r1"];
            $this->Code->ins($_arr);
            $_arr2["_key"] = "rep2";
            $_arr2["_value"] = $_REQUEST["r2"];
            $this->Code->ins($_arr2);
        }
        $r1 = $this->Code->get_by_key("rep1");
        $rep1 = $this->Members->get($r1[0]["_value"]);
        $rep1["com"] = $this->Startup_member->get_by_user($rep1["id"]);
        
        $r2 = $this->Code->get_by_key("rep2");
        $rep2 = $this->Members->get($r2[0]["_value"]);
        $rep2["com"] = $this->Startup_member->get_by_user($rep2["id"]);
        
        $this->assigns["rep1"] = $rep1;
        $this->assigns["rep2"] = $rep2;
    }

    public function calendar()
    {
        $this->assigns_layout["gnb_left"] = "calendar";
    }

    public function excel()
    {
        $this->layout = "";
        
        $res = $this->Space_reserve->list_(1, 10000000, '', 'sr.id DESC');
        $len_res = sizeof($res);
// exit(1);
        header( "Content-type: application/vnd.ms-excel; charset=euc-kr" );
        header( "Content-Disposition: attachment; filename=reservation.xls" );
        header( "Content-Description: PHP4 Generated Data" );
        Print("<Meta Http-Equiv=\"Content-Type\" Content=\"Application/Vnd.Ms-Excel; Charset=UTF-8\">");

        echo "
        <table>
        <tr>
        <td>id</td>
        <td>공간구분</td>
        <td>장소</td>
        <td>모임 일자</td>
        <td>이용 시작 시간</td>
        <td>이용 종료 시간</td>
        <td>신청자</td>
        <td>상태</td>
        <td>신청일</td>
        </tr>
        ";

        for($i=0; $i<$len_res; $i++) {
            if ($res[$i]["stype"] == 1) $type = "D.CAMP 회의실";
            else if ($res[$i]["stype"] == 2) $type = "외부 행사 대관";
            else if ($res[$i]["stype"] == 3) $type = "디자인 라운지";

            if ($res[$i]["state"] == 0) $state = "승인대기";
            else if ($res[$i]["state"] == 1) $state = "승인";
            else if ($res[$i]["state"] == 2) $state = "반려 : ".$res[$i]["state_des"];

            echo "<tr>"
                ."<td>".$res[$i]["id"]."</td>"
                ."<td>".$type."</td>"
                ."<td>".$res[$i]["opt"]."F ".$res[$i]["name"]."</td>"
                ."<td>".$res[$i]["date"]."</td>"
                ."<td>".$res[$i]["start"]."</td>"
                ."<td>".$res[$i]["end"]."</td>"
                ."<td>".$res[$i]["mname"]."(".$res[$i]["ids"].")</td>"
                ."<td>".$state."</td>"
                ."<td>".$res[$i]["date_created"]."</td>"
            ."</tr>";
        }

        echo "
        </table>
        ";
        exit(1);
    }

}
?>
