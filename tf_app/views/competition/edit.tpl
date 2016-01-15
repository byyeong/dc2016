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
    
    function check_platform(_this) {
        var _ch = $("select[name=platform]").val();
        if (_ch === '0') {
            $('#out_platform').slideDown();
        } else {
            $('#out_platform').slideUp();
        }
    }
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
                            <li class="active"><a href="/competition/edit/{res.id}">{? res}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}경진대회 정보 입력</a></li>
                            {? res.status == 1}
                            <li><a href="/competition/apply_info/{res.id}">{? res.form}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}참가신청 정보 설정</a></li>
                            <li><a href="/competition/score_info/{res.id}">{? res.score}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}평가 항목 설정</a></li>
                            <li><a href="/competition/examiner/{res.id}">{? exn}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}심사위원 초대</a></li>
                            <li><a href="/competition/winner/{res.id}">{? res.winner}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}수상자 선정</a></li>
                            {/}
                        </ul>
                     </div>
                    <div class="edit-body">   
                        <!-- tab-content -->
                        <div class="tab-content">
                            <div class="tab-pane active" id="formInfo">
                                <form class="form-horizontal" name="edit_com_f" action="/competition/edit/{res.id}" role="form" method="post" onsubmit="return false;" enctype="multipart/form-data" >
                                    <fieldset>
                                        <input type="hidden" name="user_id" value="{s.id}" />
                                        <input type="hidden" name="id" value="{res.id}" />
                                        <input type="hidden" name="contents" id="contents" value="" />
                                        <legend class="sr-only">경진대회 정보 입력</legend>
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">경진 대회명</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <input type="text" name="subject" value="{res.subject}" class="form-control input-xlarge">
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">주최&middot;주관 기관</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <input type="text" name="organized" value="{res.organized}" class="form-control input-xlarge">
                                                <span class="help-block">창업유관 기관이 등록되어야 하며, 여러개 등록 가능합니다</span> </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">접수 기간</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9"> 
                                                
                                                <!-- datepicker -->
                                                <div class="bfh-datepicker" data-format="y.m.d">
                                                    <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                        <input type="text" class="form-control datepicker" name="date_s" value="{res.date_s}" readonly>
                                                    </div>
                                                </div>
                                                <!-- /datepicker --> 
                                                
                                                <!-- timepicker -->
                                                <div class="bfh-timepicker" data-time="{? res.time_s}{res.time_s}{:}10:00{/}" >
                                                    <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                        <input type="text" class="form-control timepicker" name="time_s" value="{res.time_s}" placeholder="시작시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                    </div>
                                                </div>
                                                <!-- /timepicker --> 
                                                <span class="sim">&sim;</span> 
                                                
                                                <!-- datepicker -->
                                                <div class="bfh-datepicker" data-format="y.m.d">
                                                    <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                        <input type="text" class="form-control datepicker" name="date_e" value="{res.date_e}" readonly>
                                                    </div>
                                                </div>
                                                <!-- /datepicker --> 
                                                
                                                <!-- timepicker -->
                                                <div class="bfh-timepicker" data-time="{? res.time_e}{res.time_e}{:}19:00{/}" >
                                                    <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                        <input type="text" class="form-control timepicker" name="time_e" value="{res.time_e}" placeholder="종료시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                    </div>
                                                </div>
                                                <!-- /timepicker --> 
                                                
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">발표 일자</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9"> 
                                                
                                                <!-- datepicker -->
                                                <div class="bfh-datepicker" data-format="y.m.d">
                                                    <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                        <input type="text" class="form-control datepicker" name="announce_d" value="{res.announce_d}" readonly>
                                                    </div>
                                                </div>
                                                <!-- /datepicker --> 
                                                
                                                <!-- timepicker -->
                                                <div class="bfh-timepicker" data-time="{? res.announce_t}{res.announce_t}{:}10:00{/}" >
                                                    <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                        <input type="text" class="form-control timepicker"  placeholder="시작시간" name="announce_t" value="{res.announce_t}" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                    </div>
                                                </div>
                                                <!-- /timepicker --> 
                                                
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">참가자 공개Pitching</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <select class="selectpicker" data-width="auto" name="public">
                                                    <option value="1" {? res.public}selected="selected"{/}>사용</option>
                                                    <option value="0" {? !res.public}selected="selected"{/}>사용하지 않음</option> 
                                                </select>
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >상세 내용</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <textarea  rows="20" class="form-control" name="cont" id="inputDesc">{res.contents}</textarea>
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >대표 이미지</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <input type="hidden" name="pic" id="pic" value="">
                                                <img class="img-thumbnail" src="{?res.img}{res.img}{:}/img/default-img-event.png{/}" id="pic_img" onclick="toggle_img();return false;">
                                                <div id="div_img_change" style="display: none;">
                                                    <iframe  height="550" frameborder="0" width="100%" scrolling="no" id="frm" allowTransparency="true" src="/ajax_front/form_file?which=pic&r_width=300&r_height=300" ></iframe>
                                                </div>
                                                <span class="help-block">대표이미지는 리스트에 출력됩니다. 가로세로 300x300 픽셀 사이즈로 업로드 해주세요.</span>
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label"> 자료 첨부</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                {? res.file}<a href='/competition/get_cp_source?cp={res.id}&file={res.file}'>{res.file}</a>{/}
                                                <p class="form-control-static">
                                                    <input type="file" name="source">
                                                </p>
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label"> 플랫폼 사용 여부</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <select class="selectpicker" data-width="auto" name="platform" onchange="check_platform(this); return false;">
                                                    <option value="1" {? !res || res.platform}selected="selected"{/}>D.CAMP의 OC(open competition) 사용</option>
                                                    <option value="0" {? res.platform == '0'}selected="selected"{/}>외부 OC 사용</option>
                                                </select>
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        <div class="form-group" id="out_platform" {? !res || res.platform}style="display: none;"{/}>
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label"> 외부 OC URL</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <input type="text" name="platform_out" value="{res.platform_out}" class="form-control input-xlarge">
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label"> 공개 여부</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <select data-width="auto" class="selectpicker" name="open">
                                                    <option value="1" {? res.open}selected="selected"{/}>공개</option>
                                                    <option value="0" {? !res.open}selected="selected"{/}>비공개</option>
                                                </select>
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        <div class="form-group form-submit">
                                            <div class="col-xs-12 col-sm-offset-3 col-sm-9 col-md-offset-3 col-md-9">
                                                {? !res || res.status == 0 || res.sdate > date("Y.m.dH:i")}
                                                <a href="#" onclick="go_cancel(this); return false;" class="btn btn-default">취소</a> 
                                                <a href="#" onclick="go_submit(this); return false;" class="btn btn-primary">확인</a> 
                                                {:} 
                                                <p class="text-danger">경진대회의 접수기간 이전에만 수정 할 수 있습니다.</p>
                                                 {/}
                                            </div>
                                        </div>
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
    
<script type="text/javascript">
//<![CDATA[

function go_cancel(_id)
{
    location.href='/competition/edit?cancel='+_id;
}

function go_submit(_this)
{
    
    if (!$('input[name=subject]').val()) {
        alert("경진 대회명을 입력해주세요.");
        document.edit_com_f.subject.focus();
        return false;
    }

    if (!$('input[name=organized]').val()) {
        alert("주최/주최 기간을 입력해주세요.");
        document.edit_com_f.organized.focus();
        return false;
    }
    
    if (!$('input[name=date_s]').val()) {
        alert("접수 시작일을 입력해주세요.");
        document.edit_com_f.date_s.focus();
        return false;
    }
    
    if (!$('input[name=date_e]').val()) {
        alert("접수 종료일을 입력해주세요.");
        document.edit_com_f.date_e.focus();
        return false;
    }

    if (!$('input[name=time_s]').val()) {
        alert("접수 시작시간을 입력해주세요.");
        document.edit_com_f.time_s.focus();
        return false;
    }
    
    if (!$('input[name=time_e]').val()) {
        alert("접수 종료시간을 입력해주세요.");
        document.edit_com_f.time_e.focus();
        return false;
    }

    if (!$('input[name=announce_d]').val()) {
        alert("발표 일을 입력해주세요.");
        document.edit_com_f.announce_d.focus();
        return false;
    }
    
    var now = new Date(); 
    var todayAtMidn = new Date(now.getFullYear(), now.getMonth(), now.getDate(), now.getHours(), now.getMinutes());
    
    var _e_s_date = new Date($('input[name=date_s]').val().substr(0,4),($('input[name=date_s]').val().substr(5,2)-1),$('input[name=date_s]').val().substr(8,2), $('input[name=time_s]').val().substr(0,2), $('input[name=time_s]').val().substr(3,2));
    var _e_e_date = new Date($('input[name=date_e]').val().substr(0,4),($('input[name=date_e]').val().substr(5,2)-1),$('input[name=date_e]').val().substr(8,2), $('input[name=time_e]').val().substr(0,2), $('input[name=time_e]').val().substr(3,2));

    if (_e_s_date.getTime() >= _e_e_date.getTime())
    {
        alert("접수 기간 종료시간이 시작시간보다 빠릅니다.");
        document.add_event_f.date.focus();
        return false;
    }
    
    if (todayAtMidn.getTime() > _e_s_date.getTime())
    {
        alert("접수 기간 시작시간이 현재시간보다 빠릅니다.");
        document.add_event_f.date_e.focus();
        return false;
    }
    
    $(_this).hide();
    document.getElementById("contents").value = tinyMCE.activeEditor.getContent();
    document.edit_com_f.submit();
}

//]]>
</script>