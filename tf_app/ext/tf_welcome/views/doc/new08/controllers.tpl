<a name="0" />
<h3>문서 &gt; 0.8 소개 &gt; 컨트롤러와 관련된 새로운 기능</h3>
<br /><br />
이 절에서는 0.8버전에서 새로워진 컨트롤러와 관련된 기능을 담습니다. <br />
<a href="#1">1. view 파일 지정 형식</a><br />
<a href="#1">2. tpl include 기능</a><br />

<br /><br />
<a name="1" />
<h4>1. view 파일 지정 형식</h3>
기존의 view 파일 지정은, 클래스 이름과 같은 폴더 내부의 파일을 찾는 형식(기본값:메써드명)<br />
또는, // 를 붙여 views/ 이하 폴더를 지정할 수 있는 방식이었습니다만,<br />
// 가 의미를 알기 어렵다고 판단하여 "/" 로 간단히 변경되었고,<br />
layout 에서도 폴더 지정이 가능토록 하였습니다.<br />
<br />
다음의 예제는 Foo 클래스의 bar 메서드를 가정하겠습니다.<br />
{=cst()}
// 지정하지 않은 경우: /views/foo/bar.tpl


$this->tpl_name = "bar2";
// bar2로 지정하여 /views/foo/bar2.tpl

$this->tpl_name = "//foo2/bar2";
// (이전 방식) 폴더로 지정하여 /views/foo2/bar2.tpl

$this->tpl_name = "/foo2/bar2";
// (새 방식) 폴더로 지정하여 /views/foo2/bar2.tpl

$this->layout = "/foo2/layout";
// 레이아웃 폴더 지정하여 /views/foo2/layout.tpl
{=ced()}


<a href="#0">문서의 최상단으로</a><br /><br />


<br /><br />
<a name="2" />
<h4>2. tpl include 기능</h3>
각 탬플릿, 레이아웃 탬플릿에서 tpl 파일을 간편하게 include 할 수 있도록 하였습니다.<br />
include 된 탬플릿은 상위의 탬플릿의 assign 을 상속하므로,<br />
변수의 assign 은 별도로 하지 않습니다.<br />
$this->include_tpl($_identifier, $_tpl_name, $position="body")<br />
형식으로 include 가 가능하며,<br />
$_identifier 는 unique 한 이름 (단/ body, layout 은 예약어입니다)<br />
$_tpl_name 은 tpl 파일 위치 (tpl_name 과 동일한 룰로 작성됩니다)<br />
$position 은 include 위치입니다, 생략하면 탬플릿 바디에, "layout" 으로 지정하면<br />
레이아웃에 include 됩니다<br />
include 후, 각 view 에서 {\# identifier} 형태로 부를 수 있습니다.<br />
<br />
예를들어, views/root/foo.tpl 의 내용이 다음과 같은 경우<br />
{=cst()}
FOO
{=ced()}
<br />
views/include/global.tpl 의 내용이 다음과 같은 경우<br />
{=cst()}
GLOBAL
{=ced()}
<br />
Class Root 의 method bar() 컨트롤러의 소스로 include 를 정의합니다.<br />
{=cst()}
function bar()
{
    $this->tpl_include("test", "foo");
    $this->tpl_include("test2", "/include/global");
}
{=ced()}
<br />
원래 뷰인 views/root/bar.tpl 에서 include 를 합니다.<br />
{=cst()}
~include test~
foo.tpl: {\# test}
global.tpl: {\# test2}
{=ced()}
<br />
렌더링 된 결과는 다음과 같습니다.<br />
{=cst()}
~include test~
foo.tpl: FOO
global.tpl: GLOBAL
{=ced()}
<br /><br />
<a href="#0">문서의 최상단으로</a><br /><br />

<br /><br /><br /><br />
<font size="1">
문서의 끝.<br />
최초 작성일: 2011/06/22, 고빈섭<br />
최종 수정일: 2011/06/22, 고빈섭<br />
</font>
