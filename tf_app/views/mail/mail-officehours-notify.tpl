<!doctype html>
<html>
<head>
<meta charset="utf-8">
<style></style>
</head>

<body>



<table width="100%" cellspacing="0" cellpadding="0" border="0">
    <tr>
        <td>
            <table width="100%" align="center"  cellspacing="0" cellpadding="0" border="0"  style="max-width:600px; margin:0 auto; ">
                <tr>
                    <td align="left" valign="middle"><a href="http://dcamp.kr" target="_blank"><img src="../img/logo.png" style="width: 24px"></a></td>
                    <td align="right" valign="middle"><a href="http://dcamp.kr" target="_blank"><img src="../img/logo-txt-trans.png"></a></td>
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
                        <h4 style="font-size:18px; font-weight:bold;  color:#666;  text-align: center; margin-top:0;">
                        {title}
                        </h4>
                        
                        <table  width="100%" cellspacing="20" cellpadding="0" border="0" style="background-color: #fff;    border:1px solid #ddd; border-radius: 4px;
    -moz-border-radius: 4px;  -webkit-border-radius: 4px; -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);    -moz-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);   box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05); ">
                            <tr>
                                <td width="20%" align="right">Office Hours :</td>
                                <td width="80%" align="left"><strong>Office Hours with {m.department} {m.name} {m.position} @{oh.place}({=date_to_kr(oh.e_start)})</strong></td>
                            </tr>
                            <tr>
                                <td align="right">주최/주관 기관 :</td>
                                <td align="left"><strong>{oh.hosted}</strong></td>
                            </tr>
                            <tr>
                                <td align="right">참가기간 :</td>
                                <td align="left"><strong>{=substr(oh.e_start, 0, 10)} ({=date_to_day_only(oh.e_start)}) {=substr(oh.e_start, 11)} ~ {=substr(oh.e_end, 0, 10)} ({=date_to_day_only(oh.e_end)}) {=substr(oh.e_end, 11)}</strong></td>
                            </tr>
                            <tr>
                                <td align="right">접수기간 :</td>
                                <td align="left"><strong>{=substr(oh.a_start, 0, 10)} ({=date_to_day_only(oh.a_start)}) {=substr(oh.a_start, 11)} ~ {=substr(oh.a_end, 0, 10)} ({=date_to_day_only(oh.a_end)}) {=substr(oh.a_end, 11)}</strong></td>
                            </tr>
                            <tr>
                                <td align="right">발표일자 :</td>
                                <td align="left"><strong>{=substr(oh.r_date, 0, 10)} ({=date_to_day_only(oh.r_date)}) {=substr(oh.r_date, 11)}</strong></td>
                            </tr> 
                        </table>  
                                             
                        <p style="text-align: center; margin:20px 0 0;"> <a href="http://dcamp.kr/office_hours/views/{oh.id}" style="display: inline-block;   line-height: 40px; padding:0 20px; background-color:#FF7800; color:#fff; border:1px solid #f75d00; border-radius: 4px;     -moz-border-radius: 4px;  -webkit-border-radius: 4px; -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);    -moz-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);   box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);  text-decoration: none;">Office Hours 보러가기 &rarr;</a></p>
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
