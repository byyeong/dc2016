<script src="/js/jquery.ui.touch-punch.min.js"></script>
<script type="text/javascript">
//<![CDATA[

$(function() {
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
 
{? sizeof(res.forms) < 1}
get_form_field(0, '{res.id}');
{/}
function get_form_field(_id, _pid) {
    // $('#sortable .entry-itemOption').remove();

    var get_url = '/ajax_v3/add_comp_form/'+_pid;
    $.get(get_url, function(_data){
        // if (_id !== 0) {
        //     $('#sc_f_'+_id).before(_data);
        // } else {
            $('#sortable').append(_data);
        // }
        $('.selectpicker').selectpicker();
        $('.entry-itemOption').slideDown();
    });
}

function get_form_field_e(_this, _id) {
    $(_this).parent().parent().slideUp();

    var get_url = '/ajax_v3/add_comp_form/';
    var set_data ={
        "id"        : _id,
        "competition_id"        : '{res.id}',
        "title"     : $(_this).parent().parent().find('.t-title').html(),
        "sub"                       : $(_this).parent().parent().find('.help-block').html(),
        "type"          : $(_this).parent().parent().find('.type').val(),
        "required"      : $(_this).parent().parent().find('.text-danger').html(),
        "opt"       : $(_this).parent().parent().find('.opt').val(),
    };
    
    $.post(get_url, set_data, function(_data){
        $(_this).parent().parent().before(_data);
        $('.selectpicker').selectpicker();
        $('.entry-itemOption').slideDown();
        $(_this).parent().parent().remove();
    });
}

{? !res.form_file}
get_form_file(0);
{/}
function get_form_file(_id) {
    var get_url = '/ajax_v3/add_comp_form_file/'+{res.id};
    $.get(get_url, function(_data){
        if (_id !== 0) {
            $('#sc_f_'+_id).before(_data);
        } else {
            $('#btn_file').before(_data);
        }
    });
}

function get_form_file_e(_this, _id) {
    $(_this).parent().parent().slideUp();

    var get_url = '/ajax_v3/add_comp_form_file/';
    var set_data ={
        "competition_id"        : '{res.id}',
        "title"     : $(_this).parent().parent().find('.t-title').html(),
        "sub"           : $(_this).parent().parent().find('.help-block').html(),
        "type"          : $(_this).parent().parent().find('.type').val(),
        "req"      : $(_this).parent().parent().find('.text-danger').html(),
        "id"          : _id,
    };
    
    $.post(get_url, set_data, function(_data){
        $(_this).parent().parent().before(_data);
        $('.selectpicker').selectpicker();
        $('.entry-itemOption').slideDown();
        $(_this).parent().parent().remove();
    });
}

function make_form(_this) {
    var f = $(_this).parent().parent().parent().parent();
    f.find('.m_form').slideUp();
    var _val = f.find('.selectpicker option:selected').val();
    f.find('#f_'+_val).slideDown();
}

function delete_form_sort(_this, _id) {
    var r = confirm("삭제할까요?");
    if (r == true) {
        var get_url = '/ajax_v3/del_comp_form/'+_id;
        $.get(get_url, function(_data){
            $(_this).parent().parent().remove();
        });
    }
}

function delete_form_file(_this, _id) {
    var r = confirm("삭제할까요?");
    if (r == true) {
        var get_url = '/ajax_v3/del_comp_form_file/'+_id;
        $.get(get_url, function(_data){
            $(_this).parent().parent().remove();
        });
    }
}

function add_comp_form(_this, _type) {
    var frm = $(_this).parent().parent().parent().parent();
    var get_url = '/ajax_v3/edit_comp_form/';
    var set_data = frm.serialize();

    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {
            if (_type === 1) {
                $(_this).parent().parent().parent().parent().parent().after(_data);
            }
            else {
                $(_this).parent().parent().parent().parent().parent().after(_data);
            }
            $(_this).parent().parent().parent().parent().parent().remove();
        }
    });
}

function add_comp_form_file(_this, _type) {

    var frm = $('form[name=m_form_file_add]');
    var get_url = '/ajax_v3/edit_comp_form';
    var set_data = frm.serialize();

    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {
            if (_type === 1) {
                $(_this).parent().parent().parent().parent().parent().after(_data);
            }
            else {
                $(_this).parent().parent().parent().parent().parent().after(_data);
            }
            $(_this).parent().parent().parent().parent().parent().remove();
        }
    });
}

function submit_info(_this) {
    $(_this).hide();
    $('.comp_form_e').remove();
    $('.comp_form_f').remove();
    
    var frm = $('form[name=info_form]');
    var get_url = '/ajax_v3/save_comp_form'; 
    var set_data = frm.serialize();

    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {
            window.location.reload(true);
        }
    });
}

function add_query(_this) {
    var _or = $('input[name=query_cnt]').val();
    _or = parseInt(_or) + 1;
    var _tpl = '<li><button type="button" class="close" aria-hidden="true" onclick="javascript:$(this).parent().remove();">&times;</button>'
            +'<div class="input-group">'
                +'<span class="input-group-addon">'
                    +'<input type="radio" name="options" disabled >'
                  +'</span>' 
                    +'<input tyle="text" name="option_con_'+_or+'" class="form-control" placeholder="옵션">' 
            +'</div>'
        +'</li>';
    $('input[name=query_cnt]').val(_or)
    $(_this).prev().append(_tpl);
}

function get_my_oc() {
    $.ajax({
        type : 'GET',
        url : '/ajax_v3/get_my_oc',
        dataType : 'html',
        success : function(_data) {
            $('#md-takeCompetition').html(_data);
            $('#md-takeCompetition').modal('show');
        }
    });
}

function pick_oc() {
    var _val = $(':radio[name="pick"]:checked').val();
    window.location.href = "/challenge/apply_info/{res.id}?template="+_val;
}

function check_ser(_this) {
    var _ch = $(_this).is(':checked');
    if (_ch === true) {
        $('input[name=basic7]').prop('checked', true);
        $('input[name=basic8]').prop('checked', true);
    } else {
        $('input[name=basic7]').prop('checked', false);
        $('input[name=basic8]').prop('checked', false);
    }
}

{? msgt}
_m = "지원서 페이지 작성을 완료했습니다.<br><br>저장 후 심사위원 평가지 작성을 시작합니다.";
$('#md-warning-ch .btn-danger').html('다음으로');
$('#md-warning-ch .btn-danger').attr('onclick', 'javascript:location.href="/challenge/score_info/{res.id}"');
$('#md-warning-ch p').html(_m);
$('#md-warning-ch').modal('show');
{/}
//]]>
</script>
    
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
                        <h3><a href="/member/edit_challenge_m">Challenge 관리</a> > Challenge 지원서</h3>
                    
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
                            <li><a href="/challenge/edit/{res.id}">{? res}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}신청 정보 입력</a></li>
                            {? res.status == 1}
                            <li><a href="/challenge/edit_next/{res.id}">{? res.announce_d}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}대회 정보 입력</a></li>
                            <li class="active"><a href="/challenge/apply_info/{res.id}">{? for}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}지원서 만들기</a></li>
                            <li><a href="/challenge/score_info/{res.id}">{? sco}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}평가지 만들기</a></li>
                            {/}
                        </ul>
                     </div>
                    <div class="edit-body">   
                        <!-- tab-content -->
                        <div class="tab-content"> 
                            <div class="tab-pane active" id="formApply">
                                <form class="form-horizontal" role="form" name="info_form" method="post" onsubmit="return false;">
                                    <fieldset>
                                        <legend class="sr-only">참가 신청 정보 설정</legend>
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">템플릿 불러오기 <span class="fa fa-question-circle" data-toggle="popover" title="다른 경진대회를 진행한 내역이 있을 경우 이용 가능합니다.
기존에 개최한 경진대회의 참가 신청서를 불러옵니다."></span>
                                            </div>
                                            <div class="col-xs-12 col-sm-9 col-md-9"> 
                                                {? !res || res.status == 0 || res.sdate > date("Y.m.dH:i")}
                                                <button class="btn btn-info" onclick="get_my_oc(); return false;">템플릿 불러오기</button>
                                                <span class="help-block">기존에 진행한 경진대회의 참가 신청 항목을 불러와서 사용할 수 있습니다.</span>
                                                {:}
                                                <button class="btn btn-info" disabled="disabled">템플릿 불러오기</button>
                                                <span class="help-block">경진대회의 접수기간 이전에만 적용 할 수 있습니다.</span>
                                                {/}
                                            </div>
                                        </div>
                                        <!-- /form-group --> 

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">기본 질문 선택 <span class="fa fa-question-circle" data-toggle="popover" title="지원자가 대회 지원 시 프로필 정보를 자동으로 불러옵니다.
지원자가 수정할 수 있습니다."></span>
                                            </div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                
                                                <div class="checkbox">
                                                  <label>
                                                    <input type="checkbox" name="basic1" id="basic1" value="1" {? (res.basic & 1) == 1}checked="checked"{/}>참가자 이름
                                                  </label>
                                                </div>
                                                <div class="checkbox">
                                                  <label>
                                                    <input type="checkbox" name="basic2" value="2" {? (res.basic & 2) == 2}checked="checked"{/}>휴대폰 번호
                                                  </label>
                                                </div>
                                                <div class="checkbox">
                                                  <label>
                                                    <input type="checkbox" name="basic3" value="4" {? (res.basic & 4) == 4}checked="checked"{/}>이메일 주소
                                                  </label>
                                                </div>
                                                <div class="checkbox">
                                                  <label>
                                                    <input type="checkbox" name="basic4" value="8" {? (res.basic & 8) == 8}checked="checked"{/}>간단한 자기소개 
                                                  </label>
                                                </div>
                                                <div class="checkbox">
                                                  <label>
                                                    <input type="checkbox" name="basic5" value="16" {? (res.basic & 16) == 16}checked="checked"{/}>팀소개
                                                  </label>
                                                </div>
                                                <div class="checkbox">
                                                  <label>
                                                    <input type="checkbox" name="basic6" value="32" {? (res.basic & 32) == 32}checked="checked"{/}>참가회사/팀명 
                                                  </label>
                                                </div>
                                                <div class="checkbox">
                                                  <label>
                                                    <input type="checkbox" name="basic7" value="64" {? (res.basic & 64) == 64}checked="checked"{/}>제품/서비스명
                                                  </label>
                                                </div>
                                                <div class="checkbox">
                                                  <label>
                                                    <input type="checkbox" name="basic8" value="128" {? (res.basic & 128) == 128}checked="checked"{/} onchange="check_ser(this);">제품/서비스 한 줄 소개 (준비하고 있는 제품/서비스를 한 문장<small>(50자 이내)</small>으로 소개해주세요.)
                                                  </label>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /form-group --> 

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">참가 양식 만들기 <span class="fa fa-question-circle" data-toggle="popover" title="기본 질문 이 외에 지원서에 포함될 추가 질문을 생성합니다."></span>
                                            </div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">  
                                            
                                                <ol id="sortable">
                                                    {@ res.forms}
                                                    {? .type == "text"}
                                                    <li class="ui-state-default entry-item form-group"> 
                                                        <input type="hidden" value="text" class="type" />
                                                        <div class="set-wrap pull-right">                                                            
                                                            <button class="btn btn-default btn-xs edit" type="button" onclick="get_form_field_e(this, '{.id}'); return false;"><span class="icon-edit"></span></button> 
                                                            <button class="btn btn-default btn-xs delete" type="button" onclick="delete_form_sort(this, '{.id}'); return false;"><span class="icon-trash"></span></button> 
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label"><span class="t-title">{=add_brs(.title)}</span> {?.required}<span class="text-danger">*</span>{/}</label>
                                                            {?.sub}<p class="help-block">{=add_brs(.sub)}</p>{/}
                                                            <input type="text" class="form-control" disabled>
                                                        </div>
                                                    </li>
                                                    {/}

                                                    {? .type == "textarea"}
                                                    <li class="ui-state-default entry-item form-group"> 
                                                        <input type="hidden" value="textarea" class="type" />
                                                        <div class="set-wrap pull-right">                                                            
                                                            <button class="btn btn-default btn-xs edit" type="button" onclick="get_form_field_e(this, '{.id}'); return false;"><span class="icon-edit"></span></button> 
                                                            <button class="btn btn-default btn-xs delete" type="button" onclick="delete_form_sort(this, '{.id}'); return false;"><span class="icon-trash"></span></button> 
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label"><span class="t-title">{=add_brs(.title)}</span> {?.required}<span class="text-danger">*</span>{/}</label>
                                                            {?.sub}<p class="help-block">{=add_brs(.sub)}</p>{/}
                                                            <textarea rows="5" class="form-control" disabled></textarea>
                                                        </div>
                                                    </li>
                                                    {/}

                                                    {? .type == "query"}
                                                    <li class="ui-state-default entry-item form-group"> 
                                                        <input type="hidden" value="query" class="type" />
                                                        <input type="hidden" value="{@ .opts}{.value_},{/}" class="opt" />
                                                        <div class="set-wrap pull-right">                                                            
                                                            <button class="btn btn-default btn-xs edit" type="button" onclick="get_form_field_e(this, '{.id}'); return false;"><span class="icon-edit"></span></button> 
                                                            <button class="btn btn-default btn-xs delete" type="button" onclick="delete_form_sort(this, '{.id}'); return false;"><span class="icon-trash"></span></button> 
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label"><span class="t-title">{=add_brs(.title)}</span> {?.required}<span class="text-danger">*</span>{/}</label>
                                                            {?.sub}<p class="help-block">{=add_brs(.sub)}</p>{/}
                                                            <ul class="list-unstyled">
                                                                {@ .opts}
                                                                <li class="radio">
                                                                    <label>
                                                                        <input type="radio" name="opt{=date('is')}" disabled>{..value_}
                                                                    </label>
                                                                </li>
                                                                {/}
                                                            </ul>                                       
                                                        </div>
                                                    </li>
                                                    {/}
                                                    {/}
                                                </ol>
                                                <!-- /sortable -->
                                                
                                                <button class="btn btn-info btn-sm" id="btn_form" onclick="get_form_field(0, '{res.id}'); return false;"><span class="icon-plus"></span>&nbsp;항목추가</button>
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">파일첨부 사용 여부 <span class="fa fa-question-circle" data-toggle="popover" title="지원자가 업로드해야 하는 파일이 있을 경우 생성합니다.
하나의 항목 당 하나의 파일이 업로드 가능합니다. (항목 당 8Mb 한도)"></span>
                                            </div>
                                            <div class="col-xs-12 col-sm-9 col-md-9 file_space">
                                                
                                                
                                                 {? res.form_file}
                                                 {@ res.form_file}
                                                 <div class="ui-state-default entry-item m_file"> 
                                                     <input type="hidden" class="type" value="file" /> 
                                                    <div class="set-wrap pull-right">                                                            
                                                        <button class="btn btn-default btn-xs edit" type="button" onclick="get_form_file_e(this, '{.id}'); return false;"><span class="icon-edit"></span></button> 
                                                        <button onclick="delete_form_file(this, '{.id}'); return false;" type="button" class="btn btn-default btn-xs delete"><span class="icon-trash"></span></button>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label"><span class="t-title">{.title}</span> {?.req}<span class="text-danger">*</span>{/}</label> 
                                                        <p class="help-block">{.sub}</p>
                                                        <input type="file" disabled="disabled"> 
                                                   </div>   
                                                </div>
                                                {/}
                                                {/}   

                                                <button class="btn btn-info btn-sm" id="btn_file" onclick="get_form_file(0); return false;"><span class="icon-plus"></span>&nbsp;첨부파일 항목추가</button>
                                                
                                            </div>
                                        </div>
                                        
                                        <div class="form-actions">
                                            {? !res || res.status == 0 || res.sdate > date("Y.m.dH:i")}
                                            <div class="col-sm-offset-3 col-md-offset-3"> 
                                                <a href="#" class="btn btn-default">취소</a> 
                                                <a href="#" onclick="submit_info(this); return false;" class="btn btn-primary">확인</a>
                                                {? res.forms || res.form_file || res.basic}
                                                <a href="/challenge/apply/{res.id}?preview=1" targer="_blank" class="btn btn-primary pull-right">미리보기</a> 
                                                {:}
                                                <a href="/challenge/apply/{res.id}" targer="_blank" class="btn btn-primary pull-right" disabled="disabled">저장 후 미리보기 가능</a> 
                                                {/} 
                                            </div>
                                            {:}
                                            <p class="text-danger text-center">
                                                경진대회의 접수기간 이전에만 수정 할 수 있습니다.
                                                {? res.forms || res.form_file || res.basic}
                                                <a href="/challenge/apply/{res.id}?preview=1" targer="_blank" class="btn btn-primary pull-right">미리보기</a> 
                                                {:}
                                                <a href="/challenge/apply/{res.id}" targer="_blank" class="btn btn-primary pull-right" disabled="disabled">저장 후 미리보기 가능</a> 
                                                {/}
                                            </p>
                                            {/}
                                        </div>
                                        <input type="hidden" name="id" value="{res.id}" /> 
                                    </fieldset>
                                </form>
                            </div> 
                        </div>
                        <!-- /tab-content -->
                    </div>
                </div>
                <!-- /edit --> 
            </div>
            <!-- /container --> 
        </div>
        <!-- /page-content --> 
    </div>
    <!-- /rowContent --> 

<!-- modal #md-searchMember -->
<div class="modal fade" id="md-takeCompetition" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div>
<!-- /modal #md-searchMember -->