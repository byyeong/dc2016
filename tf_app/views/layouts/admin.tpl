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
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" >
<!--[if IE 7]>
<link rel="stylesheet" href="/font-awesome/css/font-awesome-ie7.min.css">
<![endif]-->
<link rel="stylesheet" href="/css/admin.css">

<!-- custom scrollbar stylesheet -->
<link rel="stylesheet" href="/css/jquery.mCustomScrollbar.css">

<!-- Javascript  -->
<script src="http://code.jquery.com/jquery.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script src="/js/holder.js"></script>
<script src="/js/bootstrap-select.min.js"></script>
<script src="/js/jquery.timepicker.min.js"></script>

<script type="text/javascript" src="/js/admin.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
{? gnb == "office"}
<script type="text/javascript" src="/js/admin_office.js"></script>
{/}
{? top_js}
<script src="/js/dcamp-{top_js}.js"></script>
{/}
<script>
$(document).ready(function() {
    $(".timepicker").timepicker({ 'timeFormat': 'H:i' });
}); 

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
    
    $(function() {
        $( ".datepicker" ).datepicker({ dateFormat: 'yy.mm.dd',  viewMode: 2 });
    });
    function ignoreEnter(event)
    {
      if (event.keyCode === 13) {
        return false;
      }
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

<!-- modal #md-warning -->
<div class="modal fade" id="md-warning-ch" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="z-index: 1050;">
    <div class="modal-dialog">
        <div class="modal-content"> 
            <div class="modal-body">
                <div class="alert alert-warning text-center">                 
                 <p></p><br/>
                 <button class="btn btn-default btn-sm" data-dismiss="modal">머물기</button>
                 <button class="btn btn-danger btn-sm" onclick="">시작</button>
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
            <li><a href="/admin"><span class="icon-cog"></span> 대시보드</a></li>
            <li { ?gnb == "member" }class="active"{ / }><a href="/admin_member">회원관리</a></li>
            <li { ?gnb == "membership" }class="active"{/}><a href="/admin_membership">멤버십관리</a></li>
            <li { ?gnb == "startup" }class="active"{ / }><a href="/admin_startup">스타트업관리</a></li>
            <li { ?gnb == "recruit" }class="active"{ / }><a href="/admin_recruit">채용정보관리</a></li>
            <li { ?gnb == "space" }class="active"{ / }><a href="/admin_space">Reservation관리</a></li>
            <li { ?gnb == "event" }class="active"{ / }><a href="/admin_event">이벤트관리</a></li>
            <li { ?gnb == "notice"}class="active"{ / }><a href="/admin_notice">공지사항관리</a></li>
            <li { ?gnb == "main"}class="active"{ / }><a href="/admin_main">메인콘텐츠관리</a></li>
            <li { ?gnb == "contents"}class="active"{ / }><a href="/admin_contents">Blog관리</a></li>
            <!--li { ?gnb == "competition"}class="active"{ / }><a href="/admin_competition">경진대회관리 </a></li-->
            <li { ?gnb == "challenge"}class="active"{ / }><a href="/admin_challenge">Challenge관리 </a></li>
            <li { ?gnb == "office"}class="active"{ / }><a href="/admin_office">Office Hours관리</a></li>
            <li { ?gnb == "program"}class="active"{ / }><a href="/admin_program">Benefits관리 </a></li>
            <li { ?gnb == "showcase"}class="active"{ / }><a href="/admin_showcase"> Showcase관리 </a></li>
            <li class="dropdown { ?gnb == "entrance" || gnb == "locker"}active{ / }">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">기타관리 <b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="/admin_entrance">출입관리</a></li>
                  <li><a href="/admin_entrance/monthly_locker">월간 사물함 배정</a></li>
                  <li><a href="/admin_newsletter/">뉴스레터 목록</a></li>
                  <li><a href="/admin_manage/">FAQ</a></li>
                  <li><a href="/admin_manage/qna">Q&A</a></li>
                </ul>
            </li>
            { / }

            { ? (s.per & settings->permission5) == settings->permission5}
            <li {?gnb == "member"}class="active"{ / }><a href="/admin_member">회원관리</a></li>
            <li {?gnb == "space"}class="active"{ / }><a href="/admin_space">공간공유관리</a></li>
            <li class="dropdown {?gnb == "entrance" || gnb == "locker"}active{ / }">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">기타관리 <b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="/admin_entrance">출입관리</a></li>
                  <li><a href="/admin_entrance/monthly_locker">월간 사물함 배정</a></li>
                  <li><a href="/admin_newsletter/">뉴스레터 목록</a></li>
                </ul>
            </li>
            { / }

            <!--<li {?gnb == "analytics"}class="active"{ / }><a href="/admin_analytics">통계분석</a></li>//-->
        </ul>
    </nav>
</header>








<section class="contentSector">
	<!-- jumbotron -->
	<div class="jumbotron">
	    <div class="container">
	        <h1>{ gnb_title }</h1>
	    </div>
	</div>
	<!-- /jumbotron --> 
	
	<!-- container -->
	<div class="rowContainer">
	    <div class="container">
	        <div class="row"> 
	            <!-- Start Page Cotents --> 
	            
	            <!-- sidebar -->
	            { ? gnb == "member" }
	            <div class="col-md-2 sidebar">
	                <div class="sidebar-nav hidden-print">
	                    <ul class="nav list-group">
	                        <li class="list-group-item {? gnb_left == "member"}active{/}"><a href="/admin_member">회원관리</a></li>
	                        { ? (s.per & settings->permission1) == settings->permission1}<li class="list-group-item {? gnb_left == "grade"}active{ / }"><a href="/admin_member/grade_list">회원등급 설정</a></li>{ / }
	                    </ul>
	                </div>
	            </div>
	            {/}
	            
	            { ?gnb == "startup" }
	            <div class="col-md-2 sidebar">
	               <div class="sidebar-nav hidden-print">
	                    <ul class="nav list-group">
	                        <li class="list-group-item {? gnb_left == "startup"}active{ / }"><a href="/admin_startup"> 스타트업 정보관리</a></li>
	                        <li class="list-group-item {? gnb_left == "add"}active{ /}"><a href="/admin_startup/add"> 스타트업 등록하기</a></li>
	                    </ul>
	                </div>
	            </div>
	            {/}
                    
                {?gnb == "recruit"}
	            <div class="col-md-2 sidebar">
	               <div class="sidebar-nav hidden-print">
	                    <ul class="nav list-group">
	                        <li class="list-group-item {? gnb_left == "recruit"}active{/}"><a href="/admin_recruit"> 채용정보 관리</a></li>
	                        <li class="list-group-item {? gnb_left == "add"}active{/}"><a href="/admin_recruit/add"> 채용정보 등록하기</a></li>
                            <li class="list-group-item"><a href="#" onclick="newsletterRecruitPop(0); return false;"> 정기 채용 뉴스 미리보기</a></li>
                            <li class="list-group-item"><a href="#" onclick="newsletterRecruitPop(1); return false;"> 정기 채용 뉴스 html</a></li>
                            <li class="list-group-item {? gnb_left == "pic"}active{/}"><a href="/admin_recruit/edit_mailling_pic"> 키비주얼</a></li>
	                    </ul>
	                </div>
	            </div>
	            {/}
	            
                {?gnb == "board"}
                <div class="col-md-2 sidebar">
	                <div class="sidebar-nav hidden-print">
	                    <ul class="nav list-group">
	                        <li class="list-group-item active"><a href="board-list.html"> 게시판 관리하기</a></li>
	                        <li class="list-group-item"><a href="board-write.html"> 게시판 등록하기</a></li>
	                    </ul>
	                </div>
	            </div>
                {/}

                {?gnb == "contents"}
                <div class="col-md-2 sidebar">
	                <div class="sidebar-nav hidden-print">
	                    <ul class="nav list-group">
	                        <li class="list-group-item {? gnb_left == "contents"}active{/}"><a href="/admin_contents"> Blog 목록</a></li>
                            <li class="list-group-item {? gnb_left == "category"}active{/}"><a href="/admin_contents/category"> 카테고리 관리</a></li>
                            <li class="list-group-item {? gnb_left == "pic"}active{/}"><a href="/admin_contents/edit_pic"> 키비주얼</a></li>
	                    </ul>
	                </div>
	            </div>
                {/}

                {?gnb == "space"}
                <div class="col-md-2 sidebar">
	                <div class="sidebar-nav hidden-print">
	                    <ul class="nav list-group">
	                        <li class="list-group-item {? gnb_left == "index"}active{/}"><a href="/admin_space">공간 예약 관리</a></li>
	                        <li class="list-group-item {? gnb_left == "reserve"}active{/}"><a href="/admin_space/reserve">공간 예약</a></li>
	                        <li class="list-group-item {? gnb_left == "list_"}active{/}"><a href="/admin_space/list_">공간 목록</a></li>
	                        <li class="list-group-item {? gnb_left == "rep"}active{/}"><a href="/admin_space/rep">공간 담당자</a></li>
                            <li class="list-group-item {? gnb_left == "add"}active{/}"><a href="/admin_space/add">공간 등록</a></li>
	                        <li class="list-group-item {? gnb_left == "calendar"}active{/}"><a href="/admin_space/calendar">공유일정 캘린더</a></li>
	                    </ul>
	                </div>
	            </div>
                {/}

                {?gnb == "event"}
                <div class="col-md-2 sidebar">
	                <div class="sidebar-nav hidden-print">
	                    <ul class="nav list-group">
	                        <li class="list-group-item {? gnb_left == "event"}active{/}"><a href="/admin_event">이벤트 목록</a></li>
	                        <li class="list-group-item {? gnb_left == "add"}active{/}"><a href="/admin_event/add">이벤트 추가</a></li>
	                        <li class="list-group-item {? gnb_left == "type"}active{/}"><a href="/admin_event/type">이벤트 종류 관리</a></li>
	                        <li class="list-group-item {? gnb_left == "calendar"}active{/}"><a href="/admin_event/calendar">이벤트 캘린더</a></li>
                            <li class="list-group-item {? gnb_left == "pic"}active{/}"><a href="/admin_event/edit_pic"> 키비주얼</a></li>
                            <li class="list-group-item {? gnb_left == "book"}active{/}"><a href="/admin_event/book">BOOk 프로모션</a></li>
	                    </ul>
	                </div>
	            </div>
                {/}

                {?gnb == "notice"}
                <div class="col-md-2 sidebar">
	                <div class="sidebar-nav hidden-print">
	                    <ul class="nav list-group">
	                        <li class="list-group-item {? gnb_left == "notice"}active{/}"><a href="/admin_notice">공지사항 관리</a></li>
	                        <li class="list-group-item {? gnb_left == "add"}active{/}"><a href="/admin_notice/add">공지사항 작성</a></li>
	                    </ul>
	                </div>
	            </div>
                {/}

                {?gnb == "main"}
                <div class="col-md-2 sidebar">
                    <div class="sidebar-nav hidden-print">
                        <ul class="nav list-group">
                            <li class="list-group-item {? gnb_left == "main"}active{/}"><a href="/admin_main">콘텐츠 노출 관리</a></li> 
                            <li class="list-group-item {? gnb_left == "banner"}active{/}"><a href="/admin_main/banner">슬라이드 배너 관리</a></li>
                        </ul>
                    </div>
                </div>
                {/}
                    
                {?gnb == "competition"}
                <div class="col-md-2 sidebar">
                    <div class="sidebar-nav hidden-print">
                        <ul class="nav list-group">
                            <li class="list-group-item {? gnb_left == "competition"}active{/}"><a href="/admin_competition"> 경진대회 관리</a></li>
                            <li class="list-group-item {? gnb_left == "competition_pool"}active{/}"><a href="/admin_competition/examiner_list"> 심사위원 라이브러리</a></li>
                        </ul>
                    </div>
                </div>
                {/}

                {?gnb == "challenge"}
                <div class="col-md-2 sidebar">
                    <div class="sidebar-nav hidden-print">
                        <ul class="nav list-group">
                            <li class="list-group-item {? gnb_left == "competition"}active{/}"><a href="/admin_challenge"> Challenge 목록</a></li>
                            <li class="list-group-item {? gnb_left == "competition_pool"}active{/}"><a href="/admin_challenge/examiner_list"> 심사위원 라이브러리</a></li>
                            <li class="list-group-item {? gnb_left == "pic"}active{/}"><a href="/admin_challenge/edit_pic"> 키비주얼</a></li>
                        </ul>
                    </div>
                </div>
                {/}

                {?gnb == "entrance"}
                <div class="col-md-2 sidebar">
	                <div class="sidebar-nav hidden-print">
	                    <ul class="nav list-group">
	                        <li class="list-group-item {? gnb_left == "entrance"}active{/}"><a href="/admin_entrance">입출입 대시보드</a></li>
	                        <li class="list-group-item {? gnb_left == "checkin"}active{/}"><a href="/admin_entrance/checkin">입실 관리</a></li>
	                        <li class="list-group-item {? gnb_left == "checkout"}active{/}"><a href="/admin_entrance/checkout">퇴실 관리</a></li>
	                        <li class="list-group-item {? gnb_left == "locker"}active{/}"><a href="/admin_entrance/locker">사물함 관리</a></li>
	                        <li class="list-group-item {? gnb_left == "pass"}active{/}"><a href="/admin_entrance/pass">출입증 관리</a></li>
                                <li class="list-group-item {? gnb_left == "analytics"}active{/}"><a href="/admin_entrance/analytics">출입통계</a></li>
	                    </ul>
	                </div>
	            </div>
                {/}
                
                {?gnb == "locker"}
                <div class="col-md-2 sidebar">
	                <div class="sidebar-nav hidden-print">
	                    <ul class="nav list-group">
                            <li class="list-group-item {? gnb_left == "monthly_locker"}active{/}"><a href="/admin_entrance/monthly_locker">월간 사물함 배정</a></li>
                            <li class="list-group-item {? gnb_left == "locker_analytics"}active{/}"><a href="/admin_entrance/locker_analytics">월별 사물함 이용 현황</a></li>
	                    </ul>
	                </div>
	            </div>
                {/}
                
                {?gnb == "analytics"}
                <div class="col-md-2 sidebar">
	                <div class="sidebar-nav hidden-print">
	                    <ul class="nav list-group">
	                        <li class="list-group-item {? gnb_left == "analytics"}active{/}"><a href="/admin_analytics">회원통계</a></li>
	                        <li class="list-group-item {? gnb_left == "space"}active{/}"><a href="/admin_analytics/space">공간공유</a></li>
	                        <li class="list-group-item {? gnb_left == "event"}active{/}"><a href="/admin_analytics/event">이벤트</a></li>
	                        <li class="list-group-item {? gnb_left == "startup"}active{/}"><a href="/admin_analytics/startup">기업현황</a></li>
	                        <li class="list-group-item {? gnb_left == "recruit"}active{/}"><a href="/admin_analytics/recruit">구인공고</a></li>
	                    </ul>
	                </div>
	            </div>
                {/}

                {?gnb == "office"}
                <div class="col-md-2 sidebar">
                    <div class="sidebar-nav hidden-print">
                        <ul class="nav list-group">
                            <li class="list-group-item {? gnb_left == "oh"}active{/}"><a href="/admin_office">Office Hours</a></li>
                            <li class="list-group-item {? gnb_left == "mento"}active{/}"><a href="/admin_office/mentor">멘토</a></li>
                        </ul>
                    </div>
                </div>
                {/}
                <!-- /sidebar --> 

                {?gnb == "newsletter"}
                <div class="col-md-2 sidebar">
                    <div class="sidebar-nav hidden-print">
                        <ul class="nav list-group">
                            <li class="list-group-item active"><a href="/admin_newsletter">뉴스레터 목록</a></li>
                        </ul>
                    </div>
                </div>
                {/}
                <!-- /sidebar --> 

                {?gnb == "faq"}
                <div class="col-md-2 sidebar">
                    <div class="sidebar-nav hidden-print">
                        <ul class="nav list-group">
                            <li class="list-group-item {? gnb_left == 'faq'}active{/}"><a href="/admin_manage"> FAQ</a></li>
                            <li class="list-group-item {? gnb_left == 'faq_c'}active{/}"><a href="/admin_manage/faq_category"> 분류 관리</a></li> 
                        </ul>
                    </div>
                </div>
                {/}
                <!-- /sidebar --> 

                {?gnb == "qna"}
                <div class="col-md-2 sidebar">
                    <div class="sidebar-nav hidden-print">
                        <ul class="nav list-group">
                            <li class="list-group-item {? gnb_left == 'qna'}active{/}"><a href="/admin_manage/qna"> Q&amp;A 목록</a></li>
                            <li class="list-group-item {? gnb_left == 'qna_c'}active{/}"><a href="/admin_manage/qna_category"> 분류 관리</a></li> 
                        </ul>
                    </div>
                </div>
                {/}
                <!-- /sidebar --> 

                {?gnb == "program"}
                <div class="col-md-2 sidebar">
                    <div class="sidebar-nav hidden-print">
                        <ul class="nav list-group">
                            <li class="list-group-item {? gnb_left == 'program'}active{/}"><a href="/admin_program"> Benefits 목록</a></li>
                            <li class="list-group-item {? gnb_left == 'program_c'}active{/}"><a href="/admin_program/category"> Benefits 성격 관리</a></li> 
                            <li class="list-group-item {? gnb_left == "pic"}active{/}"><a href="/admin_program/edit_pic"> 키비주얼</a></li>
                        </ul>
                    </div>
                </div>
                {/}
                <!-- /sidebar --> 

                {?gnb == "showcase"}
                <div class="col-md-2 sidebar">
                    <div class="sidebar-nav hidden-print">
                        <ul class="nav list-group">
                            <li class="list-group-item {? gnb_left == 'bz'}active{/}"><a href="/admin_showcase"> 제품/서비스 목록</a></li>
                            <li class="list-group-item {? gnb_left == 'bz_cat'}active{/}"><a href="/admin_showcase/cat_index"> 카테고리 관리</a></li> 
                            <li class="list-group-item {? gnb_left == 'pic'}active{/}"><a href="/admin_showcase/edit_pic"> 키비주얼</a></li>
                        </ul>
                    </div>
                </div>
                {/}
                <!-- /sidebar --> 

                {contents_for_layout}


	        </div>
	    </div>
	</div>
	<!-- /container -->
</section>

<!-- footer-->
<footer class="footer">
    <div class="container">
        <p>Copyright &copy <a href="/"><strong>D.CAMP</strong></a>. All rights reserved. <a href="http://www.podio.com" target="_blank">Thanks to Podio we keep work simple.</a></p>
    </div>
</footer>
<!-- /footer -->

<script src="/js/jquery.mCustomScrollbar.concat.min.js"></script>
<script>
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

(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-45121809-1', 'dcamp.kr');
ga('send', 'pageview');

</script>
</body>
</html>