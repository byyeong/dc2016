<script type="text/javascript" src="/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
    tinyMCE.init({
        mode : "textareas",
        theme : "advanced",
        plugins : "autolink,lists,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,inlinepopups,insertdatetime,preview,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,wordcount,advlist,autosave",

        theme_advanced_buttons1 : "fontselect,fontsizeselect,|,tablecontrols,|,hr,removeformat,visualaid",
        theme_advanced_buttons2 : "bold,italic,underline,strikethrough,|,forecolor,backcolor,|,justifyleft,justifycenter,justifyright,justifyfull,|,bullist,numlist,outdent,indent,blockquote,|,link,unlink,|,imagepop,iespell,media,|,code,fullscreen",
        theme_advanced_buttons3 : "",
        theme_advanced_buttons4 : "",
        theme_advanced_toolbar_location : "top",
        theme_advanced_toolbar_align : "left",
        theme_advanced_statusbar_location : "bottom",
        theme_advanced_resizing : false,

        theme_advanced_fonts : "나눔고딕=나눔고딕,NanumGothic;,맑은 고딕='맑은 고딕','Malgun Gothic';굴림=굴림;굴림체=굴림체;궁서=궁서;궁서체=궁서체;돋움=돋움;돋움체=돋움체;바탕=바탕;바탕체=바탕체;Arial=Arial; Comic Sans MS='Comic Sans MS';Courier New='Courier New';Tahoma=Tahoma;Times New Roman='Times New Roman';Verdana=Verdana",

// Drop lists for link/image/media/template dialogs
        template_external_list_url : "lists/template_list.js",
        external_link_list_url : "lists/link_list.js",
        external_image_list_url : "lists/image_list.js",
        media_external_list_url : "lists/media_list.js",

        setup : function(ed) {
            ed.onLoadContent.add(function(ed, o) {
                ed.focus();
                tinyMCE.activeEditor.setContent("{=safe_js_editor(res.winner)}");
            });
            // Register image button
            ed.addButton('imagepop', {
                title : 'imagepop',
                image : '/tinymce/add_image.gif',
                onclick : function() {
                cmdImgUploadPop();
            }
            });
        }

    });


    function cmdImgUploadPop(){
        var win = window.open( "/ajax/add_image/",
        "editor_win",
        "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=450,height=350,left=50,top=50"
        );
        win.focus();
    }

    // 파일업로드 완료후 opener.editorImgUploadComplete함수호출 되는 방식
    function editorImgUploadComplete(_path){
        var strImg = "<br><img src='" + _path + "' ><br><br>";
        var contents = tinyMCE.activeEditor.getDoc().body.innerHTML;
        //tinyMCE.activeEditor.setContent( contents + strImg );

        var inst = tinyMCE.activeEditor;
        inst.getWin().focus();
        var  args = {src: _path};
        inst.execCommand('mceInsertContent',false,'<img id="__mce_tmp" />',{skip_undo : 1});
        inst.dom.setAttribs('__mce_tmp', args);
        inst.dom.setAttrib('__mce_tmp', 'id', '');
        inst.undoManager.add();

    }
</script>
<script type="text/javascript">
//<![CDATA[

function go_cancel(_id)
{
    location.href='/competition/edit?cancel='+_id;
}

function go_submit(_this)
{
    $(_this).hide();
    document.getElementById("winner").value = tinyMCE.activeEditor.getContent();
    document.f_winner.submit();
}

//]]>
</script>
    <!-- rowContent -->
    <div class="rowContent"  id="competition"> 
        <div class="page-header">
            <div class="container">
                <h2><a href="/competition">Competition</a></h2>
                {? (s.per & settings->permission1) == settings->permission1}
                {? s.ids}
                <button  class="btn btn-primary pull-right" onclick=location.href='/competition/edit'><span class="icon-pencil"></span> 경진대회 만들기</button>
                {:}
                <button  class="btn btn-primary pull-right" onclick="javascript:alert('로그인이 필요합니다.');"><span class="icon-pencil"></span> 경진대회 만들기</button>
                {/}
                {/}
            </div>
        </div>
        <!-- /page-header -->
        
        <!-- page-content -->
        <div class="page-content" id="competition-edit"> 
            <!-- container -->
            <div class="container">
            
                <div class="editor">
                    <div class="edit-header">
                        <h3><span class="icon-pencil"></span> 경진대회 작성하기</h3>
                    
                        <ol data-progtrckr-steps="7" class="stepProgress">
                            <li class="{? step > 0}step-done{:}step-todo{/}">정보입력</li>
                            <li class="{? step > 1}step-done{:}step-todo{/}">승인받기</li>
                            <li class="{? step > 2}step-done{:}step-todo{/}">세부정보 설정</li>
                            <li class="{? step > 3}step-done{:}step-todo{/}">접수중</li>
                            <li class="{? step > 4}step-done{:}step-todo{/}">접수마감</li>
                            <li class="{? step > 5}step-done{:}step-todo{/}">수상자 발표</li>
                        </ol>
                        
                        <ul class="nav nav-tabs">
                            <li><a href="/competition/edit/{res.id}">{? res}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}경진대회 정보 입력</a></li>
                            {? res.status == 1}
                            <li><a href="/competition/apply_info/{res.id}">{? res.form}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}참가신청 정보 설정</a></li>
                            <li><a href="/competition/score_info/{res.id}">{? res.score}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}평가 항목 설정</a></li>
                            <li><a href="/competition/examiner/{res.id}">{? exn}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}심사위원 초대</a></li>
                            <li class="active"><a href="/competition/winner/{res.id}">{? res.winner}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}수상자 선정</a></li>
                            {/}
                        </ul>
                    </div>
                    <div class="edit-body"> 
                        <form class="form-horizontal" role="form" name="f_winner" action="/competition/winner/{res.id}" onsubmit="return false;" method="post">
                            <fieldset>
                                <input type="hidden" name="id" value="{res.id}" />
                                <input type="hidden" name="winner" id="winner" value="" />
                                <legend class="sr-only">수상자 선정 내용 입력</legend>
                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-3 col-md-3 control-label" >수상자 선정 내용</div>
                                    <div class="col-xs-12 col-sm-9 col-md-9">
                                        <textarea  rows="20" class="form-control" name="cont" id="inputDesc"></textarea>
                                    </div>
                                </div>
                                <!-- /form-group -->
                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-3 col-md-3 control-label" >공개여부</div>
                                    <div class="col-xs-12 col-sm-9 col-md-9">
                                        <select class="selectpicker" data-width="auto" name="winner_open">
                                            <option value="1" {? res.winner_open}selected="selected"{/}>공개</option>
                                            <option value="0" {? !res.winner_open}selected="selected"{/}>비공개</option>
                                        </select>
                                    </div>
                                </div>
                                <!-- /form-group -->
                                <div class="form-group form-submit">
                                    <div class="col-xs-12 col-sm-offset-3 col-sm-9 col-md-offset-3 col-md-9"> 
                                        <a href="#"  class="btn btn-default">취소</a> 
                                        <a href="#" onclick="go_submit(); return false;" class="btn btn-primary">확인</a> 
                                    </div>
                                </div>
                            </fieldset>
                        </form> 
                    </div> 
                </div>
                <!-- /editor --> 
                
                
            </div>
            <!-- /container --> 
        </div>
        <!-- /page-content --> 
    </div>
    <!-- /rowContent --> 