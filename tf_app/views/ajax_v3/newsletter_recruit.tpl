<!doctype html>
<html>
<head>
<meta charset="utf-8">
<style></style>
</head>

<body>
    <table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0" bgcolor="#f6f6f6" style="font-size:12px; line-height:1.6; color:#555; font-family: 'Malgun Gothic', Arial, sans-serif; padding:30px 0;">
        <tr>
            <td>
                <table width="670" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#fff">  
                    <tr>
                        <td style="background:url({? header.pic_1}http://dcamp.kr{header.pic_1}{:}http://dcamp.kr/images/newsletter-recruit-header.jpg{/}) center no-repeat; background-size:cover;"> 
                            <table width="100%" cellspacing="20" cellpadding="0" border="0">
                                <tr>
                                    <td align="center">
                                        <div style="text-align:left;">
                                            <a href="http://dcamp.kr">
                                            <img src="http://dcamp.kr/images/logo_white.png" style="width:40px;">
                                            </a>
                                        </div>
                                        <h1 style="color:#FFF; font-size:40px; margin:0; padding:0;"><a style="color:#FFF; text-decoration:none;" href="http://dcamp.kr/recruit">{? header.des_1}{header.des_1}{:}RECRUIT{/}</a></h1>
                                        {? header.des_2}<p style="color:#FFF; padding:0; margin-top:0;">{header.des_2}</p>{/}
                                        <div style="text-align:right;"><a href="http://dcamp.kr/recruit" style="color:#FFF; text-decoration:none;">채용정보등록 바로가기</a></div>
                                    </td>
                                </tr> 
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                             <table width="100%" border="0" cellpadding="20" cellspacing="0">  
                                {@ res}
                                <!-- item -->
                                <tr>
                                    <td style="border-top:1px solid #eee;"> 
                                        <table width="100%" cellspacing="0" cellpadding="0" border="0" >
                                            <tr>
                                                <td align="left" valign="top" rowspan="2" style="width:80px; padding-right:15px;">
                                                    <a href="http://dcamp.kr/startup/{.sid}">
                                                    <img src="http://dcamp.kr{?.logo}{.logo}{:}/img/default-img-company.png{/}" style="width:100%;">
                                                    </a>
                                                </td>
                                                <td align="left">
                                                    <table width="100%" cellspacing="0" cellpadding="0" border="0" >
                                                        <tr>
                                                            <td>
                                                                <h2 style="margin:0; display:inline; font-size:24px;">
                                                                    <a href="http://dcamp.kr/startup/{.sid}" style="text-decoration:none; color:#f60;">
                                                                    {.sname}
                                                                    </a>
                                                                </h2>
                                                                <!--font>IoT, 플랫폼, 스마트 완구</font-->
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-size:13px;">
                                                                {=htmlspecialchars(.bio)}
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-size:11px; color:#999; padding-top:5px;">
                                                                {? .addr}{.addr}  <br>{/}
                                                                {? .tel}전화번호 : {.tel} /{/}{? .email} 이메일 : {.email}  /{/}{? . founded} 설립일 : {.founded}  /{/}{? .number} 임직원 : {.number}명{/}
                                                            </td>
                                                        </tr>  
                                                        <tr>
                                                            <td style="padding-top:10px;">
                                                                <table width="100%" cellspacing="2" cellpadding="15" border="0">
                                                                    {@ .rec}
                                                                    <tr>
                                                                        <td bgcolor="#f6f6f6">
                                                                            <h3 style="font-weight:bold; font-size:14px; margin:0;">
                                                                                <a href="http://dcamp.kr/recruit/views/{..rid}" style="text-decoration:none; color:#f60;">
                                                                                {..title}
                                                                                </a>
                                                                            </h3>
                                                                            <a href="http://dcamp.kr/recruit/views/{..rid}" style="text-decoration:none; color:#555;">
                                                                            {? ..term}고용형태 : {@ ..term}{? ...key_ == 0}{..._value}{:}, {..._value}{/}{/}<br>{/}
                                                                            {? ..inv}업무분야 : {@ ..inv}{? ...key_ == 0}{..._value}{:}, {..._value}{/}{/}<br>{/}
                                                                            접수기간 : {..start} ({=date_to_day_only(..start)}){?..end} ~{..end} ({=date_to_day_only(..end)}) {/}
                                                                            </a>
                                                                        </td>
                                                                    </tr>
                                                                    {/}
                                                                </table> 
                                                            </td>
                                                        </tr> 
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr> 
                                <!-- /item -->
                                {/}
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
