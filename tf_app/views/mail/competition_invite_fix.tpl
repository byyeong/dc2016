<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>D.CAMP &#8211; &#039;드림뱅크&#039; 은행권청년창업재단</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
</head>

<body>



<table width="100%" cellspacing="0" cellpadding="0" border="0">
    <tr>
        <td>
            <table width="100%" align="center"  cellspacing="0" cellpadding="0" border="0"  style="max-width:600px; margin:0 auto; ">
                <tr>
                    <td align="left" valign="middle"><a href="http://dcamp.kr" target="_blank"><img src="http://dcamp.kr/img/logo.png" style="width: 24px"></a></td>
                    <td align="right" valign="middle"><a href="http://dcamp.kr" target="_blank"><img src="http://dcamp.kr/img/logo-txt-trans.png"></a></td>
                </tr>
            </table>
        </td>
    </tr>
</table>            


<table width="100%" cellspacing="10" cellpadding="0" border="0" style="background-color: #f6f6f6; border-top:2px solid #eee; font-size:14px; font-family: 'Malgun Gothic', Arial, sans-serif; ">
    <tr>
        <td>
            <table width="100%" align="center"  cellspacing="0" cellpadding="0" border="0"  style="max-width:600px; margin:0 auto; ">
                <!-- S --> 
                <tr>
                    <td style="padding:20px 0;">
                        <h4 style="font-size:18px; font-weight:bold;  color:#666;  text-align: center; margin-top:0;">{? user}{user}님이 {/}경진대회 심사위원으로 최종 선정되었습니다.</h4>
                        
                        <table  width="100%" cellspacing="20" cellpadding="0" border="0" style="background-color: #fff;  border:1px solid #ddd; border-radius: 4px;
    -moz-border-radius: 4px;  -webkit-border-radius: 4px; -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);    -moz-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);   box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05); ">
                            <tr>
                                <td width="20%" align="right">경진대회 명 :</td>
                                <td width="80%" align="left"><strong>{res.subject}</strong></td>
                            </tr>
                            <tr>
                                <td align="right">주최/주관 기관 :</td>
                                <td align="left"><strong>{res.organized}</strong></td>
                            </tr>
                            <tr>
                                <td align="right">참가 접수 기간 :</td>
                                <td align="left"><strong>{=date_to_kr(res.date_s)} ~ {=date_to_kr(res.date_e)}</strong></td>
                            </tr>
                            <tr>
                                <td bgcolor="#f4f4f4" align="center" style="font-size:12px; color:#666;" colspan="2">초대 메일 주소로 로그인(또는 가입)을 하면 심사위원 권한이 자동등록됩니다.</td> 
                            </tr>
                        </table>  
                    </td>
                </tr>
                {? res.ex_notice}
                <tr>
                    <td style="padding: 10px; font-size: 14px;  color:#666; line-height:1.6;"> 
                        {=add_brs(res.ex_notice)}
                    </td>
                </tr>
                {/}
                <tr>
                    <td style="padding: 20px; text-align: center;">
                        <a href="http://dcamp.kr/challenge/views/{res.id}" style="display: inline-block;  font-size: 12px; line-height: 40px; padding:0 20px; background-color:#666; color:#fff; border:1px solid #555; border-radius: 4px;     -moz-border-radius: 4px;  -webkit-border-radius: 4px; -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);    -moz-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);   box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);  text-decoration: none;">경진대회 내용보기 &rarr;</a>
                    </td>
                </tr>
                <!-- /E --> 
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
