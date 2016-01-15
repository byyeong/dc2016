<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>D.CAMP</title>

    {? og}
    <meta property="fb:admins" content="504444819"/>
    <meta property="og:type" content="{?og.type}{og.type}{:}website{/}"/>
    <meta property="og:url" content="{og.url}"/>
    <meta property="og:title" content="{og.title}"/>
    <meta property="og:description" content="{og.description}"/>
    {?og.image}<meta property="og:image" content="{og.image}"/>{/}
    <meta property="og:site_name" content="D.CAMP - 은행권청년창업재단이 운영하는 대한민국 최초의 복합 창업 생태계 허브"/>
    {/}

    <link rel="shortcut icon" href="http://dcamp.kr/images/favicon.ico" type="image/x-icon" />
    <link rel="icon" href="http://dcamp.kr/images/favicon.ico" type="image/x-icon" />

    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css" />  
    <link rel="stylesheet" href="/css/dcamp-profile.css?20150116"> 
    {? con=='startup'}<link rel="stylesheet" href="/css/dcamp-startup.css?20150113">{/}
    <link rel="stylesheet" href="/font-awesome/css/font-awesome.css?20150113">
    <link rel="stylesheet" href="/css/bootstrap-select.min.css" >
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" >  
    <link rel="stylesheet" href="https://gitcdn.github.io/bootstrap-toggle/2.1.0/css/bootstrap-toggle.min.css" > 
    <link rel="stylesheet" href="/css/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />



    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>  
    <script src="/js/bootstrap-select.min.js"></script>
    <script src="/js/jquery.dotdotdot.js"></script>
    <script src="/js/front.js?20150113"></script>
    <script src="/js/script.js?20150113"></script>
    <script src="/js/common.js?20150113"></script>
    <script src="/js/jquery.prettyPhoto.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery.liveurl.js"> </script>
    <script src="/js/jquery.dotdotdot.js"></script>
    <script src="/js/jquery.ellipsis.js"></script>
    <script src="/js/dcmap-lounge.js"></script>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
    <script src="https://gitcdn.github.io/bootstrap-toggle/2.1.0/js/bootstrap-toggle.min.js"></script>
    <script>
    $(function() {
        $('[data-toggle="tooltip"]').tooltip()
        $( ".datepicker" ).datepicker();
    });

    function get_follow(_type, _id, _opt)
    {
        var get_url = '/ajax_front/get_follow/'+_type+'/'+_id+'/'+_opt;
        $.get(get_url, function(_data) {
            $('#mdl-follower').html('');
            $('#mdl-follower').html(_data);
            $('#mdl-follower').modal('show');
        });
    }
    </script>

    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script>(function(d, s, id) {
      var js, fjs = d.getElementsByTagName(s)[0];
      if (d.getElementById(id)) return;
      js = d.createElement(s); js.id = id;
      js.src = "//connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v2.3&appId=190453334472223";
      fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));</script>
    <!-- Facebook Pixel Code -->
    <script>
        !function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;
n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,
                document,'script','//connect.facebook.net/en_US/fbevents.js');

        fbq('init', '985124991550434');
        fbq('track', "PageView");
    </script>
    <noscript><img height="1" width="1" style="display:none"
                   src="https://www.facebook.com/tr?id=985124991550434&ev=PageView&noscript=1"
                /></noscript>
    <!-- End Facebook Pixel Code -->
    <script src="/js/facebook-fixel-code.js"></script>
</head>

<body>
    <div id="fb-root"></div>
    <!-- modal #md-warning -->
    <div class="modal fade" id="md-warning" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="z-index: 1050;">
        <div class="modal-dialog">
            <div class="modal-content"> 
                <div class="modal-body">
                    <div class="alert alert-warning text-center">                 
                     <p><strong><span class="icon-warning-sign"></span></strong>정말 삭제하시겠습니까?<br> 아래의 [삭제]를 클릭하시면 해당 내용은 완전히 삭제됩니다.</p>
                     <button class="btn btn-default btn-sm" data-dismiss="modal">취소</button>
                     <button class="btn btn-danger btn-sm">확인</button>                
                     </div>
                </div>
                <!-- /modal-body -->
            </div>
            <!-- /.modal-content --> 
        </div>
        <!-- /.modal-dialog --> 
    </div>
    <!-- /modal #md-warning -->

    <!-- modal #md-alert -->
    <div class="modal fade" id="md-alert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="z-index: 1050;">
        <div class="modal-dialog">
            <div class="modal-content"> 
                <div class="modal-body">
                    <div class="well text-center">                 
                     <p>수정했습니다.</p>
                     <button class="btn btn-primary btn-sm" data-dismiss="modal">확인</button>               
                     </div>
                </div>
                <!-- /modal-body -->
            </div>
            <!-- /.modal-content --> 
        </div>
        <!-- /.modal-dialog --> 
    </div>
    <!-- /modal #md-alert -->

    <!-- Modal:mdl-follower -->
    <div class="modal fade" id="mdl-follower" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="z-index: 1050;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Following <span class="badge">49586 </span></h4>
                </div>
                <div class="modal-body">
                <!-- Start modal content -->
                   
                    <ul class="list-inline list-users">
                        <li>-</li>
                    </ul>

                <!-- Start modal content -->
                </div> 
            </div>
        </div>
    </div>

    <!-- wrapper -->
    <div class="wrapper" id="wrapper">
        <!-- navbar -->
        <nav class="navbar navbar-default" role="navigation">
            <div class="container-fluid">  
                
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="/"><img src="/img/logo.png" alt="D.CAMP" class="img-responsive"></a> 
                </div>
                <!-- /navbar-header -->
                
                <div class="collapse navbar-collapse" id="navbar-collapse"> 
                    {? ! s.id}
                    <ul class="nav navbar-nav navbar-right" id="signoff">
                        <li class="gosignin">
                            <a href="/login">
                                <span class="fa-stack fa-lg">
                                    <i class="fa fa-circle fa-stack-2x"></i>
                                    <i class="fa fa-facebook fa-stack-1x fa-inverse"></i>
                                </span> 
                                로그인
                            </a>
                        </li>
                        <li class="gosignup">
                            <a href="/signup">
                                회원가입
                            </a>
                        </li>
                    </ul>
                    {:}
                    <ul class="nav navbar-nav navbar-right" id="signon">
                        <li class="userbell">
                            <a href="/member/activity">
                                <span class="fa fa-fw fa-bell"></span><span class="sr-only"> 액티비티</span> 
                            </a> 
                        </li>
                        <li class="signUser dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false" title="{s.name}">
                                <img src="{?s.picture}{s.picture}{? ! strpos(s.picture, '?')}?date={=date('his')}{/}{:}/img/default-img-member.png{/}" class="img-circle">
                                <span class="sr-only">사용자이름</span>
                            </a>
                            <ul class="dropdown-menu" role="menu">
                                <li style="border-bottom: 1px dashed #ddd;">
                                    <a href="/member/{s.ids}"><span class="fa fa-fw fa-user"></span> 내 프로필 보기</a>
                                </li>
                                {? s.con}<li style="border-bottom: 1px dashed #ddd;" ><a href="/contents/edit"><span class="fa fa-fw fa-file-text"></span> Blog 글쓰기</a></li>{/}
                                {? s.mento}<li style="border-bottom: 1px dashed #ddd;"><a href="/office_hours/m_list"><span class="fa fa-fw fa-file-text"></span> Office Hours 관리</a></li>{/}
                                {? s.rep1}
                                <li style="border-bottom: 1px dashed #ddd;"><a href="/member/edit_rsv1"> <span class="fa fa-fw fa-file-text"></span> 공간공유 예약 관리</a></li>
                                {/}
                                {? s.rep2}
                                <li style="border-bottom: 1px dashed #ddd;"><a href="/member/edit_rsv2"> <span class="fa fa-fw fa-file-text"></span> 디자인라운지 예약 관리</a></li>
                                {/}
                                {? s.con}<li><a href="/member/edit_contents"> 콘텐츠관리</a></li>{/}
                                <li><a href="/member/edit_event"> 이벤트관리</a></li>
                                {? (s.per & settings->permission2) == settings->permission2 || (s.per & settings->permission1) == settings->permission1}<li><a href="/member/edit_space"> Reservation 내역</a></li>{/}
                                <li><a href="/member/edit_challenge_m"> Challenge 관리</a></li>
                                <li><a href="/member/edit_office"> Office Hours 내역</a></li>
                                <li><a href="/member/edit_benefit_m"> Benefits 관리</a></li>
                                <li><a href="/member/edit_showcase"> Showcase 관리</a></li>
                                <li><a href="/member/edit_reference"> 레퍼런스 내역</a></li>
                                <li><a href="/member/edit"> 개인정보 수정</a></li>
                                <li style="border-top: 1px dashed #ddd;"><a href="/logout"> <span class="fa fa-fw fa-sign-out"></span> 로그아웃</a></li>
                                {? (s.per & settings->permission1) == settings->permission1}<li style="border-top: 1px dashed #ddd;"><a href="/admin"><span class="icon-cog"></span> 관리자</a></li>{/}
                                {? (s.per & settings->permission5) == settings->permission5}<li style="border-top: 1px dashed #ddd;"><a href="/admin_entrance"><span class="fa fa-fw fa-cog"></span> 관리자</a></li>{/}
                            </ul>
                        </li>
                    </ul>
                    {/}
                </div>
                <!-- /navbar-collapse -->

            </div> 
        </nav>
        <!-- /navbar -->


        {contents_for_layout}


        <!-- #footer -->
        <footer id="footer">
            <div class="container">
                 Copyright © D.CAMP. All rights reserved. <a href="http://www.podio.com" target="_blank">Thanks to Podio we keep work simple.</a>
            </div>
        </footer>
        <!-- /#footer -->

    <!-- /Modal:mdl-follower -->
    </div>
    <!-- /wrapper -->

<script type="text/javascript"> 
//<![CDAT
{? msg}
alert('{msg}');
{/}

function clicked() {
    var div=$(this).closest('.ellipsis')
    div.height('auto').trigger('destroy').find('.readmore').remove()
    return false
}

function hideLinkIfNoTruncation(isTruncated, origContent) {
    if (!isTruncated) {
        $('.readmore',this).remove()
    } 
}

$(document).ready(function(){
    $("a[rel^='prettyPhoto']").prettyPhoto({social_tools: false});
});

function open_com(_this) {
    $(_this).parent().next().next().find('.form-edit-set').slideToggle();
    $(_this).parent().next().next().find('textarea').focus();
} 

function submit_comment(_this, _opt){
    var frm = $('form[name=tl_form]');
    if ($(_this).parent().parent().find('textarea[name=contents]').val().length < 1) {
        alert('내용을 입력해주세요.');
        return false;
    }

    $(_this).hide();
    if ($(_this).parent().parent().find('.liveurl').css('display') == 'block') {
        $(_this).parent().parent().find('button.close.delete').remove();
        var _sub = $('#sub').html();
        $('input[name=sub]').val(_sub);
    }

    var get_url = '/ajax_front/add_timeline';
    var set_data = frm.serialize();
    _type = $('input[name=p_type]').val();
    _pid = $('input[name=p_id]').val();
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {

            if (_opt == 1) {
                get_timeline(_type, _pid, 1);
            } else {
                get_timeline_w(_type, _pid, 1);
            }
            $(_this).show();
        }
    });
}

function submit_comment_up(_this, _opt, _public){
    var frm = $('form[name=tl_form]');
    if ($(_this).parent().parent().find('textarea[name=contents]').val().length < 1) {
        alert('내용을 입력해주세요.');
        return false;
    }

    if ($('input[name=fb]').is(':checked') == true && _public == 0) {
        var popUrl = '/fb/1?';
        var popOption = "width=1000, height=600, resizable=no, scrollbars=no, status=no;";
        window.open(popUrl,"",popOption);
    }
    else {
        $(_this).hide();
        if ($(_this).parent().parent().find('.liveurl').css('display') == 'block') {
            $(_this).parent().parent().find('button.close.delete').remove();
            var _sub = $('#sub').html();
            $('input[name=sub]').val(_sub);
        }

        var get_url = '/ajax_front/add_timeline';
        var set_data = frm.serialize();
        _type = $('input[name=p_type]').val();
        _pid = $('input[name=p_id]').val();
        $.ajax({
            type : 'POST',
            url : get_url,
            data : set_data,
            dataType : 'json',
            success : function(_data) {

                if (_opt == 1) {
                    get_timeline(_type, _pid, 1);
                } else {
                    get_timeline_w(_type, _pid, 1);
                }
                $(_this).show();
            }
        });
    }
}

function submit_p_form2() 
{
    var frm = $('form[name=tl_form]');

    $('form[name=tl_form] .btn-primary').hide();
    if ($('form[name=tl_form] .btn-primary').parent().parent().find('.liveurl').css('display') == 'block') {
        $('form[name=tl_form] .btn-primary').parent().parent().find('button.close.delete').remove();
        var _sub = $('#sub').html();
        $('input[name=sub]').val(_sub);
    }

    var get_url = '/ajax_front/add_timeline';
    var set_data = frm.serialize();
    _type = $('input[name=p_type]').val();
    _pid = $('input[name=p_id]').val();
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            get_timeline(_type, _pid, 1);
            $('form[name=tl_form] .btn-primary').show();
        }
    });
}

function submit_c_coment(_this, _id){
    var frm = $('form[name=tl_c_form_'+_id+']');
    if ($(_this).parent().parent().find('textarea[name=contents]').val().length < 1) {
        alert('내용을 입력해주세요.');
        return false;
    }
    $(_this).hide();
    var get_url = '/ajax_front/add_timeline_comm_p';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {
            $(_this).parent().parent().find('textarea').val("");
            $(_this).parent().parent().parent().parent().parent().before(_data);
            $(_this).show();
        }
    });
}

function close_form(_this) {
    $(_this).parent().parent().parent().parent().slideToggle();
}

function del_comm(_id, _is_com)
{
    del_confirm('del_comm2('+_id+', '+_is_com+')');
}

function del_comm2( _id, _is_com)
{
    var get_url = '/ajax_front/del_com/'+_id+'/'+_is_com;
    $.get(get_url, function(_data) {
        
        if (_is_com) {
            $('#com_'+_id).parent().remove();
        } else {
            $('#com_'+_id).remove();
            
            $('#com_'+_id).remove();
        }
        $('#md-warning').modal('hide');
    });

}

function more_tl(_this, _type, _pid, _opt) {
    var p = $('#page').val();
    var next = parseInt(p) + 1;
    var get_url = "/ajax_front/more_timeline_p/"+_type+"/"+_pid+"/"+_opt+"/"+next;
    $(_this).hide();
    $.get(get_url, function(_data) {
        if (_data !== '') {
            $('#page').val(next);
            $(_this).parent().prev().append(_data);
            $(_this).show();
        } else {
            // $(_this).parent().remove();
            alert("마지막 페이지입니다.");
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
                alert(error_str);
            }
            else {
                $(_this).prev().attr("src", data.img);
                $('input[name=image]').val(data.img);
            }
          }
    });
}

function close_sub(_this)
{
    $(_this).parent().parent().parent().parent().html('');
}

//]]>
</script> 

<script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-45121809-1', 'dcamp.kr');
ga('send', 'pageview');

</script>
</body>
</html>