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
                <tr>
                    <td style="padding: 20px 0;"> 
                        <h4 style="font-size: 16px; font-weight:bold; text-align: center; color:#666; margin-top:0;" > {?res.state == 1}공간 예약이 <span style="color:#428BCA;">승인</span>되었습니다.</h4>{:}공간 예약이 <span style="color:#428BCA;">반려</span>되었습니다.</h4>{/}
                        
                        <table  width="100%" cellspacing="20" cellpadding="0" border="0" style="background-color: #fff; border:1px solid #ddd; border-radius: 4px;
    -moz-border-radius: 4px;  -webkit-border-radius: 4px; -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);    -moz-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);   box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05); ">
                            <tr>
                                <td width="30%" align="right">예약한 공간 :</td>
                                <td width="70%" align="left"><strong>{res.opt}F {res.name}</strong></td>
                            </tr>
                            <tr>
                                <td align="right">예약한 날짜/시간 :</td>
                                <td align="left"><strong>{res.date} {res.start} ~ {res.end}</strong></td>
                            </tr>
                            {?res.state == 2}
                            <tr>
                                <td align="right">반려 사유 :</td>
                                <td align="left"><strong>{res.state_des}</strong></td>
                            </tr>
                            {/}
                        </table>   
                                             
                        <p style="text-align: center; margin:20px 0;"> <a href="http://dcamp.kr/reservation/apply/{res.id}" style="display: inline-block; font-size:12px; line-height:1; padding:14px 20px; background-color:#FF7800; color:#fff; border:1px solid #f75d00; border-radius: 4px;    -moz-border-radius: 4px;  -webkit-border-radius: 4px; -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);    -moz-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);   box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);  text-decoration: none;">예약 확인하기 &rarr;</a></p>
                    </td>
                </tr>
                {? res.state == 1}
                {? res.type < 3}
                <tr>
                    <td> 
                        <p style="text-align: center;">공개 모임이라면 더 많은 사람들이 참여할 수 있도록 D.CAMP에 이벤트로 등록해주세요.</p>
                        <p style="text-align: center; margin:10px 0 20px;"> 
                            <a href="http://dcamp.kr/event/add" style="display: inline-block; font-size:12px; line-height:28px; padding:0 20px; background-color:#FFF; color:#666; border:1px solid #eee; border-radius: 4px;     -moz-border-radius: 4px;  -webkit-border-radius: 4px; -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);    -moz-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);   box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);  text-decoration: none;">이벤트 추가하기 &rarr;</a>
                        </p>
                    </td>
                </tr>
                {/}
                <tr>
                    <td style="border-top:1px solid #eee; height:0; margin:0; padding:0;"></td>
                </tr>
                <tr>
                    <td style="padding:20px ; color:#666; line-height:1.8"><h3>D.CAMP 공간공유에 대한 승인과 함께 아래와 같은 안내를 해 드립니다.</h3>
                        <h4>기본사항</h4>
                        <ul >
                            <li>대표전화는 02-2030-9300 입니다.</li>
                            <li>공간공유 프로그램은 D.CAMP의 후원을 전제로 합니다. 대외 공지 시 반드시 <b>"장소(또는 공간) 후원 : 은행권청년창업재단 D.CAMP"</b> 를 명시해 주시기 바랍니다.</li>
                            <li>행사 시작 30분 전에 미리 도착하셔서 장소를 확인하시기 바랍니다.</li>
                            <li>D.CAMP는 2층 외부 흡연장을 제외한 모든 장소가 금연입니다. 참석자분들께 공지 부탁드립니다.</li>
                            <li>본건물 앞, 또는 측면에는 물건 및 차량 등을 적재나 주차하실 수 없습니다.</li>
                            <li>오토바이 및 자전거등은 새롬빌딩 주차 지정장소인 2층 흡연 장소에 주차를 하시면 됩니다.</li>
                            <li>프로젝터 사용 여부는 미리 말씀해 주셔야 합니다.</li>
                            <li>시간/일정이나 행사 관련한 변경사항이 있을 시에는 꼭 <a href="mailto:contact@dcamp.kr">contact@dcamp.kr</a> 메일로 내용을 사전 전달해 주셔야합니다.</li>
                        </ul>
                        <h4>주차 관련</h4>
                        <ul>
                            <li>2014년 12월 15일 부터 새롬빌딩 주차장이 유료로 운영됩니다.</li>
                            <li>유료 주차료는 10분 당 2000원 입니다.</li>
                            <li>공간 대관 신청자에 한해 4층 인포데스크에서 확인 후, 주차권 1장을 제공합니다.</li>
                            <li>행사 방문자 분들에 대한 주차권은 제공되지 않사오니 대중 교통 이용 장려를 부탁드립니다.</li>
                        </ul>
                        <h4>홍보 (협조) 관련</h4>
                        <ul>
                            <li>D.CAMP를 통한 온라인 홍보는 <a href="http://dcamp.kr/?c=event">http://dcamp.kr/?c=event</a> 에서 이벤트 만들기를 통해 행사 정보를 업데이트 해 주시면 확인 후 승인해 드립니다.</li>
                            <li>온오프라인 장소 표기는 "은행권청년창업재단 D.CAMP" 입니다. (대문자)</li>
                            <li>로고는 아래 링크에서 확인하실 수 있습니다.  <br>
                                <a href="https://drive.google.com/folderview?id=0B_dmLVv_Qn1zMzBnUFNBaUlZZjA&usp=sharing">Google Drive - 재단 CI 관련 파일</a> </li>
                            <li>보도자료를 배포하는 행사의 경우 미리 공유부탁드립니다.</li>
                            <li>행사 시작전에 센터장님의 환영인사가 필요한 경우는 미리 의견을 드리도록 하겠습니다.</li>
                        </ul>
                        <h4>음식물 관련</h4>
                        <ul>
                            <li>종이컵이나 음료는 직접 준비해 주셔야 합니다.</li>
                            <li>식사는 샌드위치와 같이 음식물쓰레기가 생기지 않는 품목을 추천해 드립니다.
                                식사를 하는 경우, 어떤 종류의 식사를 하는지 답변해주세요.
                                <ul>
                                    <li>(주)초콜릿라이크 정민경 경영기획 팀장 : 070-4126-9481(직) / 010-2825-9481</li>
                                </ul>
                            </li>
                            <li>음식물은 행사장 밖에서만 드시고 특히 점성이 있는 음료는 행사장 안에서는 드실 수 없습니다.</li>
                        </ul>
                        <h4>사후 정리 </h4>
                        <ul>
                            <li>행사 후에 발생한 쓰레기는 분리수거를 해서 검은색 쓰레기 봉지에 담아 배출해 주세요.</li>
                            <li>여분의 쓰레기 봉투는 설치된 쓰레기 봉지를 제거하시면 쓰레기통 하단에 있습니다.</li>
                            <li>쓰레기 양이 많을것으로 예상되는 경우는 100리터 분리 배출 봉투를 지참해 주시기 바랍니다.</li>
                            <li>음식물 쓰레기의 경우 봉투를 별도 구입하셔서 주차장 앞에 있는 분리수거통에 분리배출 하셔야 합니다.</li>
                            <li>행사가 끝나고 대표전화로 연락 부탁드립니다.</li>
                            <li>모든 기기와 배치 원상태 확인과 쓰레기 배출에 대한 부분을 확인합니다.</li>
                        </ul></td>
                </tr>
                <!-- /E -->   
                {/}
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
