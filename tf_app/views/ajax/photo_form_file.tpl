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
        <link rel="stylesheet" href="/css/bootstrap.min.css">
        <script src="http://code.jquery.com/jquery.js"></script>
        <script src="/js/bootstrap.js"></script>
    </head>

    <body style="background-color:transparent;">

        <form action="/ajax/photo_form_file/{attr}/{size}" method="post" enctype="multipart/form-data" name="form_{attr}">
            {?old}
            <label for="inputVcard"><img id="{attr}_img" src="{old}" alt="" class="img-thumbnail" style="height: {h_size}px; {?w_size}width: {w_size}px; {/}cursor: pointer;"> </label>
            {:}
            <label for="inputVcard"><img id="{attr}_img" src="/img/common/{size}.png" alt="" class="img-thumbnail" style="height: {h_size}px; {?w_size}width: {w_size}px; {/}cursor: pointer;"> </label>
            {/}
            <input type="file" id="inputVcard" name="file" onchange="upload();" style="display:none;">
        </form>

<script type="text/javascript">
//<![CDATA[
function upload()
{
{*    document.frm_file.submit();*}
    var frm = $('form[name=form_{attr}]');
    frm.submit();
}

{?error_str}
parent.show_msg_fadeout('{error_str}');
{:}
	{? ret_file_name}
            $('#{attr}_img').attr('src', '{ret_file_name}');
            parent.photo_actions("{=safe_js(ret_file_name)}", '{attr}');
	{/}
{/}
//]]>
</script>
    </body>
</html>