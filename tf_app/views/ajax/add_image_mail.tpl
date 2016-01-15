<!DOCTYPE html>
<html lang="{current_lang}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"  />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>{"이미지 업로드"}</title>

<link type="text/css" rel="stylesheet" href="/style/su_admin.css" />

</head>
<body id="popBody">

<div class="imgUpWrap">
    <form method="post" enctype="multipart/form-data" name="attach_image_pop" action="/ajax/add_image_process_mail">
        <input type="hidden" name="mode">
        <h2>{"이미지를 업로드 합니다."}</h2>
        <div class="popbodyWrap">

            <div class="insertImage">
                <p>
                    <label for="upload_file">{"이미지 파일을 선택하세요"}</label>
                    <input type="file" class="image" name="upload_file" id="upload_file"/>
                </p>
                <!-- <p class="message">전송을 완료했습니다.</p> -->
            </div>
        </div>

        <div id="popbuttonWrap">
            <input type="button" onclick="onclick_attach();" value="{"올려줘요!"}" />
            <input type="button" onclick="window.close();" value="{"안할래요."}" />
        </div>
    </form>
</div>

<script language="javascript">
var form = document.attach_image_pop;
function onclick_attach() {
	form.mode.value = 'upload';
	form.submit();
}
</script>


</body>
</html>