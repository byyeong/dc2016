<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * 
 * violet@userstorylab.com
 */

class Admin_membership extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "admin";
    var $use_models = array("Recommend", "Startup", "Members");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "membership";
        $this->assigns_layout["gnb_title"] = "멤버십 관리";
        if (($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1){
            header("Location: /login");
        }
        $this->assigns_layout["s"] = $_SESSION["s"];
        $this->assigns["s"] = $_SESSION["s"];
    }
    
    public function index($_page = 1)
    {
        $this->assigns_layout["gnb_left"] = "membership";

        $pagesize = 10;
        $where = '';
        if ($_REQUEST["sort"]) $where = $_REQUEST["sort"]." = ".$_REQUEST["order"];
        if ($_REQUEST["order"] == 3) $where = "m.state = ".$_REQUEST["order"];
        if ($_REQUEST['order'] == 99) $where = '';
        if ($_REQUEST["search"]) {
//            $where = '(m.name like "%'.$_REQUEST["search"].'%" or m.ids like "%'.$_REQUEST["search"].'%" or referee like "%'.$_REQUEST["search"].'%")';
            $res = $this->Recommend->list_search($_page, $pagesize, $_REQUEST['search']);
            $res_cnt = $this->Recommend->cnt_search($_REQUEST['search']);
        }
        else {
            $res = $this->Recommend->list_($_page, $pagesize, $where);
            $res_cnt = $this->Recommend->cnt($where);
        }
        $len_res = sizeof($res);
        for ($i=0; $i<$len_res; $i++) {

            if ($res[$i]["rec_com"]) $res[$i]["com"] = $this->Startup->get($res[$i]["rec_com"]);
            if ($res[$i]["rec_mem"]) $res[$i]["mem"] = $this->Members->get($res[$i]["rec_mem"]);
        }
        
        $this->assigns["res"] = $res;
        $this->assigns["search"] = $_REQUEST["search"];
        $this->assigns["order"] = $_REQUEST["order"];
        $this->assigns["sort"] = $_REQUEST["sort"];
        $this->assigns["page"] = $_page;
        $this->assigns["paging"] = get_paging_dot2($_page, $res_cnt, $pagesize);
    }
    
    public function excel()
    {
        $this->layout = "";
        
        $res = $this->Recommend->list_(1, 10000000);
        $len_res = sizeof($res);

        header( "Content-type: application/vnd.ms-excel; charset=euc-kr" );
        header( "Content-Disposition: attachment; filename=membershipList.xls" );
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
        <td>연락처</td>
        <td>메일수신여부</td>
        <td>SMS수신여부</td>
        <td>상태(0:승인대기,1:승인,2:반려)</td>
        <td>생성일</td>
        </tr>
        ";

        for($i=0; $i<$len_res; $i++) {
            if ($res[$i]["email_rec"])$res[$i]["email_r"] = "Y";
            else $res[$i]["email_r"] = "N";
            if ($res[$i]["sms_rec"])$res[$i]["sms_r"] = "Y";
            else $res[$i]["sms_r"] = "N";
            
            echo "<tr><td>".$res[$i]["id"]."</td><td>".$res[$i]["mgname"]."</td><td>".$res[$i]["ids"]."</td><td>".$res[$i]["name"]."(".$res[$i]["referee"].")</td><td>".$res[$i]["email"]."</td><td>".$res[$i]["tel"]."</td><td>".$res[$i]["email_r"]."</td><td>".$res[$i]["sms_r"]."</td><td>".$res[$i]["state"]."</td><td>".$res[$i]["date_created"]."</td></tr>";
        }

        echo "
        </table>
        ";
        exit(1);
    }
}
?>
