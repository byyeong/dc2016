<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Competition extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "default";
    var $use_models = array("Competitions", "Competitions_score", "Competitions_examiner"
            , "Competitions_apply", "Startup_member", "Competitions_scoring", "Competitions_file"
            , "Competitions_files", "Activity", "Members");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "competition";
        $this->assigns_layout["gnb_title"] = "competition";
        $this->assigns_layout["con"] = get_contents_category();
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns_layout["s"] = $_SESSION["s"];
    }

    public function index($_status = 'all', $_page = 1)
    {
        $_pagesize = 10;
        $where = "c.status = 1 and c.open = 1 ";
        if ($_status == 'ing') $where = $where .' and concat(date_e, time_e) >= "'. date('Y.m.dH:i').'"';
        else if ($_status == 'end') $where = $where .' and  concat(date_e, time_e) < "'. date('Y.m.dH:i').'"';

        $order = "c.date_created DESC";
        if ($_REQUEST["type"]) $order = "concat(date_e, time_e) DESC";;  

        $res = $this->Competitions->get_list($_page, $_pagesize, $where, $order);

        $this->assigns["res"] = $res;
        $this->assigns["page"] = $_page;
        $this->assigns["status"] = $_status;
        $this->assigns["type"] = $_REQUEST["type"];
        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }

    private function sub()
    {
        $sub = $this->Competitions->get_list(1, 5, 'c.status = 1 and c.open = 1 and c.date_s <= "'. date('Y.m.d').'" and c.date_e >= "'. date('Y.m.d').'"');
        $this->assigns["sub"] = $sub;
    }

    public function views($_id)
    {
        if (!$_id) header("Location: /error_404");
        header("Location: /challenge/views/".$_id);
        $this->Competitions->pageview($_id);
        $res = $this->Competitions->get($_id);
        $my = $this->Competitions_apply->get_by_user($_id, $_SESSION["s"]["id"]);
        $ex = $this->Competitions_examiner->get_by_user($_SESSION["s"]["id"], "ce.competition_id = ".$_id);

        $this->assigns["res"] = $res;
        $this->assigns["my"] = $my;
        $this->assigns["ex"] = $ex;
        $this->sub();

        $og["type"] = 'article';
        $og["url"] = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
        $og["title"] = $res["subject"]." on D.CAMP";
        $og["description"] = strip_tags($res["contents"]);
        if (strlen(strip_tags($res["contents"])) > 150) $og["description"] 
                = mb_substr(strip_tags($res["contents"]), 0, 150, 'UTF-8').'...';
        $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].$res["img"];
        if (!$res["img"]) $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].$this->assigns["res"]["mpicture"];
        $this->assigns_layout["og"] = $og;
        $this->assigns["g_start"] = date("YmdHi00",strtotime ("-9 hour", strtotime(str_replace(".", "", $res["date_s"]).str_replace(":", "", $res["time_s"]))));
        $this->assigns["g_end"] = date("YmdHi00",strtotime ("-9 hour", strtotime(str_replace(".", "", $res["date_e"]).str_replace(":", "", $res["time_e"])))); 

        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }
    
    public function apply($_id, $_per = '')
    {
        if (!$_id) header("Location: /error_404");

        $res = $this->Competitions->get($_id);
        $file = $this->Competitions_file->get_by_comp($_id);
        $my = $this->Competitions_apply->get_by_user($_id, $_SESSION["s"]["id"]);
        if ($my && ! $_per) {
            $_SESSION["msg"] = "이미 참가신청이 접수되었습니다.";
            header("Location: /challenge/views/".$_id."/".$_per);
        }

        if ($_REQUEST["user_id"]) {
            $_per = $this->Competitions_apply->add($_REQUEST);
            
            if ($file) {
                $len_file = sizeof($file);
                for ($i=0; $i<$len_file; $i++) {
                    $f = null;
                    if ($_FILES["file_".$file[$i]["id"]]["name"]) {
                        $f = make_upload("/media/comp_file/", "file_".$file[$i]["id"]);
                        $_ar["file"] = $f;
                        $_ar["c_file_id"] = $file[$i]["id"];
                        $_ar["apply_id"] = $_per;
                        $this->Competitions_files->add($_ar);

                        if ($_REQUEST["o_file_".$file[$i]["id"]]) {
                            unlink($this->settings->root_path."media/comp_file/".$_REQUEST["o_file_".$file[$i]["id"]]);
                        }
                    }
                }
            }

            // activity
            if (!$_REQUEST["id"])
                add_activity(1, $_REQUEST["user_id"], 1, $_REQUEST["user_id"], 0, "", Activity_model::E_TYPE_COMPETITION, $_REQUEST["competition_id"], 0);

            $_SESSION["msg"] = "경진 대회 참가 신청이 접수되었습니다.";
            header("Location: /member/edit_challenge/");
            exit(1);
        }
        
        if ($_per) {
            $per = $this->Competitions_apply->get($_per);

            if ($per["user_id"] != $_SESSION["s"]["id"]) {
                header("Location: /error_404");
            }

            if ($_REQUEST["req"] == 'del') {
                if ($per["user_id"] == $_SESSION["s"]["id"]) {
                    $this->Competitions_apply->delete($_per);
                    $fi = $this->Competitions_files->get_by_apply($_per);
                    for ($ff=0; $ff<sizeof($fi); $ff++) {
                        unlink("media/comp_file/".$fi[$ff]["file"]);
                    }
                    header("Location: /member/edit_challenge");
                }
                else {
                    $this->assigns_layout["msg"] = "삭제 권한이 없습니다.";
                }
            }

            $this->assigns["per"] = $per;
        }
        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
        
        if ($_per && $file) {
            for ($j=0; $j<sizeof($file); $j++) {
                $f = $this->Competitions_files->get_by_file_user($file[$j]["id"], $_per);
                $file[$j][val] = $f["file"];
            }
        }
        $res["form_file"] = $file;
        $this->assigns["res"] = $res;
        $this->sub();
    }

    public function applied_list($_id, $_page = 1)
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }
        if (!$_id) header("Location: /error_404");

        $examiner = $this->Competitions_examiner->get_by_comp_user($_id, $_SESSION["s"]["id"]);
        $pagesize = 10;
        $sort = $_REQUEST["sort"];
        if (!$sort) $sort = 1;
        $res = $this->Competitions->get($_id);
        $where = "ca.competition_id = ".$_id;
        if ($_SESSION["s"]["id"] != $res["user_id"] && $examiner) $where = $where." and ca.status = 1";
        
        // $list = $this->Competitions_apply->list_($_page, $pagesize, $where);
        // for ($i=0; $i<sizeof($list); $i++) {
        //     if ($_SESSION["s"]["id"] == $res["user_id"]) {
        //         $list[$i]["score"] = $this->Competitions_scoring->get_tot_score($list[$i]["id"]);
        //     } else if ($examiner) {
        //         $list[$i]["score"] = $this->Competitions_scoring->get_tot_score($list[$i]["id"], $_SESSION["s"]["id"]);
        //     }
        // }

///////
        if ($_REQUEST["alig"] == "up") $_sort = "score ASC";
        else if ($_REQUEST["alig"] == "down") $_sort = "score DESC";
        if ($_SESSION["s"]["id"] == $res["user_id"]) {
            $list = $this->Competitions_apply->list_info($_page, $pagesize, $where, "", $_sort);
        }
        else if ($examiner) {
            $list = $this->Competitions_apply->list_info_by_user($_page, $pagesize, $where, $_SESSION["s"]["id"], $_sort);
        }

        for ($i=0; $i<sizeof($list); $i++) {
            $u = $this->Members->get($list[$i]["user_id"]);
            $list[$i]["ids"] = $u["ids"];
            $list[$i]["name"] = $u["name"];
            $list[$i]["memail"] = $u["email"];
            $list[$i]["bio"] = $u["bio"];
            $list[$i]["picture"] = $u["picture"];
        }
        // if ( ! $_REQUEST["alig"]) $_REQUEST["alig"] = "up";
        $this->assigns["alig"] = $_REQUEST["alig"];
///////

        $list_cnt = $this->Competitions_apply->cnt($where);
        $this->assigns["res"] = $res;
        $this->assigns["list"] = $list;
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["list_cnt"] = $list_cnt;
        $this->assigns["paging"] = get_paging_dot2($_page, $list_cnt, $pagesize);
        $this->assigns["sort"] = abs($sort);
        $this->sub();
        
        $this->assigns["m_list"] = $this->Competitions->get_list(1, 5, "c.user_id = ".$_SESSION["s"]["id"]);
        $this->assigns["e_list"] = $this->Competitions_examiner->list_all(1, 5, "ce.user_id = ".$_SESSION["s"]["id"]);
        $this->assigns["a_list"] = $this->Competitions_apply->list_all(1, 5, "ca.user_id = ".$_SESSION["s"]["id"]);
        if ($_SESSION["s"]["id"] != $res["user_id"] && !$examiner) 
            header("Location: /error_404");
    }

    public function applied_view($_id)
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }

        if (!$_id) header("Location: /error_404");

        $per = $this->Competitions_apply->get($_id);
        $per["com"] = $this->Startup_member->get_by_user($per["user_id"]);
        $res = $this->Competitions->get($per["competition_id"]);
        $file = $this->Competitions_file->get_by_comp($res["id"]);
        if ($file) {
            for ($j=0; $j<sizeof($file); $j++) {
                $f = $this->Competitions_files->get_by_file_user($file[$j]["id"], $_id);
                $file[$j][val] = $f["file"];
            }
        }
        $res["form_file"] = $file;
        
        $examiner = $this->Competitions_examiner->get_by_comp_user($res["id"], $_SESSION["s"]["id"]);
        $score = $this->Competitions_score->get_by_comp($res["id"]);
        for ($i=0; $i<sizeof($score); $i++) {
            $scoring = $this->Competitions_scoring->get_scoring($_SESSION["s"]["id"], $per["id"], $score[$i]["id"]);
            $score[$i]["scoring"] = $scoring["score"];
            $score[$i]["memo"] = $scoring["memo"];
        }
        
        $this->assigns["res"] = $res;
        $this->assigns["per"] = $per;
        $this->assigns["examiner"] = $examiner;
        $this->assigns["score"] = $score;
        if ($examiner) {
            $this->assigns["prev"] = $this->Competitions_apply->get_current($_id, $res["id"], 0, 'status = 1');
            $this->assigns["next"] = $this->Competitions_apply->get_current($_id, $res["id"], 1, 'status = 1');

            $this->assigns["cnt_all"] = $this->Competitions_apply->cnt('competition_id ='.$res["id"]." and ca.status = 1");
            $c = $this->Competitions_scoring->get_apply_by_ex_score($res["id"], $_SESSION["s"]["id"]);
            $this->assigns["cnt_end"] = sizeof($c);
        }
        if ($_SESSION["s"]["id"] == $res["user_id"]) {
            // 심사결과
            $ex_user = $this->Competitions_examiner->get_by_comp($res["id"]);
            for ($e=0; $e<sizeof($ex_user); $e++) {
                $total_ = 0;
                for ($s=0; $s<sizeof($score); $s++) {
                    $scoring = $this->Competitions_scoring->get_scoring($ex_user[$e]["user_id"], $per["id"], $score[$s]["id"]);
                    $total_ = $total_ + $scoring["score"];
                    $ex_user[$e]["score"][$s]["name"] = $score[$s]["name"];
                    $ex_user[$e]["score"][$s]["scoring"] = $scoring["score"];
                    $ex_user[$e]["score"][$s]["memo"] = $scoring["memo"];
                    $ex_user[$e]["total"] = $total_;
                }
            }
            $this->assigns["ex_user"] = $ex_user;
            $this->assigns["prev"] = $this->Competitions_apply->get_current($_id, $res["id"], 0);
            $this->assigns["next"] = $this->Competitions_apply->get_current($_id, $res["id"], 1);

            $this->assigns["cnt_a_all"] = $this->Competitions_apply->cnt( "ca.competition_id =".$res["id"]);
            $this->assigns["cnt_a_suc"] = $this->Competitions_apply->cnt("ca.status = 1 and ca.competition_id =".$res["id"]);
            $this->assigns["cnt_a_pre"] = $this->Competitions_apply->cnt("ca.status = 0 and ca.competition_id =".$res["id"]);
            $this->assigns["cnt_a_rej"] = $this->Competitions_apply->cnt("ca.status = 2 and ca.competition_id =".$res["id"]);
        }
        if($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
        $this->sub();
        
        if ($_SESSION["s"]["id"] != $res["user_id"] && !$examiner && !$res["public"]) 
            header("Location: /error_404");
    }

    public function edit($_id = '')
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }

        if ($_REQUEST["cancel"]) {
            
        }
        if ($_REQUEST["subject"]) {
            $_REQUEST["contents"] = str_replace('"../../', '"'.'/', $_REQUEST["contents"]);
            $_REQUEST["contents"] = str_replace('"../', '"'.'/', $_REQUEST["contents"]);
            $_id = $this->Competitions->add($_REQUEST);
            
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
                $copy_file = $this->settings->root_path.'media/comp/'.$_id.$file_ext;

                GD2_make_thumb_x(300, "", $original_file);

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/comp/'.$_id.$file_ext;
                $this->Competitions->add_pic($_id, $_pic);
            }
            
            if ($_FILES["source"]["name"]) {

                $file = make_upload("/media/comp_file/", "source");

                $this->Competitions->add_file($_id, $file, $_FILES["source"]["name"]);
            }
            $this->assigns_layout["msg"] = "저장되었습니다.";
        }
        
        if ($_id) {
            $res = $this->Competitions->get($_id);
            $this->assigns["res"] = $res;
            
            if ($_SESSION["s"]["id"] != $res["user_id"]) 
            header("Location: /error_404");

            $this->get_process($res);
        }
        
        
    }

    public function apply_info($_id = '')
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }

        if (!$_id) header("Location: /error_404");
        
        $res = $this->Competitions->get($_id);
        $res["form_file"] = $this->Competitions_file->get_by_comp($_id);
        $this->assigns["res"] = $res;
        $this->get_process($res);
        
        if ($_SESSION["s"]["id"] != $res["user_id"]) 
            header("Location: /error_404");
    }
    
    public function score_info($_id = '')
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }

        if (!$_id) header("Location: /error_404");
        
        if ($_REQUEST["score"]) {
            $this->Competitions->add($_REQUEST);
        }
        $res = $this->Competitions->get($_id);
        $this->assigns["res"] = $res;

        $score = $this->Competitions_score->get_by_comp($_id);
        $this->assigns["score"] = $score;
        
        $this->get_process($res);
        
        if ($_SESSION["s"]["id"] != $res["user_id"]) 
            header("Location: /error_404");
    }
    
    public function examiner($_id = '')
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }
        if (!$_id) header("Location: /error_404");
        $res = $this->Competitions->get($_id);
        $this->assigns["res"] = $res;
        $this->get_process($res);$this->assigns["res"] = $res;
        
        if ($_SESSION["s"]["id"] != $res["user_id"]) 
            header("Location: /error_404");
    }
    
    public function winner($_id = '')
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }

        if (!$_id) header("Location: /error_404");
        if ($_REQUEST["id"]) {
            $_REQUEST["winner"] = str_replace('"../../', '"'.'/', $_REQUEST["winner"]);
            $_REQUEST["winner"] = str_replace('"../', '"'.'/', $_REQUEST["winner"]);
            $this->Competitions->add($_REQUEST);
        }
        $res = $this->Competitions->get($_id);
        $this->assigns["res"] = $res;
        $this->get_process($res);
        
        if ($_SESSION["s"]["id"] != $res["user_id"]) 
            header("Location: /error_404");
    }

    private function get_process($res) 
    {
        $exn = $this->Competitions_examiner->get_by_comp($res["id"]);
        if (sizeof($exn)) $this->assigns["exn"] = true;
        $this->assigns["step"] = 1;
        if ($res["status"] == 1) {
            $this->assigns["step"] = 2;
            if ($res["form"] && $res["score"] && sizeof($exn) > 0) {
                $this->assigns["step"] = 3;
                if ($res["date_s"]." ".$res["time_s"] < date("Y.m.d H:i") && $res["date_e"]." ".$res["time_e"] > date("Y.m.d H:i")) {
                    $this->assigns["step"] = 4;
                }
                if ($res["date_e"]." ".$res["time_e"] < date("Y.m.d H:i")) {
                    $this->assigns["step"] = 5;
                    if ($res["announce_d"]." ".$res["announce_t"] < date("Y.m.d H:i") && $res["winner"]) {
                        $this->assigns["step"] = 6;
                    }
                }
            }
        }
    }

    public function applied_excel($_id)
    {
        $r = $this->Competitions->get($_id);
        // if ($r["user_id"] != $_SESSION["s"]["id"]){
        //     header("Location: /");
        // }
        $this->layout = "";
        // $this->Competitions_apply->debug();
        $res = $this->Competitions_apply->list_(1,1000, "ca.competition_id = ".$_id);
        $score = $this->Competitions_score->get_by_comp($_id);
        $len_res = sizeof($res);
        // exit(1);
        header( "Content-type: application/vnd.ms-excel; charset=euc-kr" );
        header( "Content-Disposition: attachment; filename=competition_applied_list_".$_id.".xls" );
        header( "Content-Description: PHP4 Generated Data" );
        Print("<Meta Http-Equiv=\"Content-Type\" Content=\"Application/Vnd.Ms-Excel; Charset=UTF-8\">");

        echo "
        <table>
        <tr>
        <td>id</td>
        <td>신청자</td>
        <td>신청자 이메일</td>
        <td>회사/팀</td>
        <td>신청일자</td>
        <td>접수상태</td>
        <td>반려사유</td>
        
        ";
        if (sizeof($score) > 0) {
            for ($k=0; $k<sizeof($score); $k++) {
                echo "<td>[점수]".$score[$k]["name"]."</td>";
            }
            echo "<td>[점수] 총점</td>";
        }
        echo "
        <td>파일</td>
        </tr>";

        for($i=0; $i<$len_res; $i++) {
            if (!$res[$i]["status"])$res[$i]["status_kr"] = "접수대기";
            else if ($res[$i]["status"] == 1)$res[$i]["status_kr"] = "접수";
            else if ($res[$i]["status"] == 2)$res[$i]["status_kr"] = "반려";
            
            echo "<tr><td>".$res[$i]["id"]."</td><td>".$res[$i]["name"]."</td><td>".$res[$i]["memail"]."</td><td>".$res[$i]["team"]."</td><td>".$res[$i]["date_created"]."</td><td>".$res[$i]["status_kr"]."</td><td>".$res[$i]["status_des"]."</td>";

            if (sizeof($score) > 0) {
                $tot = 0;
                for ($l=0; $l<sizeof($score); $l++) {
                    $s = $this->Competitions_scoring->get_only_score($res[$i]["id"], $score[$l]["id"]);
                    $tot = $tot + $s["score"];
                    echo "<td>".$s["score"]."</td>";
                }
                echo "<td>".$tot."</td>";
            }

            $file = $this->Competitions_files->get_by_apply($res[$i]["id"]);
            for ($j=0; $j<sizeof($file); $j++) {
                if ($file[$j]["file"]) echo "<td>".$this->settings->main_service_url."/competition/get_source/?file=".$file[$j]["file"]."</td>";
            }
            echo "</tr>";
        }

        echo "
        </table>
        ";
        exit(1);
    }

    public function examine_excel($_id)
    {
        $this->layout = "";

        $ex_user = $this->Competitions_examiner->get_by_comp($_id);
        for ($e=0; $e<sizeof($ex_user); $e++) {
            $total_ = 0;
            for ($s=0; $s<sizeof($score); $s++) {
                $scoring = $this->Competitions_scoring->get_scoring($ex_user[$e]["user_id"], $per["id"], $score[$s]["id"]);
                $total_ = $total_ + $scoring["score"];
                $ex_user[$e]["total"] = $total_;
            }
        }
        $ex = "";
        for ($l=0; $l<sizeof($ex_user); $l++) {
            $ex = $ex . "<td>".$ex_user[$l]["name"]."</td>";
        }

        $res = $this->Competitions_apply->list_(1,1000, "ca.competition_id = ".$_id." and status = 1");
        $score = $this->Competitions_score->get_by_comp($_id);
        $len_res = sizeof($res);

        header( "Content-type: application/vnd.ms-excel; charset=euc-kr" );
        header( "Content-Disposition: attachment; filename=competition_examine_list_".$_id.".xls" );
        header( "Content-Description: PHP4 Generated Data" );
        Print("<Meta Http-Equiv=\"Content-Type\" Content=\"Application/Vnd.Ms-Excel; Charset=UTF-8\">");

        echo "
        <table>
        <tr>
        <td>no</td>
        <td>업체</td>
        <td>심사항목 \ 심사위원</td>
        ".$ex."
        <td>최종점수</td>
        <td>순위</td>        
        </tr>";

        $len_e_sc = sizeof($score) + 1;
        $len = $len_res * $len_e_sc;

        for($i=0; $i<$len; $i++) {
            echo "<tr>";

            if ($i % $len_e_sc == 0) {
                $o = floor($i / $len_e_sc) + 1;
                echo "<td rowspan=".$len_e_sc.">".$o."</td><td rowspan=".$len_e_sc.">".$res[$i / $len_e_sc]["team"]."/".$res[$i / $len_e_sc]["name"]."</td>";
            }
            // else {
            //     echo "<td></td><td></td>";
            // }
            // $o = floor($i / 5) + 1;
            // echo "<td>".$o."</td><td>".$res[$i / 5]["team"]."/".$res[$i / 5]["name"]."</td>";

                if (($i+1) % $len_e_sc != 0) {
                    echo "<td>".$score[$i%$len_e_sc]["name"]."</td>";
                } else {
                    echo "<td>합계</td>";
                }

                // 심사위원별 점수
                for ($n=0; $n<sizeof($ex_user); $n++) {
                    if (($i+1) % $len_e_sc != 0) {
                        $s = $this->Competitions_scoring->get_scoring($ex_user[$n]["user_id"], $res[$i / $len_e_sc]["id"], $score[$i%$len_e_sc]["id"]);
                        echo "<td>".$s["score"]."</td>";
                    }
                    else {
                        $s = $this->Competitions_scoring->get_tot_score($res[$i / $len_e_sc]["id"], $ex_user[$n]["user_id"]);
                        echo "<td>".$s."</td>";
                    }
                }

            if ($i % $len_e_sc == 0) {
                $ss = $this->Competitions_scoring->get_tot_score($res[$i / $len_e_sc]["id"]);
                echo "<td rowspan=".$len_e_sc.">".$ss."</td><td rowspan=".$len_e_sc."></td>";
                echo "</tr>";
            }
            // else {
            //     echo "<td></td><td></td>";
            // }
            // $ss = $this->Competitions_scoring->get_tot_score($res[$i / 5]["id"]);
            // echo "<td>".$ss."</td><td></td>";
            // echo "</tr>";
        }

        echo "
        </table>
        ";
        exit(1);
    } 

    public function get_source()
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }
        
        $this->tpl_name = "";
        
        $filename = trim($_REQUEST["file"]); 
        $file = "./media/comp_file/$filename"; 
        $file_size = filesize($file); 
        $filename = urlencode("$filename");

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

        if (is_file("$file")) { 
        $fp = fopen("$file", "r"); 
        if (!fpassthru($fp)) 
        fclose($fp); 
        }
    }

    public function get_cp_source()
    {
        $this->tpl_name = "";
        $cp = $this->Competitions->get($_REQUEST["cp"]);

        $filename = trim($cp["file_url"]); 
        $file = "./media/comp_file/$filename"; 
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
    

    public function get_cp_file()
    {
        $this->tpl_name = "";
        $cp = $this->Competitions->get_a_file($_REQUEST["cid"], $_REQUEST["fid"]);

        $filename = trim($cp["file"]); 
        $file = "./media/comp_file/$filename"; 
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
}
?>