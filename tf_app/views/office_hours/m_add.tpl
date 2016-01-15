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
                tinyMCE.activeEditor.setContent("{? res}{=safe_js_editor(res.description)}{:}{=safe_js_editor(m.oh_description)}{/}");
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
    <div class="rowContent"  id="userProfile"> 
        
        <!-- page-header -->
        <div class="page-header">
            <div class="container">
                <h2><a href="/office_hours/m_list">Office Hours</a></h2>

                <a href="/office_hours/m_info" class="btn btn-default btn-sm pull-right">
                    <span class="icon-fixed-width icon-large icon-user"></span> 멘토정보 수정하기 
                </a>
                <a href="/office_hours/m_apply_all" class="btn btn-default btn-sm pull-right">
                    <span class="fa fa-fw fa-check-square"></span> 신청자 모두보기 
                </a>
                <a href="/office_hours/m_add" class="btn btn-primary btn-sm pull-right">
                    <span class="icon-fixed-width icon-large icon-edit"></span> Office Hours 추가하기
                </a>
                <a href="/office_hours/m_list" class="btn btn-default btn-sm pull-right">
                    <span class="icon-fixed-width icon-large icon-list"></span> 전체 리스트보기
                </a>
            </div>
        </div>
        <!-- /page-header --> 
        
        <!-- page-content -->
        <div class="page-content"> 
            <!-- container -->
            <div class="container">
                 
                 <div class="editor">
                    <div class="edit-header">
                        <h2><a href="/office_hours/m_list">Office Hours</a></h2>
                    </div>
                    
                    <div class="edit-body">
                        <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation" class="active">
                                <a href="#edit-info" aria-controls="edit-info" role="tab" data-toggle="tab">OH 신청정보 </a>
                            </li>
                            <li role="presentation">
                                <a href="#edit-apply" aria-controls="edit-apply" role="tab" data-toggle="tab">지원서 양식</a>
                            </li> 
                        </ul>

                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active" id="edit-info">
                                <form class="form-horizontal" role="form" method="post" onsubmit="return false;" name="f_oh_add"> 
                                    <fieldset>
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >멘토 </div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <input type="text" class="form-control" value="{? res.name}{res.name}{:}{s.name}{/}" disabled="disabled">
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >Office Hours  제목 </div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <input type="text" class="form-control" name="subject" value="{? res}{res.subject}{:}{m.subject}{/}" required>
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                         <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >주최/주관</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <input type="text" class="form-control" name="hosted" value="{? res}{res.hosted}{:}{m.hosted}{/}">
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                         <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >행사 장소</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <input type="text" class="form-control" name="place" value="{res.place}" required>
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group"> 
                                            <label class="col-xs-12 col-sm-3 col-md-3 control-label">행사일시 </label>
                                            <div class="col-xs-12 col-sm-9 col-md-9"> 

                                                <!-- datepicker -->
                                                <div class="bfh-datepicker" data-format="y.m.d">
                                                    <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                        <input type="text" class="form-control datepicker" name="e_start" value="{=substr(res.e_start, 0, 10)}" readonly required="required">
                                                    </div>
                                                </div>
                                                <!-- /datepicker --> 

                                                <!-- timepicker -->
                                                <div class="bfh-timepicker" data-time="{? res.start}{res.start}{:}10:00{/}" >
                                                    <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                        <input type="text" class="form-control timepicker" placeholder="" name="e_start_t" value="{=substr(res.e_start, 11, 5)}" maxlength="5" onKeyup="onlyNumber(this);">
                                                    </div>
                                                </div>
                                                <!-- /timepicker -->
                                                
                                                <span class="sim">&sim;</span> 

                                                <!-- datepicker -->
                                                <div class="bfh-datepicker" data-format="y.m.d">
                                                    <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                        <input type="text" class="form-control datepicker" name="e_end" value="{=substr(res.e_end, 0, 10)}" readonly required="required">
                                                    </div>
                                                </div>
                                                <!-- /datepicker --> 

                                                <!-- timepicker -->
                                                <div class="bfh-timepicker" data-time="{? res.start}{res.start}{:}19:00{/}" >
                                                    <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                        <input type="text" class="form-control timepicker" placeholder="" name="e_end_t" value="{=substr(res.e_end, 11)}" maxlength="5" onKeyup="onlyNumber(this);">
                                                    </div>
                                                </div>
                                                <!-- /timepicker -->
                                            </div>
                                        </div>
                                        <!-- /form-group --> 

                                        <div class="form-group"> 
                                            <label class="col-xs-12 col-sm-3 col-md-3 control-label">상담 시작시간 </label>
                                            <div class="col-xs-12 col-sm-9 col-md-9"> 

                                                <div class="bfh-timepicker" data-time="{? res.start}{res.start}{:}10:00{/}" >
                                                    <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                        <input type="text" class="form-control timepicker" placeholder="상담 시작시간" name="start" value="{res.start}" maxlength="5" onKeyup="onlyNumber(this);">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >팀 별 상담시간 </div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <div class="input-group">
                                                  <input type="text" class="form-control" placeholder="팀/명의 상담하는 시간을 분단위로 적어주세요. 예)50" name="ing" value="{res.ing}" onKeyup="onlyNumberCom(this);">
                                                  <span class="input-group-addon">분</span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >휴식시간 </div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <div class="input-group">
                                                  <input type="text" class="form-control" placeholder="팀/명의 상담 후 휴식시간을 분단위로 적어주세요. 예)10" name="hue" value="{res.hue}" onKeyup="onlyNumberCom(this);">
                                                  <span class="input-group-addon">분</span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >상담 수</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <div class="input-group">
                                                  <input type="text" class="form-control" placeholder="상담할 팀/명의 수를 적어주세요." name="cnt" value="{res.cnt}" onKeyup="onlyNumberCom(this);">
                                                  <span class="input-group-addon">개</span>
                                                </div> 
                                            </div>
                                        </div>


                                        <div class="form-group"> 
                                            <label class="col-xs-12 col-sm-3 col-md-3 control-label">접수기간</label>
                                            <div class="col-xs-12 col-sm-9 col-md-9"> 

                                                <!-- datepicker -->
                                                <div class="bfh-datepicker" data-format="y.m.d">
                                                    <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                        <input type="text" class="form-control datepicker" name="a_start" value="{=substr(res.a_start, 0, 10)}" readonly required="required">
                                                    </div>
                                                </div>
                                                <!-- /datepicker --> 

                                                <!-- timepicker -->
                                                <div class="bfh-timepicker" data-time="{? res.start}{res.start}{:}10:00{/}" >
                                                    <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                        <input type="text" class="form-control timepicker" placeholder="" name="a_start_t" value="{=substr(res.a_start, 11)}" maxlength="5" onKeyup="onlyNumber(this);">
                                                    </div>
                                                </div>
                                                <!-- /timepicker -->
                                                
                                                <span class="sim">&sim;</span> 

                                                <!-- datepicker -->
                                                <div class="bfh-datepicker" data-format="y.m.d">
                                                    <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                        <input type="text" class="form-control datepicker" name="a_end" value="{=substr(res.a_end, 0, 10)}" readonly required="required">
                                                    </div>
                                                </div>
                                                <!-- /datepicker --> 

                                                <!-- timepicker -->
                                                <div class="bfh-timepicker" data-time="{? res.start}{res.start}{:}19:00{/}" >
                                                    <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                        <input type="text" class="form-control timepicker" placeholder="" name="a_end_t" value="{=substr(res.a_end, 11)}" maxlength="5" onKeyup="onlyNumber(this);">
                                                    </div>
                                                </div>
                                                <!-- /timepicker -->
                                            </div>
                                        </div>
                                        <!-- /form-group --> 

                                        <div class="form-group"> 
                                            <label class="col-xs-12 col-sm-3 col-md-3 control-label">발표일자 </label>
                                            <div class="col-xs-12 col-sm-9 col-md-9"> 

                                                <!-- datepicker -->
                                                <div class="bfh-datepicker" data-format="y.m.d">
                                                    <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                        <input type="text" class="form-control datepicker" name="r_date" value="{=substr(res.r_date, 0, 10)}" readonly required="required">
                                                    </div>
                                                </div>
                                                <!-- /datepicker --> 

                                                <!-- timepicker -->
                                                <div class="bfh-timepicker" data-time="{? res.start}{res.start}{:}10:00{/}" >
                                                    <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                        <input type="text" class="form-control timepicker" placeholder="" name="r_date_t" value="{=substr(res.r_date, 11)}" maxlength="5" onKeyup="onlyNumber(this);">
                                                    </div>
                                                </div>
                                                <!-- /timepicker -->
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                         <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >내용</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <textarea rows="30" class="form-control" name="description">{res.description}</textarea>
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group"> 
                                            <label class="col-xs-12 col-sm-3 col-md-3 control-label">대표 이미지 </label>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <div>
                                                    <input type="hidden" name="picture" id="pic" value="{? !res}/img/default-img-pic.png{/}">
                                                    <img class="img-thumbnail" src="{?res.picture}{res.picture}?{=date('his')}{:}/img/common/300x300.png{/}" id="pic_img" onclick="toggle_img();return false;">
                                                    <div id="div_img_change" style="display: none;">
                                                        <iframe  height="600" frameborder="0" width="100%" scrolling="no" id="frm" allowTransparency="true" src="/ajax_front/form_file?which=pic&r_width=300&r_height=300" ></iframe>
                                                    </div>
                                                </div>
                                                <!-- /btn-group -->
                                            </div>
                                        </div>
                                        <!-- /form-group --> 
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">공개설정</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <label class="radio-inline">
                                                    <input type="radio" name="is_open" value="1" {? res.is_open}checked{/}> 공개
                                                </label>
                                                <label class="radio-inline">
                                                    <input type="radio" name="is_open" value="0" {? !res.is_open}checked{/}> 비공개
                                                </label>
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        <div class="form-group form-submit">
                                            <div class="col-xs-12 col-sm-offset-3 col-sm-9 col-md-offset-3 col-md-9">
                                                <button type="button" class="btn btn-default">취소</button>
                                                <button type="submit" class="btn btn-primary" onclick="submit_oh_add({? res.id}{res.id}{:}0{/}); return false;">저장</button>
                                            </div>
                                        </div>
                                        <input type="hidden" name="id" value="{res.id}" />
                                        <input type="hidden" id="contents" name="description"/>
                                    </fieldset>
                                </form>
                            </div>
                            <!-- /tab --> 
                            <div role="tabpanel" class="tab-pane" id="edit-apply">
                                <form class="form-horizontal" role="form" method="post" onsubmit="return false;" name="f_oh_form_add"> 
                                    <fieldset>
                                        <h3>기본질문 <small>아래 내용은 신청시 기본으로 받는 정보입니다.</small></h3>
                                        <div class="well">
                                            <ul>
                                                <li>참가자 이름</li>
                                                <li>휴대폰 번호</li>
                                                <li>이메일 주소</li>
                                                <li>참가 회사/팀명</li>
                                                <li>D.CAMP 기업프로필 주소</li>
                                                <li>제품/서비스명</li>
                                                <li>제품/서비스 한 줄 소개 (준비하고 계시는 제품/서비스를 한 문장 (50자 이내)으로 소개해주세요.)</li>
                                                <li>간단한 자기소개</li>
                                                <li>팀소개</li>
                                                <li>이야기 나누고 싶은 상담 주제</li>
                                                <li>첨부파일</li>
                                                <li>이전 Office Hours신청이력</li>
                                            </ul>
                                        </div>

                                        <h3>추가질문 <small>멘토가 특별히 요청하는 추가 질문을 추가하세요.</small></h3>

                                        {? form}
                                        {@ form}
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >추가질문 제목 </div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <button class="close" type="button" onclick="remove_pp(this);"><span>×</span></button>
                                                <input type="text" class="form-control" name="q{.key_+1}" value="{.subject}">
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        {/}
                                        {:}
                                        {? m_form}
                                        {@ m_form}
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >추가질문 제목 </div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <button class="close" type="button" onclick="remove_pp(this);"><span>×</span></button>
                                                <input type="text" class="form-control" name="q{.key_+1}" value="{.subject}">
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        {/}
                                        {:}
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >추가질문 제목 </div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <button class="close" type="button" onclick="remove_pp(this);"><span>×</span></button>
                                                <input type="text" class="form-control" name="q1">
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        {/}
                                        {/}
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-offset-3 col-sm-9 col-md-offset-3 col-md-9">
                                                <button type="button" class="btn btn-default btn-xs" onclick="add_input(this, a_q);">질문 추가하기 </button>
                                            </div>
                                        </div>

                                        <div class="form-group form-submit">
                                            <div class="col-xs-12 col-sm-offset-3 col-sm-9 col-md-offset-3 col-md-9">
                                                <button type="button" class="btn btn-default">취소</button>
                                                {? ! res.id || res.a_start > date('Y.m.d H:i')}
                                                <button type="submit" class="btn btn-primary" onclick="submit_oh_form({? res.id}{res.id}{:}0{/}); return false;">저장</button>
                                                {/} 
                                                (접수기간이 시작된 이후에는 수정할 수 없습니다.)
                                            </div>
                                        </div>
                                        <input type="hidden" name="q_cnt" value="{? form}{=sizeof(form)}{:}{? m_form}{=sizeof(m_form)}{:}1{/}{/}" />
                                        <input type="hidden" name="id" value="{res.id}" />
                                    </fieldset>
                                </form>
                            </div>
                            <!-- /tab --> 
                        </div>
                        <!-- /tab-content -->
                    </div>
                </div>
                <!-- /editor --> 


            </div>
            <!-- /container --> 
        </div>
        <!-- /page-content --> 
    </div>
    <!-- /rowContent -->