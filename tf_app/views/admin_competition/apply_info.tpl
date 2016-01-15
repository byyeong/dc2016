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
 
{? !res.form}
get_form_field(0);
{/}
function get_form_field(_id) {
    $('#sortable .entry-itemOption').remove();

    var get_url = '/ajax_front/add_comp_form/'+_id;
    $.get(get_url, function(_data){
        if (_id !== 0) {
            $('#sc_f_'+_id).before(_data);
        } else {
            $('#sortable').append(_data);
        }
        $('.selectpicker').selectpicker();
        $('.entry-itemOption').slideDown();
    });
}

function get_form_field_e(_this) {
    $('.entry-itemOption').slideUp();
    $('.entry-itemOption').remove();

    var get_url = '/ajax_front/add_comp_form/';
    var set_data ={
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
    });
}

{? !res.form_file}
get_form_file(0);
{/}
function get_form_file(_id) {

    // if (_id != 0) {
        
        var get_url = '/ajax_front/add_comp_form_file/'+{res.id};
        $.get(get_url, function(_data){
            if (_id !== 0) {
                $('#sc_f_'+_id).before(_data);
            } else {
                $('#btn_file').before(_data);
            }
        });
    // }
    // else {
    //     $('.m_file').remove();
    //     $('.comp_form_f').remove();
    //     $('input[name=form_file_req]').val('');
    //     $('input[name=form_file_title]').val('');
    //     $('input[name=form_file_sub]').val('');
    // }
}

function get_form_file_e(_this, _id) {
    $('.entry-itemOption').slideUp();
    $('.entry-itemOption').remove();

    var get_url = '/ajax_front/add_comp_form_file/'+{res.id};
    var set_data ={
        "title"     : $(_this).parent().parent().find('.t-title').html(),
        "sub"           : $(_this).parent().parent().find('.help-block').html(),
        "type"          : $(_this).parent().parent().find('.type').val(),
        "required"      : $(_this).parent().parent().find('.text-danger').html(),
        "id"          : _id,
    };
    
    $.post(get_url, set_data, function(_data){
        $(_this).parent().parent().before(_data);
        $('.selectpicker').selectpicker();
        $('.entry-itemOption').slideDown();
    });
}

function make_form() {
    $('.m_form').slideUp();
    var _val = $('.selectpicker option:selected').val();
    $('#f_'+_val).slideDown();
}

function delete_form_sort(_this) {
    $(_this).parent().parent().remove();
}

function delete_form_file(_this, _id) {
    var get_url = '/ajax_front/del_comp_form_file/'+_id;
        $.get(get_url, function(_data){
            $(_this).parent().parent().remove();
        });
}

function add_comp_form(_this, _type) {
    var frm = $('form[name=m_form_add]');
    var get_url = '/ajax_front/edit_comp_form';
    var set_data = frm.serialize();

    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {
            if (_type === 1) {
                $(_this).parent().parent().parent().parent().parent().next().remove();
                $(_this).parent().parent().parent().parent().parent().after(_data);
            }
            else {
                $(_this).parent().parent().parent().parent().parent().after(_data);
            }
            $(_this).parent().parent().parent().parent().parent().remove();
            $('#btn_form').show();
        }
    });
}

function add_comp_form_file(_this, _type) {

    var frm = $('form[name=m_form_file_add]');
    var get_url = '/ajax_front/edit_comp_form';
    var set_data = frm.serialize();

    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {
            if (_type === 1) {
                $(_this).parent().parent().parent().parent().parent().next().remove();
                $(_this).parent().parent().parent().parent().parent().after(_data);
            }
            else {
                // $(_this).parent().parent().parent().parent().parent().after(_data);
                $('#btn_file').before(_data);
            }
            $(_this).parent().parent().parent().parent().parent().remove();
            $('#btn_file').show();
        }
    });
}

function submit_info(_this) {
    $(_this).hide();
    $('.comp_form_e').remove();
    $('.comp_form_f').remove();
    
    var frm = $('form[name=info_form]');
    var get_url = '/ajax_front/save_comp_form';
    var _cont = $('#sortable').html();
    $('input[name=form]').val(_cont); 
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
//]]>
</script>
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-edit"></span><span class="break"></span>경진대회 작성하기</h2>
                            <div class="actions"> <span class="break"></span> <a title="목록보기" data-toggle="tooltip" href="/admin_competition"><span class="glyphicon  glyphicon-align-justify"></span></a> </div>
                        </div>
                        <!-- /panel-heading -->
                        
                        <div class="panel-heading">
                            <ol data-progtrckr-steps="7" class="stepProgress">
                                <li class="{? step > 0}step-done{:}step-todo{/}">정보입력</li>
                                <li class="{? step > 1}step-done{:}step-todo{/}">승인받기</li>
                                <li class="{? step > 2}step-done{:}step-todo{/}">세부정보 설정</li>
                                <li class="{? step > 3}step-done{:}step-todo{/}">접수준비</li>
                                <li class="{? step > 4}step-done{:}step-todo{/}">접수중</li>
                                <li class="{? step > 5}step-done{:}step-todo{/}">접수마감</li>
                                <li class="{? step > 6}step-done{:}step-todo{/}">수상자 발표</li>
                            </ol>

                            <ul class="nav nav-tabs">
                                <li><a href="/admin_competition/edit/{res.id}">{? res}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}경진대회 정보 입력</a></li>
                                {? res.status == 1}
                                <li class="active"><a href="/admin_competition/apply_info/{res.id}">{? res.form}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}참가신청 정보 설정</a></li>
                                <li><a href="/admin_competition/score_info/{res.id}">{? res.score}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}평가 항목 설정</a></li>
                                <li><a href="/admin_competition/score_info/{res.id}">{? exn}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}심사위원 초대</a></li>
                                <li><a href="/admin_competition/score_info/{res.id}">{? res.winner}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}수상자 선정</a></li>
                                {/}
                            </ul>
                        </div>
                        <form class="form-horizontal" role="form" name="info_form" method="post" onsubmit="return false;">
                                    <fieldset>
                                        <legend class="sr-only">참가 신청 정보 설정</legend>
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">참가자 이름</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                 <input type="text" class="form-control"  value="참가신청하면 자동으로 입력됩니다." disabled >
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">참가하는 회사/팀 명</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                 <input type="text" class="form-control"  value="참가신청하면 자동으로 입력됩니다." disabled >
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">참가 양식 만들기</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">  
                                            
                                                <ol id="sortable">
                                                    {res.form}
                                                </ol>
                                                <!-- /sortable -->
                                                
                                                <button class="btn btn-info btn-sm" id="btn_form" onclick="get_form_field(0); return false;" {? !res.form}style="display: none;"{/}><span class="icon-plus"></span>&nbsp;항목추가</button>
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">파일첨부 사용 여부</div>
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

                                                <button class="btn btn-info btn-sm" id="btn_file" onclick="get_form_file(0); return false;" {? !res.form_file}style="display: none;"{/}><span class="icon-plus"></span>&nbsp;첨부파일 항목추가</button>
                                                
                                            </div>
                                        </div>
                                        <div class="panel-footer">
                                            <div class="action-wrap">
                                                <div class="col-sm-offset-3 col-md-offset-3"> 
                                                    <a href="#" class="btn btn-default">취소</a> 
                                                    <a href="#" onclick="submit_info(this);" class="btn btn-primary">확인</a> 
                                                </div>
                                            </div>
                                        </div>
                                        <input type="hidden" name="id" value="{res.id}" /> 
                                        <input type="hidden" name="form" value="" /> 
                                    </fieldset>
                                </form>
                    </div>
                    <!-- /panel --> 
                    
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 
