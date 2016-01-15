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
<meta property="og:type" content="website"/>
<meta property="og:url" content="{og.url}"/>
<meta property="og:title" content="{og.title}"/>
<meta property="og:description" content="{og.description}"/>
<meta property="og:image" content="{og.image}"/>
<meta property="og:site_name" content="D.CAMP - 은행권청년창업재단이 운영하는 대한민국 최초의 복합 창업 생태계 허브"/>
{/}

<link rel="shortcut icon" href="http://dcamp.kr/images/favicon.ico" type="image/x-icon" />
<link rel="icon" href="http://dcamp.kr/images/favicon.ico" type="image/x-icon" />

<!-- stylesheet -->
<link rel="stylesheet" href="/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/bootstrap-formhelpers.css" >
<link rel="stylesheet" href="/css/bootstrap-select.min.css" >
<link rel="stylesheet" href="/font-awesome/css/font-awesome.css" >
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
<!--[if IE 7]>
    <link rel="stylesheet" href="font-awesome/css/font-awesome-ie7.min.css">
<![endif]-->
<link rel="stylesheet" href="/css/style.css" > 
<link rel="stylesheet" href="/css/metro.css" > 
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
<script src="/js/bootstrap-formhelpers-timepicker.js"></script>
<script src="/js/bootstrap-select.min.js"></script>
<script src="/js/doubletaptogo.js"></script>
<script src="/js/jquery.shuffle.min.js"></script>
<script src="/js/jquery.dotdotdot.js"></script>
<script src="/js/front.js"></script>
<script src="/js/common.js"></script>
<!--
<script src="/js/shuffle.js"></script>
<script src="/js/jquery.dotdotdot.min.js"></script>
//-->
<script src="/js/script.js"></script>

<script>
  $(function() {
    $( ".datepicker" ).datepicker({ dateFormat: 'yy.mm.dd' }).val();
  });
</script>
<script>

$(document).ready(function() {

    var $grid = $('#grid'),
        $sizer = $grid.find('.shuffle_sizer');

    $grid.shuffle({
      itemSelector: '.item',
      sizer: $sizer,
      group: 'all', 
      speed: 250
    });

    // Advanced filtering
    shapes = [];
    $('.selectpicker').on('change', function() {
      
      _val = this.value.toLowerCase();
      
        $('#grid').shuffle('shuffle', function($el, shuffle) {
          var text = $.trim($el.data('sor')).toLowerCase();
          if(text == 'all') return true;
          return text == _val;
          //return true;
        });            
      
      
    });
       
});
function go_main(_cat) {
    location.href='/?c='+_cat;
  }
</script>

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
<form name="hidden_form" action="/" method="post">
  <input type="hidden" name="c"/>
</form>

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


<div class="wrap">
    <!-- header -->
    <header  class="navbar navbar-default global-nav navbar-fixed-top" role="navigation">
        <div class="container">
        
                <div class="navbar-header"> 
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-global-collapse"> 
                        <span class="sr-only">Toggle navigation</span> 
                        <span class="icon-bar"></span> 
                        <span class="icon-bar"></span> 
                        <span class="icon-bar"></span> 
                    </button>
                    <a class="navbar-brand" href="/"><img src="/img/logo.png" alt="D.CAMP"></a> 
                </div>
                <!-- /navbar-header --> 
                
                <nav class="collapse navbar-collapse navbar-global-collapse" role="navigation">
                
                    <ul id="menu" class="nav navbar-nav  filter-options">
                        <li>
                            <a class="btn btn-link {? c == 'about'}active{/}" onclick="javascript:location.href='/about'">About</a>
                        </li>
                        <li>
                            <a class="btn btn-link {? c == 'event'}active{/}" onclick="javascript:location.href='/event'">Event</a>
                        </li>
                        <li> 
                            <a class="btn btn-link dropdown-toggle"  href="#"  data-toggle="dropdown" >Network <b class="caret"></b></a>
                            <ul class="dropdown-menu"> 
                                <li>
                                    <a  onclick="javascript:location.href='/network/startup'">Startup</a>
                                </li>
                                <li>
                                    <a onclick="javascript:location.href='/network/people'">People</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a class="btn btn-link {? c == 'recruit'}active{/}"  onclick="javascript:location.href='/recruit'">Recruit</a>
                        </li>
                        <li>
                            <a class="btn btn-link {? c == 'notice'}active{/}"  onclick="javascript:location.href='/notice'">Notice</a>
                        </li>
                        <li>
                            <a class="btn btn-link {? c == 'news'}active{/}"  href="/news">News</a>
                        </li>
                        {? con}
                        <li> 
                            <a href="#" class="btn btn-link dropdown-toggle" data-toggle="dropdown" data-group="news">Contents <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                {@ con}
                                <li><a href="/contents/{.id}">{.name}</a></li>
                                {/}
                            </ul>
                        </li>
                        {/}
                        <li>
                            <a class="btn btn-link {? c == 'competition'}active{/}"  onclick="javascript:location.href='/competition'">Competition</a>
                        </li>
                    </ul>
                    <!-- / menu-->
                    
                    <form  id="search-form" class="navbar-form navbar-left" role="search" action="/search" method="post">
                        <input type="search" placeholder="Search" name="key">
                    </form>
                    {? s.id}
                    <ul id="signon" class="nav navbar-nav navbar-right">
                        <li class="signUser"> 
                            <a href="/member/{s.ids}" data-toggle="tooltip" data-placement="bottom" title="{s.name}"> <img src="{?s.picture}{s.picture}{:}/img/default-img-member.png{/}" class="img-circle"> </a> 
                        </li>
                        <li class="userbell">
                            <a href="/member/activity">{?s.acnt}<span class="badge pull-right">{s.acnt}</span>{/}
                                <span class="icon-bell-alt"></span><span class="sr-only"> 액티비티</span> </a> 
                        </li>

                        <li class="userset dropdown"> 
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="icon-cog"></span><span class="sr-only"> 설정 </span></a>
                            <ul class="dropdown-menu">
                                {? s.con}<li style="border-bottom: 1px dashed #ddd;" ><a href="/contents/edit"><span class="icon-file-text"></span> 컨텐츠 글쓰기</a></li>
                                <li><a href="/member/edit_contents"> 콘텐츠관리</a></li>{/}
                                <li><a href="/member/edit_event"> 이벤트관리</a></li>
                                {? (s.per & settings->permission2) == settings->permission2 || (s.per & settings->permission1) == settings->permission1}<li><a href="/member/edit_space"> 공간공유 신청내역</a></li>{/}
                                <li><a href="/member/edit_competition"> 경진대회 관리</a></li>
                                <li><a href="/member/edit_reference"> 레퍼런스 내역</a></li>
                                <li><a href="/member/edit"> 개인정보 수정</a></li>
                                <li style="border-top: 1px dashed #ddd;"><a href="/logout"><span class="icon-signout"></span> 로그아웃</a></li>
                                {? (s.per & settings->permission1) == settings->permission1}<li style="border-top: 1px dashed #ddd;"><a href="/admin"><span class="icon-cog"></span> 관리자</a></li>{/}
                                {? (s.per & settings->permission5) == settings->permission5}<li style="border-top: 1px dashed #ddd;"><a href="/admin_entrance"><span class="icon-cog"></span> 관리자</a></li>{/}
                            </ul>
                        </li>
                    </ul>     
                    <!-- / signon -->
                    {:}
                    <ul id="signoff" class="nav navbar-nav navbar-right">
                        <li class="gosignin"><a href="/login"><span class="icon icon-facebook img-circle"></span> 로그인</a></li>
                        <li class="gosignup"><a href="/signup">회원가입</a></li>
                    </ul>
                    <!-- / signoff -->
                    {/}
                </nav>
                <!-- /.navbar-collapse -->  
                      
        </div>
    </header>
    <!-- /header --> 


            {contents_for_layout}
            
</div>


<!-- footer -->
<footer>
    <div class="container"> 
            
            <div class="text-center">
                <ul class="list-inline">
                    <li><a href="http://www.2030dreambank.or.kr/" target="_blank">은행권청년창업재단</a></li>
                    <li><a href="/about">D.CAMP 소개</a></li>
                    <li><a href="/membership">멤버십안내</a></li>
                    <li><a href="/space">공간공유</a></li>
                    <li><a href="/policy_service">서비스약관</a></li>
                    <li><a href="/policy_privacy"><strong>개인정보취급방침</strong></a></li>
                </ul>
            </div>
            
            <div class="text-center">
                <address>
                    서울시 강남구 역삼동 683-34 새롬빌딩 4~6층 &nbsp; <br>
                    <span class="icon-phone"></span> (02) 2030-9300 &nbsp; <br>
                    <span class="icon-envelope-alt"></span> <a href="mailto:Contact@dcamp.kr">Contact@dcamp.kr</a>
                </address>
                <p>Copyright &copy <a href="/"><strong>D.CAMP</strong></a>. All rights reserved. <a href="http://www.podio.com" target="_blank">Thanks to Podio we keep work simple.</a></p>
            </div>
            
        
    </div>
</footer>
<!-- /footer -->
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

