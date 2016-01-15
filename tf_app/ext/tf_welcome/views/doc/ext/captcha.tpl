<a name="0" />
<h3>문서 &gt; 확장 기능 &gt; Captcha</h3>
<br /><br />
이 절에서는 한글 캡챠 기능을 설명합니다. <br />
적용 버전: 0.7 이상의 버전에 설치할 수 있습니다.<br /><br />
<a href="#1">1. 한글 캡챠 확장 기능의 설치</a><br />
<a href="#2">2. settings.php 의 설정</a><br />
<a href="#3">3. 캡챠 사용 방법 / 예제</a><br />

<br />
<a name="1" />
<h4>1. 한글 캡챠 확장 기능의 설치치</h3>
<a href="/bin/ext/captcha.zip">여기</a> 를 클릭하여 한글 캡챠 확장 기능을 다운로드 합니다.<br />
다운받은 파일을 tf_app/ext 폴더 안으로 압축을 해제하는 것으로 설치가 완료입니다. <br />
그림으로 표현하면 다음과 같습니다. <br/><br/>

{=cst()}
+ [tf_app]    
&nbsp; + ...
&nbsp; + [ext]
&nbsp; &nbsp; + <b><font color="red">[captcha]</b></font>
&nbsp; &nbsp; &nbsp; + <b><font color="red">captcha_back.jpg</b></font>
&nbsp; &nbsp; &nbsp; + <b><font color="red">controller.php</b></font>
&nbsp; &nbsp; &nbsp; + <b><font color="red">MALGUN.TTF</b></font>
&nbsp; &nbsp; &nbsp; + <b><font color="red">settings.php</b></font>
{=ced()}
<br />
* 붉은 색으로 표시된 부분이 새로 설치되는 부분입니다.<br />
* 0.6.1 이하 버전은 컴포넌트 기능 이 없으므로 확장 기능으로서 캡챠를 사용할 수 없습니다.<br />
 &nbsp; 제공되는 controller.php 의 내용을 복사하여 별도의 컨트롤러로 이용할 수 있습니다.<br />
<a href="#0">문서의 최상단으로</a><br /><br />


<a name="2" />
<h4>2. settings.php의 설정</h3>
* 캡챠 확장은 부트스트랩 앱이 아닌 컴포넌트로 동작하므로 bootstrap_apps 에는 추가하지 않습니다.<br />
* 캡챠 URL 을 라우팅에 추가하는 걸로 메인 설정이 끝납니다.<br />
{=cst()}
var $route = array(

	...

        "captcha"         =>"*component*/captcha/captcha",
                );
{=ced()}
* 위 예제는 /captcha 로 접근하면 해당 캡챠 페이지가 나옴을 의미합니다.<br /><br />
* 글로벌 세팅 이외에 /tf_app/ext/captcha/settings.php 파일에서 캡챠 세부 세팅이 이루어 집니다<br />
* 이 부분에서 캡챠에 나올 글자 시드들과 세션의 키값을 세팅합니다.<br />
{=cst()}
    $captcha_seed = array("test", "테스트", "트레일");	// 시드 값
    $captcha_session_key = "captcha";			// 세션 키값
{=ced()}
<a href="#0">문서의 최상단으로</a><br /><br />


<a name="3" />
<h4>3. 캡챠 사용 방법 / 예제</h3>
* 캡챠의 작동은 다음과 같습니다.
{=cst()}
1. 라우팅에 정의된 url을 img 태그 등으로 부르면 렌더링 된 글자가 나옵니다.
2. input tag 등을 이용하여 사용자가 입력한 답을 받습니다
3. 다음 페이지에서 $captcha_session_key 에 해당하는 세션에 담긴 캡챠 정답과 비교합니다.
{=ced()}

* 예제는 다음과 같습니다: 1. 캡챠를 보일 임의의 tpl 혹은 html
{=cst()}
&lt;form ... &gt;
    &lt;img src="/captcha/"&gt;
    &lt;input name="captcha_answer" /&gt;
    &lt;input type="submit" /&gt;
</form>
{=ced()}
* 2. 결과
{=cst()}
    if ($_REQUEST["captcha_answer"] == $_SESSION["captcha"])
    {
        // ok
    }
    else
    {
        // fail
    }
    
{=ced()}
<a href="#0">문서의 최상단으로</a><br /><br />

<br />
