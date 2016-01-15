
DB 및 세팅 검사<br />
이 항목은 트레일 세팅과 주요한 php 세팅을 검사합니다.<br />
이 항목에 문제가 있는 경우 trail 이 정상동작할 수 없습니다.<br />
<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <td>항목</td>
        <td>검사 결과</td>
        <td>설명 및 조치법</td>
    </tr>
{@result}
    <tr>
        <td>{.title}</td>
        <td>{.result}</td>
        <td>{?.remedy}<a href="#" onclick="open_remedy('{.remedy}');return false">보기</a>{/}</td>
    </tr>
{/}
</table>
<br /><br /><br />
Trail core 정보<br />
이 항목은 설치된 Trail core 파일의 정보를 확인합니다.<br />
<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <td>파일명</td>
        <td>이름</td>
        <td>버전</td>
        <td>검사 결과</td>
        <td>설명 및 조치법</td>
    </tr>
{@result_core}
    <tr>
        <td>{.file}</td>
        <td>{.name}</td>
        <td>{.version}</td>
        <td>{.result}</td>
        <td>{?.remedy}<a href="#" onclick="open_remedy('{.remedy}');return false">보기</a>{/}</td>
    </tr>
{/}
</table>
<br /><br /><br />
사용중인 외부 컴포넌트 정보<br />
사용중인 외부 컴포넌트를 검사합니다.<br />
호환 여부등이 불명확한 경우에는 확인을 거쳐 사용하시기를 권장합니다.<br />
<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <td>파일명</td>
        <td>이름</td>
        <td>버전</td>
        <td>호환여부</td>
        <td>설명 및 조치법</td>
    </tr>
{@result_bs}
    <tr>
        <td>{.file}</td>
    {?.name}
        <td>{.name}</td>
        <td>{.version}</td>
        {?.approved == 1}
        <td>호환됨</td>
        {:}
            {?.approved == 2}
        <td>알 수 없음</td>
            {:}
        <td>호환불가</td>
            {/}
        {/}
    {:}
        <td colspan="2">상세 정보 없음</td>
        <td>알 수 없음</td>
    {/}
        <td>{?.remedy}<a href="#" onclick="open_remedy('{.remedy}');return false">보기</a>{/}</td>
    </tr>
{/}
</table>

<br /><br /><br />
컨트롤러 정보<br />
컨트롤러 파일을 검사합니다.<br />
<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <td>파일명</td>
        <td>검사 결과</td>
        <td>설명 및 조치법</td>
    </tr>
{@result_con}
    <tr>
        <td>{.file}</td>
        <td>{.result}</td>
        <td>{?.remedy}<a href="#" onclick="open_remedy('{.remedy}');return false">보기</a>{/}</td>
    </tr>
{/}
</table>

<br /><br /><br />
모델 정보<br />
모델 파일을 검사합니다
<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <td>파일명</td>
        <td>검사 결과</td>
        <td>설명 및 조치법</td>
    </tr>
{@result_model}
    <tr>
        <td>{.file}</td>
        <td>{.result}</td>
        <td>{?.remedy}<a href="#" onclick="open_remedy('{.remedy}');return false">보기</a>{/}</td>
    </tr>
{/}
</table>

<div id="remedy" style="background-color:#dddddd;position:absolute;display:none;left:150px;padding:20px;border:solid 2px #000000;">
<div id="remedy_inner"></div>
<a href="#" onclick="document.getElementById('remedy').style.display='none';return false;">닫기</a>
</div>
<script>
    function open_remedy(_file)
    {
        //window.open(_file, "height=300px, width=600px");

        var xh_rel;
    	if (window.ActiveXObject)
    	{
    		xh_rel = new ActiveXObject("Microsoft.XMLHTTP");
    	}
    	else if (window.XMLHttpRequest)
    	{
    		xh_rel = new XMLHttpRequest();
    	}    
    
    	xh_rel.onreadystatechange = function ()
        {
        	if(xh_rel && xh_rel.readyState == 4)
        	{
        		if(xh_rel.status == 200)
        		{
        		    document.getElementById("remedy_inner").innerHTML = xh_rel.responseText;
        		    document.getElementById('remedy').style.display = "block";
        		}
        	}
        }
        
    	xh_rel.open("GET", _file, true);
    	xh_rel.send(null);
	        
    }
    

 function heartBeat(_id) {
    //var rtop = document.documentElement.scrollTop + 30;
    var rtop = document.body.scrollTop;
    
    if (rtop == 0)
        rtop = document.documentElement.scrollTop + 30;
    
    rtop += 100;
    //if (document.getElementById("ar_backword")) document.getElementById("ar_backword").style.top = rtop + "px";
    //if (document.getElementById("ar_forward")) document.getElementById("ar_forward").style.top = rtop + "px";
    document.getElementById(_id).style.top = rtop + "px";
    //alert(rtop);
    
    
 }
 
 function JSFX_FloatDiv(_id, sy)
{
    window.setInterval("heartBeat('" + _id + "')",100);
}


JSFX_FloatDiv("remedy",30);


    
</script>
