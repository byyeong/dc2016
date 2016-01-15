
// dev
function posting_area(_id)
{
    var get_url = '/ajax_front/get_posting_area/'+_id;
    $.get(get_url, function(_data) {
        $('fieldset').html(_data);
    });
}

function submit_p_form(_id, _public) 
{
    // console.log($('input[name=fb]').is(':checked'));
    // return false;
    // if (_public == 0 && $('checkbox[name:fb]').val() == 1) {
        
    // }
    
    if ($("textarea").val().length < 1) {
        alert('내용을 입력해주세요.');
        return;
    }
    else if ($('input[name=fb]').is(':checked') == true && _public == 0) {
        var popUrl = '/fb/1?';
        var popOption = "width=1000, height=600, resizable=no, scrollbars=no, status=no;";
        window.open(popUrl,"",popOption);
    }
    else {
        $("#submit_f").attr('disabled', 'disabled');
        var frm = $('form[name=p_form]');
        var get_url = '/ajax_front/add_lounge_posting';
        var set_data = frm.serialize();
        
        $.ajax({
            type : 'POST',
            url : get_url,
            data : set_data,
            success : function(_data) {
                if ( _data == "error_user" ) {
                    alert('로그인이 필요합니다.');
                }
                else if ( _data == "error_sns" ) {
                    alert('연동된 sns가 없습니다.');
                }
                else {
                    $("textarea[name=cont]").val("");
                    // $(".form-submit input[type=checkbox]").prop("checked", true);
                    if ($('#inputPic').length > 0) $('#inputPic').prev().attr('src', '/img/default-img-pic.png'); 
                    $('#timeline').prepend(_data);
                    $("a[rel^='prettyPhoto']").prettyPhoto({social_tools: false});
                }
                $("#submit_f").removeAttr('disabled');
                $("#submit_f").removeAttr('disabled'); 
            }
        });
    }
    return;
}

function submit_p_form2() 
{
    $("#submit_f").attr('disabled', 'disabled');
    var frm = $('form[name=p_form]');
    var get_url = '/ajax_front/add_lounge_posting';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        success : function(_data) {
            if ( _data == "error_user" ) {
                alert('로그인이 필요합니다.');
            }
            else if ( _data == "error_sns" ) {
                alert('연동된 sns가 없습니다.');
            }
            else {
                $("textarea[name=cont]").val("");
                $(".form-submit input[type=checkbox]").prop("checked", true);
                if ($('#inputPic').length > 0) $('#inputPic').prev().attr('src', '/img/default-img-pic.png'); 
                $('#timeline').prepend(_data);
                $("a[rel^='prettyPhoto']").prettyPhoto({social_tools: false});
                frm.attr('onsubmit', 'submit_p_form('+$('#timeline-form input[name=id]').val()+', 1); return false');
            }
            $("#submit_f").removeAttr('disabled');
            $("#submit_f").removeAttr('disabled'); 
        }
    });
}

function timeline_call(_id) 
{
    $("#m_t_btn").attr('disabled', 'disabled');
    var _page = Number($('#t_page').val());
    var get_url = '/ajax_front/get_lounge_timeline/3/' + _id + '/' + _page;
    $.ajax({
        type : 'GET',
        url : get_url,
        dataType : 'html',
        success : function(_data) {
            if (_data == "") {
                if (_page > 1) alert('마지막 입니다.');
                $("#m_t_btn").hide();
            }
            else {
                $('#timeline').append(_data);
                $('#t_page').val( _page + 1 );
                $("#m_t_btn").removeAttr('disabled');
                $("a[rel^='prettyPhoto']").prettyPhoto({social_tools: false});
            }
                
        }
    });
}

function submit_lo_comm(_this, _id)
{
    var frm = $('form[name=lo_comm_form'+_id+']');
    if ($(_this).parent().find('textarea[name=contents]').val().length < 1) {
        alert('내용을 입력해주세요.');
        return false;
    }
    $(_this).attr('disabled', 'disabled');
    var get_url = '/ajax_front/add_timeline_comm2';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {
            $(_this).parent().find('textarea').val("");
            $(_this).parent().parent().parent().parent().before(_data);
            $(_this).removeAttr('disabled');
            _cnt = Number($("#re_cnt"+_id).html()) + 1;
            $("#re_cnt"+_id).html(_cnt);
            $("#re_cnt"+_id).parent().addClass('active')
        }
    });
}

function comment_like(_this, _id, _type) 
{
    $(_this).attr('disabled', 'disabled');
    $.ajax({
        type : 'POST',
        url : '/ajax_front/add_timeline_like/' + _id + "/" + _type,
        dataType : 'json',
        success : function(_data) {
            if (_data.error) {
                alert('이미 좋아요 했습니다.');
                $(_this).removeAttr('disabled');
                return false;
            }
            else if (_data.login) {
                alert('로그인 해주세요.');
                $(_this).removeAttr('disabled');
                return false;
            }
            if (_data.cnt == 0) {
                $(_this).parent().removeClass('active');
                html_ = '<button onclick="comment_like(this, '+_id+', 0); return false;" '
                    +'class="btn btn-default btn-sm" type="button"><span class="glyphicon glyphicon-heart"></span>'
                    +'<span class="sr-only">좋아요</span></button>';
                $(_this).parent().html(html_);
            }
            else {
                if (_type == 1) type_ = 0
                else type_ = 1 
                $(_this).parent().addClass('active');
                html_ = '<button onclick="comment_like(this,  '+_id+', '+type_+'); return false;" class="btn btn-default btn-sm" type="button">'
                    +'<span class="glyphicon glyphicon-heart"></span></span><span class="sr-only">좋아요 </span><span id="li_cnt'+_id+'">'+_data.cnt+'</span></button>'
                    +'<button onclick="get_like('+_id+'); return false;" type="button" class="btn btn-default btn-sm" data-toggle="collapse" data-target="#like-media'+_id+'" aria-expanded="false" aria-controls="like-media"><span class="caret"></span></button>';
                $(_this).parent().html(html_);
            }
            $(_this).removeAttr('disabled');
        }
    });
}

function get_like(_id) 
{
    if ( $("#like-media"+_id).hasClass('in') == false ) {
        $.ajax({
            type : 'POST',
            url : '/ajax_front/get_timeline_like/' + _id,
            dataType : 'html',
            success : function(_data) {
                $("#like-media"+_id).html(_data);
            }
        });
    } 
        
}

function add_star(_id)
{
    var sel_star = $("#star-rating option:selected").val();
    $.ajax({
        type : 'POST',
        url : '/ajax_front/add_star_event/' + _id + '/' + sel_star,
        dataType : 'json',
        success : function(_data) {

            if (_data.error == "login") {
                alert('로그인 해주세요.');
            }
            else if (_data.error == "aleady") {
                alert('이미 참여했어요.');
            }
            else {
                alert('별점이 저장되었었어요.');
                $('.point-star').find('small').html('('+_data.data.cnt+'명 참여)');
                $('.rating > span').removeClass('selected');
                $('.rateToggle').attr('disabled', 'disabled');
                $('.rateToggle').html('참여했어요');
                if (_data.data.star > 0) $('.rating > span').eq(0).addClass('selected');
                if (_data.data.star > 1) $('.rating > span').eq(1).addClass('selected');
                if (_data.data.star > 2) $('.rating > span').eq(2).addClass('selected');
                if (_data.data.star > 3) $('.rating > span').eq(3).addClass('selected');
                if (_data.data.star > 4) $('.rating > span').eq(4).addClass('selected');

            }

            $('.ratinglayer').hide();
            $('.br-widget > a').removeClass('br-selected');
            $('.br-widget > a').eq(0).addClass('br-selected');

                
        }
    });
}

function del_comm(_id, _pid)
{
    del_confirm('del_comm2('+_id+', '+_pid+')');
}

function del_confirm(_fuc) {
    _msg = "정말 삭제하시겠습니까?<br> 아래의 [삭제]를 클릭하시면 해당 내용은 완전히 삭제됩니다.</p>";
    $('#md-warning p').html('<strong><span class="icon-warning-sign"></span></strong>'+_msg);
    $('#md-warning .btn-danger').attr('onclick', _fuc);
    $('#md-warning').modal('show');
}

function del_comm2( _id, _pid)
{

    var get_url = '/ajax_front/del_com/'+_id+'/'+_pid;
    $.get(get_url, function(data) {
        if (data == "error") {

        }
        else {
            if (data) $("#re_cnt"+_pid).html(data);
            $('#com'+_id).remove();
            $('#md-warning').modal('hide');
        }
            
    });

}

function img_up(_this) {
    var fd = new FormData();    
    fd.append( 'file', $('#inputPic')[0].files[0] );
    $.ajax({
          url: '/ajax_front/img_temp_upload',
          data: fd,
          processData: false,
          contentType: false,
          type: 'POST',
          dataType : 'json',
          success: function(data){
            if (data.error_str) {
                alert(data.error_str);
            }
            else {
                $(_this).prev().attr("src", data.img);
                $('input[name=image]').val(data.img);
            }
          }
    });
}