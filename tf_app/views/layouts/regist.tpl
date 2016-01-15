<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>D.CAMP &#8211; 은행권청년창업재단</title>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<link rel="shortcut icon" href="http://dcamp.kr/images/favicon.ico" type="image/x-icon" />
<link rel="icon" href="http://dcamp.kr/images/favicon.ico" type="image/x-icon" />

<!-- stylesheet -->
<link rel="stylesheet" href="/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/bootstrap-formhelpers.css" >
<link rel="stylesheet" href="/css/bootstrap-select.min.css" >
<link rel="stylesheet" href="/font-awesome/css/font-awesome.css" >
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
<!--[if IE 7]>
    <link rel="stylesheet" href="font-awesome/css/font-awesome-ie7.min.css">
<![endif]-->
<link rel="stylesheet" href="/css/site.css" >
<!--[if lt IE 9]>
    <link rel="stylesheet" type="text/css" href="/css/ie8-and-down.css" />
<![endif]-->

<!-- Javascrpt  -->
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
//-->
<script src="/js/script.js"></script>

<script>
  $(function() {
    $( ".datepicker" ).datepicker({ dateFormat: 'yy.mm.dd' }).val();
  });
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

<body id="regist">
<form name="hidden_form" action="/" method="post">
  <input type="hidden" name="c"/>
</form>
<!-- modal #md-warning -->
<div class="modal fade" id="md-warning" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content"> 
            <div class="modal-body">
                <div class="alert alert-warning text-center">                 
                 <p><strong><span class="icon-warning-sign"></span></strong>정말 삭제하시겠습니까?<br> 아래의 [삭제]를 클릭하시면 해당 내용은 완전히 삭제됩니다.</p>
                 <button class="btn btn-default btn-sm" data-dismiss="modal" >취소</button>
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

<!-- modal #md-alert -->
<div class="modal fade" id="md-alert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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

<!-- container -->
<div id="regist-member" class="container"> 

            {contents_for_layout}
            
    <!-- footer -->
    <div class="footer">
        <ul class="list-inline text-center">
            <li><a href="/policy_service">서비스이용약관</a></li>
            <li><a href="/policy_privacy">개인정보취급방침</a></li>
        </ul>
        <p class="text-center"> Copyright &copy <a href="/"><strong>D.CAMP</strong></a>. All rights reserved. <a href="http://www.podio.com" target="_blank">Thanks to Podio we keep work simple.</a></p>
    </div>
    <!-- /footer --> 
</div>
<!-- /container-->

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

