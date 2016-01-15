<!doctype html>
<html>
<head>
<meta charset="utf-8">
</head>

<body>


<table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">
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
                        <h4 style="font-size:18px; font-weight:bold;  color:#666;  text-align: center; margin-top:0;">
                        {res.name}님, Office Hours 상담 대상으로 선정되셨습니다.
                        </h4>
                        <p style="border-top:1px solid #ddd; padding-top:20px;">
                            안녕하세요. D.CAMP입니다.
                            <br><br>

                            <strong>{=date_to_kr(oh.e_start)} ({=date_to_day_only(oh.e_start)})</strong> 진행되는 <strong>Office hours with {m.department} {m.name} {m.position}와(과)의 1:1 집중 상담</strong>에 선정되신 것을 축하드립니다. 
                            <br>
                            본 상담은 {=date_to_time(oh.start)}부터 {oh.ing}분 씩 진행되며, 원활한 상담 진행을 위해 최소 10분 전에는 도착하여 상담을 준비해 주시면 감사하겠습니다. 
                            <br><br>

                            * 본 메일을 확인하신 후에는 아래 링크를 반드시 클릭하여 일정을 확정하시기 바랍니다.
                            미응답 시 불참으로 간주되어 상담이 불가하실 수 있습니다.
                        </p>

                        <p style="text-align: center; margin:20px 0 0;"> <a href="http://dcamp.kr/office_hours/confirm/{oh.id}/{res.id}" style="display: inline-block;   line-height: 40px; padding:0 20px; background-color:#FF7800; color:#fff; border:1px solid #f75d00; border-radius: 4px;     -moz-border-radius: 4px;  -webkit-border-radius: 4px; -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);    -moz-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);   box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);  text-decoration: none;">Office Hours 일정 확정 &rarr;</a></p>

                        <dl>
                            <dt style="font-weight:bold;">&#8226; 사전 준비물</dt>
                            <dd style="margin-left:10px;">1. 사업소개서 간략본 출력물 <br>2. 상담 주제와 관련된 기타 자료 등</dd>
                        </dl>
                        <dl>
                            <dt style="font-weight:bold;">&#8226; 일정</dt>
                            <dd style="margin-left:10px;">{=date_to_kr(oh.e_start)} {res.time.start}~{res.time.end}</dd>
                        </dl>
                        <dl style="margin-bottom:0;">
                            <dt style="font-weight:bold;">&#8226; 장소</dt>
                            <dd style="margin-left:10px;">
                            {oh.place} <br><br>
                            대기 장소는 4층 협업공간 카페테리아입니다. 도착 시, 상담 완료 후 인포데스크에 Notice 부탁드립니다. 
                            </dd>
                        </dl>
                        
                    </td>
                </tr>  
                <tr>
                    <td style="padding:20px 0; border-top:1px solid #ddd; padding-top:15px;">
                        <table  width="100%" cellspacing="20" cellpadding="0" border="0" style="background-color: #fff;    border:1px solid #ddd; border-radius: 4px; -moz-border-radius: 4px;  -webkit-border-radius: 4px; -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);    -moz-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);   box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05); ">
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
