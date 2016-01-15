<?
    class Editor8 extends Controller
    {
        var $assigns = array();
        var $assigns_layout = array();
        var $layout = "default";
        var $use_models = array();
        

        
        function editor_add_html()
        {
            $this->layout = "";
            $this->tpl_name = "editor8/views/editor_add_html";
        }
        
        function error($argv)
        {
            $type = $argv[0];
            
            $this->assigns["type"] = $type;
            
        }
        
        function editor_add_link()
        {
            $this->layout = "";
            $this->tpl_name = "editor8/views/editor_add_link";
        }
        
        function editor_add_image()
        {
            $this->layout = "";
            $this->tpl_name = "editor8/views/editor_add_image";
        }
        
        function editor_add_image_process()
        {
            global $settings;

            $this->tpl_name = "editor8/views/editor_add_image_process";
            $this->layout = "";
            $ufn = make_upload("web/media/editor_temp/","upload_file");
    	    $this->assigns["path"] = "media/editor_temp/".$ufn;
    	    $this->assigns["smu"] = $this->settings->service_main_url;

			$this->assigns["position"] = $_REQUEST["position"];
			$this->assigns["caption"] = $_REQUEST["caption"];
			
			
			
        }
        
        function editor_add_movie()
        {
            $this->layout = "";
            $this->tpl_name = "editor8/views/editor_add_movie";
        }
        
        function editor_add_movie_process()
        {
            $this->tpl_name = "editor8/views/editor_add_movie_process";
            $movie_url = trim($_REQUEST["movie_url"]);
            
            //print (substr($movie_url,0,3));



            
            if (substr($movie_url,0,3) == "<if")
            {
                // iframe hoso
                $pos1 = strpos($movie_url, "player.vimeo.com");
                if ($pos1 > 0)
                {
                    $pos2 = strpos($movie_url, "\"", $pos1+9);
                    $tgt = substr($movie_url, $pos1 + 23, $pos2 - $pos1 - 23);
                    //print ($tgt);
                    //exit(0);
                    $tgt = "http://vimeo.com/moogaloop.swf?clip_id=" . $tgt;

                    $type = "vimeo";
                    $id = $tgt;
                }
                else
                {
                    $pos1 = strpos($movie_url, "/embed/");
                    $pos2 = strpos($movie_url, "?", $pos1+9);
                    $pos3 = strpos($movie_url, "&", $pos1+9);
                    $pos4 = strlen($movie_url);
                    
                    if ($pos2 < 0 || ($pos3 > -1 && $pos3 < $pos2)) $pos2 = $pos3;
                    if ($pos2 < 0) $pos2 = $pos4;
                    
                    
                    $tgt = substr($movie_url, $pos1 + 7, $pos2 - 1 - $pos1 - 6);
                    $tgt = "http://www.youtube.com/v/" . $tgt;

                    $type = "vimeo";
                    $id = $tgt;
                }
            }
            else
            {
                $pos0 = strpos($movie_url, "embed");
                $pos1 = strpos($movie_url, "src", $pos0);
                $pos2 = strpos($movie_url, "\"", $pos1+6);
                $pos3 = strpos($movie_url, "'", $pos1+6);
                if ($pos3 && $pos3 < $pos2) $pos2 = $pos3;
                $tgt = substr($movie_url, $pos1 + 5, $pos2 - 1 - $pos1 - 4);
            }
            
            $this->assigns["tgt"] = $tgt;
            
        }
        
        function editor_add_remarks()
        {
            $this->tpl_name = "editor8/views/editor_add_remarks";
            $this->layout = "";
            $settings = new Settings();
            $ufn = make_upload("media/","upload_file");
                
    	    $this->assigns["path"] = "media/".$ufn;
			
			//$this->assigns["width"] = $width;
			$this->assigns["id"] = $_REQUEST["id"];
			
        }
        
    }
    
    
?>