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
            <table width="100%" align="center"  cellspacing="0" cellpadding="0" border="0"  style="max-width:600px; margin:0 auto; ">
                <!-- S --> 
                <tr>
                    <td style="padding:20px 0;">
                        <h4 style="font-size:16px; font-weight:bold;  color:#666;  text-align: center; margin-top:0;">{us.name}님, 업무분야에 해당하는 채용공고를 알려드립니다.</h4>
                        
                        <table  width="100%" cellspacing="20" cellpadding="0" border="0" style="margin-top: 10px; background-color: #fff; font-size:12px;  border:1px solid #ddd; border-radius: 4px;
    -moz-border-radius: 4px;  -webkit-border-radius: 4px; -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);    -moz-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);   box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05); ">
                            
                            <tr>
                                <td width="100" valign="top">
                                    <a href="http://dcamp.kr/startup/{res.sid}"><img src="http://dcamp.kr{res.slogo}" style="width:100px;"></a>                                
                                </td>
                                <td valign="top">
                                    <h3 style=" font-size:18px; margin-top:0; margin-bottom: 10px;"><a href="http://dcamp.kr/recruit/views/{res.id}" style=" color: #333;">{res.title}</a></h3>
                                    <p style=" color: #666;">{res.contents}</p>
                                    
                                    <table width="100%" align="center"  cellspacing="0" cellpadding="5" border="0" style=" border-top: 1px solid #eee; padding-top: 10px; margin-top: 10px; ">
                                        {? res.inv}
                                        <tr>
                                            <th align="right" valign="top" width="70">업무분야</th>
                                            <td>{=str_replace("/", ", ", res.inv)}</td>
                                        </tr>
                                        {/}{? res.job}
                                        <tr>
                                            <th align="right" valign="top">채용분야</th>
                                            <td>{=str_replace("/", ", ", res.job)}</td>
                                        </tr>
                                        {/}{? res.career}
                                         <tr>
                                            <th align="right" valign="top">경력</th>
                                            <td>{=str_replace("/", ", ", res.career)}</td>
                                        </tr>
                                         {/}{? res.dev}
                                         <tr>
                                            <th align="right" valign="top">개발분야</th>
                                            <td>{=str_replace("/", ", ", res.dev)}</td>
                                        </tr>
                                        {/}{? res.local}
                                        <tr>
                                            <th align="right" valign="top">지역</th>
                                            <td>{=str_replace("/", ", ", res.local)}</td>
                                        </tr>
                                        {/}{? res.term}
                                        <tr>
                                            <th align="right" valign="top">근무형태</th>
                                            <td>{=str_replace("/", ", ", res.term)}</td>
                                        </tr>
                                        {/}{? res.lang}
                                        <tr>
                                            <th align="right" valign="top">언어</th>
                                            <td>{=str_replace("/", ", ", res.lang)}</td>
                                        </tr>  
                                        {/}                                 
                                    </table> 

                                </td>
                            </tr>
                        </table>  
                        
                        <table  width="100%" cellspacing="20" cellpadding="0" border="0" style="margin-top: 10px; background-color: #fff; font-size:12px;  border:1px solid #ddd; border-radius: 4px;
    -moz-border-radius: 4px;  -webkit-border-radius: 4px; -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);    -moz-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);   box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05); ">

                        </table>  
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
