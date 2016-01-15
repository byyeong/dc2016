<a name="0" />
<h3>문서 &gt; 개요</h3>
<br /><br />
이 절에서는 0.8.0 부터 새롭게 등장한 Trail Object 를 설명합니다.<br />

<a href="#1">1. 등장 배경</a><br />
<a href="#2">2. add_event_list / remove_event_list</a><br />
<a href="#3">3. add_ext_route</a><br />


<br />
<a name="1" />
<h4>1. 등장 배경</h3>
트레일이 버전이 높아지고 기능이 복잡해 지면서,<br />
bootstrap 의 구조가 복잡하여 잘 보이지 않고,<br />
너무 많은 global 수준의 function 과 variable 들이 구조적인 프로그래밍을<br />
방해하였습니다<br />
<br />
그래서 부트스트랩의 기능의 일부를 담당하고, 트레일 수행에 필요한<br />
프로퍼티들을 한데 모은, Trail class 가 등장하게 되었습니다.<br />
<br /><br />
<a name="2" />
<h4>2. add_event_list / remove_event_list</h3>
0.7.x 버전 까지는, 부트스트랩의 각 처리 단계별로 콜백을 등록할때,<br />
각 단계별 어레이에 직접 넣는 방식을 사용했습니다만,<br />
<br />
0.8.0 부터는 기존의 방식을 무시하고, 이벤트등록/삭제 메써드를 통해<br />
컴포넌트 개발이 보다 직관적으로 되도록 하며,<br />
사용자는 필요에 따라 이벤트의 삭제가 용이하도록 하였습니다.<br />
<br />
또한 기존에 각 콜백을 호출 할 때에, Setting instance 와 현재 Controller 의 instance 를<br />
argument로 넘겼으나, trail instance 하나를 넘기는 것으로 수정하였습니다.<br />
<br />
이벤트는 각 Trail 클래스의 add_event_list($_type, $_name, $_method) 로 등록하고<br />
remove_event_list($_type, $_name) 로 제거합니다.<br />
(trail 클래스는 0.8.0 부터 추가된 클래스입니다)<br />
$_type은 스트링으로 각 이벤트가 invoke 되는 포지션을 지정합니다<br />
after_routing, before_render, after_render 의 3 종류가 있으며,<br />
이는 각각 Trail::AFTER_ROUTING, Trail::BEFORE_RENDER, Trail::AFTER_RENDER 의<br />
constant 로 대응됩니다.<br /><br />
after_routing: 라우팅 후, 각 컨트롤러 클래스의 공통 before_calling() 이전 위치<br />
before_render: 각 컨트롤러 메쏘드의 invoke 후, 각 컨트롤러 클래스의 공통 before_render() 이후<br />
after_render: 탬플릿 렌더링 직후<br />
<br/>
<a href="/tf/doc/ext/create">[같이보기] 컴포넌트 만들기</a><br />
<a href="#0">문서의 최상단으로</a><br /><br />
<br />

<a name="3" />
<h4>3. add_ext_route</h3>
0.7.x 에서는 컴포넌트에 컨트롤러가 들어있는 경우,<br />
해당 컨트롤러를 수행하기 위해 사용자(개발자)가 직접 라우팅 룰을 수정해야 하는<br />
번거로움이 있었지만,<br />
<br />
0.8.0 부터 새로 추가된 add_ext_route 기능으로<br />
컴포넌트 개발자가 컴포넌트에 라우팅 룰을 추가하도록 하여,<br />
컴포넌트 사용의 편의성을 향상시켰습니다.<br />
<br />
add_ext_route($_org, $_target) method 를 이용하며<br />
$_org 에 파싱 대상의 rule 을, $_target 에 파싱 후 결과 rule 을 인자로 받습니다.<br />
파싱 룰은 기존의 routing rule 과 완전히 동일합니다.<br />
<br/><br/>
<a href="/tf/doc/ext/create">[같이보기] 컴포넌트 만들기</a><br />
<a href="#0">문서의 최상단으로</a><br /><br />
<br /><br />
<a href="#0">문서의 최상단으로</a><br /><br />
<br />
