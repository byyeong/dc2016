<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>D.CAMP - Manage</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<link rel="shortcut icon" href="http://dcamp.kr/images/favicon.ico" type="image/x-icon" />
<link rel="icon" href="http://dcamp.kr/images/favicon.ico" type="image/x-icon" />

<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->

<!-- stylesheet -->
<link rel="stylesheet" href="/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/bootstrap-formhelpers.css">
<link rel="stylesheet" href="/css/bootstrap-select.min.css" >
<link rel="stylesheet" href="/css/jquery.timepicker.css" >
<link rel="stylesheet" href="/font-awesome/css/font-awesome.css" >
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
<!--[if IE 7]>
<link rel="stylesheet" href="/font-awesome/css/font-awesome-ie7.min.css">
<![endif]-->
<link rel="stylesheet" href="/css/admin.css">

<!-- custom scrollbar stylesheet -->
<link rel="stylesheet" href="/css/jquery.mCustomScrollbar.css">

<!-- Javascript  -->
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript" src="/js/bootstrap.js"></script>
<script src="/js/holder.js"></script>
<!--
<script src="/js/bootstrap-formhelpers-datepicker.language.js"></script>
<script src="/js/bootstrap-formhelpers-datepicker.js"></script>
//-->
<script type="text/javascript" src="/js/jquery.timepicker.js"></script>
<script type="text/javascript" src="/js/bootstrap-formhelpers-timepicker.js"></script>
<script type="text/javascript" src="/js/bootstrap-select.min.js"></script>
<script type="text/javascript" src="/js/admin.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
{? gnb == "office"}
<script type="text/javascript" src="/js/admin_office.js"></script>
{/}

<script>
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
        dateFormat: 'yy-mm-dd', // [mm/dd/yy], [yy-mm-dd], [d M, y], [DD, d MM]
        firstDay: 0,
        isRTL: false,
        showMonthAfterYear: true,
        yearSuffix: '',
        yearRange : 'c-100:c+10'};

    $.datepicker.setDefaults($.datepicker.regional['ko']);
    
    $(function() {
        $( ".datepicker" ).datepicker({ dateFormat: 'yy-mm-dd',  viewMode: 2 });
        $(".timepicker").timepicker({ 'timeFormat': 'H:i' });
    });
    
    function ignoreEnter(event)
    {
      if (event.keyCode === 13) {
        return false;
      }
    }

    function submit_dashboard()
    {
        document.term_f.submit();
    }
</script>
                        
</head>

<body>
    <!-- modal #md-warning -->
    <div class="modal fade" id="md-warning" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content"> 
                <div class="modal-body">
                    <div class="alert alert-warning text-center">                 
                     <p><strong><span class="icon-warning-sign"></span></strong>정말 삭제하시겠습니까?<br> 아래의 [삭제]를 클릭하시면 해당 내용은 완전히 삭제됩니다.</p>
                     <button class="btn btn-default btn-sm" data-dismiss="modal" class="close" >취소</button>
                     <button class="btn btn-danger btn-sm">삭제</button>                
                     </div>
                </div>
                <!-- /modal-body -->
            </div>
            <!-- /.modal-content --> 
        </div>
        <!-- /.modal-dialog --> 
    </div>
    <!-- /modal #md-warning -->
    
    <header class="header">
        <nav class="navbar navbar-inverse" role="navigation">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <a class="navbar-brand" href="/"><img src="/img/logo.png"> D.CAMP</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <ul class="nav navbar-nav">
            { ? (s.per & settings->permission1) == settings->permission1 }
                <li class="active"><a href="/admin"><span class="icon-cog"></span> 대시보드</a></li>
                <li { ?gnb == "member"}class="active"{ /}><a href="/admin_member">회원관리</a></li>
                <li { ?gnb == "membership"}class="active"{/ }><a href="/admin_membership">멤버십관리</a></li>
                <li { ?gnb == "startup"}class="active"{ /}><a href="/admin_startup">스타트업관리</a></li>
                <li { ?gnb == "recruit"}class="active"{ /}><a href="/admin_recruit">채용정보관리</a></li>
                <li { ?gnb == "space"}class="active"{ /}><a href="/admin_space">Reservation관리</a></li>
                <li { ?gnb == "event"}class="active"{ /}><a href="/admin_event">이벤트관리</a></li>
                <li { ?gnb == "notice" }class="active"{ / }><a href="/admin_notice">공지사항관리</a></li>
                <li { ?gnb == "main" }class="active"{ /}><a href="/admin_main">메인콘텐츠관리</a></li>
                <li { ?gnb == "contents"}class="active"{ /}><a href="/admin_contents">Blog관리</a></li>
                <li { ?gnb == "challenge"}class="active"{ /}><a href="/admin_challenge">Challenge관리 </a></li>
                <li { ?gnb == "office"}class="active"{ /}><a href="/admin_office">Office Hours관리</a></li>
                <li { ?gnb == "program"}class="active"{ /}><a href="/admin_program">Benefits관리 </a></li>
                <li { ?gnb == "showcase"}class="active"{ /}><a href="/admin_showcase"> Showcase관리 </a></li>
                <li class="dropdown { ?gnb == "entrance" || gnb == "locker"}active{/ }">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">기타관리 <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                      <li><a href="/admin_entrance">출입관리</a></li>
                      <li><a href="/admin_entrance/monthly_locker">월간 사물함 배정</a></li>
                      <li><a href="/admin_newsletter/">뉴스레터 목록</a></li>
                      <li><a href="/admin_manage/">FAQ</a></li>
                      <li><a href="/admin_manage/qna">Q&A</a></li>
                    </ul>
                </li>
                { /}
                { ? (s.per & settings->permission5) == settings->permission5}
                <li { ?gnb == "member"}class="active"{ /}><a href="/admin_member">회원관리</a></li>
                <li { ?gnb == "space"}class="active"{ /}><a href="/admin_space">공간공유관리</a></li>
                <li class="dropdown { ?gnb == "entrance" || gnb == "locker"}active{/ }">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">기타관리 <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                      <li><a href="/admin_entrance">출입관리</a></li>
                      <li><a href="/admin_entrance/monthly_locker">월간 사물함 배정</a></li>
                      <li><a href="/admin_newsletter/">뉴스레터 목록</a></li>
                    </ul>
                </li>
                {/ }
                <!--<li { ?gnb == "analytics"}class="active"{/ }><a href="/admin_analytics">통계분석</a></li>//-->
            </ul>
        </nav>
    </header>

    <section class="contentSector">
        <!-- jumbotron -->
        <div class="jumbotron">
            <div class="container">
                <h1>대시보드</h1>
            </div>
        </div>
        <!-- /jumbotron -->

        <!-- container -->
        <div class="rowContainer">
            <div class="container" id="dashboard">

                <!-- current-state -->
                <div class="current-state row">
                    <div class="col-xs-12 select-period">
                        <div class="pull-left">
                          <a class="btn btn-default { ? !terms}active{/ }" href="/admin">전체</a>
                          <a class="btn btn-default { ? terms == 1}active{/ }" href="/admin?terms=1">최근 1주</a>
                          <a class="btn btn-default { ? terms == 2}active{/ }" href="/admin?terms=2">최근 한 달</a>
                        </div>
                        <form method="post" action="/admin" name="term_f">
                            <div class="pull-right">
                          캘린더 조회 :

                              <!-- datepicker -->
                              <div class="bfh-datepicker" data-format="y.m.d">
                                  <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                      <input type="text" class="form-control datepicker" name="start" value="{ start}" readonly>
                                  </div>
                                  <div class="bfh-datepicker-calendar">
                                      <table class="calendar table table-bordered">
                                          <thead>
                                              <tr class="months-header">
                                                  <th class="month" colspan="4">
                                                      <a class="previous" href="#"><span class="icon-chevron-left"></span></a>
                                                      <span></span>
                                                      <a class="next" href="#"><span class="icon-chevron-right"></span></a>
                                                   </th>
                                                  <th class="year" colspan="3">
                                                      <a class="previous" href="#"><span class="icon-chevron-left"></span></a>
                                                      <span></span>
                                                      <a class="next" href="#"><span class="icon-chevron-right"></span></a>
                                                  </th>
                                              </tr>
                                              <tr class="days-header"> </tr>
                                          </thead>
                                          <tbody>
                                          </tbody>
                                      </table>
                                  </div>
                              </div>
                              <!-- /datepicker -->
                              <span class="sim">&sim;</span>
                              <!-- datepicker -->
                              <div class="bfh-datepicker" data-format="y.m.d">
                                  <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                      <input type="text" class="form-control datepicker" name="end" value="{ =substr(end,0,10)}" readonly>
                                  </div>
                                  <div class="bfh-datepicker-calendar">
                                      <table class="calendar table table-bordered">
                                          <thead>
                                              <tr class="months-header">
                                                  <th class="month" colspan="4">
                                                      <a class="previous" href="#"><span class="icon-chevron-left"></span></a>
                                                      <span></span>
                                                      <a class="next" href="#"><span class="icon-chevron-right"></span></a>
                                                   </th>
                                                  <th class="year" colspan="3">
                                                      <a class="previous" href="#"><span class="icon-chevron-left"></span></a>
                                                      <span></span>
                                                      <a class="next" href="#"><span class="icon-chevron-right"></span></a>
                                                  </th>
                                              </tr>
                                              <tr class="days-header"> </tr>
                                          </thead>
                                          <tbody>
                                          </tbody>
                                      </table>
                                  </div>
                              </div>
                              <!-- /datepicker -->
                              <button class="btn btn-default" onclick="submit_dashboard(); return false;">확인</button>
                              <input type="hidden" name="terms" value="3">

                            </div>
                        </form>
                    </div>

                    <!-- Start Page Cotents -->
                    <div class="col-xs-12 col-sm-3 col-md-3 item current">
                        <div class="inner">
                            <h3><a href="/admin_member"><span class="glyphicon glyphicon-play-circle"></span> 전체회원</a></h3>
                            <ul class="list-unstyled">
                                <li><a href="/admin_member?search=&sort=state&order=1&grade_t=&grade_e=&type=utype&type_e="><span class="text">승인</span> <span class="badge badge-success">{ u.u_1}</span></a></li>
                                <li><a href="/admin_member?search=&sort=state&order=0&grade_t=&grade_e=&type=utype&type_e="><span class="text">대기</span> <span class="badge badge-primary">{ u.u_0}</span></a></li>
                                <li><a href="/admin_member?search=&sort=state&order=2&grade_t=&grade_e=&type=utype&type_e="><span class="text">반려</span> <span class="badge badge-warning">{ u.u_2}</span></a></li>
                                <li><a href="/admin_member?search=&sort=state&order=3&grade_t=&grade_e=&type=utype&type_e="><span class="text">탈퇴</span> <span class="badge">{ u.u_3}</span></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-3 col-md-3 item current">
                        <div class="inner">
                            <h3><a href="/admin_membership"><span class="glyphicon glyphicon-play-circle"></span> 멤버십 관리</a></h3>
                            <ul class="list-unstyled">
                                <li><a href="/admin_membership?sort=r.state&order=1"><span class="text">승인</span> <span class="badge badge-success">{ m.s_1}</span></a></li>
                                <li><a href="/admin_membership?sort=r.state&order=0"><span class="text">대기</span> <span class="badge badge-primary">{ m.s_0}</span></a></li>
                                <li><a href="/admin_membership?sort=r.state&order=2"><span class="text">반려</span> <span class="badge badge-warning">{ m.s_2}</span></a></li>
                                <li><a href="/admin_membership?sort=r.state&order=3"><span class="text">탈퇴</span> <span class="badge">{ m.s_3}</span></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-3 col-md-3 item current">
                        <div class="inner">
                            <h3><a href="/admin_startup"><span class="glyphicon glyphicon-play-circle"></span> 스타트업</a></h3>
                            <ul class="list-unstyled">
                                <li><a href="/admin_startup?search=&sort=state&order=1"><span class="text">승인</span> <span class="badge badge-success">{ co.s_1}</span></a></li>
                                <li><a href="/admin_startup?search=&sort=state&order=0"><span class="text">대기</span> <span class="badge badge-primary">{ co.s_0}</span></a></li>
                                <li><a href="/admin_startup?search=&sort=state&order=2"><span class="text">비공개</span> <span class="badge badge-warning">{ co.s_2}</span></a></li>
                            </ul>

                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-3 col-md-3 item current">
                        <div class="inner">
                            <h3><a href="/admin_startup"><span class="glyphicon glyphicon-play-circle"></span> 채용정보</a></h3>
                            <ul class="list-unstyled">
                                <li><a href="/admin_recruit?search=&sort=state&order=1"><span class="text">승인</span> <span class="badge badge-success">{ re.s_1}</span></a></li>
                                <li><a href="/admin_recruit?search=&sort=state&order=0"><span class="text">대기</span> <span class="badge badge-primary">{ re.s_0}</span></a></li>
                                <li><a href="/admin_recruit?search=&sort=state&order=2"><span class="text">반려</span> <span class="badge badge-warning">{ re.s_2}</span></a></li>
                            </ul>

                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-3 col-md-3 item current">
                        <div class="inner">
                            <h3><a href="/admin_space"><span class="glyphicon glyphicon-play-circle"></span> Reservation</a></h3>
                            <ul class="list-unstyled">
                                <li><a href="/admin_space/1?type=&sort=state&order=1&order_t=&order_e=DESC"><span class="text">승인</span> <span class="badge badge-success">{ ss.s_1}</span></a></li>
                                <li><a href="/admin_space/1?type=&sort=state&order=0&order_t=&order_e=DESC"><span class="text">대기</span> <span class="badge badge-primary">{ ss.s_0}</span></a></li>
                                <li><a href="/admin_space/1?type=&sort=state&order=2&order_t=&order_e=DESC"><span class="text">반려</span> <span class="badge badge-warning">{ ss.s_2}</span></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-3 col-md-3 item current">
                        <div class="inner">
                            <h3><a href="/admin_event"><span class="glyphicon glyphicon-play-circle"></span> 이벤트</a></h3>
                            <ul class="list-unstyled">
                                <li><a href="/admin_event?search=&order_t=&order_e=DESC&sort=state&order=1"><span class="text">승인</span> <span class="badge badge-success">{ e.s_1}</span></a></li>
                                <li><a href="/admin_event?search=&order_t=&order_e=DESC&sort=state&order=0"><span class="text">대기</span> <span class="badge badge-primary">{ e.s_0}</span></a></li>
                                <li><a href="/admin_event?search=&order_t=&order_e=DESC&sort=state&order=2"><span class="text">반려</span> <span class="badge badge-warning">{ e.s_2}</span></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-3 col-md-3 item current">
                        <div class="inner">
                            <h3><a href="/admin_contents"><span class="glyphicon glyphicon-play-circle"></span> Blog</a></h3>
                            <ul class="list-unstyled">
                                <li><a href="/admin_contents?sort=c.state&order=1"><span class="text">승인</span> <span class="badge badge-info">{ con.s_1}</span></a></li>
                                <li><a href="/admin_contents?sort=c.state&order=0"><span class="text">대기</span> <span class="badge badge-warning">{ con.s_0}</span></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-3 col-md-3 item current">
                        <div class="inner">
                            <h3><a href="/admin_competition"><span class="glyphicon glyphicon-play-circle"></span> 경진대회 관리</a></h3>
                            <ul class="list-unstyled">
                                <li><a href="/admin_competition?order=0"><span class="text">접수진행 중</span> <span class="badge badge-success">{ oc.s_1}</span></a></li>
                                <li><a href="/admin_competition?order=2"><span class="text">접수마감</span> <span class="badge badge-info">{ oc.s_0}</span></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-3 col-md-3 item current">
                        <div class="inner">
                            <h3><a href="/admin_office"><span class="glyphicon glyphicon-play-circle"></span> Office hours</a></h3>
                            <ul class="list-unstyled">
                                <li><a href="/admin_office?order=0"><span class="text">접수진행 중</span> <span class="badge badge-success">{ oh.s_1}</span></a></li>
                                <li><a href="/admin_office/mentor"><span class="text">전체멘토</span> <span class="badge badge-info">{ oh.s_2}</span></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-3 col-md-3 item current">
                        <div class="inner">
                            <h3><a href="/admin_office"><span class="glyphicon glyphicon-play-circle"></span> Q&amp;A</a></h3>
                            <ul class="list-unstyled">
                                <li><a href="/admin_manage/qna?order=1"><span class="text">처리완료</span> <span class="badge badge-success">{ q.s_1}</span></a></li>
                                <li><a href="/admin_manage/qna?order=0"><span class="text">대기중</span> <span class="badge badge-info">{ q.s_0}</span></a></li>
                                <li><a href="/admin_manage/qna"><span class="text">전체</span> <span class="badge badge-info">{ q.s_2}</span></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-3 col-md-3 item">
                        <div class="inner">
                            <h3><a href="/admin_main"><span class="glyphicon glyphicon-play-circle"></span> 메인 콘텐츠 관리</a></h3>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-3 col-md-3 item">
                        <div class="inner">
                            <h3><a href="/admin_entrance"><span class="glyphicon glyphicon-play-circle"></span> 출입 관리</a></h3>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-3 col-md-3 item">
                        <div class="inner">
                            <h3><a href="/admin_entrance/monthly_locker"><span class="glyphicon glyphicon-play-circle"></span> 월간 사물함 배정 </a></h3>
                        </div>
                    </div>
                    <!-- /End Page Cotents -->
                </div>
            </div>
            <!-- /current-state -->
            <!-- monthly-state -->
            <div class="monthly-state">
                <!-- panel -->
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h2 class="panel-title">운영 리포트</h2>
                        <select class="selectpicker select-monthly" data-width="auto">
                            { option }
                        </select>
                    </div>
                    <div class="panel-body">
                    </div>
                </div>
                <!-- /panel -->
            </div>
            <!-- /monthly-state -->
        </div>
        <!-- /container -->

        </div>
        <!-- /wrap -->
    </section>
    <!-- /section -->


    <!-- footer-->
    <footer class="footer">
      <div class="container">
        <p>Copyright &copy <a href="/"><strong>D.CAMP</strong></a>. All rights reserved. <a href="http://www.podio.com" target="_blank">Thanks to Podio we keep work simple.</a></p>
      </div>
    </footer>
    <!-- /footer -->
    <script src="/js/jquery.mCustomScrollbar.concat.min.js"></script>
<script>

    $(document).ready(function() {
        //init
        updateDashboardMonthly("/ajax_v3/dashboard_monthly/");

        //운영리포트 년월 선택시
        $('.select-monthly').change(function(){

            updateDashboardMonthly("/ajax_v3/dashboard_monthly/"+$(this).val());

        });

    });

    function updateDashboardMonthly(url){
        var jqxhr_dashboard_monthly = $.ajax({
            url: url,
            method: "GET",
            data: { },
            dataType: "html"
        });

        jqxhr_dashboard_monthly.done(function( _data ) {
            $('.monthly-state .panel-body').html(_data);
        });

        jqxhr_dashboard_monthly.fail(function( jqXHR, textStatus ) {
            $('.monthly-state .panel-body').html(textStatus);
        });
    }

    function setHeight() {
        windowHeight = $(window).innerHeight();
        $('.header').css('height', windowHeight);
    };
    setHeight();
    $(window).resize(function() {

        setHeight();
    });
    $(".header").mCustomScrollbar({
        theme:"dark-thin",
        scrollbarPosition:"outside"
    });

    { ? msg }
        alert('{ msg }');
    { / }



(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-45121809-1', 'dcamp.kr');
ga('send', 'pageview');

</script>
</body>
</html>