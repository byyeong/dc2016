<script type="text/javascript" src="/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
    tinyMCE.init({
        relative_urls : false,
        remove_script_host : false,
        mode : "specific_textareas",
        editor_selector : "con",
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

{? msgt}
{? res.app}
_m = "Benefit(스타트업 지원 프로그램) 상세 설정을 완료했습니다.<br><br>저장 후 신청 지원서 작성을 시작합니다.";
$('#md-warning-ch .btn-danger').html('다음으로');
$('#md-warning-ch .btn-danger').attr('onclick', 'javascript:location.href="/program/apply_info/{res.id}"');
$('#md-warning-ch p').html(_m);
$('#md-warning-ch').modal('show');
{:}
_m = "Benefit(스타트업 지원 프로그램) 상세 설정을 완료했습니다.<br><br>저장 후 목록로 이동합니다.";
$('#md-warning-ch .btn-danger').html('목록으로');
$('#md-warning-ch .btn-danger').attr('onclick', 'javascript:location.href="/member/edit_program_m"');
$('#md-warning-ch p').html(_m);
$('#md-warning-ch').modal('show');
{/}
{/}

</script>
    <!-- rowContent -->
    <div class="rowContent"  id="competition"> 
        
        <div class="page-header">
            <div class="container">
                <h2><a href="/program">Benefit</a></h2>
                {? (s.per & settings->permission1) == settings->permission1}
                {? s.ids}
                <button  class="btn btn-primary pull-right" onclick=location.href='/program/edit'><span class="icon-pencil"></span> 프로그램 만들기</button>
                {:}
                <button  class="btn btn-primary pull-right" onclick="javascript:alert('로그인이 필요합니다.');"><span class="icon-pencil"></span> 프로그램 만들기</button>
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
                        <h3><a href="/member/edit_program_m">Benefit 관리</a> > 프로그램 상세 설정</h3>
                     </div>
                    <div class="edit-body">   
                        <!-- tab-content -->
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="/program/edit/{res.id}">{? res}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}신청 정보 입력</a></li>
                            {? res.app}
                            <li><a href="/program/apply_info/{res.id}">{? res.basic || res.forms || res.form_file}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}지원서 만들기</a></li>
                            {/}
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="formInfo">
                                <form class="form-horizontal" name="edit_pro_f" action="/program/edit/{res.id}" role="form" method="post" onsubmit="return false;" enctype="multipart/form-data" >
                                    <fieldset>
                                        
                                        <legend class="sr-only">프로그램 정보 입력</legend>
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">프로그램명</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <input type="text" name="title" value="{res.title}" class="form-control input-xlarge" required="required">
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">지원기관</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <input type="text" name="agency" value="{res.agency}" class="form-control input-xlarge" required="required">
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">성격</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <select name="cat_id" class="selectpicker sort-options">
                                                    <optgroup label="진행상태별 보기">
                                                        {@ category}
                                                        <option value="{.id}" {? res.cat_id == .id}selected="selected"{/}>{.category}</option>
                                                        {/}
                                                    </optgroup>
                                                </select>
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">접수 기간</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <select name="a_start" data-width="auto" class="selectpicker" onchange="check_date(this); return false;">
                                                    <option value="0" {? res && !res.a_start}selected="selected"{/}>상시</option>
                                                    <option value="1" {? !res || res.a_start}selected="selected"{/}>일정 선택</option>
                                                </select>
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group" {? res && !res.a_start}style="display: none;"{/} id="a_date"> 
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label"></div>
                                            <div class="col-xs-12 col-sm-9 col-md-9"> 
                                                
                                                <!-- datepicker -->
                                                <div class="bfh-datepicker" data-format="y-m-d">
                                                    <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                        <input type="text" class="form-control datepicker" name="a_start_d" value="{=substr(res.a_start, 0, 10)}" readonly>
                                                    </div>
                                                </div>
                                                <!-- /datepicker --> 
                                                
                                                <!-- timepicker -->
                                                <div class="bfh-timepicker" data-time="{? res.time_s}{res.time_s}{:}10:00{/}" >
                                                    <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                        <input type="text" class="form-control timepicker" name="a_start_t" value="{=substr(res.a_start, 11)}" placeholder="시작시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                    </div>
                                                </div>
                                                <!-- /timepicker --> 
                                                <span class="sim">&sim;</span> 
                                                
                                                <!-- datepicker -->
                                                <div class="bfh-datepicker" data-format="y.m.d">
                                                    <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                        <input type="text" class="form-control datepicker" name="a_end_d" value="{=substr(res.a_end, 0, 10)}" readonly>
                                                    </div>
                                                </div>
                                                <!-- /datepicker --> 
                                                
                                                <!-- timepicker -->
                                                <div class="bfh-timepicker" data-time="{? res.time_e}{res.time_e}{:}19:00{/}" >
                                                    <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                        <input type="text" class="form-control timepicker" name="a_end_t" value="{=substr(res.a_end, 11)}" placeholder="종료시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                    </div>
                                                </div>
                                                <!-- /timepicker --> 
                                                
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">인원</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <select name="cnt_c" data-width="auto" class="selectpicker" onchange="check_cnt(this); return false;">
                                                    <option value="0" {? res && res.cnt == 0}selected="selected"{/}>제한 없음</option>
                                                    <option value="1" {? !res || res.cnt > 0}selected="selected"{/}>숫자 입력</option>
                                                </select>
                                                <div class="input-wrap" id="inputCnt" style="display: {? !res || res.cnt > 0}block{:}none{/}; padding: 6px 0 0 0;">
                                                    <input type="number" name="cnt" value="{res.cnt}" class="form-control input-xlarge" onKeyup="onlyNumberCom(this);" placeholder="인원 수를 임력해주세요"> 
                                                </div>
                                            </div>
                                            
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >요약 내용</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <textarea  rows="5" class="form-control" name="summary">{res.summary}</textarea>
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >상세 내용</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <textarea  rows="20" class="form-control con" name="con" id="con"></textarea>
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >대표 이미지</div>
                                            <div class="col-xs-12 col-sm-9 col-sm-9">
                                                <input type="hidden" name="img" id="img" value="">
                                                <img class="img-thumbnail" src="{?res.img}{res.img}?{=date('his')}{:}/img/default-img-event.png{/}" id="img_img" onclick="toggle_img();return false;">
                                                <div id="div_img_change" style="display: none;">
                                                    <iframe  height="600" frameborder="0" width="100%" scrolling="no" id="frm" allowTransparency="true" src="/ajax_front/form_file?which=img&r_width=300&r_height=300" ></iframe>
                                                </div>
                                                <span class="help-block">대표이미지는 리스트에 출력됩니다. 가로세로 300x300 픽셀 사이즈로 업로드 해주세요.</span>
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >담당자 전화번호</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <input type="text" name="tel" value="{res.tel}" class="form-control input-xlarge">
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >담당자 주소</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <input type="text" name="addr" value="{res.addr}" class="form-control input-xlarge">
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">첨부 파일</div>
                                            <div class="col-xs-12 col-sm-9 col-sm-9">
                                                <label class="file-inline">
                                                    {? res.file}<a href="/program/get_pr_source?ev={res.id}">{res.filename}</a> <input type="checkbox" name="del_file" value="{res.file}"> 파일 삭제{/}
                                                    <input type="file" name="file"> *8MB까지 업로드 가능합니다.
                                                </label> 
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">공개 여부</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <select name="open" data-width="auto" class="selectpicker">
                                                    <option value="0" {? res.open == 0}selected="selected"{/}>비공개</option>
                                                    <option value="1" {? res.open == 1}selected="selected"{/}>공개</option>
                                                </select>
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">지원서 등록</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <select name="app" data-width="auto" class="selectpicker">
                                                    <option value="0" {? res.app == 0}selected="selected"{/}>이용안함</option>
                                                    <option value="1" {? res.app == 1}selected="selected"{/}>이용</option>
                                                </select>
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group form-submit">
                                            <div class="col-xs-12 col-sm-offset-3 col-sm-9 col-md-offset-3 col-md-9">
                                                {? !res || res.status == 0 }
                                                <a href="#" onclick="go_cancel(this); return false;" class="btn btn-default">취소</a> 
                                                <a href="#" onclick="go_submit(this); return false;" class="btn btn-primary">승인 신청</a> 
                                                {/}
                                                승인 후에는 수정할 수 없습니다.
                                            </div>
                                        </div>

                                        <input type="hidden" name="id" value="{res.id}" />
                                        <input type="hidden" name="user_id" value="{s.id}" />
                                        <input type="hidden" name="startup_id" value="{res.startup_id}" />
                                        <input type="hidden" name="content" id="content" value="" />
                                    </fieldset>
                                </form>
                            </div> 
                        </div>
                        <!-- /tab-content -->
                    </div>
                </div>
                <!-- /panel --> 
            </div>
            <!-- /container --> 
        </div>
        <!-- /page-content --> 
    </div>
    <!-- /rowContent --> 