<!DOCTYPE html>
<html lang="{current_lang}">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta http-equiv="imagetoolbar" content="no" />
        <title>{"사진 업로드"}</title>
        <style type="text/css">
            * { margin:0;padding:0; }
        </style>
    </head>

    <body>

        <form action="/ajax/photo_form_file" method="post" enctype="multipart/form-data" name="frm_file">
            {?option=="now"}
            <input type="file" class="fileUp" onchange="upload();" name="file" size="20" />
            <input type="hidden" name="option" value="now" />
            {:}
            <input type="file" class="fileUp" onchange="upload();" name="file" size="20" />
            {/}
        </form>

<script type="text/javascript">
//<![CDATA[
function upload()
{
    document.frm_file.submit();
}

{?error_str}
parent.show_msg_fadeout('{error_str}');
{:}
	{? ret_file_name}
	   parent.photo_actions("{=safe_js(ret_file_name)}");
	{/}
{/}
//]]>
</script>

    </body>
</html>