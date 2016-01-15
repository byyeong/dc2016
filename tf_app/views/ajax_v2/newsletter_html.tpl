<div id="body" style="display: none;">
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<style></style>
</head>

<body>
    <table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0" bgcolor="#f6f6f6" style="font-size:12px; line-height:1.6; color:#555; font-family: 'Malgun Gothic', Arial, sans-serif; padding:30px;">
        <tr>
            <td>
                <table width="670" border="0" align="center" cellpadding="0" cellspacing="30" bgcolor="#FFFFFF">  
                    <tr>
                        <td style="border-bottom:3px solid #ff7800; padding-bottom:10px;"> 
                            <!-- header -->
                            <table width="100%" align="center"  cellspacing="0" cellpadding="0" border="0">
                                <tr>
                                    <td align="left" valign="middle">
                                        <a href="http://dcamp.kr" target="_blank">
                                            <img src="http://dcamp.kr/img/logo.png" style="width: 24px; vertical-align:middle;">
                                        </a> 
                                    </td>
                                    <td align="right" valign="bottom"><font style="color:#999; font-size:11px;">D.CAMP Newsletter : {res.date}</font></td>
                                </tr>
                            </table>
                            <!-- /header -->
                        </td>
                    </tr>
                    <tr>
                        <td>{res.body}</td>
                    </tr>
                    <tr>
                        <td style="border-top:1px solid #eee; padding-top:15px;"> 
                            {? conts}
                            <h3 style="color:#F60;  font-size:18px; margin-bottom:4px;">- What's New -</h3>
                            <!-- select content -->
                            <table {? sizeof(conts) > 2}width="100%"{:}{? sizeof(conts) == 2}width="446px"{:}{? sizeof(conts) == 1}width="223px"{/}{/}{/} cellspacing="5" cellpadding="10" border="0">
                                {@ conts}
                                {? .key_ % 3 == 0}<tr>{/}
                                    <td width="33.33%" valign="top" bgcolor="#f6f6f6">
                                        <a href="{.url}" style="display:block; width:197px; height:197px; no-repeat center; background-size:cover;">
                                            <img src="http://dcamp.kr{.pic}" style="width:100%;">
                                        </a>  
                                        <p style="margin-bottom:0;">
                                            {.category} <br>
                                            <a href="{.url}" style="font-weight:bold; text-decoration:none; color:#1155cc;">
                                                {.title}
                                            </a>
                                        </p>
                                    </td> 
                                {? .key_ % 3 == 2 || (sizeof(conts) == .key_ +1)}</tr>{/}
                                {/}
                            </table>
                            <!-- /select content -->
                            {/}

                            {? oh}
                            <h3 style="color:#F60;  font-size:18px; margin-bottom:4px;">- Office Hours -</h3>
                            <!-- select content -->
                            <table {? sizeof(oh) > 2}width="100%"{:}{? sizeof(oh) == 2}width="446px"{:}{? sizeof(oh) == 1}width="223px"{/}{/}{/} cellspacing="5" cellpadding="10" border="0">
                                {@ oh}
                                {? .key_ % 3 == 0}<tr>{/}
                                    <td width="33.33%" valign="top" bgcolor="#f6f6f6">
                                        <a href="{.url}" style="display:block; width:197px; height:197px; no-repeat center; background-size:cover;">
                                            <img src="http://dcamp.kr{.pic}" style="width:100%;">
                                        </a>  
                                        <p style="margin-bottom:0;">
                                            <a href="{.url}" style="font-weight:bold; text-decoration:none; color:#1155cc;">
                                                {.title}
                                            </a>
                                        </p>
                                    </td> 
                                {? .key_ % 3 == 2 || (sizeof(oh) == .key_ +1)}</tr>{/}
                                {/}
                            </table>
                            <!-- /select content -->
                            {/} 

                            {? ben}
                            <h3 style="color:#F60;  font-size:18px; margin-bottom:4px;">- Benefit -</h3>
                            <!-- select content -->
                            <table {? sizeof(ben) > 2}width="100%"{:}{? sizeof(ben) == 2}width="446px"{:}{? sizeof(ben) == 1}width="223px"{/}{/}{/} cellspacing="5" cellpadding="10" border="0">
                                {@ ben}
                                {? .key_ % 3 == 0}<tr>{/}
                                    <td width="33.33%" valign="top" bgcolor="#f6f6f6">
                                        <a href="{.url}" style="display:block; width:197px; height:197px; no-repeat center; background-size:cover;">
                                            <img src="{=check_media(.pic)}" style="width:100%;">
                                        </a> 
                                        <p style="margin-bottom:0;">
                                            <a href="{.url}" style="font-weight:bold; text-decoration:none; color:#1155cc;">
                                                {.title}
                                            </a>
                                        </p>
                                    </td> 
                                {? .key_ % 3 == 2 || (sizeof(ben) == .key_ +1)}</tr>{/}
                                {/}
                            </table>
                            <!-- /select content -->
                            {/} 

                            {? con}
                            <h3 style="color:#F60;  font-size:18px; margin-bottom:4px;">- Blog -</h3>
                            <!-- select content -->
                            <table {? sizeof(con) > 2}width="100%"{:}{? sizeof(con) == 2}width="446px"{:}{? sizeof(con) == 1}width="223px"{/}{/}{/} cellspacing="5" cellpadding="10" border="0">
                                {@ con}
                                {? .key_ % 3 == 0}<tr>{/}
                                    <td width="33.33%" valign="top" bgcolor="#f6f6f6">
                                        <a href="{.url}" style="display:block; width:197px; height:197px; no-repeat center; background-size:cover;">
                                            <img src="{=check_media(.pic)}" style="width:100%;">
                                        </a> 
                                        <p style="margin-bottom:0;">
                                            <a href="{.url}" style="font-weight:bold; text-decoration:none; color:#1155cc;">
                                                {.title}
                                            </a>
                                        </p>
                                    </td> 
                                {? .key_ % 3 == 2 || (sizeof(con) == .key_ +1)}</tr>{/}
                                {/}
                            </table>
                            <!-- /select content -->
                            {/} 

                            {? recr}
                            <h3 style="color:#F60; font-size:18px; margin-bottom:4px;"> - Recruit <small>: 여러분을 기다리고 있는 스타트업들을 만나보세요!</small> -</h3>
                            <!-- select content -->
                            <table width="100%" cellspacing="5" cellpadding="0" border="0">
                                {@ recr}
                                <tr>
                                    <td bgcolor="#f6f6f6">
                                        <table width="100%" cellspacing="10" cellpadding="0" border="0">
                                            <tr>
                                                <td width="64">
                                                    <a href="#" style="display:block; width:64px; height:64px; overflow:hidden; no-repeat center; background-size:cover;">
                                                        <img src="http://dcamp.kr{.logo}" style="width:100%;">
                                                    </a>
                                                </td>
                                                <td valign="top"> 
                                                    <p style="font-weight:bold; font-size-14px; display:block; margin-top:0; margin-bottom:3px;">
                                                        <a href="http://dcamp.kr/recruit/views/{.id}" style="text-decoration:none; color:#1155cc;" target="_blank">
                                                        {.title}
                                                        </a>
                                                    </p>  
                                                    {.sname} / 
                                                    채용기간 : {.start} ({=date_to_day_only(.start)}){?.end} ~ {.end} ({=date_to_day_only(.end)}){/} / 
                                                    {@ .inv}{? ..key_ == 0}{.._value}{:}, {.._value}{/}{/} / 
                                                    {@ .term}{? ..key_ == 0}{.._value}{:}, {.._value}{/}{/} 
                                                </td>
                                            </tr>
                                        </table>
                                    </td> 
                                </tr>
                                {/}
                            </table>
                            <!-- /select content -->
                            {/}
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>

</div>
<textarea id="textbody" style="width:100%; height:100%;"></textarea>
<script type="text/javascript">
    txt = "<!doctype html>"
        +"<html>"
        +"<head>" 
        + document.getElementById("body").innerHTML
        +"</body>"
        +"</html>";
    document.getElementById("textbody").value = txt;
</script>