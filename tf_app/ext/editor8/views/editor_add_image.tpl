<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"  />
<title>이미지 업로드</title>

<link rel="stylesheet" href="/editor/popup.css">

</head>
<body id="popBody">

<form method="post" enctype="multipart/form-data" name="attach_image_pop" action="/tf_editor/editor_add_image_process">

<input type="hidden" name="mode">

<h2>이미지 업로드</h2>

<div class="popbodyWrap">

	<div class="insertImage">
		<dl>
			<dt><label for="upload_file">파일</label></dt>
			<dd>
				<input type="file" class="image" name="upload_file" id="upload_file"/>
			</dd>
		<!-- <dd class="message">전송을 완료했습니다.</dd> -->

		</dl>

		<dl>
			<dt>정렬방법</dt>
			<dd class="imagealign">
				<input id="left" class="radiobutton" name="position" type="radio" value="1" />
				<label for="left">왼쪽 </label>
				<input id="center" class="radiobutton" name="position" type="radio" checked value="2" />

				<label for="center">가운데 </label>
				<input id="right" class="radiobutton" name="position" type="radio" value="3" />
				<label for="right">오른쪽 </label>
			</dd>
		</dl>
		<dl>
			<dt>타이틀</dt>

			<dd>
				<input name="caption" type="text" class="text wd" />
			</dd>
		</dl>

	</div>
</div>

<!-- E popbodyWrap -->
<div id="popbuttonWrap">
	<input type="image" onclick="onclick_attach();" value="업로드" src="/editor/btn_submit.gif" />

	<input type="image" onclick="window.close();" value="취소" src="/editor/btn_cancel.gif" />
</div>

</form>

<script language="javascript">
var form = document.attach_image_pop;
function onclick_attach() {
	form.mode.value = 'upload';
	form.submit();
}
</script>


</body>
</html>