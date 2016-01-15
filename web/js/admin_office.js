// ++++++++++++++++++++++++++++++++++++++++++
//
// NOTICE!! DO NOT USE ANY OF THIS JAVASCRIPT
//
// Only Script for D.CAMP - ADMIN 
//
// ++++++++++++++++++++++++++++++++++++++++++

function submit_mento(_id) {
    $('form[name=f_mento] .btn-primary').hide();
    var frm = $('form[name=f_mento]');
    var set_data = frm.serialize();
    var post_url = "/ajax_v2/save_mento/"+ _id;
    $.ajax({
        type : 'POST',
        url : post_url,
        data : set_data,
        success : function(_data) {
            alert("저장되었습니다");
            if (_id == 0) {
                $('#oh1').show();
                $('#oh2').show();
            }
            $('input[name=id]').val(_data);
            $('form[name=f_mento] .btn-primary').show();
        }
    });
}

function submit_mento_oh() {
    $('form[name=f_mento_oh] .btn-primary').hide();
    document.getElementById("contents").value = tinyMCE.activeEditor.getContent();
    var _id = $('input[name=id]').val();
    var frm = $('form[name=f_mento_oh]');
    var set_data = frm.serialize();
    var post_url = "/ajax_v2/save_mento/"+ _id;
    $.ajax({
        type : 'POST',
        url : post_url,
        data : set_data,
        success : function() {
            alert("저장되었습니다");
            $('form[name=f_mento_oh] .btn-primary').show();
        }
    });
}

function submit_oh(_id) {
    if ($('form[name=f_oh] input[name=mento_id]').val() == '') {
        alert("멘토를 선택하셔야 합니다.");
        return false;
    }
    $('form[name=f_oh] .btn-primary').hide();
    document.getElementById("contents").value = tinyMCE.activeEditor.getContent();
    var frm = $('form[name=f_oh]');
    var set_data = frm.serialize();
    var post_url = "/ajax_v2/save_oh/";
    // return false;
    $.ajax({
        type : 'POST',
        url : post_url,
        data : set_data,
        success : function(_data) {
            alert("저장되었습니다");
            $('input[name=id]').val(_data);
            $('form[name=f_oh] .btn-primary').show();
        }
    });
}

function submit_apply_st() {
    $('form[name=f_apply] .btn-primary').hide();
    var frm = $('form[name=f_apply]');
    var set_data = frm.serialize();
    var post_url = "/ajax_v2/edit_apply_status/";
    // return false;
    $.ajax({
        type : 'POST',
        url : post_url,
        data : set_data,
        success : function(_data) {
            if (_data) {
                alert("에러가 발생했습니다.");
            }
            else {
                alert("저장이 완료되었습니다.");
            }
            $('form[name=f_apply] .btn-primary').show();
        }
    });
}

function fix_status(_this, _id) {
    $(_this).attr("disabled", "disabled");
    var r = confirm("상담 기업 선정을 확정하겠습니까?");
    
    if (r == true) {
        var post_url = "/ajax_v2/edit_oh_status/"+_id;
        $.ajax({
            type : 'GET',
            url : post_url,
            success : function(_data) {
                if (_data) {
                    alert("에러가 발생했습니다.");
                    $(_this).removeAttr("disabled");
                }
                else {
                    alert("상담 기업 선정을 완료했습니다.");
                    
                }
            }
        });
    }   
}

var a_bios = '<li><button class="close" type="button" onclick="remove_p(this);"><span>×</span></button><input type="text" class="form-control" placeholder="약력을 입력해 주세요" name="bios"></li>';
var a_article = '<li class="row">'
                    +'<button class="close" type="button" onclick="remove_p(this);"><span>×</span></button>'
                    +'<div class="col-xs-12 col-sm-6 col-md-6 left">'
                        +'<input type="text" class="form-control" placeholder="기사 제목을 입력해 주세요" name="an">'
                    +'</div>'
                    +'<div class="col-xs-12 col-sm-6 col-md-6 right">'
                        +'<input type="url" class="form-control" placeholder="링크주소 입력해 주세요" name="al">'
                    +'</div>'
                +'</li>';
var a_q = '<div class="form-group">'
                +'<div class="col-xs-12 col-sm-3 col-md-3 control-label">추가질문 제목 </div>'
                +'<div class="col-xs-12 col-sm-9 col-md-9">'
                    +'<button class="close" type="button" onclick="remove_p(this);"><span>×</span></button>'
                    +'<input type="text" class="form-control">'
                +'</div>'
            +'</div>';

function add_input(_this, _target) {
    if (_target == a_bios) {
        cnt = parseInt($('input[name=b_cnt]').val())+1;
        $(_this).prev().append(_target);
        $('input[name=b_cnt]').val(cnt);
        $(_this).prev().find('li').last().children().attr('name', 'bios'+cnt);
    }
    else if (_target == a_article) {
        cnt = parseInt($('input[name=a_cnt]').val())+1;
        $(_this).prev().append(_target);
        $('input[name=a_cnt]').val(cnt);
        $(_this).prev().find('li').last().find('.left > input').attr('name', 'an'+cnt);
        $(_this).prev().find('li').last().find('.right > input').attr('name', 'al'+cnt);
    }
    else if (_target == a_q) {
        cnt = parseInt($('input[name=q_cnt]').val())+1;
        $(_this).parent().parent().before(_target);
        $('input[name=q_cnt]').val(cnt);
        $(_this).parent().parent().prev().find('input').attr('name', 'q'+cnt);
    }  
    
}

function del_this(_this) {
    $(_this).prev().remove();
}

function remove_p(_this) {
    $(_this).parent().remove();
}

function remove_pp(_this) {
    $(_this).parent().parent().remove();
}

function submit_mento_form(_id) {
    $('form[name=f_mento_form_add] .btn-primary').hide();
    var frm = $('form[name=f_mento_form_add]');
    var set_data = frm.serialize();
    var post_url = "/ajax_v2/save_mento_form/"+ _id;
    // return false;
    $.ajax({
        type : 'POST',
        url : post_url,
        data : set_data,
        success : function(_data) {
            alert("저장되었습니다");
            $('form[name=f_mento_form_add] .btn-primary').show();
        }
    });
}

function get_mento() {
    var post_url = "/ajax_v2/get_mento";
    $.ajax({
        type : 'GET',
        url : post_url,
        success : function(_data) {
            $('#md-selectMentor .modal-body').html(_data);
        }
    });
}

function submit_oh_form(_id) {
    $('form[name=f_oh_form_add] .btn-primary').hide();
    var frm = $('form[name=f_oh_form_add]');
    var set_data = frm.serialize();
    var post_url = "/ajax_v2/save_oh_form/"+ _id;
    // return false;
    $.ajax({
        type : 'POST',
        url : post_url,
        data : set_data,
        success : function(_data) {
            alert("저장되었습니다");
            $('form[name=f_oh_form_add] .btn-primary').show();
        }
    });
}

function del_mentor(_this, _id) {
    var r = confirm("해당 멘토를 삭제할까요?");
    
    if (r == true) {
        var post_url = "/ajax_v2/del_mentor/"+ _id;
        $.ajax({
            type : 'POST',
            url : post_url,
            success : function(_data) {
                $(_this).parent().parent().remove();
            }
        });
    }
}

function del_oh(_this, _id) {
    var r = confirm("해당 Office Hours 를 삭제할까요?");
    
    if (r == true) {
        var post_url = "/ajax_v2/del_oh/"+ _id;
        $.ajax({
            type : 'POST',
            url : post_url,
            success : function(_data) {
                $(_this).parent().parent().remove();
            }
        });
    }
}

function get_oh_apply_list(_id)
{
    $.ajax({
        url:'/ajax_v2/get_oh_apply_list/'+_id+"/1",
        type : 'GET',
        dataType : 'html',
        success : function(_data){
            $('#sidebar').html(_data);
        }
    });
}

function get_oh_apply_list_de(_this, _type, _id, _page)
{
    $.ajax({
        url:'/ajax_v2/get_oh_apply_list_de/'+_type+"/"+_id+"/"+_page+"/1",
        type : 'GET',
        dataType : 'html',
        success : function(_data){
            $(_this).parent().parent().parent().parent().html(_data)
        }
    });
}