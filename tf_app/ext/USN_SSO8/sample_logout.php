<?php
    // ·Î±×¾Æ¿ô »ùÇÃ
    
    session_start();
    include_once("USN_SSO.php");
    
    // SSO ·Î±×¾Æ¿ô
    USN_logout($_SESSION['userid']);
    
    // Orbit ·Î±×¾Æ¿ô
    unset($_SESSION['userid']);
    
    header("Location: /sso_sample/sample.php");

?>
