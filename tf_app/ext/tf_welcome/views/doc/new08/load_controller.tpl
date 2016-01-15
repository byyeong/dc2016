<a name="0" />
<h3>문서 &gt; 0.8 소개 &gt; 내부에서 컨트롤러 로드</h3>
<br /><br />
트레일 프레임워크 0.8 부터는 콘트롤러 내부 혹은 모델, 컴포넌트 등에서<br />
새 Trail 오브젝트를 생성하여, 렌더링 한 결과를 포함하거나,<br />
스트링으로 반환받을 수 있게 되었습니다.<br /> <br />

호출할 주소를 파라미터로 하는 Trail instance 를 생성하고,<br />
work_through() 메써드로 선처리 작업을 일괄 처리한 후,<br />
<br />
method_invoke($_to_string = false) 메써드로 렌더링 시킵니다.<br />
인자인 $_to_string 을 주지 않을 경우에는, 현재 위치에 그대로 렌더링,<br />
true 로 할 경우에는 렌더링 된 결과를 스트링으로 반환합니다.<br />
<br />

{=cst()}

$inner_trail = new Trail("/samples/load_controller_inner");
// /samples/load_controller_inner 주소를 렌더링 하는 것으로 선언합니다.

$inner_trail->work_through();
// 모델, 컴포넌트, 라우팅 등 각종 선처리 작업을 일괄로 처리합니다.

$ret = $inner_trail->method_invoke(true);
// 렌더링 결과가 $ret 로 반환됩니다.

{=ced()}
<br /><br />
Trail 오브젝트를 views 로 assign 한 후 view 에서 렌더링 할 수도 있습니다.
{=cst()}
{\inner_trail->method_invoke}
{=ced()}


<br /><br />
<a href="#0">문서의 최상단으로</a><br /><br />

<br /><br /><br /><br />
<font size="1">
문서의 끝.<br />
최초 작성일: 2011/06/24, 고빈섭<br />
최종 수정일: 2011/06/24, 고빈섭<br />
</font>
