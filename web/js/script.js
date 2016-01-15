// ++++++++++++++++++++++++++++++++++++++++++
//
// NOTICE!! DO NOT USE ANY OF THIS JAVASCRIPT
//
// Only Script for D.CAMP - ADMIN 
//
// ++++++++++++++++++++++++++++++++++++++++++

function alert(_msg) {
    $('#md-alert p').html(_msg);
    $('#md-alert').modal('show');
}

function del_confirm(_fuc) {
    _msg = "정말 삭제하시겠습니까?<br> 아래의 [삭제]를 클릭하시면 해당 내용은 완전히 삭제됩니다.</p>";
    $('#md-warning p').html('<strong><span class="icon-warning-sign"></span></strong>'+_msg);
    $('#md-warning .btn-danger').attr('onclick', _fuc);
    $('#md-warning').modal('show');
}

function msg_confirm(_fuc, _msg) {
    $('#md-warning .btn-danger').attr('onclick', _fuc);
    $('#md-warning p').html('<strong><span class="icon-warning-sign"></span></strong>'+_msg);
    $('#md-warning').modal('show');
}

function msg_confirm_cm(_fuc, _msg) {
    $('#md-warning-cm .btn-default').attr('onclick', _fuc);
    $('#md-warning-cm p').html('<strong><span class="icon-warning-sign"></span></strong>'+_msg);
    $('#md-warning-cm').modal('show');
}

function msg_confirm_yesno(_fuc, _msg, _fuc2) {
    $('#md-warning .btn-danger').attr('onclick', _fuc);
    $('#md-warning .btn-default').attr('onclick', _fuc2);
    $('#md-warning p').html('<strong><span class="icon-warning-sign"></span></strong>'+_msg);
    $('#md-warning').modal('show');
}

function ignoreEnter(event)
{
  if (event.keyCode === 13) {
    return false;
    $(this).adds
  }
}

function add_follow(_this, _f1, _f2, _type, _del) {
    var get_url = '/ajax_front/add_follow/';
    var set_data ={
        "follower" 		: _f1,
        "following" 		: _f2,
        "type"                  : _type,
        "del"                   : _del
    };
    $(_this).attr('disabled', 'disabled');
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {

            if (!_data.error) {
                if (!_del) {
                    $(_this).removeClass('btn-default');
                    $(_this).removeClass('follow');
                    $(_this).addClass('following');
                    $(_this).attr('onclick', 'add_follow(this, '+_f1+', '+_f2+', 1, 1); return false;');
                    $(_this).html('Following');
                } else {
                    $(_this).removeClass('following');
                    $(_this).addClass('btn-default');
                    $(_this).addClass('follow');
                    $(_this).attr('onclick', 'add_follow(this, '+_f1+', '+_f2+', 1); return false;');
                    $(_this).html('Follow');
                }
            }
            $(_this).removeAttr('disabled');
        }
    });
}

function add_follow_p(_this, _f1, _f2, _type, _del) {
    var get_url = '/ajax_front/add_follow/';
    var set_data ={
        "follower"      : _f1,
        "following"         : _f2,
        "type"                  : _type,
        "del"                   : _del
    };
    $(_this).attr('disabled', 'disabled');
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {

            if (!_data.error) {
                if (!_del) {
                    $(_this).removeClass('btn-follow');
                    $(_this).addClass('btn-following');
                    $(_this).attr('onclick', 'add_follow_p(this, '+_f1+', '+_f2+', 1, 1); return false;');
                    $(_this).html('Following');
                    $(_this).parent().next().find('.badge').html(parseInt($(_this).parent().next().find('.badge').html()) + 1);

                } else {
                    $(_this).removeClass('btn-following');
                    $(_this).addClass('btn-follow');
                    $(_this).attr('onclick', 'add_follow_p(this, '+_f1+', '+_f2+', 1); return false;');
                    $(_this).html('<span class="glyphicon glyphicon-plus"></span>Follow');
                    $(_this).parent().next().find('.badge').html(parseInt($(_this).parent().next().find('.badge').html()) - 1);
                }
            }
            $(_this).removeAttr('disabled');
        }
    });
}

function toggle_pn(_this){
    $(_this).parent().next().slideToggle();
}

function toggle_pppp(_this){
    $(_this).parent().parent().parent().parent().slideToggle();
}

function toggle_ppn(_this){
    $(_this).parent().parent().next().slideToggle();
}

function toggle_ppp(_this){
    $(_this).parent().parent().parent().slideToggle();
}

function toggle_p(_this){
    $(_this).parent().slideToggle();
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

!function ($) {
$(function () {
    
    $(".ellipsis").dotdotdot({
        height           : 80
    });

    //follow toggle @url: www.techumber.com
    $('.following').hover(function(){
      $(this).text("Unfollow");
        },function(){
           $(this).text("Following");
    });

    // tooltip
    $('.container').tooltip({
      selector: "[data-toggle=tooltip]",
      container: "body"
        })
      
    //selectpicker
    $('.selectpicker').selectpicker();
    
    
    $('body').scrollspy({ target: '.navbar-scrollspy' })

    
    //
    $(function () {
        $('#followTab a:first').tab('show')
        })

    $.datepicker.regional['ko'] = { // Default regional settings
        closeText: '닫기',
        prevText: '이전달',
        nextText: '다음달',
        currentText: '오늘',
        monthNames: ['1월(JAN)','2월(FEB)','3월(MAR)','4월(APR)','5월(MAY)','6월(JUN)',
        '7월(JUL)','8월(AUG)','9월(SEP)','10월(OCT)','11월(NOV)','12월(DEC)'],
        monthNamesShort: ['1월','2월','3월','4월','5월','6월',
        '7월','8월','9월','10월','11월','12월'],
        dayNames: ['일','월','화','수','목','금','토'],
        dayNamesShort: ['일','월','화','수','목','금','토'],
        dayNamesMin: ['일','월','화','수','목','금','토'],
        changeMonth: true, 
        changeYear: true,
        weekHeader: 'Wk',
        dateFormat: 'yy.mm.dd', // [mm/dd/yy], [yy-mm-dd], [d M, y], [DD, d MM]
        firstDay: 0,
        isRTL: false,
        showMonthAfterYear: true,
        yearSuffix: '',
        yearRange : 'c-100:c+10'};

    $.datepicker.setDefaults($.datepicker.regional['ko']);

    //suffle    
//    var $grid = $('#grid'),
//        $filterOptions = $('.filter-options div'),
//        $sizer = $grid.find('.shuffle_sizer');
//    
//    // Set up button clicks
//    var $btns = $filterOptions.children();
//    $btns.on('click', function() {
//      var $this = $(this),
//      isActive = $this.hasClass( 'active' ),
//      group = isActive ? 'all' : $this.data('group');
//
//      // Hide current label, show current label in title
//      if ( !isActive ) {
//        $('.filter-options .active').removeClass('active');
//      }
//
//      $this.toggleClass('active');
//
//      // Filter elements
//      $grid.shuffle( 'shuffle', group );
//    });

    // Advanced filtering
//    $('.js-shuffle-search').on('keyup change', function() {
//      var val = this.value.toLowerCase();
//      $grid.shuffle('shuffle', function($el, shuffle) {
//
//        // Only search elements in the current group
//        if (shuffle.group !== 'all' && $.inArray(shuffle.group, $el.data('groups')) === -1) {
//          return false;
//        }
//
//        var text = $.trim( $el.find('.picture-item__title').text() ).toLowerCase();
//        return text.indexOf(val) !== -1;
//      });
//    });


    
        
    });
    
}(window.jQuery)


