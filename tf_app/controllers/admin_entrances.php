<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * 
 * violet@userstorylab.com
 */

class Admin_entrances extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "admin";
    var $use_models = array("Entrance", "Members", "Recommend", "Entrance", "Locker_month"
            , "Code", "Startup");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "entrance";
        $this->assigns_layout["gnb_title"] = "출입 관리";
        
        if (($_SESSION["s"]["per"] & $this->settings->permission5) != $this->settings->permission5 &&
                    ($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1){
            header("Location: /login");
        }
        
        $this->assigns_layout["s"] = $_SESSION["s"];
        $this->assigns["s"] = $_SESSION["s"];
    }

    public function index()
    {
        $this->assigns_layout["gnb_left"] = "entrance";
        
        $this->assigns["tot_to"] = $this->Entrance->cnt(date('Y-m-d'));
        $this->assigns["tot_in"] = $this->Entrance->cnt(date('Y-m-d'), '(date_out IS NULL or date_out = "")');
    }
    
    public function checkin()
    {
        $this->assigns_layout["gnb_left"] = "checkin";
        
        $this->assigns["res_curr"] = $this->Entrance->list_(1, 1000, date("Y-m-d"));
        if ($_REQUEST["q"]) {
            $this->assigns["res"] = $this->Members->search_by_entrancee($_REQUEST["q"]);
            $this->assigns["q"] = $_REQUEST["q"];
        }
    }
    
    public function checkin_pass($_id)
    {
        $this->assigns_layout["gnb_left"] = "checkin";

        if ($_REQUEST["user_id"]) {
            
            // first visit mailling - > daily p)161
            // $ch_first = $this->Entrance->check_first($_REQUEST["user_id"]);
            // if ( ! $ch_first ) {
                $us = $this->Members->get($_REQUEST["user_id"]);
                $m = new TF_mailer($this->settings);
                $m->mailto = $us["email"];
                $m->subject = "D.CAMP 방문을 환영합니다.";
                $m->tpl_name = "mail-welcome";
                $m->assigns["res"] = $us;
                $m->assigns["cnt"] = $this->Entrance->cnt('', 'e.user_id = '.$us["id"]);
                $m->assigns["main_service_url"] = $this->globals->my_host;
                $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                $m->send();
            // }
            
            $this->Members->add_login($_REQUEST["user_id"]);
            $_REQUEST["date_in"] = date('Y-m-d H:i:s');
            $_REQUEST["is_mailed"] = 1;
            $this->Entrance->add($_REQUEST);

            header("Location: /admin_entrance/checkin");
        }
        
        $res = $this->Members->get($_id);
        $res["date_ms"] = $this->Recommend->get_by_user($_id);
        $res["login_all"] = $this->Entrance->get_cnt_by_user($_id);
        $res["login_mon"] = $this->Entrance->get_cnt_by_user($_id, 'date_in like "'.date('Y-m').'%"');

        $res["mem"] = $this->Recommend->get_by_user($res["id"]);
        if ($res["mem"]["rec_com"]) $res["com"] = $this->Startup->get($res["mem"]["rec_com"]);
        if ($res["mem"]["rec_mem"]) $res["mem_"] = $this->Members->get($res["mem"]["rec_mem"]);

        $this->assigns["res"] = $res;
        $this->assigns["locker"] = $this->Entrance->locker_today();
        $this->assigns["pass"] = $this->Entrance->pass_today();
    }

    public function checkout()
    {
        $this->assigns_layout["gnb_left"] = "checkout";
        
        if ($_REQUEST["id"]) {
            $_REQUEST["pass"] = 0;
            $_REQUEST["locker"] = 0;
            $_REQUEST["date_out"] = date('Y-m-d H:i:s');
            $this->Entrance->add($_REQUEST);
        }
        
        $this->assigns["res_curr"] = $this->Entrance->list_(1, 1000, date("Y-m-d"));
        if ($_REQUEST["q"]) {
            $this->assigns["res"] = $this->Entrance->get_by_pass($_REQUEST["q"]);
        }
    }
    
    public function locker($_page = '')
    {
        $this->assigns_layout["gnb_left"] = "locker";
        if (!$_page) $_page = 1;
        $pagesize = 10;
        $res_cnt = $this->Entrance->cnt(date("Y-m-d"), "locker IS NOT NULL and locker != 0");
        $this->assigns["res"] = $this->Entrance->list_($_page, $pagesize, date("Y-m-d"), "locker IS NOT NULL and locker != 0");
        $this->assigns["page"] = $_page;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);  
    }
    
    public function locker_edit()
    {
        if ($_REQUEST["locker"]) {
            $this->Entrance->add_locker($_REQUEST["locker"]);
            $this->assigns["msg"] = "추가되었습니다.";
        }
        if ($_REQUEST["del_locker"]) {
            $this->Entrance->del_locker($_REQUEST["del_locker"]);
            $this->assigns["msg"] = "삭제되었습니다.";
        }
        $this->assigns["locker"] = $this->Entrance->locker();
    }

    public function pass($_page = '')
    {
        $this->assigns_layout["gnb_left"] = "pass";
        
        if (!$_page) $_page = 1;
        $pagesize = 10;
        $res_cnt = $this->Entrance->cnt(date("Y-m-d"), "pass IS NOT NULL and pass != 0");
        $this->assigns["res"] = $this->Entrance->list_($_page, $pagesize, date("Y-m-d"), "pass IS NOT NULL and pass != 0");
        $this->assigns["page"] = $_page;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize); 
    }

    public function pass_edit()
    {
        if ($_REQUEST["pass"]) {
            $this->Entrance->add_pass($_REQUEST["pass"]);
            $this->assigns["msg"] = "추가되었습니다.";
        }
        if ($_REQUEST["del_pass"]) {
            $this->Entrance->del_pass($_REQUEST["del_pass"]);
            $this->assigns["msg"] = "삭제되었습니다.";
        }
        $this->assigns["pass"] = $this->Entrance->pass();
    }
    
    public function analytics()
    {
        $this->assigns_layout["gnb_left"] = "analytics";
        $this->assigns["tot_mem"] = $this->Members->cnt("membership = 1");
        $this->assigns["tot_to"] = $this->Entrance->cnt(date('Y-m-d'));
        $this->assigns["tot_in"] = $this->Entrance->cnt(date('Y-m-d'), '(date_out IS NULL or date_out = "")');
        
        $day = date('d-M-y');
        for ($i=6; $i>=0; $i--)
        {
            $wek[$i]["date"] = date("d-M-Y", strtotime($day." -".$i." day"));
            $wek[$i]["val"] = date("Y-m-d", strtotime($wek[$i]["date"]));
            $wek[$i]["tot_to"] = $this->Entrance->cnt($wek[$i]["val"]);
        }
        $this->assigns["week"] = $wek;
        
        for ($j=30; $j>=0; $j--)
        {
            $mon[$j]["date"] = date("d-M-Y", strtotime($day." -".$j." day"));
            $mon[$j]["val"] = date("Y-m-d", strtotime($mon[$j]["date"]));
            $mon[$j]["tot_to"] = $this->Entrance->cnt($mon[$j]["val"]);
        }
        $this->assigns["month"] = $mon;
        
        for ($k=11; $k>=0; $k--)
        {
            $year[$k]["date"] = date("M-Y", strtotime($day." -".$k." month"));
            $year[$k]["val"] = date("Y-m", strtotime($year[$k]["date"]));
            $year[$k]["tot_to"] = $this->Entrance->cnt($year[$k]["val"]);
        }
        $this->assigns["year"] = $year;
        
    }
    
    public function monthly_locker($date = '') 
    {
        $this->assigns_layout["gnb"] = "locker";
        $this->assigns_layout["gnb_left"] = "monthly_locker";

        if ($_REQUEST["year"]) $date = $_REQUEST["year"]."-".$_REQUEST["month"];
        if (!$date) {
            $time = time(); 
//            $date = date('Y-m', strtotime("-1 month", $time));
            $date = date('Y-m');
        }
        $year_ = array();
        for ($y=2012; $y<date("Y")+1; $y++) {
            array_push($year_, $y);
        }
        
        if ($_REQUEST["m_locker"]) {
            $this->Code->set_value($_REQUEST["m_locker_id"], $_REQUEST["m_locker"]);
        }
        $this->assigns["year_"] = $year_;
        $res_cnt = $this->Entrance->get_cnt($date);
        $already_cnt = $this->Locker_month->get_cnt($date, 'state = 1');
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["already_cnt"] = $already_cnt;
        $this->assigns["date_"] = $date;
        $m_locker = $this->Code->get_by_key('m_locker', "id, _value");
        $this->assigns["m_locker"] = $m_locker[0];
    }
    
//    public function locker_analytics() 
//    {
//        $this->assigns_layout["gnb"] = "locker";
//        $this->assigns_layout["gnb_left"] = "locker_analytics";
//    }

    public function locker_analytics()
    {
        $this->assigns_layout["gnb"] = "locker";
        $this->assigns_layout["gnb_left"] = "locker_analytics";
        $_year = $_REQUEST["y"];
        if (!$_year) $_year = date('Y');
        $res = '';
        $res_cnt = 0;
        for ($i=1; $i<13; $i++) {
            if ($i > 9) {
                $cnt = $this->Locker_month->get_by_month_cnt($_year."-".$i, "state = 1");
                $date = $_year.$i;
            } else {
                $cnt = $this->Locker_month->get_by_month_cnt($_year."-0".$i, "state = 1");
                $date = $_year."0".$i;
            }
            $res = $res . "['01-".date('M-y', strtotime($date."01"))."',".$cnt."],";
            $res_cnt = $res_cnt + $cnt;
        }
        for ($j=2012; $j<date("Y")+1; $j++) {
            $y[$j] = $j;
        }
        $this->assigns["c_year"] = $_year;
        $this->assigns["year"] = $y;
        $this->assigns["res"] = substr($res, 0, -1);
        $this->assigns["amount"] = $res_cnt / 12;
    }

    public function analytics_excel($_term = 0)
    {
        if (($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1){
            header("Location: /");
        }

        $this->layout = "";
        $where = "";
        $t = "전체";
        if ($_term == 0) {
            $str = str_replace(".", "-", $_REQUEST["start"]);
            $end = str_replace(".", "-", $_REQUEST["end"]);
            $where = "date_in >= '".$str." 00:00:00' and date_in <= '".$end." 24:59:59'";
            $t = $str." ~ ".$end;
        }
        else if ($_term > 1) {
            if ($_term == 2) $en = date("Y-m-d", strtotime(date("Y-m-d")." -1 month"));
            if ($_term == 3) $en = date("Y-m-d", strtotime(date("Y-m-d")." -3 month"));
            if ($_term == 4) $en = date("Y-m-d", strtotime(date("Y-m-d")." -6 month"));
            if ($_term == 5) $en = date("Y-m-d", strtotime(date("Y-m-d")." -12 month"));
            $where = "date_in > '".$en."'";
            $t = $en." ~ ".date("Y-m-d");
        }
 
        $res = $this->Entrance->list_e(1, '', '', $where);
        $len_res = sizeof($res);

        header( "Content-type: application/vnd.ms-excel; charset=euc-kr" );
        header( "Content-Disposition: attachment; filename=entrance_analytics_".date("Ymd").".xls" );
        header( "Content-Description: PHP4 Generated Data" );
        Print("<Meta Http-Equiv=\"Content-Type\" Content=\"Application/Vnd.Ms-Excel; Charset=UTF-8\">");

        echo "
        <table>
        <tr>
        <td>id</td>
        <td>회원등급</td>
        <td>아이디</td>
        <td>이름</td>
        <td>이메일</td>
        <td>전화번호</td>
        <td>가입일</td>
        <td>기간 별(".$t.") 방문 횟수</td>
        <td>memo</td>
        </tr>
        ";

        for($i=0; $i<$len_res; $i++) {
            if ($res[$i]["grade"] == 0) $grade = "관리자";
            else if ($res[$i]["grade"] == 1) $grade = "일반회원";
            else if ($res[$i]["grade"] == 2) $grade = "멤버십 회원";
            else if ($res[$i]["grade"] == 3) $grade = "인포데스크";
            else if ($res[$i]["grade"] == 4) $grade = "투자자";
            else if ($res[$i]["grade"] == 5) $grade = "비즈니스센터 입주기업 회원";
            echo "<tr><td>".$res[$i]["id"]."</td><td>".$grade."</td><td>".$res[$i]["ids"]."</td><td>".$res[$i]["name"]."</td><td>".$res[$i]["email"]."</td><td>".$res[$i]["tel"]."</td><td>".$res[$i]["date_created"]."</td><td>".$res[$i]["cnt"]."</td><td>".$res[$i]["admin_des"]."</td></tr>";
        }
        
        echo "
        </table>
        ";
        exit(1);
    }
}
?>
