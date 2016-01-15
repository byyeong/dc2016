<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * 
 * violet@userstorylab.com
 */

class Admin_main extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "admin";
    var $use_models = array("Main", "Event", "Notice", "Banner", "Event_type", "Competitions"
            , "Content", "Members", "Recommend", "Startup", "Space_reserve", "Event", "Content"
            , "Competitions", "Office_hours", "Office_mento", "Faq", "Recruit");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "main";
        $this->assigns_layout["gnb_title"] = "메인 콘텐츠 관리";
        if (($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1){
            header("Location: /login");
        }
        $this->assigns_layout["s"] = $_SESSION["s"];
        $this->assigns["s"] = $_SESSION["s"];
    }
    
    public function index()
    {
        $this->assigns_layout["gnb_left"] = "main";

        if ($_REQUEST["save"]) {
            $a_event = '';
            $a_news = '';
            for ($i=1; $i<13; $i++) {
                $type = "type_".$i;
                $cid = "cid_".$i;
                if (!$_REQUEST[$cid]) $_REQUEST[$type] = "";
                $this->Main->edit($i, $_REQUEST[$type], $_REQUEST[$cid]);
                if ($_REQUEST[$type] == 1) $a_event = $a_event . $_REQUEST[$cid] . ",";
                if ($_REQUEST[$type] == 2) $a_news = $a_news . $_REQUEST[$cid] . ",";
                if ($_REQUEST[$type] == 3) $a_people = $a_people . $_REQUEST[$cid] . ",";
                if ($_REQUEST[$type] == 4) $a_startup = $a_startup . $_REQUEST[$cid] . ",";
                if ($_REQUEST[$type] == 7) $a_comp = $a_comp . $_REQUEST[$cid] . ",";
                if ($_REQUEST[$type] == 5) $a_cont = $a_cont . $_REQUEST[$cid] . ",";
                if ($_REQUEST[$type] == 10) $a_ben = $a_ben . $_REQUEST[$cid] . ",";
            }
            $this->Event->edit_main(substr($a_event, 0, -1));
            $this->Notice->edit_main(substr($a_news, 0, -1));
            $this->Competitions->edit_main(substr($a_comp, 0, -1));
            $this->Content->edit_main(substr($a_cont, 0, -1));
            $this->assigns["msg"] = "저장되었습니다.";
        }
        $this->assigns["res"] = $this->Main->list_();
    }
    
    public function banner()
    {
        $this->assigns_layout["gnb_left"] = "banner";
        if ($_REQUEST["sid"]) {
            $_id = $this->Banner->add($_REQUEST);
            
            if ($_REQUEST["pic_1"]) {
                $img_temp_name = str_replace(" ","",$_REQUEST['pic_1']);

                $ck = substr($img_temp_name, 0, 1);
                if($ck=='/'){
                    $img_temp_name = substr($img_temp_name, 1, strlen($img_temp_name) -1 );
                }

                $file_ext = explode('.',$img_temp_name);
                //$filename = basename($_FILES['file']['name']);
                $file_ext = '.'.$file_ext[sizeof($file_ext)-1];

                $original_file = $this->settings->root_path.$img_temp_name;
                $copy_file = $this->settings->root_path.'media/banner/1_'.$_id.$file_ext;

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/banner/1_'.$_id.$file_ext;
                $this->Banner->add_picture('pic_1', $_pic, $_REQUEST["id"]);
            }
            if ($_REQUEST["pic_2"]) {
                $img_temp_name = str_replace(" ","",$_REQUEST['pic_2']);

                $ck = substr($img_temp_name, 0, 1);
                if($ck=='/'){
                    $img_temp_name = substr($img_temp_name, 1, strlen($img_temp_name) -1 );
                }

                $file_ext = explode('.',$img_temp_name);
                //$filename = basename($_FILES['file']['name']);
                $file_ext = '.'.$file_ext[sizeof($file_ext)-1];

                $original_file = $this->settings->root_path.$img_temp_name;
                $copy_file = $this->settings->root_path.'media/banner/2_'.$_id.$file_ext;

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/banner/2_'.$_id.$file_ext;
                $this->Banner->add_picture('pic_2', $_pic, $_REQUEST["id"]);
            }
            if ($_REQUEST["pic_3"]) {
                $img_temp_name = str_replace(" ","",$_REQUEST['pic_3']);

                $ck = substr($img_temp_name, 0, 1);
                if($ck=='/'){
                    $img_temp_name = substr($img_temp_name, 1, strlen($img_temp_name) -1 );
                }

                $file_ext = explode('.',$img_temp_name);
                //$filename = basename($_FILES['file']['name']);
                $file_ext = '.'.$file_ext[sizeof($file_ext)-1];

                $original_file = $this->settings->root_path.$img_temp_name;
                $copy_file = $this->settings->root_path.'media/banner/3_'.$_id.$file_ext;

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/banner/3_'.$_id.$file_ext;
                $this->Banner->add_picture('pic_3', $_pic, $_REQUEST["id"]);
            }
            $this->assigns["msg"] = "수정되었습니다.";
        }
        $this->assigns["res"] = $this->Banner->all();
    }

    public function dashboard()
    {
        $this->layout = "";

        $w = "";
        if ($_REQUEST["terms"] == 1) {
            $st = date('Y-m-d',strtotime("-1 week",time()));
            $ed = date('Y-m-d',strtotime("+1 day",time()));
        }
        else if ($_REQUEST["terms"] == 2) {
            $st = date('Y-m-d',strtotime("-1 month",time()));
            $ed = date('Y-m-d',strtotime("+1 day",time()));   
        }
        else if ($_REQUEST["terms"] == 3) {
            $st = $_REQUEST["start"];
            $ed = $_REQUEST["end"];
        }
        if ($ed) $ed = $ed." 23:59:59";

        if ($st && $ed) {
            $w = " and date_created >= '".$st."' and date_created <= '".$ed."'";
        }
        $u["u_1"] = $this->Members->cnt("state = 1".$w);
        $u["u_0"] = $this->Members->cnt("state = 0".$w);
        $u["u_2"] = $this->Members->cnt("state = 2".$w);
        $u["u_3"] = $this->Members->cnt("state = 3".$w);


        $wm = "";
        if ($w) {
            $wm = " and r.date_created >= '".$st."' and r.date_created <= '".$ed."'";
        }
        $m["s_1"] = $this->Recommend->cnt("r.state = 1 and m.state = 1".$wm);
        $m["s_0"] = $this->Recommend->cnt("r.state = 0".$wm);
        $m["s_2"] = $this->Recommend->cnt("r.state = 2".$wm);
        $m["s_3"] = $this->Recommend->cnt("m.state = 3".$wm);

        $c["s_1"] = $this->Startup->cnt("state = 1".$w);
        $c["s_0"] = $this->Startup->cnt("state = 0".$w);
        $c["s_2"] = $this->Startup->cnt("state = 2".$w);

        $r["s_1"] = $this->Recruit->cnt("", "state = 1".$w);
        $r["s_0"] = $this->Recruit->cnt("", "state = 0".$w);
        $r["s_2"] = $this->Recruit->cnt("", "state = 9".$w);

        $ws = "";
        if ($w) {
            $ws = " and sr.date_created >= '".$st."' and sr.date_created <= '".$ed."'";
        }
        $s["s_1"] = $this->Space_reserve->cnt("sr.state = 1".$ws);
        $s["s_0"] = $this->Space_reserve->cnt("sr.state = 0".$ws);
        $s["s_2"] = $this->Space_reserve->cnt("sr.state = 2".$ws);

        $e["s_1"] = $this->Event->cnt("state = 1".$w);
        $e["s_0"] = $this->Event->cnt("state = 0".$w);
        $e["s_2"] = $this->Event->cnt("state = 2".$w);

        $wcon = "";
        if ($w) {
            $wcon = " and c.date_created >= '".$st."' and c.date_created <= '".$ed."'";
        }
        $con["s_1"] = $this->Content->cnt("c.state = 1".$wcon);
        $con["s_0"] = $this->Content->cnt("c.state = 0".$wcon);

        $oc["s_1"] = $this->Competitions->cnt("CONCAT(date_s, time_s) <= '".date('Y.m.dH:i')."' && CONCAT(date_e, time_e) > '".date('Y.m.dH:i')."'".$w);
        $oc["s_0"] = $this->Competitions->cnt("CONCAT(date_e, time_e) < '".date('Y.m.dH:i')."'".$w);

        $oh["s_1"] = $this->Office_hours->cnt("a_start <= '".date("Y.m.d H:i")."' and a_end >= '".date("Y.m.d H:i")."'".$w);
        if ($w)
            $oh["s_2"] = $this->Office_mento->cnt("date_created >= '".$st."' and date_created <= '".$ed."'");
        else
            $oh["s_2"] = $this->Office_mento->cnt();


        $q["s_1"] = $this->Faq->cnt("type= 2 and re_suc = 1".$w);
        $q["s_0"] = $this->Faq->cnt("type= 2 and re_suc = 0".$w);
        $q["s_2"] = $this->Faq->cnt("type= 2".$w);

        //monthly통계 옵션값
        $option_year = 2013;
        $option_month = 3;
        $option = '';

        while($option_year <= intval(date("Y"))){
            while($option_month <= 12){
                if($option_year == intval(date("Y")) && $option_month > intval(date("m"))) break;
                $option = '<option data-year="'.$option_year.'" data-month="'.$option_month.'">'.$option_year.'/'.$option_month.'</option>'.$option;
                $option_month++;
            }
            $option_year++;
            $option_month = 1;
        }

        $this->assigns["option"] = $option;
        $this->assigns["u"] = $u;
        $this->assigns["m"] = $m;
        $this->assigns["co"] = $c;
        $this->assigns["re"] = $r;
        $this->assigns["ss"] = $s;
        $this->assigns["e"] = $e;
        $this->assigns["con"] = $con;
        $this->assigns["oc"] = $oc;
        $this->assigns["oh"] = $oh;
        $this->assigns["q"] = $q;
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns["terms"] = $_REQUEST["terms"];
        $this->assigns["start"] = $st;
        $this->assigns["end"] = $ed;






    }

}
?>
