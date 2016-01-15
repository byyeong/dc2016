<?

function fancytime($sec)
{
	if ($sec > 60)
	{
		$min = (int)($sec/60);
		$sec = $sec - $min*60;

		if ($min > 24)
		{
			$hr = (int)($min/24);
			$min = $min - $hr*24;
			return $hr."d ".$min."h ".$sec."m";
		}
		else
		{
			return $min."h ".$sec."m";
		}

	}
	else
	{
		return $sec."m";
	}
}


function array_sort($ar, $piv)
{
	for ($i=0;$i<sizeof($ar);$i++)
	{
		for ($j=0;$j<sizeof($ar);$j++)
		{
			if ($ar[$i][$piv] < $ar[$j][$piv])
			{
				$tmp = $ar[$i];
				$ar[$i] = $ar[$j];
				$ar[$j] = $tmp;
			}
		}
	}

	return $ar;

}


function cut($str,$max)
{
	$substr = substr($str, 0, $max*2);
	$multi_max = preg_match_all('/[\x80-\xff]/', $substr, $multi_chars);

	if($multi_max >0)
	$max = $max + intval($multi_max/3)-1;

	if(strlen($str)>$max)
	{
		$str = substr($str, 0, $max-2);
		$str = preg_replace('/(([\x80-\xff]{3})*?)([\x80-\xff]{0,2})$/', '$1', $str);
		$str .= '...';
	}

	return $str;

}


function send_mail($mailto, $subject, $content, $sender_name = null, $sender_address = null)
{

	//        $subject=iconv("UTF-8", "EUC-KR", $subject);
	//        $content=iconv("UTF-8", "EUC-KR", $content);

	if (!$sender_name)
	{
		$settings = new Settings();
		$sender_name = $settings->default_mail_sender_name;
		//$settings->default_mail_sender_address;
	}

	//return mailer ($from, $fname, $to, $cc, $bcc, $subject, $content, $file, $type, $charset, $textencode)


	$smtp_server = "uwa64-001.cafe24.com";
	$smtp_user = "admin";
	$smtp_passwd = "ok1234";
	$sender_address = "admin@trail.or.kr";
	$boundary = "___==MultiPart_" . strtoupper(md5(uniqid(rand()))) . "==___";


	$smtp_server = "smtp.gmail.com";
	$smtp_user = "binseop@gmail.com";
	$smtp_passwd = "ok123456";
	$sender_address = "binseop@gmail.com";

	$smtp_sock = fsockopen($smtp_server, 25);



	/*
	 fputs($smtp_sock, "HELO $smtp_server\r\n");
	 fputs($smtp_sock, "VRFY $smtp_user\r\n");
	 fputs($smtp_sock, "MAIL FROM:$sender_address\r\n");
	 fputs($smtp_sock, "RCPT TO:$mailto\r\n");
	 fputs($smtp_sock, "DATA\r\n");
	 fputs($smtp_sock, "From: $sender_name<$sender_address>\r\n");
	 fputs($smtp_sock, "To: $mailto\r\n");
	 fputs($smtp_sock, "X-Mailer: miplus\r\n");
	 fputs($smtp_sock, "Content-Type: text/html;");
	 fputs($smtp_sock, "charset=UTF-8\r\n");
	 fputs($smtp_sock, "MIME-Version: 1.0\r\n");
	 fputs($smtp_sock, "Subject: $subject\r\n\r\n");
	 fputs($smtp_sock, $content);
	 fputs($smtp_sock, "\r\n\r\n.\r\nQUIT\r\n");
	 */

	//include_once ("../../app/XPM/smtp.php");



	require_once "../../app/XPM/SMTP.php";

	$f = "auth@myjirisan.org";
	$t = $mailto;
	$p = "trail1";
	$c = $content;


	$m = 'From: '.$f."\r\n".
     'To: '.$t."\r\n".
     'Subject: '.$subject."\r\n".
     'Content-Type: text/html'."\r\n\r\n".
	$content;

	// connect to MTA server (relay) 'smtp.gmail.com' via SSL (TLS encryption) with authentication using port '465' and timeout '10' secounds
	// make sure you have OpenSSL module (extension) enable on your php configuration
	$c = SMTP::connect('smtp.gmail.com', 465, $f, $p, 'tls', 10) or die(print_r($_RESULT));

	// send mail relay
	$s = SMTP::send($c, array($t), $m, $f);

	/*
	 // print result
	 if ($s) echo 'Sent !';
	 else print_r($_RESULT);
	 */
	// disconnect
	SMTP::disconnect($c);



}


function file_load($suburl, $filename)
{
	$settings = new Settings();
	$File=fopen($settings->upload_path.$suburl.$filename, "r");
	while(!feof($File)) {
		$Data=$Data.fgets($File, 255);

	}
	fclose($File);

	return $Data;

}


function add_quote($org)
{
	return str_replace("'","''",$org);
}


function date_to_string($org)
{
	return substr($org,5,2)."-".substr($org,8,2).", ".substr($org,11,2).":".substr($org,14,2);

}


function date_to_time_kr($org)
{
	return substr($org,0,2)."시 ".substr($org,2,2)."분";

}


function date_to_kr($org)
{
	return (substr($org,0,4))."년 ".(substr($org,5,2))."월 ".(substr($org,8,2))."일";
}

function date_to_day($org)
{
    $org = substr($org, 0, 10);
    $org = str_replace(".", "", $org);
    $org = strftime("%w",strtotime($org));
    if ($org == 0) $day = "일";
    if ($org == 1) $day = "월";
    if ($org == 2) $day = "화";
    if ($org == 3) $day = "수";
    if ($org == 4) $day = "목";
    if ($org == 5) $day = "금";
    if ($org == 6) $day = "토";
    return $day."요일";
}

function date_to_day_only($org)
{
    $org = substr($org, 0, 10);
    $org = str_replace(".", "", $org);
    $org = strftime("%w",strtotime($org));
    if ($org == 0) $day = "일";
    if ($org == 1) $day = "월";
    if ($org == 2) $day = "화";
    if ($org == 3) $day = "수";
    if ($org == 4) $day = "목";
    if ($org == 5) $day = "금";
    if ($org == 6) $day = "토";
    return $day;
}

function date_to_time($org)
{
    if (substr($org, 0, 2) < 12) $time = "오전 ".substr($org,0, 2)."시 ".substr($org,3, 2)."분";
    if (substr($org, 0, 2) > 11) $time = "오후 ".substr($org,0, 2)."시 ".substr($org,3, 2)."분";
    return $time;
}

function date_to_dateonly($org)
{
	//return $org;
	return substr($org,0,10);

}


function dateplus($odate, $to)
{
	$year = (int) substr($odate,0,4);
	$month = (int) substr($odate,4,2);
	$day = (int) substr($odate,6,2);

	$day += $to;

	if ($day < 1)
	{
		$month--;
		if ($month<1)
		{
			$month = 12;
			$year--;
		}

		$day = $day + getMaxDate($year, $month);
	}

	if ($day > getMaxDate($year,$month))
	{
		$tyear = $year;
		$tmonth = $month;
		$month++;
		if ($month > 12 )
		{
			$month = 1;
			$day -= 31;
			$year++;
		}
		else
		{
			$day -= getMaxDate($tyear,$tmonth);
		}
			
	}


	$res = $year;
	if ($month < 10) $res = $res."0";
	$res = $res.$month;
	if ($day < 10) $res = $res."0";
	$res = $res.$day;
	return $res;

}


function getMaxDate($year, $month)
{
	if ($month == 1 ||$month == 3 ||$month == 5 ||$month == 7 ||$month == 8 ||$month == 10 ||$month == 12) return 31;
	if ($month == 2 ||$month == 4 ||$month == 6 ||$month == 9 ||$month == 11) return 30;
	if ($year % 400 == 0) return 29;
	if ($year % 100 == 0) return 28;
	if ($year % 4 == 0) return 29;
	return 28;

}


function ImageCreateFromAnything($src_file) {
	$img_info = @getimagesize($src_file);
	if ($img_info[2] == "1")
	return ImageCreateFromgif($src_file);
	if ($img_info[2] == "2")
	return ImageCreateFromjpeg($src_file);
	if ($img_info[2] == "3")
	return ImageCreateFrompng($src_file);
	if ($img_info[2] == "16")
	return imagecreatefromwxbm($src_file);
	if ($img_info[2] == "5")
	return imagecreatefromwbmp($src_file);
	if ($img_info[2] == "6")
	return ImageCreateFromBMP($src_file);
}


function contains($content, $str, $ignorecase=true) {
	if ($ignorecase) {
		$str = strtolower($str);
		$content = strtolower($content);
	}
	return strpos($content, $str) ? true : false;
}


function start_with($haystack, $needle) {
	return (substr($haystack, 0, strlen($needle)) == $needle) ? true : false;
}


function end_with($haystack, $needle) {
	return (substr($haystack, 0 - strlen($needle)) == $needle) ? true : false;
}


function get_play_url($url) {
	//if (contains(strtolower($url), '<object') || contains(strtolower($url), '<embed'))
	//return $url; // embed 또는 object 태그가 들어오는 경우 원본 태그 그대로 반환
	$playURL = '';
	if (preg_match('/http:\/\/www\.youtube\.com\/v\/(.[^&]+)/i', $_url, $matches)) { // youtube
		$playURL = 'http://www.youtube.com/embed/' . $matches[1];
	} else if (preg_match('/http:\/\/youtube\.com\/v\/(.[^&]+)/i', $_url, $matches)) { // youtube
		$playURL = 'http://www.youtube.com/embed/' . $matches[1];
	} else if (preg_match('/http:\/\/www\.youtube\.com\/watch\?v=(.[^&]+)/i', $url, $matches)) { // youtube
		$playURL = 'http://www.youtube.com/embed/' . $matches[1];
	} else if (preg_match('/vimeo\.com\/(\d+)/i', $url, $matches)) { // vimeo
		$playURL = 'http://vimeo.com/moogaloop.swf?clip_id=' . $matches[1] . '&amp;server=vimeo.com&amp;show_title=0&amp;show_byline=0&amp;show_portrait=0&amp;color=4cc6d4&amp;fullscreen=1';
	}

	return $playURL;
}


function get_embed_str($videoURL, $width=440, $height=330) {

	if (ereg('youtube.com/embed', $videoURL)) {
		//$videoURL = '<iframe title="YouTube video player" width="' . $width . '" height="' . $height . '" src="' . $videoURL . '" frameborder="0" allowfullscreen></iframe>';
		$videoURL = '<iframe title="YouTube video player" width="' . $width . '" height="' . $height . '" src="' . $videoURL . '" frameborder="0"></iframe>';
	} else {
		//$videoURL = '<iframe title="Vimeo video player" width="' . $width . '" height="' . $height . '" src="' . $videoURL . '" frameborder="0" allowfullscreen></iframe>';
		$videoURL = '<iframe title="Vimeo video player" width="' . $width . '" height="' . $height . '" src="' . $videoURL . '" frameborder="0"></iframe>';
	}

	return $videoURL;
}


function qt_to_str($_value) {
	return str_replace('\'', '\\\'', $_value);
}


function big_qt_to_str($_value) {
	return str_replace('\"', '\\\"', $_value);
}


function make_code() {
	$ret = '';

	for ($i = 0; $i < 8; $i++) {
		$r = rand(0, 61);

		if ($r > 35)
		$r = $r + 61;
		if ($r > 9 and $r < 36)
		$r = $r + 55;
		if ($r < 10)
		$r = $r + 48;

		$ret = $ret . chr($r);
	}

	return $ret;
}


function trans_html($_content) {

	$_content = str_replace('\'', '\\\'', $_content);
	$_content = str_replace('\"', '\\\"', $_content);
	return htmlspecialchars($_content);
}


//2차원 배열 정제
function data_refined($_two_dimensional_array) {
	foreach ($_two_dimensional_array as $int => $val) {
		foreach ($val as $key => $value) {
			if (gettype($key) == 'string') {
				$_refined_data[$key] = $value;
			}
		}
		$final_refined_data[$int] = $_refined_data;
	}

	return $final_refined_data;
}


function get_video_id($_url) {

    $ar_video_info = array();

    if (preg_match('/youtube\.com\/v\/(.[^&]+)/i', $_url, $matches)) {
        // youtube
        $ar_video_info['id'] = $matches[1];
        $ar_video_info['type'] = 1;

    } else if (preg_match('/youtube\.com\/v\/(.[^&]+)/i', $_url, $matches)) {
        // youtube
        $ar_video_info['id'] = $matches[1];
        $ar_video_info['type'] = 1;

    } else if (preg_match('/youtube\.com\/watch\?v=(.[^&]+)/i', $_url, $matches)) {
        // youtube
        $ar_video_info['id'] = $matches[1];
        $ar_video_info['type'] = 1;

    }if (preg_match('/youtu\.be\/(.[^&]+)/i', $_url, $matches)) {
        // youtube
        $ar_video_info['id'] = $matches[1];
        $ar_video_info['type'] = 1;

    } else if (preg_match('/vimeo\.com\/(\d+)/i', $_url, $matches)) {
        // vimeo
        $ar_video_info['id'] = $matches[1];
        $ar_video_info['type'] = 2;
    }

    /*
     } else if ( preg_match('/pann\.nate\.com\/video\/(\d+)/i', $_url, $matches) ){
    $ar_video_info['id'] = $matches[1];
    $ar_video_info['type'] = 3;

    }
    */

    return $ar_video_info;
}

/*
 * get_data 리턴 형식
 * Youtube
 [entry] => Array( [id],[published],[updated],[category],[title],[content],[link] )
 [author] => Array( [name],[uri],[yt:accessControl] )
 [gd:comments] => Array( [gd:feedLink] )
 [media:group] => Array( [media:category],[media:content]
 [media:credit],[media:description],[media:keywords],
 [media:player],[media:thumbnail],[media:title],
 [yt:duration],[yt:uploaded],[yt:videoid],
 [gd:rating],[yt:statistics],[yt:rating],
 )
 */

/*
 * Vimeo
 [video] => Array
 (
 [id] ,[title] ,[description] ,[url] ,
 [upload_date] ,[mobile_url] ,[thumbnail_small] ,
 [thumbnail_medium] ,[thumbnail_large] ,
 [user_name] ,[user_url] ,[user_portrait_small] ,
 [user_portrait_medium] ,[user_portrait_large] ,
 [user_portrait_huge] ,[stats_number_of_likes] ,
 [stats_number_of_plays] ,[stats_number_of_comments] ,
 [duration] ,[width] ,[height] ,[tags]
 )
 */

function get_video_data($_video_id='', $_type=1) {
	//echo $_video_id;

	$AR_XML_ASSOC['error'] = 1;
	$AR_XML_ASSOC['msg'] = '동영상의 ID 값을 입력해 주세요';
	$AR_XML_ASSOC['val'] = '';

	if ($_video_id) {

		if (!strcmp($_type, '1')) {
			$feedURL = 'http://gdata.youtube.com/feeds/api/videos/' . $_video_id . '?v=2';
		} else if (!strcmp($_type, '2')) {
			$feedURL = 'http://vimeo.com/api/v2/video/' . $_video_id . '.xml';
		}

		$rXml = xml_parser_create();

		$arXml = array();
		$strXml = '';
		try {

			$fp = @fopen($feedURL, 'r');
			if ($fp) {
				while (!feof($fp)) {
					$strXml .= fread($fp, 1024);
				}
				fclose($fp);

				xml_parser_set_option($rXml, XML_OPTION_CASE_FOLDING, 0);
				xml_parser_set_option($rXml, XML_OPTION_SKIP_WHITE, 1);
				xml_parse_into_struct($rXml, $strXml, $arXml);
				xml_parser_free($rXml);

				$strNodeKey = null;
				$arXmlAssoc = array();

				// 연관배열 형식으로 하기 위해서 아래와 같이 처리
				foreach ($arXml as $key => $arNode) {
					switch ($arNode['type']) {
						case 'open':
							$strNodeKey = $arNode['tag'];
							$arXmlAssoc[$arNode['tag']];
							break;

						case 'complete':
							if (is_array($arNode['attributes'])) {
								$arXmlAssoc[$strNodeKey][$arNode['tag']][] = array('attr' => $arNode['attributes'], 'value' => $arNode['value']);
							} else {
								$arXmlAssoc[$strNodeKey][$arNode['tag']][] = $arNode['value'];
							}
							break;

						case 'close':
							$nOpenNodeKey = null;
							break;
					}
				}

				$AR_XML_ASSOC['error'] = 0;
				$AR_XML_ASSOC['msg'] = '';
				$AR_XML_ASSOC['val'] = $arXmlAssoc;
			} else {
				$AR_XML_ASSOC['error'] = 404;
				$AR_XML_ASSOC['msg'] = 404;
				$AR_XML_ASSOC['val'] = '';
			}
		} catch (Exception $e) {
			$AR_XML_ASSOC['error'] = 2;
			$AR_XML_ASSOC['msg'] = $e->getMessage();
			$AR_XML_ASSOC['val'] = '';
		}
	}

	return processing_video_data($_type, $AR_XML_ASSOC);
}

function processing_video_data($_type, $_array){

    $re_val = array();

    if ($_type== 1) {
        $_val = arr_search('title', $_array);
        $re_val['title'] = $_val['val'];

        $_val = arr_search('author', $_array);
        $re_val['user'] = $_val['val']['name'][0];

        $_val = arr_search('yt:statistics', $_array);

        if($_val['error']==1){
            $re_val['count'] = 0;

        }else{
            $re_val['count'] = $_val['val']['attr']['viewCount'];

        }

        $_val = arr_search('media:thumbnail', $_array);
        $re_val['s_thumbnail'] = $_val['val'][0]['attr']['url'];
        $re_val['b_thumbnail'] = $_val['val'][2]['attr']['url'];

        $_val = arr_search('media:description', $_array);
        $re_val['intro'] = strip_tags($_val['val']['value']);
         
    } else if ($_type == 2) {
        $_val = arr_search('title', $_array);
        $re_val['title'] = $_val['val'];

        $_val = arr_search('user_name', $_array);
        $re_val['user'] = $_val['val'];

        $_val = arr_search('stats_number_of_plays', $_array);
        $re_val['count'] = $_val['val'];

        $_val = arr_search('thumbnail_small', $_array);
        $re_val['s_thumbnail'] = $_val['val'];

        $_val = arr_search('thumbnail_large', $_array);
        $re_val['b_thumbnail'] = $_val['val'];

        $_val = arr_search('description', $_array);
        $re_val['intro'] = strip_tags($_val['val']);
    }

    return $re_val;
}

function arr_search($_get_attr_name='', $AR_XML_ASSOC='') {
	//test code
	//$_get_attr_name = 'media:thumbnail';
	//$_test_id = 'uPT4bHy0P3Y';
	//$_test_id = '18008261';
	//$this->get_video_data($_test_id,false);
	//print_r($this->AR_XML_ASSOC['val']);
	//exit(0);
	//test code end

	$ar_return_val = array();
	$ar_return_val['error'] = 0;
	$ar_return_val['msg'] = '';
	$ar_return_val['val'] = '';

	if ($AR_XML_ASSOC) {

		if ($AR_XML_ASSOC['val']) {

			foreach ($AR_XML_ASSOC['val'] as $key => $value) {
				if (!strcmp($key, $_get_attr_name)) {
					$ar_return_val['val'] = $value;
				} else {

					foreach ($value as $ch_key => $ch_value) {
						if (!strcmp($ch_key, $_get_attr_name)) {
							$ar_return_val['val'] = $ch_value;
						}
					}
				}
			}

			if (!$ar_return_val['val']) {
				$ar_return_val['error'] = 1;
				$ar_return_val['msg'] = '가져올 값의 key name을 확인해 주세요';
			} else {
				if (sizeof($ar_return_val['val']) == 1) {
					$ar_return_val['val'] = $ar_return_val['val'][0];
				}
			}
		} else {
			$ar_return_val['error'] = 1;
			$ar_return_val['msg'] = '최초 비디오의 DATA를 가져와야 합니다.';
		}
		//print_r($ar_return_val['val']);
	} else {
		$ar_return_val['error'] = 1;
		$ar_return_val['msg'] = '배열을 입력해 주세요';
	}
	return $ar_return_val;
}


function get_real_ip_addr() {
	if (!empty($_SERVER['HTTP_CLIENT_IP'])) { //check ip from share internet
		$ip=$_SERVER['HTTP_CLIENT_IP'];
	} elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {  //to check ip is pass from proxy
		$ip=$_SERVER['HTTP_X_FORWARDED_FOR'];
	} else {
		$ip=$_SERVER['REMOTE_ADDR'];
	}
	return $ip;
}


function handle_page($total_record, $record_per_page, $page_per_block, $current_page) { // 전체레코드,  페이지당 레코드수(10) , 블럭당페이지수(10), 현재페이지

	$return_val = array();

	//체크
	if($current_page < 0) $current_page = 1;

	$total_num_of_page = ceil($total_record / $record_per_page); //16page
	$total_num_of_block = ceil($total_num_of_page / $page_per_block); //2block
	$current_block = ceil($current_page / $page_per_block); // 1page

	$start_page = ($current_block - 1) * $page_per_block + 1;  // 1page
	$end_page = $start_page + $page_per_block - 1; // 10page
	if ($end_page > $total_num_of_page)
	$end_page = $total_num_of_page;

	if($current_page > $end_page) $current_page = $end_page;

	//NEXT,PREV 존재 여부
	$is_next = false;
	$is_prev = false;

	if ($current_block < $total_num_of_block)
	$is_next = true;
	if ($current_block > 1)
	$is_prev = true;

	if ($total_num_of_block == 1) {
		$is_next = false;
		$is_prev = false;
	}

	$return_val['current_page'] = $current_page;
	$return_val['total_record'] = $total_record;

	$return_val['is_next'] = $is_next;
	$return_val['is_prev'] = $is_prev;

	$return_val['start_page'] = $start_page;
	$return_val['end_page'] = $end_page;
	$return_val['page_per_block'] = $page_per_block;

	$return_val['total_num_of_page'] = $total_num_of_page;

	return $return_val;
}

function return_day($_day)
{
    $settings = new Settings();
    
    $days = "";
    if (($_day & $settings->day1) == $settings->day1)
        $days = $days . "월, ";
    if (($_day & $settings->day2) == $settings->day2)
        $days = $days . "화, ";
    if (($_day & $settings->day3) == $settings->day3)
        $days = $days . "수, ";
    if (($_day & $settings->day4) == $settings->day4)
        $days = $days . "목, ";
    if (($_day & $settings->day5) == $settings->day5)
        $days = $days . "금, ";
    if (($_day & $settings->day6) == $settings->day6)
        $days = $days . "토, ";
    if (($_day & $settings->day7) == $settings->day7)
        $days = $days . "일, ";
    
    if ($days != "") 
        $days = substr($days, 0, -2);
    
    return $days;
}

function GD2_make_thumb_new($max_x,$max_y,$dst_name,$src_file) {
    $img_info=@getimagesize($src_file);
    $sx = $img_info[0];
    $sy = $img_info[1];
    //썸네일 보다 큰가?
    if ($sx>$max_x && $sy>$max_y) {
        if ($sx>$sy) {
            $thumb_y=ceil(($sy*$max_x)/$sx);
            $thumb_x=$max_x;
        } else {
            $thumb_x=ceil(($sx*$max_y)/$sy);
            $thumb_y=$max_y;
        }
    }
    else if ($sx>$max_x) {
        $thumb_y=ceil(($sy*$max_x)/$sx);
        $thumb_x=$max_x;
    }
    else if ($sy>$max_y) {
        $thumb_x=ceil(($sx*$max_y)/$sy);
        $thumb_y=$max_y;
    }
     else {
        $thumb_y=$sy;
        $thumb_x=$sx;
    }
    // JPG 파일인가?
    if ($img_info[2]=="2" or 1) {
        $_dq_tempFile=basename($src_file);                                //파일명 추출
        $_dq_tempDir=str_replace($_dq_tempFile,"",$src_file);        //경로 추출
        $_dq_tempFile=$dst_name;        //경로 + 새 파일명 생성

        $_create_thumb_file = true;
        /*
         if (file_exists($_dq_tempFile)) { //섬네일 파일이 이미 존제한다면 이미지의 사이즈 비교
        $old_img=@getimagesize($_dq_tempFile);
        if($old_img[0] != $thumb_x) $_create_thumb_file = true; else $_create_thumb_file = false;
        if($old_img[1] != $thumb_y) $_create_thumb_file = true; else $_create_thumb_file = false;
        }
        */
        if ($_create_thumb_file) {
            // 복제
            if ($img_info[2]=="1") $src_img=ImageCreateFromgif($src_file);
            if ($img_info[2]=="2") $src_img=ImageCreateFromjpeg($src_file);
            if ($img_info[2]=="3") $src_img=ImageCreateFrompng($src_file);
            if ($img_info[2]=="16") $src_img=imagecreatefromwxbm($src_file);
            if ($img_info[2]=="5") $src_img=imagecreatefromwbmp($src_file);
            if ($img_info[2]=="6") $src_img=ImageCreateFromBMP($src_file);

            if (!$src_img)  $src_img=imagecreatefromjpeg($src_file);
            $dst_img=ImageCreateTrueColor($thumb_x, $thumb_y);
            ImageCopyResampled($dst_img,$src_img,0,0,0,0,$thumb_x,$thumb_y,$sx,$sy);
            Imagejpeg($dst_img,$_dq_tempFile,100);
            // 메모리 초기화
            ImageDestroy($dst_img);
            ImageDestroy($src_img);
        }
    }
}

// byyeong 추가 
function GD2_make_thumb_x($max_x, $dst_name, $src_file) {
	//가로 사이즈만 지정하는 썸네일 생성.

    $img_info = @getimagesize($src_file);
	$sx = $img_info[0];
	$sy = $img_info[1];
	//썸네일 보다 큰가?
	if ($sx > $max_x) {
        $thumb_y = ceil(($sy * $max_x) / $sx);
        $thumb_x = $max_x;
	} else {
		$thumb_y = $sy;
		$thumb_x = $sx;
	}
	// JPG 파일인가?
	if (true) {
		$_dq_tempFile = basename($src_file);                                //파일명 추출
		$_dq_tempDir = str_replace($_dq_tempFile, "", $src_file);        //경로 추출
		$_dq_tempFile = $_dq_tempDir . $dst_name . $_dq_tempFile;        //경로 + 새 파일명 생성

		$_create_thumb_file = true;
		if (file_exists($_dq_tempFile)) { //섬네일 파일이 이미 존제한다면 이미지의 사이즈 비교
			$old_img = @getimagesize($_dq_tempFile);
			if ($old_img[0] != $thumb_x)
			$_create_thumb_file = true; 
                        else
			$_create_thumb_file = false;
			if ($old_img[1] != $thumb_y)
			$_create_thumb_file = true; 
                        else
			$_create_thumb_file = false;
		}
		if ($_create_thumb_file) {
			// 복제
			$src_img = ImageCreateFromAnything($src_file);
			$dst_img = ImageCreateTrueColor($thumb_x, $thumb_y);

            if(($img_info[2] == 1) OR ($img_info[2]==3)){
                imagealphablending($dst_img, false);
                imagesavealpha($dst_img,true);
                $transparent = imagecolorallocatealpha($dst_img, 255, 255, 255, 127);
                imagefilledrectangle($dst_img, 0, 0, $thumb_x, $thumb_y, $transparent);
            }

			ImageCopyResampled($dst_img, $src_img, 0, 0, 0, 0, $thumb_x, $thumb_y, $sx, $sy);
			switch ($img_info[2]) {
			  case 1: imagegif($dst_img,$_dq_tempFile); break;
			  case 2: imagejpeg($dst_img,$_dq_tempFile);  break;
			  case 3: imagepng($dst_img,$_dq_tempFile); break;
			  default:  Imagejpeg($dst_img, $_dq_tempFile, 100);  break;
			 }

			// 메모리 초기화
			ImageDestroy($dst_img);
			ImageDestroy($src_img);
		}
	}
}

function trans_date_ago($_date) {
    //$_date="2010-02-16 13:56:00";
    $phpdate = strtotime($_date);
    $curt_time = time();

    $fancy_s = $curt_time - $phpdate;
    $fancy_h = (int) $fancy_s / 60 / 60;

    $date_form = " Y.m.d a g:i";

    $ck = date("a", $phpdate);

    if ($fancy_h > 24) {

        $trdate = date($date_form, $phpdate);

        $kr_a = '오전';
        if ($_SESSION["tf_lang"] == 'ja') $kr_a = '午前';

        if($ck=='pm') {
            $kr_a = '오후';
            if ($_SESSION["tf_lang"] == 'ja') $kr_a = '午後';

        }else{
            $ck=='am';
        }

        $trdate = str_replace($ck, $kr_a, $trdate);

    } else {
        $trdate = fancy_time($fancy_s);
    }

    return $trdate;
}

function fancy_time($sec) {
    if ($sec > 60) {
        $min = (int) ($sec / 60);
        $sec = $sec - $min * 60;

        if ($min > 60) {
            $hr = (int) ($min / 60);
            $min = $min - $hr * 60;
            
            return $hr . " 시간 " . $min . " 분전";
        } else {

            return $min . " 분전";
        }
    } else {

        return "지금 막";
    }
}

function timeDiff($_sdate, $_edate, $_min = '') {
    //$_date="2010-02-16 13:56:00";
    $phpdate = strtotime("2010-02-16 ".$_sdate);
    $curt_time = strtotime("2010-02-16 ".$_edate);

    $fancy_s = $curt_time - $phpdate;

    $trdate = (int) ($fancy_s / 60);
    if ($_min) $trdate = $trdate / 60;

    return $trdate;
}


function dateDiff($date1, $date2, $ex){ 
    $_date1 = explode($ex,$date1); 
    $_date2 = explode($ex,$date2);
    $tm1 = mktime(0,0,0,$_date1[1],$_date1[2],$_date1[0]); 
    $tm2 = mktime(0,0,0,$_date2[1],$_date2[2],$_date2[0]);
    
    return ($tm1 - $tm2) / 86400;
}

function datetimeDiff($date1, $date_1, $date2, $ex){ 

    $_date1 = explode($ex, $date1);
    $_time1 = explode(":", $date_1);

    $d2 = explode(" ", $date2);
    $_date2 = explode($ex, $d2[0]);
    $_time2 = explode(":", $d2[1]);
    $tm1 = mktime($_time1[0],$_time1[1],0,$_date1[1],$_date1[2],$_date1[0]); 
    $tm2 = mktime($_time2[0],$_time2[1],0,$_date2[1],$_date2[2],$_date2[0]);
    
    return ($tm1 - $tm2) / 86400;
}

function check_url($_ori, $_ch) {
//    echo strpos($_ori, 'http');
    if (substr_count($_ori, 'http://') || substr_count($_ori, 'https://')) {
        $res = $_ori;
    }else {
        $tmp = substr_count($_ori, $_ch);
        if ($tmp) {
            $res = 'http://'.$_ori;
        }
        else {
            $res = 'http://'.$_ch.$_ori;
        }
    }
    
    return $res;
}

function add_activity($_type, $_id, $_a_type = '', $_a_id = '', $_a_result = ''
            , $_msg = '', $_t_type = '', $_t_id = '', $_made = '')
{

    $act = load_model('Activity');
    //me
    $arr["com_type"] = $_type;
    $arr["com_id"] = $_id;
    $arr["act_type"] = $_a_type;
    $arr["act_id"] = $_a_id;
    $arr["act_result"] = $_a_result;
    $arr["target_type"] = $_t_type;
    $arr["target_id"] = $_t_id;
    $arr["is_made"] = $_made;
    $arr["msg"] = $_msg;
    $act->add($arr);

    $foller = load_model('Follow');
    $fo = $foller->get_folling_w_mem($_type, $_id, "m.public_act & 2 != 2");
    $len_fol = sizeof($fo);
    for ($i=0; $i<$len_fol; $i++) {
        $arr["com_type"] = 1;
        $arr["com_id"] = $fo[$i]["follower"];
        $arr["act_type"] = $_a_type;
        $arr["act_id"] = $_a_id;
        $arr["act_result"] = $_a_result;
        $arr["target_type"] = $_t_type;
        $arr["target_id"] = $_t_id;
        $arr["is_made"] = $_made;
        $arr["msg"] = $_msg;
        $act->add($arr);
    }

    if ($_msg) {
        if ($_a_type == 1) $mem = load_model('Members');
        if ($_a_type == 2) $mem = load_model('Startup');
        $arr2 = $mem->get($_a_id);
        $arr2["id"] = $_a_id;
        $arr2["last_edit"] = $_msg;
        $mem->add($arr2);
    }
    else {
        if ($_a_type == 1 && $_a_result == 0) {
            $mem = load_model('Members');
            
            if ($_t_type == 1) $_msg = "이벤트를 신청하였습니다.";
            if ($_t_type == 2) $_msg = "공유공간을 신청하였습니다.";
            if ($_t_type == 11) $_msg = "경진대회에 참가하였습니다.";
            $arr2 = $mem->get($_a_id);
            $arr2["id"] = $_a_id;
            $arr2["last_edit"] = $_msg;
            $mem->add($arr2);
        }
    }
}

function get_return_url($_url='', $_return_url='') {
    if (!$_return_url) {
        if ($_url) {
            $arr_temp = explode('/', $_url);
            $len = sizeof($arr_temp);
            $arr_return_url = array_slice($arr_temp, 3, $len);
            $return_url = implode('/', $arr_return_url);
            $return_url = '/' . $return_url;
        }

        if ($return_url == '/member/login' || $return_url == '/' || $return_url == '/member/register') {
            $return_url = '';
        }
    } else {
        $return_url = $_return_url;
    }

    return $return_url;
}

//원격에서 파일 가져오기
function remote_image_new($urlstr) {
    if(!preg_match("/^http(s)?:\/\//",$urlstr))
    {
        $urlstr = 'http://'.$urlstr;
    }

    return file_get_contents($urlstr);

}

//NOTE local image 저장
function image_save($file, $string) {
    $fp = @fopen($file, 'w');
    if (!$fp)
    echo $file;
    fwrite($fp, $string);
    fclose($fp);
}

function http_image_download($img, $id, $folder) {

    $file = remote_image_new($img);
    if(!$file || gettype($file)=="array") //이미지는 있는데 통신 에러로 이미지가 오지 않는다면
    {
        return false;
    }
    else
    {
        $file_ext = strtolower(substr($img, strrpos($img, '.') + 1));
        $real_url = 'media/'.$folder.'/' .$id . '.' .$file_ext;
        image_save($settings->upload_path .$real_url, $file);

        return "/".$real_url;
    }

}

function get_contents_category() {
    $con = load_model('Content_category');
    $list = $con->list_(1, 100, 'hidden = 0');
    
    return $list;
}

function email_valid($temp_email) { 
    return ereg("^[0-9a-zA-Z_-]+(\.[0-9a-zA-Z_-]+)*@[0-9a-zA-Z_-]+(\.[0-9a-zA-Z_-]+)+$", $temp_email);
} 

function parse_html($org)
{
    $ret = array();

    $phase = 0;
    $current = "";

    for ($i=0;$i<strlen($org);$i++)
    {
        $ch = substr($org,$i,1);

        if ($phase == 0)
        {// 태그 바깥(기본)
            if ($ch == "<")
            {// 태그 열기
                if ($current)
                    $ret[] = $current;

                $current = $ch;
                $phase = 1;
                continue;
            }
        }
        else if ($phase == 1)
        {
            if ($ch == ">")
            {// 태그 닫기
                $ret[] = $current . $ch;
                $current = "";
                $phase = 0;
                continue;
            }
            else if ($ch == "'")
            {// 작은따옴표
                $phase = 21;
            }
            else if ($ch == "\"")
            {// 작은따옴표
                $phase = 31;
            }
        }
        else if ($phase == 21)
        {// 작은따옴표 안
            if ($ch == "'")
            {// 작은따옴표
                $phase = 1;
            }
        }
        else if ($phase == 31)
        {// 큰따옴표 안
            if ($ch == "\"")
            {// 큰따옴표
                $phase = 1;
            }
        }

        $current = $current . $ch;

    }

    $ret[] = $current;

    return $ret;
}


function tag_barase($oorg)
{
    $ret = array();
    $org = strtolower($oorg);
    $pos = 1;
    $phase = 0;
    $tag_name = "";
    $cnt = 0;
    while ($pos < strlen($org))
    {
        $cnt = $cnt+ 1;
        if ($cnt > 1000) break;
        $ch = substr($org,$pos,1);

        if ($phase == 0 && $ch != " " && $ch != ">")
        {
            $tag_name = $tag_name . $ch;
            $pos++;
            continue;
        }
        else if ($ch == " " || $ch == ">" || $ch == "/")
        {
            $phase=1;
            $pos++;
            continue;
        }
        else
        {
            $pos1 = strpos($org, "=", $pos);
            $pos2 = strpos($org, "\"", $pos1);
            $pos3 = strpos($org, "\"", $pos2 + 1);

            $pos21 = strpos($org, "'", $pos1);
            $pos31 = strpos($org, "'ch", $pos2 + 1);

            if ((!$pos2) || ($pos21 > -1 && $pos21 < $pos2))
            {
                $pos2 = $pos21;
                $pos3 = $pos31;
            }

            if (!$pos2 || !$pos3)
            {
                break;
            }

            $tname = substr($org,$pos, $pos1 - $pos);
            $tvalue = substr($oorg,$pos2 + 1, $pos3 - $pos2 - 1);
            $ret[$tname] = $tvalue;
            $pos = $pos3 + 1;


        }
    }
    $ret["tag_"] = $tag_name;

    return $ret;

}

function get_value_in_arr($_arr, $_key)
{
	$len = sizeof($_arr);
	$val = "";
	for ($i=0; $i<$len; $i++) {
		$val = $val.",".$_arr[$i][$_key];
	}

	return substr($val, 1);
}

function set_sns_len_post( $_con, $_url, $_cont_len ) {

    $_con = remove_url( $_con, '' );
    $_con = strip_tags( $_con );

    $con_len = mb_strlen( $_con, "UTF-8" );
    $url_len = strlen( $_url );
    $ck_len = $con_len + $url_len;

    if( $ck_len > $_cont_len ){

        $want_con_len = $_cont_len - $url_len;
        $_con = cut_multi($_con, $want_con_len - 1);

    }

    return $_con.' '.$_url;
}

function remove_url( $_content ,$_replacement){

    $pattern = "/(http|https|ftp|mms):\/\/[0-9a-z-]+([\._0-9a-z-]+)+(:[0-9]{2,4})?\/?"; // domain+port
    $pattern .= "([\.~_0-9a-z-\x{1100}-\x{11FF}\x{3130}-\x{318F}\x{AC00}-\x{D7AF}]+\/?)*"; // sub roots
    $pattern .= "(\S+\.[_0-9a-z]+)?"; // file & extension string
    $pattern .= "(\?[_0-9a-z#%&;,=\-\+]+)*"; // parameters
    $pattern .= '/iu';

    $content = preg_replace($pattern, $_replacement, $_content, -1);

    return $content;
}

function check_http($_ori) {
    if (strstr($_ori, 'http://') || strstr($_ori, 'https://')) {
        $res = $_ori;
    }else {
        $res = "http://".$_ori;
    }
    
    return $res;
}

function explode_ext($_ori, $_pattern) {
    $res = $_ori;
    if (strstr($_ori, $_pattern)) {
        $tmp = explode("(", $_ori);
        $res = $tmp[0];
    }
    
    return $res;
}

function check_media($_url) {
    if (substr($_url, 0, 6) == "/media") {
        $_url = "http://dcamp.kr".$_url;
    }
    return $_url;
}

function bottom_main()
{
    $main = load_model("Main")->list_("", "type > 0 and type != 3 and type != 4");
    for ($m=0; $m<sizeof($main); $m++) {
        if ($main[$m]["type"] == 1) {
            $main[$m] = load_model("Event")->get_detail($main[$m]["cid"]);
            if ($main[$m]) {
                $main[$m]["cat"] = "event";
            }
            else {
                $main[$m]["cat"] = "";
            }
        }
        else if ($main[$m]["type"] == 2) {
            $main[$m] = load_model("Notice")->get_detail($main[$m]["cid"], 1);
            if ($main[$m]) {
                $main[$m]["cat"] = "notice";
            }
            else {
                $main[$m]["cat"] = "";
            }
        }
        else if ($main[$m]["type"] == 5) {
            $main[$m] = load_model("Content")->get($main[$m]["cid"]);
            if ($main[$m]) {
                $main[$m]["cat"] = "content";
            }
            else {
                $main[$m]["cat"] = "";
            }
        }
        else if ($main[$m]["type"] == 7) {
            $main[$m] = load_model("Competitions")->get($main[$m]["cid"]);
            if ($main[$m]) {
                $main[$m]["cat"] = "competition";
            }
            else {
                $main[$m]["cat"] = "";
            }
        }
        else if ($main[$m]["type"] == 8) {
            $main[$m] = load_model("Office_hours")->get($main[$m]["cid"]);
            $main[$m]["u"] = load_model("Members")->get($main[$m]["mid"]);
            if ($main[$m]) {
                $main[$m]["cat"] = "office";
            }
            else {
                $main[$m]["cat"] = "";
            }
        }
        else if ($main[$m]["type"] == 10) {
            $main[$m] = load_model("Program")->get($main[$m]["cid"]);
            $main[$m]["u"] = load_model("Members")->get($main[$m]["user_id"]);
            if ($main[$m]) {
                $main[$m]["cat"] = "benefits";
            }
            else {
                $main[$m]["cat"] = "";
            }
        }
    }
    # new
    if ($_opt) {
        $l_main = sizeof($main);
        if ($l_main < $_opt) {
            $tt = 0;
            for ($t=$l_main; $t<$_opt; $t++) {
                $main[$t] = $main[$tt];
                $tt++;
                if ($tt == $l_main) $tt = 0;
            }
        }
        else {
            $main = array_slice($main, 0, $_opt);
        }
    }
    
    return $main;
}
?>