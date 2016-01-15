<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>D.CAMP &#8211; 은행권청년창업재단</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
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

<!-- stylesheet -->
<!-- link rel="stylesheet" href="/css/bootstrap.min.css" --> 
<link rel="stylesheet" href="/css/bootstrap-formhelpers.css" >
<link rel="stylesheet" href="/css/bootstrap-select.min.css" >
<link rel="stylesheet" href="/css/jquery.timepicker.css" >
<link rel="stylesheet" href="/font-awesome/css/font-awesome.css" >
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" >
<!-- link rel="stylesheet" href="/css/style.css" -->
<link rel="stylesheet" href="/css/site.css" >

<!--[if IE 7]>
    <link rel="stylesheet" href="font-awesome/css/font-awesome-ie7.min.css">
<![endif]-->
<!--[if lt IE 9]>
	<link rel="stylesheet" type="text/css" href="/css/ie8-and-down.css" />
<![endif]-->


<!-- Javascript  -->
<!--[if lt IE 9]>
    <script src="/js/html5shiv.js"></script>
    <script src="/js/respond.min.js"></script>
<![endif]-->
<script src="http://code.jquery.com/jquery.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script src="/js/jquery.timepicker.min.js"></script>
<script src="/js/bootstrap-select.min.js"></script>
<script src="/js/doubletaptogo.js"></script>
<script src="/js/jquery.shuffle.min.js"></script>
<script src="/js/jquery.dotdotdot.js"></script>
<script src="/js/jquery.ellipsis.js"></script> 
<script src="/js/front.js"></script>
<script src="/js/common.js"></script>
<script src="/js/script.js"></script>
<script src="/js/dcmap-lounge.js"></script>
{? top_js}
<script src="/js/dcamp-{top_js}.js"></script>
{/}

<script>
$(document).ready(function() {
    $(".datepicker").datepicker({ dateFormat: 'yy.mm.dd',  viewMode: 2 });
    $(".timepicker").timepicker({ 'timeFormat': 'H:i' });
    
    $('[data-toggle="tooltip"]').tooltip();
    $('.ellipsis').ellipsis({
        row: 1
    }); 
    $('.mulitple').ellipsis({
        row: 2
    });  
    $('.quater').ellipsis({
        row: 4
    });
    $('.quintuple').ellipsis({
        row: 5
    });
    $(".ellipsis80").dotdotdot({
        height           : 80
    });
    $(".ellipsis100").dotdotdot({
        height           : 100
    });
    
    $('.carousel').carousel()
}); 

function go_main(_cat) {
    location.href='/?c='+_cat;
}
    
</script>

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

    <form name="hidden_form" action="/" method="post">
      <input type="hidden" name="c"/>
    </form>
        
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

    <!-- modal #md-warning -->
    <div class="modal fade" id="md-warning-cm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="z-index: 1050;">
        <div class="modal-dialog">
            <div class="modal-content"> 
                <div class="modal-body">
                    <div class="alert alert-warning text-center">                 
                     <p><strong><span class="icon-warning-sign"></span></strong>정말 삭제하시겠습니까?<br> 아래의 [삭제]를 클릭하시면 해당 내용은 완전히 삭제됩니다.</p><br/>
                     <button class="btn btn-default btn-sm">Support 바로가기</button>
                     <button class="btn btn-danger btn-sm" data-dismiss="modal">확인</button>
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
    <div class="modal fade" id="md-warning-al" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="z-index: 1050;">
        <div class="modal-dialog">
            <div class="modal-content"> 
                <div class="modal-body">
                    <div class="alert alert-warning text-center">                 
                     <p><strong><span class="icon-warning-sign"></span></strong>세부 정보 설정 완료 후 공개 가능합니다.<br> 세부 정보 설정을 시작할까요?</p><br/>
                     <button class="btn btn-default btn-sm" data-dismiss="modal">나중에</button>
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

    

    <div class="wrapper">
    <!-- header -->
        <nav  id="navbar" class="navbar navbar-default navbar-fixed-top" role="navigation">
            <div class="container">
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

                    {? s.id }
                    <ul id="signon" class="nav navbar-nav navbar-right navbar-sign">

                        <li class="userbell">
                            <a href="/member/activity" >{?s.acnt}<span class="badge pull-right">{s.acnt}</span>{/}
                                <span class="fa fa-fw fa-bell"></span><span class="sr-only"> 액티비티</span> </a> 
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
                                {? s.con}
                                <li style="border-bottom: 1px dashed #ddd;" ><a href="/contents/edit"><span class="fa fa-fw fa-file-text"></span> Blog 글쓰기</a></li>
                                {/}
                                {? s.mento}
                                <li style="border-bottom: 1px dashed #ddd;"><a href="/office_hours/m_list"><span class="fa fa-fw fa-file-text"></span> Office Hours 관리</a></li>
                                {/}
                                {? s.rep1}
                                <li style="border-bottom: 1px dashed #ddd;"><a href="/member/edit_rsv1"> <span class="fa fa-fw fa-file-text"></span> 공간공유 예약 관리</a></li>
                                {/}
                                {? s.rep2}
                                <li style="border-bottom: 1px dashed #ddd;"><a href="/member/edit_rsv2"> <span class="fa fa-fw fa-file-text"></span> 디자인라운지 예약 관리</a></li>
                                {/}
                                {? s.con}
                                <li><a href="/member/edit_contents"> 콘텐츠관리</a></li>
                                {/}
                                <li><a href="/member/edit_event"> 이벤트관리</a></li>
                                {? (s.per & settings->permission2) == settings->permission2 || (s.per & settings->permission1) == settings->permission1}
                                <li><a href="/member/edit_space"> Reservation 내역</a></li>
                                {/}
                                <li><a href="/member/edit_challenge_m"> Challenge 관리</a></li>
                                <li><a href="/member/edit_office"> Office Hours 내역</a></li>
                                <li><a href="/member/edit_benefit_m"> Benefits 관리</a></li>
                                <li><a href="/member/edit_showcase"> Showcase 관리</a></li>
                                <li><a href="/member/edit_reference"> 레퍼런스 내역</a></li>
                                <li><a href="/member/edit"> 개인정보 수정</a></li>
                                <li style="border-top: 1px dashed #ddd;"><a href="/logout"> <span class="icon-signout"></span> 로그아웃</a></li>
                                {? (s.per & settings->permission1) == settings->permission1}
                                <li style="border-top: 1px dashed #ddd;"><a href="/admin"><span class="icon-cog"></span> 관리자</a></li>
                                {/}
                                {? (s.per & settings->permission5) == settings->permission5}
                                <li style="border-top: 1px dashed #ddd;"><a href="/admin_entrance"><span class="icon-cog"></span> 관리자</a></li>
                                {/}
                            </ul>
                        </li>
                    </ul>     
                    <!-- / signon -->
                    {:}
                    <ul id="signoff" class="nav navbar-nav navbar-right navbar-sign">
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
                            <a href="/signup">회원가입</a>
                        </li>
                    </ul>
                    <!-- / signoff -->
                    {/}

                    <form  id="search-form" class="navbar-form navbar-right" role="search" action="/search" method="post">
                        <div class="form-group">
                            <input type="search" class="form-control input-sm" placeholder="Search" name="key">
                        </div>
                    </form>
                
                    <ul class="nav navbar-nav navbar-left navbar-site">
                        <li>
                            <a href='/event'>Event</a>
                        </li>
                        <li>
                            <a href='/challenge'>Challenge</a>
                        </li>
                        <li>
                            <a href='/office_hours'>Office Hours</a>
                        </li>
                        <li>
                            <a href='/recruit'>Recruit</a>
                        </li>
                        <li>
                            <a href='/benefits'>Benefits</a>
                        </li>
                        <li>
                            <a href='/showcase'>Showcase</a>
                        </li>
                        <li> 
                            <a class="dropdown-toggle"  href="#"  data-toggle="dropdown" role="button" aria-expanded="false">Network</a>
                            <ul class="dropdown-menu"> 
                                <li>
                                    <a href='/network/startup'>Startup</a>
                                </li>
                                <li>
                                    <a href='/network/people'>People</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href='/contents'>Blog</a>
                        </li>
                        <li>
                            <a href='/about'>About</a>
                        </li>
                    </ul>
                    <!-- / menu-->
                    <div class="nav navbar-nav navbar-left navbar-site" id="navbar-float">
                        <a href="/support" target="_blank" id="navbar-support">Support</a>
                    </div>
                </div>
                <!-- /.navbar-collapse --> 
            </div>
        </nav>
        <!-- /nav --> 

        <!-- rowContent -->
        <div class="rowContent"  id="userProfile"> 
           <div class="page-header">
            <div class="container">
                <h2><a href="/member/edit">{s.name}'s page</a></h2>
            </div>
        </div>
        <!-- /page-header --> 
        
        <!-- page-content -->
        <div class="page-content"> 
            <!-- container -->
            <div class="container"  id="user-activity-feed">
                <div class="row">


                    {contents_for_layout}
                

                    <div class="col-xs-12 col-sm-12 col-md-3 sidebar">
                        <ul class="nav nav-pills nav-stacked">
                            {? s.con}
                            <li><a href="/contents/edit"><span class="fa fa-fw fa-file-text"></span> Blog 글쓰기</a></li>
                            {/}
                            {? s.mento}
                            <li><a href="/office_hours/m_list"><span class="fa fa-fw fa-file-text"></span> Office Hours 관리</a></li>
                            {/}
                            {? s.rep1}
                            <li {? sideb == 'rsv1'}class="active"{/}><a href="/member/edit_rsv1"><span class="fa fa-fw fa-file-text"></span> 공간공유 예약 관리</a></li>
                            {/}
                            {? s.rep2}
                            <li {? sideb == 'rsv2'}class="active"{/}><a href="/member/edit_rsv2"><span class="fa fa-fw fa-file-text"></span> 디자인라운지 예약 관리</a></li>
                            {/}
                            <li {? sideb == 'activity'}class="active"{/}><a href="/member/activity"><span class="icon-fixed-width icon-location-arrow"></span> 액티비티</a></li>
                            {? s.con}
                            <li {? sideb == 'contents'}class="active"{/}><a href="/member/edit_contents"><span class="icon-fixed-width icon-edit"></span> 콘텐츠관리</a></li>{/}
                            {?(event_reserve_cnt+event_host_cnt) > 0}
                            <li {? sideb == 'event'}class="active"{/}><a href="/member/edit_event"><span class="icon-fixed-width icon-calendar "></span> 이벤트관리</a></li>
                            {/}
                            {? ((s.per & settings->permission2) == settings->permission2 || (s.per & settings->permission1) == settings->permission1)}
                            <li {? sideb == 'space'}class="active"{/}><a href="/member/edit_space"><span class="icon-fixed-width icon-map-marker"></span> Reservation 내역</a></li>
                            {/}
                            <li {? sideb == 'challenge'}class="active"{/}><a href="/member/edit_challenge_m"><span class="icon-fixed-width icon-trophy"></span> Challenge 관리</a></li>
                            <li {? sideb == 'office'}class="active"{/} data-cnt="{office_apply_cnt}"><a href="/member/edit_office"><span class="icon-fixed-width icon-trophy"></span> Office Hours 내역</a></li>
                            <li {? sideb == 'benefits'}class="active"{/}><a href="/member/edit_benefit_m"><span class="icon-fixed-width icon-edit"></span> Benefits 관리</a></li>
                            {? (s.per & settings->permission1) == settings->permission1}
                            <li {? sideb == 'showcase'}class="active"{/}><a href="/member/edit_showcase"><span class="icon-fixed-width icon-edit"></span> Showcase 관리(beta)</a></li>
                            {/}
                            <li {? sideb == 'recruit'}class="active"{/} ><a href="/member/edit_recruit"><span class="icon-fixed-width icon-trophy"></span> Recruit 내역</a></li>
                            <li {? sideb == 'reference'}class="active"{/}><a href="/member/edit_reference"><span class="icon-fixed-width icon-edit"></span> 레퍼런스 내역</a></li>
                            <li {? sideb == 'edit'}class="active"{/}><a href="/member/edit"><span class="icon-fixed-width icon-user"></span> 개인정보 수정</a></li>
                        </ul>
                    </div>
                    <!-- /sidebar -->
                     
                     
                </div>     
            </div>
            <!-- /container --> 
        </div>
        <!-- /page-content --> 
    </div>
    <!-- /rowContent --> 

    

    <!-- footer -->
    <footer id="footer">
        <div class="container">
            <ul class="footer-navbar list-inline">
                <li><a href="http://www.2030dreambank.or.kr/" target="_blank">은행권청년창업재단</a></li>
                <li><a href="/about">D.CAMP 소개</a></li>
                <li><a href="/membership">멤버십안내</a></li>
                <li><a href="/space">공간공유</a></li>
                <!--li><a href="/support">문의하기</a></li-->
                <li><a href="/policy_service">서비스약관</a></li>
                <li><a href="/policy_privacy"><strong>개인정보취급방침</strong></a></li>
            </ul>
            <address>
                서울시 강남구 역삼동 683-34 새롬빌딩 4~6층 &nbsp;
                <span><i class="fa fa-phone"></i> (02) 2030-9300</span> &nbsp;
                <span><i class="fa fa-envelope-o"></i> <a href="mailto:contact@dcamp.kr">contact@dcamp.kr</a></span>
            </address>
            <ul class="footer-navbar list-inline nav-sns">
                <li>
                    <a title="" data-placement="top" data-toggle="tooltip" href="https://www.facebook.com/dcamp.kr?ref=bookmarks" target="_blank" data-original-title="Facebook" id="fn-facebook">
                        <i class="fa fa-facebook-square"></i>
                    </a>
                </li>
                <li>
                    <a title="" data-placement="top" data-toggle="tooltip" href="https://twitter.com/Dcamp_kr" target="_blank" data-original-title="Twitter" id="fn-twitter">
                        <i class="fa fa-twitter-square"></i>
                    </a>
                </li>
                <li>
                    <a title="" data-placement="top" data-toggle="tooltip" href="https://www.flickr.com/photos/93969766@N06/" target="_blank" data-original-title="Flickr" id="fn-flickr">
                        <i class="fa fa-flickr"></i>
                    </a>
                </li>
                <li>
                    <a title="" data-placement="top" data-toggle="tooltip" href="https://www.youtube.com/channel/UCqsmYLUWkpphW-RgK9GZh7A" target="_blank" data-original-title="Youtube" id="fn-youtube">
                        <i class="fa fa-youtube"></i>
                    </a>
                </li>
                <li>
                    <a title="" data-placement="top" data-toggle="tooltip" href="http://www.slideshare.net/dreamcamp/" target="_blank" data-original-title="Slideshare" id="fn-slideshare">
                        <i class="fa fa-slideshare"></i>
                    </a>
                </li>
            </ul>
            <p>Copyright &copy;D.CAMP. All rights reserved. <a href="http://www.podio.com" target="_blank">Thanks to Podio we keep work simple.</a></p>
        </div>
    </footer>
    <!-- /footer -->
</div> 

<script>
{? msg}
alert('{msg}');
{/}

(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-45121809-1', 'dcamp.kr');
ga('send', 'pageview');

</script>
</body>
</html>

