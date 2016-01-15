<?

/*

    TF External Apps
    Name: tf_utils
    Author: Binseop Ko
    Description: Trail 에서 자주 사용되는 함수 묶음.
    
    Version: 2011-06-14
    VersionMin: 0.8.0
    VersionMax: -
    

*/
    

function load_ext_model($model_name, $model = null)
{
	global $trail;

    if (phpversion() >= "5.4")
    {
        $trail->_current_controller = new stdClass();
    }
	
	if ($model && !array_key_exists($model_name, $trail->_model_pool))
	{
		$trail->_model_pool[$model_name] = $model;
	}
	$trail->_current_controller->$model_name = $trail->_model_pool[$model_name];
    
	return $trail->_[$model_name];
}
    
function trans_url($_content, $_to_blank=false) {
	$pattern = "/(http|https|ftp|mms):\/\/[0-9a-z-]+([\._0-9a-z-]+)+(:[0-9]{2,4})?\/?"; // domain+port
	$pattern .= "([\.~_0-9a-z-\x80-\xff#!]+\/?)*"; // sub roots
	$pattern .= "(\S+\.[_0-9a-z]+)?"; // file & extension string
	$pattern .= "(\?[_0-9a-z#%&;=\-\+]+)*"; // parameters
	$pattern .= '/i';

	preg_match_all($pattern, $_content, $match);

	foreach ($match[0] as $value) {
		$trans_ampersand_value = trans_ampersand($value);
		$_content = str_replace($value, $trans_ampersand_value, $_content);
	}

	if ($_to_blank) {
		$replacement = "<a href='/?u=\\0'>\\0</a>";
	} else {
		$replacement = "<a href='\\0' target='_blank'>\\0</a>";
	}
	$content = preg_replace($pattern, $replacement, $_content, -1);

	return $content;
}



function trans_ampersand($_content) {
	$pattern = "([\&](?![amp;]))";
	//$pattern = "(\&+)";
	$replacement = "&amp;";

	$content = preg_replace($pattern, $replacement, $_content, -1);
	//return urlencode($content);

	return $content;
}


function load_model($model_name)
{
	global $trail;

	if (!array_key_exists($model_name, $trail->_model_pool))
	{
		include_once('../tf_app/models/' . $model_name . '.php');
		$model_classname = $model_name . '_model';
		
		$trail->_current_controller->$model_name = new $model_classname($trail->_settings);
		$trail->_model_pool[$model_name] = $trail->_current_controller->$model_name;
	}

	return $trail->_model_pool[$model_name];

}


function GD2_make_thumb($max_x, $max_y, $dst_name, $src_file) {
	$img_info = @getimagesize($src_file);
	$sx = $img_info[0];
	$sy = $img_info[1];
	//썸네일 보다 큰가?
	if ($sx > $max_x || $sy > $max_y) {
		if ($sx > $sy) {
			$thumb_y = ceil(($sy * $max_x) / $sx);
			$thumb_x = $max_x;
		} else {
			$thumb_x = ceil(($sx * $max_y) / $sy);
			$thumb_y = $max_y;
		}
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
			$_create_thumb_file = true; else
			$_create_thumb_file = false;
			if ($old_img[1] != $thumb_y)
			$_create_thumb_file = true; else
			$_create_thumb_file = false;
		}
		if ($_create_thumb_file) {
			// 복제
			$src_img = ImageCreateFromAnything($src_file);
			$dst_img = ImageCreateTrueColor($thumb_x, $thumb_y);
			ImageCopyResampled($dst_img, $src_img, 0, 0, 0, 0, $thumb_x, $thumb_y, $sx, $sy);
			Imagejpeg($dst_img, $_dq_tempFile, 100);
			// 메모리 초기화
			ImageDestroy($dst_img);
			ImageDestroy($src_img);
		}
	}
}


function make_upload($suburl, $file_id)
{
	$upload_file = "";
	$settings = new Settings();
	if (array_key_exists($file_id,$_FILES) && $_FILES[$file_id]["name"] != "")
	{
		$dir = $settings->upload_path.$suburl;
		$upload_file = $_FILES[$file_id]["tmp_name"];
		$ufn = htmlentities(urlencode(str_replace(" ","",$_FILES[$file_id]["name"])));
		$ufn = str_replace("%","",$ufn);
		$dest=$dir.$ufn;
		$pfx = 0;
		$ufn2 = $ufn;
		while(file_exists($dest))
		{
			$pfx++;
			$ufn = $pfx.$ufn2;
			$dest=$dir.$ufn;
		}
		move_uploaded_file($upload_file,$dest);
		if (file_exists($dest))
		{
			$upload_file = $ufn;
		}
		else
		$upload_file = "";

		return $upload_file;
	}

}


function remove_rn($org)
{
	$r =  str_replace("\r\n","",$org);
	$r = str_replace("\n","",$r);
	return $r;
}


function remove_tags($org)
{
	$org = str_replace("<","&lt;",$org);
	$org = str_replace(">","&gt;",$org);
	$org = str_replace(" ","&nbsp;",$org);
	return $org;
}

function remove_tags2($org)
{
    $org = str_replace("<","&lt;",$org); 
    $org = str_replace(">","&gt;",$org); 
    $org = str_replace("{","&#40;",$org); 
    $org = str_replace("}","&#41;",$org);
    $org = str_replace("#","&#35;",$org); 
    $org = str_replace("&","&#38;",$org);
    //$org = str_replace(" ","&nbsp;",$org); 
    return $org;
}

function add_brs($org)
{
	$org = str_replace("\n","<br />",$org);
	$org = str_replace("  ","&nbsp;&nbsp;",$org);
	return $org;
}

function safe_js($org)
{
	$org = str_replace("\n","\\n",$org);
	return $org;
}

function safe_js_editor($org)
{
	$org = str_replace("\r\n","",$org);
	$org = str_replace("\n","",$org);
	$org = str_replace("\"","\\\"",$org);
	return $org;
}

function get_paging_dot($page, $tot_count, $pagesize)
{
	$ret = array();

	$tot_page = floor(($tot_count-1) / $pagesize) + 1;

	$start = $page - 2;
	if ($start < 1) $start = 1;

	$ret = array();

	if ($start != 1)
	{
		$r = array();
		$r["page"] = 1;
		$r["type"] = "start";
		$ret[] = $r;

		if ($start != 2)
		{
			$r = array();
			$r["type"] = "dot";
			$ret[] = $r;
		}

	}

	if ($start > 5 && $start > $tot_page - 5)
	{
		$start = $tot_page - 4;
	}
	for ($i=$start;$i < $start + 5;$i++)
	{
		if ($i > $tot_page) break;

		$r = array();
		$r["page"] = $i;
		if ($page == $i)
		$r["type"] = "current";
		else
		$r["type"] = "normal";

		$ret[] = $r;
	}

	if ($i < $tot_page)
	{
		$r = array();
		$r["type"] = "dot";
		$ret[] = $r;

		$r = array();
		$r["page"] = $tot_page;
		$r["type"] = "end";
		$ret[] = $r;

	}
	else if ($i == $tot_page)
	{
		$r = array();
		$r["page"] = $tot_page;
		$r["type"] = "end";
		$ret[] = $r;

	}

	return $ret;
}

function get_paging_dot2($page, $tot_count, $pagesize)
{
    $ret = array();
    
    $tot_page = floor(($tot_count-1) / $pagesize) + 1;
    
    $start = $page - 2;
    if ($start < 1) $start = 1;
    
    $ret = array();

    if ($start != 1)
    {
        $r = array();
        $r["page"] = 1;
        $r["type"] = "start";
        $ret[] = $r;

        if ($start != 2)
        {
            $r = array();
            $r["type"] = "dot";
            $ret[] = $r;
        }
        
    }
    
    if ($start > 5 && $start > $tot_page - 5)
    {
        $start = $tot_page - 4;
    }
    for ($i=$start;$i < $start + 5;$i++)
    {
        if ($i > $tot_page) break;
        
        $r = array();
        $r["page"] = $i;
        if ($page == $i)
            $r["type"] = "current";
        else
            $r["type"] = "normal";
            
        $ret[] = $r;
    }

    if ($i < $tot_page)
    {
        $r = array();
        $r["type"] = "dot";
        $ret[] = $r;

        $r = array();
        $r["page"] = $tot_page;
        $r["type"] = "end";
        $ret[] = $r;
        
    }
    else if ($i == $tot_page)
    {
        $r = array();
        $r["page"] = $tot_page;
        $r["type"] = "end";
        $ret[] = $r;
        
    }
    
    $r = array();
    $r["pages"] = $ret;
    $r["tot_page"] = $tot_page;
    $r["tot_count"] = $tot_count;
    
    return $r;
}

function get_paging_dot3($page, $tot_count, $pagesize)
{
    $ret = array();
    
    $tot_page = floor(($tot_count-1) / $pagesize) + 1;
    
    $start = $page - 2;
    if ($start < 1) $start = 1;
    
    $ret = array();

    if ($start != 1)
    {
        $r = array();
        $r["page"] = 1;
        $r["type"] = "start";
        $ret[] = $r;

        if ($start != 2)
        {
            $r = array();
            $r["type"] = "dot";
            $ret[] = $r;
        }
        
    }
    
    if ($start > 3 && $start > $tot_page - 3)
    {
        $start = $tot_page - 2;
    }
    for ($i=$start;$i < $start + 3;$i++)
    {
        if ($i > $tot_page) break;
        
        $r = array();
        $r["page"] = $i;
        if ($page == $i)
            $r["type"] = "current";
        else
            $r["type"] = "normal";
            
        $ret[] = $r;
    }

    if ($i < $tot_page)
    {
        $r = array();
        $r["type"] = "dot";
        $ret[] = $r;

        $r = array();
        $r["page"] = $tot_page;
        $r["type"] = "end";
        $ret[] = $r;
        
    }
    else if ($i == $tot_page)
    {
        $r = array();
        $r["page"] = $tot_page;
        $r["type"] = "end";
        $ret[] = $r;
        
    }
    
    $r = array();
    $r["pages"] = $ret;
    $r["tot_page"] = $tot_page;
    $r["tot_count"] = $tot_count;
    
    return $r;
}

/**
 * 변수의 구성요소를 리턴받는다.
 */
function get_printr ($var, $title = NULL, $style = NULL, $title_style = NULL) {

    if( ! $style){
        $style = "background-color:#000; color:#00ff00; padding:5px; font-size:14px; margin: 5px 0";
    }

    if( ! $title_style){
        $title_style = "color:#fff";
    }

    $dump = '';
    $dump .= '<div style="text-align: left;">';
    $dump .= "<pre style='$style'>";
    if ($title) {
        $dump .= "<strong style='{$title_style}'>{$title} :</strong> \n";
    }
    if($var === null){
        $dump .= "`null`";
    }else if($var === true){
        $dump .= "`(bool) true`";
    }else if($var === false){
        $dump .= "`(bool) false`";
    }else{
        $dump .= print_r($var, TRUE);
    }
    $dump .= '</pre>';
    $dump .= '</div>';
    return $dump;
}

/**
 * 변수의 구성요소를 출력한다.
 */
function printr ($var, $title = NULL, $style = NULL, $title_style = NULL) {
    $dump = get_printr($var, $title, $style, $title_style);
    echo $dump;
}

/**
 * 변수의 구성요소를 출력하고 멈춘다.
 */
function printr2 ($var, $title = NULL, $style = NULL, $title_style = NULL) {
    printr($var, $title,  $style, $title_style);
    exit;
}

/**
 * printr은 임시로 쓰고 지우는 놈인데 이놈은 코드 안에 남겨 둘 생각으로 만든 놈.
 * @param $var
 * @param null $title
 */
function debug_print($var, $title = NULL)
{
    $style = "background-color: #ddd; color: #000; padding: 5px; font-size: 14px; margin: 5px 0";
    $title_style = "color: darkred;";
    printr($var, $title, $style, $title_style);
}

function get_debug_print($var, $title = NULL)
{
    $style = "background-color: #ddd; color: #000; padding: 5px; font-size: 14px; margin: 5px 0";
    $title_style = "color: darkred;";
    return get_printr($var, $title, $style, $title_style);
}
/*
 * 특정키의 특정값이 일치하는 배열을 찾아 리턴한다.
 * */
function search($array, $key, $value)
{
    $results = array();

    if (is_array($array)) {
        if (isset($array[$key]) && $array[$key] == $value) {
            $results[] = $array;
        }

        foreach ($array as $subarray) {
            $results = array_merge($results, search($subarray, $key, $value));
        }
    }

    return $results;
}

class Tf_utils extends Controller
{
    function static_pages($tpl_folder, $tpl_name, $layout_folder = "", $layout = "")
    {
        $this->tpl_name = "//" . $tpl_folder . "/" . $tpl_name;
        if ($layout_folder)
            $this->layout = "//" . $layout_folder . "/" . $layout;
        
        
    }
    
}



?>