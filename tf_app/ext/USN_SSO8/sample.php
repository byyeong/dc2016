<?php

    // 로그인 및 정보 가져오기 샘플
    session_start();
    include_once("USN_SSO.php");
    
    
    if (array_key_exists("userid", $_SESSION) && $_SESSION["userid"] != "")
    {
?>
    <?=$_SESSION["userid"]?>로 로그인 되었습니다. <br />
    <a href="./sample_logout.php">로그아웃하기</a><br /><br />
<?
    }
    else
    {
        
?>
    로그인이 되지 않았습니다
    <a href="<?=USN_get_login_url()?>">로그인 하기</a><br /><br />
<?
    }


    // 정보 가져오기 샘플
    
    $uinfo = USN_get_info("hi8ar");
    
    if ($uinfo == "403")
    {
        print ("사용자 정보 가져오기 테스트 - 인증의 실패");
    }
    elseif ($uinfo == "404")
    {
        print ("사용자 정보 가져오기 테스트 - 그런 사용자는 없어요");
    }
    else
    {
        print ("<br/>".$uinfo["userid"]."님의 이메일은 ".$uinfo["email"]."입니다");
    }

?>


<br/><br/><?USN_iframe();?>