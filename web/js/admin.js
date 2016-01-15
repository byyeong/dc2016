// ++++++++++++++++++++++++++++++++++++++++++
//
// NOTICE!! DO NOT USE ANY OF THIS JAVASCRIPT
//
// Only Script for D.CAMP - ADMIN 
//
// ++++++++++++++++++++++++++++++++++++++++++

!function ($) {
$(function () {
    
    // tooltip
    $('.panel').tooltip({
      selector: "[data-toggle=tooltip]",
      container: "body"
    })
      
	//selectpicker
    $('.selectpicker').selectpicker();
        
    // sidebar affix
    $('.page-sidenav').affix();
    
    
    $('#myTab a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    });
    
    $('#myTab a:last').tab('show');
    });
    
    $('#companyTab a').click(function (e) {
      e.preventDefault()
      $(this).tab('show')
    })

}(window.jQuery)

function remove_pp(_this) {
    $(_this).parent().parent().remove();
}

function newsletterPop(_id, _type){

  var popUrl = "/ajax_v2/newsletter/"+_id+"/"+_type;
  var popOption = "width=800, height=800, resizable=no, scrollbars=yes, status=no;"; 
  window.open(popUrl,"",popOption);

}

function newsletterRecruitPop(_id){

  var popUrl = "/ajax_v3/newsletter_recruit/"+_id;
  var popOption = "width=800, height=800, resizable=no, scrollbars=yes, status=no;"; 
  window.open(popUrl,"",popOption);

}

function add_cont(_this){
  var _cnt = parseInt($('input[name=cont_cnt]').val()) + 1;
  var post_url = "/ajax_v2/get_cont/"+_cnt;
    // return false;
    $.ajax({
        type : 'GET',
        url : post_url,
        success : function(_data) {
            $(_this).prev().append(_data);
            $('input[name=cont_cnt]').val(_cnt);
        }
    });
}

function newsletterPop_temp(_type){
    var frm = $('form[name=form_newsl]');
    document.getElementById("body").value = tinyMCE.activeEditor.getContent();
    var get_url = '/ajax_v2/temp_newsletter';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            var popUrl = "/ajax_v2/newsletter/"+_data.id+"/"+_type+"/1";
            var popOption = "width=800, height=800, resizable=no, scrollbars=yes, status=no;"; 
            window.open(popUrl,"",popOption);
        }
    });
}

function newsl_mail(_this){
    $(_this).attr("disabled", "disabled");

    var frm = $('form[name=form_newsl]');
    document.getElementById("body").value = tinyMCE.activeEditor.getContent();
    var get_url = '/ajax_v2/temp_newsletter';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            _id = _data.id;

            get_url = '/ajax_v2/send_newsletter/'+_id+"/1";
            set_data ={
                "emails" : $('input[name=emails]').val(),
                "subject" : $('input[name=subject]').val()
            };
            $.ajax({
                type : 'POST',
                url : get_url,
                data : set_data,
                dataType : 'json',
                success : function() {
                    alert('메일을 전송했습니다.');
                    $(_this).removeAttr('disabled');
                }
            });
        }
    }); 
}

function add_newsletter(_this){
    $(_this).attr("disabled", "disabled");
    document.getElementById("body").value = tinyMCE.activeEditor.getContent();
    $("form[name=form_newsl]").submit();
}

function del_faq(_this, _id) {
    var r = confirm("정말 삭제하시겠습니까?");
    
    if (r == true) {
        $.ajax({
            type : 'GET',
            url : '/ajax_v2/delete_faq/'+_id,
            success : function(_data) {
                if (! _data) {
                    $(_this).parent().parent().remove();
                } 
                else {
                    alert('삭제 할 수 없습니다.');
                }
            }
        });
    }
}

function serch_member() {
    if ($('input[name=q]').length < 1) {
        alert('검색어를 입력해주세요.');
        return false;
    }
    $('form[name=f_search] .btn-primary').hide();
    var frm = $('form[name=f_search]');
    var set_data = frm.serialize();
    var post_url = "/ajax_v2/search_member/";
    $.ajax({
        type : 'POST',
        url : post_url,
        data : set_data,
        success : function(_data) {
            $('.modal .table-striped').html(_data);
        }
    });
}

function this_select(_this, _id) {
    $('input[name=user_id]').val(_id);
    box = $(_this).parent().parent();
    box.find('.td-checkin').remove();
    // console.log(box);
    $('.well tbody').html(box);
    $('.modal').modal('hide');
}

function del_qna_cat(_this, _id, _type) {
    var r = confirm("정말 삭제하시겠습니까?");
    
    if (r == true) {
        var post_url = "/ajax_v2/del_qna_category/"+_id+"/"+_type;
        $.ajax({
            type : 'POST',
            url : post_url,
            success : function(_data) {
                if ( ! _data) {
                    $(_this).parent().parent().slideUp();    
                }
                else {
                    alert("삭제할 수 없습니다.");
                }
            }
        });
    }
}

function send_ch_cat(_this, _id) {
    
    $(_this).attr("disabled", "disabled");
    _cat = $("select[name=category] option:selected").val();
    var post_url = "/ajax_v2/change_cat_qna/"+_id+"/"+_cat;
    $.ajax({
        type : 'POST',
        url : post_url,
        success : function(_data) {
            if ( ! _data) {
                alert("담당자가 변경되었습니다.");
                window.location.reload();    
            }
            else {
                alert("변경할 수 없습니다.");
            }
            $(_this).removeAttr("disabled");
        }
    });
  
}

function del_newslt(_id, _this) {
    var r = confirm("정말 삭제하시겠습니까?");
    
    if (r == true) {
        var _url = "/ajax_v2/del_newsletter/"+_id;
        $.ajax({
            type : 'GET',
            url : _url,
            success : function(_data) {
                if ( ! _data) {
                    alert("삭제되었습니다.");
                    $(_this).parent().parent().slideUp();    
                }
                else {
                    alert("삭제할 수 없습니다.");
                }
            }
        });
    }
}

// competition or challenge
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