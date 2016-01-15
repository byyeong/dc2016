<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="description" content="" />
	<meta name="keywords" lang="kr" content="" />
	<meta name="keywords" lang="en" content="" />
	<meta name="author" content="" />
	<meta http-equiv="imagetoolbar" content="no" />

	<!-- Script -->
	<title>TF 0.6</title>
</head>

<body>
Trail Framework - service_settings<br />
<a href="/tf_service_settings/logout/">로그아웃</a>
<br /><br />
<form action="/tf_service_settings" method="post">
*주의* 모든 작업 후 저장하기를 눌러야 적용됩니다.<br />
<table border="0" cellpadding="5" cellspacing="0"  style="border-top:#000000 2px solid;">
{@service_settings}
    <tr>
        <td style="border-left:#000000 2px solid;border-right:#909090 1px solid;">{.key}</td>
        <td style="border-right:#000000 2px solid;">
            <input type="text" name="key_{.key}" value="{.value}" size="60" />
            <input type="hidden" name="todel_{.key}" id="todel_{.key}" value="0" size="60" />
            <input type="button" onclick="todel('{.key}')" value="삭제" id="todel_btn_{.key}"/>
        </td>
    </tr>
    <tr>
        <td style="border-top:#909090 1px solid;border-bottom:#000000 2px solid;border-left:#000000 2px solid;border-right:#000000 2px solid;" colspan="2">{.description}</td>
    </tr>
{/}
</table>
<input type="hidden" name="jobtype" value="modify" />
<input type="submit" value="저장하기" />
</form>
<br />
<form action="/tf_service_settings" method="post">
* 새 키 추가<br />
<table border="0" cellpadding="5" cellspacing="0"  style="border:#000000 2px solid;">
    <tr>
        <td style="border-right:#909090 1px solid;">키:</td>
        <td style="border-right:#000000 2px solid;">
            <input type="text" name="new_key" value="" size="60" />
        </td>
    </tr>
    <tr>
        <td style="border-right:#909090 1px solid;">값:</td>
        <td style="border-right:#000000 2px solid;">
            <input type="text" name="new_value" value="" size="60" />
        </td>
    </tr>
    <tr>
        <td style="border-right:#909090 1px solid;">설명:</td>
        <td style="border-right:#000000 2px solid;">
            <input type="text" name="new_desc" value="" size="60" />
        </td>
    </tr>
</table>
<input type="submit" value="추가하기" />
</form>
<br />
<form action="/tf_service_settings" method="post">
* 비밀번호 변경<br />
<table border="0" cellpadding="5" cellspacing="0"  style="border:#000000 2px solid;">
    <tr>
        <td style="border-right:#909090 1px solid;">새 비밀번호:</td>
        <td style="border-right:#000000 2px solid;">
            <input type="text" name="pw" value="" size="60" />
        </td>
    </tr>
</table>
<input type="submit" value="변경하기" />
</form>
<script>
    function todel(_key)
    {
        var tod = document.getElementById("todel_" + _key);
        if (tod.value == "1")
        {
            document.getElementById("todel_btn_" + _key).value="삭제";
            tod.value = "0";
        }
        else
        {
            document.getElementById("todel_btn_" + _key).value="취소";
            tod.value = "1";
        }
    }
</script>

</body>

</html>