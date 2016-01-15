SNS 샘플 - Me2day 콜백<br />
<br />
이 페이지는 Me2day로 연동 후,<br />
연동된 데이터를 각 프로젝트와 연동하기 위한 페이지의 샘플입니다.<br />
<br />
Trail의 tf_sns_utils 컴포넌트는 Me2day와 연동 후,<br />
API 이용에 필요한 정보 (ID/API KEY)를<br />
세션에 넣어 전달합니다. 세션명은 "tf_me2day" 입니다,<br />
콜백 URL 은 ext/tf_sns_utils/settings.php 에서<br />
$me2day_callback 변수를 수정하는 것으로 지정할 수 있습니다.<br />
지속적인 처리를 위해 지정된 콜백 URL 에서<br />
DB에 해당 값을 넣는 등의 작업을 하시기 바랍니다.<br /><br />
현재 "tf_me2day" 세션 내의 실제 내용은 다음과 같습니다<br />
<br />
<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <td>KEY</td>
        <td>VALUE</TD>
    </tr>
{@ret}
    <tr>
        <td>{.key_}</td>
        <td>{.value_}</td>
    </tr>
{/}
</table>
<br />
이제 사용자의 연동이 끝났으므로, 다음 단계에서 연동된 데이터를 이용해서<br />
실제로 me2day에 글을 써 보겠습니다.<br />
<a href="/samples_sns/me2day_write">다음 단계로 이동 (Me2day에 글 쓰기)</a><br />