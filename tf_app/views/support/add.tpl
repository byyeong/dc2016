<script type="text/javascript" src="/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
    tinyMCE.init({
        relative_urls : false,
        remove_script_host : false,
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
                tinyMCE.activeEditor.setContent("{=safe_js_editor(res.content)}");
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

    <!-- rowContent -->
    <div id="support" class="rowContent"> 
        <!-- page-header -->
        <div class="page-header">
            <div class="container">
                <h2><a href="/support">Member  Support</a></h2>
            </div>
        </div>
        <!-- /page-header -->

        <!-- page-content -->
        <div class="page-content"> 
            <div class="container"> 
                <!-- Start Contents -->

                <ul class="nav nav-tabs">
                    <li role="presentation" >
                        <a href="/support">FAQ</a>
                    </li>
                    <li role="presentation" class="active">
                        <a href="/support/qna">Q&amp;A</a>
                    </li>
                </ul>
                <!-- /nav-tabs -->

                <div id="qna">
                    <div class="content-header">
                        <h3>
                            <a href="/support/qna">Q&amp;A</a>
                        </h3>
                    </div>


                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-pencil-square-o"></i> 문의하기 
                        </div>
                        <div class="panel-body">
                            <form role="form" class="form-horizontal" method="post" action="/support/add/{res.id}" id="qna_f">
                                <fieldset>
                                    <div class="form-group">
                                        <span class="control-label col-xs-12 col-sm-4 col-md-3 col-lg-2">작성자</span>
                                        <div class="col-xs-12 col-sm-8 col-md-9 col-lg-10">
                                            <input type="text" class="form-control" name="name" value="{?res}{res.name}{:}{s.name}{/}" required>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <span class="control-label col-xs-12 col-sm-4 col-md-3 col-lg-2">전화번호</span>
                                        <div class="col-xs-12 col-sm-8 col-md-9 col-lg-10">
                                            <input type="text" class="form-control" name="tel" value="{?res}{res.tel}{:}{s.tel}{/}" required>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <span class="control-label col-xs-12 col-sm-4 col-md-3 col-lg-2">이메일</span>
                                        <div class="col-xs-12 col-sm-8 col-md-9 col-lg-10">
                                            <input type="text" class="form-control" name="email" value="{?res}{res.email}{:}{s.email}{/}" required>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <span class="control-label col-xs-12 col-sm-4 col-md-3 col-lg-2">분류선택</span>
                                        <div class="col-xs-12 col-sm-8 col-md-9 col-lg-10 form-inline">
                                            <select class="selectpicker" name="cat">
                                                {@ category}
                                                <option value="{.id}">{.category}</option>
                                                {/}
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <span class="control-label col-xs-12 col-sm-4 col-md-3 col-lg-2">질문제목</span>
                                        <div class="col-xs-12 col-sm-8 col-md-9 col-lg-10">
                                            <input type="text" class="form-control" name="title" value="{res.title}" required>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <span class="control-label col-xs-12 col-sm-4 col-md-3 col-lg-2">질문내용</span>
                                        <div class="col-xs-12 col-sm-8 col-md-9 col-lg-10">
                                            <textarea rows="15" class="form-control" required></textarea>
                                        </div>
                                    </div>

                                    <div class="form-group"> 
                                        <span class="col-lg-2 control-label"> 공개 여부</span>
                                        <div class="col-lg-10">                     
                                            <label class="radio-inline">
                                              <input type="radio" name="open" value="1" {? res.open}checked="checked"{/}> 공개
                                            </label>
                                            <label class="radio-inline">
                                              <input type="radio" name="open" value="0" {? !res.open}checked="checked"{/}> 비공개
                                            </label>
                                        </div>
                                    </div>
                                    <!-- /form-group --> 


                                    <div class="form-group form-submit"> 
                                        <div class="col-xs-12 col-sm-offset-4 col-sm-8 col-sm-offset-3 col-md-9 col-sm-offset-2 col-lg-10">
                                            <button class="btn btn-primary" id="submit_b">확인</button>
                                            <a class="btn btn-default" href="/support">목록으로</a>
                                        </div>
                                    </div>
                                    <input type="hidden" name="user_id" value="{?user_id}{user_id}{:}{s.id}{/}" />
                                    <input type="hidden" name="id" value="{res.id}" />
                                    <input type="hidden" name="type" value="2" />
                                    <input type="hidden" id="content" name="content" value="" />
                                </fieldset>
                            </form>
                        </div>
                    </div>

                </div>
                <!-- /qna -->

                <!-- /End Contents --> 
            </div>
        </div>
        <!-- /page-content -->
    </div>
    <!-- /rowContent -->
<script>
$('#submit_b').click(function(){
    $(this).attr("disabled", "disabled");
    document.getElementById("content").value = tinyMCE.activeEditor.getContent();
    document.getElementById("qna_f").submit();
});
</script>