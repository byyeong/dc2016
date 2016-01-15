<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!-- Script -->
	<title>Welcome package :: TF 0.8</title>
</head>

<body border="0" style="margin-top:0px;margin-left:0px;">
<table cellpadding="10" cellspacing="0">
    <tr>
        <td colspan="2" style="font-size:12px;background-color:#000000;padding-top:20px;padding-bottom:5px;">
            <a href="/"><font color="white" size="3"><b>Trail Framework 0.8</b></font></a>
        </td>
    </tr>
    <tr>
        <td colspan="2" style="font-size:12px;background-color:#000000;padding-top:0px;padding-bottom:3px;" align="right">
            <a href="/tf/diagnotics/"><b><font color="#c0c0c0">Diagnotics</font></b></a> <font color="#ffffff">|</font>
            <a href="/tf/doc/"><b><font color="#c0c0c0">Documentation</font></b></a> <font color="#ffffff">|</font>
            <a href="/samples/"><b><font color="#c0c0c0">Samples</font></b></a> <font color="#ffffff">|</font>
            <a href="/tf/make_ultra_project/"><b><font color="#c0c0c0">UlraEdit .prj generator</font></b></a> <font color="#ffffff">|</font>
        </td>
    </tr>
    <tr>
        <td valign="top" width="200" style="font-size:12px;background-color:#E0E0E0;">
            <b>TF documentation - 0.8</b>
            <br />
            <br />
            (작성 중입니다)<br />
            <br /><br />
            {=menu(0,"개요","concept",true)}
                {=menu(1,"개요","concept/index")}
                {=menu(1,"class Trail","concept/class_trail")}
            </div>
                
            {=menu(0,"확장 기능","ext", true)}
                {=menu(1,"개요","ext/about")}
                {=menu(1,"프로젝트에 포함하기","ext/how_to_add")}
                {=menu(1,"SNS Utils","ext/sns")}
                {=menu(1,"메일발송","ext/mailer")}
                {=menu(1,"위지윅 에디터","ext/editor")}
                {=menu(1,"한글 캡챠","ext/captcha")}
                {=menu(1,"서비스 세팅 매니저","ext/service_settings")}
                {=menu(1,"파일 유틸","ext/file_utils")}
            </div>

            {=menu(0,"0.6 -> 0.7에서 달라진 기능","new07", true)}
                {=menu(1,"모델 관련","new07/models")}
                {=menu(1,"클래스 확장 기능으로 추가","new07/use_component_vs_external_apps")}
                {=menu(1,"컴포넌트","new07/component")}
                {=menu(1,"새로 추가된 확장기능","new07/apps")}
            </div>

            {=menu(0,"0.7 -> 0.8에서 달라진 기능","new08", true)}
                {=menu(1,"모델 관련","new08/models")}
                {=menu(1,"컨트롤러 관련","new08/controllers")}
                {=menu(1,"컴포넌트 관련","new08/component")}
                {=menu(1,"부트스트랩/전역변수 관련","new08/global")}
                {=menu(1,"새로 추가된 확장기능","new08/apps")}
                {=menu(1,"내부에서 컨트롤러 로드","new08/load_controller")}
                {=menu(1,"마이그레이션 가이드","new08/migration")}
            </div>

            {=menu(0,"웰컴 패키지 제거","welcome", true)}
                {=menu(1,"리다이렉트 제거","welcome/disable_welcome")}
                {=menu(1,"완전히 제거","welcome/remove_welcome")}
            </div>

            
            
            
            
            
            
        </td>
        <td valign="top" style="font-size:12px;padding-left:20px;" width="700">
            {contents_for_layout}
        </td>
    </tr>
    <tr>
        <td colspan="2" style="font-size:12px;background-color:#000000;padding-top:15px;padding-bottom:5px;" align="right">
            <font color="#606060">Trail Framework.</font>
        </td>
    </tr>
</table>

</body>

</html>


<script>
    
    
    function d_toggle(id)
    {
        if (document.getElementById(id).style.display == "none")
            document.getElementById(id).style.display = "block";
        else
            document.getElementById(id).style.display = "none";
        
    }

    function _open(id)
    {
        d_close("page" + id + "_off");
        d_open("page" + id + "_on");
    }

    function _close(id)
    {
        d_open("page" + id + "_off");
        d_close("page" + id + "_on");
    }


    function d_open(id)
    {
        document.getElementById(id).style.display = "block";
    }
    function d_close(id)
    {
        document.getElementById(id).style.display = "none";
    }
    
</script>
