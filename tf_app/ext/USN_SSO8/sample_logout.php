<?php
    // �α׾ƿ� ����
    
    session_start();
    include_once("USN_SSO.php");
    
    // SSO �α׾ƿ�
    USN_logout($_SESSION['userid']);
    
    // Orbit �α׾ƿ�
    unset($_SESSION['userid']);
    
    header("Location: /sso_sample/sample.php");

?>
