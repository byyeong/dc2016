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
                                <li class="active"><a href="/admin_challenge/edit/{res.id}">{? res}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}신청 정보 입력</a></li>
                                {? res.status == 1}
                                <li><a href="/admin_challenge/edit_next/{res.id}">{? res.announce_d}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}대회 정보 입력</a></li>
                                <li><a href="/admin_challenge/apply_info/{res.id}">{? for}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}지원서 만들기</a></li>
                                <li><a href="/admin_challenge/score_info/{res.id}">{? sco}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}평가지 만들기</a></li>
                                <li><a href="/admin_challenge/operator/{res.id}">{? op}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}운영진 초대</a></li>
                                <li><a href="/admin_challenge/examiner/{res.id}">{? exn}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}심사위원 초대</a></li>
                                <li><a href="/admin_challenge/winner/{res.id}">{? res.winner}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}수상자 선정</a></li>
                                {/}
                            </ul>
                        </div>
                        
                        
                        <form class="form-horizontal" name="edit_com_f" action="/admin_challenge/edit/{res.id}" role="form" method="post" onsubmit="return false;" enctype="multipart/form-data" >

                            <div class="panel-body" id="setting-info">
                                <div class="examiner-notice alert alert-info">
                                    <h4><i class="fa fa-microphone"></i> Challenge를 통해 지원서 접수 및 심사가 필요한 창업자 대상 프로그램( 경진대회등) 을 손쉽게 관리할 수 있습니다.</h4>
                                    <p>이용 프로세스는 다음과 같습니다.<br>
1. 아래 신청서를 입력하여 제출해 주세요.<br>
2. 프로그램 취지 및 목적을 검토하여 최대 48시간 이내에 승인이 이루어집니다.<br>
3. 진행하고자 하시는 프로그램의 상세 내용은 승인 후 입력이 가능합니다. (승인 결과 메일 안내)<br>
※ 승인 후 신청 내용 및 지원서 접수 일정의 수정이 필요한 경우에는 Q&A 게시판 - Challenge 관련 메뉴를 이용해 주세요</p>
                                </div><br>
                                <fieldset>
                                    <legend class="sr-only">경진대회 정보 입력</legend>
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">경진 대회명 <span title="입력하신 경진대회 명은 Challenge 리스트에 노출됩니다. 
승인후에는 수정이 불가능하니 주의해주세요." data-toggle="popover" class="fa fa-question-circle"></span></div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <input type="text" name="subject" value="{res.subject}" class="form-control input-xlarge" required="required" onblur="copy_subject(this); return false;">
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">주최&middot;주관 기관 <span title="입력하신 주최/주관 기관은 Challenge 리스트에 노출됩니다. 
승인후에는 수정이 불가능하니 주의해주세요." data-toggle="popover" class="fa fa-question-circle"></span></div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <input type="text" name="organized" value="{res.organized}" class="form-control input-xlarge">
                                            <span class="help-block">창업유관 기관이 등록되어야 하며, 여러개 등록 가능합니다</span> </div>
                                    </div>
                                    <!-- /form-group -->

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">후원 기관 <span title="입력하신 후원 기관은 Challenge 리스트에 노출됩니다. 
승인후에는 수정이 불가능하니 주의해주세요." data-toggle="popover" class="fa fa-question-circle"></span></div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <input type="text" name="backing" value="{res.backing}" class="form-control input-xlarge"> 
                                        </div>
                                    </div>
                                    <!-- /form-group -->

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >프로그램 내용 <span title="신청 내용을 바탕으로 승인이 이루어집니다.
개설하고자 하는 프로그램의 목적 및 프로그램 내용 관련 내용등을 상세히 작성해 주세요." data-toggle="popover" class="fa fa-question-circle"></span></div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <textarea  rows="10" class="form-control" name="semi_cont" id="inputDesc">{res.semi_cont}</textarea>
                                        </div>
                                    </div>
                                    <!-- /form-group -->

                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">접수 기간 <span title="개설하고자 하는 프로그램의 지원서 접수 기간을 입력해 주세요.
승인 후에는 수정이 불가능하니 주의해 주세요." data-toggle="popover" class="fa fa-question-circle"></span></div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            
                                            <!-- datepicker -->
                                            <div class="bfh-datepicker" data-format="y.m.d">
                                                <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                    <input type="text" class="form-control datepicker" name="date_s" value="{res.date_s}" readonly>
                                                </div>
                                            </div>
                                            <!-- /datepicker --> 

                                            <!-- timepicker -->
                                            <div class="bfh-timepicker" data-time="{? res.time_s}{res.time_s}{:}10:00{/}" >
                                                <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
                                                    <input type="text" class="form-control timepicker" name="time_s" value="{res.time_s}" placeholder="시작시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                </div>
                                            </div>
                                            <!-- /timepicker --> 
                                            <span class="sim">&sim;</span> 

                                            <!-- datepicker -->
                                            <div class="bfh-datepicker" data-format="y.m.d">
                                                <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                    <input type="text" class="form-control datepicker" name="date_e" value="{res.date_e}" readonly>
                                                </div>
                                            </div>
                                            <!-- /datepicker --> 

                                            <!-- timepicker -->
                                            <div class="bfh-timepicker" data-time="{? res.time_e}{res.time_e}{:}19:00{/}" >
                                                <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
                                                    <input type="text" class="form-control timepicker" name="time_e" value="{res.time_e}" placeholder="종료시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                </div>
                                            </div>
                                            <!-- /timepicker --> 
                                            
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">상태 처리</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <select data-width="auto" class="selectpicker" name="status">
                                                <option value="0" {? !res.status}selected="selected"{/}>승인대기</option>
                                                <option value="1" {? res.status == 1}selected="selected"{/}>승인</option>
                                                <option value="2" {? res.status == 2}selected="selected"{/}>반려</option>
                                            </select>
                                        </div>
                                    </div>
                                    <!-- /form-group -->

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">반려 사유</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <input type="text" name="status_des" value="{res.status_des}" class="form-control input-xlarge">
                                            <span class="help-block">반려 일 경우, 반려 사유를 입력해주세요.</span> </div>
                                    </div>
                                    <!-- /form-group -->

                                    <input type="hidden" name="user_id" value="{?res.user_id}{res.user_id}{:}{s.id}{/}" />
                                    <input type="hidden" name="id" value="{res.id}" />
                                    <input type="hidden" name="status_o" value="{res.status}" />
                                    <input type="hidden" name="announce_d_temp" value="{ res.announce_d }" />
                                </fieldset>
                            </div>
                            <!--/panel-body -->
                            
                            <div class="panel-footer">
                                <div class="col-lg-offset-2">
                                    <a href="#" onclick="go_cancel(this); return false;" class="btn btn-default">취소</a> 
                                    <a href="#" onclick="go_submit(this); return false;" class="btn btn-primary">확인</a> 
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

    if($('input[name=announce_d_temp]').val().length > 0 ){
        var announce_date = new Date($('input[name=announce_d_temp]').val());
        var end_date = new Date($('input[name=date_e]').val());
        if(announce_date.getTime() < end_date.getTime()){
            alert("'대회 정보 입력' 탭에서 발표일자를 접수 기간 이후로 설정해주세요. 현재 발표일자가 " + $('input[name=announce_d_temp]').val() + "로 설정되어 있습니다.");
        }
    }

    $(_this).hide();
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



//]]>
</script>