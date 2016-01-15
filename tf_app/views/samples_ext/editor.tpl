컴포넌트 샘플 - HTML EDITOR<br />
<br />
이 페이지는 HTML에디터 샘플입니다.<br /><br />
1. 에디터를 부를 때에는 tpl의 해당 위치에 {\# editor} 를 입력하시면 됩니다.
   다음과 같은 입력 화면이 나옵니다.
<div>
{#editor}
<br /><br />

2. 에디터를 로드하는 위치 다음에 에디터를 사용가능하게 준비하여야 합니다.<br />
자바스크립트 set_editor(); 을 호출하는 것으로 준비는 완료 됩니다.<br />
<br /><br />

3. 에디터에 이전에 작성한 내용을 집어넣는 경우,<br />
htmleditor.document.body.innerHTML 에 직접 assign 을 할 수 있습니다.<br />
예를 들어, <a href="#" onclick="set_default();return false;">여기</a> 를 눌러서 htmleditor.document.body.innerHTML 의 효과를<br />
확인 해 봅시다.<br />
<br /><br />
4. 에디터의 값을 받아오는 것은, htmleditor.document.body.innerHTML 의 값을 가져오는 것으로<br />
간단히 받아올 수 있습니다.<br />
<a href="#" onclick="get_html();return false;">여기</a> 를 눌러서 htmleditor.document.body.innerHTML 의 값을<br />
확인 해 봅시다.<br />

<script>
    set_editor();
    
    function set_default()
    {
        htmleditor.document.body.innerHTML = "htmleditor.document.body.innerHTML 을 이용해서 기본 데이터를 넣어 보았습니다.";
    }
    
    function get_html()
    {
        alert(htmleditor.document.body.innerHTML);
    }
</script>

</div>
