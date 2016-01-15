<a name="0" />
<h3>문서 &gt; 확장 기능 &gt; SNS Utils</h3>
<br /><br />
이 절에서는 SNS Utils를 설명합니다. <br /><br />
외부 SNS와 연동(인증)하고, 가장 많이 사용되는 기능인, 글 작성 기능읻 들어 있습니다.<br />
다른 기능들에 대해서는 추후에 보강될 예정입니다.<br /><br />
적용 버전: 0.8 이상의 버전에 설치할 수 있습니다.<br />0.7.x 버전의 사용을 위해서는 <a href="#6">추가적인 세팅</a>이 필요합니다. 0.7이전 버전은 호환되지 않습니다.<br /><br />
<a href="#1">1. SNS Utils의 설치</a><br />
<a href="#2">2. 전역 settings.php 의 설정</a><br />
<a href="#settings">3. 컴포넌트 설정</a><br />
<a href="#4">4. 인증(연동) 하기</a><br />
<a href="#5">5. 글 쓰기 방법</a><br />
<a href="#6">6. TF 0.7.x 에서의 사용</a><br />

<br />
<a name="1" />
<h4>1. SNS Utils의 설치</h3>
SNS Utils는 0.8.0 이상 버전의 트레일 패키지에 기본적으로 포함되어 있습니다만,<br />
없는 경우 지원 페이지에서 파일을 다운 받고,<br />
다운받은 파일을 tf_app/ext 폴더 안으로 압축을 해제하는 것으로 설치가 완료입니다. <br />
그림으로 표현하면 다음과 같습니다. <br/><br/>

{=cst()}
+ [tf_app]    
&nbsp; + ...
&nbsp; + [ext]
&nbsp; &nbsp; + <b><font color="red">[tf_sns_utils]</b></font>
&nbsp; &nbsp; &nbsp; &nbsp; - <b><font color="red">controller.php</b></font>
&nbsp; &nbsp; &nbsp; &nbsp; - <b><font color="red">info.php</b></font>
&nbsp; &nbsp; &nbsp; &nbsp; - <b><font color="red">OAuth.php</b></font>
&nbsp; &nbsp; &nbsp; &nbsp; - <b><font color="red">settings.php</b></font>
&nbsp; &nbsp; &nbsp; &nbsp; - <b><font color="red">twitteroauth.php</b></font>
+ [web]
&nbsp; + ...
{=ced()}
<br />
* 붉은 색으로 표시된 부분이 새로 설치되는 부분입니다.<br />
<a href="#0">문서의 최상단으로</a><br /><br />


<a name="2" />
<h4>2. 전역 settings.php의 설정</h3>
* 확장 기능의 사용을 위해 먼저 /tf_app/settings/settings.php bootstrap_apps 에 "tf_sns_utils/info" 를 다음과 같이 포함합니다.<br /><br />
{=cst()}
var $bootstrap_apps = array(
&nbsp; &nbsp; &nbsp; &nbsp; "tf_utils",
&nbsp; &nbsp; &nbsp; &nbsp; "globals",
&nbsp; &nbsp; &nbsp; &nbsp; <font color="red"><b>"tf_sns_utils/info",  // 이 부분이 새로 추가된 부분입니다.</b></font>
&nbsp; &nbsp;);
{=ced()}
<br />
순서는 상관이 없습니다.<br /><br />
<a href="#0">문서의 최상단으로</a><br /><br />

<a name="settings" />
<h4>3. 컴포넌트 설정</h3>
이 절에서는 tf_sns_utils를 이용하기 위한 컴포넌트 설정을 설명합니다.<br />
세팅 대상은 ext/tf_sns_utils/settings.php 파일입니다.<br /><br />
세팅 해야할 변수 목록<br />
{=cst()}
twitter_consumer_key: 트위터 컨슈머 키, 트위터 홈 페이지에서 발급받습니다.
twitter_consumer_secret: 트위터 컨슈머 시크릿, 트위터 홈 페이지에서 발급받습니다.
twitter_callback: 트위터 콜백 URL, 트위터 인증 작업후, 돌아갈 URL(내부 URL)을 적습니다

facebook_consumer_key: 페이스북 컨슈머 키, 페이스북 <a href="http://developers.facebook.com/setup/">홈 페이지</a>에서 발급받습니다.
facebook_consumer_secret: 페이스북 컨슈머 시크릿, 페이스북 홈 페이지에서 발급받습니다.
facebook_callback: 페이스북 콜백 URL, 페이스북 인증 작업후, 돌아갈 URL(내부 URL)을 적습니다

me2day_key: 미투데이 API 키, 미투데이 <a href="http://me2day.net/me2/app/get_appkey">홈 페이지</a>에서 발급받습니다.
me2day_callback: Me2day 콜백 URL, Me2day 인증 작업후, 돌아갈 URL(내부 URL)을 적습니다
{=ced()}
<br />
* 주의: 미투데이 키 발급시, 발급후 키 관리 페이지에서 웹 기반 인증 아래의 콜백 주소에<br />
(서비스 주소)/tf_sns_utils/me2day_auth_res 를 반드시 설정 해 주셔야 합니다.<br />
<br />
사용하지 않는 서비스의 경우에는 작성하지 않으셔도 무방합니다
callback URL 의 구체적인 동작에 대해서는 <a href="#4">인증하기</a>란을 참고하시기 바랍니다.

<a href="#0">문서의 최상단으로</a><br /><br />


<a name="4" />
<h4>4. 인증하기</h3>
트위터 인증은 /tf_sns_utils/twitter_auth/ 를 호출하는 것으로 시작합니다,<br />
유사하게, 미투데이는 /tf_sns_utils/facebook_auth/ , 페이스북은 /tf_sns_utils/me2day_auth/ 의 주소가 됩니다.<br />
<br />
인증 절차 수행 후, 인증시 받아온 각 정보를 세션에 넣고, settings.php 에서 지정된<br />
콜백 URL 로 direct 시킵니다. 각 개발자는 세션으로 받아온 정보를 DB에 갱신하는 것으로<br />
인증이 완료됩니다.<br />
<br />
다음은 각 서비스별 세션 반환 값입니다. * 표시된 부분은 인증에 필요한 부분입니다.<br /><br />
Twitter 반환 값 (세션명: tf_twitter)<br />
{=cst()}
- tid: twitter 사용자 tid
- screen_name: twitter 사용자 screen_name
- photo_url: twitter 사용자 이미지 URL
- twitter_key: twitter 토큰 키*
- twitter_secret: twitter 토큰 시크릿*
{=ced()}
<br />
Facebook 반환 값 (세션명: tf_facebook)<br />
{=cst()}
- facebook_secret: facebook 토큰 시크릿*
{=ced()}
<br />
Me2day 반환 값 (세션명: tf_me2day)<br />
{=cst()}
- me2day_id: me2day 계정 ID*
- me2day_apikey: me2day 사용자 API 키*
{=ced()}
<a href="#0">문서의 최상단으로</a><br /><br />

<a name="5" />
<h4>5. 글 쓰기</h3>
글 쓰기는 twitter_post, facebook_post, me2day_post 펑션을 이용합니다.<br />
각각 인증하기에서 받은 토큰 값 (미투데이의 경우 ID와 API 키), 그리고 작성할 글의 내용을 받아<br />
글을 작성합니다.<br />
<br />
- Twitter 의 경우.
{=cst()}
    // 글 내용을 받아옵니다.
    $cont = $_REQUEST["cont"];
    
    // 트위터 컨슈머 key/secret 을 받아옵니다.
    // 샘플에서는 세션에 저장되었으므로 세션의 내용을 받아옵니다.
    // 보통은, DB에 저장하고 DB에서 불러오는 것이 일반적입니다.
    
    $key = $_SESSION["tf_twitter"]["twitter_key"];
    $secret = $_SESSION["tf_twitter"]["twitter_secret"];
    
    // sns_utils 에 포함된 twitter_post 를 부릅니다.
    // twitter_post는 내용을 자동으로 140자로 맞춰주므로, 별다른 처리는
    // 필요치 않습니다.
    // 작성 성공시 작성 글의 tid 를 반환합니다. (실패시 false 반환)
    $result = twitter_post($key, $secret, $cont);
{=ced()}
<br />
<br />
- me2day 의 경우.
{=cst()}
    // 글 내용을 받아옵니다.
    $cont = $_REQUEST["cont"];
    
    // me2day id/api key 를 받아옵니다.
    // 샘플에서는 세션에 저장되었으므로 세션의 내용을 받아옵니다.
    // 보통은, DB에 저장하고 DB에서 불러오는 것이 일반적입니다.
    
    $id = $_SESSION["tf_me2day"]["me2day_id"];
    $apikey = $_SESSION["tf_me2day"]["me2day_apikey"];
    
    // sns_utils 에 포함된 me2day_post 를 부릅니다.
    // me2day_post는 내용을 자동으로 160자로 맞춰주므로, 별다른 처리는
    // 필요치 않습니다.
    // 작성 성공시 작성 글의 퍼머링크를 를 반환합니다. (실패시 false 반환)
    $result = me2day_post($id, $apikey, $cont);
{=ced()}
<br />
<br />
- facebook 의 경우.
{=cst()}
    // 글 내용을 받아옵니다.
    $cont = $_REQUEST["cont"];
    
    // 페이스북 컨슈머 secret 을 받아옵니다.
    // 샘플에서는 세션에 저장되었으므로 세션의 내용을 받아옵니다.
    // 보통은, DB에 저장하고 DB에서 불러오는 것이 일반적입니다.
    
    $secret = $_SESSION["tf_facebook"]["facebook_secret"];
    
    // sns_utils 에 포함된 facebook_post 를 부릅니다.
    // 작성 성공시 작성 글의 id 를 반환합니다. (실패시 false 반환)
    $result = facebook_post($secret, $cont);
{=ced()}
<br />

<a href="#0">문서의 최상단으로</a><br /><br />


<a name="6" />
<h4>6. TF 0.7 에서의 사용</h3>
* TF 0.7 보다 낮은 버전에서는 익스텐션 기능을 지원하지 않기 때문에 사용이 불가능합니다.<br />
* TF 0.7.x 버전의 경우, 컴포넌트의 URL ROUTING 등록이 자동으로 이루어지지 않기 때문에,
tf_app/settings/settings.php 의 라우팅 설정을 추가로 할 필요가 있습니다.
{=cst()}
var $route = array(
        ...
        <font color="red">"tf_sns_utils/twitter_auth" => "*component*/Tf_sns_utils/twitter_auth",</font>
        <font color="red">"tf_sns_utils/twitter_auth_res" => "*component*/Tf_sns_utils/twitter_auth_res",</font>
        
        <font color="red">"tf_sns_utils/me2day_auth" => "*component*/Tf_sns_utils/me2day_auth",</font>
        <font color="red">"tf_sns_utils/me2day_auth_res" => "*component*/Tf_sns_utils/me2day_auth_res",</font>
        
        <font color="red">"tf_sns_utils/facebook_auth" => "*component*/Tf_sns_utils/facebook_auth",</font>
        <font color="red">"tf_sns_utils/facebook_auth_res" => "*component*/Tf_sns_utils/facebook_auth_res",</font>
        );
{=ced()}



<br /><br /><br /><br />
<font size="1">
문서의 끝.<br />
최초 작성일: 2011/06/20, 고빈섭<br />
최종 수정일: 2011/06/60, 고빈섭<br />
</font>
