<!DOCTYPE html>
<html lang="{current_lang}">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta http-equiv="imagetoolbar" content="no" />
	<title>{"사진 업로드"}</title>
	<script type="text/javascript" src="/js/jquery-1.6.4.min.js"></script>
	<script type="text/javascript" src="/js/jquery.imgareaselect.min.js"></script>
<style type="text/css">
 * { margin:0; padding: 0;}
 body { padding: 10px; background: #444 url(/img/common/bg_cutted_area.gif) repeat 0 0; }
.profile-pic-edit .anc { margin-bottom: 20px; background: #222; border-bottom: 1px solid #111; border-right: 1px solid #111; padding: 10px; }
.profile-pic-edit .anc .hint {
	color: #eee;
	margin-bottom: 10px;
	font-size: 13px;
    line-height: 1.5;
}
.profile-pic-edit .anc .hint b { color: #FFAD3A; }
.profile-pic-edit .anc input { width:220px; text-indent:0!important; }
.cuttingArea { width: 566px; overflow: hidden; }
.cuttingArea .uploadThumb { float:left; margin-right:20px;}
.cuttingArea .previewThumb { float:right; text-align:center; padding-right: 20px; }
.cuttingArea .previewThumb #small_image { background-color:#fff; border:5px solid #fff; border-radius: 2px; margin-bottom: 10px; box-shadow: 0 0 5px #000; }
.cuttingArea .previewThumb span { color: #fff; font-size: 12px; letter-spacing: -1px; }
.btnwrap { margin-top:10px; clear: both; padding: 10px 0 0; }
.btnwrap .btn_image_save {
	background:url(/img/common/btns.png) no-repeat -150px -205px;
	border: 0 none;
	padding: 0;
	margin: 0;
	overflow: hidden;
	font-size: 12px;
	letter-spacing: -1px;
	cursor: pointer;
	color: #555;
    height: 30px;
    width: 200px;
}
.btnwrap .btn_image_save:hover { background-position: -150px -246px;}
</style>
</head>

<body>
	<div class="profile-pic-edit">
		<div class="anc">
			<p class="hint">
				<b>JPG</b>, <b>GIF</b> {"또는"} <b>PNG</b> {"형식의"} <b>{"그림 파일"}</b>{"을 업로드할 수 있습니다."}<br/>
				{"업로드가 완료되면, 사진 위 사각형 틀을 드래그하고 크기를 조절해서 프로필 사진으로 표시할 부분을 선택하세요."}
			</p>
			<form name="frm_file" enctype="multipart/form-data" action="/ajax_front/form_file" method="post">
				<input type="hidden" name="sub_dir" value="{sub_dir}" />
                                <input type="hidden" name="which" value="{which}" />
				{? r_width && r_height}
				<input type="hidden" name="r_width" value="{r_width}" />
				<input type="hidden" name="r_height" value="{r_height}" />
				{/}
				{? strlen(large_photo_exists) > 0}
				<input type="hidden" name="large_image" value="{sub_large_image_location}" />
				{/}
				<input type="file" name="file" size="15" onchange="upload();" />
			</form>
		</div>
	{? strlen(large_photo_exists) > 0}
            <div class="cuttingArea">
        	<div class="uploadThumb">
				<img src="{sub_large_image_location}" id="thumbnail" alt="{"리사이즈 한 사진"}" />
            </div>

            <div class="previewThumb">
                <div id="small_image" style="position:relative; overflow:hidden; width:{thumb_width}px; height:{thumb_height}px;">
                    <img src="{sub_large_image_location}" style="position: relative;" alt="Thumbnail Preview" />
                </div>
                <span>{"미리보기"}</span>
            </div>

			<form name="frm_thumbnail" action="/ajax_front/form_file" method="post">
				<input type="hidden" name="sub_dir" value="{sub_dir}" />
                                <input type="hidden" name="which" value="{which}" />
                {? r_width && r_height}
                <input type="hidden" name="r_width" value="{r_width}" />
                <input type="hidden" name="r_height" value="{r_height}" />
                {/}
				<input type="hidden" name="x1" value="0" id="x1" />
				<input type="hidden" name="y1" value="0" id="y1" />
				<input type="hidden" name="x2" value="{resize_width}" id="x2" />
				<input type="hidden" name="y2" value="{resize_height}" id="y2" />
				<input type="hidden" name="w" value="{resize_width}" id="w" />
				<input type="hidden" name="h" value="{resize_height}" id="h" />
				<input type="hidden" name="large_image" value="{sub_large_image_location}" />
				<input type="hidden" name="thumb_width" value="{thumb_width}" />
			</form>

		</div>
        <div class="btnwrap">
            <button type="submit" class="submit btn_image_save" name="upload_thumbnail" id="save_thumb" /><span>{"이 이미지를 프로필로 사용"}</span> </button>
        </div>
	{/}
	</div>

</body>

</html>

<script type="text/javascript">
//<![CDATA[

//이미지 포토가 이면
{? strlen(large_photo_exists) > 0}
	function preview(img, selection) {
		var scaleX = {thumb_width} / selection.width;
		var scaleY = {thumb_height} / selection.height;

		$('#small_image > img').css({
			width: Math.round(scaleX * {current_large_image_width}) + 'px',
			height: Math.round(scaleY * {current_large_image_height}) + 'px',
			marginLeft: '-' + Math.round(scaleX * selection.x1) + 'px',
			marginTop: '-' + Math.round(scaleY * selection.y1) + 'px'
		});
		$('#x1').val(selection.x1);
		$('#y1').val(selection.y1);
		$('#x2').val(selection.x2);
		$('#y2').val(selection.y2);
		$('#w').val(selection.width);
		$('#h').val(selection.height);
	}

	$(document).ready(function () {
		$('#save_thumb').click(function() {
			var frm = $('form[name=frm_thumbnail]');
			var x1 = $('#x1').val();
			var y1 = $('#y1').val();
			var x2 = $('#x2').val();
			var y2 = $('#y2').val();
			var w = $('#w').val();
			var h = $('#h').val();
			if(x1=="" || y1=="" || x2=="" || y2=="" || w=="" || h==""){
				alert("You must make a selection first");
				return false;
			}

			frm.submit();

			return false;

		});
	});

	function init_preview() {
        var scaleX = {thumb_width} / $('#w').val();
        var scaleY = {thumb_height} / $('#h').val();

        $('#small_image > img').css({
            width: Math.round(scaleX * {current_large_image_width}) + 'px',
            height: Math.round(scaleY * {current_large_image_height}) + 'px',
            marginLeft: '-' + Math.round(scaleX * $('#x1').val()) + 'px',
            marginTop: '-' + Math.round(scaleY * $('#y1').val()) + 'px'
        });
    }


    init_preview();
	$(window).load(function () {
		$('#thumbnail').imgAreaSelect({x1: 0, y1: 0, x2: {resize_width}, y2: {resize_height},w:{resize_width},h:{resize_height} , aspectRatio: '1:{thumb_height/thumb_width}', onSelectChange: preview });
	});


{/}

	function upload()
    {
        document.frm_file.submit();
    }

{? thumbnail}
//    console.log(window.parent.actions);
	parent.actions('{=safe_js(thumbnail)}', '{which}');
{/}

{? error_str}
	alert('{error_str}');
{/}


//]]>
</script>