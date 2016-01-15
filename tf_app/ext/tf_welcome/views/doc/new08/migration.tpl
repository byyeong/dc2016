<a name="0" />
<h3>문서 &gt; 0.8 소개 &gt; 마이그레이션 가이드</h3>
<br /><br />
0.6/0.7 버전의 소스코드를 0.8 버전으로 마이그레이션 하기 위한 가이드입니다.<br />
<a href="#1">1. 모델 파일에서 선언 삭제</a><br />
<a href="#2">2. 전역 변수의 변화</a><br />
<a href="#2">3. 컴포넌트 관련 변화</a><br />

<br /><br />
<a name="1" />
<h4>1. 모델 파일에서 선언 삭제</h3>
각 모델 파일의 최하단의 선언부를 삭제합니다.<br /><br />
DEFAULT 모델이 아닌 모델의 세팅을 사용할 경우, <br />
모델 멤버 변수로 $_db_master 를 지정하여야 합니다.<br />
읽기 DB가 별도인 경우에는 $_db_read 를 지정하셔야 합니다.<br />
{=cst()}
    class TM_Synonymous_links_model extends Model
    {
        var $tablename = "synonymous_links";
        var $_db_master = "TWEETMIX_DB1";
        
        ...
{=ced()}

<a href="#0">문서의 최상단으로</a><br /><br />

<a name="2" />
<h4>2. 전역 변수의 변화</h3>
Trail class 의 추가와 함께 대부분의 전역 변수들의 사용이 금지되었습니다.
변화된 테이블을 참고하여 수정하십시오.
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
</table>
<br />
<a href="#0">문서의 최상단으로</a><br /><br />

<a name="3" />
<h4>3. 컴포넌트 관련 변화</h3>
트레일에서 배포하는 주요 컴포넌트는 새 버전에 맞게 수정되어<br />
이 패키지와 함께 배포되었습니다.<br />
수정되어 새로 배포된 컴포넌트들은 이름 끝에 "8" 이 붙어 있습니다.<br />
settings->bootstrap_apps 에서 사용 컴포넌트의 이름을 바꾸셔야 합니다.<br />
<br />
자체 제작한 컴포넌트가 있는 경우는<br />
2절의 전역변수와 <a href="/tf/doc/new08/component#2">이벤트 등록 부분의 수정</a>이 필요합니다.<br />
<br />
<a href="#0">문서의 최상단으로</a><br /><br />

<br /><br /><br /><br />
<font size="1">
문서의 끝.<br />
최초 작성일: 2011/06/22, 고빈섭<br />
최종 수정일: 2011/06/22, 고빈섭<br />
</font>
