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
            <table width="100%" cellspacing="0" cellpadding="0" border="0" align="center" style="max-width:600px; margin:0 auto; ">
                <tr>
                    <td align="left" valign="middle"><a href="http://dcamp.kr" target="_blank"><img src="http://dcamp.kr/img/logo.png" style="width: 24px"></a></td>
                    <td align="right" valign="middle"><a href="http://dcamp.kr" target="_blank"><img src="http://dcamp.kr/img/logo-txt-trans.png"></a></td>
                </tr>
            </table>
        </td>
    </tr>
</table>            


<table width="100%" cellspacing="10" cellpadding="0" border="0" style="background-color: #f6f6f6; border-top:2px solid #eee; font-size:12px; font-family: 'Malgun Gothic', Arial, sans-serif; ">
    <tr>
        <td>
            <table width="100%" cellspacing="0" cellpadding="0" border="0" align="center" style="max-width:600px; margin:0 auto; "> 
                <!-- S -->
                <!--
                <tr>
                    <td style="color:#999; text-align: center;"> 
                        <h3 style="text-transform: uppercase; font-weight:bold; font-family: 'Malgun Gothic', 'open sans', Arial, sans-serif;  font-size: 40px; margin:0 0 8px;">Event</h3>
                        <font style="font-size: 12px;">D.CAMPER 여러분이 꼭 알아야할 스타트업 관련 이벤트를 공유합니다.</font>
                     </td>
                </tr> 
                -->
                <tr>
                    <td style="padding: 20px 0;"> 
                        <h4 style="font-size: 16px; font-weight:bold; text-align: center; color:#666; margin-top:0;" ><span style="color:#428BCA;">{res.title}</span>, 곧 시작됩니다. 실시간으로 질문하고 사람들과 이야기를 나누세요.</h4>
                        
                        <table  width="100%" cellspacing="20" cellpadding="0" border="0" style="background-color: #fff; font-size:12px;  border:1px solid #ddd; border-radius: 4px;
    -moz-border-radius: 4px;  -webkit-border-radius: 4px; -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);    -moz-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);   box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05); ">
                            <tr>
                                <td width="20%" align="right">이벤트 명 :</td>
                                <td width="80%" align="left"><strong>{res.title}</strong></td>
                            </tr>
                            <tr>
                                <td align="right">장소 :</td>
                                <td align="left"><strong>{? res.space_id == 0}{res.space_etc}{:}{res.opt}F {res.sname}{/}</strong></td>
                            </tr>
                            <tr>
                                <td align="right">일시 :</td>
                                <td align="left"><strong>{?res.date}{=date_to_kr(res.date)} {=date_to_day(res.date)} {? res.start}{=date_to_time(res.start)}{/}{/} {?res.date_e}~ {=date_to_kr(res.date_e)} {=date_to_day(res.date_e)} {? res.end}{=date_to_time(res.end)}{/}{/}</strong></td>
                            </tr>
                        </table>   
                                             
                        <p style="text-align: center; margin:20px 0 0;"> <a href="http://dcamp.kr/lounge/event/{res.id}" style="display: inline-block; font-size:12px; line-height:1; padding:14px 20px; background-color:#FF7800; color:#fff; border:1px solid #f75d00; border-radius: 4px;    -moz-border-radius: 4px;  -webkit-border-radius: 4px; -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);    -moz-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);   box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);  text-decoration: none;">D.CAMP Lounge 에서 실시간으로 질문하고, 이야기를 나누세요! &rarr;</a></p>
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
