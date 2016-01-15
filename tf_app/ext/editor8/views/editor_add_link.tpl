<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"  />
<title>링크 추가</title>

<link rel="stylesheet" href="/editor/popup.css">

</head>
<body id="popBody">

<form method="post" enctype="multipart/form-data" name="attach_image_pop" action="/tf_editor/editor_add_link">

<input type="hidden" name="mode">

<h2>링크 추가</h2>

<div class="popbodyWrap">
	<div class="insertImage">
	<dl>
		<dt>주소</dt>
		<dd>
			<input type="text" name="url" class="text wd" value="http://" />
		</dd>
		<!-- <dd class="message">전송을 완료했습니다.</dd> -->
	</dl>

	<dl>
		<dt>옵션</dt>
		<dd>
			<input type="checkbox" value="1" name="optNew" id="optNew"/> <label for="optNew">새창으로</label>
		</dd>
	</dl>
	</div>

</div>

<!-- E popbodyWrap -->
<div id="popbuttonWrap">
	<input type="image" onclick="onclick_attach();" value="링크추가" src="/editor/btn_submit.gif" />
	<input type="image" onclick="window.close();" value="취소" src="/editor/btn_cancel.gif" />
</div>

</form>

<script language="javascript">
var form = document.attach_image_pop;
function onclick_attach() {
	var optionStr = "";
	if (document.attach_image_pop.optNew.checked) optionStr = " target=\"_blank\" ";
		opener.window.gotolink(document.attach_image_pop.url.value,optionStr);
		window.close();
	
}
</script>


</body>

</html>