<?
class Ajax extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "";
    var $use_models = array("Member_grade", "Member_career", "Member_project","Space_reserve"
            , "Notice", "Event", "Event_reserve", "Startup", "Startup_bussiness", "Startup_tech"
            , "Startup_local", "Startup_reference", "Startup_investment", "Startup_incubating"
            , "Startup_founder", "Startup_service", "Event_type", "Activity", "Recommend"
            , "Space", "Member_education", "Member_ext", "Members", "Startup_member", "Content"
            , "Code", "Entrance", "Locker_month", "Content_category", "Competitions_examiner"
            , "Recruit", "Recruit_opt");

    public function before_calling()
    {
        $this->assigns["s"] = $_SESSION["s"];
    }
    
    public function photo_form_file($_attr, $_size) {

        if (array_key_exists('file', $_FILES)) {

            //그림
            $userfile_size = $_FILES['file']['size'];
            $filename = basename($_FILES['file']['name']);

            $file_ext = strtolower(substr($filename, strrpos($filename, '.') + 1));

            foreach ($this->settings->allowed_image_ext as  $ext) {
                if($file_ext == $ext ){
                    $file_type = 0;
                    break;
                }else{
                    $file_type = 1;
                }
            }
            //JPG, PNG, GIF 가 아니라면
            if($file_type == 1){
                $this->assigns['error_str'] = _("그림파일이 아닙니다.");

                return;
            }

            //이미지 허용 크기를 벗어남
            if ($userfile_size > ($this->settings->max_file * 1048576)) {
                $this->assigns['error_str'] = _("파일 사이즈 ").$this->settings->max_file._("MB 이하의 파일만 업로드 할 수 있습니다.");
                return ;
            }

            $filename = make_upload('media/temp/', 'file');
            if ($filename) {
                $src_file = $this->settings->upload_path . 'media/temp/' . $filename;
                $ret_file_name = '/media/temp/' . $filename;
            }

        }
//        $this->tpl_name = "";
//        $result["ret_file_name"] = $ret_file_name;
//        $result["attr"] = $_attr;
//        echo json_encode($result);
        $_s_size = explode("x", $_size);
        $this->assigns["old"] = $_REQUEST["old"];
        $this->assigns["ret_file_name"] = $ret_file_name;
        $this->assigns["attr"] = $_attr;
        $this->assigns["size"] = $_size;
        $this->assigns["w_size"]  = $_s_size[0];
        $this->assigns["h_size"]  = $_s_size[1];
//        $_SESSION['temp_file'] = $ret_file_name;
    }
    
    function add_image()
    {
        $this->layout = "";
    }

    function add_image_process()
    {
        global $settings;

        $this->layout = "";
        $ufn = make_upload("media/editor_temp/","upload_file");
        $img_info=@getimagesize($this->settings->root_path ."media/editor_temp/" . $ufn);

        if ($img_info[0] > 670)
        {
            GD2_make_thumb_new(670,3000,$this->settings->root_path . "media/editor_temp/" . $ufn, $this->settings->root_path . "media/editor_temp/" .$ufn);
        }

        $this->assigns["path"] = "media/editor_temp/".$ufn;
        $this->assigns["smu"] = $this->settings->service_main_url;

        $this->assigns["position"] = $_REQUEST["position"];
        $this->assigns["caption"] = $_REQUEST["caption"];
    }
    
    public function check_grade()
    {
        $res = $this->Member_grade->get_name($_REQUEST["data"]);
        
        if (sizeof($res) > 0) {
            $result["error"] = 1;
        } else {
            $result["error"] = 0;
        }
        
        $this->tpl_name = "";
        echo json_encode($result);
    }

    public function get_reserve()
    {
        $res = $this->Space_reserve->get_by_date($_REQUEST["date"], "sr.state = 1");
        
        $this->assigns["res"] = $res;
        $this->assigns["date"] = $_REQUEST["date"];
    }

    public function get_reserve_n()
    {
        $res = $this->Space_reserve->get_by_date($_REQUEST["date"], "sr.state = 1");
        
        $this->assigns["res"] = $res;
        $this->assigns["date"] = $_REQUEST["date"];
    }

    public function get_reserve_main()
    {
        $this->assigns["day_per"] = $this->Space_reserve->day_per();
    }
    
    public function notice_edit_state($_state = '',$_id = '')
    {
        if ($_id)
            $this->Notice->edit($_id, $_state);
        else if ($_REQUEST["data"]) {
            $this->Notice->edit_all($_REQUEST["data"], $_state);
        }
        $this->tpl_name = "";
    }
    
    public function notice_del($_id='')
    {
        if ($_id)
            $this->Notice->delete($_id);
        else if ($_REQUEST["data"]) {
            $this->Notice->delete_all($_REQUEST["data"]);
        }
        $this->tpl_name = "";
    }
    
    public function grade_edit_state($_state = '',$_id = '')
    {
        if ($_id)
            $this->Member_grade->edit($_id, $_state);
        
        $this->tpl_name = "";
    }
    
    public function grade_del($_id='')
    {
        if ($_id)
            $this->Member_grade->delete($_id);
        
        $this->tpl_name = "";
    }
    
    public function member_add_career()
    {
        $this->assigns["v"] = $_REQUEST["data"];
    }
    
    public function member_add_project()
    {
        $this->assigns["v"] = $_REQUEST["data"];
    }
    
    public function member_del_career()
    {
        $this->Member_career->del_by_user($_REQUEST["cid"], $_REQUEST["uid"]);
        $this->tpl_name = "";
    }
    
    public function member_del_project()
    {
        $this->Member_project->del_by_user($_REQUEST["pid"], $_REQUEST["uid"]);
        $this->tpl_name = "";
    }

    public function event_reserve_list($_page = 1)
    {
        $pagesize = 10;
        $res = $this->Event_reserve->list_($_page, $pagesize, "event_id = ".$_REQUEST["id"]);
        for ($i=0; $i<sizeof($res); $i++) {
            $com = $this->Startup_member->get_by_user($res[$i]["user_id"]);
            if (!$res[$i]["company"]) $res[$i]["company"] = $com["name"];
        }
        $res_cnt = $this->Event_reserve->cnt("event_id = ".$_REQUEST["id"]);
        $this->assigns["res"] = $res;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize); 
        $this->assigns["page"] = $_page;
        $this->assigns["ev"] = $this->Event->get($_REQUEST["id"]);
    }
    
    public function event_by_days()
    {
        $res = $this->Event->list_(1, 1000, "date = '".$_REQUEST["date"]."'", 1);
        
        $this->assigns["res"] = $res;
        $this->assigns["date"] = $_REQUEST["date"];
    }
    
    public function event_edit_reserve($_id, $_state)
    {
        $this->Event_reserve->edit_state($_id, $_state);
        $e_r_user = $this->Event_reserve->get($_id);
        
        if ($_state == 1) {
            $arr["act_type"] = Activity_model::C_TYPE_MEMBER;
            $arr["act_id"] = $e_r_user["user_id"];
            $arr["target_type"] = Activity_model::A_TYPE_EVENT;
            $arr["target_id"] = $e_r_user["event_id"];
            $arr["act_result"] = 1;
            $this->Activity->edit($arr);
            
            $ev = $this->Event->get_detail($e_r_user["event_id"]);
            $u = $this->Members->get($e_r_user["user_id"]);
            $m = new TF_mailer($this->settings);
            $m->mailto = $u["email"];
            $m->subject = "[D.CAMP] 이벤트 참가 신청이 승인되었습니다.";
            $m->tpl_name = "event_apply";
            $m->assigns["res"] = $ev;
            $m->assigns["main_service_url"] = $this->globals->my_host;
            $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
            $m->send();
        }
        
        $this->tpl_name = "";
    }
    
    public function startup_add_step1()
    {
        if ($_REQUEST["name"]) {
            $_id = $this->Startup->add($_REQUEST);
            if ($_REQUEST["img"]) {
                $img_temp_name = str_replace(" ","",$_REQUEST['img']);

                $ck = substr($img_temp_name, 0, 1);
                if($ck=='/'){
                    $img_temp_name = substr($img_temp_name, 1, strlen($img_temp_name) -1 );
                }

                $file_ext = explode('.',$img_temp_name);
                //$filename = basename($_FILES['file']['name']);
                $file_ext = '.'.$file_ext[sizeof($file_ext)-1];

                $original_file = $this->settings->root_path.$img_temp_name;
                $copy_file = $this->settings->root_path.'media/startup/'.$_id.$file_ext;

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/startup/'.$_id.$file_ext;
                $this->Startup->add_picture($_id, $_pic);
            }
            $this->Startup_tech->delete_by_user($_REQUEST["id"]);
            $len_sk = $_REQUEST["cnt_sk"];
            for($j=1; $j<$len_sk+1; $j++) {
                $tmp = "skill_".$j;
                if (trim($_REQUEST[$tmp])) {
                    $val = $this->Code->get_value(trim($_REQUEST[$tmp]), 'jobs');
                    $this->Startup_tech->add_c($_id, $val['id']);
                }
            }
            $this->Startup_bussiness->delete_by_user($_REQUEST["id"]);
            $len_int = $_REQUEST["cnt_int"];
            for($k=1; $k<$len_int+1; $k++) {
                $tmp = "inter_".$k;
                if (trim($_REQUEST[$tmp])) {
                    $val = $this->Code->get_value(trim($_REQUEST[$tmp]), 'field');
                    $this->Startup_bussiness->add_c($_id, $val['id']);
                }
            }
            
            $result["id"] = $_id;
            echo json_encode($result);
        }
        $this->tpl_name="";
    }
    
    public function startup_add_step2()
    {
        $this->Startup_reference->del($_REQUEST["id"]); // 기존 데이터 삭제
        $len_ref = $_REQUEST["cnt_ref"];
        for($c=1; $c<$len_ref+1; $c++) {
            if ($_REQUEST["reference_".$c]) {
                $this->Startup_reference->add($_REQUEST["id"], $_REQUEST["reference_".$c], $_REQUEST["description_".$c]);
            }
        }
        
        $this->Startup_investment->del($_REQUEST["id"]); // 기존 데이터 삭제
        $len_inv = $_REQUEST["cnt_inv"];
        for($d=1; $d<$len_inv+1; $d++) {
            if ($_REQUEST["investor_".$d]) {
                $this->Startup_investment->add($_REQUEST["id"], $_REQUEST["investor_".$d], $_REQUEST["iv_email_".$d]
                        , $_REQUEST["date_".$d], $_REQUEST["investment_".$d], $_REQUEST["type_".$d]);
            }
        }
        
        $this->Startup_incubating->del($_REQUEST["id"]); // 기존 데이터 삭제
        $len_inc = $_REQUEST["cnt_inc"];
        for($e=1; $e<$len_inc+1; $e++) {
            if ($_REQUEST["incubator_".$e]) {
                $this->Startup_incubating->add($_REQUEST["id"], $_REQUEST["incubator_".$e], $_REQUEST['des_'.$e] , $_REQUEST["ic_email_".$e]
                        , $_REQUEST["start_".$e], $_REQUEST["end_".$e]);
            }
        }
        
        $this->Startup_founder->del($_REQUEST["id"]); // 기존 데이터 삭제
        $len_fou = $_REQUEST["cnt_fou"];
        for($f=1; $f<$len_fou+1; $f++) {
            if ($_REQUEST["founder_".$f]) {
                $this->Startup_founder->add($_REQUEST["id"], $_REQUEST["founder_".$f]);
            }
        }
        $result["id"] = $_REQUEST["id"];
        echo json_encode($result);
        $this->tpl_name="";
    }
    
    public function startup_add_step3()
    {
        if($_REQUEST["id"])$ex = $this->Startup_service->get($_REQUEST["id"]);
        $_id = $this->Startup_service->add($_REQUEST);
        if (!$_REQUEST["id"]) $_REQUEST["id"] = $_id;
        
        for ($i=1; $i<5; $i++) {  
            $_ord = 'img'.$i;
            if ($_REQUEST[$_ord]) {
                if (strpos($_REQUEST[$_ord], '/temp/')) {
                    $img_temp_name = str_replace(" ","",$_REQUEST[$_ord]);

                    $ck = substr($img_temp_name, 0, 1);
                    if($ck=='/'){
                        $img_temp_name = substr($img_temp_name, 1, strlen($img_temp_name) -1 );
                    }

                    $file_ext = explode('.',$img_temp_name);
                    //$filename = basename($_FILES['file']['name']);
                    $file_ext = '.'.$file_ext[sizeof($file_ext)-1];

                    $original_file = $this->settings->root_path.$img_temp_name;
                    $copy_file = $this->settings->root_path.'media/service/'.$i.'_'.$_id.$file_ext;

                    $_REQUEST[$_ord] = '/media/service/'.$i.'_'.$_id.$file_ext;
                    $_REQUEST[$_ord."_thumb"] = '/media/service/thumb/'.$i.'_'.$_id.$file_ext;

                    if ($ex[$_ord]) {
                        unlink(substr($ex[$_ord], 1));
                        unlink(substr($ex[$_ord."_thumb"], 1));
                    }

                    //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                    copy($original_file, $copy_file);
                    unlink($original_file); 
                    GD2_make_thumb_x(180, 'thumb/', $copy_file);


                } else {
                    $_REQUEST[$_ord] = $ex[$_ord];
                    $_REQUEST[$_ord."_thumb"] = $ex[$_ord."_thumb"];
                }
            } else {
                $_REQUEST[$_ord] = '';
                $_REQUEST[$_ord."_thumb"] = '';
                if ($ex[$_ord]) {
                    unlink(substr($ex[$_ord], 1));
                    unlink(substr($ex[$_ord."_thumb"], 1));
                }
            }
        }
        
        for ($k=1; $k<5; $k++) {
            $_o = "movie".$k;
            if ($_REQUEST[$_o]) {
                $video_info = get_video_id($_REQUEST[$_o]);
                if ($video_info['id']) {
                    $video_data = get_video_data($video_info['id'], $video_info['type']);
                    $_REQUEST[$_o] = $video_info['id'];
                    $_REQUEST[$_o."_type"] = $video_info['type'];
                    $_REQUEST[$_o."_thumb"] = $video_data['b_thumbnail'];
                }
                else {
                    $_REQUEST[$_o] = '';
                    $_REQUEST[$_o."_type"] = '';
                    $_REQUEST[$_o."_thumb"] = '';
                }
            }
        }
        
        for ($j=1; $j<5; $j++) {
            $_or = "gr".$j;
            if ($_REQUEST[$_or]) {
                if (strpos($_REQUEST[$_or], '/temp/')) {
                    $img_temp_name = str_replace(" ","",$_REQUEST[$_or]);

                    $ck = substr($img_temp_name, 0, 1);
                    if($ck=='/'){
                        $img_temp_name = substr($img_temp_name, 1, strlen($img_temp_name) -1 );
                    }

                    $file_ext = explode('.',$img_temp_name);
                    //$filename = basename($_FILES['file']['name']);
                    $file_ext = '.'.$file_ext[sizeof($file_ext)-1];

                    $original_file = $this->settings->root_path.$img_temp_name;
                    $copy_file = $this->settings->root_path.'media/service/'.$_or.'_'.$_id.$file_ext;

                    $_REQUEST[$_or] = '/media/service/'.$_or.'_'.$_id.$file_ext;
                    $_REQUEST[$_or."_thumb"] = '/media/service/thumb/'.$_or.'_'.$_id.$file_ext;

                    if ($ex[$_or]) {
                        unlink(substr($ex[$_or], 1));
                        unlink(substr($ex[$_or."_thumb"], 1));
                    }
                    //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                    copy($original_file, $copy_file);
                    unlink($original_file); 
                    GD2_make_thumb_x(180, 'thumb/', $copy_file);


                } else {
                    $_REQUEST[$_or] = $ex[$_or];
                    $_REQUEST[$_or."_thumb"] = $ex[$_or."_thumb"];
                }
            } else {
                $_REQUEST[$_or.'_title'] = '';
                $_REQUEST[$_or.'_thumb'] = '';
                $_REQUEST[$_or] = '';
                if ($ex[$_or]) {
                    unlink(substr($ex[$_or], 1));
                    unlink(substr($ex[$_or."_thumb"], 1));
                }
            }
        }

        $this->Startup_service->add($_REQUEST);
        
        $result["id"] = $_id;
        echo json_encode($result);
        $this->tpl_name="";
    }

    public function startup_add_reference()
    {
        $this->assigns["v"] = $_REQUEST["data"];
    }
    
    public function startup_add_investment()
    {
        $this->assigns["v"] = $_REQUEST["data"];
    }
    
    public function startup_add_incubate()
    {
        $this->assigns["v"] = $_REQUEST["data"];
    }
    
    public function startup_add_founder()
    {
        $this->assigns["v"] = $_REQUEST["data"];
    }
    
    public function startup_add_picture()
    {
        $this->assigns["v"] = $_REQUEST["data"];
    }
    
    public function startup_add_service()
    {
        $this->assigns["v"] = $_REQUEST["data"];
    }
    
    public function startup_del_service($_id)
    {
        $sr = $this->Startup_service->get($_id);
        $this->Startup_service->del_cache($sr["startup_id"]);
        $this->Startup_service->delete($_id);
        $this->tpl_name = "";
    }
    
    public function check_event_type()
    {
        $result["check"] = $this->Event_type->check($_REQUEST["data"]);
        echo json_encode($result);
        $this->tpl_name = "";
    }
    
    public function permit_membership()
    {
        $this->Recommend->permit($_REQUEST["id"], $_REQUEST["user_id"], $_REQUEST["state"], $_REQUEST["state_des"]);
        $this->tpl_name = "";
        $user = $this->Members->get($_REQUEST["user_id"]);
        if ($_REQUEST["state"] == 1) {
            $msg = "D.CAMP 멤버십 가입이 승인되었습니다.";
            $arr["com_type"] = 1;
            $arr["com_id"] = $user["id"];
            $arr["act_type"] = 1;
            $arr["act_id"] = $user["id"];
            $arr["msg"] = $msg;
            $this->Activity->add($arr);
            
            $m = new TF_mailer($this->settings);
            $m->mailto = $user["email"];
            $m->subject = "[D.CAMP] 멤버십 승인 메일입니다.";
            $m->tpl_name = "membership";
            $m->assigns["main_service_url"] = $this->globals->my_host;
            $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
            $m->send();
        } 
        else if ($_REQUEST["state"] == 2) {
            $msg = "D.CAMP 멤버십 가입신청이 반려되었습니다.";
            if ($_REQUEST["state_des"]) $msg = $msg." 반려사유는 '".$_REQUEST["state_des"]."' 입니다.";
            $arr2["com_type"] = 1;
            $arr2["com_id"] = $user["id"];
            $arr2["act_type"] = 1;
            $arr2["act_id"] = $user["id"];
            $arr2["msg"] = $msg;
            $this->Activity->add($arr2);

            $m = new TF_mailer($this->settings);
            $m->mailto = $user["email"];
            $m->subject = "[D.CAMP] 멤버십 반려 메일입니다.";
            $m->tpl_name = "membership";
            $m->assigns["status"] = 1;
            $m->assigns["des"] = $_REQUEST["state_des"];
            $m->assigns["main_service_url"] = $this->globals->my_host;
            $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
            $m->send();
        }
        
        echo json_encode($result = NULL);
    }
    
    public function del_space($_id)
    {
        $this->Space->delete($_id);
        $this->tpl_name = "";
        echo json_encode($result = NULL);
    }
    
    public function get_ms_info($_id, $_type = "")
    {
        if ($_type) {
            $res = $this->Recommend->get_detail_by_rec($_id);
        }
        else {
            $res = $this->Recommend->get_detail($_id);
        }
        $res["com"] = $this->Startup->get($res["rec_com"]);
        $res["mem"] = $this->Members->get($res["rec_mem"]);
        $res["edu"] = $this->Member_education->list_($res["user_id"]);
        $res["car"] = $this->Startup_member->get_list_by_user($res["user_id"]);
        $res["tw"] = $this->Member_ext->get_by_user_id_type($res["user_id"], Member_ext_model::TWITTER_TYPE);
        $res["fb"] = $this->Member_ext->get_by_user_id_type($res["user_id"], Member_ext_model::FACEBOOK_TYPE);
        $this->assigns["res"] = $res;
    }
   
    public function entrance($_page = '')
    {
        if (!$_page) $_page = 1;
        $pagesize = 10;
        $res_cnt = $this->Entrance->cnt('', '(date_out is NULL or date_out = "" or date_in LIKE "'.date("Y-m-d").'%")');
        $this->assigns["res_curr"] = $this->Entrance->list_($_page, $pagesize, '', '(date_out is NULL or date_out = "" or date_in LIKE "'.date("Y-m-d").'%")');
        $this->assigns["page"] = $_page;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);  
    }
    
    public function entrance_user($_id)
    {
        if ($_REQUEST["user_id"]) {
            $this->Members->edit_info($_id, "admin_des", $_REQUEST["admin_des"]);
            exit(1);
        }
        $res = $this->Members->get($_id);
        $res["mem"] = $this->Recommend->get_by_user($res["id"]);
        $res["cnt_al"] = $this->Entrance->cnt('', 'user_id = '.$res["id"]);
        $res["cnt_m"] = $this->Entrance->cnt(date('Y-m'), 'user_id = '.$res["id"]);
        if ($res["mem"]["rec_com"]) $res["com"] = $this->Startup->get($res["mem"]["rec_com"]);
        if ($res["mem"]["rec_mem"]) $res["mem_"] = $this->Members->get($res["mem"]["rec_mem"]);
        $this->assigns["res"] = $res;
    }
    
    public function info_excel($_id)
    {
        $this->layout = "";
        $res = $this->Event_reserve->list_(1, 1000, "event_id = ".$_id);
        $len_res = sizeof($res);

        header( "Content-type: application/vnd.ms-excel; charset=euc-kr" );
        header( "Content-Disposition: attachment; filename=event_".$_id."_list.xls" );
        header( "Content-Description: PHP4 Generated Data" );
        Print("<Meta Http-Equiv=\"Content-Type\" Content=\"Application/Vnd.Ms-Excel; Charset=UTF-8\">");

        echo "
        <table>
        <tr>
        <td>회원등급</td>
        <td>이름</td>
        <td>연락처</td>
        <td>이메일</td>
        <td>소속</td>
        <td>상태(1:참여대상, 0:신청대기)</td>
        <td>신청일자</td>
        </tr>
        ";

        for($i=0; $i<$len_res; $i++) {
            $com = $this->Startup_member->get_by_user($res[$i]["user_id"]);
            $res[$i]["company"] = $com["name"];
            echo "<tr><td>".$res[$i]["mgname"]."</td><td>".$res[$i]["mname"]."</td><td>".$res[$i]["tel"]."</td><td>".$res[$i]["email"]."</td><td>".$res[$i]["company"]."</td><td>".$res[$i]["state"]."</td><td>".$res[$i]["date_created"]."</td></tr>";
        }

        echo "
        </table>
        ";
        exit(1);
    }

    public function info_excel_front($_id)
    {
        $this->layout = "";
        $e = $this->Event->get($_id);
        if ($e["user_id"] != $_SESSION["s"]["id"]) {
            exit(1);
        }
        $res = $this->Event_reserve->list_(1, 1000, "event_id = ".$_id);
        $len_res = sizeof($res);

        header( "Content-type: application/vnd.ms-excel; charset=euc-kr" );
        header( "Content-Disposition: attachment; filename=event_".$_id."_list.xls" );
        header( "Content-Description: PHP4 Generated Data" );
        Print("<Meta Http-Equiv=\"Content-Type\" Content=\"Application/Vnd.Ms-Excel; Charset=UTF-8\">");

        echo "
        <table>
        <tr>
        <td>회원등급</td>
        <td>이름</td>
        <td>연락처</td>
        <td>이메일</td>
        <td>소속</td>
        <td>상태(1:참여대상, 0:신청대기)</td>
        <td>신청일자</td>
        </tr>
        ";

        for($i=0; $i<$len_res; $i++) {
            $com = $this->Startup_member->get_by_user($res[$i]["user_id"]);
            $res[$i]["company"] = $com["name"];
            echo "<tr><td>".$res[$i]["mgname"]."</td><td>".$res[$i]["mname"]."</td><td>".$res[$i]["tel"]."</td><td>".$res[$i]["email"]."</td><td>".$res[$i]["company"]."</td><td>".$res[$i]["state"]."</td><td>".$res[$i]["date_created"]."</td></tr>";
        }

        echo "
        </table>
        ";
        exit(1);
    }
    
    public function locker_month_possible($_page = 1, $_date = '')
    {
        $pagesize = 10;
        if (!$_date) {
            $time = time(); 
            $_date = date('Y-m', strtotime("-1 month", $time));
        }
        $res = $this->Entrance->get_by_month($_page, $pagesize, $_date);
        $res_cnt = $this->Entrance->get_cnt($_date);
        $len_size = sizeof($res);
        for ($i=0; $i<$len_size; $i++) 
        {
            if ($res[$i]["membership"]) {
                $t = $this->Recommend->get_detail($res[$i]["mid"]);
                $res[$i]["mbs_date"] = $t["date_edited"];
            }
            $cnt_a = $this->Entrance->get_cnt_by_user($res[$i]["mid"]); 
            $res[$i]["cnt_a"] = $cnt_a;
        }
        
        $this->assigns["res"] = $res;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["date"] = $_date;
        $this->assigns["page"] = $_page;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);
    }
    
    public function locker_month_already($_page = 1, $_date = '')
    {
        $pagesize = 10;
        if (!$_date) {
            $time = time(); 
            $_date = date('Y-m', strtotime("-1 month", $time));
        }
        $res = $this->Locker_month->get_by_month($_page, $pagesize, $_date, 'l.state = 1');
        $res_cnt = $this->Locker_month->get_cnt($_date, 'state = 1');
        $len_size = sizeof($res);
        for ($i=0; $i<$len_size; $i++) 
        {
            if ($res[$i]["membership"]) {
                $t = $this->Recommend->get_detail($res[$i]["mid"]);
                $res[$i]["mbs_date"] = $t["date_edited"];
            }
            $cnt_m = $this->Entrance->get_cnt_by_user($res[$i]["mid"], "date_in like '".$_date."%'"); 
            $res[$i]["cnt"] = $cnt_m;
            $cnt_a = $this->Entrance->get_cnt_by_user($res[$i]["mid"]); 
            $res[$i]["cnt_a"] = $cnt_a;
        }
        
        $this->assigns["res"] = $res;
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["date"] = $_date;
        $this->assigns["page"] = $_page;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);
    }
    
    public function get_locker_info($_date = '', $_user = '')
    {
        if ($_REQUEST["locker_id"]) {
            $this->Locker_month->edit_locker($_date, $_user, $_REQUEST["locker_id"]);
        }
        $res = $this->Locker_month->get_by_month_user_id($_date, $_user);
        $this->assigns["res"] = $res;
        $this->assigns["locker"] = $this->Locker_month->get_empty($_date);
    }
    
    public function del_locker_info($_id)
    {
        $this->Locker_month->delete($_id);
    }
    
    public function edit_user_con_cat($_cat, $_id)
    {
        $this->tpl_name = "";
        if ($_REQUEST["del"]) {
            $this->Content_category->edit_user($_cat, $_id, 1);
        }
        else {
            $this->Content_category->edit_user($_cat, $_id);
        }
    }
    
    public function set_con_cat($_ord, $_type)
    {
        $this->Content_category->set_ord($_ord, $_type);
    }

    public function del_examiner($_id)
    {
        $this->tpl_name = "";
        $this->Competitions_examiner->delete($_id);
        echo json_encode($result = NULL);
    }

    public function get_year_visitors($_year)
    {
        $this->tpl_name = '';
        $day = date('d-M-y', strtotime('01-12-'.$_year));
        for ($k=11; $k>=0; $k--)
        {
            $year[$k]["date"] = date("M-Y", strtotime($day." -".$k." month"));
            $year[$k]["val"] = date("Y-m", strtotime($year[$k]["date"]));
            $year[$k]["tot_to"] = $this->Entrance->cnt($year[$k]["val"]);
        }
        $st = substr($st, 0, -2);
        $st = $st . "];";

        echo json_encode($year);
    }

    public function get_space_time($_id)
    {
        $this->tpl_name = "";
        $result = $this->Space->get($_id);
        echo json_encode($result);
    }

    public function del_category($_id)
    {
        if ( ($_SESSION["s"]["per"] & $this->settings->permission1) == $this->settings->permission1 ) {
            $this->tpl_name = "";
            $this->Content_category->delete($_id);
        }
    }

    public function del_contents($_id)
    {
        if ( ($_SESSION["s"]["per"] & $this->settings->permission1) == $this->settings->permission1 ) {
            $this->tpl_name = "";
            $this->Content->delete($_id);
        }
    }

    public function del_recruit($_id)
    {
        if ( ($_SESSION["s"]["per"] & $this->settings->permission1) == $this->settings->permission1 ) {
            $this->tpl_name = "";
            $this->Recruit->delete($_id);
            $this->Recruit_opt->delete_by_recruit($_id);
        }
    }
}

?>