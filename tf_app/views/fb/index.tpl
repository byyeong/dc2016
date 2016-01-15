<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <script type="text/javascript">
        //<![CDATA[
        {? type === 'regist'}
        {? error}
        opener.error("fb");
        {:}
        {? fb}
        opener.recive_fb_info('{fb.name}', '{fb.email}', '{fb.picture}', '{fb.id}', '{fb.secret}');
        {/}
        {/}
        {/}
            
        {? type === 'step'}
        {? error}
        opener.recive_fb_info('{fb.id}', 1);
        {:}
        {? fb}
        opener.recive_fb_info('{fb.id}');
        {/}
        {/}
        {/}

        {? type === "public"}
        opener.submit_p_form2();
        {/}

        window.close();
        //]]>
        </script>

    </head>
    <body>
        
    </body>
</html>

