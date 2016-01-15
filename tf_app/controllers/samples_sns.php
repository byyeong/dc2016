<?
    class Samples_sns extends Controller
    {
        var $assigns = array();
        var $assigns_layout = array();
        var $layout = "default";
        var $use_models = array("Banners");
        
        // TWITTER
        public function twitter_auth()
        {// Æ®À§ÅÍ ÀÎÁõ »ùÇÃÀÔ´Ï´Ù.
            // °£´ÜÈ÷, /tf_sns_utils/twitter_auth/ ¸¦ È£ÃâÇÏ¸é µË´Ï´Ù
            // header ¸¦ ÀÌ¿ëÇØ redirect ¸¦ ÇÏ¼Åµµ µÇ°í,
            // ÇØ´ç URLÀ» ÀÎÁõ À§Ä¡·Î ¹Ù·Î ¸µÅ©ÇÏ¼Åµµ ¹«°üÇÕ´Ï´Ù.
            
            //header ("location: /tf_sns_utils/twitter_auth");
            
        }
        
        public function twitter_callback()
        {// Æ®À§ÅÍ ÄÝ¹éÀÇ »ùÇÃÀÔ´Ï´Ù.
            
            // Æ®À§ÅÍ¿¡¼­ ¹Þ¾Æ¿Â Á¤º¸´Â ¾Æ·¡¿Í °°ÀÌ, ¼¼¼Ç tf_twitter ·Î ¹Þ¾Æ¿É´Ï´Ù
            // ¹ÞÀº Á¤º¸´Â Æ®À§ÅÍ twitter_key, twitter_secret, screen_name, tid, ÇÁ·ÎÇÊ »çÁø(photo_url) ÀÔ´Ï´Ù.
            
            $ret = $_SESSION["tf_twitter"];
            
            // ÇÊ¿ä¿¡ µû¶ó ¹Þ¾Æ¿Â key, secret µîÀ» DB¿¡ ÀúÀå ÇØ µÎ°í
            // Â÷ÈÄ¿¡ ÇØ´ç »ç¿ëÀÚ°¡ ´Ù½Ã ·Î±×ÀÎÇÑ °æ¿ì posting µî¿¡ »ç¿ëµÇ¾îÁú ¼ö ÀÖ½À´Ï´Ù.

            $this->assigns["ret"] = $ret;
            
        }
        
        public function twitter_write()
        {// Æ®À§ÅÍ·Î ±Û ¾²±â »ùÇÃÀÔ´Ï´Ù.
            if ($_REQUEST["cont"])
            {
                // ±Û ³»¿ëÀ» ¹Þ¾Æ¿É´Ï´Ù.
                $cont = $_REQUEST["cont"];
                
                // Æ®À§ÅÍ ÄÁ½´¸Ó key/secret À» ¹Þ¾Æ¿É´Ï´Ù.
                // »ùÇÃ¿¡¼­´Â ¼¼¼Ç¿¡ ÀúÀåµÇ¾úÀ¸¹Ç·Î ¼¼¼ÇÀÇ ³»¿ëÀ» ¹Þ¾Æ¿É´Ï´Ù.
                // º¸ÅëÀº, DB¿¡ ÀúÀåÇÏ°í DB¿¡¼­ ºÒ·¯¿À´Â °ÍÀÌ ÀÏ¹ÝÀûÀÔ´Ï´Ù.
                
                $key = $_SESSION["tf_twitter"]["twitter_key"];
                $secret = $_SESSION["tf_twitter"]["twitter_secret"];
                
                // sns_utils ¿¡ Æ÷ÇÔµÈ twitter_post ¸¦ ºÎ¸¨´Ï´Ù.
                // twitter_post´Â ³»¿ëÀ» ÀÚµ¿À¸·Î 140ÀÚ·Î ¸ÂÃçÁÖ¹Ç·Î, º°´Ù¸¥ Ã³¸®´Â
                // ÇÊ¿äÄ¡ ¾Ê½À´Ï´Ù.
                // ÀÛ¼º ¼º°ø½Ã ÀÛ¼º ±ÛÀÇ tid ¸¦ ¹ÝÈ¯ÇÕ´Ï´Ù. (½ÇÆÐ½Ã false ¹ÝÈ¯)
                $this->assigns["writed"] = twitter_post($key, $secret, $cont);
                $this->assigns["screen_name"] = $_SESSION["tf_twitter"]["screen_name"];
                
            }
        }

        // ME2DAY
        public function me2day_auth()
        {// Æ®À§ÅÍ ÀÎÁõ »ùÇÃÀÔ´Ï´Ù.
            // °£´ÜÈ÷, /tf_sns_utils/me2day_auth/ ¸¦ È£ÃâÇÏ¸é µË´Ï´Ù
            // header ¸¦ ÀÌ¿ëÇØ redirect ¸¦ ÇÏ¼Åµµ µÇ°í,
            // ÇØ´ç URLÀ» ÀÎÁõ À§Ä¡·Î ¹Ù·Î ¸µÅ©ÇÏ¼Åµµ ¹«°üÇÕ´Ï´Ù.
            
            //header ("location: /tf_sns_utils/me2day_auth");
            
        }
        
        public function me2day_callback()
        {// Æ®À§ÅÍ ÄÝ¹éÀÇ »ùÇÃÀÔ´Ï´Ù.
            
            // Æ®À§ÅÍ¿¡¼­ ¹Þ¾Æ¿Â Á¤º¸´Â ¾Æ·¡¿Í °°ÀÌ, ¼¼¼Ç tf_me2day ·Î ¹Þ¾Æ¿É´Ï´Ù
            // ¹ÞÀº Á¤º¸´Â Æ®À§ÅÍ me2day_id, me2day_apikey ÀÔ´Ï´Ù..
            
            $ret = $_SESSION["tf_me2day"];
            
            // ÇÊ¿ä¿¡ µû¶ó ¹Þ¾Æ¿Â key, secret µîÀ» DB¿¡ ÀúÀå ÇØ µÎ°í
            // Â÷ÈÄ¿¡ ÇØ´ç »ç¿ëÀÚ°¡ ´Ù½Ã ·Î±×ÀÎÇÑ °æ¿ì posting µî¿¡ »ç¿ëµÇ¾îÁú ¼ö ÀÖ½À´Ï´Ù.

            $this->assigns["ret"] = $ret;
            
        }
        
        public function me2day_write()
        {// me2day·Î ±Û ¾²±â »ùÇÃÀÔ´Ï´Ù.
            if ($_REQUEST["cont"])
            {
                // ±Û ³»¿ëÀ» ¹Þ¾Æ¿É´Ï´Ù.
                $cont = $_REQUEST["cont"];
                
                // me2day id/api key ¸¦ ¹Þ¾Æ¿É´Ï´Ù.
                // »ùÇÃ¿¡¼­´Â ¼¼¼Ç¿¡ ÀúÀåµÇ¾úÀ¸¹Ç·Î ¼¼¼ÇÀÇ ³»¿ëÀ» ¹Þ¾Æ¿É´Ï´Ù.
                // º¸ÅëÀº, DB¿¡ ÀúÀåÇÏ°í DB¿¡¼­ ºÒ·¯¿À´Â °ÍÀÌ ÀÏ¹ÝÀûÀÔ´Ï´Ù.
                
                $id = $_SESSION["tf_me2day"]["me2day_id"];
                $apikey = $_SESSION["tf_me2day"]["me2day_apikey"];
                
                // sns_utils ¿¡ Æ÷ÇÔµÈ me2day_post ¸¦ ºÎ¸¨´Ï´Ù.
                // me2day_post´Â ³»¿ëÀ» ÀÚµ¿À¸·Î 160ÀÚ·Î ¸ÂÃçÁÖ¹Ç·Î, º°´Ù¸¥ Ã³¸®´Â
                // ÇÊ¿äÄ¡ ¾Ê½À´Ï´Ù.
                // ÀÛ¼º ¼º°ø½Ã ÀÛ¼º ±ÛÀÇ ÆÛ¸Ó¸µÅ©¸¦ ¸¦ ¹ÝÈ¯ÇÕ´Ï´Ù. (½ÇÆÐ½Ã false ¹ÝÈ¯)
                $this->assigns["writed"] = me2day_post($id, $apikey, $cont);
                
            }
        }
        

        // facebook
        public function facebook_auth()
        {// ÆäÀÌ½ººÏ ÀÎÁõ »ùÇÃÀÔ´Ï´Ù.
            // °£´ÜÈ÷, /tf_sns_utils/facebook_auth/ ¸¦ È£ÃâÇÏ¸é µË´Ï´Ù
            // header ¸¦ ÀÌ¿ëÇØ redirect ¸¦ ÇÏ¼Åµµ µÇ°í,
            // ÇØ´ç URLÀ» ÀÎÁõ À§Ä¡·Î ¹Ù·Î ¸µÅ©ÇÏ¼Åµµ ¹«°üÇÕ´Ï´Ù.
            
            //header ("location: /tf_sns_utils/facebook_auth");
            
        }
        
        public function facebook_callback()
        {// ÆäÀÌ½ººÏ ÄÝ¹éÀÇ »ùÇÃÀÔ´Ï´Ù.
            
            // ÆäÀÌ½ººÏ¿¡¼­ ¹Þ¾Æ¿Â Á¤º¸´Â ¾Æ·¡¿Í °°ÀÌ, ¼¼¼Ç tf_facebook ·Î ¹Þ¾Æ¿É´Ï´Ù
            // ¹ÞÀº Á¤º¸´Â facebook_secret, ÇÁ·ÎÇÊ ID(id) ÀÔ´Ï´Ù.
            
            $ret = $_SESSION["tf_facebook"];
            
            // ÇÊ¿ä¿¡ µû¶ó ¹Þ¾Æ¿Â key, secret µîÀ» DB¿¡ ÀúÀå ÇØ µÎ°í
            // Â÷ÈÄ¿¡ ÇØ´ç »ç¿ëÀÚ°¡ ´Ù½Ã ·Î±×ÀÎÇÑ °æ¿ì posting µî¿¡ »ç¿ëµÇ¾îÁú ¼ö ÀÖ½À´Ï´Ù.

            $this->assigns["ret"] = $ret;
            
        }
        
        public function facebook_write()
        {// ÆäÀÌ½ººÏÀ¸·Î ±Û ¾²±â »ùÇÃÀÔ´Ï´Ù.
            
            if ($_REQUEST["cont"])
            {
                // ±Û ³»¿ëÀ» ¹Þ¾Æ¿É´Ï´Ù.
                $cont = $_REQUEST["cont"];
                
                // ÆäÀÌ½ººÏ ÄÁ½´¸Ó secret À» ¹Þ¾Æ¿É´Ï´Ù.
                // »ùÇÃ¿¡¼­´Â ¼¼¼Ç¿¡ ÀúÀåµÇ¾úÀ¸¹Ç·Î ¼¼¼ÇÀÇ ³»¿ëÀ» ¹Þ¾Æ¿É´Ï´Ù.
                // º¸ÅëÀº, DB¿¡ ÀúÀåÇÏ°í DB¿¡¼­ ºÒ·¯¿À´Â °ÍÀÌ ÀÏ¹ÝÀûÀÔ´Ï´Ù.
                
                $secret = $_SESSION["tf_facebook"]["facebook_secret"];
                
                // sns_utils ¿¡ Æ÷ÇÔµÈ facebook_post ¸¦ ºÎ¸¨´Ï´Ù.
                // ÀÛ¼º ¼º°ø½Ã ÀÛ¼º ±ÛÀÇ id ¸¦ ¹ÝÈ¯ÇÕ´Ï´Ù. (½ÇÆÐ½Ã false ¹ÝÈ¯)
                $this->assigns["writed"] = facebook_post($secret, $cont);
                $this->assigns["id"] = $_SESSION["tf_facebook"]["id"];


                
            }
        }
                        
    }

?>