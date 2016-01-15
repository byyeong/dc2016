<!doctype html>
<html>
<head>
<meta charset="utf-8">
<style></style>
</head>

<body>
<table width="100%" cellspacing="0" cellpadding="0" border="0">
    <tr>
        <td><table width="100%" align="center"  cellspacing="0" cellpadding="0" border="0"  style="max-width:600px; margin:0 auto; ">
                <tr>
                    <td align="left" valign="middle"><a href="http://dcamp.kr" target="_blank"><img src="http://dcamp.kr/img/logo.png" style="width: 24px"></a></td>
                    <td align="right" valign="middle"><a href="http://dcamp.kr" target="_blank"><img src="http://dcamp.kr/img/logo-txt-trans.png"></a></td>
                </tr>
            </table></td>
    </tr>
</table>
<table width="100%" cellspacing="10" cellpadding="0" border="0" style="background-color: #f6f6f6; border-top:2px solid #eee; font-size:12px; font-family: 'Malgun Gothic', Arial, sans-serif;  ">
    <tr>
        <td><table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0" style="max-width:600px; margin:0 auto; ">
                <!-- S -->
                <tr>
                    <td style="padding:20px 0;"> 
                        
                        <h4 style="font-size:16px; font-weight:bold;  color:#666;  text-align: center; margin-top:0;">{res.name}님의 글에 {wr.name}님이 댓글을 달았습니다.</h4>
                        
                        <table  width="100%" cellspacing="20" cellpadding="0" border="0" style="background-color: #fff; font-size:12px;  border:1px solid #eee; border-radius: 4px;
    -moz-border-radius: 4px;  -webkit-border-radius: 4px; -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);    -moz-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);   box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05); ">
                            <tr>
                                <td>
                                    <!-- post -->
                                    <table  width="100%" cellspacing="10" cellpadding="0" border="0" >
                                        <tr>
                                            <td width="40" valign="top"><img src="{? preg_match("/^http(s)?:\/\//",res.picture)}{res.picture}{:}http://dcamp.kr{res.picture}{/}" style="width:40px; height:40px;"></td>
                                            <td valign="top"><strong style=" font-size:16px; margin-top:0; margin-bottom: 10px;">{res.name}</strong>
                                                <p>{res.contents}</p>
                                        </tr>
                                    </table> 
                                    {? com}
                                    <!-- reply -->
                                    <table  width="100%" cellspacing="10" cellpadding="0" border="0" style="border-top:1px dashed #eee;">
                                        {@ com}
                                        <tr>
                                            <td width="10" valign="top"><small style="background-color:#666; padding: 1px 4px; font-size:9px; text-transform: uppercase; color:#fff; border-radius: 2px;
    -moz-border-radius: 2px;  -webkit-border-radius: 2px; ">re</small></td>
                                            <td width="40" valign="top"><img src="{? preg_match("/^http(s)?:\/\//", .picture)}{.picture}{:}http://dcamp.kr{.picture}{/}" style="width:40px; height:40px;"></td>
                                            <td valign="top"><strong style=" font-size:16px; margin-top:0; margin-bottom: 10px;">{.name}</strong>
                                                <p>{.contents}</p>
                                        </tr>
                                        {/}
                                    </table>
                                  <!-- / post -->
                                  {/}
                               </td>
                            </tr>
                        </table>
                        <p style="text-align: center; margin:20px 0 0;"> 
                            <a href="http://dcamp.kr/timeline/{url}" style="display: inline-block; font-size:12px; line-height:40px; padding:0 20px; background-color:#FF7800; color:#fff; border:1px solid #f75d00; border-radius: 4px;    -moz-border-radius: 4px;  -webkit-border-radius: 4px; -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);    -moz-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);   box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);  text-decoration: none;">글 보러가기 &rarr;</a>
                        </p>
                        
                        
                    </td>
                </tr>
                <!-- /E -->
                <tr>
                    <td style="padding: 20px; font-size: 11px; color:#999; border-top:1px solid #ddd;">
                        이 메일은 발신전용 주소로 보내졌습니다.<br>
                        이메일 수신을 원하지 않을 경우 수신 거부할 수 있으며 <a href="http://dcamp.kr/member/edit" style="color:#FF7800;">[알림 설정]</a>에서 수정이 가능합니다.<br><br>
                       <a href="http://dcamp.kr" target="_blank" style="color:#888; text-decoration: none;"> &copy; <strong>D.CAMP</strong> - 은행권청년창업재단 </a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>
