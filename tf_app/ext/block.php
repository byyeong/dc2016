<?
    
    if ('/' . $url != $settings->BLOCK_REDIR_ADDR && $settings->BLOCK_AVAIL)
    {
    
        if (array_key_exists($settings->BLOCK_COOKIE_KEY, $_COOKIE) && $_COOKIE[$settings->BLOCK_COOKIE_KEY] == $settings->BLOCK_COOKIE_VALUE)
        {
            
        }
        else
        {
            if ('/' . $url == $settings->BLOCK_REGISTER_ADDR)
            {
                if (array_key_exists('key', $_REQUEST) && $_REQUEST['key'] == $settings->BLOCK_QUESTION)
                {
                    setcookie($settings->BLOCK_COOKIE_KEY, $settings->BLOCK_COOKIE_VALUE,time() + $settings->BLOCK_TIME, '/');
                    print ('ok');
                    exit(0);
                }
                else
                {
                    print ('<form action=\'' . $settings->BLOCK_REGISTER_ADDR . '\' method=\'post\'>');
                    print ('key: ');
                    print ('<input type=\'text\' name=\'key\' /></form>');
                    print ('<input type=\'submit\' /></form>');
                    exit(0);
                }
            }
            else
            {
                Header ('Location: ' . $settings->BLOCK_REDIR_ADDR);
            }
        }
    }
    
    

?>