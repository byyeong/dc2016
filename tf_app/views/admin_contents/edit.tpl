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
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-edit"></span><span class="break"></span>Blog 작성하기</h2>
                            <div class="actions"> <span class="break"></span> <a title="Blog 추가" data-toggle="tooltip" href="/admin_contents"><span class="glyphicon  glyphicon-align-justify"></span></a> </div>
                        </div>
                        <!-- /panel-heading -->
                        
                        <form class="form-horizontal" method="post" action="/admin_contents/edit/{res.id}">
                            <input type="hidden" name="id" value="{res.id}" />
                            <input type="hidden" name="contents" id="contents" value="" />
                            <div class="panel-body">
                                <fieldset>
                                    <legend>Blog 정보입력</legend>
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">카테고리</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <select class="selectpicker" data-width="auto" name="category_id">
                                                {@ cat}
                                                <option value="{.id}" {? res.category_id == .id}selected="selected"{/}>{.name}</option>
                                                {/}
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">작성자</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <input type="hidden" name="user_id" value="{? res}{res.user_id}{:}{s.id}{/}" />
                                            {? res} 
                                            <a href="/admin_member/add/{res.user_id}" class="form-control-static"><img src="{res.picture}" style="width: 40px; height: 40px;"> {res.name}</a>
                                            {:}
                                            <a href="/admin_member/add/{s.id}" class="form-control-static"><img src="{s.picture}" style="width: 40px; height: 40px;"> {s.name}</a>
                                            {/}
                                        </div>
                                    </div>   
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">글 제목</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <input type="text"  class="form-control" name="subject" value="{res.subject}" required="required">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">내용</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <textarea rows="30" class="form-control" id="inputDesc" name="contents" >{res.contents}</textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >대표 이미지</div>
                                        <div class="col-xs-12 col-sm-10 col-sm-10">
                                            <input type="hidden" name="pic" id="pic" value="">
                                            <img class="img-thumbnail" src="{?res.cpic}{res.cpic}?{=date('his')}{:}/img/default-img-event.png{/}" id="pic_img" onclick="toggle_img();return false;">
                                            <div id="div_img_change" style="display: none;">
                                                <iframe  height="600" frameborder="0" width="100%" scrolling="no" id="frm" allowTransparency="true" src="/ajax_front/form_file?which=pic&r_width=300&r_height=300" ></iframe>
                                            </div>
                                            <span class="help-block">대표이미지는 리스트에 출력됩니다. 가로세로 300x300 픽셀 사이즈로 업로드 해주세요.</span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">공개 설정</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <label class="radio-inline">
                                                <input type="radio" {? res.hidden == 0}checked="checked"{/} name="hidden" value="0">
                                            공개</label>
                                            <label class="radio-inline">
                                                <input type="radio" {? res.hidden == 1}checked="checked"{/}  name="hidden" value="1">
                                                비공개</label>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">상태 설정</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <label class="radio-inline">
                                                <input type="radio" {? res.state == 1}checked="checked"{/} name="state" value="1">승인
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" {? res.state == 0}checked="checked"{/} name="state" value="0">승인대기
                                            </label>
                                        </div>
                                    </div>
                                </fieldset>
                            </div>
                            <!--/panel-body -->
                            
                            <div class="panel-footer">
                                <div class="col-lg-offset-2">
                                    <button type="button" class="btn btn-default">취소</button>
                                    <button type="submit" class="btn btn-primary">저장</button>
                                </div>
                            </div>
                            <!-- /panel-footer -->
                        </form>
                    </div>
                    <!-- /panel --> 
                    
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 