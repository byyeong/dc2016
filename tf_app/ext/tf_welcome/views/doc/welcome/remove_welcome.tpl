<a name="0" />
<h3>문서 &gt; 웰컴 페이지 &gt; 삭제하기</h3>
<br /><br />
트레일 0.8.0 부터 기본 확장 기능으로 제공되는 웰컴페이지는<br />
간단한 설명서, 진단, 울트라 에디터 프로젝트 파일 생성기등이 포함되어 있습니다.<br />
<br />
이 페이지는 개발자에게 편리함을 줄 수 있지만,<br />
내부 구조가 드러날 수 있는 문제점 역시 가지고 있으므로,<br />
개발이 종료된 후, <font color="red"><b>실제 서비스시에는 제거되어야 합니다.</font></b><br />
<br />
1. 프로젝트에서 컴포넌트 사용을 제거하기 위해<br />
- <font color="red"><b>{cwd}\tf_app\settings\settings.php</font></b><br />
- <font color="red"><b>{cwd}\tf_app\settings\settings_local.php</font></b> (존재하지 않을 수도 있음)<br />
파일들을 편집기로 열어 주십시오.<br />
<br />
2. "var $bootstrap_apps = array(" 라고 되어 있는 부분을 찾으시면,<br />
그 중 "tf_welcome/info", 라고 되어 있는 열이 있습니다.<br />
이 부분이 웰컴 페이지 컴포넌트입니다.<br />
아래와 같이 해당 부분을 주석처리(//) 하거나 삭제하면 됩니다<br />
<br />
예) 삭제 이전<br />
{=cst()}
        var $bootstrap_apps = array(
                <font color="red"><b>"tf_welcome/info",</b></font>          // <- 이 부분이 제거되어야 할 부분입니다.
                "tf_service_settings/info",
                "tf_utils",
                "utils",
                "tf_mailer",
                "tf_cache",
                );
{=ced()}
<br />
예) 삭제(주석처리) 이후<br />
{=cst()}
        var $bootstrap_apps = array(
                <font color="red"><b>//"tf_welcome/info",</b></font>  //주석처리한 예제이며, 이 줄을 완전히 제거해도 됩니다.
                "tf_service_settings/info",
                "tf_utils",
                "utils",
                "tf_mailer",
                "tf_cache",
                );
{=ced()}
<br />
settings_local.php 파일이 존재하는 경우,<br />
해당 파일 내에서도 확인하여 제거하여 주시기 바랍니다<br />
(사용자의 설정에 따라 해당 내용은 존재하지 않을 수도 있습니다)<br />
<br />
3. 트레일의 기본 root controller 에는 월컴 페이지를 자동 이동할 수 있도록<br />
자바스크립트 처리가 되어 있습니다.<br />
<font color="red"><b>해당 처리를 삭제하지 않는 경우, 트레일은 첫 페이지에서 오류를 출력하게 되므로,<br />
해당 페이지의 내용이 수정되어야 합니다.</font></b><br />
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
<br />
4. 폴더를 제거하기 위해, {cwd}\tf_app\ext\tf_welcome 폴더 자체를 삭제할 수 있습니다 (선택사항)<br />
삭제하지 않는 경우에도 위 세팅 파일을 변경한 경우에는 서비스에 영향을 미치지 않으므로<br />
굳이 삭제하실 필요는 없습니다.<br />
<br />



