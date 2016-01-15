<?
    function cst()
    {
        return ("<div style=\"background-color:#EAEAEA;border-top:#A0A0A0 1px solid;border-bottom:#A0A0A0 1px solid;\"><pre>");
    }

    function ced()
    {
        return ("</pre></div>");
    }
    
    $menucnt = 0;
    $last_upper = 0;
    function menu($level, $title, $my_url, $noarrow = false)
    {
        global $menucnt, $last_upper;
        global $trail;
        $url = $trail->_url;
        $ret = "";
        

        for ($i=0; $i < $level; $i++)
        {
            $ret = $ret . " &nbsp; &nbsp; ";
        }
        
        if (!$noarrow)
        {
            $ret = $ret . "->&nbsp; ";
        }
        
        $ret = $ret . "<a href='/tf/doc/" . $my_url . "'>" . $title . "</a><br/>";

        if ($noarrow && $level==0)
        {
            $menucnt++;
            
            $is_my = substr($url,7,strlen($my_url)) == $my_url;
            
            if ($is_my)
            {
                $ret = "<div id=\"page" . $menucnt . "_off\" style=\"display:none;\">"
                        . "<a href=\"#\" onclick=\"_open(" . $menucnt . ");return false;\">[+] $title</a></div>"
                        . "<div id=\"page" . $menucnt . "_on\">"
                        . "<a href=\"#\" onclick=\"_close(" . $menucnt . ");return false;\">[-] $title</a><br />";
            }
            else
            {
                $ret = "<div id=\"page" . $menucnt . "_off\">"
                        . "<a href=\"#\" onclick=\"_open(" . $menucnt . ");return false;\">[+] $title</a></div>"
                        . "<div id=\"page" . $menucnt . "_on\" style=\"display:none;\">"
                        . "<a href=\"#\" onclick=\"_close(" . $menucnt . ");return false;\">[-] $title</a><br />";
            }
            
        }
        
        
        if ($level == 0)
        {
            $ret = "<br />" . $ret;
        }
        
        return $ret;
    }
    class Tf_welcome extends Controller
    {
        var $assigns = array();
        var $assigns_layout = array();
        var $layout = "";
        var $use_models = array();
        var $use_components = array();
        var $ue_cnt = 0;
        
        
        public function docs($dir = "-1", $file = "index")
        {
            $this->layout = "tf_welcome/views/layout_docs";
            if ($dir == "-1")
            {
                $this->tpl_name = 'tf_welcome/views/doc/index';
            }
            else
            {
                $this->tpl_name = 'tf_welcome/views/doc/' . $dir . '/' . $file;
            }
            
            chdir("..");
            $cwd = getcwd();
            chdir("web");
            $this->assigns["cwd"] = $cwd;


        }
        
        public function make_ultra_project_write()
        {
            $skip = array();
            $skips = $_REQUEST["skips"];
            
            $skips_arr = explode("|", $skips);
            foreach ($skips_arr as $s)
            {
                $s = trim($s);
                if (!$s) continue;
                $skip[$s] = true;
            }
            
            $files = $this->read_file("../tf_app",0, $skip);

                        
            $ret = "[Project ID]\n";
            $ret = $ret . "Signature=UE Proj: v.1\n";
            $ret = $ret . "[Project Information]\n";
            $ret = $ret . "Use Relative Directory=0\n";
            $ret = $ret . "Relative to Project File=1\n";
            $ret = $ret . "Include Sub Directories=1\n";
            $ret = $ret . "Project Tagfile=\n";
            $ret = $ret . "Project Wordfile=\n";
            $ret = $ret . "Filter=\n";
            $ret = $ret . "Create Tagfile=0\n";
            $ret = $ret . "[Group]\n";
            
            $cnt = 0;
            
            $this->ue_cnt = 0;
            $ret = $ret . $this->get_ue_title($files, "", 0);
            $this->ue_cnt = 0;
            $ret = $ret . $this->get_ue_cont($files, "", "");
            
            $fp = fopen("../" . $_REQUEST["filename"] . ".prj" . $file, "w");
            fputs($fp, $ret);
            fclose($fp);
            
            header("location: /tf/make_ultra_project/?filename=" . $_REQUEST["filename"]);
            
            exit(0);
            

        }

        public function make_ultra_project()
        {
            $this->tpl_name = "tf_welcome/views/make_ultra_project";
            $this->layout = "tf_welcome/views/layout";

            chdir("..");
            $cwd = getcwd();
            chdir("web");
            
            $this->assigns["cwd"] = $cwd;
            
            $files = $this->read_file("../tf_app",0, array());
            
            $org = array();
            $exts = array();
            foreach ($this->settings->bootstrap_apps as $b)
            {
                $k = explode("/", $b);
                if ($k[1]) $exts[$k[0]] = true;
            }
            $ret = $this->make_1depth($files, "", "",0, $exts);
            
            //$files = array("core"=>$core, "settings"=>$settings, "ext"=>$exts, "models"=>$models, "controllers"=>$controllers, "views"=>$views);
                    
            $this->assigns["files"] = $ret;
            
            $this->assigns["filename"] = $_REQUEST["filename"];


        }
        
        public function make_1depth($files , $prefix, $spacing, $pass, $exts)
        {
            $ret = array();
            foreach ($files as $k=>$v)
            {
                if ($v != "file")
                {
                    $pass_now = $pass;
                    if ($k == "template.cache" || $k == "template_") $pass_now = true;
                    if ($prefix == "/ext" && !array_key_exists($k, $exts)) $pass_now = true;
                    $r = array();
                    if ($pass_now)
                        $r["pass"] = true;
                    $r["name"] = $prefix . "/" . $k;
                    $r["spacing"] = $spacing;
                    $ret[] = $r;
                    $sib = $this->make_1depth($v, $prefix . "/" . $k, $spacing . "&nbsp;&nbsp;&nbsp;&nbsp;", $pass_now, $exts);
                    $ret = array_merge($ret, $sib);
                }
            }
            
            return $ret;
            
        }

        public function make_ultra_project_download()
        {

            $skip = array();
            $skips = $_REQUEST["skips"];
            
            $skips_arr = explode("|", $skips);
            foreach ($skips_arr as $s)
            {
                $s = trim($s);
                if (!$s) continue;
                $skip[$s] = true;
            }
            
            $files = $this->read_file("../tf_app",0, $skip);
                        
            $ret = "[Project ID]\n";
            $ret = $ret . "Signature=UE Proj: v.1\n";
            $ret = $ret . "[Project Information]\n";
            $ret = $ret . "Use Relative Directory=0\n";
            $ret = $ret . "Relative to Project File=1\n";
            $ret = $ret . "Include Sub Directories=1\n";
            $ret = $ret . "Project Tagfile=\n";
            $ret = $ret . "Project Wordfile=\n";
            $ret = $ret . "Filter=\n";
            $ret = $ret . "Create Tagfile=0\n";
            $ret = $ret . "[Group]\n";
            
            $cnt = 0;
            
            $this->ue_cnt = 0;
            $ret = $ret . $this->get_ue_title($files, "", 0);
            $this->ue_cnt = 0;
            $ret = $ret . $this->get_ue_cont($files, "", "");
            
            header("Content-Type: doesn/matter");
            header("content-length: ". strlen($ret));
            header("Content-Disposition: attachment; filename=ue.prj");
            header("Content-Transfer-Encoding: binary");
            header("Pragma: no-cache");
            header("Expires: 0");
            print ($ret);
            exit(0);
            

        }

        
        function get_ue_title($files, $prefix)
        {
            $ret = "";
            foreach($files as $k=>$v)
            {
                if ($v == "file" || !$v) continue;
                $ret = $ret . $this->ue_cnt . "=" . $prefix . $k . "\n";
                $this->ue_cnt++;
                $ret = $ret . $this->get_ue_title($v, $prefix . $k . " - ");
                
            }
            
            return $ret;
        }
        
        function get_ue_cont($files, $prefix, $prefix_file)
        {
            chdir("..");
            $cwd = getcwd();
            chdir("web");

            $ret = "";
            $cnt = 0;
            
            $dirs = array();
            
            foreach($files as $k=>$v)
            {
                if (!$v) continue;
                if ($v == "file")
                {
                    $ret = $ret . $cnt . "=" . $cwd . "\\tf_app\\" . $prefix_file . $k . "\n";
                    $cnt++;
                }
                else
                {
                    $dirs[$k] = $v;
                }
                
            }
            foreach($dirs as $k=>$v)
            {
                $ret = $ret . "[Files - " . $prefix . $k . "]\n";
                $this->ue_cnt++;
                $ret = $ret . $this->get_ue_cont($v, $prefix . $k . " - ",  $prefix_file . $k . "\\");
                
            }
            
            return $ret;
        }
        
        public function read_file($name, $depth ,$skip = null)
        {
            $ret = array();
            $dir = dir($name);
            while ($file = $dir->read())
            {
                if ($file == "." || $file == "..") continue;
                
                if (array_key_exists(substr($name,9) . "/" . $file, $skip)) continue;
                
                if (is_dir($name . "/" . $file))
                {
                    $ret[$file] = $this->read_file($name . "/" . $file, $depth+1, $skip);
                }
                else
                {
                    $ret[$file] = "file";
                    
                }
                
                
            }            
            
            return $ret;
        }
        
        public function diagnotics()
        {
            set_error_handler('tf_warning_handler', E_WARNING);
            $result = array();
            
            // TEST DB
            $db_setting = $this->settings->db;
            
            if ($db_setting)
            {
                $tcnt = sizeof($db_setting);
                $cnt=0;
                foreach($db_setting as $d)
                {
                    $cnt++;
                    $db = mysql_connect($d['SERVER'],$d['ID'], $d['PW'], true);
                    $ret = mysql_select_db($d['DB'],$db);
                    
                    if ($db)
                    {
                        if ($ret)
                            $result[] = array("title"=>"DB 테스트" . $cnt . "/" . $tcnt, "result"=>"DB 연결이 잘 되었습니다.");
                        else
                            $result[] = array("title"=>"DB 테스트" . $cnt . "/" . $tcnt, "result"=>"그러한 DB는 없습니다.", "remedy"=>"/tf/remedy/db_not_exists/" . $d['DB'] . "/");
                    }
                    else
                        $result[] = array("title"=>"DB 테스트" . $cnt . "/" . $tcnt, "result"=>"DB 연결에 실패하였습니다.", "remedy"=>"/tf/remedy/db_not_exists");
                }
            }
            else
            {
                $result[] = array("title"=>"DB 테스트", "result"=>"DB 세팅이 없습니다", "remedy"=>"/tf/remedy/db_setting_not_exists");
            }
            
            if (get_magic_quotes_gpc())
            {
                $result[] = array("title"=>"php.ini 세팅", "result"=>"magic_quotes_gpc 세팅이 꺼져야 합니다.", "remedy"=>"/tf/remedy/php_ini_magic_quotes_gpc");
            }
            else
            {
                $result[] = array("title"=>"php.ini 세팅", "result"=>"알려진 이상은 없습니다");
            }
            $this->assigns["result"] = $result;

            $tf = array();
            $tf["version"] = "0.8.0";
            $this->tpl_name = "tf_welcome/views/diagnotics";
            $this->layout = "tf_welcome/views/layout";
            

            $result_con = array();
            $core = array();
            // TEST COMPONENTS
            $result_bs = array();
            $bootstrap_apps = $this->settings->bootstrap_apps;
            
            $tcnt = sizeof($bootstrap_apps);
            $cnt=0;
            foreach($bootstrap_apps as $b)
            {
                $name = "";
                $author = "";
                $version = "";
                $version_max = "";
                $version_min = "";
                $fp = fopen("../tf_app/ext/" . $b . ".php", "r");
                while ($content = fgets($fp, 256))
                {
                    if (strpos($content, "TF External Apps"))
                    {
                        for ($i=0;$i<8;$i++)
                        {

                            
                            $content = fgets($fp, 256);
                            $pos = strpos($content, ":");
                            if ($pos)
                            {
                                $c_key = trim(substr($content, 0, $pos));
                                $c_value = trim(substr($content, $pos + 1));
                                if ($c_key == "Name")
                                    $name = $c_value;
                                else if ($c_key == "Author")
                                    $author = $c_value;
                                else if ($c_key == "Version")
                                    $version = $c_value;
                                else if ($c_key == "VersionMax")
                                    $version_max = $c_value;
                                else if ($c_key == "VersionMin")
                                    $version_min = $c_value;
                                    
                            }
                        }
                        break;
                        
                    }
                }
                
                if ($name)
                {
                    $approved = 0;
                    if ($version_max && $version_min)
                    {
                        if (($tf["version"]  == $version_max || $tf["version"]  == $version_min) || $tf["version"]  <= $version_max || $tf["version"]  >= $version_min)
                        {
                            $approved = 1;
                        }
                        else if ($tf["version"] < $version_min || $tf["version"] > $version_max)
                        {
                            $approved = 0;
                        }
                        else
                        {
                            $approved = 2;
                        }
                    }
                    
                    if ($approved == 0)
                        $remedy = "/tf/remedy/component_not_usable";
                    else if ($approved == 2)
                        $remedy = "/tf/remedy/component_may_not_usable";
                    else
                        $remedy = "";
                    
                    $result_bs[] = array("file"=>$b, "name"=>$name, "author"=>$author, "version"=>$version, "approved"=>$approved, "remedy"=>$remedy);
                }
                else
                {
                    $result_bs[] = array("file"=>$b, "remedy"=>"/tf/remedy/not_welformed_component");
                }
                $cnt++;
                
            }

            $this->assigns["result_bs"] = $result_bs;

            
                        
            // TEST CORE FILES
            $result_con = array();
            $bootstrap_apps = $this->settings->bootstrap_apps;
            
            $dir = dir("../tf_app/core");
            $total_use_model = array();
            while ($file = $dir->read())
            {
                if ($file == "." || $file == "..") continue;
                $r = array();
                $r["file"] = $file;

                $name = "";
                $author = "";
                $version = "";
                $fp = fopen("../tf_app/core/" . $file, "r");
                while ($content = fgets($fp, 256))
                {
                    if (strpos($content, "TF CORE"))
                    {
                        for ($i=0;$i<8;$i++)
                        {

                            
                            $content = fgets($fp, 256);
                            $pos = strpos($content, ":");
                            if ($pos)
                            {
                                $c_key = trim(substr($content, 0, $pos));
                                $c_value = trim(substr($content, $pos + 1));
                                if ($c_key == "Name")
                                    $name = $c_value;
                                else if ($c_key == "Author")
                                    $author = $c_value;
                                else if ($c_key == "Version")
                                    $version = $c_value;
                                    
                            }
                        }
                        break;
                        
                    }
                }
                
                if ($file == ".htaccess")
                {
                    $result_core[] = array("file"=>$file, "name"=>"htaccess", "version"=>"N/A", "Authior"=>"N/A", "remedy"=>"");
                }
                else if ($name)
                {
                    $result_core[] = array("file"=>$file, "name"=>$name, "author"=>$author, "version"=>$version, "remedy"=>"");
                }
                else
                {
                    $result_core[] = array("file"=>$file, "result"=>"알 수 없는 파일", "remedy"=>"/tf/remedy/core_unknown");
                }
                $cnt++;
                
            }

            $this->assigns["result_core"] = $result_core;

            $result_con = array();
            // TEST CONTROLLERS
            $dir = dir("../tf_app/controllers");
            $total_use_model = array();
            while ($file = $dir->read())
            {
                if ($file == "." || $file == "..") continue;
                $r = array();
                $r["file"] = $file;
                if (substr(strtolower($file), strlen($file)-4) == ".php")
                {

                    $fp = fopen("../tf_app/controllers/" . $file, "r");
                    $model_cand = array();
                    while ($content = fgets($fp, 256))
                    {
                        if (strpos($content, '$use_models'))
                        {
                            $pos = strpos($content, "(");
                            $pos2 = strpos($content, ")");
                            $model_def = "";
                            if ($pos && $pos2)
                            {
                                $model_def = substr($content, $pos + 1, $pos2-$pos-1);
                            }
                            
                            $model_a = explode(",", $model_def);
                            
                            foreach($model_a as $m)
                            {
                                $m = trim($m);
                                $m = substr($m,1,strlen($m)-2);
                                $total_use_model[strtolower($m)] = true;
                                $model_cand[] = $m;
                            }
                        }
                        else
                        {
                            for($i=0;$i<sizeof($model_cand);$i++)
                            {
                                if ($model_cand[$i] && strpos($content, $model_cand[$i]))
                                {
                                    $model_cand[$i] = "";
                                }
                            }
                        }
                    }
                    
                    $unuse_model = "";
                    for($i=0;$i<sizeof($model_cand);$i++)
                    {
                        if ($model_cand[$i])
                        {
                            if ($unuse_model) $unuse_model = $unuse_model . ", ";
                            $unuse_model = $unuse_model . $model_cand[$i];
                        }
                    }    
                    
                    if ($unuse_model)                
                    {
                        $r["result"] = "사용되지 않는 것으로 추정되는 모델이 있습니다:" . $unuse_model;
                        $r["remedy"] = "/tf/remedy/controller_warning_notuse_model";
                    }
                    
                                    
                }
                else
                {
                    $r["result"] = ".php 파일이 아님";
                    $r["remedy"] = "/tf/remedy/controller_not_a_php_file";
                }
                $result_con[] = $r;
            }
                

            $result_model = array();
            // TEST MODELS
            $dir = dir("../tf_app/models");
            while ($file = $dir->read())
            {
                if ($file == "." || $file == "..") continue;
                $r = array();
                $r["file"] = $file;
                if (substr(strtolower($file), strlen($file)-4) == ".php")
                {
                    if (!array_key_exists(substr(strtolower($file), 0, strlen($file)-4), $total_use_model))
                    {
                        $r["result"] = "이용되지 않는 모델";
                        $r["remedy"] = "/tf/remedy/model_not_use";
                        $result_model[] = $r;
                        $r = array();
                        $r["file"] = $file;
                    }
                    
                    $fp = fopen("../tf_app/models/" . $file, "r");
                    while ($content = fgets($fp, 256))
                    {
                        
                        if (strpos($content, '$current_controller'))
                        {
                            $r["result"] = "호환되지 않는 예전 코드 존재";
                            $r["remedy"] = "/tf/remedy/model_old_definition";
                            $result_model[] = $r;
                            $r = array();
                            $r["file"] = $file;
                            
                        }

                    }
                    
                }
                else
                {
                    $r["result"] = ".php 파일이 아님";
                    $r["remedy"] = "/tf/remedy/controller_not_a_php_file";
                }
                
                
                
            }
            $this->assigns["result_model"] = $result_model;
            $this->assigns["result_con"] = $result_con;
        }
        

        
        public function remedy($tpl_name)
        {
            $this->tpl_name = "tf_welcome/views/remedy/" . $tpl_name;
            $this->layout = "tf_welcome/views/layout_remedy";
        }
        public function index()
        {
            $this->tpl_name = "tf_welcome/views/index";
            $this->layout = "tf_welcome/views/layout";
        }
    } 

?>
