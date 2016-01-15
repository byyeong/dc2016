<a name="0" />
<h3>문서 &gt; 웰컴 페이지 &gt; 리다이렉트 제거</h3>
<br /><br />
트레일의 기본 root controller 에는 월컴 페이지를 자동 이동할 수 있도록<br />
자바스크립트 처리가 되어 있습니다.<br />
자동으로 리다이렉트를 하지 않고자 할 경우, 다음을 수정합니다.<br />
수정할 파일은 {cwd}\tf_app\ext\views\root\index.tpl 이며,<br />
해당 파일을 편집기로 열어, 자바 스크립트 부분을 모두 제거하시면 됩니다.<br />
상황에 따라서는, 개발자가 이미 해당 페이지의 내용을 변경하였을 수 있습니다.<br />
이 경우에는 삭제하실 필요가 없습니다.<br />
참고로 삭제 대상의 코드는 다음과 같습니다.<br />
{=cst()}
&lt;script language="javascript">

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
    		    location.href = "/tf/";
    		}
    		else if(xh_rel.status == 404)
    		{
    		    document.getElementById("error_mod").style.display = "block";
    		}
    		else if(xh_rel.status == 500 || xh_rel.status == 403)
    		{
    		    document.getElementById("error_ext_power").style.display = "block";
    		}
    	}
    }
    
	xh_rel.open("GET", "/tf/", true);
	xh_rel.send(null);

&lt;/script>

{=ced()}
