<a name="0" />
<h3>문서 &gt; 확장 기능 &gt; 프로젝트에 포함하기</h3>
<br /><br />
이 절에서는 확장기능을 프로젝트에 포함하는 방법을 설명합니다. <br />
<a href="#1">1. 전역 확장 기능으로 추가</a><br />
<a href="#2">2. 클래스 확장 기능으로 추가</a><br />
<a href="#3">3. 컴포넌트의 라우팅 설정</a><br />
<a href="#4">4. 컴포넌트 설치시 특별히 주의할 점</a><br />

<br />
<a name="1" />
<h4>1. 전역 확장 기능으로 추가</h3>
전역 확장 기능은 부트업 타임에 전체로 로딩하는 것으로<br />
확장 기능의 파일명을 .php 를 제거하고 settings.php 의<br />
bootstrap_apps 에 추가합니다.<br /><br />
{=cst()}
var $bootstrap_apps = array(
&nbsp; &nbsp; &nbsp; &nbsp; "tf_utils",
&nbsp; &nbsp; &nbsp; &nbsp; <font color="red"><b>"tf_mailer",  // 이러한 형태로 추가합니다.</b></font>
&nbsp; &nbsp;);
{=ced()}
*참고* tf_utils 는 트레일 프레임워크 동작에 필수적인 함수들을 담고 있습니다. (0.6 부터) <br /><br />
<a href="#0">문서의 최상단으로</a><br /><br />


<a name="2" />
<h4>2. 클래스 확장 기능으로 추가 (0.7)</h3>
모든 프로젝트가 아닌 특정 컨트롤러에서만 이용되는 경우,
수행 시간을 줄이기 위해 해당 클래스에만 삽일할 수 있습니다.<br /><br />
{=cst()}
class Foo extends Controller
{
    var $use_components = array(<font color="red"><b>"tf_mailer"</b></font>, ...);
    
    ..
    
}
{=ced()}
<br /><br />
<a href="#0">문서의 최상단으로</a><br /><br />

<a name="3" />
<h4>3. 컴포넌트의 라우팅 설정(0.7)</h3>
<b><font color="red">* 이 부분은 0.8 에서 다시 폐지되었습니다</b></font><br />
(0.8 부터는 각 컴포넌트를 제작하는 시점에 추가적인 라우팅 룰을 정의할 수 있도록 하였으므로<br />
0.8 버전으로 인증된 컴포넌트에는 아래의 설정을 할 필요가 없습니다.)<br />
<br />
컴포넌트 기능은 완전한 페이지를 클라이언트에 제공하는 것을 목표로 하기 때문에<br />
접근 경로 보정이 필요합니다. 컴포넌트 기능을 사용할 때에는 use_route 를 true 로 설정하고<br />
settings.php의 routes 변수에 해당 컴포넌트에서 요구하는 경로를 명시해야 합니다.<br />
예를들어, 위지윅 에디터의 경우 다음과 같은 설정을 필요로 합니다.<br />
{=cst()}
var $route = array(
            ...
            <font color="red">"system/editor_add_image"          =>"*component*/editor/editor_add_image",</font>
            <font color="red">"system/editor_add_link"           =>"*component*/editor/editor_add_link",</font>
            <font color="red">"system/editor_add_image_process"  =>"*component*/editor/editor_add_image_process",</font>
            );
{=ced()}<br /><br />
<a href="#0">문서의 최상단으로</a><br /><br />


<a name="5" />
<h4>5. 컴포넌트 설치시 특별히 주의할 점</h3>
<b><font color="red">* 이 부분은 0.8 에서 다시 폐지되었습니다</b></font><br />
(0.8 부터는 각 컴포넌트의 template cache 파일 역시 tf_app/template.cache 폴더를 사용하도록<br />
변경되었습니다. 0.8 버전으로 인증된 컴포넌트에는 아래의 설정을 할 필요가 없습니다.)<br />
<br />
template_ 엔진을 사용하는 trail framework는 일반적으로 tf_app/template.cache 폴더를 
컴파일 된 탬플릿들의 저장소로 사용하고 있습니다만,
컴포넌트에 view 기능이 있는 경우 /ext/(컴포넌트폴더)/views/ 폴더를 사용하게 됩니다
해당 폴더는 www-root 사용자의 쓰기 권한이 있어야 합니다.
<a href="#0">문서의 최상단으로</a><br /><br />


<br /><br /><br /><br />
<font size="1">
문서의 끝.<br />
최초 작성일: 2010/07/15, 고빈섭<br />
최종 수정일: 2011/06/20, 고빈섭<br />
</font>
