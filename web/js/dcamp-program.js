// ++++++++++++++++++++++++++++++++++++++++++
//
// NOTICE!! DO NOT USE ANY OF THIS JAVASCRIPT
//
// Only Script for D.CAMP - PROGRAM 
//
// ++++++++++++++++++++++++++++++++++++++++++

// edit.tpl
function go_submit(_this)
{
    if (!$('input[name=title]').val()) {
        alert("프로그램명을 입력해주세요.");
        return false;
    }

    if ($("select[name=a_start] option:selected").val() === "1") {
        if (!$('input[name=a_start_d]').val()) {
            alert("접수 시작일을 입력해주세요.");
            return false;
        }

        if (!$('input[name=a_start_t]').val()) {
            alert("접수 시작 시간을 입력해주세요.");
            return false;
        }

        if (!$('input[name=a_end_d]').val()) {
            alert("접수 종료일을 입력해주세요.");
            return false;
        }

        if (!$('input[name=a_end_t]').val()) {
            alert("접수 종료 시간을 입력해주세요.");
            return false;
        }
    }
    
    if ($("select[name=cnt_c] option:selected").val() === "1") {
        if (!$('input[name=cnt]').val()) {
            alert("인원을 입력해주세요.");
            return false;
        }
    }    
    
    document.getElementById("content").value = tinyMCE.activeEditor.getContent();
    document.edit_pro_f.submit();
}

function check_cnt(_this)
{
    var check = $(_this).val();
    if (check === "0") {
        $('#inputCnt').hide();
    }
    else {
        $('#inputCnt').show();
    }
}

function check_date(_this)
{
    var check = $(_this).val();
    if (check === "0") {
        $('#a_date').hide();
    }
    else {
        $('#a_date').show();
    }
}

// apply_info.tpl
function get_form_field(_id, _pid) {

    var get_url = '/ajax_v3/add_pro_form/'+_pid;
    $.get(get_url, function(_data){
        $('#sortable').append(_data);
        $('.selectpicker').selectpicker();
        $('.entry-itemOption').slideDown();
    });
}

function get_form_field_e(_this, _id, _pid) {
    $(_this).parent().parent().slideUp();

    var get_url = '/ajax_v3/add_pro_form/';
    var set_data ={
        "id"        : _id,
        "program_id"        : _pid,
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

function get_form_file(_id, _pid) {
    var get_url = '/ajax_v3/add_pro_form_file/'+_pid;
    $.get(get_url, function(_data){
        if (_id !== 0) {
            $('#sc_f_'+_id).before(_data);
        } else {
            $('#btn_file').before(_data);
        }
    });
}

function get_form_file_e(_this, _id, _pid) {
    $(_this).parent().parent().slideUp();

    var get_url = '/ajax_v3/add_pro_form_file/';
    var set_data ={
        "program_id"        : _pid,
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
        var get_url = '/ajax_v3/del_pro_form/'+_id;
        $.get(get_url, function(_data){
            $(_this).parent().parent().remove();
        });
    }
}

function delete_form_file(_this, _id) {
    var r = confirm("삭제할까요?");
    if (r == true) {
        var get_url = '/ajax_v3/del_pro_form_file/'+_id;
        $.get(get_url, function(_data){
            $(_this).parent().parent().remove();
        });
    }
}

function add_pro_form(_this, _type) {
    var frm = $(_this).parent().parent().parent().parent();
    var get_url = '/ajax_v3/edit_pro_form/';
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

function add_pro_form_file(_this, _type) {

    var frm = $('form[name=m_form_file_add]');
    var get_url = '/ajax_v3/edit_pro_form';
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
    $('.pro_form_e').remove();
    $('.pro_form_f').remove();
    
    var frm = $('form[name=info_form]');
    var get_url = '/ajax_v3/save_pro_form'; 
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