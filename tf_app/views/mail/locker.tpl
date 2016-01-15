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
                        
                        
                        <!-- todo : 다른 사람이 내 프로필에 글을 작성했을 경우 -->
                        
                        <h3 style="font-size:16px; font-weight:bold;  color:#666;  text-align: center; margin-top:0;">{user.name}님, D.CAMP의 월간 사물함 사용 신청을 받습니다.</h3>
                        
                        <table  width="100%" cellspacing="20" cellpadding="0" border="0" style="background-color: #fff; font-size:12px;  color: #777;  border:1px solid #eee; border-radius: 4px;
    -moz-border-radius: 4px;  -webkit-border-radius: 4px; -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);    -moz-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);   box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05); ">
                            <tr>
                                <td>
                                    <!-- post -->
                                    <table  width="100%" cellspacing="10" cellpadding="0" border="0" >
                                        <tr>
                                            <td style="line-height: 1.8;">
                                            <h4 style=" margin-top: 0;"><strong>{user.name}</strong>님은 D.CAMP의 포인트 산정에 따라 월간 사물함 신청이 가능합니다.  </h4>
                                            <p>
                                                D.CAMP의 월간 사물함 신청은 비공개이며, 해당 회원만이 신청할 수 있습니다.  <br>
                                                반드시 신청기간 내에 접수를 받고 있습니다. 잊지 말고 신청해주세요.
                                                </p>
                                            </td>
                                        </tr>
                                        <tr> 
                                            <td style="border-top: 1px dashed #ddd;"> 
                                            
                                                <table  width="100%" cellspacing="10" cellpadding="0" border="0" >
                                                    <tr>
                                                        <th width="60">신청기간 : </th>
                                                        <td><strong style="color:#FF7800;">{= substr(pdate, 0, 4)}년 {= substr(pdate, 5, 2)}월 {end_day}일 까지</strong></td>
                                                    </tr> 
                                                    <tr>
                                                        <th>사용기간 : </th>
                                                        <td><strong style="color:#428BCA;">{= substr(date, 0, 4)}년 {= substr(date, 5, 2)}월 1일 ~ {= substr(date, 0, 4)}년 {= substr(date, 5, 2)}월 {= date("t", mktime(0, 0, 0, substr(date, 5, 2), 1, substr(date, 0, 4)))}일 까지</strong></td>
                                                    </tr>                                                
                                                </table> 
                                                
                                            </td>
                                        </tr>
                                    </table>  
                                  <!-- / post -->
                               </td>
                            </tr>
                        </table>
                        <p style="text-align: center; margin:20px 0 0;"> <a href="http://dcamp.kr/locker/{date}?email={user.email}" style="display: inline-block; font-size:12px; line-height:40px; padding:0 20px; background-color:#FF7800; color:#fff; border:1px solid #f75d00; border-radius: 4px;    -moz-border-radius: 4px;  -webkit-border-radius: 4px; -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);    -moz-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);   box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);  text-decoration: none;">월간 사물함 신청하기 &rarr;</a></p>
                        
                        
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
