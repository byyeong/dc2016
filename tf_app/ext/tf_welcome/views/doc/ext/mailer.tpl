<a name="0" />
<h3>문서 &gt; 확장 기능 &gt; 메일 발송</h3>
<br /><br />
이 절에서는 메일 발송 기능을 설명합니다. <br />
적용 버전: 0.6 이상의 버전에 설치할 수 있습니다. 0.5 버전에 제한적으로 적용됩니다(<a href="#5">?</a>)<br /><br />
<a href="#1">1. 메일 확장 기능의 설치</a><br />
<a href="#2">2. settings.php 의 설정</a><br />
<a href="#3">3. 멤버</a><br />
<a href="#4">4. 메일 발송 방법 / 예제</a><br />
<a href="#5">5. TF 0.5 에서의 사용 / 더 나은 성능을 위하여</a><br />
<a href="#6">6. 문제 해결</a><br />

<br />
<a name="1" />
<h4>1. 메일 확장 기능의 설치</h3>
<a href="/bin/ext/tf_mailer.zip">여기</a> 를 클릭하여 메일 확장 기능을 다운로드 합니다.<br />
다운받은 파일을 tf_app/ext 폴더 안으로 압축을 해제하는 것으로 설치가 완료입니다. <br />
그림으로 표현하면 다음과 같습니다. <br/><br/>

{=cst()}
+ [tf_app]    
&nbsp; + ...
&nbsp; + [ext]
&nbsp; &nbsp; + <b><font color="red">[tf_mailer.php]</b></font>
&nbsp; &nbsp; + <b><font color="red">[XPM]</b></font>
+ [web]
&nbsp; + ...
{=ced()}
<br />
* 붉은 색으로 표시된 부분이 새로 설치되는 부분입니다.<br />
* 배포판에 따라서는 메일 확장 기능이 이미 포함되어 있는 경우가 있습니다.<br />
&nbsp; 구 버전의 메일 확장 기능은 TLS 를 지원하지 않으므로<br />
&nbsp; 확신이 없을 경우 새로 설치하시기 바랍니다.<br />
&nbsp; 알려진 하위 호환성의 문제는 없으므로 설치하셔서 사용하시면 됩니다<br /><br />
<a href="#0">문서의 최상단으로</a><br /><br />


<a name="2" />
<h4>2. settings.php의 설정</h3>
* 확장 기능의 사용을 위해 먼저 bootstrap_apps 에 "tf_mailer" 를 다음과 같이 포함합니다.<br /><br />
{=cst()}
var $bootstrap_apps = array(
&nbsp; &nbsp; &nbsp; &nbsp; "tf_utils",
&nbsp; &nbsp; &nbsp; &nbsp; "globals",
&nbsp; &nbsp; &nbsp; &nbsp; <font color="red"><b>"tf_mailer",  // 이 부분이 새로 추가된 부분입니다.</b></font>
&nbsp; &nbsp;);
{=ced()}
<br />
순서는 상관이 없습니다.<br /><br />
* 세팅 파일의 아무 곳에나 다음의 코드를 입력하여 메일 서버를 세팅합니다.<br /><br />
{=cst()}
var $sender_name = ""; 
var $sender_password = ""; 
var $server = "112.175.232.185"; 
var $sender_user = "apis"; 
var $sender_address = "apis@mail.userstory.net"; 
var $mail_use_tls = false; 
{=ced()}
<br /><br />
sender_name 은 메일 발신자의 이름입니다.<br />
sender_password 는 발신자의 암호입니다.<br />
server 는 메일 서버의 주소입니다.<br />
sender_user 는 메일 서버의 사용자 계정입니다.<br />
sender_address 는 메일 발신자의 메일 주소입니다.<br />
mail_use_tls 는 TLS의 사용 여부를 결정합니다. gmail 등 TLS 를 이용하는 경우 true 로 설정합니다.<br /><br />
<a href="#0">문서의 최상단으로</a><br /><br />


<a name="3" />
<h4>3. 멤버 설명</h3>
이 절에서는 TF_mailer 클래스의 멤버 목록을 설명합니다.<br />
간단하게 메일을 보내는 경우 <a href="#4">4절</a>로 이동하여 바로 예제를 보는 것을 추천합니다.<br /><br />
멤버 변수<br />
mailto: 메일 수신자의 계정<br />
subject: 제목<br />
content: 메일 내용<br />
sender_name: 메일 수신자의 이름<br />
sender_address: 발신자 주소<br />
sender_password: 발신자 암호<br />
port: 메일 서버 포트<br />
server: 메일 서버 주소<br />
sender_user: 발신자 계정<br />
assigns: 탬플릿 어사인 값<br />
tpl_name: 탬플릿 이름<br /><br />
컨스트럭터<br />
TF_mailer($settings): 기본 컨스트럭터. 반드시 settings 의 인스턴스를 넘겨 주어야 합니다.<br /><br />
멤버 함수<br />
send():메일 발송<br /><br />
<a href="#0">문서의 최상단으로</a><br /><br />


<a name="4" />
<h4>4. 메일 발송 방법 / 예제</h3>
* 메일의 발송은 settings.php 의 세팅 / 탬플릿 작성 / assign 및 발송의 단계로 나누어 집니다.<br />
&nbsp; 탬플릿은 기본적인 Template_ 의 탬플릿 작성 요령에 맞추어 작성하여 /views/mail/ 폴더 안에<br />
&nbsp; 저장합니다.<br />
&nbsp; 컨트롤러 내에서의 기본적인 메일 발송 코드는 다음과 같습니다.<br />
{=cst()}
    $m = new TF_mailer($this->settings);
    $m->mailto = "binseop@gmail.com";
    $m->subject = "테스트 메일 발송입니다.";
    $m->tpl_name = "test";
    $m->assigns["name"] = "고빈섭";
    $m->assigns["iq"] = "512";
    $m->send();
{=ced()}
<br />
&nbsp; /views/mail/test.tpl 의 내용은 다음과 같다고 가정합시다.<br />
{=cst()}
    {\name} 님의 IQ 는 {\iq} 입니다.
{=ced()}
<br />
&nbsp; 컨트롤러에서 결과 tpl 을 렌더링 하는 것과 동일하게 다음과 같이 렌더링 됩니다.
{=cst()}
    고빈섭 님의 IQ 는 512 입니다.
{=ced()}
<br />
&nbsp; 해당 메일은 아래 부분의 $m->send(); 문을 만나면서 mailto 의 계정으로 발송 됩니다. <br />
&nbsp; {=...} 문을 통하여 함수를 부르거나, {@...},  {?...} 등의 탬플릿 문법들을 제한없이 사용할 수 있습니다.<br /><br />
<a href="#0">문서의 최상단으로</a><br /><br />


<a name="5" />
<h4>5. TF 0.5 에서의 사용 / 더 나은 성능을 위하여</h3>
* TF 0.6 보다 낮은 버전에서는 익스텐션 기능을 지원하지 않기 때문에 메일을 사용하기 직전에<br />
&nbsp; 메일 확장 기능을 별도로 로드 할 필요가 있습니다.<br />
&nbsp; TF 0.6 이상일 경우에도, 성능상의 잇점을 위하여 settings 의 bootstrap_apps 에 등록하지 않고<br />
&nbsp; 다음과 같이 사용될 수 있습니다.<br />
{=cst()}
include_once("../tf_app/ext/tf_mailer.php");
{=ced()}
<br />
* 위 코드를 <a href="#4">예제</a>의 코드 직전에 삽입하게 되면<br />
&nbsp; bootstrap_apps의 등록 여부와 관계 없이 부가 기능을 로드하게 되므로<br />
&nbsp; 사용이 가능 해 집니다. 또한 0.6 이상의 경우에도 메일 기능은 특정 컨트롤러에서만<br />
&nbsp; 사용되는 것이 일반적이므로 위의 방법대로 로딩하는 것이 더 나은 성능을 위한<br />
&nbsp; 좋은 선택이 됩니다. <br />
<a href="#0">문서의 최상단으로</a><br /><br />


<a name="6" />
<h4>6. 문제 해결</h3>
* 한메일에서 발송자 이름 영역이나 제목이 깨지는 경우<br />
&nbsp; => 예전 버전의 메일러가 가지는 오류입니다. 최신 버전에 해당 문제가 패치되었으므로, <a href="/bin/ext/tf_mailer.zip">여기</a>에서 다운받으세요.<br />
&nbsp; &nbsp; 알려진 호환성의 문제는 없으므로 안심하고 사용하셔도 됩니다.
<br />


<br /><br /><br /><br />
<font size="1">
문서의 끝.<br />
최초 작성일: 2010/05/04, 고빈섭<br />
최종 수정일: 2010/05/04, 고빈섭<br />
</font>
