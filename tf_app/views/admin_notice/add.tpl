<script type="text/javascript" src="/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
    tinyMCE.init({
        mode : "textareas",
        theme : "advanced",
        plugins : "autolink,lists,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,wordcount,advlist,autosave",

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
                tinyMCE.activeEditor.setContent("{=safe_js_editor(res.contents)}");
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
        console.log(_path);
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
                    
                    <!-- panel #pane-notice-edit -->
                    <div id="pane-notice-edit" class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-bullhorn"></span><span class="break"></span>공지사항 작성하기</h2>
                            <div class="actions"> <span class="break"></span> <a href="notice-list.html" class="btn-list"  data-toggle="tooltip" title="목록보기"><span class="glyphicon  glyphicon-align-justify"></span></a> </div>
                        </div>
                        <!-- /panel-heading -->
                        
                        <form class="form-horizontal" name="frm_board" action="/admin_notice/add/{res.id}" method="post" onsubmit="return false;" >
                            <input type="hidden" name="id" value="{res.id}" />
                            <input type="hidden" name="writer_id" value="{?res.writer_id}{res.writer_id}{:}{s.id}{/}" />
                            <input type="hidden" name="contents" id="contents" value="" />
                            <!-- panel-body -->
                            <div class="panel-body">
                                <fieldset>
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >공지사항 종류 선택</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                        <select name="type" data-width="auto" class="selectpicker" >
                                            <option value="1" {? res.type == 1}selected="selected"{/}>공지사항</option>
                                            <!--<option value="2" {? res.type == 2}selected="selected"{/}>스타트업 뉴스</option>>
                                            <option value="3" {? res.type == 3}selected="selected"{/}>공지사항</option-->
                                        </select>
                                        </div>
                                    </div>
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" > 제목 입력</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <input type="text" class="form-control" name="title" value="{res.title}" placeholder="제목을 입력해 주세요">
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" > 내용 입력</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <textarea rows="30" class="form-control" id="inputArticle">{res.contents}</textarea>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                     
                                        <div class="form-group"> 
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" > 대표 이미지</div>
                                            <div class="col-xs-12 col-sm-10 col-md-10">                                                
                                                <!-- btn-group -->                                                
                                                <div>
                                                    <input type="hidden" name="pic" id="pic" value="">
                                                    <!--<iframe width="100%" scrolling="no" height="300px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/pic/300x300?old={=safe_js(res.main)}" allowtransparency="true"></iframe>//-->
                                                    <img class="img-thumbnail" src="{?res.main}{res.main}?{=date('his')}{:}/img/common/300x300.png{/}" id="pic_img" onclick="toggle_img();return false;">
                                                    <div id="div_img_change" style="display: none;">
                                                        <iframe  height="600" frameborder="0" width="100%" scrolling="no" id="frm" allowTransparency="true" src="/ajax_front/form_file?which=pic&r_width=300&r_height=300" ></iframe>
                                                    </div>
                                                </div>
                                                <!-- /btn-group -->
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        <div class="form-group"> 
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" > 공개 설정</div>
                                            <div class="col-xs-12 col-sm-10 col-md-10"> 
                                                    <select name="visible" data-width="auto" class="selectpicker" >
                                                        <option value="0" {? res.visible == 0}selected="selected"{/}>비공개</option>
                                                        <option value="1" {? res.visible == 1}selected="selected"{/}>공개</option>
                                                    </select> 
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        <div class="form-group"> 
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" > 작성자 선택</div>
                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                <div class="form-group-sub form-inline">                                                     
                                                        <select name="writer_type" data-width="auto" class="selectpicker" >
                                                            <option value="0" {? res.writer != s.name}selected="selected"{/}>작성자 추가</option>
                                                            <option value="1" {? res.writer == s.name || !res}selected="selected"{/}>D.CAMP</option>
                                                        </select> 
                                                          
                                                        <input type="text" class="form-control" id="inputAuthor" name="writer" value="{res.writer}" placeholder="작성자 입력">                                                    
                                                     
                                                 </div>
                                                 <!-- /form-group-sub -->                                                
                                            </div>
                                        </div>
                                        <!-- /form-group --> 
                                </fieldset>
                            </div>
                            <!-- /panel-body --> 
                            
                            <!-- panel-footer -->
                            <div class="panel-footer">
                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                    <button type="button" class="btn btn-default">취소</button>
                                    <button type="submit" class="btn btn-primary" onclick="go();">저장</button>
                                    </div>
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

<script type="text/javascript">
    function go()
    {
        document.getElementById("contents").value = tinyMCE.activeEditor.getContent();
        document.frm_board.submit();
    }
</script>