<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"  />
<title>링크 추가</title>

<link rel="stylesheet" href="/css/popup.css">

</head>
<body id="popBody">

<form method="post" name="attach_image_pop" action="/system/editor_add_movie_process">

<input type="hidden" name="mode">

<h2>링크 추가</h2>

<div class="popbodyWrap">
	<div class="insertImage">
	<dl>
		<dt>동영상 URL</dt>
		<dd>
			<textarea type="text" name="movie_url" class="text wd" ><object width="640" height="390"><param name="movie" value="http://www.youtube.com/v/Z8sDT6OdK34?fs=1&amp;hl=ko_KR&amp;rel=0"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="http://www.youtube.com/v/Z8sDT6OdK34?fs=1&amp;hl=ko_KR&amp;rel=0" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="640" height="390"></embed></object></textarea>
		</dd>
	</dl>
	</div>

</div>

<!-- E popbodyWrap -->
<div id="popbuttonWrap">
	<input type="image" onclick="onclick_attach();" value="추가" src="/images/btn_submit.gif" />
	<input type="image" onclick="window.close();" value="취소" src="/images/btn_cancel.gif" />
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