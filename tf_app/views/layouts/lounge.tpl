<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>D.CAMP Lounge</title>

    <meta property="fb:admins" content="504444819"/>
    <meta property="og:type" content="website"/>
    <meta property="og:url" content="{og_url}"/>
    <meta property="og:title" content="D.CAMP Lounge"/>
    <meta property="og:description" content="은행권청년창업재단이 운영하는 대한민국 최초의 복합 창업 생태계 허브"/>
    <meta property="og:image" content="http://dcamp.kr/video/louge.jpg"/>
    <meta property="og:site_name" content="D.CAMP - 은행권청년창업재단이 운영하는 대한민국 최초의 복합 창업 생태계 허브"/>

    <link rel="shortcut icon" href="http://dcamp.kr/images/favicon.ico" type="image/x-icon" />
    <link rel="icon" href="http://dcamp.kr/images/favicon.ico" type="image/x-icon" />

    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" >
    <link rel="stylesheet" href="/css/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />
    {? tpl == "permalink"} 
    <link rel="stylesheet" href="/css/dcamp-permalink.css">
    {/}
    {? tpl == "main" || tpl == "event"} 
    <link rel="stylesheet" href="/css/dcamp-lounge.css">
    <link href="/css/jquery.videobackground.css" rel="stylesheet" media="screen">  
    {/}

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
    <script src="/js/jquery.prettyPhoto.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/dcmap-lounge.js"></script>
    {? tpl == "main" || tpl == "event"} 
    <script src="/js/jquery.videobackground.js"></script>
    <script>
        $(document).ready(function() {
            $('body').prepend('<div class="video-background"></div>');
            $('.video-background').videobackground({
                videoSource: [['/video/lounge.mp4', 'video/mp4'],
                    ['/video/lounge.webm', 'video/webm'], 
                    ['/video/lounge.ogv', 'video/ogg']], 
                controlPosition: '.wrapper',
                poster: '/video/lounge.jpg',
                loadedCallback: function() {
                    $(this).videobackground('mute');
                },
                loop : true,
            });
            $("a[rel^='prettyPhoto']").prettyPhoto({social_tools: false});
        });
    </script> 
    {/}
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

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
                    <li class="signUser"> 
                        <a href="/member/{s.ids}" data-toggle="tooltip" data-placement="bottom" title="{s.name}"> <img src="{?s.picture}{s.picture}{? ! strpos(s.picture, '?')}?date={=date('his')}{/}{:}/img/default-img-member.png{/}" class="img-circle"> </a> 
                    </li>
                    <li class="userbell">
                        <a href="/member/activity">
                            <span class="fa fa-fw fa-bell"></span><span class="sr-only"> 액티비티</span> 
                        </a> 
                    </li>
                    <li class="dropdown"> 
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><span class="fa fa-fw fa-cog"></span><span class="sr-only"> 설정 </span> </a>
                        <ul class="dropdown-menu" role="menu">
                            {? s.con}<li style="border-bottom: 1px dashed #ddd;" ><a href="/contents/edit"><span class="fa fa-fw fa-file-text"></span> Blog 글쓰기</a></li>{/}
                            {? s.mento}<li style="border-bottom: 1px dashed #ddd;"><a href="/office_hours/m_list"><span class="fa fa-fw fa-file-text"></span> Office Hours 관리</a></li>{/}
                            {? s.con}<li><a href="/member/edit_contents"> 콘텐츠관리</a></li>{/}
                            <li><a href="/member/edit_event"> 이벤트관리</a></li>
                            {? (s.per & settings->permission2) == settings->permission2 || (s.per & settings->permission1) == settings->permission1}<li><a href="/member/edit_space"> 공간공유 신청내역</a></li>{/}
                            <li><a href="/member/edit_challenge_m"> Challenge 관리</a></li>
                            <li><a href="/member/edit_office"> Office Hours 내역</a></li>
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

    {? tpl == "main" || tpl == "event"} 
    <div id="jumbo-header">
        <div class="container">
            <h2><a href="/lounge">D.CAMP <em>Lounge</em></a></h2>
            <div class="slogan">We are all connected</div>
        </div>
    </div>
    {/}

    <div class="content-wrapper"> 
        <div class="container">
        <!-- Start Contents -->
            
            {? tpl == "main" || tpl == "event"} 
            <p id="top-lead" class="lead"><span class="fa fa-fw fa-clock-o"></span>&nbsp; <strong>{=date("Y.m.d")} {=strtoupper(date("D"))}</strong> <small>지금 D.CAMP에 {=sizeof(users)}+명이 함께하고 있습니다</small></p>
            {/}
                
            {contents_for_layout}

        </div>
    </div>
    <!-- /content-wrapper -->

    <!-- #footer -->
    <footer id="footer">
        <div class="container">
             Copyright © D.CAMP. All rights reserved. <a href="http://www.podio.com" target="_blank">Thanks to Podio we keep work simple.</a>
        </div>
    </footer>
    <!-- /#footer -->
</div>
<!-- /wrapper -->
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