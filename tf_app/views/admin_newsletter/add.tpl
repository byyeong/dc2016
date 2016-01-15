<link href="/css/bootstrap-tagsinput.css" rel="stylesheet"> 
<script type="text/javascript" src="/js/jquery-sortable.js"></script> 
<script type="text/javascript" src="/js/bootstrap-tagsinput.min.js"></script>

<script>
    $(function() {
        $(".form-tags").tagsinput('items'); 
        
        $("#sortable").sortable({
            cancel: '.form-control',
            handle: 'i.icon-move',
            onDragStart: function (item, container, _super) {
            // Duplicate items of the no drop area
            if(!container.options.drop)
            item.clone().insertAfter(item)
            _super(item)
            }
        });
    });
</script>

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
                tinyMCE.activeEditor.setContent("{=safe_js_editor(res.body)}");
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
                            <h2><span class="icon-edit"></span><span class="break"></span>뉴스레터 작성하기</h2>
                            <div class="actions"> <span class="break"></span> <a title="뉴스레터 목록" data-toggle="tooltip" href="/admin_newsletter/"><span class="icon-align-justify"></span></a> </div>
                        </div>
                        <!-- /panel-heading -->
                        
                        <form class="form-horizontal" method="post" action="/admin_newsletter/add/{res.id}" name="form_newsl">
                            <div class="panel-body">
                                <fieldset>
                                    <legend>뉴스레터 정보입력</legend>
                                    <div class="form-group">
                                        <span class="col-xs-12 col-sm-2 col-md-2 control-label">글 제목</span>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <input type="text"  class="form-control" name="subject" value="{res.subject}">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <span class="col-xs-12 col-sm-2 col-md-2 control-label">발송일</span>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <!-- datepicker -->
                                            <div class="bfh-datepicker" data-format="y-m-d">
                                                <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                    <input type="text" class="form-control datepicker" readonly name="date" value="{res.date}">
                                                </div>
                                                <div class="bfh-datepicker-calendar">
                                                    <table class="calendar table table-bordered">
                                                        <thead>
                                                            <tr class="months-header">
                                                                <th class="month" colspan="4"> 
                                                                    <a class="previous" href="#"><span class="icon-chevron-left"></span></a> 
                                                                    <span></span> 
                                                                    <a class="next" href="#"><span class="icon-chevron-right"></span></a>
                                                                 </th>
                                                                <th class="year" colspan="3"> 
                                                                    <a class="previous" href="#"><span class="icon-chevron-left"></span></a> 
                                                                    <span></span> 
                                                                    <a class="next" href="#"><span class="icon-chevron-right"></span></a> 
                                                                </th>
                                                            </tr>
                                                            <tr class="days-header"> </tr>
                                                        </thead>
                                                        <tbody>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <!-- /datepicker -->
                                        </div>
                                    </div> 
                                    <div class="form-group">
                                        <span class="col-xs-12 col-sm-2 col-md-2 control-label">내용</span>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            
                                            <!-- mainEditor -->
                                            <div id="mailEditor" >
                                                <div class="mail-header">Newsletter Header (fixed)</div>

                                                <textarea class="form-control" rows="20"></textarea> 
                                                <!-- select-content-edit -->
                                                <div class="select-content-edit"> 
                                                    <ol id="sortable">
                                                        {? cont}
                                                        {@ cont}
                                                        <li class="ui-state-default entry-item"> 
                                                            <i class="icon-move  pull-left"></i>
                                                            <div class="set-wrap pull-right">
                                                                <button type="button" class="btn btn-default btn-xs delete" onclick="remove_pp(this); return false;"><span class="icon-trash"></span></button> 
                                                            </div>
                                                            <div class="form-group">
                                                                <span class="col-xs-12 col-sm-3 col-md-3 control-label">Event, Competition </span>
                                                                <div class="col-xs-12 col-sm-9 col-md-9 form-inline">
                                                                    <select class="form-control" name="type_{.key_+1}">
                                                                        <option value="1" {? .type == 1}selected{/}>Event</option>
                                                                        <option value="3" {? .type == 3}selected{/}>Competition</option>
                                                                    </select>
                                                                    <input type="text"  class="form-control" placeholder="아이디 번호입력" name="cont_id_{.key_+1}" value="{.cont_id}">
                                                                </div>
                                                           </div>   
                                                        </li>
                                                        {/}
                                                        {:}
                                                        <li class="ui-state-default entry-item"> 
                                                            <i class="icon-move  pull-left"></i>
                                                            <div class="set-wrap pull-right">
                                                                <button type="button" class="btn btn-default btn-xs delete" onclick="remove_pp(this); return false;"><span class="icon-trash"></span></button> 
                                                            </div>
                                                            <div class="form-group">
                                                                <span class="col-xs-12 col-sm-3 col-md-3 control-label">Event, Competition </span>
                                                                <div class="col-xs-12 col-sm-9 col-md-9 form-inline">
                                                                    <select class="form-control" name="type_1">
                                                                        <option value="1">Event</option>
                                                                        <option value="3">Competition</option>
                                                                    </select>
                                                                    <input type="text"  class="form-control" placeholder="아이디 번호입력" name="cont_id_1">
                                                                </div>
                                                           </div>   
                                                        </li>
                                                        {/}
                                                    </ol> 
                                                    <button class="btn btn-default btn-xs" onclick="add_cont(this); return false;"><span class="icon-plus"></span>&nbsp;Event, Competition 추가</button>
                                                </div>
                                                <!-- /select-content-edit -->

                                                <!-- select-recruit-edit -->
                                                <div class="select-recruit-edit"> 
                                                    <div class="form-group">
                                                        <span class="col-xs-12 col-sm-3 col-md-3 control-label">Office hours 선택</span>
                                                        <div class="col-xs-12 col-sm-9 col-md-9">
                                                            <input type="text" class="form-control form-tags" data-role="tagsinput" placeholder="콤마(,)로 구분해서 아이디 번호를 입력해주세요" name="o_ids" value="{res.o_ids}">
                                                        </div>
                                                   </div>  
                                                </div>
                                                <!-- /select-recruit-edit -->
                                                <br>

                                                <!-- select-recruit-edit -->
                                                <div class="select-recruit-edit"> 
                                                    <div class="form-group">
                                                        <span class="col-xs-12 col-sm-3 col-md-3 control-label">Benefit 선택</span>
                                                        <div class="col-xs-12 col-sm-9 col-md-9">
                                                            <input type="text" class="form-control form-tags" data-role="tagsinput" placeholder="콤마(,)로 구분해서 아이디 번호를 입력해주세요" name="b_ids" value="{res.b_ids}">
                                                        </div>
                                                   </div>  
                                                </div>
                                                <!-- /select-recruit-edit -->
                                                <br>  

                                                <!-- select-recruit-edit -->
                                                <div class="select-recruit-edit"> 
                                                    <div class="form-group">
                                                        <span class="col-xs-12 col-sm-3 col-md-3 control-label">Blog 선택</span>
                                                        <div class="col-xs-12 col-sm-9 col-md-9">
                                                            <input type="text" class="form-control form-tags" data-role="tagsinput" placeholder="콤마(,)로 구분해서 아이디 번호를 입력해주세요" name="c_ids" value="{res.c_ids}">
                                                        </div>
                                                   </div>  
                                                </div>
                                                <!-- /select-recruit-edit -->
                                                <br>                                             

                                                <!-- select-recruit-edit -->
                                                <div class="select-recruit-edit"> 
                                                    <div class="form-group">
                                                        <span class="col-xs-12 col-sm-3 col-md-3 control-label">리쿠르트 선택</span>
                                                        <div class="col-xs-12 col-sm-9 col-md-9">
                                                            <input type="text" class="form-control form-tags" data-role="tagsinput" placeholder="콤마(,)로 구분해서 아이디 번호를 입력해주세요" name="r_ids" value="{res.r_ids}">
                                                        </div>
                                                   </div>  
                                                </div>
                                                <!-- /select-recruit-edit -->

                                                <div class="mail-footer">Newsletter Footer (fixed)</div>
                                            </div>
                                            <!-- /mainEditor -->
                                            

                                            <div class="temp-priview">
                                                <p>
                                                    <button type="button" class="btn btn-default btn-sm" onclick="newsletterPop_temp(1); return false;">뉴스레터 HTML 보기</button>
                                                    <button type="button" class="btn btn-default btn-sm"onclick="newsletterPop_temp(0); return false;">뉴스레터 미리 보기</button>
                                                </p>
                                                <div class="input-group">
                                                    <input name="emails" type="text" class="form-control form-tags" data-role="tagsinput" placeholder="메일주소는 콤마(,)로 구분해서 여러개 입력할 수 있습니다.">
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" type="button" onclick="newsl_mail(this); return false;">테스트 발송하기</button>
                                                    </span>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                    <input type="hidden" id="body" name="body" value="" />
                                    <input type="hidden" name="id" value="{res.id}" />
                                    <input type="hidden" name="cont_cnt" value="{? cont}{=sizeof(cont)}{:}1{/}" />
                                </fieldset>
                            </div>
                            <!--/panel-body -->
                            
                            <div class="panel-footer">
                                <div class="col-lg-offset-2">
                                    <button type="button" class="btn btn-default">취소</button>
                                    <button type="submit" class="btn btn-primary" onclick="add_newsletter(this); return false;">저장</button>
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
            <!-- /End Page Cotents --> 
