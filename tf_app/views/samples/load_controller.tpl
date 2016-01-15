<br />
<h2>내부에서 컨트롤러 로드</h2>
<br />
트레일 프레임워크 0.8 부터는 콘트롤러 내부 혹은 모델, 컴포넌트 등에서<br />
새 Trail 오브젝트를 생성하여, 렌더링 한 결과를 포함하거나,<br />
스트링으로 반환받을 수 있게 되었습니다.<br />
<br />
먼저, 트레일 인스턴스를 생성합니다.<br />
$inner_trail = new Trail("/samples/load_controller_inner");<br />
<br />
트레일은 이 이후 모델/컴포넌트 로딩/라우팅 등<br />
여러가지 작업을 거치게 되어 있습니다만,<br />
간단하게, work_through() 메써드를 이용하면 렌더링 직전까지의 작업을 완료합니다<br />
<br />
$inner_trail->work_through();<br />
<br />
이제, 렌더링만 하면 됩니다. 일반적인 렌더링은 다음처럼 할 수 있습니다.<br />
$inner_trail->method_invoke();<br />
<br />
다만, 렌더링 한 결과를 텍스트로 반환받고 싶다면<br />
$ret = $inner_trail->method_invoke(true);<br />
형태로 받으실 수 있습니다.<br />
<br />
<br />
실제로 지금 보시는 샘플 페이지에는,<br />
다음의 과정을 거쳐, 별도의 컨트롤러를 로딩 한 상태입니다.<br />
$inner_trail = new Trail("/samples/load_controller_inner");<br />
$inner_trail->work_through();<br />
<br />
$this->assigns["inner_trail"] = $inner_trail;<br />
<br />
자, 이제 이 것을 여기에 {#inner_trail->method_invoke()}를 통해 렌더링 해 보겠습니다.<br />
{inner_trail->method_invoke()}<br />
<br /><br />
이번에는 컨트롤러에서 method_invoke(true)를 이용해 렌더링 결과를 스트링으로 받은 값을 보겠습니다.<br />
{inner_trail_rendered}<br />
<br /><br />
include_tpl 은 탬플릿(view) 자체만 include 했다면,<br />
이것은 라우팅부터 시작하여 프레임워크의 전체 작업을 처리합니다.<br />
<br />