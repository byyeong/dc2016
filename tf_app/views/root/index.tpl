
    <!-- jumbotron -->
    <div id="jumbo-header" class="jumbotron" style="background-image:url(&quot;{ma.pic_1}&quot;);">
        <div class="container">
            <h1>{ma.des_1}</h1>
            <p>
                {ma.des_2}<br>
                <a href="{ma.url_1}" class="btn" target="{ma.target_1}">{ma.des_3} <i class="fa fa-angle-double-right"></i></a>
            </p>
            <ul class="list-inline nav-sns">
                <li>
                    <a id="fn-facebook" title="" data-placement="top" data-toggle="tooltip" href="https://www.facebook.com/dcamp.kr?ref=bookmarks" target="_blank" data-original-title="Facebook">
                        <i class="fa fa-facebook-square"></i>
                    </a>
                </li>
                <li>
                    <a id="fn-twitter" title="" data-placement="top" data-toggle="tooltip" href="https://twitter.com/Dcamp_kr" target="_blank" data-original-title="Twitter">
                        <i class="fa fa-twitter-square"></i>
                    </a>
                </li>
                <li>
                    <a id="fn-flickr" title="" data-placement="top" data-toggle="tooltip" href="https://www.flickr.com/photos/93969766@N06/" target="_blank" data-original-title="Flickr">
                        <i class="fa fa-flickr"></i>
                    </a>
                </li>
                <li>
                    <a id="fn-youtube" title="" data-placement="top" data-toggle="tooltip" href="https://www.youtube.com/channel/UCqsmYLUWkpphW-RgK9GZh7A" target="_blank" data-original-title="Youtube">
                        <i class="fa fa-youtube"></i>
                    </a>
                </li>
                <li>
                    <a id="fn-slideshare" title="" data-placement="top" data-toggle="tooltip" href="http://www.slideshare.net/dreamcamp/" target="_blank" data-original-title="Slideshare">
                        <i class="fa fa-slideshare"></i>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <!-- /jumbotron -->


    <!-- rowContent -->
    <div id="main" class="rowContent">
        <!-- Start -->

        <div id="connect-service">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12 col-sm-4 col-md-4">
                        <dl class="svc-membership">
                            <dt>Membership <small><a class="btn btn-link btn-xs" href="/membership">멤버십 신청하기<i class="fa fa-caret-right"></i></a></small></dt>
                            <dd>큰 꿈을 지닌 이들이 함께 모여 창업을 준비할 수 있는 열린 공간과 되는 다양한 교육&middot;행사 참여의 기회를 드립니다.</dd>
                        </dl>
                    </div>
                    <div class="col-xs-12 col-sm-4 col-md-4">
                        <dl class="svc-roomsharing">
                            <dt>Reservation <small><a class="btn btn-link btn-xs" href="/reservation">공간 예약하기<i class="fa fa-caret-right"></i></a></small></dt>
                            <dd>여럿이 함께 모여 내일을 준비하는 공간, 여러분과 공유합니다.</dd>
                        </dl>
                    </div>
                    <div class="col-xs-12 col-sm-4 col-md-4">
                        <dl class="svc-lounge">
                            <dt>Lounge <small><a class="btn btn-link btn-xs" href="/lounge">라운지 가기<i class="fa fa-caret-right"></i></a></small></dt>
                        <dd>현재 D.CAMP에 {lounge_cnt}명이 함께 있습니다.</dd>
                        </dl>
                    </div>
                </div>
            </div>
        </div>
        <!-- /connect-service -->

        
        <!-- recent-cards -->
        <div id="recent-cards">
            <div class="container">
            <div class="row">
                {@ main}
                {?.cat == "event"}
                <div class="item card col-xs-12 col-sm-4 col-md-3"> <!-- event -->
                    <div class="inner">
                        <a href="/event/apply/{.id}" class="featured-img">
                            <span style="background-image:url({?.picture}{.picture}{:}/img/default-img-pic.png{/});">
                                <img class="img-responsive" src="/images/img_trans.png" >
                            </span>
                            <img class="sr-only" src="{?.picture}{.picture}{:}/img/default-img-pic.png{/}" >
                        </a> 
                        <div class="caption">
                            <span class="category">Event</span> 
                            <h3>
                                <a href="/event/apply/{.id}" class="mulitple">
                                {.title}
                                </a>
                            </h3>
                            <dl class="dl-horizontal">
                                <dt>행사장소</dt>
                                <dd>{? .space_id == 0}{.space_etc}{:}{.opt}F {=explode_ext(.sname, '(')}{/}</dd>
                                <dt>행사일자</dt>
                                <dd>{.date}</dd>
                            </dl>
                        </div>
                        <div class="footer">
                            <span class="author">
                                <a href="/member/{.ids}" data-toggle="tooltip" data-placement="top" title="{.mname}">
                                    <img src="{.mpicture}" class="img-circle"> <span class="ellipsis">{.mname}</span>
                                </a>
                            </span>
                            <span class="date">{=str_replace("-", ".", substr(.date_created, 0, 10))}</span>
                        </div>
                    </div>
                </div>
                <!-- /item -->
                {/}
                {?.cat == "competition"}
                <div class="item card col-xs-12 col-sm-4 col-md-3"> <!-- competition -->
                    <div class="inner"> 
                        <a href="/challenge/views/{.id}" class="featured-img">
                            <span style="background-image:url({? .img}{.img}{:}/img/default-img-pic.png{/});">
                                <img class="img-responsive" src="/images/img_trans.png" >
                            </span>
                            <img class="sr-only" src="{? .img}{.img}{:}/img/default-img-pic.png{/}" >
                        </a> 
                        <div class="caption">
                            <span class="category">Challenge</span>
                            <h3>
                                <a href="/challenge/views/{.id}" class="mulitple">{.subject}</a>
                            </h3>
                            <dl class="dl-horizontal">
                                <dt>주최&middot;주관</dt>
                                <dd>{.organized}</dd>
                                <dt>접수기간</dt>
                                <dd>{.date_s} ~ {.date_e} </dd>
                            </dl>
                        </div>
                        <div class="footer">
                            <span class="author">
                                <a href="/member/{.ids}" data-toggle="tooltip" data-placement="top" title="{.name}">
                                    <img src="{.picture}" class="img-circle"> <span class="ellipsis">{.name}</span>
                                </a>
                            </span>
                            <span class="date">{=str_replace("-", ".", substr(.date_created, 0, 10))}</span>
                        </div>
                    </div>
                </div>
                <!-- /item -->
                {/}
                {?.cat == "office"}
                <div class="item card col-xs-12 col-sm-4 col-md-3"> <!-- office hours -->
                    <div class="inner"> 
                        <a href="/office_hours/views/{.id}" class="featured-img">
                            <span style="background-image:url({? .picture}{.picture}{:}/img/default-img-pic.png{/});">
                                <img class="img-responsive" src="/images/img_trans.png" >
                            </span>
                            <img class="sr-only" src="{? .picture}{.picture}{:}/img/default-img-pic.png{/}" >
                        </a> 
                        <div class="caption">
                            <span class="category">Office Hours</span>
                            <h3>
                                <a href="/office_hours/views/{.id}" class="mulitple">{.subject}</a>
                            </h3>
                            <dl class="dl-horizontal">
                                <dt>주최&middot;주관</dt>
                                <dd>{.hosted}</dd>
                                <dt>접수기간</dt>
                                <dd>{=substr(.a_start, 0, 10)} ~ {=substr(.a_end, 0, 10)} </dd>
                            </dl>
                        </div>
                        <div class="footer">
                            <span class="author">
                                <a href="/member/{.u.ids}" data-toggle="tooltip" data-placement="top" title="{.mname}">
                                    {?.mpicture}<img src="{.mpicture}" class="img-circle"> <span class="ellipsis">{/}{.mname}</span>
                                </a>
                            </span>
                            <span class="date">{=str_replace("-", ".", substr(.date_created, 0, 10))}</span>
                        </div>
                    </div>
                </div>
                <!-- /item -->
                {/}
                {?.cat == "notice"}
                <div class="item card col-xs-12 col-sm-4 col-md-3"> <!-- news -->
                    <div class="inner"> 
                        <a href="/notice/views/{.type}/{.id}" class="featured-img">
                            <span style="background-image:url({.main});">
                                <img class="img-responsive" src="/images/img_trans.png" >
                            </span>
                            <img class="sr-only" src="{.main}" >
                        </a> 
                        <div class="caption">
                            <span class="category">Notice</span>
                            <h3>
                                <a href="/notice/views/{.type}/{.id}" class="mulitple">{.title}</a>
                            </h3>
                            <p class="summary">
                                <span class="mulitple">
                                    {=strip_tags(.contents)}
                                </span>
                            </p>
                        </div>
                        <div class="footer">
                            <span class="author">
                                <a href="/member/{.ids}" data-toggle="tooltip" data-placement="top" title="{.name}">
                                    <img src="{.picture}" class="img-circle"> <span class="ellipsis">{.name}</span>
                                </a>
                            </span>
                            <span class="date">{=str_replace("-", ".", substr(.date_created, 0, 10))}</span>
                        </div>
                    </div>
                </div>
                <!-- /item -->
                {/}
                {?.cat == "content"}
                <div class="item card col-xs-12 col-sm-4 col-md-3"> <!-- content -->
                    <div class="inner"> 
                        <a href="/contents/views/{.id}" class="featured-img">
                            <span style="background-image:url({? .cpic}{.cpic}{:}{.img}{/});">
                                <img class="img-responsive" src="/images/img_trans.png" >
                            </span>
                            <img class="sr-only" src="{? .cpic}{.cpic}{:}{.img}{/}" >
                        </a> 
                        <div class="caption">
                            <span class="category">Blog</span>
                            <h3>
                                <a href="/contents/views/{.id}" class="mulitple">
                                    {.subject}
                                </a>
                            </h3>
                            <p class="summary">
                                <span class="mulitple">
                                    {=strip_tags(.contents)}
                                </span>
                            </p>
                        </div>
                        <div class="footer">
                            <span class="author">
                                <a href="/member/{.ids}" data-toggle="tooltip" data-placement="top" title="{.name}">
                                    <img src="{.picture}" class="img-circle"> <span class="ellipsis">{.name}</span>
                                </a>
                            </span>
                            <span class="date">{=str_replace("-", ".", substr(.date_created, 0, 10))}</span>
                        </div>
                    </div>
                </div>
                <!-- /item -->
                {/}
                {?.cat == "benefits"}
                <div class="item card col-xs-12 col-sm-4 col-md-3"> <!-- content -->
                    <div class="inner"> 
                        <a href="/benefits/views/{.id}" class="featured-img">
                            <span style="background-image:url({? .img}{.img}{:}/img/default-img-pic.png{/});">
                                <img class="img-responsive" src="/images/img_trans.png" >
                            </span>
                            <img class="sr-only" src="{? .img}{.img}{:}/img/default-img-pic.png{/}" >
                        </a> 
                        <div class="caption">
                            <span class="category">benefits</span>
                            <h3>
                                <a href="/benefits/views/{.id}" class="mulitple">
                                    {.title}
                                </a>
                            </h3>
                            <dl class="dl-horizontal">
                                <dt>지원기관</dt>
                                <dd>{.agency}</dd>
                                <dt>접수기관</dt>
                                <dd>{? .a_start}{=substr(.a_start, 0, 10)} ~ {=substr(.a_end, 0, 10)}{:}상시{/}</dd>
                            </dl>
                        </div>
                        <div class="footer">
                            <span class="author">
                                <a href="/member/{.u.ids}" data-toggle="tooltip" data-placement="top" title="{.u.name}">
                                    <img src="{.u.picture}" class="img-circle"> <span class="ellipsis">{.u.name}</span>
                                </a>
                            </span>
                            <span class="date">{=str_replace("-", ".", substr(.date_created, 0, 10))}</span>
                        </div>
                    </div>
                </div>
                <!-- /item -->
                {/}
                {/}
            </div><!-- /row -->
            </div><!-- /container -->
        </div>
        <!-- /recent-cards -->


        <div id="bind-cards">
            <div class="container">
                <div class="lead">
                    <div class="text-center">
                        <P>한국 창업 생태계 활성화를 위해 D.DAY, D.TALKS, D.PARTY 등<br> 다양한 형식의 이벤트와 프로그램을 진행합니다</P>
                    </div>
                </div>
                <!-- /lead -->

                <div class="bind">
                    <h3><a href="/event">Event</a></h3>

                    <ul class="list-unstyled row">
                        {@ event}
                        <li  class="col-xs-12 col-sm-6 col-md-4">
                            <div class="featured-img">
                                <a href="/event/apply/{.id}" data-toggle="tooltip" data-placement="top" title="{.mname}">
                                    <span style="background-image:url({?.picture}{.picture}{:}/img/default-img-pic.png{/});">
                                        <img src="/images/img_trans.png"  class="img-responsive">
                                    </span>
                                    <img src="{?.picture}{.picture}{:}/img/default-img-pic.png{/}" class="sr-only">
                                </a>
                            </div>
                            <div class="caption">
                                <h4>
                                    <a href="/event/apply/{ .id }" class="mulitple">
                                        {.title}
                                    </a>
                                </h4>
                            </div>
                        </li>
                        {/}
                    </ul>
                    <div class="more">
                        <a href="/event" class="label label-default">more <i class="fa fa-caret-right"></i></a>
                    </div>
                </div>
                <!-- /bind -->


                <div class="bind">
                    <h3><a href="/challenge">Challenge</a></h3>

                    <ul class="list-unstyled row">
                        {@ competition}
                        <li class="col-xs-12 col-sm-6 col-md-4">
                            <div class="featured-img">
                                <a href="/challenge/views/{.id}" data-toggle="tooltip" data-placement="top" title="{.name}">
                                    <span style="background-image:url({? .img}{.img}{:}/img/default-img-pic.png{/});">
                                        <img src="/images/img_trans.png"  class="img-responsive">
                                    </span>
                                    <img src="{? .img}{.img}{:}/img/default-img-pic.png{/}" class="sr-only">
                                </a>
                            </div>
                            <div class="caption">
                                <h4>
                                    <a href="/challenge/views/{ .id }" class="mulitple">
                                        {.subject}
                                    </a>
                                </h4>
                            </div>
                        </li>
                        {/}
                    </ul>
                    <div class="more">
                        <a href="/challenge" class="label label-default">more <i class="fa fa-caret-right"></i></a>
                    </div>
                </div>
                <!-- /bind -->


                <div class="bind">
                    <h3><a href="/contents">Blog</a></h3>

                    <ul class="list-unstyled row">
                        {@ contents}
                        <li class="col-xs-12 col-sm-6 col-md-4">
                            <div class="featured-img">
                                <a href="/contents/views/{.id}" data-toggle="tooltip" data-placement="top" title="{.mname}">
                                    <span style="background-image:url({? .picture}{.picture}{:}{? .img}{.img}{:}/img/default-img-pic.png{/}{/});">
                                        <img src="/images/img_trans.png"  class="img-responsive">
                                    </span>
                                    <img src="{? .img}{.img}{:}/img/default-img-pic.png{/}" class="sr-only">
                                </a>
                            </div>
                            <div class="caption">
                                <h4>
                                    <a href="/contents/views/{ .id }" class="mulitple">
                                        {.subject}
                                    </a>
                                </h4>
                            </div>
                        </li>
                        {/}
                    </ul>
                    <div class="more">
                        <a href="/contents" class="label label-default">more <i class="fa fa-caret-right"></i></a>
                    </div>
                </div>
                <!-- /bind -->


                <div class="bind">
                    <h3><a href="/recruit">Recruit</a></h3>

                    <ul class="list-unstyled row">
                        {@ recruit}
                        <li class="col-xs-12 col-sm-6 col-md-4">
                            <div class="featured-img">
                                <a href="/recruit/views/{.id}" data-toggle="tooltip" data-placement="top" title="{.sname}">
                                    <span style="background-image:url({.logo});">
                                        <img src="/images/img_trans.png"  class="img-responsive">
                                    </span>
                                    <img src="{.logo}" class="sr-only">
                                </a>
                            </div>
                            <div class="caption">
                                <h4><a href="/recruit/views/{.id}" class="mulitple">{.title}</a></h4>
                            </div>
                        </li>
                        {/}
                    </ul>
                    <div class="more">
                        <a href="/recruit" class="label label-default">more <i class="fa fa-caret-right"></i></a>
                    </div>
                </div>
                <!-- /bind -->
            </div>
            <!--/container-->
        </div>
        <!--/#bind-cards-->


    <!-- /End -->