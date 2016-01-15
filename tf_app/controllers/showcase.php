<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Showcase extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "default";
    var $use_models = array("Startup", "Startup_member", "Startup_service", "Code"
            , "Board", "Banner");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "showcase";
        $this->assigns_layout["gnb_title"] = "showcase";
        $this->assigns_layout["top_js"] = "bz";
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns_layout["s"] = $_SESSION["s"];
    }

    public function index($_page = 1) 
    {
        $this->assigns["visual"] = $this->Banner->get_one(4);
        $cat = $this->Code->get_by_key("bz_market", "", "", "_value ASC");
        $pagesize = 10;

        $where = 'status_bz = 1 and user_id_bz IS NOT NULL and img1 is not null and img1 != "" and des_ele is not null and des_ele != "" and des_pro is not null and des_pro != "" ';
        $where_a = $where." and date > '".date('Y.m.d',strtotime('-1 month'))."'";
        $where_r = $where." and date > '".date("Y.m.d")."'";
        $where_j = $where.' and date <= "'.date("Y.m.d").'" and sd.type = 0';
        $where_aa = $where." and date > '".date('Y.m.d',strtotime('-1 month'))."'";
        
        // $this->Startup_service->debug();
        $t_a = $this->Startup_service->get_by_date_cat('', '', $where_a);
        $t_r = $this->Startup_service->get_ser_date('', '', $where_r);
        $t_j = $this->Startup_service->get_by_date_cat('', '', $where_j);
        $t_aa = $this->Startup_service->get_by_date_cat('', '', $where);
        
        $tot_a = sizeof($t_a);
        $tot_r = sizeof($t_r);
        $tot_j = sizeof($t_j);
        $tot_aa = sizeof($t_aa);

        if (!$_REQUEST["status"]) $_REQUEST["status"] = 'just_launched';
        if ($_REQUEST["status"] == 'ready') {
            $res = $this->Startup_service->get_ser_date($_page, $pagesize, $where_r, 'date ASC');  
        }
        else if ($_REQUEST["status"] == 'just_launched') {
            $res = $this->Startup_service->get_by_date_cat($_page, $pagesize, $where_j);
        }
        else if ($_REQUEST["status"] == 'archived') {
            $res = $this->Startup_service->get_ser_date($_page, $pagesize, $where_aa, 'date DESC');
        }
        else if ($_REQUEST["status"] == 'all') {
            $res = $this->Startup_service->get_ser_date($_page, $pagesize, $where_a, 'date ASC');
        }

        for ($r=0; $r<sizeof($res); $r++) {
            $date = $res[$r]["date"];
            $res[$r] = $this->Startup_service->get($res[$r]["service_id"]);
            if ($res[$r]["status_bz"] == 1) {
                $res[$r]["cats"] = $this->Startup_service->get_category($res[$r]["id"]);
                $res[$r]["s"] = $this->Startup->get($res[$r]["startup_id"]);
                $res[$r]["com"] = $this->Board->cnt("p_type = 9 and p_id = ".$res[$r]["id"]);
                
                if (!$date) {
                    $d = $this->Startup_service->get_last_date($res[$r]["id"]);
                    $res[$r]["date"] = $d["date"];
                }
                else {
                    $res[$r]["date"] = $date;
                }
                    
                $res[$r]["type"] = $dates["type"];
                $res[$r]["diff"] = dateDiff(date("Y.m.d"), $res[$r]["date"], '.');
            }
            else { unset($res[$r]); }      
        }
        $t = 0;
        for ($rr=0; $rr<sizeof($res); $rr++) {
            if ($res[$rr]["diff"] < 0) {
                $t = $rr;
                break;
            }
        }   

        $result = $res;
        if ($_REQUEST["status"] == 'all') {
            for ($i=0; $i<$t; $i++) {
                $result[$i] = $res[$t-$i-1];
            }  
        }

        $this->assigns["res"] = $result;
        $this->assigns["tot_aa"] = $tot_aa;
        $this->assigns["tot_j"] = $tot_j;
        $this->assigns["tot_r"] = $tot_r;
        $this->assigns["tot_a"] = $tot_a;
        $this->assigns["today"] = date("Y.m.d");
        $this->assigns["status"] = $_REQUEST["status"];
    }

    public function index_o($_page = 1) 
    {
        $this->assigns["visual"] = $this->Banner->get_one(4);
        $cat = $this->Code->get_by_key("bz_market", "", "", "_value ASC");
        $pagesize = 10;

        // $where = 'status_bz = 1 and user_id_bz IS NOT NULL and user_id_bz != 0';
        $where = 'status_bz = 1 and user_id_bz IS NOT NULL';
        if ($_REQUEST["status"] == 'archived') {
            
            $where = $where." and date < '".date('Y.m.d',strtotime('-1 month'))."'";
            for ($c=0; $c<sizeof($cat); $c++) {
                $where_c = $where.' and category_id = '.$cat[$c]["id"];
                $cc = $this->Startup_service->get_list_ser_cat('', '', $where_c);
                $cat[$c]["cnt"] = sizeof($cc);

            }

            $t = $this->Startup_service->get_ser_date('', '', $where);
            $tot = sizeof($t); 

            if ($_REQUEST["category"]) {
                $where = $where.' and category_id = '.$_REQUEST["category"];
                $res = $this->Startup_service->get_list_ser_cat($_page, $pagesize, $where, 'date DESC');
            }
            else {
                $res = $this->Startup_service->get_ser_date($_page, $pagesize, $where, 'date DESC');  
            }
        }
        else if ($_REQUEST["status"] == 'ready') {

            $where = $where." and date > '".date("Y.m.d")."'";
            for ($c=0; $c<sizeof($cat); $c++) {
                $where_c = $where.' and category_id = '.$cat[$c]["id"];
                $cc = $this->Startup_service->get_list_ser_cat('', '', $where_c);
                $cat[$c]["cnt"] = sizeof($cc);

            }

            $t = $this->Startup_service->get_ser_date('', '', $where);
            $tot = sizeof($t); 

            if ($_REQUEST["category"]) {
                $where = $where.' and category_id = '.$_REQUEST["category"];
                $res = $this->Startup_service->get_list_ser_cat($_page, $pagesize, $where, 'date DESC');
            }
            else {
                $res = $this->Startup_service->get_ser_date($_page, $pagesize, $where, 'date DESC');  
            }
        }
        else {
            $_REQUEST["status"] = 'just_launched';
            
            $where = $where.' and date <= "'.date("Y.m.d").'" and date >= "'.date('Y.m.d',strtotime('-1 month')).'"';
            // category
            $where_c = 'service_id IN ('
                    .'SELECT sd.service_id FROM startup_service s, startup_service_date sd '
                    .'WHERE s.id = sd.service_id AND '.$where.' GROUP BY sd.service_id ORDER BY DATE DESC'
                    .') AND category_id = ';
            for ($c=0; $c<sizeof($cat); $c++) {
                $cnt = $this->Startup_service->get_cnt_cat('', '', $where_c.$cat[$c]["id"]);
                $cat[$c]["cnt"] = sizeof($cnt);
            }
            // result
            if ($_REQUEST["category"]) {
                $where_c = 'service_id IN ('
                    .'SELECT sd.service_id FROM startup_service s, startup_service_date sd '
                    .'WHERE s.id = sd.service_id AND '.$where.' GROUP BY sd.service_id ORDER BY DATE DESC'
                    .') AND category_id = ';
                $res = $this->Startup_service->get_cnt_cat('', '', $where_c.$_REQUEST["category"]);
            }
            else {
                $res = $this->Startup_service->get_by_date_cat($_page, $pagesize, $where);
            }
           
            $t = $this->Startup_service->get_by_date_cat('', '', $where);
            $tot = sizeof($t);
        }

        for ($r=0; $r<sizeof($res); $r++) {
            $date = $res[$r]["date"];
            $res[$r] = $this->Startup_service->get($res[$r]["service_id"]);
            if ($res[$r]["status_bz"] == 1) {
                $res[$r]["cats"] = $this->Startup_service->get_category($res[$r]["id"]);
                $res[$r]["s"] = $this->Startup->get($res[$r]["startup_id"]);
                $res[$r]["com"] = $this->Board->cnt("p_type = 9 and p_id = ".$res[$r]["id"]);
                if ($_REQUEST["status"] == 'just_launched') {
                    $dates = $this->Startup_service->get_last_date($res[$r]["id"]);
                    $res[$r]["date"] = $dates["date"];
                    $res[$r]["type"] = $dates["type"];
                    $res[$r]["diff"] = dateDiff(date("Y.m.d"), $res[$r]["date"], '.');
                }
                else { $res[$r]["date"] = $date; }
            }
            else { unset($res[$r]); }      
        }

        $this->assigns["cat"] = $cat;
        $this->assigns["res"] = $res;
        $this->assigns["tot"] = $tot;
        $this->assigns["today"] = date("Y.m.d");
        $this->assigns["category"] = $_REQUEST["category"];
        $this->assigns["status"] = $_REQUEST["status"];
    }

    public function views($_id)
    {
        if ( ! $_id) {
            header("Location: /showcase");
        }
        $cat = $this->Code->get_by_key("bz_market");
        for ($c=0; $c<sizeof($cat); $c++) {
            $cat[$c]["cnt"] = $this->Startup_service->get_by_cat_cnt($cat[$c]["id"]);
        }
        $tot = $this->Startup_service->cnt("user_id_bz IS NOT NULL and status_bz = 1");

        $res = $this->Startup_service->get($_id);
        $dates = $this->Startup_service->get_last_date($_id);
        $res["date"] = $dates["date"];
        $res["type"] = $dates["type"];
        $res["diff"] = dateDiff(date("Y.m.d"), $res["date"], '.');
        $res["dates"] = $this->Startup_service->get_dates($_id, 1);
        $res["cats"] = $this->Startup_service->get_category($_id);
        $res["s"] = $this->Startup->get($res["startup_id"]);
        $res["art"] = $this->Startup_service->get_article($_id);

        $og["type"] = 'article';
        $og["url"] = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
        $og["title"] = $res["name"]." on D.CAMP";
        $og["description"] = $res["des_ele"];
        $og["image"] = 'http://'.$_SERVER['SERVER_NAME'].$res["img1"];
        $this->assigns_layout["og"] = $og;

        $this->assigns["cat"] = $cat;
        $this->assigns["tot"] = $tot;
        $this->assigns["res"] = $res;
        $this->assigns["today"] = date("Y.m.d");

        if (!strpos($_SERVER["HTTP_REFERER"], "dcamp.kr")) {
            $this->assigns_layout["cards"] = bottom_main();
        }
    }

    public function edit($_id = '')
    {
        if ( ! $_SESSION["s"]["id"]) {
            header("Location: /showcase");
        }

        $this->assigns["st"] = $this->Startup_member->get_list_by_user($_SESSION["s"]["id"], "sm.status = 1");
        $this->assigns["market"] = $this->Code->get_by_key("bz_market");

        if ($_id) {
            $res = $this->Startup_service->get($_id);
            // if ($res["user_id_bz"] == $_SESSION["s"]["id"]) {
                $res["dates"] = $this->Startup_service->get_dates($_id, 1);
                $cats = $this->Startup_service->get_category($_id);
                $res["cat1"] = $cats[0]["id"];
                $res["cat2"] = $cats[1]["id"];
                $res["cat3"] = $cats[2]["id"];
                $res["s"] = $this->Startup->get($res["startup_id"]);
                $res["art"] = $this->Startup_service->get_article($_id);

                $this->assigns["res"] = $res;
            // }
            // else {
            //     header("Location: /showcase");
            // }
        }
        // else {
        //     $ser = $this->Startup_service->list_($this->assigns["st"][0]["id"]);
        //     if ($ser[0]["id"]) {
        //         $res = $this->Startup_service->get($ser[0]["id"]);
        //         $edi = $this->Startup_member->get_first($res["startup_id"], $_SESSION["s"]["id"]);
        //         if ($res["user_id_bz"] == $_SESSION["s"]["id"] || $edi["user_id"] == $_SESSION["s"]["id"]) {
        //             $res["dates"] = $this->Startup_service->get_dates($_id, 1);
        //             $cats = $this->Startup_service->get_category($_id);
        //             $res["cat1"] = $cats[0]["id"];
        //             $res["cat2"] = $cats[1]["id"];
        //             $res["cat3"] = $cats[2]["id"];
        //             $res["s"] = $this->Startup->get($res["startup_id"]);
        //             $res["art"] = $this->Startup_service->get_article($_id);

        //             $this->assigns["res"] = $res;
        //         }
        //     }
        // }
    }

    

}
?>
