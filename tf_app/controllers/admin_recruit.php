<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * 
 * violet@userstorylab.com
 */

class Admin_recruit extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "admin";
    var $use_models = array("Recruit", "Recruit_opt", "Code", "Local", "Startup", "Code", "Banner");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "recruit";
        $this->assigns_layout["gnb_title"] = "채용정보";
        if (($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1){
            header("Location: /login");
        }
        $this->assigns_layout["s"] = $_SESSION["s"];
        $this->assigns["s"] = $_SESSION["s"];
    }

    public function index($_page = 1)
    {
        $this->assigns_layout["gnb_left"] = "recruit";
        
        $pagesize = 10;
        $where = '';
        $c_where = '';
        if ($_REQUEST["sort"]) {
            $where = "r.".$_REQUEST["sort"]."=".$_REQUEST["order"];
            $c_where = $_REQUEST["sort"]."=".$_REQUEST["order"];
        }
        if ($_REQUEST['order'] == 99) {
            $where = '';
            $c_where = '';
        }
        if ($_REQUEST["search"]) {
            if  ($where != '') $where = $where . " and ";
            if  ($c_where != '') $c_where = $c_where . " and ";
            $where = $where. '(title like "%'.$_REQUEST["search"].'%" or contents like "%'.$_REQUEST["search"].'%" )';
            $c_where = $c_where. '(title like "%'.$_REQUEST["search"].'%" or contents like "%'.$_REQUEST["search"].'%" )';
        }
        $res = $this->Recruit->list_s_($_page, $pagesize, $where);
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {
            $res[$i]["sector"] = $this->Recruit_opt->get_detail($res[$i]["rid"], 7);
        }
        $res_cnt = $this->Recruit->cnt('', $c_where);
        $this->assigns["res"] = $res;
        $this->assigns["page"] = $_page;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);
        $this->assigns["search"] = $_REQUEST["search"];
        $this->assigns["order"] = $_REQUEST["order"];
        $this->assigns["sort"] = $_REQUEST["sort"];
    }

    public function add($_id = '')
    {

        $this->assigns_layout["gnb_left"] = "add";
        
        $this->assigns["job"] = $this->Code->get_by_key('job');
        $this->assigns["local"] = $this->Code->get_by_key('local');
        $this->assigns["career"] = $this->Code->get_by_key('career');
        $this->assigns["field"] = $this->Code->get_by_key('field', '', 'id < 20');
        $this->assigns["period"] = $this->Code->get_by_key('period');
        $this->assigns["lang"] = $this->Code->get_by_key('lang');
        $this->assigns["inv"] = $this->Code->get_by_key('inv');
        
        $_key = 'field';
        $result = $this->Code->get_by_key($_key);
        $items = array();
        for ($i=0; $i<sizeof($result); $i++) {
            $result[$i]["value"] = $result[$i]["_value"];
            array_push($items, $result[$i]);
        }

        $this->assigns["job"] =  json_encode($items);

        if ($_REQUEST["user_id"]) {
            if ($_REQUEST["contents"]) {
                 $_REQUEST["contents"] = str_replace('"../../', '"'.'/', $_REQUEST["contents"]);
                 $_REQUEST["contents"] = str_replace('"../', '"'.'/', $_REQUEST["contents"]);
            }
            $startup = $this->Startup->get_by_name($_REQUEST["company"]);
            $_REQUEST["startup_id"] = $startup["id"];
            $id = $this->Recruit->add($_REQUEST);
            $this->Recruit_opt->delete_by_recruit($id);

            if ($_REQUEST["t_local"]) {
                $local = explode(",", $_REQUEST["t_local"]);
                $len_local = sizeof($local);
                for($i=0; $i<$len_local; $i++) {
                    if (trim($local[$i]))
                        $this->Recruit_opt->add($id, trim($local[$i]), 1);
                }
            }
            if ($_REQUEST["t_career"]) {
                $career = explode(",", $_REQUEST["t_career"]);
                $len_career = sizeof($career);
                for($j=0; $j<$len_career; $j++) {
                    if (trim($career[$j]))
                        $this->Recruit_opt->add($id, trim($career[$j]), 2);
                }
            }
            if ($_REQUEST["t_field"]) {
                $field = explode(",", $_REQUEST["t_field"]);
                $len_field = sizeof($field);
                for($k=0; $k<$len_field; $k++) {
                    if (trim($field[$k]))
                        $this->Recruit_opt->add($id, trim($field[$k]), 3);
                }
            }
            if ($_REQUEST["t_period"]) {
                $period = explode(",", $_REQUEST["t_period"]);
                $len_period = sizeof($period);
                for($l=0; $l<$len_period; $l++) {
                    if (trim($period[$l]))
                        $this->Recruit_opt->add($id, trim($period[$l]), 4);
                }
            }
            if ($_REQUEST["t_lang"]) {
                $lang = explode(",", $_REQUEST["t_lang"]);
                $len_lang = sizeof($lang);
                for($m=0; $m<$len_lang; $m++) {
                    if (trim($lang[$m]))
                        $this->Recruit_opt->add($id, trim($lang[$m]), 5);
                }
            }
            $len_j = $_REQUEST["cnt_j"];
            for($n=1; $n<$len_j+1; $n++) {
                $tmp = "job_".$n;
                if (trim($_REQUEST[$tmp])) {
                    $val = $this->Code->get_value(trim($_REQUEST[$tmp]), 'field');
                    $this->Recruit_opt->add($id, $val['id'], '6');
                }
            }
            if ($_REQUEST["t_inv"]) {
                $in = explode(",", $_REQUEST["t_inv"]);
                $len_in = sizeof($in);
                for($ii=0; $ii<$len_in; $ii++) {
                    if (trim($in[$ii]))
                        $this->Recruit_opt->add($id, trim($in[$ii]), 7);
                }
            }

            if (!$_REQUEST["id"]) {
                $this->assigns["ok"] = TRUE;
                $s = $this->Startup->get($_REQUEST["startup_id"]);
                $_msg = "<a href='/startup/".$s["id"]."'>".$s["name"]."</>에서 <a href='/recruit/views/".$id."'>채용공고</a>를 작성했습니다.";
                add_activity(2, $_REQUEST["startup_id"], 2, $_REQUEST["startup_id"], '', $_msg);

            }
            else {
                $this->assigns["msg"] = "수정되었습니다.";

                if ($_REQUEST["state"] == 1) {

                    // mailing code
                    $this->Code->get_value($id, "rec_m");
                }
            }
        }
        
        if ($_id) {
            $res = $this->Recruit->get($_id);
            $this->assigns["res"] = $res;
            $e_lo = $this->Recruit_opt->get_detail($_id, 1, 1);
            $e_ca = $this->Recruit_opt->get_detail($_id, 2, 1);
            $e_fi = $this->Recruit_opt->get_detail($_id, 3, 1);
            $e_pe = $this->Recruit_opt->get_detail($_id, 4, 1);
            $e_la = $this->Recruit_opt->get_detail($_id, 5, 1);
            $e_jo = $this->Recruit_opt->get_detail($_id, 6);
            $e_in = $this->Recruit_opt->get_detail($_id, 7, 1);
            $this->assigns["e_lo"] = $e_lo["_value"];
            $this->assigns["e_ca"] = $e_ca["_value"];
            $this->assigns["e_fi"] = $e_fi["_value"];
            $this->assigns["e_pe"] = $e_pe["_value"];
            $this->assigns["e_la"] = $e_la["_value"];
            $this->assigns["e_jo"] = $e_jo;
            $this->assigns["e_inv"] = $e_in["_value"];
        }
        else {
            $this->assigns["con"] = '<div>
                <div>* 아래 입력 사항을 준수하여 채용 공고를 작성해 주세요.&nbsp;</div>
                <div>&nbsp; 정보가 부족한 경우에는 &nbsp;승인이 어렵습니다. ^^</div>
                </div>
                <div>&nbsp;</div>
                <div>1. 사업 소개</div>
                <div>&nbsp;</div>
                <div>2. 회사 소개</div>
                <div>&nbsp;</div>
                <div>3. 모집 부분 및 인원, 지원 자격</div>
                <div>&nbsp;</div>
                <div>4. 근무 조건 및 복지제도</div>
                <div>&nbsp;</div>
                <div>5. 지원 방법</div>
                <div>&nbsp;</div>
                <div>6. 근무지역 &nbsp;</div>
                <div>&nbsp;</div>
                <div>7. 유의사항</div>
                <div>&nbsp;</div>
                <div>8. 기타</div>';                                                      
            }
    }

    public function edit_mailling_pic()
    {
        $this->assigns_layout["gnb_left"] = "pic";
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
                $copy_file = $this->settings->root_path.'media/banner/recruit_'.$_id.$file_ext;

                //그림 파일 update 폴더로 옮긴 후 임시파일 삭제
                copy($original_file, $copy_file);
                unlink($original_file); 

                $_pic = '/media/banner/recruit_'.$_id.$file_ext;
                $this->Banner->add_picture('pic_1', $_pic, $_id);
            }
            $this->assigns["msg"] = "수정되었습니다.";
        }
        $this->assigns["res"] = $this->Banner->recruit();
        $this->assigns["res"]["pic_1"] = $this->assigns["res"]["pic_1"]."?".date("is");
    }
}
?>
