<a name="0" />
<h3>문서 &gt; 확장 기능 &gt; 서비스 세팅</h3>
<br /><br />
이 절에서는 서비스 세팅 기능을 설명합니다. <br />
적용 버전: 0.7 이상의 버전에 설치할 수 있습니다. 컴포넌트 기능을 이용하므로 이전 버전엔 설치할 수 없습니다.<br /><br />
<a href="#1">1. 개요</a><br />
<a href="#1">2. 서비스 세팅 기능의 설치</a><br />
<a href="#2">3. 사용법</a><br />

<br />
<a name="1" />
<h4>1. 개요</h3>
기존의 settings/ local_settings 로 나뉘여진 세팅 방법은<br />
코드 작성을 위한 세팅에 대해서는 편리하지만, SI 등 외부 작업을 하는 경우<br />
간단한 외부 설정값들을 지정할 때 프로그래밍 언어에 익숙하지 못한<br />
사용자가 편집하기 불편하고, 비정상적인 작동으로 예기치 못한 결과를 불러킬<br />
가능성이 있었습니다.<br />
서비스 세팅 확장기능은, 사용자가 설정할 수 있는 변수값들을 별도로 관리하며<br />
서비스 설정 페이지에서 설정이 가능하므로, <br />
사용자에게는 편의성 및 안정성을 도모하고<br />
기존 settings 클래스의 멤버로 그대로 사용되므로 개발에 있어 수정할 부분도 없습니다.<br /><br />
<a href="#0">문서의 최상단으로</a><br /><br />


<a name="2" />
<h4>2. 서비스 세팅 기능의 설치</h3>


<a href="/bin/ext/tf_service_settings.zip">여기</a> 를 클릭하여 서비스 세팅 확장 기능을 다운로드 합니다.<br />
다운받은 파일을 tf_app/ext 폴더 안으로 압축을 해제하는 것으로 설치가 완료입니다. <br />
그림으로 표현하면 다음과 같습니다. <br/><br/>

{=cst()}
+ [tf_app]    
&nbsp; + ...
&nbsp; + [ext]
&nbsp; &nbsp; + <b><font color="red">[tf_service_setting]</b></font>
&nbsp; &nbsp; &nbsp; &nbsp; + <b><font color="red">info.php</b></font>
&nbsp; &nbsp; &nbsp; &nbsp; + <b><font color="red">controllers.php</b></font>
&nbsp; &nbsp; &nbsp; &nbsp; + <b><font color="red">settings.php</b></font>
&nbsp; &nbsp; &nbsp; &nbsp; + <b><font color="red">[views]</b></font>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; + <b><font color="red">admin.tpl</b></font>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; + <b><font color="red">login.tpl</b></font>
&nbsp; + ...
{=ced()}
<br /><br />
* 확장 기능의 사용을 위해 먼저 bootstrap_apps 에 "tf_service_settings/info" 를 다음과 같이 포함합니다.<br /><br />
{=cst()}
var $bootstrap_apps = array(
&nbsp; &nbsp; &nbsp; &nbsp; "tf_utils",
&nbsp; &nbsp; &nbsp; &nbsp; "globals",
&nbsp; &nbsp; &nbsp; &nbsp; <font color="red"><b>"tf_service_settings/info",  // 이 부분이 새로 추가된 부분입니다.</b></font>
&nbsp; &nbsp;);
{=ced()}
<br />
순서는 상관이 없습니다.<br /><br />
* 그다음 설정과 관련된 URL들을 라우팅에 추가하는 걸로 메인 설정이 끝납니다.<br />
{=cst()}
var $route = array(
            ...
            <font color="red">"tf/admin/settings"                    =>"*component*/tf_service_settings/admin",</font>
            <font color="red">"tf/admin/settings/login"                    =>"*component*/tf_service_settings/login",</font>
            <font color="red">"tf/admin/settings/logout"                    =>"*component*/tf_service_settings/logout",</font>
            );
{=ced()}
<a href="#0">문서의 최상단으로</a><br /><br />


<a name="3" />
<h4>3. 사용법</h3>
/tf/admin/settings 주소로 접근합니다.<br />
첫 로그인 비밀번호는 service_settings 로 되어 있습니다 접속 후 반드시 바꾸시기 바랍니다. <br />
접근 후 안내에 따라 설정을 추가/삭제/편집 할 수 있습니다.<br />
<a href="#0">문서의 최상단으로</a><br /><br />


<a name="4" />
<h4>4. 설정의 한계</h3>
기존 세팅과는 달리 이것은 추가 기능으로 돌아가므로,<br />
추가기능이 로딩되는 시점에 세팅이 로딩됩니다. 이 로딩 시점 이전에는<br />
세팅 내용을 확인할 수 없게 됩니다. 일반적인 클래스나 모델에서는 관계가 없습니다만,<br />
세팅파일을 사용하는 확장 기능의 경우 오동작의 가능성이 있으므로,<br />
이 추가 기능을 가능한 bootstrap_apps 내에서 위쪽에 기술하기를 추천합니다.<br /><br />
<a href="#0">문서의 최상단으로</a><br /><br />


<br /><br /><br /><br />
<font size="1">
문서의 끝.<br />
최초 작성일: 2010/05/04, 고빈섭<br />
최종 수정일: 2010/05/04, 고빈섭<br />
</font>
