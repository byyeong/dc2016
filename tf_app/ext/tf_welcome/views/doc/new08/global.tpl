<a name="0" />
<h3>문서 &gt; 0.8 소개 &gt; 부트스트랩/전역변수 관련</h3>
<br /><br />
<a href="#1">1. Trail class 의 등장</a><br />
<a href="#2">2. 전역 변수의 변화</a><br />
<a href="#3">3. 404 에러 처리</a><br />


<br /><br />
<a name="1" />
<h4>1. Trail class 의 등장</h3>
그래서 부트스트랩의 기능의 일부를 담당하고, 트레일 수행에 필요한<br />
프로퍼티들을 한데 모은, Trail class 가 새롭게 추가되었습니다.<br />
<br />
<a href="/tf/doc/concept/class_trail">[같이보기] class Trail</a><br />
<a href="#0">문서의 최상단으로</a><br /><br />

<a name="2" />
<h4>2. 전역 변수의 변화</h3>
기존의 전역 변수들은 다음과 같은 방식으로 접근 방법이 변화됩니다.<br />
$trail 오브젝트는 콘트롤러에서 _trail 멤버로 assign 되므로,<br />
콘트롤러 내부에서는 $this->_trail 로 접근이 가능합니다.<br /><br />
<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <td>기존</td>
        <td>변화</td>
        <td>설명</td>
    </tr>
    <tr>
        <td>$args</td>
        <td>$trail->_arguments_all</td>
        <td>모델 풀</td>
    </tr>
    <tr>
        <td>$argv</td>
        <td>$trail->_arguments</td>
        <td>주소를 파싱한 파라미터 어레이(메서드 포함)</td>
    </tr>
    <tr>
        <td>$tf_url</td>
        <td>$trail->_url</td>
        <td>주소를 파싱한 파라미터 어레이</td>
    </tr>
    <tr>
        <td>$settings</td>
        <td>$trail->_settings</td>
        <td>Settings instance</td>
    </tr>
    <tr>
        <td>$current_controller</td>
        <td>$trail->_current_controller</td>
        <td>Controller instance</td>
    </tr>
    <tr>
        <td>$use_component</td>
        <td>$trail->_use_component</td>
        <td>컴포넌트 콘트롤러 여부</td>
    </tr>
    <tr>
        <td>$before_calling_ext</td>
        <td>$trail->before_calling (구조 변화됨)</td>
        <td>invoke 전 이벤트</td>
    </tr>
    <tr>
        <td>$before_render_calls</td>
        <td>$trail->_before_render (구조 변화됨)</td>
        <td>render 전 이벤트</td>
    </tr>
    <tr>
        <td>$last_calls</td>
        <td>$trail->_after_render (구조 변화됨)</td>
        <td>render 후 이벤트</td>
    </tr>
    <tr>
        <td>(신규)</td>
        <td>$trail->_root_dir</td>
        <td>서버 루트 폴더 (tf_app 위치) ex; /opt/npub/tf_app </td>
    </tr>
    <tr>
        <td>(신규)</td>
        <td>$trail->_server_url</td>
        <td>웹 루트 URL (슬래시 포함) ex; http://npub.kr/ </td>
    </tr>
</table>
마지막 세번째 이벤트 관련된 부분은 <a href="/tf/doc/new08/component#2">이곳</a>을 참고하여 주시기 바랍니다 . <br />

<a href="#0">문서의 최상단으로</a><br /><br />

<br /><br />
<a name="3" />
<h4>3. 404 에러 처리</h3>
기존 settings에 page_404 프로퍼티에 주소를 넣으면,<br />
해당 주소로 리다이렉트 처리를 하였습니다만,<br />
이제는 주소(스트링) 이외에 펑션을 넣어 처리할 수도 있게 되었습니다.<br />
(기존의 방식도 그대로 유지됩니다.<br />
파라미터로 호출 URL 을 보내줍니다.<br />
<br />
새로 추가된 <a href="/tf/doc/new08/load_controller">내부 컨트롤러 로드</a> 기능과 조합하여<br />
보다 보기 좋은 404 처리가 가능 해 졌습니다.<br />
<br />
또한, 각 컨트롤러의 어디에서도,<br />
$this->_trail->_throw(404) 를 이용하여 동일한 에러 처리가 가능합니다.<br />
<br />
{=cst()}

    class Settings
    {
        ...
        
        var $page_404   = handler_404;  // 펑션으로 지정
        
        ...
        
    }

    function handler_404($_url)         // 핸들러 내부
    {// SAMPLE 404 handler.
        
        print("sorry, page not found..");
        print("you requested: /" . $_url);
    }
{=ced()}

<br />
<a href="/tf/doc/new08/load_controller">[같이보기] 내부 컨트롤러 로드</a><br />
<a href="#0">문서의 최상단으로</a><br /><br />


<br /><br /><br /><br />
<font size="1">
문서의 끝.<br />
최초 작성일: 2011/06/22, 고빈섭<br />
최종 수정일: 2011/06/24, 고빈섭<br />
</font>
