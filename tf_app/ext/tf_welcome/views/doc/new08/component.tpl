<a name="0" />
<h3>문서 &gt; 0.8 소개 &gt; 컴포넌트</h3>
<br /><br />
여기 에서는 컴포넌트와 관련해 바뀐 사항을 소개합니다. <br />
<a href="#1">1. 라우팅 룰 추가 방식 변경</a><br />
<a href="#2">2. 이벤트 등록/삭제 방식 변경</a><br />
<a href="#3">3. 뷰 지정 방식 변경 및 오류 수정</a><br />

<br />
<a name="1" />
<h4>1. 라우팅 룰 추가 방식 변경</h3>
0.7.x 에서는 컴포넌트에 컨트롤러가 들어있는 경우,<br />
해당 컨트롤러를 수행하기 위해 사용자(개발자)가 직접 라우팅 룰을 수정해야 하는<br />
번거로움이 있었지만,<br />
<br />
0.8.0 부터 새로 추가된 add_ext_route 기능으로<br />
컴포넌트 개발자가 컴포넌트에 라우팅 룰을 추가하도록 하여,<br />
컴포넌트 사용의 편의성을 향상시켰습니다.<br />
<br/><br/>
<a href="/tf/doc/ext/about">[같이보기] 컴포넌트 개요</a><br />
<a href="/tf/doc/ext/create">[같이보기] 컴포넌트 만들기</a><br />

<a href="#0">문서의 최상단으로</a><br /><br />

<a name="2" />
<h4>2. 이벤트 등록/삭제 방식 변경</h3>
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
<br/><br/>
<a href="/tf/doc/concept/class_trail">[같이보기] class Trail</a><br />
<a href="/tf/doc/ext/about">[같이보기] 컴포넌트 개요</a><br />
<a href="/tf/doc/ext/create">[같이보기] 컴포넌트 만들기</a><br />
<a href="#0">문서의 최상단으로</a><br /><br />


<a name="3" />
<h4>3. 뷰 지정 방식 변경 및 오류 수정</h3>
기존 컴포넌트 뷰 파일 지정시 일부 OS에서 비정상 동작하는 오류가 있었으며,<br />
각 컴포넌트 폴더별로 탬플릿 캐시 폴더의 쓰기 권한을 줘야하는 불편함이 있었습니다.<br />
이를 개선하여, 내부적으로 모든 캐시를 기존 tf_app/template.cache 로 통합하였고,<br />
뷰 위치 지정방식이 바뀌었습니다.<br />
layout / tpl_name 동일하게, 컴포넌트의 경우 tf_app/ext 가 기본 폴더가 됩니다<br /><br />
{=cst()}
$this->tpl_name = "tf_welcome/views/index";
// 위의 경우 tf_app/ext/tf_welcome/views/index.tpl 파일을 참고합니다.
{=ced()}

<br/><br/>
<a href="/tf/doc/ext/create">[같이보기] 컴포넌트 만들기</a><br />
<a href="#0">문서의 최상단으로</a><br /><br />


<br /><br /><br /><br />
<font size="1">
문서의 끝.<br />
최초 작성일: 2011/06/22, 고빈섭<br />
최종 수정일: 2011/06/22, 고빈섭<br />
</font>
