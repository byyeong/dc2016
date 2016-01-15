<a name="0" />
<h3>문서 &gt; 확장 기능 &gt; 위지윅 에디터</h3>
<br /><br />
이 절에서는 위지윅 에디터 기능을 설명합니다. <br />
적용 버전: 0.7 이상의 버전에 설치할 수 있습니다.<br /><br />
<a href="#1">1. 위지윅 에디터 기능의 설치</a><br />
<a href="#2">2. settings.php 의 설정</a><br />
<a href="#3">3. 권한 설정</a><br />
<a href="#4">4. 위지윅 사용방법/예제</a><br />

<br />
<a name="1" />
<h4>1. 위지윅 에디터 확장 기능의 설치</h3>
<a href="/bin/ext/editor.zip">여기</a> 를 클릭하여 위지윅 에디터 확장 기능의 소스를 다운로드 합니다.<br />
다운받은 파일을 tf_app/ext 폴더 안으로 압축을 해제합니다<br />
다음으로 <a href="/bin/ext/editor_web.zip">여기</a> 를 클릭하여 위지윅 에디터 확장 기능의 css 등을 다운로드 합니다<br />
다운받은 파일을 web 폴더 안으로 압축을 해제하는 것으로 설치가 완료입니다. <br />
그림으로 표현하면 다음과 같습니다. <br/><br/>

{=cst()}
+ [tf_app]    
&nbsp; + ...
&nbsp; + [ext]
&nbsp; &nbsp; + <b><font color="red">[editor]</b></font>
&nbsp; &nbsp; &nbsp; + <b><font color="red">controller.php</b></font>
&nbsp; &nbsp; &nbsp; + <b><font color="red">editor.php</b></font>
&nbsp; &nbsp; &nbsp; + <b><font color="red">[views]</b></font>
&nbsp; &nbsp; &nbsp; &nbsp; + <b><font color="red">editor.tpl</b></font>
&nbsp; &nbsp; &nbsp; &nbsp; + <b><font color="red">editor_add_image.tpl</b></font>
&nbsp; &nbsp; &nbsp; &nbsp; + <b><font color="red">editor_add_image_process.tpl</b></font>
&nbsp; &nbsp; &nbsp; &nbsp; + <b><font color="red">editor_add_link.tpl</b></font>
+ [web]
&nbsp; + ...
&nbsp; + <b><font color="red">[css]</b></font>
&nbsp; &nbsp; + <b><font color="red">editor.css</b></font>
&nbsp; &nbsp; + <b><font color="red">popup.css</b></font>
&nbsp; + <b><font color="red">[js]</b></font>
&nbsp; &nbsp; + <b><font color="red">editor.js</b></font>
&nbsp; &nbsp; + <b><font color="red">popup.css</b></font>
&nbsp; + <b><font color="red">[images]</b></font>
&nbsp; &nbsp; + <b><font color="red">btn_cancel.gif</b></font>
&nbsp; &nbsp; + <b><font color="red">btn_submit.gif</b></font>
&nbsp; &nbsp; + <b><font color="red">[editor]</b></font>
&nbsp; &nbsp; + <b><font color="red">... (20개의 파일)</b></font>
{=ced()}
<br />
* 붉은 색으로 표시된 부분이 새로 설치되는 부분입니다.<br />
* 0.6.1 이하 버전은 컴포넌트 기능 이 없으므로 확장 기능으로서의 위지윅 에디터를 사용할 수 없습니다.<br />
<a href="#0">문서의 최상단으로</a><br /><br />


<a name="2" />
<h4>2. settings.php의 설정</h3>
* 에디터 URL 을 라우팅에 추가하는 걸로 메인 설정이 끝납니다.<br />
{=cst()}
var $route = array(
            ...
            <font color="red">"system/editor_add_image"          =>"*component*/editor/editor_add_image",</font>
            <font color="red">"system/editor_add_link"           =>"*component*/editor/editor_add_link",</font>
            <font color="red">"system/editor_add_image_process"  =>"*component*/editor/editor_add_image_process",</font>
            );
{=ced()}
<a href="#0">문서의 최상단으로</a><br /><br />


<a name="3" />
<h4>3. 권한 설정</h3>
* /ext/editor/views/ 디렉토리는 웹 서버 사용자가 읽기/쓰기 권한을 가지고 있어야 합니다.<br />
&nbsp; 예를들어, apache 사용자라면 다음과 같이 설정할 수 있습니다<br />
{=cst()}
root@Haruhi:/home/tf_testor/tf_app/ext/editor/views# <font color="red"><b>chown www-data .</b></font>
{=ced()}
<br />
웹 서버의 사용자명은, 서버 종류는 물론, 관리자의 설정에 따라 다를 수 있으므로, 에러가 나면<br />
서버 관리자에게 문의하시기 바랍니다.<br /><br />
<a href="#0">문서의 최상단으로</a><br /><br />


<a name="4" />
<h4>4. 위지윅 사용방법/예제</h3>
* 위지윅의 작동은 다음과 같습니다.
1. 에디터를 사용할 해당 컨트롤러의 클래스 변수에 editor를 다음과 같이 포함합니다.<br /><br />
{=cst()}
var $use_components = array(<font color="red"><b>"editor/editor"</b></font>, ...);
{=ced()}
<br />
&nbsp; 만일 다른 컴포넌트를 사용하고 있다면 어레이 안에 덧붙이는 형태로 하시면 됩니다.<br />
&nbsp; * TIP: bootstrap_apps 에 등록하는 것도 전체 컨트롤러에서 동일한 효과를 발휘합니다. <a href="/tf/doc/new07/use_component_vs_external_apps/">차이점 보기</a><br /><br />

2. 데이터를 사용할 해당 컨트롤러의 코드부분(메써드 안) 에서 $this->load_editor(); 를 이용하여<br >
&nbsp; &nbsp; 에디터 이용을 선언합니다.<br ><br />
3. 에디터를 이용할 view 페이지에 에디터를 이용할 DIV 를 생성하고 내부에 {\# editor} 의 코드를 삽입합니다.<br ><br />
4. 해당 페이지의 아래쪽에 에디터를 준비시키는 스크립트, set_editor(); 를 실행합니다.<br ><br />
5. 만일 에디터 안에 넣어야 할 데이터가 있다면, htmleditor.document.body.innerHTML = "데이터"; 와 같이 준비시킵니다.<br /><br />
6. 작성이 완료된 데이터는 htmleditor.document.body.innerHTML 를 이용해 받아옵니다.<br >
{=ced()}

<br />
* 1~2의 과정에 대한 예제는 다음과 같습니다:
{=cst()}
    class Admin extends Controller
    {
        var $assigns = array();
        var $assigns_layout = array();
        var $layout = "admin";
        var $use_models = array();
        <font color="red"><b>var $use_components = array("editor/editor");</b></font>

        function foo()
        {
            <font color="red"><b>$this->load_editor();</b></font>
        }
    }
    
{=ced()}
* 3~6의 과정에 대한 예제는 다음과 같습니다:
{=cst()}
&lt;form>
&lt;div>{\# editor}&lt;/div>
&lt;input type="hidden" name="cont" />
&lt;button value="작성완료" onclick="go();" />
&lt;/form>
&lt;script>
    
    // 에디터를 준비합니다. DIV 이후에 반드시 호출
    set_editor();
    
    // (필요할 경우) 기본 데이터를 넣어둡니다.
    htmleditor.document.body.innerHTML = "초기 데이터";
    
    function go()
    {
        // 히든으로 실 데이터를 넘깁니다.
        document.getElementById("cont").value = htmleditor.document.body.innerHTML;
    }
    
&lt;/script>
{=ced()}
<a href="#0">문서의 최상단으로</a><br /><br />

<br />
