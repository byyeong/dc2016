function edit_des()
{
    $('#edit_des').slideToggle();
}

function submit_des()
{
    var frm = $('form[name=edit_des_form]');
    var _id = $('#id').val();
    var temp = '<input type="hidden" name="id" value="'+_id+'" />';
    frm.append(temp);

    var get_url = '/ajax_front/startup_edit';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {

            $('#edit_des').slideToggle();
            $('#desc p').html(_data.data);
            if ($('#desc_no').css('display') === 'block')
                $('#desc_no').slideToggle();
            if ($('#desc').css('display') === 'none')
                $('#desc').slideToggle();
            get_slide(_id);
        }
    });
}

function edit_bm_des()
{
    $('#edit_bm_des_form').slideToggle();
}

function submit_edit_bm_des()
{
    var frm = $('form[name=edit_bm_des_form]');
    var _id = $('#id').val();
    var temp = '<input type="hidden" name="id" value="'+_id+'" />';
    frm.append(temp);

    var get_url = '/ajax_front/startup_edit';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {

            $('#edit_bm_des_form').slideToggle();
            $('#e_bm_des').html(_data.data);
            if ($('#e_bm_des_no').css('display') === 'block')
                $('#e_bm_des_no').slideToggle();
            if ($('#e_bm_des').css('display') === 'none')
                $('#e_bm_des').slideToggle();
        }
    });
}

function edit_bm_tech()
{
    $('#edit_bm_tech_form').slideToggle();
}

function submit_edit_bm_tech()
{
    var frm = $('form[name=edit_bm_tech_form]');
    var _id = $('#id').val();
    var temp = '<input type="hidden" name="id" value="'+_id+'" />';
    frm.append(temp);

    var get_url = '/ajax_front/startup_edit';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {

            $('#edit_bm_tech_form').slideToggle();
            $('#e_bm_tech').html(_data.data);
            if ($('#e_bm_tech_no').css('display') === 'block')
                $('#e_bm_tech_no').slideToggle();
            if ($('#e_bm_tech').css('display') === 'none')
                $('#e_bm_tech').slideToggle();
        }
    });
}

function edit_edu()
{
    $('#edit_edu_no').slideToggle();
}

function submit_edit_edu()
{
    var frm = $('form[name=edit_edu_form]');
    var _id = $('#id').val();
    var temp = '<input type="hidden" name="id" value="'+_id+'" />';
    frm.append(temp);

    var get_url = '/ajax_front/member_edit_edu';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {

            $('#edit_edu_no').slideToggle();
            $('#edit_edu h4').html(_data.data1);
            $('#edit_edu small').html(_data.data2);
            if ($('#edit_edu_em').css('display') === 'block')
                $('#edit_edu_em').slideToggle();
            if ($('#edit_edu').css('display') === 'none')
                $('#edit_edu').slideToggle();
            
        }
    });
}

// Office Hours
function submit_apply(_id) {
    if ($('input[name=name]').val().length < 1) {
        alert('참가자 이름을 입력해주세요.');
        $('input[name=name]').focus();
        return false;
    }
    if ($('input[name=tel]').val().length < 1) {
        alert('휴대폰 번호를 입력해주세요.');
        $('input[name=tel]').focus();
        return false;
    }
    if ($('input[name=email]').val().length < 1) {
        alert('이메일 주소를 입력해주세요.');
        $('input[name=email]').focus();
        return false;
    }
    if ($('textarea[name=m_description]').val().length < 1) {
        alert('간단한 자기소개를 입력해주세요.');
        $('textarea[name=m_description]').focus();
        return false;
    }
    if ($('textarea[name=topic]').val().length < 1) {
        alert('이야기 나누고 싶은 상담주제를 입력해주세요.');
        $('textarea[name=topic]').focus();
        return false;
    }
    if ($('textarea[name=t_description]').val().length < 1) {
        alert('팀 소개를 입력해주세요.');
        $('textarea[name=t_description]').focus();
        return false;
    }

    // 제품/서비스명
    if ( $('input[name=s_subject]').length > 0) {
        if ($('input[name=s_subject]').val().length < 1) {
            alert('제품/서비스명을 입력해주세요.');
            $('input[name=s_subject]').focus();
            return false;
        }
    }    
    if ($('input[name=s_description]').val().length < 1) {
        alert('제품/서비스 한줄 설명을 입력해주세요.');
        $('input[name=s_description]').focus();
        return false;
    }
    if ( $('input[name=id]').val().length == 0) {
        if ($('input[name=file]').val().length == 0 && $('input[name=file_link]').val().length == 0) {
            alert('첨부파일을 입력해주세요.');
            $('input[name=file]').focus();
            return false;
        }
    }

    if ($('#f_ing').val() == 1) {
        _error = 1;
        alert("첨부 파일은 8MB까지 업로드 가능합니다. 파일을 확인해주세요."); 
        return false;
    }  
    $('form[name=f_apply] .btn-primary').hide();
    $('input[name=ser_id]').val($("select[name=s_subject] option:selected").attr('rel'));
    $('input[name=st_id]').val($("select[name=team] option:selected").attr('rel'));
    document.f_apply.submit();
}

function submit_oh_add(_id) {
    $('form[name=f_oh_add] .btn-primary').hide();
    document.getElementById("contents").value = tinyMCE.activeEditor.getContent();
    var frm = $('form[name=f_oh_add]');
    var set_data = frm.serialize();
    var post_url = "/ajax_v2/save_oh/"+ _id;
    // return false;
    $.ajax({
        type : 'POST',
        url : post_url,
        data : set_data,
        success : function(_data) {
            alert("저장되었습니다");
            $('input[name=id]').val(_data);
            $('form[name=f_oh_add] .btn-primary').show();
        }
    });
}

var a_q = '<div class="form-group">'
                +'<div class="col-xs-12 col-sm-3 col-md-3 control-label">추가질문 제목 </div>'
                +'<div class="col-xs-12 col-sm-9 col-md-9">'
                    +'<button class="close" type="button" onclick="remove_pp(this);"><span>×</span></button>'
                    +'<input type="text" class="form-control">'
                +'</div>'
            +'</div>';

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
var a_dpt = '<p><input type="text" placeholder="분야를 입력하세요." class="form-control" ></p>';

var a_f = '<p class="form-control-static"><input type="file"></p>';

function add_input(_this, _target) {
    if (_target == a_q) {
        cnt = parseInt($('input[name=q_cnt]').val())+1;
        $(_this).parent().parent().before(_target);
        $('input[name=q_cnt]').val(cnt);
        $(_this).parent().parent().prev().find('input').attr('name', 'q'+cnt);
    }    
    else if (_target == a_bios) {
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
    else if (_target == a_dpt) {
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
    var _id = $('input[name=id]').val();
    document.getElementById("contents").value = tinyMCE.activeEditor.getContent();
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
            window.location.reload(true);
        }
    });
}

function remove_p(_this) {
    $(_this).parent().remove();
}

function remove_pp(_this) {
    $(_this).parent().parent().remove();
}

function del_apply(_id) {
    var r = confirm("참가 취소을 삭제하시겠습니까? 접수한 내용이 삭제됩니다.");
    
    if (r == true) {
        var post_url = "/ajax_v2/delete_apply/"+_id;
        $.ajax({
            type : 'GET',
            url : post_url,
            success : function(_data) {
                if (_data) {
                    alert("에러가 발생했습니다.");
                }
                else {
                    alert("삭제 되었습니다.");
                    window.location.reload(true);
                }
            }
        });
    }

}

function set_alarm(_id) {
    $.ajax({
        type : 'GET',
        url : '/ajax_v2/add_mento_alarm/' + _id,
        success : function() {
            alert("접수가 시작되면 메일로 알려드립니다.");
        }
    });
}

function get_record(_mid, _uid) {
    $.ajax({
        type : 'GET',
        url : '/ajax_v2/get_record/' + _mid + "/" + _uid,
        success : function(_data) {
            $('#md-recordHours').html(_data);
            $('#md-recordHours').modal('show');
        }
    });
}

function get_startup(_id, _ser) {
    var set_data ={
        "id"      : _id,
        "service" : _ser
    };

    $.ajax({
        type : 'POST',
        data : set_data,
        url : '/ajax_v2/get_startup/',
        success : function(_data) {
            $('#more-companyInfo').html(_data);
            $('#more-companyInfo').show();
        }
    });
}

function get_service(_id) {
    $.ajax({
        type : 'GET',
        dataType : 'json',
        url : '/ajax_v2/get_service_des/' + _id,
        success : function(_data) {
            if (_data) {
                $('input[name=ser_id]').val(_id);
                $('input[name=s_description]').val(_data.des_ele);
            }
                
        }
    });
}

function limit_upload(_this)
{
    $('#f_ing').val(1);
    $(_this).next().show();
    var formData = new FormData();
    jQuery.each($(_this)[0].files, function(i, file) {
        formData.append('file-'+i, file);
    });

    $.ajax({
        url:'/ajax_front/check_upload_file',
        data:formData,
        cache:false,
        processData:false,
        contentType:false,
        type:'POST',
        dataType : 'html',
        success : function(_err){
            if (_err > 8388608 || ! _err || _err == 0) {
                alert("업로드 된 파일의 사이즈가 8MB를 초과합니다.<br/>8MB 이내의 파일을 업로드 해주세요");
            }
            else {
                $('#f_ing').val(0);
            }
            $(_this).next().hide();
        }
    });
}

function get_oh_apply_list(_id)
{
    $.ajax({
        url:'/ajax_v2/get_oh_apply_list/'+_id,
        type : 'GET',
        dataType : 'html',
        success : function(_data){
            $('.affix-top').html(_data)
        }
    });
}

function get_oh_apply_list_de(_this, _type, _id, _page)
{
    $.ajax({
        url:'/ajax_v2/get_oh_apply_list_de/'+_type+"/"+_id+"/"+_page,
        type : 'GET',
        dataType : 'html',
        success : function(_data){
            $(_this).parent().parent().parent().parent().html(_data)
        }
    });
}

function send_ch_cat(_this, _id) {

    $(".btn").attr("disabled", "disabled");
    _cat = $("select[name=category] option:selected").val();
    var post_url = "/ajax_v2/change_cat_qna/"+_id+"/"+_cat;
    $.ajax({
        type : 'POST',
        url : post_url,
        success : function(_data) {
            if ( ! _data) {
                document.location.href = "/support/qna";    
            }
            else {
                alert("변경할 수 없습니다.");
            }
            $(_this).removeAttr("disabled");
        }
    });
}

function submit_pending(_this) 
{
    if ($('input[name=fb]').is(':checked') == true && _public == 0) {
        var popUrl = '/fb/1?';
        var popOption = "width=1000, height=600, resizable=no, scrollbars=no, status=no;";
        window.open(popUrl,"",popOption);
    }

    $(_this).attr('disabled', 'disabled');
    var frm = $('form[name=p_form]');
    var get_url = '/ajax_v3/edit_examiner_status';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        success : function() {
            alert("저장되었습니다.");
            window.location.href = "/";
        }
    });    
}

function get_reject(_id, _comp)
{
    $.ajax({
        url:'/ajax_v3/get_examiner_comp/'+_id+"/"+_comp,
        type : 'GET',
        dataType : 'html',
        success : function(_data){
            $('#md-managerRefuse').html(_data);
            $('#md-managerRefuse').modal('show')
        }
    });
}

function search_member()
{
    $('#md-searchMember').html('');
    var url = '/ajax_front/get_member_list/';
    $.get(url, function(_data){
        $('#md-searchMember').append(_data);
    });
}

function search_member_q()
{
    var url = '/ajax_front/get_member_list_q/';
    var set_data ={
        "q":$('input[name=q]').val(),
    };
    $.post(url, set_data, function(_data){
        $('#md-searchMember .search-result').html('');
        $('#md-searchMember .search-result').append(_data);
    });
}

function set_email(_email)
{
    $('#md-searchMember').modal('hide');
    var _e_email = $('input[name=ex_email]').val();
    if (_e_email !== '')
        $('input[name=ex_email]').val(_e_email +", "+ _email);
    else 
        $('input[name=ex_email]').val(_email);
}

function change_status_cm(_this, _id)
{
    _type = $("select[name=open] option:selected").val();
    var get_url = '/ajax_front/change_status_competition/'+_id+'/'+_type;
    $.get(get_url, function(_data){
        if (_type == '0'){
            alert('대회를 비공개로 설정합니다.');
        }
        else {
            if (_data) {
                $(_this).next().find('.filter-option').html('비공개');
                $('#md-warning-al .btn-danger').attr("onclick", "javascirpt:location.href='/challenge/edit_next/"+_id+"'")
                $('#md-warning-al').modal('show');
            }
            else {
                alert('대회를 공개로 설정합니다.');
            }
        }
    });
}

function move_applied_list()
{
    location.href = "/challenge/edit_next";
}