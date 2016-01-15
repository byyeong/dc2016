<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * 
 * violet@userstorylab.com
 */

class Admin_startup extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "admin";
    var $use_models = array("Startup", "Startup_bussiness", "Startup_tech", "Startup_local"
            , "Startup_reference", "Startup_investment", "Startup_incubating", "Startup_founder"
            , "Startup_service", "Code");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "startup";
        $this->assigns_layout["gnb_title"] = "스타트업 관리";
        if (($_SESSION["s"]["per"] & $this->settings->permission1) != $this->settings->permission1){
            header("Location: /login");
        }
        $this->assigns_layout["s"] = $_SESSION["s"];
        $this->assigns["s"] = $_SESSION["s"];
    }

    public function index($_page = 1)
    {
        $this->assigns_layout["gnb_left"] = "startup";
        
        $pagesize = 10;
        $where = '';
        if ($_REQUEST["sort"]) $where = $_REQUEST["sort"]."=".$_REQUEST["order"];
        if ($_REQUEST['order'] == 99) $where = '';
        if ($_REQUEST["search"]) {
            if  ($where != '') $where = $where . " and ";
            $where = '(name like "%'.$_REQUEST["search"].'%" or bio like "%'.$_REQUEST["search"].'%" or addr like "%'.$_REQUEST["search"].'%")';
        }
        $res = $this->Startup->list_($_page, $pagesize, $where);
        $res_cnt = $this->Startup->cnt($where);
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
        
        if ($_REQUEST["name"]) {

            $_id = $this->Startup->add($_REQUEST);
            if ($_REQUEST["bussiness"]) {
                if($_REQUEST["id"]) {
                    $this->Startup_bussiness->delete_by_user($_REQUEST["id"]);
                }
                $bussiness = explode(",", $_REQUEST["bussiness"]);
                $len_bussiness = sizeof($bussiness);
                for($i=0; $i<$len_bussiness; $i++) {
                    if (trim($bussiness[$i]))
                        $this->Startup_bussiness->add($_id, trim($bussiness[$i]));
                }
            }
            if ($_REQUEST["tech"]) {
                if($_REQUEST["id"]) {
                    $this->Startup_tech->delete_by_user($_REQUEST["id"]);
                }
                $tech = explode(",", $_REQUEST["tech"]);
                $len_tech = sizeof($tech);
                for($j=0; $j<$len_tech; $j++) {
                    if (trim($tech[$j]))
                        $this->Startup_tech->add($_id, trim($tech[$j]));
                }
            }
        }
        
        if ($_id) {
            $this->assigns["res"] = $this->Startup->get($_id);
            $this->assigns["res_sk"] = $this->Startup_tech->get_by_member_c($_id);
            $this->assigns["res_in"] = $this->Startup_bussiness->get_by_member_c($_id);
            $this->assigns["ref"] = $this->Startup_reference->list_($_id);
            $this->assigns["inv"] = $this->Startup_investment->list_($_id);
            $this->assigns["inc"] = $this->Startup_incubating->list_($_id);
            $this->assigns["fou"] = $this->Startup_founder->list_($_id);
            $this->assigns["service"] = $this->Startup_service->list_($_id);
        }
        
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
        $this->assigns["job"] =  json_encode($items);
        $this->assigns["skill"] =  json_encode($items2);
    }
    
    public function excel()
    {
        $this->layout = "";
        
        $res = $this->Startup->list_(1, 10000000);
        $len_res = sizeof($res);

        header( "Content-type: application/vnd.ms-excel; charset=euc-kr" );
        header( "Content-Disposition: attachment; filename=startupList.xls" );
        header( "Content-Description: PHP4 Generated Data" );
        Print("<Meta Http-Equiv=\"Content-Type\" Content=\"Application/Vnd.Ms-Excel; Charset=UTF-8\">");

        echo "
        <table>
        <tr>
        <td>id</td>
        <td>회사명</td>
        <td>한줄설명</td>
        <td>창립일</td>
        <td>규모</td>
        <td>웹사이트</td>
        <td>블로그</td>
        <td>twitter</td>
        <td>facebook</td>
        <td>이메일</td>
        <td>전화번호</td>
        <td>주소</td>
        <td>상태(0:승인대기,1:승인,2:비공개)</td>
        <td>dateCreated</td>
        <td>사업분야</td>
        <td>핵심기술</td>
        </tr>
        ";

        for($i=0; $i<$len_res; $i++) {
            $res_in = $this->Startup_bussiness->get_by_member_c($res[$i]["id"]);
            $res_sk = $this->Startup_tech->get_by_member_c($res[$i]["id"]);

            echo "<tr><td>".$res[$i]["id"]."</td><td>".$res[$i]["name"]."</td><td>".$res[$i]["bio"]."</td><td>".$res[$i]["founded"]."</td><td>".$res[$i]["number"]."</td><td>".$res[$i]["website"]."</td><td>".$res[$i]["blog"]."</td><td>".$res[$i]["twitter"]."</td><td>".$res[$i]["facebook"]."</td><td>".$res[$i]["email"]."</td><td>".$res[$i]["tel"]."</td><td>".$res[$i]["addr"]."</td><td>".$res[$i]["state"]."</td><td>".$res[$i]["date_created"]."</td><td>".get_value_in_arr($res_in, "_value")."</td><td>".get_value_in_arr($res_sk, "_value")."</td></tr>";
        }

        echo "
        </table>
        ";
        exit(1);
    }

}
?>
