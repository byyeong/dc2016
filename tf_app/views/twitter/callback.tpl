<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <script type="text/javascript">
        //<![CDATA[

        {? error}
        opener.recive_tw_info('{tw}', 1);
        {:}
        {? tw}
        opener.recive_tw_info('{tw}');
        {/}
        {/}

        window.close();
        //]]>
        </script>

    </head>
    <body>
        
    </body>
</html>

