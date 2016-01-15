<?
use Facebook\FacebookCurl;
use Facebook\FacebookCurlHttpClient;
use Facebook\FacebookSession;                         //
use Facebook\FacebookRedirectLoginHelper;             //
use Facebook\FacebookRequest;
use Facebook\FacebookResponse;
use Facebook\FacebookSDKException;
use Facebook\FacebookRequestException;
use Facebook\FacebookOtherException;
use Facebook\FacebookAuthorizationException;
use Facebook\GraphObject;
use Facebook\GraphUser;
use Facebook\GraphSessionInfo;

class Ajax_front extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "";
    var $use_models = array("Member_grade", "Space_reserve", "Notice", "Member_grade"
            , "Event", "Event_reserve", "Startup", "Startup_bussiness", "Startup_tech"
            , "Startup_local", "Startup_reference", "Startup_investment", "Startup_incubating"
            , "Startup_founder", "Startup_service", "Members", "Member_career", "Member_project"
            , "Member_reference", "Board", "Startup_member", "Activity", "Space", "Follow"
            , "Recruit", "Code", "Member_education", "Content", "Competitions_score"
            , "Competitions", "Competitions_examiner", "Competitions_apply", "Competitions_scoring"
            , "Competitions_file", "Recruit_opt", "Member_interist", "Competitions_files"
            , "Member_local", "Member_skill", "Member_inv", "Member_market", "Member_ext"
            , "Office_mento", "Office_hours", "Competitions_form", "Program");
    var $use_components = array('simple_html_dom');
    public function before_calling()
    {
        $this->assigns["s"] = $_SESSION["s"];
    }

    public function img_temp_upload() {
        $this->tpl_name = "";
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
                $result['error_str'] = _("그림파일이 아닙니다.");
            }
            else {
                //이미지 허용 크기를 벗어남
                if ($userfile_size > ($this->settings->max_file * 1048576)) {
                    $result['error_str'] = _("파일 사이즈 ").$this->settings->max_file._("MB 이하의 파일만 업로드 할 수 있습니다.");
                }
                else {
                    $filename = make_upload('media/temp/', 'file');
                    if ($filename) {
                        $src_file = $this->settings->upload_path . 'media/temp/' . $filename;
                        $result["img"] = '/media/temp/' . $filename;
                    }
                }
            }
        }
        echo json_encode($result);
    }
        
    public function form_file(){
        
        $sub_dir = remove_tags2($_REQUEST['sub_dir']);
        if(!$sub_dir){
            $sub_dir = 'media/member/';
        }
        
        //어떤 에러페이지가 있어도 해당 값은 계속 넘겨줘야 함(취약점 문제를 계속 확인 하기 위해)
        $this->assigns['sub_dir'] = $sub_dir;
        $this->assigns['which'] = $_REQUEST['which'];

        if (array_key_exists('file',$_FILES)) {
                //Get the file information
            $max_width = "300";

            if( array_key_exists('r_width',$_REQUEST) && array_key_exists('r_height',$_REQUEST) )
            {
                $this->tpl_name = "form_file_300";
                $thumb_width = $_REQUEST['r_width'];                       // Width of thumbnail image
                $thumb_height = $_REQUEST['r_height'];

                $resize_width= $_REQUEST['r_width']; 
                $resize_height=  $_REQUEST['r_height'];
                
                $max_width = $_REQUEST['r_width'];
            }else{
                $thumb_width = "200";                       // Width of thumbnail image
                $thumb_height = "200";

                $resize_width= "200";
                $resize_height= "200";
            }

            // 재업로드를 한다면 다시 삭제해준다.
            if( array_key_exists('large_image',$_POST) ){
                    $large_image = $this->settings->root_path .$_POST["large_image"];
                    if (file_exists($large_image)){
                            unlink($large_image);
                    }
            }

            $userfile_name = $_FILES['file']['name'];
            $userfile_tmp = $_FILES['file']['tmp_name'];
            $userfile_size = $_FILES['file']['size'];
//          $userfile_type = $_FILES['file']['type'];
            $filename = basename($_FILES['file']['name']);
            $file_ext = strtolower(substr($filename, strrpos($filename, '.') + 1));
            $tmp_filename = 'resize_temp'.strtotime(date('Y-m-d H:i:s')).'.'.$file_ext;

            //단지 JPG, PNG, GIF 만 허용 가능함
            if((!empty($_FILES['file'])) && ($_FILES['file']['error'] == 0)) {
                
                //실제 이미지 확인 
                list($imagewidth, $imageheight, $imageType) = getimagesize($userfile_tmp);
                $userfile_type = image_type_to_mime_type($imageType);
                
                //단지 JPG, PNG, GIF 만 허용 가능함
                $ext_loop = false;
                foreach ($this->settings->allowed_image_types as $mime_type => $ext) {
                    if(is_array($ext)) {
                        for($i=0;$i<sizeof($ext); $i++)
                        {
                            //echo $userfile_type.'  '.$mime_type.' => '.$file_ext.'  '.$ext[$i].'</br>';
                            if( $userfile_type == $mime_type && $file_ext == $ext[$i] ){
                                $file_type = 0;
                                $ext_loop = true;
                                break;
                            }else{
                                $file_type = 1;
                            }
                        }
                        if($ext_loop) break;
                    }
                    else {
                        if($userfile_type == $mime_type && $file_ext == $ext){
                            $file_type = 0;
                            break;
                        }else{
                            $file_type = 1;
                        }
                    }
                }  
                //JPG, PNG, GIF 가 아니라면
                if($file_type == 1){
                        $this->assigns['error_str'] = "그림파일이 아닙니다.";
                        return;
                }

                //이미지 허용 크기를 벗어남
                if ($userfile_size > ($this->settings->max_file * 1048576)) {
                        $this->assigns['error_str'] = "파일 사이즈 ".$this->settings->max_file."MB 이하의 파일만 업로드 할 수 있습니다.";
                        return ;
                }

            }else{
                    //이미지에 에러가 있음
                    $this->assigns['error_str'] = "이미지 데이터 오류가 났습니다. 다시 업로드해 주세요.";
                    return;
            }


            //업로드를 변경 했다면
            if (isset($_FILES['file']['name'])){

                if($sub_dir == 'media/member/'){
                        $sub_large_image_location = 'media/temp/'.$tmp_filename;
                }else{
                        $minus_base_nm = str_replace(basename($sub_dir),'',$sub_dir);
                        if($minus_base_nm == 'media/startup/')
                        {
                           $sub_large_image_location = $minus_base_nm.$tmp_filename;
                        }
                        else
                        {
                                $sub_large_image_location = 'media/temp/'.$tmp_filename;
                        }
                }


                $large_image_location = $this->settings->root_path .$sub_large_image_location;

                move_uploaded_file($userfile_tmp, $large_image_location);

                $width = getWidth($large_image_location);
                $height = getHeight($large_image_location);

                if ($width > $max_width){
                        $scale = $max_width/$width;
                        $uploaded = resizeImage($large_image_location,$width,$height,$scale);
                }else{
                        $scale = 1;
                        $uploaded = resizeImage($large_image_location,$width,$height,$scale);
                }
            }

            //이미지 사이즈가 작으면 선택영역을 최대로 한다.
            $temp_width = getWidth($uploaded);
            $temp_height = getHeight($uploaded);
            if($thumb_height == $thumb_width)
            {
                if($temp_width < $thumb_width) $resize_width = $temp_width;
                if($temp_height < $thumb_height) $resize_height = $temp_height;
                if($resize_width > $resize_height )     $resize_width = $resize_height;
                else                                    $resize_height = $resize_width;
            }
            else
            {
                //둘 다 현재 이미지 보다 큰 경우
                if(  $resize_height > $temp_height  && $resize_width > $temp_width ){

                    $resize_width = $temp_width;
                    $resize_height = $temp_height;
                    if($resize_width > $resize_height)
                    {
                       $resize_width = $resize_height * ($thumb_width/$thumb_height);
                    }
                    else
                    {
                            $resize_height = $resize_width * ($thumb_height/$thumb_width);
                    }

                }else if( $resize_height <= $temp_height  && $resize_width >= $temp_width){
                    $resize_width = $temp_width;
                    $resize_height = $temp_width * ($thumb_height/$thumb_width);
                }
                else if( $resize_width <= $temp_width   && $resize_height >= $temp_height ){

                    $resize_height = $temp_height;
                    $resize_width = $temp_height * ($thumb_width/$thumb_height);
                }
                else {
                    echo "*********".$resize_width .'     '. $temp_width.'-----'.$resize_height .'     '. $temp_height; 
                }
            
            }


            if (file_exists($large_image_location)){
                    $large_photo_exists = $large_image_location;
                    $current_large_image_width = getWidth($large_image_location);
                    $current_large_image_height = getHeight($large_image_location);
            } else {
                    $large_photo_exists = "";
                    $thumb_photo_exists = "";
            }

            $this->assigns['current_large_image_width'] = $current_large_image_width;
            $this->assigns['current_large_image_height'] = $current_large_image_height;
            $this->assigns['thumb_width'] = $thumb_width;
            $this->assigns['thumb_height'] = $thumb_height;
            $this->assigns['resize_width'] = $resize_width;
            $this->assigns['resize_height'] = $resize_height;
            $this->assigns['large_photo_exists'] = $large_photo_exists;
            $this->assigns['sub_large_image_location'] = '/'.$sub_large_image_location;
        }

        //업로드를 변경 했다면
        if(array_key_exists('thumb_width',$_REQUEST)){
            //Get the new coordinates to crop the image.

            $start =  strpos($sub_dir,"/",6) + 1;
            $end =  strpos($sub_dir,"/",strpos($sub_dir,"/",6)+1);
            $length = $end - $start;
            $temp_size_str =  substr($sub_dir,$start,$length);

            $x1 = $_POST["x1"];
            $y1 = $_POST["y1"];
            $x2 = $_POST["x2"];
            $y2 = $_POST["y2"];
            $w = $_POST["w"];
            $h = $_POST["h"];
            $thumb_width = $_POST["thumb_width"];
//            if($sub_dir == 'media/member/'){
//                    $tmp_thumbnail = $sub_dir.$_SESSION['s']['id'].".jpg";
//            }else{
//
//                $tmp_thumbnail = $sub_dir;
//            }
            $tmp_thumbnail = 'resize_temp'.strtotime(date('Y-m-d H:i:s')).'.'.jpg;

            //취약점 보안
            if(array_key_exists('large_image',$_POST)){
                
                $low_str = strtolower($_POST["large_image"]);
                for($i=0;$i<sizeof($this->settings->weak_part); $i++)
                {
                    $pattern = '/^\/'.$this->settings->weak_part[$i].'\/resize_temp[0-9]+.(jpg|gif|jpeg|png)$/';
                    if(preg_match($pattern,$low_str,$match)){
                        break;
                    }
                }
            }

            $thumb_image = $this->settings->root_path .'media/temp/'.$tmp_thumbnail;
            $large_image = $this->settings->root_path .$_POST["large_image"];

            $scale = $thumb_width/$w;

            resizeThumbnailImage($thumb_image, $large_image,$w,$h,$x1,$y1,$scale);

            //리사이즈용  임시 이미지 삭제
            if (file_exists($large_image)){
                unlink($large_image);
            }

            $this->assigns['thumbnail'] = '/media/temp/'.$tmp_thumbnail;
            
        }
        $this->assigns['r_width'] = $_REQUEST['r_width'];
        $this->assigns['r_height'] = $_REQUEST['r_height'];

    }
    
    public function startup_edit() {
        $this->Startup->add($_REQUEST);
        if ($_REQUEST["description"])
            $result["data"] = str_replace("\n","<br />", $_REQUEST["description"]);
        else if ($_REQUEST["bm_des"])
            $result["data"] = str_replace("\n","<br />", $_REQUEST["bm_des"]);
        else if ($_REQUEST["bm_tech"])
            $result["data"] = str_replace("\n","<br />", $_REQUEST["bm_tech"]);
        
        $mem = $this->Startup->get($_REQUEST["id"]);
        $m = "<a href='/startup/".$mem["id"]."'>".$mem["name"]."</a>님이 소개를 수정하였습니다.";
        add_activity(2, $mem["id"], 2, $mem["id"], "", $m);
            
        $this->tpl_name = "";
        echo json_encode($result);
    }
    
    public function startup_get_service($_id) {
        $res = $this->Startup_service->list_($_id);
        $com = $this->Startup->get($_id);
        $this->assigns["com"] = $com;
        $this->assigns["id"] = $_id;
        $this->assigns["service"] = $res;
        $this->assigns["edi"] = $this->Startup_member->get_first($_id, $_SESSION["s"]["id"]);
    }
    
    public function startup_get_service_e($_id) {
        $this->assigns["res"] = $this->Startup_service->get($_id);
    }
    
    public function startup_edit_service() {
        if ($_REQUEST["id"]) $ex = $this->Startup_service->get($_REQUEST["id"]);
        $_id = $this->Startup_service->add($_REQUEST);
        $_REQUEST["id"] = $_id;
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
        
        $result["data"] = $_id;
        $mem = $this->Startup->get($_REQUEST["startup_id"]);
        $m = "<a href='/startup/".$mem["id"]."'>".$mem["name"]."</a>님이 제품/서비스 정보를 수정하였습니다.";
        add_activity(2, $mem["id"], 2, $mem["id"], "", $m);
        
        $this->tpl_name = "";
        echo json_encode($result);
    }
    
    public function startup_del_service($_id) {
        $sr = $this->Startup_service->get($_id);
        // $this->Startup_service->del_cache($sr["startup_id"]);
        $this->Startup_service->delete($_id);
        $this->Startup_service->del_category($_id);
        $this->Startup_service->del_date($_id);
        $this->tpl_name = "";
        echo json_encode($result);
    }
    
    public function startup_get_ref($_id)
    {
        $res = $this->Startup_reference->list_($_id);
        $this->assigns["id"] = $_id;
        $this->assigns["res"] = $res;
    }
    
    public function startup_edit_ref()
    {
        if ( ! $_REQUEST["startup_id"]) {
            return false;
        }
        
        if (!$_REQUEST["id"]) $_REQUEST["id"] = 0;
        $ref = $this->Members->get_by_email($_REQUEST["email"]);
        $result["data"] = $this->Startup_reference->add($_REQUEST["startup_id"], $_REQUEST["user_id"]
                , $_REQUEST["email"], $ref["id"], $_REQUEST["contents"], $_REQUEST["type"]);

        $st = $this->Startup->get($_REQUEST["startup_id"]);
        if ($ref) {
//            $mem = $this->Members->get($_REQUEST["user_id"]);
            $m = "<a href='/startup/".$st["id"]."'>".$st["name"]."</a>님이 D.CAMP의 프로필/이력 페이지에 당신의 레퍼런스를 추가하고자 합니다. <a href='/startup/".$st["id"]."#reference_space'>".$st["name"]."</a>에 대한 추천사를 남겨주세요.";
//            add_activity("1", $mem["id"], "1", $mem["id"], "", $m);
            
//            //me
//            $arr["com_type"] = 1;
//            $arr["com_id"] = $_SESSION["s"]["id"];
//            $arr["act_type"] = 1;
//            $arr["act_id"] = $_SESSION["s"]["id"];
//            $arr["act_result"] = '';
//            $arr["target_type"] = '';
//            $arr["target_id"] = '';
//            $arr["is_made"] = '';
//            $arr["msg"] = $m;
//            $this->Activity->add($arr);
            
            //you
            $arr2["com_type"] = 1;
            $arr2["com_id"] = $ref["id"];
            $arr2["act_type"] = 2;
            $arr2["act_id"] = $_REQUEST["startup_id"];
            $arr2["act_result"] = '';
            $arr2["target_type"] = Activity_model::E_TYPE_REFERENCE;
            $arr2["target_id"] = '';
            $arr2["is_made"] = '';
            $arr2["msg"] = $m;
            $this->Activity->add($arr2);
        }

        $m = new TF_mailer($this->settings);
        $m->mailto = $_REQUEST["email"];
        $m->subject = "[D.CAMP] ".$st["name"]."에 대한 추천사를 남겨주세요.";
        $m->tpl_name = "reference";
        $m->assigns["contents"] = $_REQUEST["contents"];
        $m->assigns["url"] = '/startup/'.$st["id"];
        $m->assigns["ref"] = $_REQUEST["email"];
        $m->assigns["main_service_url"] = $this->globals->my_host;
        $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
        $m->send();

        $this->tpl_name = "";
        echo json_encode($result);
    }
    
    public function startup_write_ref()
    { 
        if ( ! $_SESSION["s"]["id"] ){
            return false;
        }
        $result["data"] = $this->Startup_reference->add_ref($_SESSION["s"]["id"], $_REQUEST["req_id"]
                , $_REQUEST["reference"]);
        $this->Startup_reference->edit_state_ref($_REQUEST["req_id"], $_SESSION["s"]["email"], 1);
        $mem = $this->Startup->get($_REQUEST["req_id"]);
        $m = "<a href='/member/".$_SESSION["s"]["ids"]."'>".$_SESSION["s"]["name"]."</a>님이 <a href='/startup/".$mem["id"]."'>".$mem["name"]."</a>님의 프로필/이력 페이지에 <a href='/startup/".$mem["id"]."?tab=profile-content-reference'>레퍼런스</a>를 추가하였습니다.";

        //me
        $arr["com_type"] = 1;
        $arr["com_id"] = $_SESSION["s"]["id"];
        $arr["act_type"] = 1;
        $arr["act_id"] = $_SESSION["s"]["id"];
        $arr["act_result"] = '';
        $arr["target_type"] = Activity_model::E_TYPE_REFERENCE;
        $arr["target_id"] = '';
        $arr["is_made"] = '';
        $arr["msg"] = $m;
        $this->Activity->add($arr);

        //you
        $arr2["com_type"] = 2;
        $arr2["com_id"] = $mem["id"];
        $arr2["act_type"] = 1;
        $arr2["act_id"] = $_SESSION["s"]["id"];
        $arr2["act_result"] = '';
        $arr2["target_type"] = Activity_model::E_TYPE_REFERENCE;
        $arr2["target_id"] = '';
        $arr2["is_made"] = '';
        $arr2["msg"] = $m;
        $this->Activity->add($arr2);

        $this->tpl_name = "";
        echo json_encode($result);
    }
    
    public function startup_del_ref($_id) {
        $this->Startup_reference->delete($_id);
        $this->tpl_name = "";
        echo json_encode($result);
    }
    
    public function startup_get_inv($_id) {
        $res = $this->Startup_investment->list_($_id);
        $this->assigns["id"] = $_id;
        $this->assigns["invest"] = $res;
        $this->assigns["edi"] = $this->Startup_member->get_first($_id, $_SESSION["s"]["id"]);
    }
    
    public function startup_edit_inv() {
        $result["data"] = $this->Startup_investment->add($_REQUEST["startup_id"]
                ,$_REQUEST["investor"],$_REQUEST["email"],$_REQUEST["date"]
                ,$_REQUEST["investment"],$_REQUEST["type"],$_REQUEST["id"]);
        
        $mem = $this->Startup->get($_REQUEST["startup_id"]);
        $m = "<a href='/startup/".$mem["id"]."'>".$mem["name"]."</a>님이 투자내역을 수정하였습니다.";
        add_activity(2, $mem["id"], 2, $mem["id"], "", $m);
        
        $this->tpl_name = "";
        echo json_encode($result);
    }
    
    public function startup_del_inv($_id) {
        $this->Startup_investment->delete($_id);
        $this->tpl_name = "";
        echo json_encode($result);
    }
    
    public function startup_get_inc($_id) {
        $res = $this->Startup_incubating->list_($_id);
        $this->assigns["id"] = $_id;
        $this->assigns["incubat"] = $res;
        $this->assigns["edi"] = $this->Startup_member->get_first($_id, $_SESSION["s"]["id"]);
    }
    
    public function startup_edit_inc() {
        $result["data"] = $this->Startup_incubating->add($_REQUEST["startup_id"]
                ,$_REQUEST["incubator"], $_REQUEST['description'], $_REQUEST["email"]
                ,$_REQUEST["start"], $_REQUEST["end"],$_REQUEST["id"]);
        
        $mem = $this->Startup->get($_REQUEST["startup_id"]);
        $m = "<a href='/startup/".$mem["id"]."'>".$mem["name"]."</a>님이 인큐베이팅 프로그램/기관 참여 내역을 수정하였습니다.";
        add_activity(2, $mem["id"], 2, $mem["id"], "", $m);
        
        $this->tpl_name = "";
        echo json_encode($result);
    }
    
    public function startup_del_inc($_id) {
        $this->Startup_incubating->delete($_id);
        $this->tpl_name = "";
        echo json_encode($result);
    }
    
    public function member_get_career($_id)
    {
        $res = $this->Startup_member->get_list_by_user($_id);
        $this->assigns["id"] = $_id;
        $this->assigns["res"] = $res;
    }
    
    public function member_get_investment($_id)
    {
        $res = $this->Startup_member->get_list_by_user($_id);
        $this->assigns["id"] = $_id;
        $this->assigns["res"] = $res;
    }

    public function member_del_career($_id) {
        $this->Startup_member->delete($_id);
        $this->tpl_name = "";
        echo json_encode($result);
    }
    
    public function member_get_pj($_id)
    {
        $st = $this->Startup_member->get_list_by_user($_id);
        $res = $this->Member_project->list_($_id);
        $this->assigns["id"] = $_id;
        $this->assigns["res"] = $res;
        $this->assigns["st"] = $st;
    }
    
    public function member_edit_pj()
    {
        if (!$_REQUEST["id"]) $_REQUEST["id"] = 0;
        $result["data"] = $this->Member_project->add($_REQUEST["uid"], $_REQUEST["startup_id"], $_REQUEST["project"]
                , $_REQUEST["start"], $_REQUEST["end"], $_REQUEST["role"], $_REQUEST["is_ing"]
                , $_REQUEST["id"]);
        
        $mem = $this->Members->get($_REQUEST["uid"]);
        $m = "<a href='/member/".$mem["ids"]."'>".$mem["name"]."</a>님이 참여 프로젝트를 수정하였습니다.";
        add_activity("1", $mem["id"], "1", $mem["id"], "", $m);
        
        $this->tpl_name = "";
        echo json_encode($result);
    }
    
    public function member_del_pj($_id) {
        $this->Member_project->delete($_id);
        $this->tpl_name = "";
        echo json_encode($result);
    }
    
    public function member_get_ref($_id)
    {
        $res = $this->Member_reference->list_($_id);
        $this->assigns["id"] = $_id;
        $this->assigns["res"] = $res;
    }
    
    public function member_edit_ref()
    {
        if ( ! $_SESSION["s"]["ids"]) {
            return false;
        }

        if (!$_REQUEST["id"]) $_REQUEST["id"] = 0;
        $ref = $this->Members->get_by_email($_REQUEST["email"]);
        $result["data"] = $this->Member_reference->add($_REQUEST["uid"], $_REQUEST["email"]
                , $ref["id"], $_REQUEST["contents"], $_REQUEST["type"]);
        
        if ($ref) {
//            $mem = $this->Members->get($_REQUEST["user_id"]);
            $m = "<a href='/member/".$_SESSION["s"]["ids"]."'>".$_SESSION["s"]["name"]."</a>님이 D.CAMP의 프로필/이력 페이지에 당신의 레퍼런스를 추가하고자 합니다. <a href='/member/".$_SESSION["s"]["ids"]."#reference_space'>".$_SESSION["s"]["name"]."</a>님에 대한 추천사를 남겨주세요.";
//            add_activity("1", $mem["id"], "1", $mem["id"], "", $m);
            
//            //me
//            $arr["com_type"] = 1;
//            $arr["com_id"] = $_SESSION["s"]["id"];
//            $arr["act_type"] = 1;
//            $arr["act_id"] = $_SESSION["s"]["id"];
//            $arr["act_result"] = '';
//            $arr["target_type"] = '';
//            $arr["target_id"] = '';
//            $arr["is_made"] = '';
//            $arr["msg"] = $m;
//            $this->Activity->add($arr);
            
            //you
            $arr2["com_type"] = 1;
            $arr2["com_id"] = $ref["id"];
            $arr2["act_type"] = 1;
            $arr2["act_id"] = $_SESSION["s"]["id"];
            $arr2["act_result"] = '';
            $arr2["target_type"] = Activity_model::E_TYPE_REFERENCE;
            $arr2["target_id"] = '';
            $arr2["is_made"] = '';
            $arr2["msg"] = $m;
            $this->Activity->add($arr2);
    }
        $m = new TF_mailer($this->settings);
        $m->mailto = $_REQUEST["email"];
        $m->subject = "[D.CAMP] ".$_SESSION["s"]["name"]."님에 대한 추천사를 남겨주세요.";
        $m->tpl_name = "reference";
        $m->assigns["contents"] = $_REQUEST["contents"];
        $m->assigns["url"] = '/member/'.$_SESSION["s"]["ids"];
        $m->assigns["ref"] = $_REQUEST["email"];
        $m->assigns["main_service_url"] = $this->globals->my_host;
        $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
        $m->send();
      
        $this->tpl_name = "";
        echo json_encode($result);
    }
    
    public function member_write_ref()
    {
        if ( ! $_SESSION["s"]["id"] ){
            return false;
        }
        $result["data"] = $this->Member_reference->add_ref($_SESSION["s"]["id"], $_REQUEST["req_id"]
                , $_REQUEST["reference"]);
        $this->Member_reference->edit_state_ref($_REQUEST["req_id"], $_SESSION["s"]["email"], 1);
        $mem = $this->Members->get($_REQUEST["req_id"]);
        $m = "<a href='/member/".$_SESSION["s"]["ids"]."'>".$_SESSION["s"]["name"]."</a>님이 <a href='/member/".$mem["ids"]."'>".$mem["name"]."</a>님의 프로필/이력 페이지에 <a href='/member/".$mem["ids"]."?tab=profile-content-reference'>레퍼런스</a>를 추가하였습니다.";

        //me
        $arr["com_type"] = 1;
        $arr["com_id"] = $_SESSION["s"]["id"];
        $arr["act_type"] = 1;
        $arr["act_id"] = $_SESSION["s"]["id"];
        $arr["act_result"] = '';
        $arr["target_type"] = Activity_model::E_TYPE_REFERENCE;
        $arr["target_id"] = '';
        $arr["is_made"] = '';
        $arr["msg"] = $m;
        $this->Activity->add($arr);

        //you
        $arr2["com_type"] = 1;
        $arr2["com_id"] = $mem["id"];
        $arr2["act_type"] = 1;
        $arr2["act_id"] = $_SESSION["s"]["id"];
        $arr2["act_result"] = '';
        $arr2["target_type"] = Activity_model::E_TYPE_REFERENCE;
        $arr2["target_id"] = '';
        $arr2["is_made"] = '';
        $arr2["msg"] = $m;
        $this->Activity->add($arr2);
        
        $m = new TF_mailer($this->settings);
        $m->mailto = $_REQUEST["email"];
        $m->subject = "[D.CAMP] ".$_SESSION["s"]["name"]."님이 ".$mem["name"]."님의 '레퍼런스'에 글을 작성하였습니다.";
        $m->tpl_name = "reference2";
        $m->assigns["res"] = $_SESSION["s"];
        $m->assigns["req"] = $mem;
        $m->assigns["main_service_url"] = $this->globals->my_host;
        $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
        $m->send();

        $this->tpl_name = "";
        echo json_encode($result);
    }
    
    public function member_del_ref($_id) {
        $this->Member_reference->delete($_id);
        $this->tpl_name = "";
        echo json_encode($result);
    }
    
    public function member_edit_career()
    {
        if (!$_REQUEST["id"]) $_REQUEST["id"] = 0;
        $_REQUEST["status"] = 0;
        $str = $this->Startup->get_by_name($_REQUEST["company"]);
        if ($_REQUEST["is_ing"]) {
            $tem = $this->Startup_member->get_by_startup($str["id"]);
            if (!sizeof($tem) || (sizeof($tem) == 1 && $tem[0]["mid"] == $_REQUEST["user_id"]) 
                    || (sizeof($tem) == 1 && $tem[0]["status"] == 0)) $_REQUEST["status"] = 1;

            $tem3 = $this->Startup_member->get_by_startup($str["id"], "", "sm.status = 1" );
            if (!sizeof($tem3)) $_REQUEST["status"] = 1;

            // member들에게 메일 및 노티
            $us = $this->Startup_member->get_by_startup($str["id"], '', 'sm.status = 1');
            for ($i=0; $i<sizeof($us); $i++) {
                $_arr["com_type"] = 1;
                $_arr["com_id"] = $us[$i]["mid"];
                $_arr["act_type"] = 1;
                $_arr["act_id"] = $_SESSION["s"]["id"];
                $_arr["msg"] = '<a href="/member/'.$_SESSION["s"]["ids"].'">"'.$_SESSION["s"]["name"].'"</a>님이 <a href="/startup/'.$str["id"].'">"'.$str["name"].'"</a> 구성원으로 신청하셨습니다.';
                $this->Activity->add($_arr);

                $m = new TF_mailer($this->settings);
                $m->mailto = $us[$i]["memail"];
                $m->subject = "[D.CAMP] ".$str["name"]." 구성원 신청이 있습니다.";
                $m->tpl_name = "staff_apply2";
                $m->assigns["res"] = $_SESSION["s"];
                $m->assigns["st"] = $str;
                $m->assigns["contents"] = $_REQUEST["contents"];
                $m->assigns["main_service_url"] = $this->globals->my_host;
                $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                $m->send();
            }

        }
        $result["data"] = $this->Startup_member->add($str["id"], $_REQUEST["user_id"]
                    , $_REQUEST["id"], $_REQUEST["role"], $_REQUEST["start"], $_REQUEST["end"]
                    , $_REQUEST["is_ing"], $_REQUEST["status"]);
        
        $mem = $this->Members->get($_REQUEST["user_id"]);
        $m = "<a href='/member/".$mem["ids"]."'>".$mem["name"]."</a>님이 관련기업을 수정하였습니다.";
        add_activity("1", $mem["id"], "1", $mem["id"], "", $m);
        
        $this->tpl_name = "";
        echo json_encode($result);
    }
    
    public function member_get_edu($_id)
    {
        $res = $this->Member_education->list_($_id);
        $this->assigns["id"] = $_id;
        $this->assigns["res"] = $res;
    }
    
    public function member_edit_edu()
    {
        if (!$_REQUEST["id"]) $_REQUEST["id"] = 0;
        $result["data"] = $this->Member_education->add($_REQUEST["uid"], $_REQUEST["education"]
                , $_REQUEST["education_sp"], $_REQUEST["education_st"], $_REQUEST["id"]);
        $this->tpl_name = "";
        echo json_encode($result);
    }
    
    public function member_del_edu($_id) {
        $this->Member_education->delete($_id);
        $this->tpl_name = "";
        echo json_encode($result);
    }

    public function get_reply($_type, $_pid, $_page)
    {
        $pagesize = 10;
        $res = $this->Board->list_($_type, $_pid, $_page, $pagesize);
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            $res[$i]["comm"] = $this->Board->get_comment($_type, $res[$i]["id"]);
        }
        $this->assigns["type"] = $_type;
        $this->assigns["pid"] = $_pid;
        $this->assigns["page"] = $_page;
        $this->assigns["res"] = $res;
        $this->assigns["s"] = $_SESSION["s"];
    }

    public function get_timeline($_type, $_pid, $_page, $_opt = 0)
    {
        /*
        type 1: member
        type 2: startup
        type 3: event
        type 4: recruit
        type 5: notice
        type 6: contents(blog)
        type 7: competition(challenge)
        type 8: office hours
        type 9: benefit 
        type 10: showcase
        */

        $pagesize = 10;
        $where = "";
        if ($_type == 1 || $_type == 2) {
            $this->tpl_name = "get_timeline_profile";
            if ($_type == 1) {
                if ($_opt == 1) $where = "user_id = ".$_pid;
                else if ($_opt == 2) $where = "user_id != ".$_pid;
            }
            else if ($_type == 2) {
                $edi = $this->Startup_member->get_first($_pid, $_SESSION["s"]["id"]);
                $this->assigns["edi"] = false;
                if ($edi) $this->assigns["edi"] = true;

                if ($_opt == 1) $where = "user_id IN (SELECT user_id FROM startup_member WHERE startup_id = ".$_pid." AND STATUS = 1)";
                else if ($_opt == 2) $where = "user_id NOT IN (SELECT user_id FROM startup_member WHERE startup_id = ".$_pid." AND STATUS = 1)";
                $st = $this->Startup->get($_pid);
                $this->assigns["st"] = $st;
            }
        }
        // $this->Board->debug();
        $res = $this->Board->list_($_type, $_pid, $_page, $pagesize, $where);
        if ($_type > 2) $this->assigns["tot"] = $this->Board->cnt('p_type = '.$_type.' and p_id ='.$_pid);
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            $res[$i]["like"] = $this->Board->get_like_cnt($res[$i]["id"]);
            $res[$i]["is_like"] = $this->Board->get_like_this($res[$i]["id"], $_SESSION["s"]["id"]);
            $res[$i]["comm"] = $this->Board->get_comment($_type, $res[$i]["id"]);
            if ($_type == 2 && $_opt == 1) {
                for ($c=0; $c<sizeof($res[$i]["comm"]); $c++){
                    $e = $this->Startup_member->get_first($_pid, $res[$i]["comm"][$c]["user_id"]);
                    if ($e) {
                        $ee = $this->Startup->get($_pid);
                        $res[$i]["comm"][$c]["s_id"] = $ee["id"];
                        $res[$i]["comm"][$c]["s_logo"] = $ee["logo"];
                        $res[$i]["comm"][$c]["s_name"] = $ee["name"];
                    }
                }   
            }
        }
        $this->assigns["type"] = $_type;
        $this->assigns["pid"] = $_pid;
        $this->assigns["page"] = $_page;
        $this->assigns["res"] = $res;
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns["pic"] = $this->Board->list_($_type, $_pid, 1, 100, '(image is not NULL or image != "")');
        $this->assigns["opt"] = $_opt;
        if ($_type == 3) {
            $this->assigns["check"] = $this->Event->check_star($_pid, $_SESSION["s"]["id"]);
            $this->assigns["star"] = $this->Event->get_average_star($_pid);
            $this->assigns["ev"] = $this->Event->get($_pid);
        }
        if ($_type > 7) {
            $this->tpl_name = "get_timeline_2015";
        }
    }

    public function get_timeline_2015($_type, $_pid, $_page, $_opt = 0)
    {
        /*
        type 1: member
        type 2: startup
        type 3: event
        type 4: recruit
        type 5: notice
        type 6: contents(blog)
        type 7: competition(challenge)
        type 8: office hours
        type 9: benefit 
        type 10: showcase
        */

        $pagesize = 10;
        $comments = $this->Board->list_($_type, $_pid, $_page, $_pagesize);
        for ( $i=0; $i<sizeof($comments); $i++ ){
            if ($_id == 0 && $comments[$i]["p_id"] > 0 ) {
                $e = $this->Event->get($comments[$i]["p_id"]);
                $comments[$i]["p_name"] = $e["title"];
                
            }
            $comments[$i]["comm"] = $this->Board->get_comment($_type, $comments[$i]["id"]);
            $comments[$i]["like"] = $this->Board->get_like_cnt($comments[$i]["id"]);
            $comments[$i]["is_like"] = $this->Board->get_like_this($comments[$i]["id"], $_SESSION["s"]["id"]);
        }
            
        if ($_type == 8) {
            $res = $this->Office_mento->get($_pid);
            $this->assigns["star"] = $this->Office_mento->get_average_star($_id);
        }

        $this->assigns["id"] = $_pid;
        $this->assigns["comments"] = $comments;

        $this->assigns["page"] = $_page;
        $this->assigns["res"] = $res;
        $this->assigns["type"] = $_type;
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns["pic"] = $this->Board->list_($_type, $_pid, 1, 100, '(image is not NULL or image != "")');
        $this->assigns["opt"] = $_opt;


        $this->assigns["tw"] = $this->Member_ext->get_by_user_id_type($_SESSION["s"]["id"], Member_ext_model::TWITTER_TYPE);
        $this->assigns["fb"] = $this->Member_ext->get_by_user_id_type($_SESSION["s"]["id"], Member_ext_model::FACEBOOK_TYPE); 
    }
    
    public function more_timeline($_type = '', $_pid = '', $_page = '')
    {
        $pagesize = 10;
        $res = $this->Board->list_($_type, $_pid, $_page, $pagesize);
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            $res[$i]["comm"] = $this->Board->get_comment($_type, $res[$i]["id"]);
        }
        $this->assigns["type"] = $_type;
        $this->assigns["pid"] = $_pid;
        $this->assigns["page"] = $_page;
        $this->assigns["res"] = $res;
        $this->assigns["s"] = $_SESSION["s"];

    }

    public function more_timeline_p($_type = '', $_pid = '', $_opt='', $_page = '')
    {
        $pagesize = 10;
        $where = "";
        if ($_type == 1) {
            $this->tpl_name = "more_timeline_profile";
            if ($_opt == 1) $where = "user_id = ".$_SESSION["s"]["id"];
            else if ($_opt == 2) $where = "user_id != ".$_SESSION["s"]["id"];
        }
        else if ($_type == 2) {
            $this->tpl_name = "more_timeline_profile";
            if ($_opt == 1) $where = "user_id IN (SELECT user_id FROM startup_member WHERE startup_id = ".$_pid." AND STATUS = 1)";
            else if ($_opt == 2) $where = "user_id NOT IN (SELECT user_id FROM startup_member WHERE startup_id = ".$_pid." AND STATUS = 1)";
            $st = $this->Startup->get($_pid);
            $this->assigns["st"] = $st;
        }
        $res = $this->Board->list_($_type, $_pid, $_page, $pagesize, $where);
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            $res[$i]["comm"] = $this->Board->get_comment($_type, $res[$i]["id"]);
            if ($_type == 2 && $_opt == 1) {
                for ($c=0; $c<sizeof($res[$i]["comm"]); $c++){
                    $e = $this->Startup_member->get_first($_pid, $res[$i]["comm"][$c]["user_id"]);
                    if ($e) {
                        $ee = $this->Startup->get($_pid);
                        $res[$i]["comm"][$c]["s_id"] = $ee["id"];
                        $res[$i]["comm"][$c]["s_logo"] = $ee["logo"];
                        $res[$i]["comm"][$c]["s_name"] = $ee["name"];
                    }
                }   
            }
        }
        $this->assigns["type"] = $_type;
        $this->assigns["pid"] = $_pid;
        $this->assigns["page"] = $_page;
        $this->assigns["opt"] = $_opt;
        $this->assigns["res"] = $res;
        $this->assigns["s"] = $_SESSION["s"];
    }

    public function add_timeline()
    {
        $result["data"] = $this->Board->add($_REQUEST);
        if ($_REQUEST["image"]) {
            $new_i = $this->settings->root_path . "media/board/" . $result["data"] . ".jpg";
            $ori_i = $this->settings->root_path . substr($_REQUEST["image"], 1);
            GD2_make_thumb_x(600, "", $ori_i);
            copy($ori_i, $new_i);
            unlink(substr($_REQUEST["image"], 1));
            $_arr["id"] = $result["data"] ;
            $_arr["image"] = "/media/board/" . $result["data"]  . ".jpg";
            $this->Board->add_image($_arr);
        }
        //activity
        if ($_REQUEST["p_type"] != 3) {
            $wr = $this->Members->get($_REQUEST["user_id"]);
            if ($_REQUEST["p_type"] == 1) {
                $rc = $this->Members->get($_REQUEST["p_id"]);
                $m = "<a href='/member/".$wr["ids"]."'>".$wr["name"]."</a>님이 <a href='/member/".$rc["ids"]."'>".$rc["name"]."</a>님의 <a href='/member/".$rc["ids"]."?tab=profile-content-wall'>방명록</a>에 글을 남겼습니다.";
                if($_REQUEST["p_id"] == $_REQUEST["user_id"]) {
                    $m = "<a href='/member/".$wr["ids"]."'>".$wr["name"]."</a>님이 프로필 페이지에 <a href='/member/".$rc["ids"]."?tab=profile-content-update'>새 글</a>을 남겼습니다.";
                }
                if ( ! $_REQUEST["is_hidden"]) {
                    add_activity("1", $wr["id"], "1", $wr["id"], "", $m);
                }
            }
            if ($_REQUEST["p_type"] == 2) {
                $rc = $this->Startup->get($_REQUEST["p_id"]);
                $m = "<a href='/member/".$wr["ids"]."'>".$wr["name"]."</a>님이 <a href='/startup/".$rc["id"]."'>".$rc["name"]."</a>의 <a href='/startup/".$rc["id"]."?tab=profile-content-wall'>방명록</a>에 글을 남겼습니다.";
                if($this->Startup_member->get_first($_REQUEST["p_id"], $_REQUEST["user_id"])) {
                    $m = "<a href='/member/".$wr["ids"]."'>".$wr["name"]."</a>님이 <a href='/startup/".$rc["id"]."'>".$rc["name"]."</a> 페이지에 <a href='/startup/".$rc["id"]."?tab=profile-content-wall'>새 글</a>을 남겼습니다.";
                }
                if ( ! $_REQUEST["is_hidden"]) {
                    add_activity("1", $wr["id"], "1", $wr["id"], "", $m);
                }
            }

            if ($rc["id"] != $wr["id"]) {
                $arr["com_type"] = 1;
                $arr["com_id"] = $rc["id"];
                $arr["act_type"] = 1;
                $arr["act_id"] = $wr["id"];
                $arr["msg"] = $m;
                $this->Activity->add($arr);

                if ($_REQUEST["p_type"] == 1 && $rc["email_rec"]) {
                    $m = new TF_mailer($this->settings);
                    $m->mailto = $rc["email"];
                    $m->subject = "[D.CAMP] ".$wr["name"]."님이 ".$rc["name"]."님의 '방명록'에 글을 작성하였습니다.";
                    $m->tpl_name = "timeline";
                    $m->assigns["wr"] = $wr;
                    $m->assigns["rc"] = $rc;
                    $m->assigns["contents"] = $_REQUEST["contents"];
                    $m->assigns["main_service_url"] = $this->globals->my_host;
                    $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                    $m->send();
                }
            }
            if (!$_REQUEST["is_hidden"]) {
                if ($_REQUEST["fb"]) {
                    if ($_SESSION["s"]["fb"]["public"]) {
                        $APP_ID = $this->settings->FACEBOOK_API_KEY;
                        $APP_SECRET = $this->settings->FACEBOOK_SECRET;
                        FacebookSession::setDefaultApplication( $APP_ID, $APP_SECRET );
                        
                        $session = new FacebookSession( $_SESSION["s"]["fb"]["secret"] );
                        $request = new FacebookRequest(
                          $session,
                          'POST',
                          '/me/feed',
                          array (
                            'message' => $_REQUEST["contents"],
                            'link' => "http://".$_SERVER["HTTP_HOST"]."/timeline/".$result["data"]
                          )
                        ); 
                        $response = $request->execute();
                        $graphObject = $response->getGraphObject();
                    }
                       

                }
                if ($_REQUEST["tw"]) {
                    twitter_post($_SESSION["s"]["tw"]["key_"], $_SESSION["s"]["tw"]["secret"], cut_multi($_REQUEST["contents"], 100)." http://dcamp.kr/timeline/".$result["data"]);
                }
            }
        }

        if ($_REQUEST["p_type"] == 3 || $_REQUEST["p_type"] == 7 || $_REQUEST["p_type"] == 6
                || $_REQUEST["p_type"] == 4) {
            $rc = $this->Members->get($_SESSION["s"]["id"]);
            if ($_REQUEST["p_type"] == 3) { //event
                
                $ev = $this->Event->get_detail($_REQUEST["p_id"]);
                $m = "<a href='/member/".$rc["ids"]."'>".$rc["name"]."</a>님이 \"<a href='/event/apply/".$ev["id"]."#comment'>".$ev["title"]."</a>\" 이벤트에 댓글을 달았습니다.";

                $mailto = $ev["memail"];
                $subject = "[D.CAMP] ".$rc["name"]."님이 \"".$ev["title"]."\" 이벤트에 댓글을 달았습니다.";;
                $title = "<a href='http://dcamp.kr/member/".$rc["ids"]."'>".$rc["name"]."</a>님이 \"<a href='http://dcamp.kr/event/apply/".$ev["id"]."'>".$ev["title"]."</a>\" 이벤트에 댓글을 달았습니다.";
                $url = "/event/apply/".$ev["id"]."#comment";
                $cid = $ev["user_id"];
            }
            else if ($_REQUEST["p_type"] == 7) { // challenge, competition
                $ev = $this->Competitions->get($_REQUEST["p_id"]);
                $m = "<a href='/member/".$rc["ids"]."'>".$rc["name"]."</a>님이 \"<a href='/competition/views/".$ev["id"]."#comment'>".$ev["subject"]."</a>\" 경진대회에 댓글을 달았습니다.";

                $mailto = $ev["memail"];
                $subject = "[D.CAMP] ".$rc["name"]."님이 \"".$ev["subject"]."\" 경진대회에 댓글을 달았습니다.";;
                $title = "<a href='http://dcamp.kr/member/".$rc["ids"]."'>".$rc["name"]."</a>님이 \"<a href='http://dcamp.kr/competition/views/".$ev["id"]."'>".$ev["subject"]."</a>\" 경진대회에 댓글을 달았습니다.";
                $url = "/competition/views/".$ev["id"]."#comment";
                $cid = $ev["user_id"];
            }
            else if ($_REQUEST["p_type"] == 6) { // blog
                $ev = $this->Content->get($_REQUEST["p_id"]);
                $m = "<a href='/member/".$rc["ids"]."'>".$rc["name"]."</a>님이 \"<a href='/contents/views/".$ev["id"]."#comment'>".$ev["subject"]."</a>\" Blog에 댓글을 달았습니다.";

                $mailto = $ev["memail"];
                $subject = "[D.CAMP] ".$rc["name"]."님이 \"".$ev["subject"]."\" Blog에 댓글을 달았습니다.";;
                $title = "<a href='http://dcamp.kr/member/".$rc["ids"]."'>".$rc["name"]."</a>님이 \"<a href='http://dcamp.kr/contents/views/".$ev["id"]."'>".$ev["subject"]."</a>\" Blog에 댓글을 달았습니다.";
                $url = "/contents/views/".$ev["id"]."#comment";
                $cid = $ev["mid"];
            }
            else if ($_REQUEST["p_type"] == 4) { // recruit
                $ev = $this->Recruit->get($_REQUEST["p_id"]);
                $m = "<a href='/member/".$rc["ids"]."'>".$rc["name"]."</a>님이 \"<a href='/recruit/views/".$ev["id"]."#comment'>".$ev["title"]."</a>\" 채용정보에 댓글을 달았습니다.";

                $mailto = $ev["memail"];
                $subject = "[D.CAMP] ".$rc["name"]."님이 \"".$ev["title"]."\" 채용정보에 댓글을 달았습니다.";;
                $title = "<a href='http://dcamp.kr/member/".$rc["ids"]."'>".$rc["name"]."</a>님이 \"<a href='http://dcamp.kr/recruit/views/".$ev["id"]."'>".$ev["title"]."</a>\" 채용정보에 댓글을 달았습니다.";
                $url = "/recruit/views/".$ev["id"]."#comment";
                $cid = $ev["mid"];
            }

            // noti
            $arr1["com_type"] = 1;
            $arr1["com_id"] = $cid;
            $arr1["act_type"] = 1;
            $arr1["act_id"] = $rc["id"];
            $arr1["msg"] = $m;
            $this->Activity->add($arr1);
            
            // maill
            $m = new TF_mailer($this->settings);
            $m->mailto = $mailto;
            $m->subject = $subject;
            $m->tpl_name = "timeline_act";
            $m->assigns["title"] = $title;
            $m->assigns["url"] = $url;
            $m->assigns["rc"] = $rc;
            $m->assigns["content"] = $_REQUEST["contents"];
            $m->assigns["main_service_url"] = $this->globals->my_host;
            $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
            $m->send(); 
        }


        $this->tpl_name = "";
        echo json_encode($result);
    }
    
    public function get_timeline_cont($_type, $_pid)
    {
        $res = $this->Board->list_($_type, $_pid, '', '');
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            $res[$i]["comm"] = $this->Board->get_comment($_type, $res[$i]["id"]);
        }
        $this->assigns["type"] = $_type;
        $this->assigns["pid"] = $_pid;
        $this->assigns["res"] = $res;
        $this->assigns["s"] = $_SESSION["s"];
    }
   
    public function add_timeline_comm()
    {
        $id = $this->Board->add($_REQUEST);
        $res = $this->Board->get_detail($_REQUEST["parent"]);
        $url = $res["bid"];

        //activity
        $wr = $this->Members->get($_SESSION["s"]["id"]);
        if ($_REQUEST["p_type"] == 2) {
            $m = "<a href='/startup/".$res["p_id"]."'>".$res["name"]."</a>님의 글에 <a href='/member/".$wr["ids"]."'>".$wr["name"]."</a>님이 <a href='/timeline/".$url."'>댓글</a>을 달았습니다.";
        }
        else {    
            $m = "<a href='/member/".$res["ids"]."'>".$res["name"]."</a>님의 글에 <a href='/member/".$wr["ids"]."'>".$wr["name"]."</a>님이 <a href='/timeline/".$url."'>댓글</a>을 달았습니다.";
        }

        $arr["com_type"] = 1;
        $arr["com_id"] = $res["user_id"];
        $arr["act_type"] = 1;
        $arr["act_id"] = $wr["id"];
        $arr["msg"] = $m;
        $this->Activity->add($arr);

        if ($res["email_rec"] && $res["user_id"] != $wr["id"]) {
            $m = new TF_mailer($this->settings);
            $m->mailto = $res["email"];
            $m->subject = "[D.CAMP] ".$res["name"]."님의 글에 ".$wr["name"]."님이 댓글을 달았습니다.";
            $m->tpl_name = "timeline_com";
            $m->assigns["wr"] = $wr;
            $m->assigns["rc"] = $rc;
            $m->assigns["res"] = $res;
            $m->assigns["com"] = $this->Board->get_comment('', $res["id"]);
            $m->assigns["url"] = $url;
            $m->assigns["main_service_url"] = $this->globals->my_host;
            $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
            $m->send();

            // reply mailling
            $re = $this->Board->get_comment_user($_REQUEST["p_type"], $_REQUEST["parent"]);
            for ($r=0; $r<sizeof($re); $r++) {
                if ($re[$r]["user_id"] != $res["user_id"] && $re[$r]["user_id"] != $_REQUEST["user_id"])  {
                    $m = new TF_mailer($this->settings);
                    $m->mailto = $re[$r]["email"];
                    $m->subject = "[D.CAMP] ".$res["name"]."님의 글에 ".$wr["name"]."님이 댓글을 달았습니다.";
                    $m->tpl_name = "timeline_com";
                    $m->assigns["wr"] = $wr;
                    $m->assigns["rc"] = $rc;
                    $m->assigns["res"] = $res;
                    $m->assigns["com"] = $this->Board->get_comment('', $res["id"]);
                    $m->assigns["url"] = $url;
                    $m->assigns["main_service_url"] = $this->globals->my_host;
                    $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                    $m->send();
                }
            }
        }

        $this->assigns["res"] = $this->Board->get_detail($id);
    }

    public function add_timeline_comm_p()
    {
        $_REQUEST["user_id"] = $_SESSION["s"]["id"];
        $id = $this->Board->add($_REQUEST);
        $res = $this->Board->get_detail($_REQUEST["parent"]);
        $url = $res["bid"];

        //activity
        if ($_REQUEST["p_type"] != 3) {
            $wr = $this->Members->get($_SESSION["s"]["id"]);
            if ($_REQUEST["p_type"] == 1) {    
                $m = "<a href='/member/".$res["ids"]."'>".$res["name"]."</a>님의 글에 <a href='/member/".$wr["ids"]."'>".$wr["name"]."</a>님이 <a href='/timeline/".$url."'>댓글</a>을 달았습니다.";
            }
            else if ($_REQUEST["p_type"] == 2) {
                $m = "<a href='/startup/".$res["p_id"]."'>".$res["name"]."</a>님의 글에 <a href='/member/".$wr["ids"]."'>".$wr["name"]."</a>님이 <a href='/timeline/".$url."'>댓글</a>을 달았습니다.";
            }

            $arr["com_type"] = 1;
            $arr["com_id"] = $res["user_id"];
            $arr["act_type"] = 1;
            $arr["act_id"] = $wr["id"];
            $arr["msg"] = $m;
            $this->Activity->add($arr);

            if ($res["email_rec"] && $res["user_id"] != $wr["id"]) {
                $m = new TF_mailer($this->settings);
                $m->mailto = $res["email"];
                $m->subject = "[D.CAMP] ".$res["name"]."님의 글에 ".$wr["name"]."님이 댓글을 달았습니다.";
                $m->tpl_name = "timeline_com";
                $m->assigns["wr"] = $wr;
                $m->assigns["res"] = $res;
                $m->assigns["url"] = $url;
                $m->assigns["com"] = $this->Board->get_comment('', $res["id"]);
                $m->assigns["main_service_url"] = $this->globals->my_host;
                $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                $m->send();

                // reply mailling
                $re = $this->Board->get_comment_user($_REQUEST["p_type"], $_REQUEST["parent"]);
                for ($r=0; $r<sizeof($re); $r++) {
                    if ($re[$r]["user_id"] != $res["user_id"] && $re[$r]["user_id"] != $_REQUEST["user_id"])  {
                        $m = new TF_mailer($this->settings);
                        $m->mailto = $re[$r]["email"];
                        $m->subject = "[D.CAMP] ".$res["name"]."님의 글에 ".$wr["name"]."님이 댓글을 달았습니다.";
                        $m->tpl_name = "timeline_com";
                        $m->assigns["wr"] = $wr;
                        $m->assigns["rc"] = $rc;
                        $m->assigns["res"] = $res;
                        $m->assigns["url"] = $url;
                        $m->assigns["com"] = $this->Board->get_comment('', $res["id"]);
                        $m->assigns["main_service_url"] = $this->globals->my_host;
                        $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                        $m->send();
                    }
                }
            }
        }

        $this->assigns["res"] = $this->Board->get_detail($id);
        if ($_REQUEST["p_type"] == 2 && $_REQUEST["opt"] == 1) {
            $e = $this->Startup_member->get_first($_REQUEST["p_id"], $_SESSION["s"]["id"]);
            if ($e) $this->assigns["st"] = $this->Startup->get($_REQUEST["p_id"]);
        }
             
    }

    public function add_timeline_comm2()
    {
        $id = $this->Board->add($_REQUEST);
        $res = $this->Board->get_detail($_REQUEST["parent"]);
        $url = $res["bid"];

        //activity
        $wr = $this->Members->get($_SESSION["s"]["id"]);
        if ($_REQUEST["p_type"] == 1) {    
            $m = "<a href='/member/".$res["ids"]."'>".$res["name"]."</a>님의 글에 <a href='/member/".$wr["ids"]."'>".$wr["name"]."</a>님이 <a href='/timeline/".$url."'>댓글</a>을 달았습니다.";
        }
        else if ($_REQUEST["p_type"] == 2) {
            $m = "<a href='/startup/".$res["p_id"]."'>".$res["name"]."</a>님의 글에 <a href='/member/".$wr["ids"]."'>".$wr["name"]."</a>님이 <a href='/timeline/".$url."'>댓글</a>을 달았습니다.";
        }

        $arr["com_type"] = 1;
        $arr["com_id"] = $res["user_id"];
        $arr["act_type"] = 1;
        $arr["act_id"] = $wr["id"];
        $arr["msg"] = $m;
        $this->Activity->add($arr);

        if ($res["email_rec"] && $res["user_id"] != $wr["id"]) {
            $m = new TF_mailer($this->settings);
            $m->mailto = $res["email"];
            $m->subject = "[D.CAMP] ".$res["name"]."님의 글에 ".$wr["name"]."님이 댓글을 달았습니다.";
            $m->tpl_name = "timeline_com";
            $m->assigns["wr"] = $wr;
            $m->assigns["rc"] = $rc;
            $m->assigns["res"] = $res;
            $m->assigns["com"] = $this->Board->get_comment('', $res["id"]);
            $m->assigns["main_service_url"] = $this->globals->my_host;
            $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
            $m->send();

            // reply mailling
            $re = $this->Board->get_comment_user($_REQUEST["p_type"], $_REQUEST["parent"]);
            for ($r=0; $r<sizeof($re); $r++) {
                if ($re[$r]["user_id"] != $res["user_id"] && $re[$r]["user_id"] != $_REQUEST["user_id"])  {
                    $m = new TF_mailer($this->settings);
                    $m->mailto = $re[$r]["email"];
                    $m->subject = "[D.CAMP] ".$res["name"]."님의 글에 ".$wr["name"]."님이 댓글을 달았습니다.";
                    $m->tpl_name = "timeline_com";
                    $m->assigns["wr"] = $wr;
                    $m->assigns["rc"] = $rc;
                    $m->assigns["res"] = $res;
                    $m->assigns["com"] = $this->Board->get_comment('', $res["id"]);
                    $m->assigns["main_service_url"] = $this->globals->my_host;
                    $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                    $m->send();
                }
            }
        }

        $this->assigns["res"] = $this->Board->get_detail($id);
    }
    
    public function del_com($_id, $_dep = '')
    {
        $this->tpl_name = "";
        $res = $this->Board->get($_id);

        if ($res["user_id"] == $_SESSION["s"]["id"]) {
            if ($res["image"]) unlink(substr($res["image"], 1));
            $this->Board->del_com($_id, $_dep);
            if ($res["depth"]) {
                $cnt = $this->Board->cnt("parent = ".$res["parent"]);
                echo $cnt;
            }
        }
        else {
            echo "error";
        }
    }
    
    public function get_current_company($_id)
    {
        $this->assigns["s_m"] = $this->Startup_member->get_list_by_user($_id);
    }

    public function get_search_startup()
    {
        if ($_REQUEST["data"]) {
            $res = $this->Startup->get_search($_REQUEST["data"]);
            $this->assigns["key"] = $_REQUEST["data"];
            $this->assigns["res"] = $res;
        }
        $this->assigns["user_id"] = $_SESSION["user_id"];
    }
    
    public function get_search_startup_in()
    {
        if ($_REQUEST["data"]) {
            $res = $this->Startup->get_search($_REQUEST["data"]);
            $this->assigns["res"] = $res;
        }
        $this->assigns["user_id"] = $_SESSION["user_id"];
    }
    
    public function get_search_startup2($_type = 1, $is_diable_select = 0)
    {
        if ($_REQUEST["data"]) {
            $res = $this->Startup->get_search($_REQUEST["data"], $_type);
            $this->assigns["res"] = $res;
            $this->assigns["key"] = $_REQUEST["data"];
        }
        $this->assigns["stype"] = $_type;
        $this->assigns["is_diable_select"] = $is_diable_select;
        $this->assigns["form"] = $_REQUEST["form"];
        $this->assigns["user_id"] = $_SESSION["user_id"];
    }
    
    public function get_search_startup_in2($_type = 1, $is_diable_select = 0)
    {
        if ($_REQUEST["data"]) {
            $res = $this->Startup->get_search($_REQUEST["data"], $_type);
            $this->assigns["res"] = $res;
        }
         $this->assigns["stype"] = $_type;
        $this->assigns["is_diable_select"] = $is_diable_select;
        $this->assigns["user_id"] = $_SESSION["user_id"];
        $this->assigns["form"] = $_REQUEST["form"];
    }
    
    public function get_search_company()
    {
        if ($_REQUEST["data"]) {
            $res = $this->Startup->get_search($_REQUEST["data"]);
            $this->assigns["key"] = $_REQUEST["data"];
            $this->assigns["res"] = $res;
        }
        $this->assigns["v"] = $_REQUEST["v"];
    }
    
    public function get_search_company_in()
    {
        if ($_REQUEST["data"]) {
            $res = $this->Startup->get_search($_REQUEST["data"]);
            $this->assigns["res"] = $res;
        }
        $this->assigns["v"] = $_REQUEST["v"];
    }
    
    public function get_search_investment()
    {
        if ($_REQUEST["data"]) {
            $res = $this->Startup->get_search($_REQUEST["data"], 2);
            $this->assigns["key"] = $_REQUEST["data"];
            $this->assigns["res"] = $res;
        }
        $this->assigns["user_id"] = $_SESSION["user_id"];
    }
    
    public function get_search_investment_in()
    {
        if ($_REQUEST["data"]) {
            $res = $this->Startup->get_search($_REQUEST["data"], 2);
            $this->assigns["res"] = $res;
        }
        $this->assigns["user_id"] = $_SESSION["user_id"];
    }
    
    public function get_search_member()
    {
        if ($_REQUEST["data"]) {
            $res = $this->Members->get_search($_REQUEST["data"]);
            $this->assigns["key"] = $_REQUEST["data"];
            $this->assigns["res"] = $res;
        }
        $this->assigns["v"] = $_REQUEST["v"];
    }
    
    public function get_search_member_in()
    {
        if ($_REQUEST["data"]) {
            $res = $this->Members->get_search($_REQUEST["data"]);
            $this->assigns["res"] = $res;
        }
        $this->assigns["v"] = $_REQUEST["v"];
    }
    
    public function find_id()
    {
        $this->assigns["res"] = $this->Members->find_id_by_name($_REQUEST);
    }
    
    public function find_pwd()
    {

        $res = $this->Members->find_id($_REQUEST);
        if ($res) {
            $new_pw = make_code();
            $this->Members->edit_pwd_by_mail($res["id"],$new_pw);

            $m = new TF_mailer($this->settings);
            $m->mailto = $res["email"];
            $m->subject = "[D.CAMP] 비밀번호 확인 메일입니다.";
            $m->tpl_name = "pw_renew";
            $m->assigns["userid"] = $res["ids"];
            $m->assigns["new_pw"] = $new_pw;
            $m->assigns["main_service_url"] = $this->globals->my_host;
            $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
            $m->send();
            
        }
        $this->assigns["res"] = $res;
    }
    
    public function member_edit_pwd()
    {
        $_REQUEST["id"] = $_SESSION["s"]["id"];
        $result["res"] = $this->Members->edit_pwd($_REQUEST);
        $this->tpl_name = "";
        echo json_encode($result);
    }
    
    public function event_apply()
    {
        if ($_REQUEST["enroll"] == 1 && $_REQUEST["enroll_type"] == 1 && ($_REQUEST["cnt"] == 0 || $_REQUEST["cnt"] > $_REQUEST["rcnt"])) {
            $_REQUEST["state"] = 1;
        } else {
            $_REQUEST["state"] = 0;
        }
        
        $result["id"] = $this->Event_reserve->add($_REQUEST);

        add_activity(1, $_REQUEST["user_id"], 1, $_REQUEST["user_id"], $_REQUEST["state"], "", Activity_model::A_TYPE_EVENT, $_REQUEST["event_id"]);
        
        $e = $this->Event->get($_REQUEST["event_id"]);
        if ($e["enroll_type"] == 1) {
            $e_cnt = $this->Event_reserve->cnt("event_id = ".$_REQUEST["event_id"]);
            if ($e["cnt"] > $e_cnt) {
                
                $arr["act_type"] = Activity_model::C_TYPE_MEMBER;
                $arr["act_id"] = $_REQUEST["user_id"];
                $arr["target_type"] = Activity_model::A_TYPE_EVENT;
                $arr["target_id"] = $_REQUEST["event_id"];
                $arr["act_result"] = 1;
                $this->Activity->edit($arr);
                
                $ev = $this->Event->get_detail($_REQUEST["event_id"]);
                $u = $this->Members->get($_REQUEST["user_id"]);
                $m = new TF_mailer($this->settings);
                $m->mailto = $u["email"];
                $m->subject = "[D.CAMP] <".$ev["title"]."> 참가 신청이 승인되었습니다.";
                $m->tpl_name = "event_apply";
                $m->assigns["res"] = $ev;
                $m->assigns["main_service_url"] = $this->globals->my_host;
                $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                $m->send();
            }
        }
        
        $this->tpl_name = "";
        echo json_encode($result);
    }
    
    public function more_notice($_type, $_page)
    {
        $_pagesize = 10;
        $this->assigns["res"] = $this->Notice->list_($_page, $_pagesize, $_type);
        
        if ($_pagesize == sizeof($this->assigns["res"])) {
            $this->assigns["more"] = TRUE;
            $this->assigns["n_page"] = $_page+1;
        }
    }
    
    public function more_news($_page)
    {
        $pagesize = 10;
        $res = $this->Board->list_news($_page, $pagesize, 'is_hidden = 0');
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            $res[$i]["comm"] = $this->Board->get_comment('', $res[$i]["id"]);
            if ($res[$i]["p_type"] == 2) {
                $s = $this->Startup->get($res[$i]["p_id"]);
                $res[$i]["picture"] = $s["logo"];
                $res[$i]["name"] = $s["name"];
            }
        }
        $this->assigns["res"] = $res;
        if ($pagesize == sizeof($this->assigns["res"])) {
            $this->assigns["more"] = TRUE;
            $this->assigns["n_page"] = $_page+1;
        }
    }

    public function more_press($_page)
    {
        $pagesize = 10;
        $res = $this->Board->list_press($_page, $pagesize, 'is_hidden = 0');
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            $res[$i]["comm"] = $this->Board->get_comment('', $res[$i]["id"]);
        }
        $this->assigns["res"] = $res;
        if ($pagesize == sizeof($this->assigns["res"])) {
            $this->assigns["more"] = TRUE;
            $this->assigns["n_page"] = $_page+1;
        }
    }

    public function more_press2($_page)
    {
        $pagesize = 10;
        $res = $this->Board->list_press($_page, $pagesize, 'is_hidden = 0');
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            //$res[$i]["contents"] = trans_url($res[$i]['contents'], false, "<small>/ 2015.10.05</small>");
            $html = str_get_html($res[$i]["sub"]);
            if($res[$i]["sub"] && count($html->find('a[class=title]')) > 0){
                foreach($html->find('a[class=title]') as $element){

                    ob_start();
                    echo '<a href="'.$element->href.'">'.$element->innertext.' <small>/ '.$res[$i]['date_created'].'</small></a>';
                    $res[$i]["sub"] = ob_get_contents();
                    ob_end_clean();
                }
            }
        }
        $this->assigns["res"] = $res;
        if ($pagesize == sizeof($this->assigns["res"])) {
            $this->assigns["more"] = TRUE;
            $this->assigns["n_page"] = $_page+1;
        }
    }
    
    public function edit_startup_member_state($_type, $_id, $_user = '')
    {
        $result = null;
        $this->Startup_member->edit_state($_id, $_type);
        $this->tpl_name = "";
        if ($_type == 1) {
            $user_i = $this->Members->get($_user);
            $result["html"] = '<li> <a href="/member/'.$user_i['ids'].'"> <img style="width:24px;" src="'.$user_i['picture'].'" class="img-circle"> '.$user_i['name'].' </a> <small>'.$user_i['company_role'].'</small></li>';
            
            $s = $this->Startup_member->get_detail($_id);
            $m = "<a href='/startup/".$s["sid"]."'>".$s["sname"]."</a> 구성원으로 승인되었습니다. 이제 정보를 수정할 수 있습니다.";
            $arr["com_type"] = 1;
            $arr["com_id"] = $_user;
            $arr["act_type"] = 2;
            $arr["act_id"] = $s["sid"];
            $arr["msg"] = $m;
            $this->Activity->add($arr);
        }
        echo json_encode($user_i["ids"]);
    }

    public function delete_startup_member_state($_id, $_user)
    {
        $result = null;
        $s = $this->Startup_member->get_detail($_id);
        $this->Startup_member->del_by_user_st($_id);
        $this->tpl_name = "";

        $user_i = $this->Members->get($_user);

        $m = new TF_mailer($this->settings);
        $m->mailto = $user_i["email"];
        $m->subject = $s["mname"]."님, [D.CAMP] '".$s["sname"]."'의 구성원에서 삭제되셨습니다.";
        $m->tpl_name = "startup_member_delete";
        $m->assigns["res"] = $s;
        $m->assigns["main_service_url"] = $this->globals->my_host;
        $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
        $m->send();

        echo json_encode(1);
    }
    
    public function more_act($_type, $_id, $_page, $_target_type = '')
    {
        $pagesize = 10;
        if ($_target_type) 
            $res = $this->Activity->get_by_com($_type, $_id, $_page, $pagesize, '', 'target_type = '.Activity_model::E_TYPE_REFERENCE);
        else
            $res = $this->Activity->get_by_com($_type, $_id, $_page, $pagesize);
        for ($i=0; $i<sizeof($res); $i++) {
            if ($res[$i]["act_type"] == Activity_model::A_TYPE_EVENT) {
                $res[$i]["data"] = $this->Event->get($res[$i]["act_id"]);
            }
            else if ($res[$i]["act_type"] == Activity_model::A_TYPE_SPACE) {
                $res[$i]["data"] = $this->Space_reserve->get_detail($res[$i]["act_id"]);
            }
            if ($res[$i]["msg"]) {
                if ($res[$i]["act_type"] == 1) {
                    $ow = $this->Members->get($res[$i]["act_id"]);
                    $res[$i]["ow_ids"] = $ow["ids"];
                    $res[$i]["ow_picture"] = $ow["picture"];
                    $res[$i]["ow_name"] = $ow["name"];
                }
                else if ($res[$i]["act_type"] == 2){
                    $ow = $this->Startup->get($res[$i]["act_id"]);
                    $res[$i]["ow_id"] = $ow["id"];
                    $res[$i]["ow_logo"] = $ow["logo"];
                    $res[$i]["ow_name"] = $ow["name"];
                }
            }
        }
        $this->assigns["res"] = $res;
    }
    
    public function check_space()
    {
        $this->tpl_name = "";
        $res = $this->Space->get($_REQUEST["space_id"]);
        
        $w = date("w", mktime(0,0,0, substr($_REQUEST["date"], 5, 2), substr($_REQUEST["date"], 8, 2), substr($_REQUEST["date"], 0, 4)));
        
        if ($w == 1) $w = 1;
        else if ($w == 2) $w = 2;
        else if ($w == 3) $w = 4;
        else if ($w == 4) $w = 8;
        else if ($w == 5) $w = 16;
        else if ($w == 6) $w = 32;
        else if ($w == 0) $w = 64;
//        echo $w;
        $error = FALSE;
        $msg = "해당 공유공간 사용가능 ";
        if ($w != ($res["days"] & $w)) {
            $msg = $msg."요일은 ";
            if (1 == ($res["days"] & 1)) $msg = $msg . "월요일, ";
            if (2 == ($res["days"] & 2)) $msg = $msg . "화요일, ";
            if (4 == ($res["days"] & 4)) $msg = $msg . "수요일, ";
            if (8 == ($res["days"] & 8)) $msg = $msg . "목요일, ";
            if (16 == ($res["days"] & 16)) $msg = $msg . "금요일, ";
            if (32 == ($res["days"] & 32)) $msg = $msg . "토요일, ";
            if (64 == ($res["days"] & 64)) $msg = $msg . "일요일, ";
            $error = TRUE;
        }
        
        if ($res["start"] > $_REQUEST["start"] || $res["end"] < $_REQUEST["end"]) {
            $msg = $msg."시간은 ".$res["start"]."~".$res["end"]."입니다.";
            $error = TRUE;
        }
        else if ($error) {
            $msg = substr($msg, 0, -2)." 입니다.";
        }
        
        if (!$error) {
            $msg = '';
            $check_s = $this->Space_reserve->get_by_date_space($_REQUEST["date"], $_REQUEST["space_id"], $_REQUEST["id"]);
            if (sizeof($check_s) > 0) {
//                echo $_REQUEST["start"]."/".$_REQUEST["end"].'-';
                $r_start = str_replace(":", "", $_REQUEST["start"]);
                $r_end = str_replace(":", "", $_REQUEST["end"]);
                for ($s=0; $s<sizeof($check_s); $s++) {
                    $c_start = str_replace(":", "", $check_s[$s]["start"]);
                    $c_end = str_replace(":", "", $check_s[$s]["end"]);
//                    echo $check_s[$s]["start"]."/".$check_s[$s]["end"].'';
//                    echo "*************";
                    
                    if ($r_start < $c_start) {
//                        echo "|=|";
                        if ($r_end <= $c_start) {
//                            echo 202;
                        }
                        else {
                            $error = TRUE;
                            $msg = "중복된 공간공유 신청입니다.";
//                            echo 11;
                            break;
                        }
                    }
                    else {
//                        echo "|-|";echo "[".$r_end."/".$c_start."]";
                        if ($r_start >= $c_end) {
//                            echo 303; 
                        }
                        else {
                            $error = TRUE;
                            $msg = "중복된 공간공유 신청입니다.";
//                            echo 44;
                            break;
                            
                        }
                    }
                }
                
            }
            
            // permission7 check
            if (($_SESSION["s"]["per"] & $this->settings->permission7) == $this->settings->permission7) {
                $tmp = $this->Members->get_etc("_key = 'permission7' and user_id = ".$_SESSION["s"]["id"]);
                $list = $this->Space_reserve->list_(1, 1000, 'user_id = '.$_SESSION["s"]["id"].' and date > "'.$tmp["_value"].'" and sr.date_created like "'.date("Y-m").'%" and sr.state = 1');
                $len_list = sizeof($list);
                if ($len_list) {
                    $rest = 0;
                    for ($t=0; $t<$len_list; $t++) {
                        $rest = $rest + timeDiff($list[$t]["start"], $list[$t]["end"]);
                    }
                    
                    if (10*60 < $rest + timeDiff($_REQUEST["start"], $_REQUEST["end"])) {
                        $msg = "이달의 공간공유 예약 시간이 10시간을 초과하였습니다. <br />해당 신청서부터는 관리자의 승인이 필요합니다.";
                    }
                }
            }
        }
        
        $result["error"] = $error;
        $result["msg"] = $msg;
        echo json_encode($result);
    }
    
    public function startup_member_apply() 
    {
        $this->tpl_name = '';
        $this->Startup_member->add($_REQUEST["startup_id"], $_SESSION["s"]["id"], ""
                    , $_REQUEST["role"], $_REQUEST["start"], "", $_REQUEST["is_ing"]
                    , $_REQUEST["status"]);
        
        $stu = $this->Startup->get($_REQUEST["startup_id"]);
        $mem = $mem = $this->Members->get($_SESSION["s"]["id"]);
        $m = "<a href='/member/".$mem["ids"]."'>".$mem["name"]."</a>님이 <a href='/startup/".$stu["id"]."'>".$stu["name"]."</a>에 구성원 신청을 하였습니다.";
        $st = $this->Startup_member->get_by_startup($_REQUEST["startup_id"], '', 'sm.status = 1 and sm.is_ing = 1');
        $len_st = sizeof($st);
        for ($i=0; $i<$len_st; $i++) {
            $arr["com_type"] = 1;
            $arr["com_id"] = $st[$i]["mid"];
            $arr["act_type"] = 1;
            $arr["act_id"] = $mem["id"];
            $arr["msg"] = $m;
            $this->Activity->add($arr);
        }
        $arr2["com_type"] = 2;
        $arr2["com_id"] = $_REQUEST["startup_id"];
        $arr2["act_type"] = 1;
        $arr2["act_id"] = $mem["id"];
        $arr2["msg"] = $m;
        $this->Activity->add($arr2);

        $result["data"] = '<li><a href="/member/'.$_SESSION["s"]["ids"].'" class="prf-memberStading"> <img src="'.$_SESSION["s"]["picture"].'" class="img-circle" alt="'.$_SESSION["s"]["name"].'"></a></li>';
        echo json_encode($result);
    }
    
    public function startup_staff_apply() 
    {
        $this->tpl_name = '';
        $e_user = $this->Members->get_by_email($_REQUEST["email"]);
        
        $s = $this->Startup->get($_REQUEST["startup_id"]);
        if ($e_user) {
            
            if ($this->Startup_member->check_by_user_st($e_user["id"], $s["id"])) {
                $result["msg"] = "이미 구성원이거나, 구성원 신청 상태입니다.";
                echo json_encode($result);
                exit(1);
            }
            
            $this->Startup_member->add($_REQUEST["startup_id"], $e_user["id"], ""
                    , "", "", "", 1, 1);

            $m = "<a href='/startup/".$s["id"]."'>".$s["name"]."</a> 구성원으로 초대되었습니다. 기업 정보를 수정할 수 있습니다.";
            $arr["com_type"] = 1;
            $arr["com_id"] = $e_user["id"];
            $arr["act_type"] = 2;
            $arr["act_id"] = $_REQUEST["startup_id"];
            $arr["msg"] = $m;
            $this->Activity->add($arr);
            
            if ($e_user["email_rec"]) {
                $m = new TF_mailer($this->settings);
                $m->mailto = $e_user["email"];
                $m->subject = $_REQUEST["name"]."님, [D.CAMP] '".$s["name"]."'의 구성원으로 초대되었습니다.";
                $m->tpl_name = "staff";
                $m->assigns["res"] = $s;
                $m->assigns["main_service_url"] = $this->globals->my_host;
                $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                $m->send();
            }
        }
        else {
            
            if ($this->Startup_member->check_by_user_st_req($_REQUEST["email"], $s["id"])) {
                $result["msg"] = "이미 구성원이거나, 구성원 신청 상태입니다.";
                echo json_encode($result);
                exit(1);
            }
            
            $_u = $this->Members->get($_REQUEST["user_id"]);
            $this->Startup_member->add_req($_REQUEST["startup_id"], $_REQUEST["user_id"]
                    , $_REQUEST["name"], $_REQUEST["email"], $e_user["id"]);
            
            $m = new TF_mailer($this->settings);
            $m->mailto = $_REQUEST["email"];
            $m->subject = $_REQUEST["name"]."님, [D.CAMP] '".$s["name"]."'의 구성원으로 초대되었습니다.";
            $m->tpl_name = "staff";
            $m->assigns["res"] = $s;
            $m->assigns["main_service_url"] = $this->globals->my_host;
            $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
            $m->send();
        }
        
        if ($e_user)
            $result["data"] = '<li><a href="/member/'.$e_user["ids"].'"> <img src="'.$e_user["picture"].'" class="img-circle"> '.$e_user["name"].'</a></li>';
        else 
            $result["data"] = '<li><img src="/img/default-img-member.png" class="img-circle"> '.$_REQUEST["name"].' </li>';
        echo json_encode($result);
    }
    
    public function add_startup()
    {
        $this->tpl_name = '';
        $_id = $this->Startup->add($_REQUEST);
        
        if($_REQUEST["id"]) {
            $this->Startup_bussiness->delete_by_user($_REQUEST["id"]);
            $this->Startup_tech->delete_by_user($_REQUEST["id"]);
        }
            
        if ($_REQUEST["bussiness"]) {
            $bussiness = explode(",", $_REQUEST["bussiness"]);
            $len_bussiness = sizeof($bussiness);
            for($i=0; $i<$len_bussiness; $i++) {
                if (trim($bussiness[$i])) {
                    $val = $this->Code->get_value(trim($bussiness[$i]), 'jobs');
                    $this->Startup_bussiness->add_c($_id, $val['id']);
                }
            }
        }
        if ($_REQUEST["tech"]) {
            $tech = explode(",", $_REQUEST["tech"]);
            $len_tech = sizeof($tech);
            for($j=0; $j<$len_tech; $j++) {
                if (trim($tech[$j])) {
                    $val = $this->Code->get_value(trim($tech[$j]), 'jobs');
                    $this->Startup_tech->add_c($_id, $val['id']);
                }
            }
        }

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
        
        echo json_encode($result);
    }
    
    public function add_follow()
    {
        $this->tpl_name = "";
        if ($_REQUEST['del']) {
            $this->Follow->del($_REQUEST);
        }
        else {
            $id = $this->Follow->add($_REQUEST);
            if ($_REQUEST["type"] == 1) {
                $fli = $this->Members->get($_REQUEST["following"]);
                $url = '/member/'.$fli["ids"];
            }
            if ($_REQUEST["type"] == 2) {
                $fli = $this->Startup->get($_REQUEST["following"]);
                $url = '/startup/'.$fli["id"];
            }
            $flw = $this->Members->get($_REQUEST["follower"]);
            $m = "<a href='/member/".$flw["ids"]."'>".$flw["name"]."</a>님이 <a href='".$url."'>".$fli["name"]."</a>님을 Follow 합니다.";
            // you
            $arr["com_type"] = $_REQUEST["type"];
            $arr["com_id"] = $_REQUEST["following"];
            $arr["act_type"] = 1;
            $arr["act_id"] = $_REQUEST["follower"];
            $arr["msg"] = $m;
            $this->Activity->add($arr);
            // me
            $arr2["com_type"] = 1;
            $arr2["com_id"] = $_REQUEST["follower"];
            $arr2["act_type"] = 1;
            $arr2["act_id"] = $_REQUEST["follower"];
            $arr2["msg"] = $m;
            $this->Activity->add($arr2);
            
            if ($fli["email_rec"]) {
                $m = new TF_mailer($this->settings);
                $m->mailto = $fli["email"];
                $m->subject = "[D.CAMP] '".$flw["name"]."'님이 회원님을 Follow하였습니다.";
                $m->tpl_name = "follow";
                $m->assigns["res"] = $flw;
                $m->assigns["main_service_url"] = $this->globals->my_host;
                $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                $m->send();
            }
        }

    }

    public function add_follow_p()
    {
        $this->tpl_name = "";
        if ($_REQUEST['del']) {
            $this->Follow->del($_REQUEST);
        }
        else {
            $id = $this->Follow->add($_REQUEST);
            if ($_REQUEST["type"] == 1) {
                $fli = $this->Members->get($_REQUEST["following"]);
                $url = '/member/'.$fli["ids"];
            }
            if ($_REQUEST["type"] == 2) {
                $fli = $this->Startup->get($_REQUEST["following"]);
                $url = '/startup/'.$fli["id"];
            }
            $flw = $this->Members->get($_REQUEST["follower"]);
            $m = "<a href='/member/".$flw["ids"]."'>".$flw["name"]."</a>님이 <a href='".$url."'>".$fli["name"]."</a>님을 Follow 합니다.";
            // you
            $arr["com_type"] = $_REQUEST["type"];
            $arr["com_id"] = $_REQUEST["following"];
            $arr["act_type"] = 1;
            $arr["act_id"] = $_REQUEST["follower"];
            $arr["msg"] = $m;
            $this->Activity->add($arr);
            // me
            $arr2["com_type"] = 1;
            $arr2["com_id"] = $_REQUEST["follower"];
            $arr2["act_type"] = 1;
            $arr2["act_id"] = $_REQUEST["follower"];
            $arr2["msg"] = $m;
            $this->Activity->add($arr2);
            
            if ($fli["email_rec"]) {
                $m = new TF_mailer($this->settings);
                $m->mailto = $fli["email"];
                $m->subject = "[D.CAMP] '".$flw["name"]."'님이 회원님을 Follow하였습니다.";
                $m->tpl_name = "follow";
                $m->assigns["res"] = $flw;
                $m->assigns["main_service_url"] = $this->globals->my_host;
                $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                $m->send();
            }
        }

    }
    
    public function member_add_i($_startup = '')
    {
        $this->assigns["v"] = $_REQUEST["data"];
        $this->assigns["st"] = $_startup;
    }
    
    public function member_add_s($_startup = '')
    {
        $this->assigns["v"] = $_REQUEST["data"];
        $this->assigns["st"] = $_startup;
    }
    
    public function recruit_add_job()
    {
        $this->assigns[v] = $_REQUEST["data"];
    }
    
    public function more($_page, $_c = '')
    {
        $_pagesize = 12;
        if ($_c) {
            $_REQUEST["c"] = $_c;
            $_pagesize = 30;
        }
        $res = array();
        if (!$_REQUEST["c"] || $_REQUEST["c"] == 'event') {
            $event = $this->Event->list_($_page, $_pagesize, 'e.state = 1', '', 'e.apply_end DESC');
            for ($e=0; $e<sizeof($event); $e++) {
                $html['data'] = '["event"]';
                $html['cl'] = 'col-xs-12 col-sm-4 col-md-3 item type1';
                if (dateDiff($event[$e]["apply_end"], date('y.m.d H:i'), '.') > 0) {
                    $html['html'] = '<div class="inner">'
                                    .'<a href="/event/apply/'.$event[$e]["id"].'">'
                                        .'<div class="imgbox"><img src="'.$event[$e]["picture"].'" class="img-responsive img-thumb"></div>'
                                        .'<div class="d-day">D-'.dateDiff($event[$e]["date"], date("y.m.d"), ".").'</div>'
                                        .'<div class="sort"><strong>Event</strong></div>'
                                        .'<div class="caption"><h3 class="ellipsis">'.$event[$e]["title"].'</h3><span class="date"><span class="icon-calendar"></span> '.$event[$e]["date"].'</span></div>'
                                    .'</a>'
                                .'</div>';
                }
                else {
                    $html['html'] = '<div class="inner">'
                                    .'<a href="/event/apply/'.$event[$e]["id"].'">'
                                        .'<div class="imgbox"><img src="'.$event[$e]["picture"].'" class="img-responsive img-thumb"></div>'
                                        .'<div class="sort"><strong>Event</strong></div>'
                                        .'<div class="caption"><h3 class="ellipsis"><span class="label label-default">완료</span> '.$event[$e]["title"].'</h3><span class="date"><span class="icon-calendar"></span> '.$event[$e]["date"].'</span></div>'
                                    .'</a>'
                                .'</div>';
                }
                
                array_push($res, $html);
            }
        }
        
        if (!$_REQUEST["c"] || $_REQUEST["c"] == 'notice') {
            $news = $this->Notice->list_($_page, $_pagesize, '', 1,'visible = 1', 'n.date_edited DESC');
            for ($n=0; $n<sizeof($news); $n++) {
                $html['data'] = '["news"]';
                if ($news[$n]["main"]) {
                    if ($news[$n]['type'] == 1) $ne = 'News';
                    else $ne = 'Notice';
                    $html['cl'] = 'col-xs-12 col-sm-4 col-md-3 item type1';
                    $html['html'] = '<div class="inner">'
                                    .'<a href="/notice/views/'.$news[$n]["type"].'/'.$news[$n]["id"].'">'
                                        .'<div class="imgbox">'
                                            .'<img src="'.$news[$n]["main"].'" class="img-responsive  img-thumb" >'
                                        .'</div>'
                                        .'<div class="sort"><strong>'.$ne.'</strong></div>'
                                        .'<div class="caption"><h3 class="ellipsis">'.$news[$n]["title"].'</h3></div>'     
                                    .'</a>'               
                                .'</div>';
                } else {
                    if ($news[$n]['type'] == 1) {
                        $ne = 'News';
                        $ne_i = '/img/default-img-news.png';
                    }
                    else {
                        $ne = 'Notice';
                        $ne_i = '/img/default-img-notice.png';
                    }
                    $html['cl'] = 'col-xs-12 col-sm-4 col-md-3 item type2';
                    $html['html'] = '<div class="inner">'
                                    .'<a href="/notice/views/'.$news[$n]["type"].'/'.$news[$n]["id"].'">'
                                        .'<div class="imgbox">'
                                            .'<img src="'.$ne_i.'" class="img-responsive">'
                                        .'</div>'
                                        .'<div class="sort"><strong>'.$ne.'</strong></div>'
                                        .'<h3 class="ellipsis"style="word-wrap: break-word; white-space: normal;">'.$news[$n]["title"].'</h3>'  
                                    .'</a>'
                                .'</div>';
                }
                array_push($res, $html);
            }
        }
        if (!$_REQUEST["c"] || $_REQUEST["c"] == 'recruit') {
            $rec = $this->Recruit->list_s_($_page, $_pagesize, '', 'r.date_edited DESC');
            for ($r=0; $r<sizeof($rec); $r++) {
                if (!$rec[$r]["logo"]) $rec[$r]["logo"] = '/img/default-img-company.png';
                $html['data'] = '["recruit"]';
                $html['cl'] = 'col-xs-12 col-sm-4 col-md-3 item type2';
                $html['html'] = '<div class="inner">'
                                .'<a href="/recruit/views/'.$rec[$r]["rid"].'">'
                                    .'<div class="imgbox"><img src="'.$rec[$r]["logo"].'" class="img-responsive"></div>'
                                    .'<div class="sort"><strong>Recruit</strong></div>'
                                    .'<h3 class="ellipsis">'.$rec[$r]["title"].'</h3> '
                                .'</a>'
                            .'</div>';
                array_push($res, $html);
            }
        }
        
        shuffle($res);
        if (!$_REQUEST["c"] || $_REQUEST["c"] == 'startup') {
            $com_st = $this->Startup->list_($_page, $_pagesize, 'state = 1', 'date_edited DESC');
            for ($s=0; $s<sizeof($com_st); $s++) {
                if (!$com_st[$s]["logo"]) $com_st[$s]["logo"] = '/img/default-img-company.png';
                $html['data'] = '["startup"]';
                $html['cl'] = 'col-xs-12 col-sm-4 col-md-3 item type2';
                $html['html'] = '<div class="inner">'
                                .'<a href="/startup/'.$com_st[$s]["id"].'">'
                                    .'<div class="imgbox"><div><span><img src="'.$com_st[$s]["logo"].'" class="img-responsive "></span></div></div>'
                                    .'<div class="sort"><strong>Startup</strong></div>'
                                    .'<h3>'.$com_st[$s]["name"].' </h3>'
                                    .'<p class="ellipsis">'.$com_st[$s]["bio"].'</p>'
                                .'</a>'
                            .'</div>';
                array_push($res, $html);
            }
        }
        
        if (!$_REQUEST["c"] || $_REQUEST["c"] == 'people') {
            $com_m = $this->Members->list_($_page, $_pagesize, 'state = 1', 'date_edited DESC');
            for ($m=0; $m<sizeof($com_m); $m++) {
                if (!$com_m[$m]["picture"]) $com_m[$m]["picture"] = '/img/default-img-member.png';
                $html['data'] = '["people"]';
                $html['cl'] = 'col-xs-12 col-sm-4 col-md-3 item type2';
                $html['html'] = '<div class="inner">'
                                .'<a href="/member/'.$com_m[$m]["ids"].'">'
                                    .'<div class="imgbox"><div><span><img src="'.$com_m[$m]["picture"].'" class="img-responsive"></span></div></div>'
                                    .'<div class="sort"><strong>People</strong></div>'
                                    .'<h3>'.$com_m[$m]["name"].'</h3>'
                                    .'<p class="ellipsis">'.strip_tags($com_m[$m]["last_edit"]).'</p>'
                                .'</a>'
                            .'</div>';
                array_push($res, $html);
            }
        }
        
        $this->tpl_name = '';
        $result = $res; 
        echo json_encode($result);
    }

    public function check_ids($_ids) {
        $this->tpl_name = '';
        $res = $this->Members->get_by_ids($_ids);
        $result["id"] = $res["id"];
        echo json_encode($result);
    }
    
    public function check_email($_ids) {
        $this->tpl_name = '';
        $res = $this->Members->get_by_email($_ids);
        $result["id"] = $res["id"];
        echo json_encode($result);
    }
    
    public function get_add_startup() {
        
    }
    
    public function get_add_investment() {
        $this->assigns["form"] = $_REQUEST["form"];
        $this->assigns["data"] = $_REQUEST["data"];
    }
       
    public function use_cache() {
        $this->tpl_name = '';
        if ($_REQUEST["type"] && $_REQUEST["id"]) {
            setcookie($_REQUEST["type"], $_REQUEST["id"], time()+ 604800, "/");
        }
    }

    public function fetch_og()
    {
        $this->tpl_name = "";
        $url = $_REQUEST["url"];
        // $url = 'http://news.naver.com/main/read.nhn?mode=LSD&mid=sec&oid=293&aid=0000012889&sid1=001';
//        $content = file_get_contents($url);
        // $content=mb_convert_encoding(file_get_contents($url), 'HTML-ENTITIES', 'EUC-KR');
        $content=mb_convert_encoding(file_get_contents($url), 'HTML-ENTITIES', 'UTF-8');

        $dom = new DomDocument();
        @$dom->loadHTML($content);

        $xpath = new DOMXPath($dom);
        # query metatags with og prefix
        $metas = $xpath->query('//*/meta[starts-with(@property, \'og:\')]');
        
        $og = array();
        foreach($metas as $meta){
            # get property name without og: prefix
            $property = str_replace('og:', '', $meta->getAttribute('property'));
            # get content
            $content =  $meta->getAttribute('content');
            $og[$property] = $content;
        }
        echo json_encode($og);
    }

    public function del_event_apply($_id)
    {
        $this->tpl_name = '';
        $result = '';
        
        $rer = $this->Event_reserve->get($_id);
        $this->Event_reserve->delete($_id);
        echo json_encode($result);
    }

    public function del_event($_id)
    {
        $this->tpl_name = '';
        $result = '';
        $rer = $this->Event->delete($_id);
        echo json_encode($result);
    }
    
    public function del_cont($_id)
    {
        $this->tpl_name = '';
        $result = '';
        $this->Content->delete($_id);
        echo json_encode($result);
    }

    public function test()
    {
        $this->tpl_name = '';
        $user["email"] = $_REQUEST["email"];
        $user["id"] = $_REQUEST["id"];
        $mem_app = $this->Startup_member->get_by_email_req($user["email"]);
        if ($mem_app) {
            $len_mem_app = sizeof($mem_app);
            for ($m=0; $m<$len_mem_app; $m++) {
                $s = $this->Startup->get($mem_app[$m]["startup_id"]);
                $msg = "<a href='/startup/".$s["id"]."'>".$s["name"]."</a> 구성원으로 초대되었습니다. 기업 정보를 수정할 수 있습니다.";
                $arr["com_type"] = 1;
                $arr["com_id"] = $user["id"];
                $arr["act_type"] = 1;
                $arr["act_id"] = $mem_app[$m]["mid"];
                $arr["act_result"] = '';
                $arr["target_type"] = '';
                $arr["target_id"] = '';
                $arr["is_made"] = '';
                $arr["msg"] = $msg;
                $this->Activity->add($arr);
                $this->Startup_member->add($s["id"], $user["id"], ""
                    , "", "", "", 1, 1);
            }
            $this->Startup_member->edit_state_req($user["email"], 1);
        }
    }
    
    public function add_score_rate($_id = '')
    {
        if ($_id)
            $this->assigns["ress"] = $this->Competitions_score->get($_id);
    }
    
    public function edit_score()
    {
        $_REQUEST["sid"] = $this->Competitions_score->add($_REQUEST);
        $this->assigns["res"] = $_REQUEST;
    }
    
    public function delete_score_rete($_id)
    {
        $this->tpl_name = "";
        $this->Competitions_score->delete($_id);
    }
    
    public function add_comp_form()
    {
        if ($_REQUEST["title"]) {
            if ($_REQUEST["opt"]) {
                $_REQUEST["opts"] = explode(",", $_REQUEST["opt"]);
            }
            $this->assigns["ress"] = $_REQUEST;
        }
    }
    
    public function edit_comp_form()
    {
        if ($_REQUEST["type"] == 'text') {
            
        }
        else if ($_REQUEST["type"] == 'textarea') {
            
        }
        else if ($_REQUEST["type"] == 'query') {
            $j = 0;
            for ($i=1; $i<$_REQUEST["query_cnt"]+1; $i++) {
                if ($_REQUEST["option_con_".$i]) {
                    $_REQUEST["opt"][$j] = $_REQUEST["option_con_".$i];
                    $j++;
                }
            }
        }
        else if ($_REQUEST["type"] == 'file') {
            // $this->Competitions_file->debug();
            $_id = $this->Competitions_file->add($_REQUEST);
            $_REQUEST["id"] = $_id;
        }

        $this->assigns["res"] = $_REQUEST;
    }
    
    public function add_comp_form_file($_id = '')
    {
        if ($_REQUEST["title"]) {
            $this->assigns["ress"] = $_REQUEST;
        }
        $this->assigns["competition_id"] = $_id;
    }

    public function del_comp_form_file($_id)
    {
        $this->tpl_name = '';
        $this->Competitions_file->delete($_id);
    }
    
    public function save_comp_form()
    {
        $this->tpl_name = '';
        $_id = $this->Competitions->add($_REQUEST);
    }
    
    public function get_examiner($_id = '')
    {
        if ($_REQUEST["tpl"]) {
            $_page = $_REQUEST["page"];
            $pagesize = 10;
            $res = $this->Competitions_examiner->get_by_comp($_id, $_page, $pagesize);
            for ($i=0; $i<sizeof($res); $i++) {
                $c = $this->Competitions_scoring->get_score_by_comp($_id, $res[$i]["user_id"]);
                $res[$i]["end"] = sizeof($c);
            }
            $this->tpl_name = $_REQUEST["tpl"];
            $res_cnt = $this->Competitions_examiner->cnt('competition_id = '.$_id);
            $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize); 
            $this->assigns["res_cnt"] = $res_cnt;
            $this->assigns["page"] = $_page;
            $this->assigns["pagesize"] = $pagesize;
            $this->assigns["apply_cnt"] = $this->Competitions_apply->cnt("ca.status =1 and ca.competition_id = ".$_id);
        }
        else {
            $res = $this->Competitions_examiner->get_by_comp($_id);
            $len_res = sizeof($res);
            for ($i=0; $i<$len_res; $i++) {
                $res[$i]["com"] = $this->Startup_member->get_by_user($res[$i]["user_id"]);
                $res[$i]["comp"] = $this->Competitions_examiner->get_by_user($res[$i]["user_id"], '');
            }
        }
        $this->assigns["res"] = $res;
        $this->assigns["cid"] = $_id;
    }
    
    public function delete_examiner($_id)
            {
        $this->tpl_name = '';
        $this->Competitions_examiner->delete($_id);
    }
    
    public function get_examiner_pool($_page)
    {
        $pagesize = 5;
        $where = 'ce.public = 1';
        $res = $this->Competitions_examiner->list_($_page, $pagesize, $where);
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            $res[$i]["com"] = $this->Startup_member->get_by_user($res[$i]["user_id"]);
            $res[$i]["comp"] = $this->Competitions_examiner->get_by_user($res[$i]["user_id"], '');
        }
        $res_cnt = $this->Competitions_examiner->cnt($where);
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize); 
        $this->assigns["res"] = $res;
        $this->assigns["page"] = $_page;
    }
    
    public function add_examiner()
    {
        $this->tpl_name = '';
        if ($_REQUEST["competition_id"] && $_REQUEST["users"]) {
            $users = explode(",", $_REQUEST["users"]);
            $len_users = sizeof($users);
            for ($i=0; $i<$len_users; $i++) {
                if ($users[$i]) {
                    $arr["competition_id"] = $_REQUEST["competition_id"];
                    $arr["user_id"] = $users[$i];
                    $this->Competitions_examiner->add($arr);
                    
                    //mailing
                    $per = $this->Members->get($users[$i]);
                    $res = $this->Competitions->get($_REQUEST["competition_id"]);
                    $us = $this->Members->get($res["user_id"]);
                    $m = new TF_mailer($this->settings);
                    $m->mailto = $per["email"];
                    $m->subject = "[D.CAMP] ".$us["name"]."님이 경진대회 심사위원으로 초대하였습니다.";
                    $m->tpl_name = "competition_invite";
                    $m->assigns["res"] = $res;
                    $m->assigns["user"] = $us;
                    $m->assigns["main_service_url"] = $this->globals->my_host;
                    $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                    $m->send();
                }
            }
        }
    }
    
    public function get_member_list()
    {
    }
    
    public function get_member_list_q()
    {
        if ($_REQUEST["q"]) {
            $this->assigns["q"] = $_REQUEST["q"];
            $this->assigns["res"] = $this->Members->get_search($_REQUEST["q"]);
        }
    }
    
    public function invitation_email()
    {
        $this->tpl_name = '';
        if ($_REQUEST["ex_email"]) {
            $_email = explode(",", $_REQUEST["ex_email"]);
            if ($_email) {
                $len_email = sizeof($_email);
                for ($i=0; $i<$len_email; $i++) {
                    $e = rtrim(ltrim($_email[$i]));
                    $_exn = $this->Members->get_by_email($e);
                    $arr["competition_id"] = $_REQUEST["competition_id"];
                    $arr["user_id"] = $_exn["id"];
                    if (!$_exn) $arr["email"] = $e;
                    $this->Competitions_examiner->add($arr);
                    
                    // mail, activity
                    if (email_valid($e)) {
                        //mailing
                        
                        $res = $this->Competitions->get($_REQUEST["competition_id"]);
                        $us = $this->Members->get($res["user_id"]);
                        $m = new TF_mailer($this->settings);
                        $m->mailto = $e;
                        $m->subject = "[D.CAMP] ".$us["name"]."님이 경진대회 심사위원으로 초대하였습니다.";
                        $m->tpl_name = "competition_invite";
                        $m->assigns["res"] = $res;
                        $m->assigns["user"] = $us;
                        $m->assigns["main_service_url"] = $this->globals->my_host;
                        $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
                        $m->send();
                    }
                }
                
            }
        }
    }
    
    public function add_comp_apply()
    {
        $this->tpl_name = '';
        if ($_REQUEST["user_id"]) {
            if ($_FILES["file"]) {
                $_REQUEST["file"] = make_upload("/media/comp_file/", "file");
            }
            $this->Competitions_apply->add($_REQUEST);
            $_SESSION["msg"] = "경진 대회 참가 신청이 접수되었습니다.";
        }
    }
    
    public function del_competition($_id)
    {
        $this->tpl_name = '';
        $res = $this->Competitions->get($_id);
        $o = $this->Competitions_examiner->operator_check($_id, $_SESSION["s"]["id"]);
        if ($res["user_id"] == $_SESSION["s"]["id"] || $o) {
            $this->Competitions->delete($_id);
        }
    }
    
    public function change_status_competition($_id, $_st) 
    {
        $this->tpl_name = '';
        if ($_st == 1) {
            $af = $this->Competitions_form->get_by_comp($_id);
            $sf = $this->Competitions_score->get_by_comp($_id);
            if ( ( 1 > sizeof($af) ) && ( 1 > sizeof($sf) ) ) {
                echo "leak";
                exit(1);
            }
        }
        $arr["id"] = $_id;
        $arr["open"] = $_st;
        $this->Competitions->add($arr);
    }
    
    public function get_examiner_per($_id)
    {
        $res = $this->Members->get($_id);
        $res["com"] = $this->Startup_member->get_by_user($res["id"]);
        $res["comp"] = $this->Competitions_examiner->get_by_user($res["id"], '', 1);
        $this->assigns["res"] = $res;
    }
    
    public function change_status_competition_apply()
    {
        $this->tpl_name = '';
        if (array_key_exists("status", $_REQUEST)) {
            $arr["status"] = $_REQUEST["status"];
            $arr["status_des"] = $_REQUEST["status_des"];
            $arr["id"] = $_REQUEST["id"];
            $this->Competitions_apply->add($arr);

            $aly = $this->Competitions_apply->get($_REQUEST["id"]);
            $res = $this->Competitions->get($aly["competition_id"]);
            $m = new TF_mailer($this->settings);
            
            if (! $aly["email"]) $aly["email"] = $aly["f_email"];
            if (! $aly["name"]) $aly["name"] = $aly["f_name"];
            $m->mailto = $aly["email"];
            if ($_REQUEST["status"] == 1)
                $m->subject = "[D.CAMP] ".$aly["name"]."님의 경진대회 참가신청이 접수되었습니다.";
            if ($_REQUEST["status"] == 2) 
                $m->subject = "[D.CAMP] ".$aly["name"]."님의 경진대회 참가신청이 반려되었습니다.";
            
            $m->tpl_name = "competition_apply_accept";
            $m->assigns["res"] = $res;
            $m->assigns["aly"] = $aly;
            $m->assigns["main_service_url"] = $this->globals->my_host;
            $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
            $m->send();

            if ($_REQUEST["status"] == 1 || $_REQUEST["status"] == 2) {
                $arr["act_type"] = Activity_model::C_TYPE_MEMBER;
                $arr["act_id"] = $aly["user_id"];
                $arr["target_type"] = Activity_model::E_TYPE_COMPETITION;
                $arr["target_id"] = $aly["competition_id"];
                $arr["is_made"] = 0;
                $arr["act_result"] = $_REQUEST["status"];
                $this->Activity->edit($arr); 
            }
        }
    }
    
    public function scoring_apply()
    {
        $this->tpl_name = '';
        $score_l = $this->Competitions_score->get_by_comp($_REQUEST["competition_id"]);
        for ($i=0; $i<sizeof($score_l); $i++) {
            if (array_key_exists("score_".$score_l[$i]["id"], $_REQUEST)) {
                $arr["user_id"] = $_REQUEST["user_id"];
                $arr["apply_id"] = $_REQUEST["apply_id"];
                $arr["score_id"] = $score_l[$i]["id"];
                $arr["score"] = $_REQUEST["score_".$score_l[$i]["id"]];
                $arr["memo"] = $_REQUEST["memo"];
                $this->Competitions_scoring->add($arr);
            }
        }
    }

    public function hide_news($_id)
    {
        $arr["id"] = $_id;
        $arr["is_hidden"] = 1;
        $this->Board->add($arr);
    }

    public function more_event($_status , $_type = '' , $_page = '', $_order = '')
    {
        $pagesize = 16;
        $where = "e.en < 2 and e.state = 1 and open = 1 ";

        if ($_status == 'ing') $where = $where .' and concat(e.date_e, e.end) >= "'. date('Y.m.dH:i').'"';
        else if ($_status == 'end') $where = $where .' and  concat(e.date_e, e.end) < "'. date('Y.m.dH:i').'"';

        if ($_type) $where = $where." and et.id = ".$_type;

        $order = "";  
        if ($_order) $order= 'CONCAT(e.date_e, e.end) ASC';

        $res = $this->Event->list_($_page, $pagesize, $where, 1, $order);

        $this->assigns["res"] = $res;
        $this->assigns["page"] = $_page;
        $this->assigns["status"] = $_status;
    }

    public function more_recruit($_page)
    {
        $pagesize = 10;
        if ($_REQUEST["ing"]) {
            $where = 'r.en < 2 and r.state = 1 '
                .'and ('
                    .'(r.start <= "'.date("Y.m.d").'" and r.end >= "'.date("Y.m.d").'") '
                    .'or (r.start <= "'.date("Y.m.d").'" and r.end = "") '
                    .'or (r.start = "" and r.end = "") '
                .') and r.startup_id = '.$_REQUEST["ing"];
        }
        else  {
            if (! $_REQUEST["status"]) $_REQUEST["status"] = 'ing';
            if ($_REQUEST["status"] == 'all') {
                $where = 'r.en < 2 and r.state = 1';
            }
            else if ($_REQUEST["status"] == 'ing') {
                $where = 'r.en < 2 and r.state = 1 '
                .'and ('
                    .'(r.start <= "'.date("Y.m.d").'" and r.end >= "'.date("Y.m.d").'") '
                    .'or (r.start <= "'.date("Y.m.d").'" and r.end = "") '
                    .'or (r.start = "" and r.end = "") '
                .')';
            }
            else if ($_REQUEST["status"] == 'end') {
                $where = 'r.en < 2 and r.state = 1 and r.end < "'.date("Y.m.d").'" and r.end != ""';
            }
        }
        if ($_REQUEST["inv"])
            $res = $this->Recruit->list_s_opt($_page, $pagesize, 7, $_REQUEST["inv"], $where, 'r.date_edited DESC');
        else
            $res = $this->Recruit->list_s_($_page, $pagesize, $where, 'r.date_edited DESC');
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            $res[$i]["inv"] = $this->Recruit_opt->get_detail($res[$i]["id"], 7);
            $res[$i]["term"] = $this->Recruit_opt->get_detail($res[$i]["id"], 4);
            $res[$i]["job"] = $this->Recruit_opt->get_detail($res[$i]["id"], 6);
            $res[$i]["bis"] = $this->Startup_bussiness->get_by_member_c($res[$i]["id"]);
        }
        $tot = $this->Recruit->list_s_cnt($where);

        $invL = $this->Code->get_by_key('inv');
        for ($v=0; $v<sizeof($invL); $v++) {
            $invL[$v]["cnt"] = $this->Recruit_opt->cnt_by_opt(7, $invL[$v]["id"], $where);
        }

        $this->assigns["res"] = $res;
        $this->assigns["tot"] = $tot;
        $this->assigns["invL"] = $invL;
        $this->assigns["status"] = $_REQUEST["status"];
        $this->assigns["inv"] = $_REQUEST["inv"];
        $this->assigns["ing"] = $_REQUEST["ing"];
    }

    public function more_notice2($_page)
    {
        $_pagesize = 10;
        
        $res = $this->Notice->list_($_page, $_pagesize, '','','visible = 1');
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            $res[$i]["wr"] = $this->Members->get($res[$i]["writer_id"]);
        }
        $this->assigns["res"] = $res;
        $this->assigns["page"] = $_page;
    }

    public function more_competition($_status , $_type = '' , $_page = '')
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
    }

    public function more_contents($_id = '', $_page = '')
    {
        $_pagesize = 10;
        if ($_id)
            $res = $this->Content->list_($_page, $_pagesize, 'c.en = 0 and c.state = 1 and c.hidden = 0 and cc.hidden = 0 and c.category_id ='.$_id);
        else {
            if ($_REQUEST["key"]) {
                $res = $this->Content->search($_REQUEST["key"], 'c.en = 0 and c.state = 1 and c.hidden = 0 and cc.hidden = 0', $_page, $_pagesize);
            }
            else {
                $res = $this->Content->list_($_page, $_pagesize, 'c.en = 0 and c.state = 1 and c.hidden = 0 and cc.hidden = 0');    
            }
            
        }
        $this->assigns["res"] = $res;
        $this->assigns["page"] = $_page;
    }

    public function more_new($_page, $_c = '', $_inv = '')
    {
        $pagesize = 30;
        $result = array();
        if ($_c == 'startup') {
            $res = $this->Startup->list_($_page, $pagesize, 'state = 1 and bio != "" and logo != ""', 'date_edited DESC');
            $len_res = sizeof($res);
            for ($i=0; $i<$len_res; $i++) {
                $ch = $this->Follow->check_follow($_SESSION["s"]["id"], $res[$i]["id"], 2);
                if ($ch) $ch_html = '<button class="btn btn-xs  following" onclick="add_follow(this, '.$_SESSION["s"]["id"].', '.$res[$i]["id"].', 2, 1); return false;">Follwing</button>';
                else $ch_html = '<button class="btn btn-default btn-xs follow" onclick="add_follow(this, '.$_SESSION["s"]["id"].', '.$res[$i]["id"].', 2); return false;">Follow</button>';
                if (!$_SESSION["s"])$ch_html = '<button class="btn btn-default btn-xs follow" onclick="javascript:alert(\'로그인 후 Follow 할 수 있습니다.\');">Follow</button>';

                $html["html"] = '<div class="brick-head"> <a href="/startup/'.$res[$i]["id"].'" class="pull-left brick-object" ><span><img  src="'.$res[$i]["logo"].'"></span></a>'
                            .'<h3 class="brick-heading"><a href="/startup/'.$res[$i]["id"].'">'.$res[$i]["name"].'</a></h3>'
                            .'<button class="btn btn-default btn-xs" onclick=location.href="/startup/'.$res[$i]["id"].'" >프로필 보기</button> '
                            .$ch_html
                        .'</div>'
                        .'<div class="brick-body">'
                            .'<p class="ellipsis"> '.$res[$i]["bio"].' </p>'
                        .'</div>';

                array_push($result, $html);
            }
        }
        else if ($_c == 'people') {

            if ($_inv) $res = $this->Member_interist->list_($_page, $pagesize, 'state = 1 and utype = 1 and interist_id = '.$_inv, 'date_edited DESC');
            else $res = $this->Members->list_($_page, $pagesize, 'state = 1 and utype = 1', 'date_edited DESC');
            
            $len_res = sizeof($res);
            for ($i=0; $i<$len_res; $i++) {
                
                $ch = $this->Follow->check_follow($_SESSION["s"]["id"], $res[$i]["id"], 1);
                if ($ch) $ch_html = '<button class="btn  btn-xs  following" onclick="add_follow(this, '.$_SESSION["s"]["id"].', '.$res[$i]["id"].', 1, 1); return false;">Follwing</button>';
                else $ch_html = '<button class="btn btn-default btn-xs follow" onclick="add_follow(this, '.$_SESSION["s"]["id"].', '.$res[$i]["id"].', 1); return false;">Follow</button>';
                if (!$_SESSION["s"])$ch_html = '<button class="btn btn-default btn-xs follow" onclick="javascript:alert(\'로그인 후 Follow 할 수 있습니다.\');">Follow</button>';
                if ($_SESSION["s"]["id"] == $res[$i]["id"]) $ch_html = "";

                $ed_html = "";
                if ($res[$i]["last_edit"]) $ed_html = "<small>".strip_tags($res[$i]["last_edit"])."</small>";

                $html["html"] = '<div class="brick-head"> <a href="/member/'.$res[$i]["ids"].'" class="pull-left brick-object" ><span><img  src="'.$res[$i]["picture"].'"></span></a>'
                            .'<h3 class="brick-heading"><a href="/member/'.$res[$i]["ids"].'">'.$res[$i]["name"].'</a></h3>'
                            .'<button class="btn btn-default btn-xs" onclick=location.href="/member/'.$res[$i]["ids"].'" >프로필 보기</button> '
                            .$ch_html
                        .'</div>'
                        .'<div class="brick-body">'
                            .'<p class="ellipsis"> '.$res[$i]["bio"].' </p>'
                            .$ed_html
                        .'</div>';

                array_push($result, $html);
            }
        }
        else if ($_c == 'suporter') {
            
            $res = $this->Members->list_($_page, $pagesize, 'state = 1 and utype = 2', 'date_edited DESC');
            $len_res = sizeof($res);
            for ($i=0; $i<$len_res; $i++) {
                
                $ch = $this->Follow->check_follow($_SESSION["s"]["id"], $res[$i]["id"], 1);
                if ($ch) $ch_html = '<button class="btn  btn-xs  following" onclick="add_follow(this, '.$_SESSION["s"]["id"].', '.$res[$i]["id"].', 1, 1); return false;">Follwing</button>';
                else $ch_html = '<button class="btn btn-default btn-xs follow" onclick="add_follow(this, '.$_SESSION["s"]["id"].', '.$res[$i]["id"].', 1); return false;">Follow</button>';
                if (!$_SESSION["s"])$ch_html = '<button class="btn btn-default btn-xs follow" onclick="javascript:alert(\'로그인 후 Follow 할 수 있습니다.\');">Follow</button>';
                if ($_SESSION["s"]["id"] == $res[$i]["id"]) $ch_html = "";
                $ed_html = "";
                if ($res[$i]["last_edit"]) $ed_html = "<small>".strip_tags($res[$i]["last_edit"])."</small>";

                $html["html"] = '<div class="brick-head"> <a href="/member/'.$res[$i]["ids"].'" class="pull-left brick-object" ><span><img  src="'.$res[$i]["picture"].'"></span></a>'
                            .'<h3 class="brick-heading"><a href="/member/'.$res[$i]["ids"].'">'.$res[$i]["name"].'</a></h3>'
                            .'<button class="btn btn-default btn-xs" onclick=location.href="/member/'.$res[$i]["ids"].'" >프로필 보기</button> '
                            .$ch_html
                        .'</div>'
                        .'<div class="brick-body">'
                            .'<p class="ellipsis"> '.$res[$i]["bio"].' </p>'
                            .$ed_html
                        .'</div>';

                array_push($result, $html);
            }
        }
        $this->tpl_name = '';
        if (!$len_res) $result = "";
        echo json_encode($result);
    }

    public function more_network($_page, $_c = '', $_inv = '')
    {
        $pagesize = 15;
        // $result = array();
        if ($_c == 'startup') {
            $pagesize = 20;
            $res = $this->Startup->list_($_page, $pagesize, 'state = 1 and bio != "" and logo != ""', 'date_edited DESC');
        }
        else if ($_c == 'people') {
            if ($_inv) $res = $this->Member_interist->list_($_page, $pagesize, 'state = 1 and utype = 1 and interist_id = '.$_inv, 'date_edited DESC');
            else $res = $this->Members->list_($_page, $pagesize, 'state = 1 and utype = 1', 'date_edited DESC');
        }
        else if ($_c == 'suporter') {
            if ($_inv) $res = $this->Member_interist->list_($_page, $pagesize, 'state = 1 and utype = 2 and interist_id = '.$_inv, 'date_edited DESC');
            else $res = $this->Members->list_($_page, $pagesize, 'state = 1 and utype = 2', 'date_edited DESC');
        }
        $this->assigns["res"] = $res;
        $this->assigns["c"] = $_c;
    }

    public function get_event_link($_id)
    {
        if ($_REQUEST["id"]) {
            $_arr["id"] = $_REQUEST["id"];
            $_arr["rel_url"] = $_REQUEST["rel_url"];
            $this->Space_reserve->edit_rel_url($_arr);
            exit(1);
        }
        $this->assigns["res"] = $this->Space_reserve->get_detail($_id);
    }

    public function get_slide($_id)
    {
        $res = $this->Startup->get($_id);
        $arr = array();
        for ($i=1; $i<5; $i++) {
            if ($res["slide_".$i]) array_push($arr, $res["slide_".$i]);
        }

        if (sizeof($arr)>0)$this->assigns["slide"] = $arr;
    }

    public function get_ex_list_all($_id, $_type, $_page, $_div)
    {
        $pagesize = 5;
        if ($_type == 'all') {
            $res = $this->Competitions_apply->list_($_page, $pagesize, "ca.competition_id = ".$_id." and ca.status = 1");
            for ($ee=0; $ee<sizeof($res); $ee++) {
                $res[$ee]["score"] = $this->Competitions_scoring->get_tot_score($res[$ee]["id"], $_SESSION["s"]["id"]);
            }
            $res_cnt = $this->Competitions_apply->cnt("competition_id = ".$_id." and ca.status = 1");
        }
        else if ($_type == 'end') {
            $res = $this->Competitions_scoring->get_apply_by_ex_score($_id, $_SESSION["s"]["id"], $_page, $pagesize);
            $r_c = $this->Competitions_scoring->get_apply_by_ex_score($_id, $_SESSION["s"]["id"]);
            $res_cnt = sizeof($r_c);
        }
        else if ($_type == 'yet') {
            $s = $this->Competitions_scoring->get_apply_by_ex_score($_id, $_SESSION["s"]["id"], '', '', 'ca.id');
            $a_l = '';
            for ($i=0; $i<sizeof($s); $i++) {
                if ($i == 0) $a_l = $s[$i]["id"];
                else $a_l = $a_l. "," .$s[$i]["id"];
            }
            $w = "status = 1 and competition_id = ".$_id. " and ca.id NOT IN (" .$a_l. ")";
            if ($a_l == '') $w = "status = 1 and competition_id = ".$_id;
            $res = $this->Competitions_apply->list_($_page, $pagesize, $w);
            $res_cnt  = $this->Competitions_apply->cnt($w);
        }
        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["res"] = $res;
        $this->assigns["id"] = $_id;
        $this->assigns["div"] = $_div;
        $this->assigns["type"] = $_type;
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["paging"] = get_paging_dot3($_page, $res_cnt, $pagesize);
    }

    public function get_ap_list_all($_id, $_type, $_page, $_div)
    {
        $pagesize = 5;
        if ($_type == 'all') {
            $res = $this->Competitions_apply->list_out($_page, $pagesize, "ca.competition_id =".$_id);
            $res_cnt = $this->Competitions_apply->cnt_out( "ca.competition_id =".$_id);
        }
        else if ($_type == 'suc') {
            $res = $this->Competitions_apply->list_out($_page, $pagesize, "ca.status = 1 and ca.competition_id =".$_id);
            $res_cnt = $this->Competitions_apply->cnt_out("ca.status = 1 and ca.competition_id =".$_id);
        }
        else if ($_type == 'pre') {
            $res = $this->Competitions_apply->list_out($_page, $pagesize, "ca.status = 0 and ca.competition_id =".$_id);
            $res_cnt = $this->Competitions_apply->cnt_out("ca.status = 0 and ca.competition_id =".$_id);
        }
        else if ($_type == 'rej') {
            $res = $this->Competitions_apply->list_out($_page, $pagesize, "ca.status = 2 and ca.competition_id =".$_id);
            $res_cnt = $this->Competitions_apply->cnt_out("ca.status = 2 and ca.competition_id =".$_id);
        }
        for ($i=0; $i<sizeof($res); $i++) {
            $res[$i]["score"] = $this->Competitions_scoring->get_tot_score($res[$i]["id"]);
        }

        $this->assigns["res_cnt"] = $res_cnt;
        $this->assigns["res"] = $res;
        $this->assigns["id"] = $_id;
        $this->assigns["div"] = $_div;
        $this->assigns["type"] = $_type;
        $this->assigns["page"] = $_page;
        $this->assigns["pagesize"] = $pagesize;
        $this->assigns["paging"] = get_paging_dot3($_page, $res_cnt, $pagesize);
    }

    public function get_apply($_id)
    {
        if (!$_SESSION["s"]) {
            $_SESSION["msg"] = "로그인 후 이용하실 수 있습니다.";
            header("Location: /");
        }

        if (!$_id) header("Location: /error_404");

        $per = $this->Competitions_apply->get($_id);
        $per["com"] = $this->Startup_member->get_by_user($per["user_id"]);
        $res = $this->Competitions->get($per["competition_id"]);
        $examiner = $this->Competitions_examiner->get_by_comp_user($res["id"], $_SESSION["s"]["id"]);
        $op = $this->Competitions_examiner->operator_check($res["id"], $_SESSION["s"]["id"]);

        if ($_SESSION["s"]["id"] != $res["user_id"] && !$examiner && !$op) {
            header("Location: /error_404");
        }
            

        $file = $this->Competitions_file->get_by_comp($res["id"]);
        if ($file) {
            for ($j=0; $j<sizeof($file); $j++) {
                $f = $this->Competitions_files->get_by_file_user($file[$j]["id"], $_id);
                $file[$j][val] = $f["file"];
            }
        }
        $res["form_file"] = $file;
        
        
        $score = $this->Competitions_score->get_by_comp($res["id"]);
        for ($i=0; $i<sizeof($score); $i++) {
            $scoring = $this->Competitions_scoring->get_scoring($_SESSION["s"]["id"], $per["id"], $score[$i]["id"]);
            $score[$i]["scoring"] = $scoring["score"];
            $score[$i]["memo"] = $scoring["memo"];
        }
        
        $this->assigns["res"] = $res;
        $this->assigns["per"] = $per;
        $this->assigns["examiner"] = $examiner;
        $this->assigns["op"] = $op;
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
    }

    public function check_st_info($_id) 
    {
        $lack = false;
        $lack_cnt = 0;
        $res = $this->Startup->get($_id);
        $bis = $this->Startup_bussiness->get_by_member_c($_id);
        $tech = $this->Startup_tech->get_by_member_c($_id);
        
        if (!$res["name"]) {
            $res["lack_1"] = true;
            $lack = true;
            $lack_cnt++;
        }
        if (!$res["bio"]) {
            $res["lack_2"] = true;
            $lack = true;
            $lack_cnt++;
        }
        if (!$res["founded"]) {
            $res["lack_3"] = true;
            $lack = true;
            $lack_cnt++;
        }
        if (!$res["number"]) {
            $res["lack_4"] = true;
            $lack = true;
            $lack_cnt++;
        }
        if (sizeof($bis) < 1) {
            $res["lack_5"] = true;
            $lack = true;
            $lack_cnt++;
        }
        if (sizeof($tech) < 1) {
            $res["lack_6"] = true;
            $lack = true;
            $lack_cnt++;
        }
        if (!$res["email"]) {
            $res["lack_7"] = true;
            $lack = true;
            $lack_cnt++;
        }
        if (!$res["description"]) {
            $res["lack_8"] = true;
            $lack = true;
            $lack_cnt++;
        }

        $ser = $this->Startup_service->list_($_id);

        $res["lack_9"] = true;
        $res["lack_10"] = true;
        $res["lack_11"] = true;
        $res["lack_12"] = true;
        $lack_o = $lack;
        $lack = true;

        for ($i=0; $i<sizeof($ser); $i++) {
            
            if ($ser[$i]["name"]) {
                $res["lack_9"] = false;
            }
            if ($ser[$i]["des_ele"]) {
                $res["lack_10"] = false;
            }
            if ($ser[$i]["des_pro"]) {
                $res["lack_11"] = false;
            }
            if ($ser[$i]["des_sol"]) {
                $res["lack_12"] = false;
            }
        }

        if ($res["lack_9"] == true) $lack_cnt++;
        if ($res["lack_10"] == true) $lack_cnt++;
        if ($res["lack_11"] == true) $lack_cnt++;
        if ($res["lack_12"] == true) $lack_cnt++;

        if ($lack_o == false && ($res["lack_9"] == false || $res["lack_10"] == false 
                || $res["lack_11"] == false || $res["lack_12"] == false ))  {
            $lack = false;
        }

        $this->assigns["res"] = $res;
        $this->assigns["lack"] = $lack;
        $this->assigns["lack_cnt"] = $lack_cnt;

        if ($lack == false) {
            exit(1);
        }
    }

    public function promotion_apply() 
    {
        $this->tpl_name = "";
        $result["error "]= "";
        if ($_REQUEST["startup_id"]) {
            $arr["user_id"] = $_SESSION["s"]["id"];
            $arr["team"] = $_REQUEST["startup_id"]; 
            $arr["competition_id"] = 2; 
            $arr["file"] = $_REQUEST["bio"]; 
            $arr["form"] = $_REQUEST["target"]; 
            $this->Competitions_apply->add($arr);

            $arr["bio"] = $_REQUEST["bio"];
            $arr["id"] = $_REQUEST["startup_id"];
            $this->Startup->add($arr);
        }
        else {
            $result["error "] = "스타트업 정보가 없습니다. 다시 시도해주세요.";
        }
        echo json_encode($result);
    }

    public function bp_edit_profile() 
    {
        $res = $this->Members->get($_SESSION["s"]["id"]);
        $this->assigns["res"] = $res;

        $res_lo = $this->Member_local->get_by_member($_SESSION["s"]["id"]);
        $this->assigns["res_sk"] = $this->Member_skill->get_by_member_c($_SESSION["s"]["id"]);
        if ($res["utype"] == 1) {
            $this->assigns["res_in"] = $this->Member_interist->get_by_member_c($_SESSION["s"]["id"]);
            $inv = $this->Code->get_by_key('inv');
            for ($v=0; $v<sizeof($inv); $v++) {
                for ($vv=0; $vv<sizeof($this->assigns["res_in"]); $vv++) {
                    if ($inv[$v]["id"] == $this->assigns["res_in"][$vv]["interist_id"]) {
                        $inv[$v]['checked'] = true; 
                    }
                }
            }
            $this->assigns["inv"] = $inv;
        }
        else if ($res["utype"] == 2) {
            $this->assigns["res_mk"] = $this->Member_market->get_by_member_c($res["id"]);
            $this->assigns["res_in"] = $this->Member_inv->get_by_member($res["id"]);
        }
        $loc = $this->Code->get_by_key('local');
        for ($l=0; $l<sizeof($loc); $l++) {
            for ($ll=0; $ll<sizeof($res_lo); $ll++) {
                if ($loc[$l]["id"] == $res_lo[$ll]["local_id"]) {
                    $loc[$l]['checked'] = true; 
                }
            }
        }
        $this->assigns["local"] = $loc;
        $this->assigns["res_lo"] = $res_lo;

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

    }

    public function bp_apply()
    {
        $result = "";
        $this->tpl_name = "";

        if ($_REQUEST["birth"]) {
            $_REQUEST["id"] = $_SESSION["s"]["id"];
            $_REQUEST["state"] = $_SESSION["s"]["state"];
            $_id = $this->Members->add($_REQUEST);

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
                $copy_file = $this->settings->root_path.'media/member/'.$_id.$file_ext;

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/member/'.$_id.$file_ext;
                $this->Members->add_picture($_id, $_pic);
            }
            if ($_REQUEST["local"]) {
                if($_REQUEST["id"]) {
                    $this->Member_local->delete_by_user($_REQUEST["id"]);
                }
                $local = explode(",", $_REQUEST["local"]);
                $len_local = sizeof($local);
                for($i=0; $i<$len_local; $i++) {
                    if (trim($local[$i]))
                        $this->Member_local->add($_id, trim($local[$i]));
                }
            }

            if($_REQUEST["id"]) {
                $this->Member_local->delete_by_user($_REQUEST["id"]);
                $this->Member_interist->delete_by_user($_REQUEST["id"]);
                $this->Member_inv->delete_by_user($_REQUEST["id"]);
                $this->Member_skill->delete_by_user($_REQUEST["id"]);
                $this->Member_market->delete_by_user($_REQUEST["id"]);
            }
            // utype == 1
            if ($_REQUEST["local"]) {
                $local = explode(",", $_REQUEST["local"]);
                $len_local = sizeof($local);
                for($i=0; $i<$len_local; $i++) {
                    if (trim($local[$i]))
                        $this->Member_local->add($_id, trim($local[$i]));
                }
            }
            if ($_REQUEST["inter_"]) {
                $int = explode(",", $_REQUEST["inter_"]);
                $len_int = sizeof($int);
                for($n=0; $n<$len_int; $n++) {
                    if (trim($int[$n]))
                        $this->Member_interist->add_c($_id, trim($int[$n]));
                }
            }
            $len_sk = $_REQUEST["cnt_sk"];
            for($j=1; $j<$len_sk+1; $j++) {
                $tmp = "skill_".$j;
                if (trim($_REQUEST[$tmp])) {
                    $val = $this->Code->get_value(trim($_REQUEST[$tmp]), 'jobs');
                    $this->Member_skill->add_c($_id, $val['id']);
                }
            }
            
            // utype == 2
            $len_int = $_REQUEST["cnt_fl_i"];
            for($k=1; $k<$len_int+1; $k++) {
                $tmp = "field_".$k;
                if (trim($_REQUEST[$tmp])) {
                    $val = $this->Code->get_value(trim($_REQUEST[$tmp]), 'jobs');
                    $this->Member_inv->add($_id, $val['id']);
                }
            }
            $len_sk_i = $_REQUEST["cnt_sk_i"];
            for($l=1; $l<$len_sk_i+1; $l++) {
                $tmp = "skill_".$l;
                if (trim($_REQUEST[$tmp])) {
                    $val = $this->Code->get_value(trim($_REQUEST[$tmp]), 'jobs');
                    $this->Member_skill->add_c($_id, $val['id']);
                }
            }
            $len_mk_i = $_REQUEST["cnt_mk_i"];
            for($m=1; $m<$len_mk_i+1; $m++) {
                $tmp = "market_".$m;
                if (trim($_REQUEST[$tmp])) {
                    $val = $this->Code->get_value(trim($_REQUEST[$tmp]), 'market');
                    $this->Member_market->add_c($_id, $val['id']);
                }
            }

            unset($_SESSION["s"]);
            $_SESSION["s"] = $this->Members->get($_id);
            
            $result["msg"] = "오늘 이벤트 참여하였습니다.";
        }

        echo json_encode($result);
    }

    // - Lounge - //
    
    // public function get_posting_area($_id)
    // {
        // $this->assigns["tw"] = $this->Member_ext->get_by_user_id_type($_SESSION["s"]["id"], Member_ext_model::TWITTER_TYPE);
        // $this->assigns["fb"] = $this->Member_ext->get_by_user_id_type($_SESSION["s"]["id"], Member_ext_model::FACEBOOK_TYPE);
        // $this->assigns["id"] = $_id;
        // $e = $this->Event->get($_id);

        // if ( ($e["date_e"] < date('Y.m.d')) || ($e["date_e"] == date('Y.m.d') && $e["end"] < date('H:i')) )  {
        //     $this->assigns["is_end"] = true;
        // }
    // }

    public function add_lounge_posting()
    {
        if ( ! $_SESSION["s"]["id"] ) {
            echo "error_user";
            exit(1);
        }

        $tw = $this->Member_ext->get_by_user_id_type($_SESSION["s"]["id"], Member_ext_model::TWITTER_TYPE);
        $fb = $this->Member_ext->get_by_user_id_type($_SESSION["s"]["id"], Member_ext_model::FACEBOOK_TYPE);

        if ( ($_REQUEST["tw"] && ! $tw) || ($_REQUEST["fb"] && ! $fb) ) {
            echo "error_sns";
            exit(1);
        }
        
        // $arr["p_type"] = Board_model::EVENT_TYPE;
        if ( ! $_REQUEST["type"] ) $_REQUEST["type"] = 3;
        $arr["p_type"] = $_REQUEST["type"];
        $arr["p_id"] = $_REQUEST["id"]; 
        $arr["user_id"] = $_SESSION["s"]["id"];
        $arr["contents"] = $_REQUEST["cont"];
        $arr["parent"] = 0;
        $arr["depth"] = 0;
        $id = $this->Board->add($arr);

        if ($_REQUEST["image"]) {
            $new_i = $this->settings->root_path . "media/board/" . $id . ".jpg";
            $ori_i = $this->settings->root_path . substr($_REQUEST["image"], 1);
            GD2_make_thumb_x(600, "", $ori_i);
            copy($ori_i, $new_i);
            unlink(substr($_REQUEST["image"], 1));
            $_arr["id"] = $id ;
            $_arr["image"] = "/media/board/" . $id  . ".jpg";
            $this->Board->add_image($_arr);
        }

        $res = $this->Board->get_detail($id);
        $addr = "http://".$_SERVER["HTTP_HOST"]."/lounge/comment/".$res["id"];
        $cont = "[D.CAMP Lounge] " . $_REQUEST["cont"];
        if ($_type == 10) {
            $addr = "http://".$_SERVER["HTTP_HOST"]."/showcase/views/".$res["id"];
            $cont = "[D.CAMP Showcase] " . $_REQUEST["cont"];
        }
        if ( $_REQUEST["tw"] ) {
            require_once('../tf_app/ext/twitter/twitteroauth.php');
            $parameters = array('status' => set_sns_len_post($cont, $addr, 140));
            $connection = new TwitterOAuth($this->settings->TWITTER_COMSUMER_KEY, $this->settings->TWITTER_COMSUMER_SECRET, $tw["key_"], $tw["secret"]);
            $status = $connection->post('statuses/update', $parameters);
        }

        if ( $_REQUEST["fb"] ) {
            if ($fb["public"]) {
                $APP_ID = $this->settings->FACEBOOK_API_KEY;
                $APP_SECRET = $this->settings->FACEBOOK_SECRET;
                FacebookSession::setDefaultApplication( $APP_ID, $APP_SECRET );
                
                $session = new FacebookSession( $fb["secret"] );
                $request = new FacebookRequest(
                  $session,
                  'POST',
                  '/me/feed',
                  array (
                    'message' => $cont,
                    'link' => $addr
                  )
                ); 
                $response = $request->execute();
                $graphObject = $response->getGraphObject();
            }
                
        }  
        
        $rc = $this->Members->get($_SESSION["s"]["id"]);
        if ($_REQUEST["type"] == 8) { // challenge, competition
            
            $ev = $this->Office_hours->get_detail($_REQUEST["id"]);
            $m = "<a href='/member/".$rc["ids"]."'>".$rc["name"]."</a>님이 \"<a href='/office_hours/views/".$ev["id"]."#comment'>".$ev["mname"]." ".$ev["mposition"]."</a>\" Office Hours에 댓글을 달았습니다.";

            $mailto = $ev["memail"];
            $subject = "[D.CAMP] ".$rc["name"]."님이 \"".$ev["mname"]." ".$ev["mposition"]."\" Office Hours에 댓글을 달았습니다.";;
            $title = "<a href='http://dcamp.kr/member/".$rc["ids"]."'>".$rc["name"]."</a>님이 \"<a href='http://dcamp.kr/office_hours/views/".$ev["id"]."'>".$ev["mname"]." ".$ev["mposition"]."</a>\" Office Hours에 댓글을 달았습니다.";
            $url = "/office_hours/views/".$ev["id"]."#comment";

            $cid = $ev["mid"];
        }
        else if ($_REQUEST["type"] == 3){
            $ev = $this->Event->get_detail($_REQUEST["id"]);
            $m = "<a href='/member/".$rc["ids"]."'>".$rc["name"]."</a>님이 \"<a href='/event/apply/".$ev["id"]."#comment'>".$ev["title"]."</a>\" 이벤트에 댓글을 달았습니다.";

            $mailto = $ev["memail"];
            $subject = "[D.CAMP] ".$rc["name"]."님이 \"".$ev["title"]."\" 이벤트에 댓글을 달았습니다.";;
            $title = "<a href='http://dcamp.kr/member/".$rc["ids"]."'>".$rc["name"]."</a>님이 \"<a href='http://dcamp.kr/event/apply/".$ev["id"]."'>".$ev["title"]."</a>\" 이벤트에 댓글을 달았습니다.";
            $url = "/event/apply/".$ev["id"]."#comment";

            $cid = $ev["user_id"];
        }

        // noti
        $arr1["com_type"] = 1;
        $arr1["com_id"] = $cid;
        $arr1["act_type"] = 1;
        $arr1["act_id"] = $rc["id"];
        $arr1["msg"] = $m;
        $this->Activity->add($arr1);
        
        if ($_REQUEST["type"] == 3 || $_REQUEST["type"] == 8) {
            // maill
            $m = new TF_mailer($this->settings);
            $m->mailto = $mailto;
            $m->subject = $subject;
            $m->tpl_name = "timeline_act";
            $m->assigns["title"] = $title;
            $m->assigns["url"] = $url;
            $m->assigns["rc"] = $rc;
            $m->assigns["content"] = $_REQUEST["cont"];
            $m->assigns["main_service_url"] = $this->globals->my_host;
            $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
            $m->send();
        }

        $this->get_lounge_timeline($_REQUEST["type"], $_REQUEST["id"], 1, 1);
        $this->tpl_name = "get_lounge_timeline";
    }

    public function get_lounge_timeline($_type, $_id, $_page, $_pagesize = 10)
    {
        if ($_id) 
            $comments = $this->Board->list_($_type, $_id, $_page, $_pagesize);
        else
            $comments = $this->Board->list_in(0, $_page, $_pagesize = 10, "p_type in (3, 6, 7, 8, 9, 10)");
        
        for ( $i=0; $i<sizeof($comments); $i++ ){
            if ($comments[$i]["p_type"] == 3 && $comments[$i]["p_id"] > 0 && !$_id) {
                $e = $this->Event->get($comments[$i]["p_id"]);
                $comments[$i]["p_name"] = $e["title"];
            }
            else if ($comments[$i]["p_type"] == 6) {
                $e = $this->Content->get($comments[$i]["p_id"]);
                $comments[$i]["p_name"] = $e["subject"];
            }
            else if ($comments[$i]["p_type"] == 7) {
                $e = $this->Competitions->get($comments[$i]["p_id"]);
                $comments[$i]["p_name"] = $e["subject"];
            }
            else if ($comments[$i]["p_type"] == 8) {
                $e = $this->Office_hours->get_detail($comments[$i]["p_id"]);
                $comments[$i]["p_name"] = $e["subject"];
            }
            else if ($comments[$i]["p_type"] == 9) {
                $e = $this->Program->get($comments[$i]["p_id"]);
                $comments[$i]["p_name"] = $e["title"];
            }
            else if ($comments[$i]["p_type"] == 10) {
                $e = $this->Startup_service->get($comments[$i]["p_id"]);
                $comments[$i]["p_name"] = $e["name"];
            }
            $comments[$i]["comm"] = $this->Board->get_comment($comments[$i]["p_type"], $comments[$i]["id"]);
            $comments[$i]["like"] = $this->Board->get_like_cnt($comments[$i]["id"]);
            $comments[$i]["is_like"] = $this->Board->get_like_this($comments[$i]["id"], $_SESSION["s"]["id"]);
        }
            
        if ($_id < 1) $where = "b.user_id = m.id and p_type = ".$_type." AND depth = '0'";
        else $where = "b.user_id = m.id and p_id = ".$_id." AND p_type = ".$_type." AND depth = '0'";
        $comments_cnt = $this->Board->cnt($where, "members m, board b");
        
        $this->assigns["id"] = $_id;
        $this->assigns["comments"] = $comments;
        $this->assigns["paging"] = get_paging_dot2($_page, $comments_cnt, $_pagesize); 
        $this->assigns["page"] = $_page;
    }

    public function check_upload_file()
    {
        $this->tpl_name = "";

        print_r($_FILES['file-0']['size']);

    }

    public function add_timeline_like($_bid, $_type)
    {
        $this->tpl_name = "";
        if ( ! $_SESSION["s"]["id"]) {
            $result["login"] = true;
            echo json_encode($result);   
            exit();
        }
        if ($_type == 1) {
            $this->Board->delete_like($_bid, $_SESSION["s"]["id"]);
        }
        else {
            $res = $this->Board->check_like($_bid, $_SESSION["s"]["id"]);
            if ($res) {
                $result["error"] = "500";
                echo json_encode($result);   
                exit();
            }
            $this->Board->add_like($_bid, $_SESSION["s"]["id"]);   
        }
        $result["cnt"] = $this->Board->get_like_cnt($_bid);
        echo json_encode($result);
    }

    public function get_timeline_like($_bid)
    {
        $this->assigns["res"] = $this->Board->get_like_user($_bid);
    }

    public function add_star_event($_id, $_star)
    {
        $this->tpl_name = "";
        if ( ! $_SESSION["s"]["id"]) {
            $result["error"] = "login";
        }
        else {
            $check = $this->Event->check_star($_id, $_SESSION["s"]["id"]);
            if ( $check ) {
                $result["error"] = "aleady";   
            }
            else {
                $this->Event->add_star($_id, $_SESSION["s"]["id"], $_star);
                $result["data"] = $this->Event->get_average_star($_id);
            }
        }
            
        echo json_encode($result);
    }

    public function edit_recruit($_type)
    {
        $this->tpl_name = "";
        if ($_SESSION["s"]) 
        {
            $this->Members->edit_info($_SESSION["s"]["id"], "wanted", $_type);
        }
    }

    public function get_follow($_type, $_id, $_opt)
    {
        if ( ! $_opt){
            $fl = $this->Follow->get_folling($_type, $_id);
            for($i=0; $i<sizeof($fl); $i++) {
                $res[$i] = $this->Members->get($fl[$i]["follower"]); 
            }
        }  
        else {
            $fi = $this->Follow->get_follower("", $_id);
            for($j=0; $j<sizeof($fi); $j++) {
                if ($fi[$j]["type"] == 1) {
                    $res[$j] = $this->Members->get($fi[$j]["following"]); 
                    $res[$j]['type'] = 1;
                }
                else {
                    $res[$j] = $this->Startup->get($fi[$j]["following"]); 
                    $res[$j]['type'] = 2;
                }
            }
        }

        $this->assigns["res"] = $res;
        $this->assigns["opt"] = $_opt;
    }

    public function get_profile($_id, $_smid)
    {
        $this->assigns["res"] = $this->Members->get($_id);
        $this->assigns["smid"] = $_smid;
    }

    public function doffice_send_mail()
    {
        $m = new TF_mailer($this->settings);
        $m->mailto = "d.office@dcamp.kr";
        $m->subject = "[D.Office] BOOK A TOUR 신청";
        $m->tpl_name = "doffice";
        $m->assigns["name"] = $_REQUEST["name"];
        $m->assigns["email"] = $_REQUEST["email"];
        $m->assigns["phone"] = $_REQUEST["phone"];
        $m->assigns["needs"] = $_REQUEST["needs"];
        $m->assigns["main_service_url"] = $this->globals->my_host;
        $m->assigns["main_service_domain"] = $_SERVER['SERVER_NAME'];
        $m->send();

        $this->tpl_name = "";
    }
}
?>
