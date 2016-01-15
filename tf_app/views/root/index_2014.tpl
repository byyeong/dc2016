<script type="text/javascript" src="/js/jquery.vticker.min.js"></script>

<!-- rowContent -->
    <div class="rowContent" id="main"> 
        
        <section class="section" id="main-header">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-8" id="mainVisual">
                        {? banner.pic_1}
                        <!-- carousel-main -->
                        <div id="carousel-main" class="carousel slide" data-ride="carousel"> 
                              <ol class="carousel-indicators">
                                {? banner.active_1 && banner.pic_1}<li data-target="#carousel-main" data-slide-to="0" class="active"></li>{/}
                                {? banner.active_2 && banner.pic_2}<li data-target="#carousel-main" data-slide-to="1" {? !banner.active_1 || !banner.pic_1}class="active"{/}></li>{/}
                                {? banner.active_3 && banner.pic_3}<li data-target="#carousel-main" data-slide-to="2" {? !banner.active_1 && !banner.active_2}class="active"{/}></li>{/}
                              </ol>
                              <!-- /indicator -->
                              
                              <div class="carousel-inner">
                                {? banner.active_1 && banner.pic_1}
                                <div class="item active">
                                    <a href="{banner.url_1}" target="{banner.target_1}">
                                        <div class="carousel-img"><img src="{banner.pic_1}" ></div>
                                      <div class="carousel-caption ellipsis">
                                        {banner.des_1}
                                      </div>
                                    </a>
                                </div>
                                <!-- /item -->  
                                {/}{? banner.active_2 && banner.pic_2}
                                <div class="item {? !banner.active_1 || !banner.pic_1}active{/}">
                                    <a href="{banner.url_2}" target="{banner.target_2}">
                                      <div class="carousel-img"><img src="{banner.pic_2}" ></div>
                                      <div class="carousel-caption ellipsis">
                                        {banner.des_2}
                                      </div>
                                    </a>
                                </div>
                                <!-- /item -->   
                                {/}{? banner.active_3 && banner.pic_3}
                                <div class="item {? !banner.active_1 && !banner.active_2}active{/}">
                                    <a href="{banner.url_3}" target="{banner.target_3}">
                                      <div class="carousel-img"><img src="{banner.pic_3}" ></div>
                                      <div class="carousel-caption ellipsis">
                                        {banner.des_3}
                                      </div>
                                    </a>
                                </div>
                                <!-- /item -->                           
                                {/}
                              </div>
                              <!-- /inner -->
                              
                              <a class="left carousel-control" href="#carousel-main" data-slide="prev">
                                <span class="glyphicon glyphicon-chevron-left"></span>
                              </a>
                              <a class="right carousel-control" href="#carousel-main" data-slide="next">
                                <span class="glyphicon glyphicon-chevron-right"></span>
                              </a> 
                              <!-- / control -->
                        </div>
                        <!-- /carousel-main --> 
                        {:}
                        <a href="/about">
                        <img src=" /img/visaual_main01.jpg" class="img-responsive">
                        <p>D.CAMP는 은행권청년창업재단이 운영하는 <br>대한민국 최초의 복합 창업 생태계 허브입니다</p>
                        </a>
                        {/}
                    </div>
                    <!-- /col -->
                    
                    <div class="col-xs-12 col-sm-12 col-md-4" id="mainApply">
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-12 column membership">
                                <div class="pull-left  icon-object img-circle"> 
                                      <span class="icon-group  icon-light"></span> 
                                </div>
                                <div class="column-content">
                                    <a href="/membership">
                                        <h3>Membership </h3>
                                        <p>큰 꿈을 지닌 이들이 함께 모여 창업을 준비할 수 있는 열린 공간과 되는 다양한 교육·행사 참여의 기회를 드립니다.</p>  
                                        <span class="btn btn-default btn-sm">멤버십 신청하기</span>                                  
                                    </a>
                                </div>
                            </div>
                            <!-- /membership -->
                            
                            <div class="col-xs-12 col-sm-6 col-md-12 column roomsharing">
                                <div class="pull-left  icon-object img-circle">  
                                      <span class="icon-map-marker  icon-light"></span> 
                                </div> 
                                <div class="column-content">  
                                    <a href="/space">                         
                                        <h3>Room Sharing </h3>
                                        <p>여럿이 함께 모여 내일을 준비하는 공간, 여러분과 공유합니다.</p>
                                        <span class="btn btn-default btn-sm">공간공유 신청하기</span>
                                    </a>
                                </div>
                            </div>
                            <!-- /roomsharing -->   
                        </div>                    
                    </div>
                    <!-- /col -->
                   
                </div>
            </div>
        </section>
        <!-- /section -->
        
        <section class="section" id="media-schedule" >
            <div class="container "> 
                <div class="row">
                    <div id="lounge-now" class="col-xs-12 col-sm-12 col-md-4 pull-right"> 
                        <h3><span class="fa fa-users"></span> D.CAMP 라운지</h3> 
                        <a href="/lounge" class="btn btn-link btn-block">
                            현재 D.CAMP에 <span class="badge">{lounge_cnt}</span>명이 함께있습니다 
                            <i class="fa fa-long-arrow-right" rel="ev{ev_cnt}_en{en_cnt}"></i>
                        </a> 
                    </div>

                    <div id="schedule-news" class="col-xs-12 col-sm-12 col-md-8"> 
                        <a href="#" id="all-tick" class="btn btn-default btn-sm pull-right" onclick="open_c(); return false;"><span class="icon-reorder"></span> 전체 일정보기</a>
                        
                        <div class="pull-right">
                            <button id="prev-tick" class="btn btn-default btn-sm"><span class="icon-caret-left "></span><span class="sr-only">prev</span></button>
                            <button id="next-tick" class="btn btn-default btn-sm"><span class="icon-caret-right "></span><span class="sr-only">next</span></button>
                        </div>
                        
                        <h3><span class="icon-calendar"></span> D.CAMP 행사</h3>  

                    
                        <div class="ticker">
                            <div id="scroll-tickers">
                                <ul>
                                    {@ reserve}
                                    <li>
                                        <p>{.purpose}  {? .rel_url}<a class="btn btn-default btn-xs" href="{.rel_url}"><span class="icon-share"></span> 이벤트보기 </a>{/}</p>
                                        <small>
                                            <span class="spot"><span class="icon icon-map-marker"></span> {.opt}F {=explode_ext(.name, '(')}</span>
                                            <span class="time"><span class="icon icon-time"></span> {.date} {.start} ~ {.end}</span>
                                        </small>
                                    </li>
                                    {/}
                                </ul>
                            </div>
                        </div>
                        <script>
                            $(function() { 
                                 //vTicker
                                $('#scroll-tickers').vTicker('init', {
                                    speed: 400, 
                                    pause: 6000,
                                    showItems: 1,
                                    padding: 0
                                });
                                $('#next-tick').click(function() { 
                                    $('#scroll-tickers').vTicker('next', {animate:true});
                                });
                                $('#prev-tick').click(function() { 
                                    $('#scroll-tickers').vTicker('prev', {animate:true});
                                });
                            });
                            </script> 
                    </div>
                    <!-- / schedule-news -->
                     
                </div>

                <div  id="schedule-calendar" class="in"  style="height: auto;">
                </div>
                <!-- / schedule-calendar --> 
<script>
        function open_c() {
            var c = $('#schedule-calendar').hasClass("not_e");
            if (c === false) {
                var get_url = '/ajax/get_reserve_main/';
                $.post(get_url, function(_data){
                    $('#schedule-calendar').html(_data);
                    $('#schedule-calendar').addClass( "not_e" );
                });
            }
            else {
                $('#schedule-calendar').removeClass( "not_e" );
                $('#schedule-calendar').html('');
            }    

        }
</script>
            </div>
        </section>
        <section id="media-post" class="section">
            <div class="container ">
                <div id="metro" class="js-packery">
                <!-- brick grid Start -->
                {? r || date("Y-m-d H") > "2014-04-01 11" && date("Y-m-d H") < "2014-05-01 12"}   
                <div class="col-xs-12 col-sm-6 col-md-4 brick" data-groups='["event"]' > <span class="sort"><a href="/event">Event</a></span>
                    <div class="brick-head">
                        <h3 class="brick-heading"><a href="/event/book_promotions">스타트업 선배 창업자, 멘토들이 선정한 <br>창업자 필독서 30선.</a></h3>
                        <a href="/event/book_promotions" class="brick-object"> <img src="/img/event0401/book_promotion_banner_318x318.jpg" class="img-responsive">
                        </a> </div>
                    <div class="brick-body">
                        <div class="brick-status">
                            <dl class="dl-horizontal">
                                <dt>참여기간</dt>
                                <dd>2014.04.01 (화) 12:00 ~ 2014.05.01 (목) 12:00 </dd>
                                <dt>지원내용</dt>
                                <dd>매일 한분께 멘토가 선정한 필독서를 드립니다.</dd>
                                <dt>지원 자격</dt>
                                <dd> 디캠프 회원이신가요? 자신의 프로필을 완성하고,
                                    <br>
                                    개성있는 자기 소개를 작성해 주세요.
                                </dd>
                            </dl>
                        </div>
                    </div>
                </div>
                <!-- / brick -->          
                {/}

                {@ main}
                {?.cat == "event"}
                <div class="col-xs-12 col-sm-6 col-md-4 brick" data-groups='["event"]' > <span class="sort"><a href="/event">Event</a></span>
                    <div class="brick-head">
                        <h3 class="brick-heading"><a href="/event/apply/{.id}">{.title}</a></h3>
                        <a href="/event/apply/{.id}" class="brick-object"> <img src="{?.picture}{.picture}{:}/img/default-img-pic.png{/}" class="img-responsive">
                        <div class="brick-content">
                            <p class="ellipsis">{=strip_tags(.contents)}</p>
                        </div>
                        </a> </div>
                    <div class="brick-body">
                        <div class="brick-status">
                            <dl class="dl-horizontal">
                                <dt>신청기한</dt>
                                <dd>{=substr(.apply_end, 0, 10)} ({=date_to_day_only(.apply_end)})</dd>
                                <dt>행사일시</dt>
                                <dd>{.date} ({=date_to_day_only(.date)})</dd>
                                <dt>행사장소</dt>
                                <dd>{? .space_id == 0}{.space_etc}{:}{.opt}F {=explode_ext(.sname, '(')}{/} </dd>
                                <dt>신청현황</dt>
                                <dd>{? .enroll == 1}신청자 <span class="badge">{.rcnt}</span> / {/}정원 <span class="badge">{? .cnt}{.cnt}{:}제한없음{/}</span></dd>
                            </dl>
                        </div>
                        <div class="meta"> 
                            <span class="category"><a href="/event/ing/?type={.eid}">{.ename}</a></span> <span class="sep"></span> 
                            <span class="author"><a href="/member/{.ids}"><img src="{.mpicture}" class="img-circle"> {.mname}</a></span>, 
                            <span class="time">{=trans_date_ago(.date_created)}</span>, 
                            <span class="comment"><a href="/event/apply/{.id}#comment"><span class="icon-comment"></span> {.r_cnt} </a></span> <!--, 
                            <span class="click"><span class="icon-eye-open"></span> <span class="cnt">{.v_cnt}</span></span -->
                        </div>
                    </div>
                </div>
                <!-- / brick -->          
                {/}
                {?.cat == "notice"}
                <div class="col-xs-12 col-sm-4 col-md-4 brick" data-groups='["notice"]' >
                    <span class="sort"><a href="/notice">Notice</a></span>
                    <h3 class="brick-heading"><a href="/notice/views/{.type}/{.id}">{.title}</a></h3>
                    {?.main}<a href="/notice/views/{.type}/{.id}" class="brick-object"> 
                        <img src="{.main}" class="img-responsive"> 
                    </a> {/}
                    <div class="brick-body"> 
                        <p class="ellipsis">{=strip_tags(.contents)}</p> 
                        <div class="meta"> 
                            <span class="author"><a href="/member/{.ids}"><img src="{.picture}" class="img-circle"> {.name}</a></span>, 
                            <span class="time">{=trans_date_ago(.date_created)}</span>, 
                            <span class="comment"><a href="/notice/views/{.type}/{.id}#comment"><span class="icon-comment"></span> {.r_cnt} </a></span> <!--, 
                            <span class="click"><span class="icon-eye-open"></span> <span class="cnt">{.v_cnt}</span></span-->
                        </div>
                    </div>
                </div>
                <!-- / brick --> 
                {/}
                {?.cat == "people"}
                <div class="col-xs-12 col-sm-6 col-md-4 brick vcard" data-groups='["people"]' > 
                    <span class="sort"><a href="/network/people">People</a></span>
                    <div class="brick-head"> 
                        <h3 class="brick-heading"><a href="/member/{.ids}">{.name} <span class="btn btn-default btn-sm pull-right">프로필보기</span></a></h3>
                        <a href="/member/{.ids}" class="brick-object"> 
                            <div class="vimg"><div class="img-thumbnail"><div><span><img src="{.picture}"></span></div></div></div>
                            <div class="filter"><div style="background-image: url('{.picture}')"></div></div> 
                        </a> 
                    </div>
                    <div class="brick-body">
                        <p class="ellipsis">{.bio}</p> 
                    </div>
                </div>
                <!-- / brick -->
                {/}
                {?.cat == "startup"}
                <div class="col-xs-12 col-sm-6 col-md-4 brick vcard" data-groups='["startup"]' > 
                    <span class="sort"><a href="/network/startup">Startup</a></span> 
                    <div class="brick-head">
                        <h3 class="brick-heading"><a href="/startup/{.id}">Chinchin, Inc. <span class="btn btn-default btn-sm pull-right">프로필보기</span></a></h3>
                        <a href="/startup/{.id}" class="brick-object"> 
                            <div class="vimg"><div class="img-thumbnail"><div><span><img src="{.logo}"></span></div></div></div>
                            <div class="filter"><div style="background-image: url('{.logo}')"></div></div>  
                        </a> 
                    </div>
                    <div class="brick-body">
                        <p class="ellipsis">{.description}</p> 
                    </div>
                </div>
                <!-- / brick -->
                {/}
                {?.cat == "competition"}
                <div class="col-xs-12 col-sm-4 col-md-4 brick" data-groups='["competition"]' > 
                    <span class="sort"><a href="/competition">Competition</a></span>
                    <div class="brick-head">
                        <h3 class="brick-heading"><a href="/competition/views/{.id}">{.subject}</a></h3>
                        <a href="/competition/views/{.id}" class="brick-object"> 
                            <img src="{? .img}{.img}{:}/img/default-img-pic.png{/}" class="img-responsive"> 
                            <div class="brick-content"><p class="ellipsis">{=strip_tags(.contents)}</p> </div>
                        </a> 
                    </div>
                    <div class="brick-body">
                        <div class="brick-status">
                            <dl class="dl-horizontal">
                                {?.organized}
                                <dt>주최&middot;주관</dt>
                                <dd>{.organized}</dd>{/}
                                <dt>접수기간</dt>
                                <dd>{.date_s} ({=date_to_day_only(.date_s)}) {.time_s} ~ {.date_e} ({=date_to_day_only(.date_e)}) {.time_e}</dd>
                                <dt>발표일자</dt>
                                <dd>{.announce_d} ({=date_to_day_only(.announce_d)}) {.announce_t}</dd>
                            </dl>
                        </div>
                        <div class="meta"> <span class="author"><a href="/member/{.ids}"><img src="{.picture}" class="img-circle"> {.name}</a></span>, <span class="time">{=trans_date_ago(.date_created)}</span>, <span class="comment"><a href="/competition/views/{.id}#comment"><span class="icon-comment"></span> {.r_cnt} </a></span></div>
                    </div>
                </div>
                <!-- / brick -->
                {/}
                {/}

                {@ event}
                <div class="col-xs-12 col-sm-6 col-md-4 brick" data-groups='["event"]' > <span class="sort"><a href="/event">Event</a></span>
                    <div class="brick-head">
                        <h3 class="brick-heading"><a href="/event/apply/{.id}">{.title}</a></h3>
                        <a href="/event/apply/{.id}" class="brick-object"> <img src="{?.picture}{.picture}{:}/img/default-img-pic.png{/}" class="img-responsive">
                        <div class="brick-content">
                            <p class="ellipsis">{=strip_tags(.contents)}</p>
                        </div>
                        </a> </div>
                    <div class="brick-body">
                        <div class="brick-status">
                            <dl class="dl-horizontal">
                                <dt>신청기한</dt>
                                <dd>{=substr(.apply_end, 0, 10)} ({=date_to_day_only(.apply_end)})</dd>
                                <dt>행사일시</dt>
                                <dd>{.date} ({=date_to_day_only(.date)})</dd>
                                <dt>행사장소</dt>
                                <dd>{? .space_id == 0}{.space_etc}{:}{.opt}F {=explode_ext(.sname, '(')}{/} </dd>
                                <dt>신청현황</dt>
                                <dd>{? .enroll == 1}신청자 <span class="badge">{.rcnt}</span> / {/}정원 <span class="badge">{? .cnt}{.cnt}{:}제한없음{/}</span></dd>
                            </dl>
                        </div>
                        <div class="meta"> 
                            <span class="category"><a href="/event/ing/?type={.eid}">{.ename}</a></span> <span class="sep"></span> 
                            <span class="author"><a href="/member/{.ids}"><img src="{.mpicture}" class="img-circle"> {.mname}</a></span>, 
                            <span class="time">{=trans_date_ago(.date_created)}</span>, 
                            <span class="comment"><a href="/event/apply/{.id}#comment"><span class="icon-comment"></span> {.r_cnt} </a></span> <!--, 
                            <span class="click"><span class="icon-eye-open"></span> <span class="cnt">{.v_cnt}</span></span -->
                        </div>
                    </div>
                </div>
                <!-- / brick -->        
                {/}

                {@ recruit}
                <div class="col-xs-12 col-sm-4 col-md-4 brick" data-groups='["recruit"]' > 
                    <span class="sort"><a href="/recruit">Recruit</a></span>
                    <div class="brick-head">
                        <h3 class="brick-heading"><a href="/recruit/views/{.id}">{.title}</a></h3>  
                    </div>
                    <div class="brick-body">
                        
                        <div class="recruiter">
                            <a href="/startup/{.sid}">
                                <span class="p-img pull-left"><span><img src="{.logo}" class="img-responsive"></span></span>
                                <h4>{.sname}</h4>
                            </a>
                        </div>
                        <small class="tag"><span class="icon-tag"></span> {? .inv}{@ .inv}{? ..key_ == 0}{.._value}{:}, {.._value}{/}{/}{:}{@ .job}{? ..key_ == 0}{.._value}{:}, {.._value}{/}{/}{/}</small>
                        <div class="meta"> 
                            <span class="author"><a href="/member/{.ids}"><img src="{.mpicture}" class="img-circle"> {.mname}</a></span>, 
                            <span class="time">{=trans_date_ago(.date_created)}</span>, 
                            <span class="comment"><a href="/recruit/views/{.id}#comment"><span class="icon-comment"></span> {.r_cnt} </a></span> <!--, 
                            <span class="click"><span class="icon-eye-open"></span> <span class="cnt">{.v_cnt}</span></span -->
                        </div>
                    </div>
                </div>
                <!-- / brick -->                
                {/}
                
                <!--
                <div class="col-xs-12 col-sm-4 col-md-4 brick" data-groups='["notice"]' >
                    <a href="#" class="sort">Notice</a>
                    <a href="#" class="brick-object"> 
                        <img src="../img/default-img-pic.png" class="img-responsive"> 
                    </a> 
                    <div class="brick-body"> 
                        <h3 class="brick-heading"><a href="#">대림미술관과 함께 하는 청춘 PASS 강연 초대 이벤트!</a></h3>
                        <p class="ellipsis">어떤 음식이든지 간만 잘 맞아도 맛있게 먹을 수 있어요. 너무 싱겁거나 너무 짜면 음식 본연의 맛을 살릴 수 없죠. 사람마다 입맛이  </p> 
                        <div class="meta"> <span class="author"><a href="#"><img src="../img/default-img-member.png" class="img-circle"> Author</a></span>, <span class="time">2014.01.20</span> </div>
                    </div>
                </div>
                // brick --> 
                
                {@ contents}
                <div class="col-xs-12 col-sm-4 col-md-4 brick" data-groups='["contents"]' > 
                    <span class="sort"><a href="#">Contents</a></span>
                    {?.img}<a href="/contents/views/{.id}" class="brick-object"> 
                        <img src="{.img}" class="img-responsive"> 
                    </a> {/}
                    <div class="brick-body">
                        <h3 class="brick-heading"><a href="/contents/views/{.id}">{.subject}</a></h3>
                        <p class="ellipsis">{=strip_tags(.contents)}</p> 
                        <div class="meta"> 
                            <span class="author"><a href="/member/{.ids}"><img src="{.mpicture}" class="img-circle"> {.mname}</a></span>, 
                            <span class="time">{=trans_date_ago(.date_created)}</span>, 
                            <span class="comment"><a href="/contents/views/{.id}#comment"><span class="icon-comment"></span> {.r_cnt} </a></span> <!--, 
                            <span class="click"><span class="icon-eye-open"></span> <span class="cnt">{.v_cnt}</span></span -->
                        </div>
                    </div>
                </div>
                <!-- / brick -->
                {/}
                
                {@ competition}
                <div class="col-xs-12 col-sm-4 col-md-4 brick" data-groups='["competition"]' > 
                    <span class="sort"><a href="/competition">Competition</a></span>
                    <div class="brick-head">
                        <h3 class="brick-heading"><a href="/competition/views/{.id}">{.subject}</a></h3>
                        <a href="/competition/views/{.id}" class="brick-object"> 
                            <img src="{? .img}{.img}{:}/img/default-img-pic.png{/}" class="img-responsive"> 
                            <div class="brick-content"><p class="ellipsis">{=strip_tags(.contents)}</p> </div>
                        </a> 
                    </div>
                    <div class="brick-body">
                        <div class="brick-status">
                            <dl class="dl-horizontal">
                                {?.organized}
                                <dt>주최&middot;주관</dt>
                                <dd>{.organized}</dd>{/}
                                <dt>접수기간</dt>
                                <dd>{.date_s} ({=date_to_day_only(.date_s)}) {.time_s} ~ {.date_e} ({=date_to_day_only(.date_e)}) {.time_e}</dd>
                                <dt>발표일자</dt>
                                <dd>{.announce_d} ({=date_to_day_only(.announce_d)}) {.announce_t}</dd>
                            </dl>
                        </div>
                        <div class="meta"> 
                            <span class="author"><a href="/member/{.ids}"><img src="{.picture}" class="img-circle"> {.name}</a></span>, 
                            <span class="time">{=trans_date_ago(.date_created)}</span>, 
                            <span class="comment"><a href="/competition/views/{.id}#comment"><span class="icon-comment"></span> {.r_cnt} </a></span> <!--, 
                            <span class="click"><span class="icon-eye-open"></span> <span class="cnt">{.v_cnt}</span></span -->
                        </div>
                    </div>
                </div>
                <!-- / brick -->
                {/}

                <!-- brick grid End --> 
            </div>
        </div>
        </section>
            <!-- /metro -->

        <section class="section" id="media-news">
            <div class="container"> 
            
            <h3 class="section-heading">News <small><span class="sep">&Iota;</span> <a href="/news" class="moreview">More &rarr;</a></small></h3>

           <div class="crsl-carousel">
                <div id="crsl-news-nav" class="crsl-nav">
                    <a href="#" class="previous"><span class="icon-chevron-left"> <span class="sr-only">Previous</span></a>
                    <a href="#" class="next"><span class="icon-chevron-right"> <span class="sr-only">Next</span></a>
                </div>
                <div id="crsl-news-items" class="crsl-items" data-navigation="crsl-news-nav"> 
                    <div class="crsl-wrap"> 
                        {@ news1}
                        <div class="crsl-item media">
                             <div class="media-content"> <a href="/member/{.ids}" class="media-object pull-left"> <img title="{.name}" data-toggle="tooltip" class="img-circle" src="{.picture}"></a>
                                    <div class="ellipsis">{? strlen(.contents) > 256}{=mb_substr(.contents, 0, 256, 'EUC-KR')} <a href="/timeline/{.bid}">...</a>{:}{.contents}{/}</div>
                                    {?.sub}{.sub}{/}   
                                </div>
                                <div class="media-meta"><span class="time"><span class="fontawesome icon-time"></span><a href="/timeline/{.bid}">&nbsp;  {=trans_date_ago(.bdate_created)}</a></span></div>
                        </div>  
                        <!-- /media -->
                        {/}                           
                    </div>
                </div>
                
                <script src="/js/responsiveCarousel.js"></script>                  
                <script>
                $(function() {
                    $('.crsl-items').carousel_c( {  speed: 1000, autoRotate: 6000 , visible: 3, itemMinWidth: 380, itemMargin: -1 });
                });
                </script>   
            </div>
            <!-- / crsl-carosel -->
           
           </div>
        </section>
        <!-- /stream -->
            
            
        <section class="section" id="main-analytics" >
             <div class="container">
                
                <div class="col-xs-6 col-sm-4 col-md-2 item">
                     <div class=" icon-object">
                        <span class="icon-stack">
                          <i class="icon-circle icon-stack-base"></i>
                          <i class="icon-user icon-light"></i>
                        </span>
                    </div>
                    <strong>Member</strong>
                    <span class="cnt">{cnt_mem}</span>
                </div>
                <!-- /col --> 
               
                <div class="col-xs-6 col-sm-4 col-md-2 item">
                    <div class=" icon-object">
                        <span class="icon-stack">
                          <i class="icon-circle icon-stack-base"></i>
                          <i class="icon-building icon-light"></i>
                        </span>
                    </div>
                    <strong>Startup</strong>
                    <span class="cnt">{cnt_st}</span>
                </div>
                <!-- /col -->
                
                <div class="col-xs-6 col-sm-4 col-md-2 item">
                     <div class=" icon-object">
                        <span class="icon-stack">
                          <i class="icon-circle icon-stack-base"></i>
                          <i class="icon-calendar icon-light"></i>
                        </span>
                    </div>
                    <strong>Event</strong>
                    <span class="cnt">{cnt_ev}</span>
                </div>
                <!-- /col -->
                
                <div class="col-xs-6 col-sm-4 col-md-2 item">
                     <div class=" icon-object">
                        <span class="icon-stack">
                          <i class="icon-circle icon-stack-base"></i>
                          <i class="icon-briefcase  icon-light"></i>
                        </span>
                    </div>
                    <strong>Recruit</strong>
                    <span class="cnt">{cnt_rec}</span>
                </div>
                <!-- /col -->
                
                <div class="col-xs-6 col-sm-4 col-md-2 item">
                     <div class=" icon-object">
                        <span class="icon-stack">
                          <i class="icon-circle icon-stack-base"></i>
                          <i class="icon-file-text  icon-light"></i>
                        </span>
                    </div>
                    <strong>Contents</strong>
                    <span class="cnt">{cnt_cont}</span>
                </div>
                <!-- /col -->
                
                <div class="col-xs-6 col-sm-4 col-md-2 item">
                     <div class=" icon-object">
                        <span class="icon-stack">
                          <i class="icon-circle icon-stack-base"></i>
                          <i class="icon-trophy  icon-light"></i>
                        </span>
                    </div>
                    <strong>Competition</strong>
                    <span class="cnt">{cnt_comp}</span>
                </div>
                <!-- /col -->
                
             </div>
        </section>
        <!-- / -->

    </div>
    <!-- /rowContent --> 

<div id="md-linkEvent" class="modal fade">
</div>
<!-- modal -->


<script src="/js/packery.pkgd.min.js"></script> 
<script>
//<![CDAT
$(window).load(function() { 
    var $container = $('#metro');
    // initialize
    $container.packery({ 
      itemSelector: '.brick',
      gutter: 0
    });  
    var pckry = $container.data('packery');
    
    // $('#schedule-calendar').removeClass('in');
    // $('#schedule-calendar').addClass('collapse');
});

function get_event_space_link(_id)
{
    var get_url = '/ajax_front/get_event_link/'+_id;
    $.get(get_url, function(_data) {
        $('#md-linkEvent').html(_data);
    });
}
//]]>
</script> 