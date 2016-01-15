
<script src="/js/jquery.ui.touch-punch.min.js"></script>
<script type="text/javascript">
//<![CDATA[
/*
$(function() {
  $( ".sortable" ).sortable({
    placeholder: "ui-state-highlight"
  }); 
  $( ".sortable" ).disableSelection();
});
*/       
function add_score_field(_this) {
    
    if (!$('input[name=score]').val()) {
        alert("총 배점을 설정해주세요.");
        $('input[name=score]').focus();
        return false;
    }
    
    if (!$('input[name=s_name]').val()) {
        alert("항목 제목을 입력해주세요.");
        $('input[name=s_name]').focus();
        return false;
    }

    if (!$('input[name=s_score]').val() || $('input[name=s_score]').val() === '0') {
        alert("항목 점수를 입력해주세요.");
        $('input[name=s_score]').focus();
        return false;
    }
    
    if (parseInt($('input[name=score]').val()) < parseInt($('input[name=s_score]').val())) {
        alert("항목 점수가 총 배점보다 높습니다.");
        $('input[name=s_score]').focus();
        return false;
    }

    var l_sc = 0
    $(".sc_l_one").each(function() {
        l_sc = l_sc + parseInt($(this).val());
    });
 
    if (parseInt($('input[name=score]').val()) < parseInt($('input[name=s_score]').val()) + l_sc) {
        alert("배점 항목의 총 합이 총 배점보다 높습니다.");
        $('input[name=s_score]').focus();
        return false;
    }
    $(_this).hide();
    var get_url = '/ajax_front/edit_score';
    var set_data ={
        "competition_id" 	: '{res.id}',
        "total"                  : $('input[name=score]').val(),
        "id"                  : $('input[name=s_id]').val(),
        "name"                  : $('input[name=s_name]').val(),
        "score" 		: $('input[name=s_score]').val(),
    };

    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {
            var _ii = $('input[name=s_id]').val();
            if (_ii) {
                $('#sc_f_'+_ii).remove();
                $(_this).parent().parent().parent().parent().before(_data);
            } else {
                $('.sortable').append(_data);
            }
            $('#add_scr_btn').show();
            $(_this).parent().parent().parent().parent().remove();
        }
    });
}

{? !score}
get_score_field(0);
{/}
function get_score_field(_id) {
{*    var _field = $('.entry-itemOption').length;

    if (_field ===  0) {
        $('.entry-itemOption').remove();
        var get_url = '/ajax_front/add_score_rate/'+_id;
        $.get(get_url, function(_data){
            if (_id !== 0) {
                $('#sc_f_'+_id).before(_data);
            } else {
                $('.sortable').append(_data);
            }
            
            $('.entry-itemOption').slideDown();
        });
    }
    else {
        
    }*}
    $('.entry-itemOption').remove();
    $('#sc_f_'+_id+' input').removeClass('sc_l_one');
    var get_url = '/ajax_front/add_score_rate/'+_id;
    $.get(get_url, function(_data){
        if (_id !== 0) {
            $('#sc_f_'+_id).before(_data);
        } else {
            $('.sortable').append(_data);
        }

        $('.entry-itemOption').slideDown();
    });

}

function del_score_field(_id) {
    del_confirm('del_score_field2('+_id+')');
}

function del_score_field2(_id) {
    var get_url = '/ajax_front/delete_score_rete/'+_id;
    $.get(get_url, function(){
        $('#sc_f_'+_id).remove();
        $('.modal').modal('hide');
    });
}

function del_score_field_r(_id) {
    if (_id ==='') {
        $('.entry-itemOption').slideUp();
        $('.entry-itemOption').remove();
    } else {
        $('#sc_f_'+_id+' input').addClass('sc_l_one');
    }
}

function submit_score_l(_this) 
{
    if (!$('input[name=score]').val()) {
        alert("총 배점을 설정해주세요.");
        $('input[name=score]').focus();
        return false;
    }
    $(_this).hide();
    document.score_l_f.submit();
}

{? msgt}
_m = "평가지 작성을 완료했습니다.<br>운영 페이지로 이동할까요?";
$('#md-warning-ch .btn-danger').html('이동하기');
$('#md-warning-ch .btn-danger').attr('onclick', 'javascript:location.href="/challenge/applied_list/{res.id}?tab=dashboard"');
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
                        <h3><a href="/member/edit_challenge_m">Challenge 관리</a> > Challenge 평가지</h3>
                        
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
                            <li><a href="/challenge/apply_info/{res.id}">{? for}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}지원서 만들기</a></li>
                            <li class="active"><a href="/challenge/score_info/{res.id}">{? sco}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}평가지 만들기</a></li>
                            {/}
                        </ul>
                    </div>
                    
                    <div class="edit-body"  id="setting-score">
                        <form class="form-horizontal" role="form" action="/challenge/score_info/{res.id}" method="post" onsubmit="return false;" name="score_l_f">
                            <fieldset>
                                <input type="hidden" name="id" value="{res.id}" />
                                <legend class="sr-only">평가 항목 설정</legend>
                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-3 col-md-3 control-label">총 배점 설정 <span class="fa fa-question-circle" data-toggle="popover" title="심사위원 평가지의 총점"></span></div>
                                    <div class="col-xs-12 col-sm-3 col-md-2">
                                        <input type="text" class="form-control" name="score" value="{res.score}" placeholder="" required="required" onkeyup="onlyNumberCom(this);" style="ime-mode:disabled">
                                    </div>
                                </div>
                                <!-- /form-group -->

                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-3 col-md-3 control-label">배점 항목 <span class="fa fa-question-circle" data-toggle="popover" title="평가 항목 및 배점을 설정합니다.
각 항목 점수의 합은 총 배점을 초과할 수 없습니다."></span>
                                    </div>
                                    <div class="col-xs-12 col-sm-9 col-md-9">

                                        <div class="sortable">

                                             <!-- /ui-state-default  -->
                                             {? score}{@ score}
                                            <div class="ui-state-default entry-item" id="sc_f_{.id}"> 
                                                <div class="set-wrap pull-right">                                                            
                                                    <button type="button" class="btn btn-default btn-xs edit" onclick="get_score_field('{.id}'); return false;"><span class="icon-edit"></span></button> 
                                                    <button type="button" class="btn btn-default btn-xs delete" onclick="del_score_field('{.id}'); return false;"><span class="icon-trash"></span></button> 
                                                </div> 
                                                <div class="form-group">
                                                        <label class="col-xs-12 col-sm-2 col-md-2 control-label">{.name} </label>  
                                                        <div class="col-xs-12 col-sm-4 col-md-4"><input type="text" value="{.score}" class="form-control sc_l_one" placeholder="점수" disabled="disabled"> / {res.score}</div> 
                                                </div> 
                                            </div>
                                            <!-- /ui-state-default  -->                                                
                                            {/}{/}

                                        </div>
                                        <!-- /sortable -->
                                        
                                        <button id="add_scr_btn" class="btn btn-info btn-sm" onclick="get_score_field(0); return false;" {? !score}style="display: none"{/}><span class="icon-plus"></span>&nbsp;항목추가</button>
                                        
                                    </div>
                                </div>
                                <!-- /form-group -->

                                 <div class="form-group form-submit">
                                    <div class="col-xs-12 col-sm-offset-3 col-sm-9 col-md-offset-3 col-md-9"> 
                                        <a href="#"  class="btn btn-default">취소</a> 
                                        <button class="btn btn-primary" onclick="submit_score_l(this); return false;" >저장</button> 
                                    </div>
                                </div>
                            </fieldset>
                        </form>
                             
                    </div>
                </div>
                <!-- /editor --> 
            </div>
            <!-- /container --> 
        </div>
        <!-- /page-content --> 
    </div>
    <!-- /rowContent --> 