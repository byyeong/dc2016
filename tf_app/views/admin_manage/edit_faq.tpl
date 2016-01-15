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
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap">
                <!-- section -->
                <section> 
                    
                    <!-- panel #pane-faq-edit -->
                    <div id="pane-faq-edit"class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="icon-plus"></span><span class="break"></span>FAQ 추가하기</h2>
                            <div class="actions"> <span class="break"></span> <a href="/admin_manage" class="btn-list"  data-toggle="tooltip" title="목록보기"><span class="icon-align-justify"></span></a> </div>
                        </div>
                        <!-- /panel-heading -->
                        <form class="form-horizontal" method="post" action="/admin_manage/edit_faq/{res.id}" id="qna_f">
                            <!-- panel-body -->
                            <div class="panel-body">
                                <fieldset>
                                    <div class="form-group"> 
                                        <span class="col-lg-2 control-label"> 분류 </span>
                                        <div class="col-lg-10"> 
                                            <select class="selectpicker" name="cat">
                                                {@ cat}
                                                <option value="{.id}" {? q.cat == .id}selected{/}>{.category}</option>
                                                {/}
                                            </select>
                                        </div>
                                    </div>
                                    <!-- /form-group --> 

                                    <div class="form-group"> 
                                        <span class="col-lg-2 control-label"> 제목 입력</span>
                                        <div class="col-lg-10"> 
                                          <input type="text" class="form-control" placeholder="제목을 입력해 주세요" name="title" value="{res.title}" required>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <span class="col-lg-2 control-label"> 내용 입력</span>
                                        <div class="col-lg-10"> 
                                          <textarea rows="30" class="form-control" id="inputArticle" placeholder="내용을 입력해 주세요" >{res.content}</textarea>
                                        </div>
                                    </div>
                                    <!-- /form-group --> 

                                    <div class="form-group"> 
                                        <span class="col-lg-2 control-label"> 공개 여부</span>
                                        <div class="col-lg-10">                     
                                            <label class="radio-inline">
                                              <input type="radio" name="open" value="1" {? res.open}checked{/}> 공개
                                            </label>
                                            <label class="radio-inline">
                                              <input type="radio" name="open" value="0" {? !res.open}checked{/}> 비공개
                                            </label>
                                        </div>
                                    </div>
                                    <!-- /form-group --> 
                                    <input type="hidden" name="type" value="1" />
                                    <input type="hidden" name="id" value="{res.id}" />
                                    <input type="hidden" id="content" name="content" value="" />
                                </fieldset>
                            </div>
                            <!-- /panel-body --> 
                            <!-- panel-footer -->
                            <div class="panel-footer">
                                <div class="col-lg-offset-2">
                                    <button type="button" class="btn btn-default">취소</button>
                                    <button type="submit" class="btn btn-primary" id="submit_b">저장</button>
                                </div>
                            </div>
                            <!-- /panel-footer -->
                        </form>
                    </div>
                    <!-- /panel #pane-notice-edit--> 
                    
                </section>
                <!-- /section -->
            </div>
            <!-- /contentwrap -->             

<script>
$('#submit_b').click(function(){
    $(this).attr("disabled", "disabled");
    document.getElementById("content").value = tinyMCE.activeEditor.getContent();
    document.getElementById("qna_f").submit();
});
</script>