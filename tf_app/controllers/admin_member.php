<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 *
 * violet@userstorylab.com
 */

class Admin_member extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "admin";
    var $use_models = array("Members", "Member_local", "Member_skill", "Member_interist"
            , "Member_grade", "Member_career", "Member_project", "Startup_member"
            , "Member_education", "Code", "Recommend");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "member";
        $this->assigns_layout["gnb_title"] = "회원관리";
        if (($_SESSION["s"]["per"] & $this->settings->permission5) != $this->settings->permission5 &&
                    ($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1){
            header("Location: /");
        }
        $this->assigns_layout["s"] = $_SESSION["s"];
        $this->assigns["s"] = $_SESSION["s"];
    }

    public function index($_page = 1)
    {
        $this->assigns_layout["gnb_left"] = "member";
        $pagesize = 10;
        $where = '';
        if ($_REQUEST["sort"] && array_key_exists("order", $_REQUEST)) {
            $where = $_REQUEST["sort"]."=".$_REQUEST["order"];
            if ($_REQUEST['order'] == 99) $where = '';
        }
        if ($_REQUEST["type"] && $_REQUEST["type_e"]) {
            if ($_REQUEST["type_e"] != 99) {
                if  ($where != '') $where = $where . " and ";
                $where = $where . $_REQUEST["type"] . " = " . $_REQUEST["type_e"];
            }
        }
        if (array_key_exists("grade_t", $_REQUEST) && array_key_exists("grade_e", $_REQUEST)
             && $_REQUEST["grade_t"]) {
            if ($_REQUEST["grade_e"] != 99)  {
                if  ($where != '') $where = $where . " and ";
                $where = $where . $_REQUEST["grade_t"] . " = " . $_REQUEST["grade_e"];
            }
        }
        if ($_REQUEST['search']) {
            if  ($where != '') $where = $where . " and ";
            $where = $where. '(m.name like "'.$_REQUEST["search"].'%" or ids like "'.$_REQUEST["search"].'%" 
                    or m.id IN (SELECT user_id FROM startup_member sm, startup s WHERE s.id = sm.startup_id AND s.name LIKE "'.$_REQUEST["search"].'%"))';
        }
        $res = $this->Members->list_($_page, $pagesize, $where);
        $res_cnt = $this->Members->cnt($where);
        for ($i=0; $i<sizeof($res); $i++) {
            $com = $this->Startup_member->get_by_user($res[$i]["id"]);
            $res[$i]["company"] = $com["name"];
        }

        $this->assigns["res"] = $res;
        $this->assigns["search"] = $_REQUEST["search"];
        $this->assigns["order"] = $_REQUEST["order"];
        $this->assigns["sort"] = $_REQUEST["sort"];
        $this->assigns["grade_t"] = $_REQUEST["grade_t"];
        $this->assigns["grade_e"] = $_REQUEST["grade_e"];
        $this->assigns["type"] = $_REQUEST["type"];
        $this->assigns["type_e"] = $_REQUEST["type_e"];
        $this->assigns["page"] = $_page;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);    
        $this->assigns["grade"] = $this->Member_grade->list_(1, 100, "visible = 1");
        if (($_SESSION["s"]["per"] & $this->settings->permission5) == $this->settings->permission5){
            $this->assigns["permit5"] = true;
        }
    }

    public function add($_id = '')
    {
        $this->assigns_layout["gnb_left"] = "member";

        if($_REQUEST["name"]) {
            
            if ($_REQUEST["grade"] == '2') {
                $rec = $this->Recommend->get_by_user($_REQUEST["id"], 'state = 1');
                if (!$rec) unset($_REQUEST["grade"]);
            }
            
            $_id = $this->Members->add($_REQUEST);
            if ($_REQUEST["grade"] == 5) {
                $this->Members->add_etc($_id, 'permission7', date("Y.m.d", mktime(0,0,0,date("m"),date("d")+1,date("Y"))));
            }
        }

        if ($_id) {
            $this->assigns["res"] = $this->Members->get($_id);
            $res_lo = $this->Member_local->get_by_member($_id);
            $loc = $this->Code->get_by_key('local');
            for ($l=0; $l<sizeof($loc); $l++) {
                for ($ll=0; $ll<sizeof($res_lo); $ll++) {
                    if ($loc[$l]["id"] == $res_lo[$ll]["local_id"]) {
                        $loc[$l]['checked'] = true; 
                    }
                }
            }
            $this->assigns["local"] = $loc;
            $this->assigns["res_sk"] = $this->Member_skill->get_by_member_c($_id);
            $this->assigns["res_in"] = $this->Member_interist->get_by_member_c($_id);
            $this->assigns["edu"] = $this->Member_education->list_($_id);
            $this->assigns["career"] = $this->Startup_member->get_list_by_user($_id);
            $this->assigns["project"] = $this->Member_project->list_($_id);
        }
        $this->assigns["grade"] = $this->Member_grade->list_(1, 100, "visible = 1");
    }

    public function approve($_id)
    {
        if (($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1){
            header("Location: /");
        }
        
        $this->assigns_layout["gnb_left"] = "member";
        if ($_REQUEST["id"]) {
            $this->Members->approve($_REQUEST);
        }
        $this->assigns["res"] = $this->Members->get($_id);
        $this->assigns["res_lo"] = $this->Member_local->get_by_member($_id);
        $this->assigns["res_sk"] = $this->Member_skill->get_by_member($_id);
        $this->assigns["res_in"] = $this->Member_interist->get_by_member($_id);
        $this->assigns["grade"] = $this->Member_grade->list_(1, 100, "visible = 1");
    }

    public function grade_list($_page = 1)
    {
        if (($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1){
            header("Location: /");
        }
        $this->assigns_layout["gnb_left"] = "grade";
        
        $pagesize = 10;
        $res = $this->Member_grade->list_($_page, $pagesize);
        $res_cnt = $this->Member_grade->cnt();
        $this->assigns["res"] = $res;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);  
    }

    public function grade($_id = '')
    {
        if (($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1){
            header("Location: /");
        }
        $this->assigns_layout["gnb_left"] = "grade";
        
        if ($_REQUEST["name"]) {
            $permission = 0;

            //체크박스 사용
            if(array_key_exists('permission1',$_REQUEST)) $permission = $permission | $this->settings->permission1;
            else $permission = $permission & (~$this->settings->permission1);

            if(array_key_exists('permission2',$_REQUEST)) $permission = $permission | $this->settings->permission2;
            else $permission = $permission & (~$this->settings->permission2);

            if(array_key_exists('permission3',$_REQUEST)) $permission = $permission | $this->settings->permission3;
            else $permission = $permission & (~$this->settings->permission3);

            if(array_key_exists('permission4',$_REQUEST)) $permission = $permission | $this->settings->permission4;
            else $permission = $permission & (~$this->settings->permission4);

            if(array_key_exists('permission5',$_REQUEST)) $permission = $permission | $this->settings->permission5;
            else $permission = $permission & (~$this->settings->permission5);
            
            if(array_key_exists('permission6',$_REQUEST)) $permission = $permission | $this->settings->permission6;
            else $permission = $permission & (~$this->settings->permission6);
            
            if(array_key_exists('permission7',$_REQUEST)) $permission = $permission | $this->settings->permission7;
            else $permission = $permission & (~$this->settings->permission7);
            
            if(array_key_exists('permission8',$_REQUEST)) $permission = $permission | $this->settings->permission8;
            else $permission = $permission & (~$this->settings->permission8);

            $_REQUEST['permission'] = $permission;
            
            $grade = $this->Member_grade->add($_REQUEST);
            
            $_pic = null;
            if ($_REQUEST["image"]) {
                $img_temp_name = str_replace(" ","",$_REQUEST['image']);

                $ck = substr($img_temp_name, 0, 1);
                if($ck=='/'){
                    $img_temp_name = substr($img_temp_name, 1, strlen($img_temp_name) -1 );
                }

                $file_ext = explode('.',$img_temp_name);
                //$filename = basename($_FILES['file']['name']);
                $file_ext = '.'.$file_ext[sizeof($file_ext)-1];

                $original_file = $this->settings->root_path.$img_temp_name;
                $copy_file = $this->settings->root_path.'media/member_g/img_'.$grade.$file_ext;

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/member_g/img_'.$grade.$file_ext;
            }
            
            $_ico = null;
            if ($_REQUEST["icon"]) {
                $img_temp_name = str_replace(" ","",$_REQUEST['icon']);

                $ck = substr($img_temp_name, 0, 1);
                if($ck=='/'){
                    $img_temp_name = substr($img_temp_name, 1, strlen($img_temp_name) -1 );
                }

                $file_ext = explode('.',$img_temp_name);
                //$filename = basename($_FILES['file']['name']);
                $file_ext = '.'.$file_ext[sizeof($file_ext)-1];

                $original_file = $this->settings->root_path.$img_temp_name;
                $copy_file = $this->settings->root_path.'media/member_g/ico_'.$grade.$file_ext;

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_ico = '/media/member_g/ico_'.$grade.$file_ext;
                $this->Members->add_picture($_id, $_pic);
            }
            if ($_pic || $_ico) {
                $this->Member_grade->add_picture($grade, $_pic, $_ico);
            }

            header("Location: /admin_member/grade/".$grade);
        }
        
        if ($_id || $_id == '0') {
            $this->assigns["res"] = $this->Member_grade->get($_id);
        }
    }

    public function excel()
    {
        if (($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1){
            header("Location: /");
        }
        $this->layout = "";
        
        $res = $this->Members->list_(1, 100000);
        $len_res = sizeof($res);

        header( "Content-type: application/octet-stream; charset=euc-kr" );
        header( "Content-Disposition: attachment; filename=memberList.xls" );
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
        <td>메일수신여부</td>
        <td>SMS수신여부</td>
        <td>상태(0:승인대기,1:승인,2:탈퇴)</td>
        <td>생성일</td>
        <td>관심지역</td>
        <td>업무분야</td>
        <td>업무역량</td>
        </tr>
        ";


        for($i=0; $i<$len_res; $i++) {
            if ($res[$i]["email_rec"])$res[$i]["email_r"] = "Y";
            else $res[$i]["email_r"] = "N";
            if ($res[$i]["sms_rec"])$res[$i]["sms_r"] = "Y";
            else $res[$i]["sms_r"] = "N";

            $res_lo = $this->Member_local->get_by_member_c($res[$i]["id"]);
            $res_sk = $this->Member_skill->get_by_member_c($res[$i]["id"]);
            $res_in = $this->Member_interist->get_by_member_c($res[$i]["id"]);            
            
            echo "<tr><td>".$res[$i]["id"]."</td><td>".$res[$i]["gname"]."</td><td>".$res[$i]["ids"]."</td><td>".$res[$i]["name"]."</td><td>".$res[$i]["email"]."</td><td>".$res[$i]["tel"]."</td><td>".$res[$i]["email_r"]."</td><td>".$res[$i]["sms_r"]."</td><td>".$res[$i]["state"]."</td><td>".$res[$i]["date_created"]."</td><td>".get_value_in_arr($res_lo, "_value")."</td><td>".get_value_in_arr($res_in, "_value")."</td><td>".get_value_in_arr($res_sk, "_value")."</td></tr>";
            // echo "<tr><td>".$res[$i]["id"]."</td><td>".$res[$i]["gname"]."</td><td>".$res[$i]["ids"]."</td><td>".$res[$i]["name"]."</td><td>".$res[$i]["email"]."</td><td>".$res[$i]["tel"]."</td><td>".$res[$i]["email_r"]."</td><td>".$res[$i]["sms_r"]."</td><td>".$res[$i]["state"]."</td><td>".$res[$i]["date_created"]."</td></tr>";
        }

        echo "
        </table>
        ";
        exit(1);
    }
}

?>