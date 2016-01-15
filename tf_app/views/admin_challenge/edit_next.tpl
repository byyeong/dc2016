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
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-edit"></span><span class="break"></span>경진대회 작성하기</h2>
                            <div class="actions"> <span class="break"></span> <a title="목록보기" data-toggle="tooltip" href="/admin_challenge"><span class="glyphicon  glyphicon-align-justify"></span></a> </div>
                        </div>
                        <!-- /panel-heading -->
                        
                        <div class="panel-heading">
                            <!--ol data-progtrckr-steps="7" class="stepProgress">
                                <li class="{? step > 0}step-done{:}step-todo{/}">정보입력</li>
                                <li class="{? step > 1}step-done{:}step-todo{/}">승인받기</li>
                                <li class="{? step > 2}step-done{:}step-todo{/}">세부정보 설정</li>
                                <li class="{? step > 3}step-done{:}step-todo{/}">접수준비</li>
                                <li class="{? step > 4}step-done{:}step-todo{/}">접수중</li>
                                <li class="{? step > 5}step-done{:}step-todo{/}">접수마감</li>
                                <li class="{? step > 6}step-done{:}step-todo{/}">수상자 발표</li>
                            </ol-->

                            <ul class="nav nav-tabs">
                                <li><a href="/admin_challenge/edit/{res.id}">{? res}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}신청 정보 입력</a></li>
                                {? res.status == 1}
                                <li class="active"><a href="/admin_challenge/edit_next/{res.id}">{? res.announce_d}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}대회 정보 입력</a></li>
                                <li><a href="/admin_challenge/apply_info/{res.id}">{? for}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}지원서 만들기</a></li>
                                <li><a href="/admin_challenge/score_info/{res.id}">{? sco}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}평가지 만들기</a></li>
                                <li><a href="/admin_challenge/operator/{res.id}">{? op}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}운영진 초대</a></li>
                                <li><a href="/admin_challenge/examiner/{res.id}">{? exn}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}심사위원 초대</a></li>
                                <li><a href="/admin_challenge/winner/{res.id}">{? res.winner}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}수상자 선정</a></li>
                                {/}
                            </ul>
                        </div>
                        
                        
                        <form class="form-horizontal" name="edit_com_f" action="/admin_challenge/edit_next/{res.id}" role="form" method="post" onsubmit="return false;" enctype="multipart/form-data" >
                            <div class="panel-body" id="setting-info">
                                <fieldset>
                                    <input type="hidden" name="user_id" value="{?res.user_id}{res.user_id}{:}{s.id}{/}" />
                                    <input type="hidden" name="id" value="{res.id}" />
                                    <input type="hidden" name="platform" value="1" />
                                    <input type="hidden" name="status_o" value="{res.status}" />
                                    <input type="hidden" name="contents" id="contents" value="" />

                                    <legend class="sr-only">경진대회 정보 입력</legend>

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">URL 설정 <span class="fa fa-question-circle" data-toggle="popover" title="영문,숫자, - (하이픈), _ (언더바)를 사용할 수 있습니다. 따로 설정하지 않으면 임의의 숫자로 자동 설정됩니다."></span></div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 form-inline">
                                            http://dcamp.kr/challenge/<input type="text" class="form-control" placeholder="98" name="url" value="{res.url}" style='ime-mode:disabled;' onblur="check_c_url(this); return false;">
                                            <span class="text-danger" id="double_url" style="display: none;" ><span class="icon-warning-sign"></span> url이 중복되었습니다. 변경해주세요.</span>
                                        </div>
                                    </div>
                                    <!-- /form-group -->

                                    {? res.department}
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">분야별 접수 <span class="fa fa-question-circle" data-toggle="popover" title="분야별로 다른 양식의 지원서를 접수받는 경우 참가 분야별로 별도의 페이지를 생성합니다.
분야별 페이지 및 심사위원, 운영진을 각각 설정하셔야 합니다.
분야별 접수 기능은 대회 정보 첫 입력시에만 선택이 가능합니다."></span>
                                        </div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <input type="text" name="department" value="{res.department}" class="form-control input-xlarge"> 
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    {:}
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label"> 
                                          분야별 접수 <span class="fa fa-question-circle" data-toggle="popover" title="분야별로 다른 양식의 지원서를 접수받는 경우 참가 분야별로 별도의 페이지를 생성합니다.
분야별 페이지 및 심사위원, 운영진을 각각 설정하셔야 합니다.
분야별 접수 기능은 대회 정보 첫 입력시에만 선택이 가능합니다."></span>
                                        </div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <div class="checkbox">
                                              <label>
                                                <input type="checkbox" name="department_add" onchange="check_department(this); return false;" {? sizeof(res.dpt_l) > 1}checked="checked"{/}> 분야별 접수받기
                                              </label>
                                            </div>
                                            <span class="help-block">각기 다른 분야의 접수를 받아야 할 경우 체크하세요.</span>

                                            <div class="well form-inline" id="add_dp" {? sizeof(res.dpt_l) > 1}{:}style="display: none;"{/}>
                                              {@ res.dpt_l}
                                              <p><input type="text" class="form-control" placeholder="분야를 입력하세요." name="dpt{.key_+1}" value="{.department}"></p>
                                              {/}
                                              <button class="btn btn-default btn-sm" onclick="add_input(this, a_dpt); return false;">추가하기</button>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    {/}

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label"> 
                                            비회원 참여 가능 여부 <span class="fa fa-question-circle" data-toggle="popover" title="'가능'을 선택하면, D.CAMP회원에 가입하지 않은 경우에도 대회에 참여 가능합니다.
비회원 참가자는 지원서 접수 내용을 확인, 수정할 수 없습니다."></span>
                                        </div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <label class="radio-inline">
                                              <input type="radio" name="logined" id="competeAllOptions_yes" value="1" {? res.opened}checked="checked"{/}> 가능
                                            </label>
                                            <label class="radio-inline">
                                              <input type="radio" name="logined" id="competeAllOptions_no" value="0" {? !res.opened}checked="checked"{/}> 불가능
                                            </label>
                                            <span class="help-block">'가능'을 선택하면, D.CAMP회원이 아니더라도 참여 가능하도록 할 수 있습니다.</span> 
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">발표 일자 <span class="fa fa-question-circle" data-toggle="popover" title="경진대회 결과 발표 일자를 선택해 주세요."></span>
                                        </div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            
                                            <!-- datepicker -->
                                            <div class="bfh-datepicker" data-format="y.m.d">
                                                <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                    <input type="text" class="form-control datepicker" name="announce_d" value="{res.announce_d}" readonly>
                                                </div>
                                            </div>
                                            <!-- /datepicker --> 

                                            <!-- timepicker -->
                                            <div class="bfh-timepicker" data-time="{? res.announce_t}{res.announce_t}{:}10:00{/}" >
                                                <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
                                                    <input type="text" class="form-control timepicker"  placeholder="시작시간" name="announce_t" value="{res.announce_t}" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                </div>
                                            </div>
                                            <!-- /timepicker --> 
                                            
                                        </div>
                                    </div>
                                    <!-- /form-group -->

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >한줄 설명 <span class="fa fa-question-circle" data-toggle="popover" title="한줄 설명은 리스트에 출력됩니다."></span></div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <input type="text" class="form-control" name="summary" value="{res.summary}">
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">상세 내용 <span class="fa fa-question-circle" data-toggle="popover" title="경진대회 메인 페이지입니다."></span>
                                        </div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <textarea  rows="20" class="form-control" name="cont" id="inputDesc">{res.contents}</textarea>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">대표 이미지 <span class="fa fa-question-circle" data-toggle="popover" title="대표이미지는 리스트에 출력됩니다. 가로세로 300x300 픽셀 사이즈로 업로드 해주세요."></span>
                                        </div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <input type="hidden" name="pic" id="pic" value="">
                                            <img class="img-thumbnail" src="{?res.img}{res.img}{:}/img/default-img-event.png{/}" id="pic_img" onclick="toggle_img();return false;">
                                            <div id="div_img_change" style="display: none;">
                                                <iframe  height="550" frameborder="0" width="100%" scrolling="no" id="frm" allowTransparency="true" src="/ajax_front/form_file?which=pic&r_width=300&r_height=300" ></iframe>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /form-group -->

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">상단 배경 이미지
                                         <span class="fa fa-question-circle" data-toggle="popover" title="상단 배경이미지는 대회 상세 페이지에 출력됩니다. 가로세로 800x260 픽셀 사이즈로 업로드 해주세요."></span>
                                        </div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <input type="hidden" name="top_img" id="top" value="">
                                            <img class="img-thumbnail" src="{?res.top_img}{res.top_img}{:}/img/common/800x260.png{/}" id="top_img" onclick="toggle_img2();return false;">
                                            <div class="div_img_change2" style="display: none;">
                                                <iframe  height="1150" frameborder="0" width="100%" scrolling="no" id="frm" allowTransparency="true" src="/ajax_front/form_file?which=top&r_width=800&r_height=260" ></iframe>
                                            </div>
                                            <p class="form-control-static">
                                                <input type="text" class="form-control" placeholder="제목을 입력해주세요. (경진 대회명을 입력하면 자동입력됩니다.)" name="top_title" value="{? res.top_title}{res.top_title}{:}{res.subject}{/}">
                                            </p>
                                            <span class="help-block">상단 배경이미지 위에 타이틀로 출력됩니다.</span>
                                            <p class="form-control-static">
                                                <input type="text" class="form-control" placeholder="부제목을 입력해주세요." name="top_sub" value="{res.top_sub}">
                                            </p>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label"> 자료 첨부 <span class="fa fa-question-circle" data-toggle="popover" title="참가 신청자들에게 배포해야 하는 자료를 첨부할 수 있습니다."></span>
                                        </div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            {? res.a_file}
                                            <ul class="list-unstyled">
                                                {@ res.a_file}
                                                <li class="form-control-static">
                                                    <a href='/challenge/get_cp_file?cid={.competitions_id}&fid={.id}&file={.name}'>{.name}</a>
                                                    <button aria-label="Close" class="close close-inline" type="button" onclick="del_c_a_file(this, '{.id}'); return false;"><span aria-hidden="true">×</span></button>
                                                </li>
                                                {/}
                                            </ul>
                                            {/}
                                            <p class="form-control-static">
                                                <input type="file" name="afile1">
                                            </p>
                                            <button class="btn btn-default btn-sm" onclick="add_input(this, a_f); return false;">첨부파일 추가</button>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">공개여부</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <select data-width="auto" class="selectpicker" name="open">
                                                <option value="1" {? res.open}selected="selected"{/}>공개</option>
                                                <option value="0" {? !res.open}selected="selected"{/}>비공개</option>
                                            </select>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    <input type="hidden" name="dpt_cnt" value="{? sizeof(res.dpt_l)}{=sizeof(res.dpt_l)}{:}1{/}" />
                                    <input type="hidden" name="f_cnt" value="{? sizeof(res.a_file)}{=sizeof(res.a_file)}{:}1{/}" />
                                </fieldset>
                            </div>
                            <!--/panel-body -->
                            
                            <div class="panel-footer">
                                <div class="col-lg-offset-2">
                                    <a href="#" onclick="go_cancel(this); return false;" class="btn btn-default">취소</a> 
                                    <a href="#" onclick="go_submit(this); return false;" class="btn btn-primary">확인</a> 
                                    <a href="/challenge/views/{res.id}" target="_blank" class="btn btn-primary pull-right">미리보기</a> 
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
<script type="text/javascript">
//<![CDATA[

{? msg}
alert('{msg}');
{/}

{? msgt}
_m = "Challenge 공고 페이지 작성을 완료했습니다.<br><br>저장 후 참가자 지원서 작성을 시작합니다.";
$('#md-warning-ch .btn-danger').html('다음으로');
$('#md-warning-ch .btn-danger').attr('onclick', 'javascript:location.href="/admin_challenge/apply_info/{res.id}"');
$('#md-warning-ch p').html(_m);
$('#md-warning-ch').modal('show');
{/}

function copy_subject(_this)
{
    $('input[name=top_title]').val($(_this).val());
}

function check_c_url(_this)
{
    if ($(_this).val().length < 1 ) {
        return false;
    }

    var get_url = '/ajax_v3/check_c_url/';
    var set_data ={
        "id"      : $('input[name=id]').val(),
        "url"     : $(_this).val()
    };
    
    $.post(get_url, set_data, function(_data){
        if (_data) {
            $('#double_url').slideDown();
        }
        else {
            $('#double_url').slideUp();
        }
    });
}

function check_platform(_this) {
    var _ch = $(':radio[name="platform"]:checked').val();
    if (_ch === '0') {
        $('#out_platform').slideDown();
        $('#in_platform').slideUp();
    } else {
        $('#out_platform').slideUp();
        $('#in_platform').slideDown();
    }
}

function check_department(_this) {
    var _ch = $(_this).is(':checked');
    if (_ch === true) {
        $('#add_dp').slideDown();
    } else {
        $('#add_dp').slideUp();
    }
}

function go_cancel(_id)
{
    location.href='/admin_challenge/edit?cancel='+_id;
}

function go_submit(_this)
{
    

    if (!$('input[name=announce_d]').val()) {
        alert("발표 일을 입력해주세요.");
        document.edit_com_f.announce_d.focus();
        return false;
    }
    $(_this).hide();
    document.getElementById("contents").value = tinyMCE.activeEditor.getContent();
    document.edit_com_f.submit();
}

function del_c_a_file(_this, _id) 
{
    var r = confirm("해당 파일을 삭제하겠습니까?");
    if (r == true) {
        var get_url = '/ajax_v3/del_c_a_file/'+_id;
        
        $.post(get_url, function(_data){
            $(_this).parent().remove();
        });
    }
        
}

var a_dpt = '<p><input type="text" placeholder="분야를 입력하세요." class="form-control" ></p>';

var a_f = '<p class="form-control-static"><input type="file"></p>';

function add_input(_this, _target) {
    if (_target == a_dpt) {
        cnt = parseInt($('input[name=dpt_cnt]').val())+1;
        $(_this).before(_target);
        $('input[name=dpt_cnt]').val(cnt);
        $(_this).prev().find('input').attr('name', 'dpt'+cnt);
    } 
    else if (_target == a_f) {
        cnt = parseInt($('input[name=f_cnt]').val())+1;
        $(_this).before(_target);
        $('input[name=f_cnt]').val(cnt);
        $(_this).prev().find('input').attr('name', 'afile'+cnt);
    } 
}
//]]>
</script>