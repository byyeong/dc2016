<?php

    // �α��� �� ���� �������� ����
    session_start();
    include_once("USN_SSO.php");
    
    
    if (array_key_exists("userid", $_SESSION) && $_SESSION["userid"] != "")
    {
?>
    <?=$_SESSION["userid"]?>�� �α��� �Ǿ����ϴ�. <br />
    <a href="./sample_logout.php">�α׾ƿ��ϱ�</a><br /><br />
<?
    }
    else
    {
        
?>
    �α����� ���� �ʾҽ��ϴ�
    <a href="<?=USN_get_login_url()?>">�α��� �ϱ�</a><br /><br />
<?
    }


    // ���� �������� ����
    
    $uinfo = USN_get_info("hi8ar");
    
    if ($uinfo == "403")
    {
        print ("����� ���� �������� �׽�Ʈ - ������ ����");
    }
    elseif ($uinfo == "404")
    {
        print ("����� ���� �������� �׽�Ʈ - �׷� ����ڴ� �����");
    }
    else
    {
        print ("<br/>".$uinfo["userid"]."���� �̸����� ".$uinfo["email"]."�Դϴ�");
    }

?>


<br/><br/><?USN_iframe();?>