    <!-- rowContent -->
    <div class="rowContent"  id="competition"> 
        
        <div class="page-header">
            <div class="container">
                <h2><a href="/challenge">Challenge</a></h2>
                {? (s.per & settings->permission1) == settings->permission1}
                {? s.ids}
                <button  class="btn btn-primary pull-right" onclick=location.href='/challenge/edit'><span class="icon-pencil"></span> 경진대회 만들기</button>
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
                        <h3>Challenge 개설 신청</h3>
                        {? res}
                        <div class="well applied-item">
                            <div class="media">
                                {? res.img}<a href="/challenge/views/{res.id}" class="pull-left media-object"><img class="img-responsive" src="{res.img}" ></a>{/}
                                <div class="media-body">
                                    <h4 class="media-heading"><a href="/challenge/views/{res.id}">{res.subject}</a></h4>
                                    <div class="item-status">
                                        <dl class="dl-horizontal ">
                                            <dt>주최/주관</dt>
                                            <dd><a href="/member/{res.ids}">{res.name}</a>{? res.organized}/{res.organized}{/} </dd>
                                            <dt>참가기간</dt>
                                            <dd>{=date_to_kr(res.date_s)} ~ {=date_to_kr(res.date_e)} 
                                                {? date('Y.m.dH:i') < res.sdate}<span class="label label-info">접수 준비</span>{/}
                                                {? date('Y.m.dH:i') > res.sdate && date('Y.m.dH:i') < res.edate}<span class="label label-primary">접수중</span>{/} 
                                                {? date('Y.m.dH:i') > res.edate}<span class="label label-warning">접수마감</span>{/} 
                                                {? date('Y.m.dH:i') > res.announce && res.winner}<span class="label label-default">수상자 발표</span>{/}
                                            </dd>
                                            <dt>발표일자</dt>
                                            <dd>{=date_to_kr(res.announce_d)}</dd>
                                        </dl>
                                    </div>
                                </div>
                                {? res}
                                <div class="list-controller pull-right">
                                    <a href="/challenge/applied_list/{res.id}?tab=dashboard" class="btn btn-primary btn-sm">운영 페이지로 이동</a>
                                </div>
                                {/}
                            </div>
                            <!-- /media -->
                        </div>
                        {/}
                    
                        <!--ol data-progtrckr-steps="7" class="stepProgress">
                            <li class="{? step > 0}step-done{:}step-todo{/}">정보입력</li>
                            <li class="{? step > 1}step-done{:}step-todo{/}">승인받기</li>
                            <li class="{? step > 2}step-done{:}step-todo{/}">세부정보 설정</li>
                            <li class="{? step > 3}step-done{:}step-todo{/}">접수중</li>
                            <li class="{? step > 4}step-done{:}step-todo{/}">접수마감</li>
                            <li class="{? step > 5}step-done{:}step-todo{/}">수상자 발표</li>
                        </ol-->
                        
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="/challenge/edit/{res.id}">{? res}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}신청 정보 입력</a></li>
                            {? res.status == 1}
                            <li><a href="/challenge/edit_next/{res.id}">{? res.announce_d}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}대회 정보 입력</a></li>
                            <li><a href="/challenge/apply_info/{res.id}">{? for}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}지원서 만들기</a></li>
                            <li><a href="/challenge/score_info/{res.id}">{? sco}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}평가지 만들기</a></li>
                            {/}
                        </ul>
                     </div>
                    <div class="edit-body">   
                        <!-- tab-content -->
                        <div class="tab-content">
                            <div class="tab-pane active" id="formInfo">
                                <div class="examiner-notice alert alert-info">
                                    <h4><i class="fa fa-microphone"></i> Challenge를 통해 지원서 접수 및 심사가 필요한 창업자 대상 프로그램( 경진대회등) 을 손쉽게 관리할 수 있습니다.</h4>
                                    <p>이용 프로세스는 다음과 같습니다.<br>
1. 아래 신청서를 입력하여 제출해 주세요.<br>
2. 프로그램 취지 및 목적을 검토하여 최대 48시간 이내에 승인이 이루어집니다.<br>
3. 진행하고자 하시는 프로그램의 상세 내용은 승인 후 입력이 가능합니다. (승인 결과 메일 안내)<br>
※ 승인 후 신청 내용 및 지원서 접수 일정의 수정이 필요한 경우에는 Q&A 게시판 - Challenge 관련 메뉴를 이용해 주세요</p>
                                </div>
                                <form class="form-horizontal" name="edit_com_f" action="/challenge/edit/{res.id}" role="form" method="post" onsubmit="return false;" enctype="multipart/form-data" >
                                    <fieldset>
                                        
                                        <legend class="sr-only">경진대회 정보 입력</legend>
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">경진 대회명 <span title="입력하신 경진대회 명은 Challenge 리스트에 노출됩니다. 
승인후에는 수정이 불가능하니 주의해주세요." data-toggle="popover" class="fa fa-question-circle"></span></div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <input type="text" name="subject" value="{res.subject}" class="form-control input-xlarge">
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">주최&middot;주관 기관 <span title="입력하신 주최/주관 기관은 Challenge 리스트에 노출됩니다. 
승인후에는 수정이 불가능하니 주의해주세요." data-toggle="popover" class="fa fa-question-circle"></span></div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <input type="text" name="organized" value="{res.organized}" class="form-control input-xlarge">
                                                <span class="help-block">창업유관 기관이 등록되어야 하며, 여러개 등록 가능합니다</span> 
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">후원 기관 <span title="입력하신 후원 기관은 Challenge 리스트에 노출됩니다. 
승인후에는 수정이 불가능하니 주의해주세요." data-toggle="popover" class="fa fa-question-circle"></span></div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <input type="text" name="backing" value="{res.backing}" class="form-control input-xlarge"> 
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >프로그램 내용 <span title="신청 내용을 바탕으로 승인이 이루어집니다.
개설하고자 하는 프로그램의 목적 및 프로그램 내용 관련 내용등을 상세히 작성해 주세요." data-toggle="popover" class="fa fa-question-circle"></span></div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <textarea  rows="10" class="form-control" name="semi_cont" id="inputDesc">{res.semi_cont}</textarea>
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">접수 기간 <span title="개설하고자 하는 프로그램의 지원서 접수 기간을 입력해 주세요.
승인 후에는 수정이 불가능하니 주의해 주세요." data-toggle="popover" class="fa fa-question-circle"></span></div>
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

                                        <div class="form-group form-submit">
                                            <div class="col-xs-12 col-sm-offset-3 col-sm-9 col-md-offset-3 col-md-9">
                                                {? !res || res.status == 0 }
                                                <a href="#" onclick="go_cancel(this); return false;" class="btn btn-default">취소</a> 
                                                <a href="#" onclick="go_submit(this); return false;" class="btn btn-primary">승인 신청</a> 
                                                {/}
                                                승인 후에는 수정할 수 없습니다.
                                            </div>
                                        </div>

                                        <input type="hidden" name="user_id" value="{s.id}" />
                                        <input type="hidden" name="id" value="{res.id}" />
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

    function go_cancel(_id)
    {
        location.href='/challenge/edit?cancel='+_id;
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
        
        var now = new Date(); 
        var todayAtMidn = new Date(now.getFullYear(), now.getMonth(), now.getDate(), now.getHours(), now.getMinutes());
        
        var _e_s_date = new Date($('input[name=date_s]').val().substr(0,4),($('input[name=date_s]').val().substr(5,2)-1),$('input[name=date_s]').val().substr(8,2), $('input[name=time_s]').val().substr(0,2), $('input[name=time_s]').val().substr(3,2));
        var _e_e_date = new Date($('input[name=date_e]').val().substr(0,4),($('input[name=date_e]').val().substr(5,2)-1),$('input[name=date_e]').val().substr(8,2), $('input[name=time_e]').val().substr(0,2), $('input[name=time_e]').val().substr(3,2));

        if (_e_s_date.getTime() >= _e_e_date.getTime())
        {
            alert("접수 기간 종료시간이 시작시간보다 빠릅니다.");
            document.edit_com_f.date.focus();
            return false;
        }
        
        if (todayAtMidn.getTime() > _e_s_date.getTime())
        {
            alert("접수 기간 시작시간이 현재시간보다 빠릅니다.");
            document.edit_com_f.date_e.focus();
            return false;
        }
        
        $(_this).hide();
        document.edit_com_f.submit();
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

//]]>
</script>