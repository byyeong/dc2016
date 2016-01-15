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

    <link rel="stylesheet" href="/css/site.css"> 
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" >  
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>  
 
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]--> 

    <script src="/js/jquery.ellipsis.js"></script> 

    <script>
        $(document).ready(function() {
            $('[data-toggle="tooltip"]').tooltip();
        

            $('.ellipsis').ellipsis({
                row: 1
            }); 
            $('.mulitple').ellipsis({
                row: 2
            });  
            $('.triple').ellipsis({
                row: 2
            });  

        });  

        function go_main(_cat) {
            location.href='/?c='+_cat;
        }    
    </script> 
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


    <!-- wrapper -->
    <div class="wrapper">
        <!-- navbar -->
        <nav id="navbar" class="navbar navbar-default navbar-fixed-top" role="navigation">
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
                 
                <div class="collapse navbar-collapse" id="navbar-collapse" > 
                    {? s.id}
                    <ul class="nav navbar-nav navbar-right navbar-sign" id="signon">
                        <li class="signUser"> 
                            <a href="/member/{s.ids}" data-toggle="tooltip" data-placement="bottom" title="{s.name}"> 
                                <img class="img-circle" src="{?s.picture}{s.picture}{:}/img/default-img-member.png{/}"> <span class="sr-only">{s.name}</span> 
                            </a> 
                        </li>
                        <li class="userbell">
                            <a href="/member/activity">
                                <span class="fa fa-fw fa-bell"></span><span class="sr-only"> 액티비티</span> {?s.acnt}<span class="badge">{s.acnt}</span>{/} 
                            </a> 
                        </li>
                        <li class="dropdown"> 
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                                <span class="fa fa-fw fa-cog"></span><span class="sr-only"> 설정 </span> 
                            </a>
                            <ul class="dropdown-menu" role="menu">
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
                    {:}
                    <ul class="nav navbar-nav navbar-right navbar-sign" id="signoff">
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
                    {/}
                    <!--
                    <ul class="nav navbar-nav navbar-left navbar-site">
                        <li><a href="#">Event</a></li>
                        <li><a href="#">Competition</a></li>
                        <li>
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Contents</a>
                            <ul class="dropdown-menu">
                                <li><a href="#">D.MENTOR</a></li>
                                <li><a href="#">D.DAY</a></li>
                                <li><a href="#">D.CREW</a></li>
                                <li><a href="#">Startup Nations Summit 2014</a></li>
                                <li><a href="#">D.Class</a></li>
                                <li><a href="#">Global D.MATCH 2014</a></li>
                            </ul>
                        </li>
                        <!--li><a href="#">Notice</a></li>
                        <!--li><a href="#">News</a></li>
                        <li><a href="#">Recruit</a></li>
                        <li>
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Network</a>
                            <ul class="dropdown-menu"> 
                                <li><a href="#">Startup</a></li>
                                <li><a href="#">People</a></li>
                            </ul>
                        </li>
                        <li><a href="#">About</a></li>
                    </ul>
                    
                    <form class="navbar-form navbar-right" role="search">
                        <div class="form-group">
                          <input type="text" class="form-control input-sm" placeholder="Search">
                        </div>
                    </form>
                    -->

                    <ul class="nav navbar-nav navbar-left navbar-site">
                        <li>
                            <a class="{? c == 'event'}active{/}" onclick="javascript:location.href='/event'">Event</a>
                        </li>
                        <li>
                            <a class="{? c == 'competition'}active{/}"  onclick="javascript:location.href='/competition'">Competition</a>
                        </li>
                        {? con}
                        <li> 
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Contents</a>
                            <ul class="dropdown-menu">
                                {@ con}
                                <li><a href="/contents/{.id}">{.name}</a></li>
                                {/}
                            </ul>
                        </li>
                        {/}
                        <li>
                            <a class="{? c == 'recruit'}active{/}"  onclick="javascript:location.href='/recruit'">Recruit</a>
                        </li>
                        <li> 
                            <a class="dropdown-toggle"  href="#"  data-toggle="dropdown" role="button" aria-expanded="false">Network</a>
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
                            <a class="{? c == 'about'}active{/}" onclick="javascript:location.href='/about'">About</a>
                        </li>
                        <!--
                        <li>
                            <a class="btn btn-link {? c == 'notice'}active{/}"  onclick="javascript:location.href='/notice'">Notice</a>
                        </li>
                        <li>
                            <a class="btn btn-link {? c == 'news'}active{/}"  href="/news">News</a>
                        </li>
                        -->
                    </ul>
                    <!-- / menu-->

                    <form id="search-form" class="navbar-form navbar-right" role="search" action="/search">
                        <div class="form-group">
                          <input type="text" class="form-control input-sm" placeholder="Search" name="key">
                        </div>
                    </form> 

                </div>
                <!-- /navbar-collapse -->

            </div> 
        </nav>
        <!-- /navbar -->

        <!-- jumbotron -->
        <div id="jumbo-header" class="jumbotron" >
            <div class="container">
                <h1>Welcome, D.CAMP</h1>
                <p>
                    은행권청년창업재단이 운영하는 대한민국 최초의 복합 창업 생태계 허브입니다.<br>
                    <a href="/about" class="btn">D.CAMP 소개 <i class="fa fa-angle-double-right"></i></a>
                </p>
            </div>
        </div>
        <!-- /jumbotron -->

        {contents_for_layout}
                
    </div>
    <!-- /rowContent -->

    <!-- footer -->
    <footer id="footer">
        <div class="container">
            <ul class="footer-navbar list-inline">
                <li><a href="/about">D.CAMP 소개</a></li>
                <li><a href="/membership">멤버십안내</a></li>
                <li><a href="/space">공간공유</a></li>
                <li><a href="/policy_service">서비스약관</a></li>
                <li><a href="/policy_privacy"><strong>개인정보취급방침</strong></a></li>
            </ul>
            <address>
                서울시 강남구 역삼동 683-34 새롬빌딩 4~6층 &nbsp;
                <span><i class="fa fa-phone"></i> (02) 2030-9300</span> &nbsp;
                <span><i class="fa fa-envelope-o"></i> <a href="mailto:contact@dcamp.kr">contact@dcamp.kr</a></span>
            </address>
            <p>Copyright &copy;D.CAMP. All rights reserved. <a href="http://www.podio.com" target="_blank">Thanks to Podio we keep work simple.</a></p>
        </div>
    </footer>
    <!-- /footer -->
</div>
<!-- /wrapper -->

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
