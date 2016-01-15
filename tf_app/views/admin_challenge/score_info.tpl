
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
        $(_this).show();
        alert("총 배점을 설정해주세요.");
        $('input[name=score]').focus();
        return false;
    }
    
    if (!$('input[name=s_name]').val()) {
        $(_this).show();
        alert("항목 제목을 입력해주세요.");
        $('input[name=s_name]').focus();
        return false;
    }

    if (!$('input[name=s_score]').val()) {
        $(_this).show();
        alert("항목 점수를 입력해주세요.");
        $('input[name=s_score]').focus();
        return false;
    }
    
    if (parseInt($('input[name=score]').val()) < parseInt($('input[name=s_score]').val())) {
        $(_this).show();
        alert("항목 점수가 총 배점보다 높습니다.");
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
    del_score_field2(_id);
}

function del_score_field2(_id) {
    var get_url = '/ajax_front/delete_score_rete/'+_id;
    $.get(get_url, function(){
        $('#sc_f_'+_id).remove();
        $('.modal').modal('hide');
    });
}

function score_f() {
    if (!$('input[name=score]').val()) {
        $(_this).show();
        alert("총 배점을 설정해주세요.");
        $('input[name=score]').focus();
        return false;
    }
    document.scroe_form.submit();
}

{? msgt}
_m = "평가지 작성을 완료했습니다.<br>운영진 초대 페이지로 이동할까요?";
$('#md-warning-ch .btn-danger').html('이동하기');
$('#md-warning-ch .btn-danger').attr('onclick', 'javascript:location.href="/admin_challenge/operator/{res.id}?tab=dashboard"');
$('#md-warning-ch p').html(_m);
$('#md-warning-ch').modal('show');
{/}
//]]>
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
                                <li><a href="/admin_challenge/edit_next/{res.id}">{? res.announce_d}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}대회 정보 입력</a></li>
                                <li><a href="/admin_challenge/apply_info/{res.id}">{? for}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}지원서 만들기</a></li>
                                <li class="active"><a href="/admin_challenge/score_info/{res.id}">{? sco}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}평가지 만들기</a></li>
                                <li><a href="/admin_challenge/operator/{res.id}">{? op}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}운영진 초대</a></li>
                                <li><a href="/admin_challenge/examiner/{res.id}">{? exn}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}심사위원 초대</a></li>
                                <li><a href="/admin_challenge/winner/{res.id}">{? res.winner}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}수상자 선정</a></li>
                                {/}
                            </ul>
                        </div>
                        <form class="form-horizontal" role="form" action="/admin_challenge/score_info/{res.id}" method="post" onsubmit="return false;" name="scroe_form">
                            <div class="panel-body" id="setting-score">
                                <fieldset>
                                    <input type="hidden" name="id" value="{res.id}" />
                                    <legend class="sr-only">평가 항목 설정</legend>
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">총 배점 설정 <span class="fa fa-question-circle" data-toggle="popover" title="심사위원 평가지의 총점"></span>
                                        </div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <input type="text" class="form-control" name="score" value="{res.score}" placeholder="" required="required">
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">배점 항목 <span class="fa fa-question-circle" data-toggle="popover" title="평가 항목 및 배점을 설정합니다.
각 항목 점수의 합은 총 배점을 초과할 수 없습니다."></span>
                                        </div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
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
                                                           <div class="col-xs-12 col-sm-4 col-md-4"><input type="text" value="{.score}" class="form-control" placeholder="점수" disabled="disabled"> / {res.score}</div> 
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
                                </fieldset>
                            </div>
                            <!--/panel-body -->
                            
                            <div class="panel-footer">
                                <div class="col-lg-offset-2">
                                    <a href="#"  class="btn btn-default">취소</a> 
                                    <button type="submit" class="btn btn-primary" onclick="score_f(); return false;">확인</button>
                                </div>
                            </div>

                        </form>
                    </div>
                    <!-- /panel --> 
                    
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 
            