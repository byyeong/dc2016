<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Event extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "default";
    var $use_models = array("Event","Event_reserve", "Event_type", "Space", "Activity", "Startup_member"
            , "Startup_service", "Startup_bussiness", "Startup_tech", "Competitions_apply", "Code"
            , "Books", "Space_reserve", "Banner", "Competitions", "Board", "Entrance");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "event";
        $this->assigns_layout["gnb_title"] = "이벤트";
        $this->assigns_layout["con"] = get_contents_category();
        $this->assigns_layout["s"] = $_SESSION["s"];
        $this->assigns["s"] = $_SESSION["s"];
    }
    
    public function index($_status = 'ing', $_page = 1)
    {
        $pagesize = 16;
        $where = "e.en < 2 and e.state = 1 and open = 1 ";

        if ($_status == 'ing') $where = $where .' and concat(e.date_e, e.end) >= "'. date('Y.m.dH:i').'"';
        else if ($_status == 'end') $where = $where .' and  concat(e.date_e, e.end) < "'. date('Y.m.dH:i').'"';

        if ($_REQUEST["type"]) $where = $where." and et.id = ".$_REQUEST["type"];

        $order = "";  
        if ($_REQUEST["order"]) $order= 'CONCAT(e.date_e, e.end) ASC';

        $res = $this->Event->list_($_page, $pagesize, $where, 1, $order);

        $this->assigns["res"] = $res;
        $this->assigns["page"] = $_page;
        $this->assigns["status"] = $_status;
        $this->assigns["type"] = $_REQUEST["type"];
        $this->assigns["order"] = $_REQUEST["order"];
        $this->assigns["type_l"] = $this->Event_type->list_(1, 100);
        $this->assigns["banner"] = $this->Banner->get_one(5);
        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }

    public function index_o($_page = 1)
    {
        $pagesize = 3;
        $res = $this->Event->list_($_page, $pagesize, '', 1);
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            if ($res[$i]["state"] == 1) {
                $tmp_s = $res[$i]["date"]. " ".$res[$i]["start"];
                $tmp_e = $res[$i]["date"]. " ".$res[$i]["end"];
                $tmp_c = date("Y-m-d H:i");
                if ($tmp_c > $tmp_e)
                    $res[$i]["state_expand"] = "end";
                else if ($tmp_c > $tmp_s && $tmp_c < $tmp_e)
                    $res[$i]["state_expand"] = "ing";
                else
                    $res[$i]["state_expand"] = "before";
            }
        }
        $res_cnt = $this->Event->cnt();
        $this->assigns["c_res"] = $this->Event->get_by_date(date("Y/m/d"));
        $this->assigns["res"] = $res;
        $this->assigns["page"] = $_page;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);
    }
    
    public function apply($_id)
    {
        $this->Event->pageview($_id);
        $this->assigns["s"] = $_SESSION["s"];
        $already = $this->Event_reserve->check($_id, $_SESSION["s"]["id"]);

        $res = $this->Event->get_detail($_id);
        if(!$res["end"]) $res["end"] = "23:59";
        $this->assigns["res"] = $res;
        $this->assigns["res_s"] = $this->Event->list_(1, 5, 'e.id != '.$_id.' and e.state = 1 and e.open = 1 and e.apply_end > "'.date("Y.m.d H:i").'"');
        $this->assigns["res_c"] = $this->Competitions->get_list(1, 5, 'c.status = 1 and c.open = 1 and c.date_s <= "'. date('Y.m.d').'" and c.date_e >= "'. date('Y.m.d').'"');
        $this->assigns["part"] = $this->Event_reserve->list_(1, 1000, "er.state = 1 and event_id = ".$_id);
        $this->assigns["part2"] = $this->Event_reserve->list_(1, 1000, "er.state = 0 and event_id = ".$_id);
        if ($already) {
            $this->assigns["already"] = $already;
        }
        
        $og["type"] = 'article';
        $og["url"] = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
        $og["title"] = $this->assigns["res"]["title"]." on D.CAMP";
        $og["description"] = $this->assigns["res"]["summary"];
        if (strlen(strip_tags($this->assigns["res"]["summary"])) > 150) $og["description"] = mb_substr(strip_tags($this->assigns["res"]["summary"]), 0, 150, 'UTF-8').'...';
        $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].$this->assigns["res"]["picture"];
        if (!$this->assigns["res"]["picture"]) $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].$this->assigns["res"]["mpicture"];
        $this->assigns_layout["og"] = $og;
        // echo date("YmdHi00",strtotime ("-9 hour", strtotime(str_replace(".", "", $res["date"]).str_replace(":", "", $res["start"]))));
        $this->assigns["g_start"] = date("YmdHi00",strtotime ("-9 hour", strtotime(str_replace(".", "", $res["date"]).str_replace(":", "", $res["start"]))));
        $this->assigns["g_end"] = date("YmdHi00",strtotime ("-9 hour", strtotime(str_replace(".", "", $res["date_e"]).str_replace(":", "", $res["end"])))); 
        
        // lounge box
        $today_ev_users = $this->Event_reserve->list_(1, 100, "e.space_id > 0 and er.state = 1 and date = '".date("Y.m.d")."'");
        $today_dcamp_users = $this->Entrance->list_('', '', '', 'date_out IS NULL and date_in LIKE "'.date("Y-m-d").'%" GROUP BY m.id ');

        $comments = $this->Board->list_(Board_model::EVENT_TYPE, 0, 1, 5);
        for ( $i=0; $i<sizeof($comments); $i++ ){
            if ($comments[$i]["p_id"] > 0 ) {
                $e = $this->Event->get($comments[$i]["p_id"]);
                $comments[$i]["p_name"] = $e["title"];
                
            }
            $com = $this->Board->get_comment($_type = 3, $comments[$i]["id"]);
            $comments[$i]["com"] = sizeof($com); 
            $comments[$i]["like"] = $this->Board->get_like_cnt($comments[$i]["id"]);
        }
        
        $this->assigns["lounge"] = $comments;
        $this->assigns["u_cnt"] = sizeof($today_ev_users) + sizeof($today_dcamp_users);
        // lounge box

        if (!strpos($_SERVER["HTTP_REFERER"], "dcamp.kr")) {
            $this->assigns_layout["cards"] = bottom_main();
        }
        
        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }
    
    public function add($_id = '')
    {

        $this->assigns["space"] = $this->Space->list_(1,1000, $order="visible = 1");
        $this->assigns["type"] = $this->Event_type->list_(1,1000, $order="visible = 1");
        $this->assigns["sp"] = $this->Space_reserve->list_(1, 100, 'user_id = '.$_SESSION["s"]["id"]." and sr.state = 1 and date > '".date('Y.m.d', strtotime("+1 day"))."'");
        if ($_id) {
            $res = $this->Event->get_detail($_id);
            if ($res["user_id"] == $_SESSION["s"]["id"]) $this->assigns["res"] = $res;
            else header("Location: /member/edit_event_m");
        }
        if ($_REQUEST["sp"]) {
            $r = $this->Space_reserve->get($_REQUEST["sp"]);
            $res["title"] = $r["purpose"];
            $res["space_id"] = $r["space_id"];
            $res["date"] = $r["date"];
            $res["date_e"] = $r["date"];
            $res["start"] = $r["start"];
            $res["end"] = $r["end"];
            $res["p_space"] = $r["id"];
            $this->assigns["res"] = $res;
        }

    }

    public function info($_id)
    {
        $this->assigns_layout["gnb_left"] = "event";
        
        $res = $this->Event->get_detail($_id);
        $this->assigns["res"] = $res;
        
        if ($res["user_id"] != $_SESSION["s"]["id"]) {
            header("Location: /member/edit_event_m");
        }
    }
    
    public function add_process()
    {
            
        $payment = 0;
        if(array_key_exists('payment1',$_REQUEST)) $payment = $payment | $this->settings->payment1;
        else $payment = $payment & (~$this->settings->payment1);
        if(array_key_exists('payment2',$_REQUEST)) $payment = $payment | $this->settings->payment2;
        else $payment = $payment & (~$this->settings->payment2);
        if(array_key_exists('payment3',$_REQUEST)) $payment = $payment | $this->settings->payment3;
        else $payment = $payment & (~$this->settings->payment3);
        if(array_key_exists('payment4',$_REQUEST)) $payment = $payment | $this->settings->payment4;
        else $payment = $payment & (~$this->settings->payment4);
        $_REQUEST['payment'] = $payment;
        if ($_REQUEST["space"] == 0) {
            $_REQUEST["space_id"] = 0;
        }
        else {
            $_REQUEST["space_etc"] = null;
        }

        $_id = $this->Event->add($_REQUEST);

        if ($_REQUEST["pic"]) {
            $img_temp_name = str_replace(" ","",$_REQUEST['pic']);

            $ck = substr($img_temp_name, 0, 1);
            if($ck=='/'){
                $img_temp_name = substr($img_temp_name, 1, strlen($img_temp_name) -1 );
            }

            $file_ext = explode('.',$img_temp_name);
            //$filename = basename($_FILES['file']['name']);
            $file_ext = '.'.$file_ext[sizeof($file_ext)-1];

            $original_file = $this->settings->root_path.$img_temp_name;
            $copy_file = $this->settings->root_path.'media/event/'.$_id.$file_ext;
            
            GD2_make_thumb_x(300, "", $original_file);

            //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
            copy($original_file, $copy_file);
            unlink($original_file); 

            $_pic = '/media/event/'.$_id.$file_ext;
            $this->Event->add_picture($_id, $_pic);
        }
        
        if ($_REQUEST["del_file"]) {
            $this->Event->add_file($_id, '');
            unlink('media/event_file/'.$_REQUEST["del_file"]);
        }
        if ($_FILES["file"]["name"]) {
            $file = make_upload("/media/event_file/", "file");
            if ($file) $this->Event->add_file($_id, $file, $_FILES["file"]["name"]);
        }

        add_activity(1, $_REQUEST["user_id"], 1, $_REQUEST["user_id"], 0, "", Activity_model::A_TYPE_EVENT, $_id, 1);
        
        $_SESSION["msg"] = "이벤트가 신청되었습니다.<br />관리자 승인이 완료되면 이벤트 페이지에 노출됩니다.";
        header("Location: /member/edit_event_m");
    }
    
    public function del_event($_id)
    {
        $res = $this->Event->get($_id);
        if ($res["user_id"] == $_SESSION["s"]["id"]) {
            $this->Event->delete($_id);
            $_SESSION["msg"] = "이벤트가 삭제되었습니다.";
            header("Location: /member/edit_event_m");
        }
    }

    public function daily_review()
    {
        $this->tpl_name = "";
        $date = date('Y.m.d');
        $_date = date("Y.m.d", strtotime(str_replace(".", "-", $date)." -1 day"));
        $res = $this->Event->list_($_page, $pagesize, 'e.date_e = "'.$_date.'" and e.state = 1 and e.open = 1');
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            $ap = $this->Event_reserve->list_(1, 1000, 'er.state = 1 and event_id = '.$res[$i]["id"]);
            $len_ap = sizeof($ap);
            for ($a=0; $a<$len_ap; $a++) {
                echo $ap[$a]["email"]."<br>";

                $m = new TF_mailer($this->settings);
                $m->mailto = $ap[$a]["email"];
                $m->subject = "[D.CAMP] ".$ap[$a]["mname"]."님, 어제 참여한 이벤트의 후기를 남겨주세요.";
                $m->tpl_name = "event_review";
                $m->assigns["res"] = $res[$i];
                $m->assigns["main_service_url"] = $this->globals->my_host;
                $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                $m->send();
            }
        }
        echo "<br>".date('Y-m-d H:i');
        exit(1);
    }

    public function promotions()
    {
        $res = $this->Startup_member->get_list_by_user($_SESSION["s"]["id"], "sm.status = 1");
        $bis = $this->Startup_bussiness->get_by_member_c($res[0]["startup_id"]);
        $tech = $this->Startup_tech->get_by_member_c($res[0]["startup_id"]);
        if ($res[0]["id"]) {
            $lack = false;
            $lack_cnt = 0;
            if (!$res[0]["sname"]) {
                $res[0]["lack_1"] = true;
                $lack = true;
                $lack_cnt++;
            }
            if (!$res[0]["bio"]) {
                $res[0]["lack_2"] = true;
                $lack = true;
                $lack_cnt++;
            }
            if (!$res[0]["founded"]) {
                $res[0]["lack_3"] = true;
                $lack = true;
                $lack_cnt++;
            }
            if (!$res[0]["number"]) {
                $res[0]["lack_4"] = true;
                $lack = true;
                $lack_cnt++;
            }
            if (sizeof($bis) < 1) {
                $res[0]["lack_5"] = true;
                $lack = true;
                $lack_cnt++;
            }
            if (sizeof($tech) < 1) {
                $res[0]["lack_6"] = true;
                $lack = true;
                $lack_cnt++;
            }
            if (!$res[0]["email"]) {
                $res[0]["lack_7"] = true;
                $lack = true;
                $lack_cnt++;
            }
            if (!$res[0]["description"]) {
                $res[0]["lack_8"] = true;
                $lack = true;
                $lack_cnt++;
            }

            $ser = $this->Startup_service->list_($res[0]["startup_id"]);

            $res[0]["lack_9"] = true;
            $res[0]["lack_10"] = true;
            $res[0]["lack_11"] = true;
            $res[0]["lack_12"] = true;
            $lack_o = $lack;
            $lack = true;

            for ($i=0; $i<sizeof($ser); $i++) {
                
                if ($ser[$i]["name"]) {
                    $res[0]["lack_9"] = false;
                }
                if ($ser[$i]["des_ele"]) {
                    $res[0]["lack_10"] = false;
                }
                if ($ser[$i]["des_pro"]) {
                    $res[0]["lack_11"] = false;
                }
                if ($ser[$i]["des_sol"]) {
                    $res[0]["lack_12"] = false;
                }
            }

            if ($res[0]["lack_9"] == true) $lack_cnt++;
            if ($res[0]["lack_10"] == true) $lack_cnt++;
            if ($res[0]["lack_11"] == true) $lack_cnt++;
            if ($res[0]["lack_12"] == true) $lack_cnt++;

            if ($lack_o == false && ($res[0]["lack_9"] == false || $res[0]["lack_10"] == false 
                    || $res[0]["lack_11"] == false || $res[0]["lack_12"] == false ))  {
                $lack = false;
            }

            $this->assigns["lack"] = $lack;
            $this->assigns["lack_cnt"] = $lack_cnt;
        }

        $this->assigns["res"] = $res;

        $og["type"] = 'article';
        $og["url"] = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
        $og["title"] = "D.CAMP Online 정식 서비스 기념 이벤트!";
        $og["description"] = "'새로운 봄, 나는 목표한다.' 2014년, 여러분의 스타트업이 이루고자 하는 목표는? D.CAMP가 여러분의 스타트업을 홍보 영상 제작을 지원합니다!";
        $og["image"] = 'http://'.$_SERVER['SERVER_NAME']."/img/event0304/banner_300x300.png";
        $this->assigns_layout["og"] = $og;

    }

    public function promotions_res($_id, $_excel = '')
    {
        if (($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1){
            header("Location: /");
        }
        $res = $this->Competitions_apply->get_promotions($_id);
        if ($_excel) {

            $len_res = sizeof($res);

            header( "Content-type: application/vnd.ms-excel; charset=euc-kr" );
            header( "Content-Disposition: attachment; filename=promotions0306.xls" );
            header( "Content-Description: PHP4 Generated Data" );
            Print("<Meta Http-Equiv=\"Content-Type\" Content=\"Application/Vnd.Ms-Excel; Charset=UTF-8\">");

            echo "
            <table>
            <tr>
            <td>id</td>
            <td>참가자</td>
            <td>참가자 url</td>
            <td>참가자 email</td>
            <td>스타트업</td>
            <td>스타트업 url</td>
            <td>회사설명</td>
            <td>목표</td>
            <td>참가시간</td>
            </tr>
            ";

            for($i=0; $i<$len_res; $i++) {
                $j = $i+1;
                echo "<tr><td>".$j."</td><td>".$res[$i]["name"]."</td><td>http://www.dcamp.kr/member/".$res[$i]["ids"]."</td><td>".$res[$i]["email"]."</td><td>".$res[$i]["sname"]."</td><td>http://www.dcamp.kr/startup/".$res[$i]["id"]."</td><td>".$res[$i]["file"]."</td><td>".$res[$i]["form"]."</td><td>".$res[$i]["date_created"]."</td></tr>";
            }

            echo "
            </table>
            ";
            exit(1);
        }
        else {
            $this->assigns["res"] = $res;
        }
     }

     public function book_promotions()
     {
        $_key = 'field';
        $result = $this->Code->get_by_key($_key);
        $items = array();
        for ($i=0; $i<sizeof($result); $i++) {
            $result[$i]["value"] = $result[$i]["_value"];
            array_push($items, $result[$i]);
        }
        $_key2 = 'jobs';
        $result2 = $this->Code->get_by_key($_key2);
        $items2 = array();
        for ($j=0; $j<sizeof($result2); $j++) {
            $result2[$j]["value"] = $result2[$j]["_value"];
            array_push($items2, $result2[$j]);
        }     
        $_key3 = 'market';
        $result3 = $this->Code->get_by_key($_key3);
        $items3 = array();
        for ($j=0; $j<sizeof($result3); $j++) {
            array_push($items3, $result3[$j]["_value"]);
        }
        $this->assigns["market"] =  json_encode($items3);
        $this->assigns["job"] =  json_encode($items2);
        $this->assigns["skill"] =  json_encode($items2);

        $today = date("Y.m.d");
        if (date("H") < 12) {
            $today = date("Y.m.d", strtotime("-1 day"));
        }
        $this->assigns["today"] = $today;
        $this->assigns["t_res"] = $this->Books->list_("dates = '".$today."'");
        $this->assigns["passed"] = $this->Books->list_("dates < '".$today."'", "dates DESC");
        $this->assigns["scheduled"] = $this->Books->list_("dates > '".$today."'");

        $og["type"] = 'article';
        $og["url"] = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
        $og["title"] = "스타트업 선배 창업자, 멘토들이 선정한 창업자 필독서 30선 on D.CAMP";
        $og["description"] = "창업, 어떤 책들을 봐야하죠? 4월 한달간 매일 매일 스타트업 멘토가 추천하는 창업자 필독서를 디캠프 이벤트 페이지에서 만나보세요!";
        $og["image"] = 'http://'.$_SERVER['SERVER_NAME']."/img/event0401/book_promotion_banner_318x318.jpg";
        $this->assigns_layout["og"] = $og;
     }

    public function get_ev_source()
    {

        $this->tpl_name = "";
        $ev = $this->Event->get($_REQUEST["ev"]);
        
        $filename = trim($ev["file"]); 
        $file = "./media/event_file/$filename"; 
        $file_size = filesize($file); 
        $filename = urlencode("$filename");


        if( strpos($_SERVER['HTTP_USER_AGENT'], 'MSIE') || strpos($_SERVER['HTTP_USER_AGENT'], 'Trident') ) { 
        
            $_REQUEST['file'] = iconv('utf-8', 'euc-kr', $_REQUEST['file']);

            header("Content-Type: doesn/matter"); 
            Header("Content-Length: ".filesize("$file"));
            Header("Content-Disposition: attachment; filename=".trim($_REQUEST['file'])); 
            header("Content-Transfer-Encoding: binary"); 
            header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
            header('Pragma: public');
            header("Expires: 0"); 
        
        } else { 

            Header("Content-type: file/unknown"); 
            Header("Content-Disposition: attachment; filename=".trim($_REQUEST['file'])); 
            Header("Content-Transfer-Encoding: binary");
            Header("Content-Length: ".filesize($file));
            Header("Content-Description: PHP3 Generated Data"); 
            header("Pragma: no-cache"); 
            header("Expires: 0"); 
        } 

        if (is_file("$file")) { 
            $fp = fopen("$file", "r"); 
        if (!fpassthru($fp)) 
            fclose($fp); 
        }
    }

     public function get_source()
     {
        // if (!$_SESSION["s"]) {
        //     $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
        //     header("Location: /");
        // }
        
        $this->tpl_name = "";
        
        $filename = trim($_REQUEST["file"]); 
        $file = "./media/event_file/$filename"; 
        $file_size = filesize($file); 
        $filename = urlencode("$filename");

        // 접근경로 확인 
//        if (!eregi($_SERVER['HTTP_HOST'], $_SERVER['HTTP_REFERER'])) Error("외부에서는 다운로드 받으실수 없습니다."); 

        if(strstr($HTTP_USER_AGENT, "MSIE 5.5")) { 
        header("Content-Type: doesn/matter"); 
        Header("Content-Length: ".filesize("$file"));
        header("Content-Disposition: filename=$filename"); 
        header("Content-Transfer-Encoding: binary"); 
        header("Pragma: no-cache"); 
        header("Expires: 0"); 
        } else { 
        Header("Content-type: file/unknown"); 
        Header("Content-Disposition: attachment; filename=$filename"); 
        Header("Content-Transfer-Encoding: binary");
        Header("Content-Length: ".filesize($file));
        Header("Content-Description: PHP3 Generated Data"); 
        header("Pragma: no-cache"); 
        header("Expires: 0"); 
        } 

//        if( $ret == 1 ) Error("지정하신 파일이 없습니다."); 
//        if( $ret == 2 ) Error("접근불가능 파일입니다. 정상 접근 하시기 바랍니다."); 

        if (is_file("$file")) { 
        $fp = fopen("$file", "r"); 
        if (!fpassthru($fp)) 
        fclose($fp); 
        }
     }
}
?>
