<?

/*

    TF External Apps
    Name: td_db_session
    Author: Binseop Ko
    Description: DB session 핸들러 V0.8 용
    
    Version: 2011-06-23
    VersionMin: 0.8.0
    VersionMax: -
    
    History
    2011-06-23 v0.8 용으로 수정
    2010-01-13 최초작성
    
    주의사항:
        1. 반드시 bootstrap_apps 중 가장 최상단에 불려져야 함
        2. 다음의 테이블이 작성되어 있어야 함.
            CREATE TABLE `sessions` (
              `session_id` varchar(32) NOT NULL DEFAULT '',
              `date_created` datetime DEFAULT '0000-00-00 00:00:00',
              `session_expiration` datetime DEFAULT '0000-00-00 00:00:00',
              `session_data` longtext CHARACTER SET utf8,
              PRIMARY KEY (`session_id`)
            ) ENGINE=MyISAM DEFAULT CHARSET=latin1


*/

session_set_save_handler("on_session_start",   "on_session_end",
			"on_session_read",    "on_session_write",
			"on_session_destroy", "on_session_gc");

$db_sess = mysql_connect($trail->_settings->DB_SESSION_SETTINGS["SERVER"],$trail->_settings->DB_SESSION_SETTINGS["ID"],$trail->_settings->DB_SESSION_SETTINGS["PW"]);
mysql_select_db($trail->_settings->DB_SESSION_SETTINGS["DB"], $db_sess);

function on_session_start($save_path, $session_name) {
	error_log($session_name . " ". session_id());
}

function on_session_end() {
	// Nothing needs to be done in this function
	// since we used persistent connection.
}

function on_session_read($key) {
    global $db_sess;
	$stmt = "select session_data from sessions ";
	$stmt .= "where session_id ='$key' ";
	$stmt .= "and session_expiration > now()";
	$sth = mysql_query($stmt, $db_sess);

	if($sth)
	{
		$row = mysql_fetch_array($sth);
		return($row['session_data']);
	}
	else
	{
		return $sth;
	}
}
function on_session_write($key, $val) {
    global $db_sess;
	$val = addslashes($val);
	$insert_stmt  = "insert into sessions (session_id, session_data, session_expiration) values('$key', ";
	$insert_stmt .= "'$val',date_add(now(), interval 1 hour))";

	$update_stmt  = "update sessions set session_data ='$val', ";
	$update_stmt .= "session_expiration = date_add(now(), interval 1 hour) ";
	$update_stmt .= "where session_id ='$key'";
	
	$a = mysql_query("select session_id from sessions where session_id = '$key' limit 1", $db_sess);
	if (mysql_fetch_array($a))
	{
		mysql_query($update_stmt, $db_sess);
	}
	else
	{
		mysql_query($insert_stmt, $db_sess);
	}
}

function on_session_destroy($key) {
    global $db_sess;
	mysql_query("delete from sessions where session_id = '$key'", $db_sess);
}

function on_session_gc($max_lifetime) 
{
	mysql_query("delete from sessions where unix_timestamp(session_expiration) < unix_timestamp(now())");
}
	
    	    

session_start();


?>