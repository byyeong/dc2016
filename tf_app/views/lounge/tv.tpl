<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>D.CAMP</title>
    
    <link rel="shortcut icon" href="http://dcamp.kr/images/favicon.ico" type="image/x-icon" />
    <link rel="icon" href="http://dcamp.kr/images/favicon.ico" type="image/x-icon" />

    <link rel="stylesheet" href="/css/lounge-tv.css">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" > 
    <link rel="stylesheet" href="/css/superslides.css"> 
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>  

    <script src="/js/jquery.easing.1.3.js"></script>
    <script src="/js/jquery.animate-enhanced.min.js"></script>
    <script src="/js/jquery.superslides.js" type="text/javascript" charset="utf-8"></script>
 
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]--> 

    <script src="/js/jquery.ellipsis.js"></script> 

    <script>
        $(document).ready(function() {
            $('.ellipsis').ellipsis({
                row: 1
            });
            $('.mulitple').ellipsis({
                row: 2
            }); 
            $('.triple').ellipsis({
                row: 3
            }); 
            $('.quintuple').ellipsis({
                row: 4
            }); 

            $('#vcardSlides').superslides({
                hashchange: false,
                animation: 'fade',
                play: 16000,
                inherit_width_from: '#vcardList',
                inherit_height_from: '#vcardList'
            });
            $('#eventSlides').superslides({
                hashchange: false,
                play: 8000,
                inherit_width_from: '#nowEvent',
                inherit_height_from: '#nowEvent'
            });
        });      
    </script> 
    

</head>
<body> 
 
<!-- wrapper -->
<div class="wrapper">

    <!-- jumbotron -->
    <div id="jumbo-header" class="jumbotron" style="background-image:url(/images/main-tv.png);">
        <div class="container">
            <h1>D.CAMP LOUNGE</h1>
            <p>We are all connected</p>
        </div>
    </div>
    <!-- /jumbotron -->

    <!-- rowContent -->
    <div class="rowContent">
        <!-- Start -->
        <div class="container-fluid">
            <div class="row">


                <div id="vcardList" class="col-lg-9">
                    <!-- vcardSlides -->
                    <div id="vcardSlides">
                        <div class="slides-container">
                            <!-- slide-wrap -->
                            {@ users}
                            {? .key_ % 8 == 0}<div class="slide-wrap">
                                <div class="row">{/}
                                    {? .msg}
                                    <div class="item vcard vcard2 col-lg-3" id="vcard_{.id}">
                                        <div class="inner">
                                            <div class="vcard-heading">
                                                <div class="vimg">
                                                    <div style="background-image:url({.picture});">
                                                        <img src="/images/img_trans.png">
                                                    </div>
                                                </div>
                                                <h2 class="ellipsis">{.name}</h2>
                                                <strong class="tag ellipsis">{.com.name}</strong>
                                                <small class="tag ellipsis">{.com.role}</small>
                                            </div>
                                            <div class="vcard-body">
                                                <p class="quintuple">{.msg}</p>
                                            </div>
                                        </div>
                                    </div>
                                    {:}
                                    <div class="item vcard col-lg-3" id="vcard_{.id}">
                                        <div class="inner">
                                            <div class="vcard-heading">
                                                <div class="vimg">
                                                    <div style="background-image:url({.picture});">
                                                        <img src="/images/img_trans.png">
                                                    </div>
                                                </div>
                                                <h2 class="ellipsis">{.name}</h2>
                                                <strong class="tag ellipsis">{.com.name}</strong>
                                                <small class="tag ellipsis">{.com.role}</small>
                                            </div>
                                        </div>
                                    </div>
                                    {/}
                                    <!-- /vcard -->
                                {? (.key_ % 8 == 7) || (sizeof(users) == .key_ +1)}</div>
                            </div>{/}
                            {/}
                            <!-- /slide-wrap -->
                        </div>
                        <!-- /slide-container --> 
                    </div>
                    <!-- /vcardSlides -->
                </div>
                <!-- /vcardList -->

                <div id="nowEvent" class="col-lg-3">
                    <!-- eventSlides -->
                    <div id="eventSlides">
                        <div class="slides-container">
                            {@ event}{? .cat}
                            <!-- slide-wrap -->
                            <div class="slide-wrap">
                                <div class="item card">
                                    <div class="inner">

                                        {? .cat == "event"}
                                        <div class="featured-img">
                                            {? .picture}
                                            <span style="background-image:url({?.picture}{.picture}{:}/img/default-img-pic.png{/});">
                                                <img class="img-responsive" src="/images/img_trans.png" >
                                            </span>
                                            {/}
                                        </div> 
                                        <div class="caption">
                                            <span class="category">EVENT</span>
                                            <h3 class="mulitple">
                                                {.title}
                                            </h3>
                                            <dl class="dl-horizontal">
                                                <dt>행사장소</dt>
                                                <dd class="ellipsis">{? .space_id == 0}{.space_etc}{:}{.opt}F {=explode_ext(.sname, '(')}{/}</dd>
                                                <dt>행사일자</dt>
                                                <dd>{?.date}{.date}{/}{?.date_e} ~ {.date_e}{/}</dd>
                                            </dl>
                                        </div>
                                        {/}
                                        
                                        {? .cat == "competition"}
                                        <div class="featured-img">
                                            {? .picture}
                                            <span style="background-image:url({? .img}{.img}{:}/img/default-img-pic.png{/});">
                                                <img class="img-responsive" src="/images/img_trans.png" >
                                            </span>
                                            {/}
                                        </div> 
                                        <div class="caption">
                                            <span class="category">COMPETITION</span>
                                            <h3 class="mulitple">
                                                {.subject}
                                            </h3>
                                            <dl class="dl-horizontal">
                                                <dt>주최&middot;주관</dt>
                                                <dd class="ellipsis">{.organized}</dd>
                                                <dt>접수기간</dt>
                                                <dd>{.date_s} ~ {.date_e}</dd>
                                            </dl>
                                        </div>
                                        {/}

                                        {? .cat == "office"}
                                        <div class="featured-img">
                                            {? .picture}
                                            <span style="background-image:url({? .picture}{.picture}{:}/img/default-img-pic.png{/});">
                                                <img class="img-responsive" src="/images/img_trans.png" >
                                            </span>
                                            {/}
                                        </div> 
                                        <div class="caption">
                                            <span class="category">OFFICE HOURS</span>
                                            <h3 class="mulitple">
                                                {.subject}
                                            </h3>
                                            <dl class="dl-horizontal">
                                                <dt>주최&middot;주관</dt>
                                                <dd class="ellipsis">{.hosted}</dd>
                                                <dt>접수기간</dt>
                                                <dd>{=substr(.a_start, 0, 10)} ~ {=substr(.a_end, 0, 10)}</dd>
                                            </dl>
                                        </div>
                                        {/}

                                        {? .cat == "notice"}
                                        <div class="featured-img">
                                            {? .picture}
                                            <span style="background-image:url({.main});">
                                                <img class="img-responsive" src="/images/img_trans.png" >
                                            </span>
                                            {/}
                                        </div> 
                                        <div class="caption">
                                            <span class="category">NOTICE</span>
                                            <h3 class="mulitple">
                                                {.title}
                                            </h3>
                                            <p class="summary">
                                                <span class="mulitple">
                                                    {=strip_tags(.contents)}
                                                </span>
                                            </p>
                                        </div>
                                        {/}

                                        {? .cat == "content"}
                                        <div class="featured-img">
                                            {? .picture}
                                            <span style="background-image:url({.img});">
                                                <img class="img-responsive" src="/images/img_trans.png" >
                                            </span>
                                            {/}
                                        </div> 
                                        <div class="caption">
                                            <span class="category">CONTENT</span>
                                            <h3 class="mulitple">
                                                {.subject}
                                            </h3>
                                            <p class="summary">
                                                <span class="mulitple">
                                                    {=strip_tags(.contents)}
                                                </span>
                                            </p>
                                        </div>
                                        {/}{/}
                                    </div>
                                </div>
                                <!-- /item -->
                           </div>
                            <!-- /slide-wrap -->
                            {/}
                        </div>
                    </div>
                    <!-- /eventSlides -->
                </div>
                <!-- /nowEvent -->





            </div>
        </div>
        <!-- /End -->
    </div>
    <!-- /rowContent --> 
</div>
<!-- /wrapper -->






<!-- Button trigger modal -->
<!--button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#popModal">
  새글 모달 띄우기 
</button-->

<!-- Modal -->
<div class="modal fade" id="popModal" tabindex="-1" role="dialog" aria-labelledby="popModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">  
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> 
                <div class="media">
                    <div class="media-left">
                        <div class="vimg">
                            <div id="vimg" style="background-image:url(https://graph.facebook.com/v2.2/876084195763054/picture?redirect=1&type=large);">
                                <img src="../images/img_trans.png">
                            </div>
                        </div>
                    </div>
                    <div class="media-body">
                        <h4 class="media-heading">Jongwoo Kim <small>2015.02.25 오후 2:53</small></h4>
                        <p>
                        많이 우리 거친 품고 몸이 것이다. 청춘의 지혜는 이상 이상은 만물은 용기가 발휘하기 이것이다. 가치를 있는 그들의 열락의 ? 할지라도 대한 뜨거운지라, 것이다. 갑 노년에게서 힘차게 위하여, 그들은 방지하는 것이다. 이상은 지혜는 우리 않는 때문이다. 인간에 그들은 평화스러운 있는 불러 봄바람이다. 그들의 이는 눈에 밝은 위하여 아니더면, 수 때문이다. 이상의 뜨거운지라, 놀이 청춘을 그러므로 무한한 황금시대다. 할지라도 뼈 현저하게 두손을 사막이다.
                        </p>
                    </div>
                </div>
            </div> 
        </div>
    </div>
</div>

<script type="text/javascript">
//<![CDATA[

cur_id = 0;

$(function() {
    timer = setInterval( function () {
        $.ajax ({
            url : '/ajax_v2/check_tv/' + cur_id,  // ----- (1)
            dataType : "json",
            cache : false,
            success : function (_data) { // ----- (2)
                if (_data.id) {
                    cur_id = _data.id;
                }
                if (_data.pic) {
                    $("#popModal #vimg").css('background-image', 'url(' + _data.pic + ')');
                    $("#popModal .media-heading").html(_data.name+" <small>"+_data.date+"</small>");
                    $("#popModal p").html(_data.content);
                    $("#popModal").modal('show');
                    update_tv();
                    close_modal();
                }
            }
        });
    }, 1000 * 20); 
});

$(function() {
    timer = setInterval( function () {
        update_tv();
    }, 1000 * 60 * 3); 
});

function close_modal() {
    setTimeout(function(){
        $("#popModal").modal('hide');
    }, 10000);
}

function update_tv() {
    $.ajax ({
        url : '/ajax_v2/update_tv',  // ----- (1)
        dataType : "html",
        cache : false,
        success : function (_data) { // ----- (2)
            $('#vcardList').html("");
            $('#vcardList').html(_data);
            
            $('#vcardSlides').superslides({
                hashchange: false,
                animation: 'fade',
                play: 16000,
                inherit_width_from: '#vcardList',
                inherit_height_from: '#vcardList'
            });
            $('.ellipsis').ellipsis({
                row: 1
            });
            $('.mulitple').ellipsis({
                row: 2
            }); 
            $('.triple').ellipsis({
                row: 3
            }); 
            $('.quintuple').ellipsis({
                row: 4
            }); 

            check_rolling();
        }
    });
}

check_rolling();
function check_rolling() {   
    if ($('#vcardSlides .slide-wrap').size() == 1) {
        $('#vcardSlides').superslides('stop');
    }
}

//]]>
</script> 

</body>
</html>