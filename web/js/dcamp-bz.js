// ++++++++++++++++++++++++++++++++++++++++++
//
// NOTICE!! DO NOT USE ANY OF THIS JAVASCRIPT
//
// Only Script for D.CAMP - SHOWCASE 
//
// ++++++++++++++++++++++++++++++++++++++++++

// edit.tpl
function check_connect() {
    _ch = $('input[name=check_conn]').is(":checked");
    if (_ch) {
        $('#st_c').slideDown();
        $('#st_nc').slideUp();
    } 
    else {
        $('#st_c').slideUp();
        $('#st_nc').slideDown();
    }
}
var input_date = '<li class="item">'
                    +'<button onclick="del_box(this); return false;" aria-label="Close" class="close" type="button"><span aria-hidden="true">×</span></button>'
                    +'<div class="input-group">'
                        +'<span class="input-group-addon"><span class="icon-calendar"></span></span>'
                        +'<input type="text" class="form-control datepicker" value="">'
                    +'</div>'
                    +'<textarea placeholder="관련 내용을 입력하세요." class="form-control" rows="3"></textarea>'
                +'</li>';
var input_article = '<li class="item">'
                        +'<button type="button" class="close" aria-label="Close" onclick="del_box(this); return false;"><span aria-hidden="true">&times;</span></button>'
                        +'<div class="row art">'
                            +'<div class="col-md-4 left">'
                                +'<input type="text" class="form-control" placeholder="관련 기사 제목를 입력해 주세요.">'
                            +'</div>'
                            +'<div class="col-md-8 right">'
                                +'<input type="text" placeholder="관련 기사 링크를 입력해 주세요." class="form-control">'
                            +'</div>'
                        +'</div>' 
                    +'</li> ';

function add_input(_input, _this) {
    $(_this).prev().append(_input);
    $(".datepicker").datepicker({ dateFormat: 'yy.mm.dd',  viewMode: 2 })
    if (_input == input_date) {
        var _cnt = parseInt($("input[name=cnt_date]").val()) + 1;
        $("input[name=cnt_date]").val(_cnt);
        $(_this).prev().find('li').last().children().find('.datepicker').attr('name', 'update_'+_cnt);
        $(_this).prev().find('li').last().find('textarea.form-control').attr('name', 'update_des_'+_cnt);
    }
    else if (_input == input_article) {
        var _cnt = parseInt($("input[name=cnt_article]").val()) + 1;
        $("input[name=cnt_article]").val(_cnt);
        $(_this).prev().find('li').last().find('.left > input.form-control').attr('name', 'article_t_'+_cnt);
        $(_this).prev().find('li').last().find('.right > input.form-control').attr('name', 'article_'+_cnt);
    }
}

function cancel_bz() {
    $('#md-warning p').html('<strong><span class="icon-warning-sign"></span></strong>지금까지의 등록 내역이 초기화 됩니다.');
    $('#md-warning .btn-default').html('아니요');
    $('#md-warning .btn-danger').html('네');
    $('#md-warning .btn-danger').attr('onclick', 'javascript:location.href="/showcase"');
    $('#md-warning').modal('show');
}

function submit_bz(_this, _str) {
    if ($('input[name=name]').val().length < 1) {
        confirm("제품/서비스명을 입력해주세요.");
        return false;
    }
    if ($('select[name=market_1] option:selected').val() == 0 && $('select[name=market_2] option:selected').val() == 0 && $('select[name=market_3] option:selected').val() == 0) {
        confirm("시장 구분을 하나라도 입력해주세요.");
        return false;
    }
    if ($('input[name=founded]').val().length < 1) {
        confirm("런칭(예정) 날짜를 입력해주세요.");
        return false;
    }
    if ($('#p').val().length < 1 && $('input[name=pic_1]').val().length < 1) {
        confirm("대표 이미지를 입력해주세요.");
        return false;
    }
    if ($('input[name=des_ele]').val().length < 1) {
        confirm("제품/서비스 한줄 설명을 입력해주세요.");
        return false;
    }

    if ($('textarea[name=des_pro]').val().length < 1) {
        confirm("제품/서비스 상세 설명을 입력해주세요.");
        return false;
    }

    $(_this).hide();
    var frm = $('form[name=form_bz]');
    var get_url = '/ajax_v3/save_bz';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            if (_data.id) {
                
                if (_str > 0) {
                    alert('제품/서비스 등록이 완료되었습니다.<br>관련 내용은 제품/서비스 관리에서 확인하실 수 있습니다.');
                    $('.modal-product-editor').modal('hide');
                    get_service(_str);
                }
                else {
                    msg_confirm('window.location.href="/member/edit_showcase"', '제품/서비스 등록이 완료되었습니다.<br>관련 내용은 제품/서비스 관리에서 확인하실 수 있습니다.');
                }
                    
            }
            else {
                alert("오류가 발생했습니다.");
            }
            
        }
    });
}

function more_betazone (_cat, _st) {
    var _page = parseInt($('#page').val());
    _page = _page + 1;
    if (_cat === '') _cat = 0;
    var get_url = '/ajax_v3/more_betazone/'+_page+'?category='+_cat+'&status='+_st;
    $.get(get_url, function(_data) {
        if (_data) {
            $('#page').val(_page);
            $('.post-list').append(_data);
            $('.quater').ellipsis({
                row: 4
            });
        }
        else {
            $('.pager').hide();
            alert('마지막 페이지 입니다.');
        }
    });
}

function get_service_list(_id, _pos) {
    $.ajax({
        type : 'GET',
        dataType : 'html',
        url : '/ajax_v3/get_service_list/' + _id,
        success : function(_data) {
            if (_data) {
                $(_pos).html(_data);
                $(_pos).parent().parent().show();
                
                if($('input[name=id]').val() > 0) {
                    $(_pos+' option[value="'+$('input[name=id]').val()+'"]').attr("selected", "selected");
                }
                $(_pos).selectpicker('refresh');
            }
            else {
                $(_pos).parent().parent().hide();
            }
        }
    });
}

function get_edit_service_modal(_id) {
    $('.modal-product-detail').hide();
    $('.modal-product-detail').removeClass('in');
    $('.modal-product-detail').attr('aria-hidden', true);

    // $('.navbar-fixed-top, .navbar-fixed-bottom').css('zIndex', 1);
    // $.ajax({
    //     type : 'GET',
    //     dataType : 'html',
    //     url : '/ajax_v3/edit_service/' + _id + '/0',
    //     success : function(_data) {
    //         $('.modal-product-editor').html(_data);
    //         $('.selectpicker').selectpicker('refresh');
    //         $(".datepicker").datepicker({ dateFormat: 'yy.mm.dd',  viewMode: 2 });
    //         $('.ui-datepicker-div').css('zIndex', 1041);
    //         $('.modal-product-editor').modal();
    //         $('.modal-backdrop.fade.in').click(function(){
    //             $('.modal').modal('hide');
    //         });
    //     }
    // });
    edit_service_modal(_id, 0);
}

function edit_service_modal(_id, _sid) {
    $('.navbar-fixed-top, .navbar-fixed-bottom').css('zIndex', 1);
    $.ajax({
        type : 'GET',
        dataType : 'html',
        url : '/ajax_v3/edit_service/' + _id + '/' + _sid,
        success : function(_data) {
            $('.modal-product-editor').html(_data);
            $('.selectpicker').selectpicker('refresh');
            $(".datepicker").datepicker({ dateFormat: 'yy.mm.dd',  viewMode: 2 });
            $('.ui-datepicker-div').css('zIndex', 1041);
            $('.modal-product-editor').modal();
            $('.modal-backdrop.fade.in, .close').click(function(){
                $('.modal').modal('hide');
            });
        }
    });
}

function edit_service_modal_html(_id) {
    $.ajax({
        type : 'GET',
        dataType : 'html',
        url : '/ajax_v3/edit_service/' + _id + "/0",
        success : function(_data) {
            $('.modal-product-editor').html('<div class="modal-backdrop fade in" style="height: 5000px;"></div>');
            $('.modal-product-editor').append(_data);
            $('.selectpicker').selectpicker('refresh');
            $(".datepicker").datepicker({ dateFormat: 'yy.mm.dd',  viewMode: 2 });
            $('.ui-datepicker-div').css('zIndex', 1041);

            $('.modal-backdrop.fade.in').click(function(){
                $('.modal').modal('hide');
            });
        }
    });
}

// function get_service_modal(_id, _wh, _op) {
//     $.ajax({
//         type : 'GET',
//         dataType : 'html',
//         url : '/ajax_v3/get_service/'+_id+'?where='+_wh+'&opt='+_op,
//         success : function(_data) {
//             $('.modal-product-detail').html(_data);
//             $('.modal-product-detail').modal('show');
//         }
//     });
// }

function get_service_modal(_id, _type, _opt) {
    _page = $('#page').val();

    $.ajax({
        type : 'GET',
        dataType : 'html',
        url : '/ajax_v3/get_service/'+_id+'?page='+_page+'&type='+_type+'&opt='+_opt,
        success : function(_data) {
            $('.modal-product-detail').html(_data);
            $('.modal-product-detail').modal('show');
        }
    });
}

function get_service_modal_next(_id, _wh, _op) {
    $.ajax({
        type : 'GET',
        dataType : 'html',
        url : '/ajax_v3/get_service/'+_id+'?where='+_wh+'&opt='+_op+'&next=1',
        success : function(_data) {
            $('.modal-product-detail').html(_data);
        }
    });
}

function del_service(_id, _type){
    del_confirm('del_ser2('+_id+', '+_type+')');
}

function del_ser2(_id, _type){
    var get_url = '/ajax_front/startup_del_service/'+_id;
    
    $.ajax({
        type : 'POST',
        url : get_url,
        dataType : 'json',
        success : function(_data) {
            if (_type == 1) {
                $('.media_li_'+_id).slideToggle();
            }
            else {
                get_service();
            }
            $('#md-warning').modal('hide');    
        }
    });
}

function more_bz_my() {
    var _page = parseInt($('#page').val());
    _page = _page + 1;

    var get_url = '/ajax_v3/more_bz_my/'+_page;
    $.get(get_url, function(_data) {
        if (_data) {
            $('#page').val(_page);
            $('.post-list').append(_data);
        }
        else {
            $('.pager').hide();
            alert('마지막 페이지 입니다.');
        }
    });
}