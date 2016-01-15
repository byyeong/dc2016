<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Timeline extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "default";
    var $use_models = array("Board", "Startup");

    public function before_calling()
    {
        $this->assigns_layout["con"] = get_contents_category();
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns_layout["s"] = $_SESSION["s"];
    }
    
    public function index($_id) 
    {
        $res = $this->Board->get_detail($_id);
        if ($res) {
            // if ($res["p_type"] == 2) {
            //     $s = $this->Startup->get($res["p_id"]);
            //     $res["picture"] = $s["logo"];
            //     $res["name"] = $s["name"];
            // }
            $this->assigns["comm"] = $this->Board->get_comment('', $res["bid"]);
            $this->assigns["res"] = $res;

            if (!strpos($_SERVER["HTTP_REFERER"], "dcamp.kr")) {
                $this->assigns_layout["cards"] = bottom_main();
            }
        }
        else {
            header("Location: /error_404");
        }
    }

}
?>
