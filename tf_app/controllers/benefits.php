<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Benefits extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "default";
    var $use_models = array("Program", "Startup_member", "Program_form", "Program_file"
            , "Program_apply", "Startup_service", "Members", "Banner");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "program";
        $this->assigns_layout["top_js"] = "program";
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns_layout["s"] = $_SESSION["s"];
    }

    public function index($_status = 'ing', $_page = 1)
    {
        $_pagesize = 1000;
        $where = "c.status = 1 and c.open = 1 ";
        if ($_status == 'ing') $where = $where .' and ( a_start = "" or a_start IS NULL or a_start <= "'. date('Y.m.d H:i').'" OR a_end = "" OR a_end IS NULL OR a_end > "'. date('Y.m.d H:i').'")';
        else if ($_status == 'end') $where = $where .' and a_start != "" and a_start IS NOT NULL and a_end < "'. date('Y.m.d H:i').'"';

        if ($_REQUEST["type"]) $where = $where." and cat_id = ".$_REQUEST["type"];

        $order = "";  
        if ($_REQUEST["order"]) $order= 'a_end = "" ASC, a_end ASC';

        $res = $this->Program->get_list($_page, $_pagesize, $where, $order);

        $this->assigns["res"] = $res;
        $this->assigns["cat"] = $this->Program->get_category('visible = 1');
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $_pagesize;
        $this->assigns["status"] = $_status;
        $this->assigns["type"] = $_REQUEST["type"];
        $this->assigns["order"] = $_REQUEST["order"];
        $this->assigns["banner"] = $this->Banner->get_one(6);
        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }        

    public function views($_id)
    {
        $r = $this->Program->get_list('', '', 'c.id = '.$_id);
        $res = $r[0];
        if (!$res) 
            header("Location: /benefits");

        $og["type"] = 'article';
        $og["url"] = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
        $og["title"] = $res["title"]." on D.CAMP";
        $og["description"] = strip_tags($res["content"]);
        if (strlen(strip_tags($res["content"])) > 150) $og["description"] 
                = mb_substr(strip_tags($res["content"]), 0, 150, 'UTF-8').'...';
        $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].$res["img"];
        $this->assigns_layout["og"] = $og;
        $this->assigns["g_start"] = date("YmdHi00",strtotime ("-9 hour", strtotime(str_replace(".", "", str_replace(":", "", str_replace(" ", "", $res["a_start"]))))));
        $this->assigns["g_end"] = date("YmdHi00",strtotime ("-9 hour", strtotime(str_replace(".", "", str_replace(":", "", str_replace(" ", "", $res["a_end"]))))));
        
        $this->assigns["res"] = $res;
        $this->assigns["my"] = $this->Program_apply->get_by_user($res["id"], $_SESSION["s"]["id"]);
        $this->sub();
        $this->assigns["hot"] = $this->Program->get_hot(1, 5, 'p.status = 1 and p.open = 1 and ( a_start = "" or a_start IS NULL or a_start <= "'. date('Y.m.d H:i').'" OR a_end = "" OR a_end IS NULL OR a_end > "'. date('Y.m.d H:i').'")');
        if (!strpos($_SERVER["HTTP_REFERER"], "dcamp.kr")) {
            $this->assigns_layout["cards"] = bottom_main();
        }
        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
    }   

    public function apply($_id, $_per = '')
    {
        $r = $this->Program->get_list('', '', 'c.id = '.$_id);
        $res = $r[0];
        if (!$res) 
            header("Location: /benefits");

        $my = $this->Program_apply->get_by_user($_id, $_SESSION["s"]["id"]);

        if ($_per) {
            $per = $this->Program_apply->get($_per);

            if ($per["user_id"] != $_SESSION["s"]["id"]) {
                header("Location: /error_404");
            }

            if ($_REQUEST["req"] == 'del') {
                if ($per["user_id"] == $_SESSION["s"]["id"]) {
                    $this->Program_apply->delete($_per);
                    $fi = $this->Program_file->get_by_apply_res($_per);
                    for ($ff=0; $ff<sizeof($fi); $ff++) {
                        unlink("media/program_file/".$fi[$ff]["file"]);
                    }
                    $this->Program_file->del_file_res($_per);
                    $this->Program_form->del_form_res($_per);
                    header("Location: /member/edit_benefit");
                }
                else {
                    $this->assigns_layout["msg"] = "삭제 권한이 없습니다.";
                }
            }
        }
        else {
            $per["user_id"] = $_SESSION["s"]["id"];
            $per["f_name"] = $_SESSION["s"]["name"];
            $per["f_tel"] = $_SESSION["s"]["tel"];
            $per["f_email"] = $_SESSION["s"]["email"];
            $per["f_des"] = $_SESSION["s"]["bio"];
        }
        $this->assigns["per"] = $per;

        $forms = $this->Program_form->get_by_comp($_id);
        if ($forms) {
            for ($f=0; $f<sizeof($forms); $f++) {
                if ($forms[$f]["type"] == "query") {
                    $forms[$f]["opts"] = explode(",", $forms[$f]["opt"]);
                }
                if ($per["id"]) {
                    $fr = $this->Program_form->get_by_form_user($forms[$f]["id"], $_per);
                    $forms[$f]["ress"] = $fr["res"];
                }
            }
        }

        $file = $this->Program_file->get_by_comp($_id);
        if ($file) {
            for ($j=0; $j<sizeof($file); $j++) {
                $f = $this->Program_file->get_by_file_user_res($file[$j]["id"], $_per);
                $file[$j]["val"] = $f["file"];
                $file[$j]["fid"] = $file[$j]["id"];
            }
        }    

        $st = $this->Startup_member->get_list_by_user($_SESSION["s"]["id"], "sm.status = 1");

        $this->assigns["st"] = $st;
        $this->assigns["st_f"] = $st[0];

        $res["form_file"] = $file;
        $res["forms"] = $forms;
        $this->assigns["res"] = $res;
        $this->assigns["pre"] = $_REQUEST["preview"];
        $this->sub();
        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }

        // if (!$_per) {
        //     if ($my && ! $_per) {
        //         $_SESSION["msg"] = "이미 참가신청이 접수되었습니다.";
        //         header("Location: /benefits/views/".$_id);
        //     }
        // }
    }

    public function save_apply()
    {
        $this->tpl_name = "";
        if ($_REQUEST["user_id"]) {
            $_id = $this->Program_apply->add($_REQUEST);
            
            $form = $this->Program_form->get_by_comp($_REQUEST["program_id"]);
            if ($form) {
                $this->Program_form->del_form_res($_id);
                for ($f=0; $f<sizeof($form); $f++) {
                    if ($_REQUEST["form".$form[$f]["id"]]) {
                        $arr["apply_id"] = $_id;
                        $arr["c_form_id"] = $form[$f]["id"];
                        $arr["res"] = $_REQUEST["form".$form[$f]["id"]];
                        $this->Program_form->res_add($arr);
                    }
                }
            }
            $file = $this->Program_file->get_by_comp($_REQUEST["program_id"]);
            if ($file) {
                $file_date_dir = $_REQUEST["program_id"];
                if(! is_dir($this->settings->upload_path."/media/program_file/".$file_date_dir)){
                    @mkdir($this->settings->upload_path."/media/program_file/".$file_date_dir, 0777);
                    exec("chmod 777 ".$this->settings->upload_path."/media/program_file/".$file_date_dir);
                }
                $len_file = sizeof($file);
                for ($i=0; $i<$len_file; $i++) {
                    $f = null;
                    if ($_FILES["file_".$file[$i]["id"]]["name"]) {
                        $f = make_upload("/media/program_file/".$file_date_dir.'/', "file_".$file[$i]["id"]);
                        $_ar["file"] = $f;
                        $_ar["c_file_id"] = $file[$i]["id"];
                        $_ar["apply_id"] = $_id;
                        $this->Program_file->add_res($_ar);

                        if ($_REQUEST["o_file_".$file[$i]["id"]]) {
                            unlink($this->settings->root_path."media/program_file/".$file_date_dir.'/'.$_REQUEST["o_file_".$file[$i]["id"]]);
                        }
                    }
                }
            }

            if ($_REQUEST["f_s_des"] && $_REQUEST["f_service"] && $_REQUEST["ser_id"]) {
                $arr3["startup_id"] = $_REQUEST["st_id"];
                $arr3["id"] = $_REQUEST["ser_id"];
                $arr3["name"] = $_REQUEST["f_service"];
                $arr3["des_ele"] = $_REQUEST["f_s_des"];
                $this->Startup_service->add2($arr3);
            }

            $ev = $this->Program->get_list('', '', "c.id = ".$_REQUEST["program_id"]);
            $_ev = $ev[0];
            $m = new TF_mailer($this->settings);
            $m->mailto = $_ev["memail"];
            $m->subject = "[D.CAMP] ".$_SESSION["s"]["name"]."님의 '".$_ev["title"]."'' Benefit 프로그램에 지원하었습니다.";
            $m->tpl_name = "program_apply";
            $m->assigns["res"] = $_ev;
            $m->assigns["u"] = $_SESSION["s"]["name"];
            $m->assigns["main_service_url"] = $this->globals->my_host;
            $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
            $m->send();

            $_SESSION["msg"] = "Benefit 프로그램 신청이 접수되었습니다.";
            header("Location: /member/edit_benefit/");
            exit(1);
        }     
    }

    public function edit($_id = '')
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }

        if ($_REQUEST["title"]) {
            if ($_REQUEST["a_start"]) {
                $_REQUEST["a_start"] = $_REQUEST["a_start_d"]." ".$_REQUEST["a_start_t"];
                $_REQUEST["a_end"] = $_REQUEST["a_end_d"]." ".$_REQUEST["a_end_t"];
            }
            else {
                $_REQUEST["a_start"] = '';
                $_REQUEST["a_end"] = '';
            }
            if ($_REQUEST["cnt_c"] == 0) $_REQUEST["cnt"] = 0;
            $_id = $this->Program->add($_REQUEST);

            if ($_REQUEST["img"]) {
                $img_temp_name = str_replace(" ","",$_REQUEST['img']);

                $ck = substr($img_temp_name, 0, 1);
                if($ck=='/'){
                    $img_temp_name = substr($img_temp_name, 1, strlen($img_temp_name) -1 );
                }

                $file_ext = explode('.',$img_temp_name);
                $file_ext = '.'.$file_ext[sizeof($file_ext)-1];

                $original_file = $this->settings->root_path.$img_temp_name;
                $copy_file = $this->settings->root_path.'media/program/'.$_id.$file_ext;
                
                GD2_make_thumb_x(300, "", $original_file);

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/program/'.$_id.$file_ext;
                $this->Program->add_picture($_id, $_pic);
            }
            
            if ($_REQUEST["del_file"]) {
                $this->Program->add_file($_id, '');
                unlink('media/program/'.$_REQUEST["del_file"]);
            }
            
            if ($_FILES["file"]["name"]) {
                $file = make_upload("/media/program/", "file");
                if ($file) $this->Program->add_file($_id, $file, str_replace(" ", "_", $_FILES["file"]["name"]));
            }

            $this->assigns["msgt"] = 1;
        }

        if ($_id)
        {
            $res = $this->Program->get($_id);
            if (! $res) 
                header("Location: /error_404");

            $this->assigns["res"] = $res;
        }
        $this->assigns["category"] = $this->Program->get_category();
    }

    public function apply_info($_id = '')
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }

        if (!$_id) header("Location: /error_404");
        
        $res = $this->Program->get($_id);
        $forms = $this->Program_form->get_by_comp($_id);
        for ($i=0; $i<sizeof($forms); $i++) {
            if ($forms[$i]["type"] == 'query') {
                $forms[$i]["opts"] = explode(",", $forms[$i]["opt"]);
            }
        }
        $res["forms"] = $forms;
        $res["form_file"] = $this->Program_file->get_by_comp($_id);

        $this->assigns["res"] = $res;

        if ($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }

        if ($_SESSION["msgt"]) {
            $this->assigns["msgt"] = 1;
            unset($_SESSION["msgt"]);
        }
    }

    public function applied_list($_id, $_page = 1)
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }
        if (!$_id) header("Location: /error_404");

        $pagesize = 10;
        $sort = $_REQUEST["sort"];
        if (!$sort) $sort = 1;
        $res = $this->Program->get($_id);
        $where = "ca.program_id = ".$_id;
        $list = $this->Program_apply->list_out($_page, $pagesize, $where, "");

        for ($i=0; $i<sizeof($list); $i++) {
            $u = $this->Members->get($list[$i]["user_id"]);
            $list[$i]["ids"] = $u["ids"];
            $list[$i]["name"] = $u["name"];
            $list[$i]["memail"] = $u["email"];
            $list[$i]["bio"] = $u["bio"];
            $list[$i]["picture"] = $u["picture"];
        }

        // dashboard
        $_sDate = str_replace(".", "-", substr($res["a_start"], 0, 10));
        $_eDate = str_replace(".", "-", substr($res["a_end"], 0, 10));
        if ($_eDate > date("Y-m-d")) $_eDate = date("Y-m-d");
        $term = dateDiff($_eDate, $_sDate, "-");
        // echo $term;
        for ($d=0; $d<$term+1; $d++) {
            $day = date("Y-m-d", strtotime("+$d day", strtotime($_sDate))); 
            $d_list[$d]["day"] = str_replace("-", ".", $day);
            $d_list[$d]["all"] = $this->Program_apply->cnt_out("ca.date_created like '".$day."%' and ca.program_id = ".$_id);
        }

        $this->assigns["d_list"] = array_reverse($d_list);
        $this->assigns["alig"] = $_REQUEST["alig"];
        $list_cnt = $this->Program_apply->cnt_out($where);
        $this->assigns["res"] = $res;
        $this->assigns["list"] = $list;
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["list_cnt"] = $list_cnt;
        $this->assigns["list_cnt_reject"] = $this->Program_apply->cnt_out("ca.status = 2 and ca.program_id = ".$_id);
        $this->assigns["paging"] = get_paging_dot2($_page, $list_cnt, $pagesize);
        $this->assigns["sort"] = abs($sort);
        $this->assigns["tab"] = $_REQUEST["tab"];
        $this->assigns["m_list"] = $this->Program->get_list(1, 5, "c.user_id = ".$_SESSION["s"]["id"]);
        $this->assigns["a_list"] = $this->Program_apply->list_all(1, 5, "ca.user_id = ".$_SESSION["s"]["id"]);

        if ($_SESSION["s"]["id"] != $res["user_id"]) 
            header("Location: /error_404");
    }

    public function applied_view($_id)
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }

        if (!$_id) header("Location: /error_404");

        $per = $this->Program_apply->get($_id);
        $per["com"] = $this->Startup_member->get_by_user($per["user_id"]);
        $res = $this->Program->get($per["program_id"]);

        $file = $this->Program_file->get_by_comp($res["id"]);
        if ($file) {
            for ($j=0; $j<sizeof($file); $j++) {
                $f = $this->Program_file->get_by_file_user_res($file[$j]["id"], $_id);
                $file[$j]["val"] = $f["file"];
                $file[$j]["fid"] = $file[$j]["id"];
            }
        }
        $forms = $this->Program_form->get_by_comp($res["id"]);
        if ($forms) {
            for ($f=0; $f<sizeof($forms); $f++) {
                if ($forms[$f]["type"] == "query") {
                    $forms[$f]["opts"] = explode(",", $forms[$f]["opt"]);
                }
                if ($per["id"]) {
                    $fr = $this->Program_form->get_by_form_user($forms[$f]["id"], $_id);
                    $forms[$f]["ress"] = $fr["res"];
                }
            }
        }
        $res["form_file"] = $file;
        $res["forms"] = $forms;
        
        $this->assigns["res"] = $res;
        $this->assigns["per"] = $per;

        if($_SESSION["msg"]) {
            $this->assigns_layout["msg"] = $_SESSION["msg"];
            unset($_SESSION["msg"]);
        }
        $this->sub();
        
        if ($_SESSION["s"]["id"] != $per["user_id"]  && $_SESSION["s"]["id"] != $res["user_id"] ) 
            header("Location: /error_404");
    }

    private function sub()
    {
        $sub = $this->Program->get_list(1, 5, 'c.status = 1 and ( a_start = "" or a_start IS NULL or a_start <= "'. date('Y.m.d H:i').'" and a_end > "'. date('Y.m.d H:i').'")');
        $this->assigns["sub"] = $sub;
    }

    public function applied_excel($_id)
    {
        $r = $this->Program->get($_id);
        // if ($r["user_id"] != $_SESSION["s"]["id"]){
        //     header("Location: /");
        // }

        $this->layout = "";
        $res = $this->Program_apply->list_out(1,1000, "ca.program_id = ".$_id);
        $len_res = sizeof($res);
        header( "Content-type: application/vnd.ms-excel; charset=euc-kr" );
        header( "Content-Disposition: attachment; filename=program_applied_list_".$_id.".xls" );
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
        <td>파일</td>
        </tr>";

        for($i=0; $i<$len_res; $i++) {

            if (! $res[$i]["name"]) $res[$i]["name"] = $res[$i]["f_name"];
            if (! $res[$i]["memail"]) $res[$i]["memail"] = $res[$i]["f_email"];
            if (! $res[$i]["team"]) $res[$i]["team"] = $res[$i]["f_team"];
            
            echo "<tr><td>".$res[$i]["id"]."</td><td>".$res[$i]["name"]."</td><td>".$res[$i]["memail"]."</td><td>".$res[$i]["team"]."</td><td>".$res[$i]["date_created"]."</td><td>".$res[$i]["status_kr"]."</td>";

            $file = $this->Program_file->get_by_apply_res($res[$i]["id"]);
            for ($j=0; $j<sizeof($file); $j++) {
                if ($file[$j]["file"]) echo "<td>".$this->settings->main_service_url."/benefits/get_source/?file=".$file[$j]["file"]."</td>";
            }
            echo "</tr>";
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
        $p = $this->Program_apply->get($_REQUEST["aid"]);
        $f = $this->Program_file->get_by_file_user_res($_REQUEST["fid"], $_REQUEST["aid"]);
        $filename = trim($f["file"]); 
        $file = "./media/program_file/".$p["program_id"]."/".$f["file"]; 
        // echo $file;exit(1);
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
        // header("Pragma: no-cachttp://localhost.me:8006/benefits/get_pr_source?ev=2&file=0226_%EB%A1%9C%EA%B7%B8%EC%9D%B8%20%EC%83%81%ED%83%9C%20%EC%9C%A0%EC%A7%80.JPGhe"); 
        header("Expires: 0"); 
        } 

        if (is_file("$file")) { 
        $fp = fopen("$file", "r"); 
        if (!fpassthru($fp)) 
        fclose($fp); 
        }
    }

    public function get_pr_source()
    {
        $this->tpl_name = "";
        $cp = $this->Program->get($_REQUEST["ev"]);

        $filename = trim($cp["file"]); 
        $file = "./media/program/$filename"; 
        // echo $file;exit(1);
        $file_size = filesize($file); 
        $filename = urlencode("$filename");

        if( strpos($_SERVER['HTTP_USER_AGENT'], 'MSIE') || strpos($_SERVER['HTTP_USER_AGENT'], 'Trident') ) { 
        
        $_REQUEST['file'] = iconv('utf-8', 'euc-kr', $cp['filename']);

        header("Content-Type: doesn/matter"); 
        Header("Content-Length: ".filesize("$file"));
        Header("Content-Disposition: attachment; filename=".trim($cp['filename'])); 
        header("Content-Transfer-Encoding: binary"); 
        header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
        header('Pragma: public');
        header("Expires: 0"); 
        
        } else { 

        Header("Content-type: file/unknown"); 
        Header("Content-Disposition: attachment; filename=".trim($cp['filename'])); 
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