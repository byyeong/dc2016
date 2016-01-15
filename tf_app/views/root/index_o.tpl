
<!-- rowContent -->
<div class="rowContent"> 
    <!-- container -->
    <div class="container">
        <div id="grid"> 
            
            <input type="hidden" id="page" value="{page}" />
            {? c == "event"}
            <div class="col-xs-12 col-sm-4 col-md-3 item title" data-groups='["event"]' data-sor='["all"]'> 
                <div class="inner filter-options">
                    <h2><span><img src="/img/item-title-event.png" class="img-responsive"></span>Event</h2>
                    
                    <div class="item-sort">
                        <select class="selectpicker sort-options" data-width="auto" >
                            <option value="ing">진행중인 이벤트</option>
                            <option value="end">종료된 이벤트</option>
                        </select>
                     </div>
                     
                     <div class="item-add">
                         {? (s.per & settings->permission4) == settings->permission4 || (s.per & settings->permission1) == settings->permission1}
                         <button class="btn btn-default" onclick="javascript:document.location.href='/event/add'"><span class="icon-pencil"></span> 이벤트 만들기</button>
                         {:}
                         {? s}
                         <button class="btn btn-default" onclick="alert('이벤트 만들기는 멤버십 회원에게만 제공됩니다.<br>멤버십에 먼저 가입해주세요.')"><span class="icon-pencil"></span> 이벤트 만들기</button>
                         {:}
                         <button class="btn btn-default" onclick="alert('이벤트 만들기는 디캠프 멤버십 회원에게 제공됩니다.<br>이미 가입하셨다면 로그인 후 진행해주세요.')"><span class="icon-pencil"></span> 이벤트 만들기</button>
                         {/}
                         {/}
                     </div>

                     <!--
                     <div class="item-add">
                        <button class="btn btn-default" data-groups="ing"><span class="icon-pencil"></span> 진행중인 이벤트</button>
                     </div>
                     <div class="item-add">
                        <button class="btn btn-default" data-groups="end"><span class="icon-pencil"></span> 종료된 이벤트</button>
                     </div>
                    //-->
                </div>
            </div>
            <!--/item -->
            {/}
            
            {? c == "startup"}
            <div class="col-xs-12 col-sm-4 col-md-3 item title" data-groups='["startup"]' > 
                <div class="inner">
                    <h2><span><img src="/img/item-title-startup.png" class="img-responsive"></span>Startup</h2>
                </div>
            </div>
            <!--/item -->
            {/}
            {? c == "people"}
            <div class="col-xs-12 col-sm-4 col-md-3 item title" data-groups='["people"]' > 
                <div class="inner">
                    <h2><span><img src="/img/item-title-people.png" class="img-responsive"></span>People</h2>
                </div>
            </div>
            <!--/item --> 
            {/}
            {? c == "recruit"}
            <div class="col-xs-12 col-sm-4 col-md-3 item title" data-groups='["recruit"]' > 
                <div class="inner">
                    <h2><span><img src="/img/item-title-recruit.png" class="img-responsive"></span>Recruit</h2>
                    <div class="item-add">
                        {? s}
                        {? no_rec}
                        <button class="btn btn-default" onclick="alert('채용정보를 작성할 수 있는 권한을 가진 스타트업 정보가 없습니다.');"><span class="icon-pencil"></span> 채용정보 작성하기</button>
                        {:}
                        <button class="btn btn-default" onclick="javascript:location.href='/recruit/add'"><span class="icon-pencil"></span> 채용정보 작성하기</button>
                        {/}
                        {:}
                        <button class="btn btn-default" onclick="alert('채용정보 작성을 위해 로그인 해주세요.')"><span class="icon-pencil"></span> 채용정보 작성하기</button>
                        {/}
                    </div>
                </div>
            </div>
            <!--/item --> 
            {/}
            
            {? c == "notice"}
            <div class="col-xs-12 col-sm-4 col-md-3 item title" data-groups='["news"]' > 
                <div class="inner">
                    <h2><span><img src="/img/item-title-news.png" class="img-responsive"></span>Notice</h2>
                </div>
            </div>
            <!--/item --> 
            {/}
            
            {? c == "competition"}
            <div class="col-xs-12 col-sm-4 col-md-3 item title" data-groups='["competition"]' > 
                <div class="inner">
                    <h2><span><img src="/img/item-title-competition.png" class="img-responsive"></span>Competition</h2>
                    <div class="item-add">
                        {? s}
                        <button class="btn btn-default" onclick="javascript:location.href='/competition/edit'"><span class="icon-pencil"></span> 경진대회 만들기</button>
                        {:}
                        <button class="btn btn-default" onclick="alert('경진대회 만들기는 디캠프 회원에게 제공됩니다.<br>로그인 후 진행해주세요.')"><span class="icon-pencil"></span> 경진대회 만들기</button>
                        {/}
                    </div>
                </div>
            </div>
            <!--/item --> 
            {/}
            
            {? !c}
            <!--
            <div class="col-xs-12 col-sm-4 col-md-3 item type1 about" data-groups='["about"]' > 
                <div class="inner">
                     <a href="/about">
                        <div class="imgbox"><img src="/img/grid-about-img.png" class="img-responsive  img-thumb"></div>
                        <div class="sort"><strong>About</strong></div>
                        <h3>D.CAMP는  은행권청년창업재단이 운영하는 대한민국 최초의 복합 창업 생태계 허브입니다. </h3>
                    </a>
                </div>
            </div>
            //-->
            
            {? banner.pic_1}
            <div class="col-xs-12 col-sm-4 col-md-3 item type1 sbanner" data-groups='["about"]' >
                <div class="inner"> 
                    <!-- carousel -->
                    <div id="carousel-main-generic" class="carousel slide"> 

                        <!-- Indicators -->
                        <ol class="carousel-indicators">
                            {? banner.pic_1}<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>{/}
                            {? banner.pic_2}<li data-target="#carousel-example-generic" data-slide-to="1"></li>{/}
                            {? banner.pic_3}<li data-target="#carousel-example-generic" data-slide-to="2"></li>{/}
                        </ol>

                        <!-- Wrapper for slides -->
                        <div class="carousel-inner">
                            {? banner.pic_1}<div class="item active"> <a href="{banner.url_1}" target="{banner.target_1}"><img src="{banner.pic_1}" class="img-responsive" ></a> </div>{/}
                            {? banner.pic_2}<div class="item"> <a href="{banner.url_2}" target="{banner.target_2}"><img src="{banner.pic_2}" class="img-responsive" ></a> </div>{/}
                            {? banner.pic_3}<div class="item"> <a href="{banner.url_3}" target="{banner.target_3}"><img src="{banner.pic_3}" class="img-responsive" ></a> </div>{/}
                        </div>

                        <!-- Controls --> 
                        <a class="left carousel-control" href="#carousel-main-generic" data-slide="prev"> <span class="icon-prev"></span> </a> 
                        <a class="right carousel-control" href="#carousel-main-generic" data-slide="next"> <span class="icon-next"></span> </a> 

                    </div>
                    <!-- /carousel --> 
                </div>
            </div>
            <!--/item -->
            {/}
            
            {@ main}
            {? .key_ == 2}
            <div class="col-xs-12 col-sm-4 col-md-3 item type2 membership" data-groups='["about"]' > 
                <div class="inner">
                 <a href="/membership">
                    <div class="imgbox"><span><img src="/img/default-img-membership.png" data-src="" class="img-responsive"></span></div>                    
                    <h3>Membership</h3>
                </a>
                </div>
            </div>
            <!--/item -->
            <div class="col-xs-12 col-sm-4 col-md-3 item type2 space" data-groups='["about"]' > 
                <div class="inner">
                 <a href="/space">
                    <div class="imgbox"><span><img src="/img/default-img-space.png" data-src="" class="img-responsive"></span></div> 
                    <h3>Room Sharing</h3>
                </a>
                </div>
            </div>
            <!--/item -->
            {/}
            {? .cat == "event"}
            <div class="col-xs-12 col-sm-4 col-md-3 item type1" data-groups='["event"]' > 
                <div class="inner">
                    <a href="/event/apply/{.id}">
                        <div class="imgbox"><img src="{?.picture}{.picture}{:}/img/default-img-pic.png{/}"  data-src="" class="img-responsive img-thumb"></div>
                        <div class="sort"><strong>Event</strong></div>
                        {? dateDiff(.date, date('y.m.d'), '.') > -1}<div class="d-day img-circle">D-{=dateDiff(.date_e, date('y.m.d'), '.')}</div>{/}
                        <div class="caption">
                            <h3 class="ellipsis">{? dateDiff(.apply_end, date('y.m.d H:i'), '.') < 0}<span class="label label-default">완료</span> {/}{.title}</h3>
                            <span class="date"><span class="icon-calendar"></span> {.date}</span>
                        </div>
                    </a>
                </div>
            </div>
            {/}   
            <!--/item -->
            {? .cat == "news"}
            {? .main}
            <div class="col-xs-12 col-sm-4 col-md-3 item type1" data-groups='["news"]' > 
                <div class="inner">
                    <a href="/news/views/{.type}/{.id}">
                        <div class="imgbox">
                            <img src="{.main}" data-src=""  class="img-responsive  img-thumb" >
                        </div>
                        <div class="sort"><strong>{? .type == 1}News{/}{? .type == 3}Notice{/}</strong></div>
                        <div class="caption">
                            <h3 class="ellipsis">{.title}</h3>
                            <span class="date"><span class="icon-time"></span> {=substr(str_replace("-",".",.date_created), 0, 10)}</span>
                        </div>
                    </a>               
                </div>
            </div>
            {:}
            <div class="col-xs-12 col-sm-4 col-md-3 item type2" data-groups='["news"]' > 
                <div class="inner">
                    <a href="/news/views/{.type}/{.id}">
                        <div class="imgbox"><span>
                            <img {? .type == 1}src="/img/default-img-news.png"{/}{? .type == 3}src="/img/default-img-notice.png"{/}  data-src=""  class="img-responsive">
                            </span>
                        </div>
                        <div class="sort"><strong>{? .type == 1}News{/}{? .type == 3}Notice{/}</strong></div>
                        <h3 class="ellipsis">{.title}</h3>
                        <span class="date"><span class="icon-time"></span> {=substr(str_replace("-",".",.date_created), 0, 10)}</span>     
                    </a>               
                </div>
            </div>
            {/}
            {/}
            <!--/item -->
            {/}
            {/}
            
            {@ res}
            
            {?!c || c == 'event'}
            {? .cat == "event"}
            <div class="col-xs-12 col-sm-4 col-md-3 item type1" data-groups='["event", "{? dateDiff(.date_e, date('Y.m.d'), '.') < 0}end{:}ing{/}"]' data-sor='["{? dateDiff(.date_e, date('Y.m.d'), '.') < 0}end{:}ing{/}"]'> 
                <div class="inner">
                    <a href="/event/apply/{.id}">
                        <div class="imgbox"><img src="{?.picture}{.picture}{:}/img/default-img-pic.png{/}"  data-src="" class="img-responsive img-thumb"></div>
                        {? dateDiff(.date, date('y.m.d'), '.') > -1}<div class="d-day img-circle">D-{=dateDiff(.date, date('y.m.d'), '.')}</div>{/}
                        <div class="sort"><strong>Event</strong></div>
                        <div class="caption">
                            <h3 class="ellipsis">{? dateDiff(.apply_end, date('y.m.d H:i'), '.') < 0}<span class="label label-default">완료</span> {/}{.title}</h3>
                            <span class="date"><span class="icon-calendar"></span> {.date}</span>
                        </div>
                    </a>
                </div>
            </div>
            {/}   
            <!--/item -->
            {/}
            
            {?!c || c == 'startup'}
            {? .cat == "startup"}
            <div class="col-xs-12 col-sm-4 col-md-3 item type2" data-groups='["startup"]' > 
                <div class="inner">
                    <a href="/startup/{.id}" >
                        <div class="imgbox"><div><span><img src="{? .logo}{.logo}{:}/img/default-img-company.png{/}"  data-src="" class="img-responsive"></span></div></div>
                        <div class="sort"><strong>Startup</strong></div>
                        <h3>{.name} </h3>
                        <p class="ellipsis">{.bio}</p>
                    </a>
                </div>
            </div>             
            {/}
            <!--/item -->
            {/}
            
            {?!c || c == 'people'}
            {? .cat == "people"}
            <div class="col-xs-12 col-sm-4 col-md-3 item type2" data-groups='["people"]' > 
                <div class="inner">
                    <a href="/member/{.ids}">
                        <div class="imgbox"><div><span><img src="{? .picture}{.picture}{:}/img/default-img-member.png{/}"  data-src="" class="img-responsive"></span></div></div>
                        <div class="sort"><strong>People</strong></div>
                        <h3>{.name}</h3>
                        <p class="ellipsis">{=strip_tags(.last_edit)}</p>
                    </a>
                </div>
            </div>
            {/}
            <!--/item -->
            {/}
            
            {?!c || c == 'recruit'}
            {? .cat == "recruit"}
            <div class="col-xs-12 col-sm-4 col-md-3 item type2" data-groups='["recruit"]' >
                <div class="inner">
                    <a href="/recruit/views/{.rid}">
                        <div class="imgbox"><div><span><img src="{?.logo}{.logo}{:}/img/default-img-company.png{/}" class="img-responsive"></span></div></div>
                        <div class="sort"><strong>Recruit</strong></div>
                        <h3 class="ellipsis">{.title}</h3> 
                    </a>
                </div>
            </div>
            {/}
            <!--/item -->
            {/}
            
            {?!c || c == 'notice'}
            {? .cat == "news"}
            {? .main}
            <div class="col-xs-12 col-sm-4 col-md-3 item type1" data-groups='["news"]' > 
                <div class="inner">
                    <a href="/notice/views/{.type}/{.id}">
                        <div class="imgbox">
                            <img src="{.main}" class="img-responsive  img-thumb" >
                        </div>
                        <div class="sort"><strong>{? .type == 1}News{/}{? .type == 3}Notice{/}</strong></div>
                        <div class="caption">
                            <h3 class="ellipsis">{.title}</h3>
                            <span class="date"><span class="icon-time"></span> {=substr(str_replace("-",".",.date_created), 0, 10)}</span>   
                        </div>
                    </a>               
                </div>
            </div>
            {:}
            <div class="col-xs-12 col-sm-4 col-md-3 item type2" data-groups='["news"]' > 
                <div class="inner">
                    <a href="/notice/views/{.type}/{.id}">
                        <div class="imgbox"><span>
                            <img {? .type == 1}src="/img/default-img-news.png"{/}{? .type == 3}src="/img/default-img-notice.png"{/}  data-src=""  class="img-responsive">
                            <span>
                        </div>
                        <div class="sort"><strong>{? .type == 1}News{/}{? .type == 3}Notice{/}</strong></div>
                        <h3 class="ellipsis">{.title}</h3>
                        <span class="date"><span class="icon-time"></span> {=substr(str_replace("-",".",.date_created), 0, 10)}</span>         
                    </a>               
                </div>
            </div>
            {/}
            {/}
            {/}
            
            {?!c || c == 'competition'}
            {? .cat == "competition"}
            <div class="col-xs-12 col-sm-4 col-md-3 item type1" data-groups='["competition"]'> 
                <div class="inner">
                    <a href="/competition/views/{.id}">
                        <div class="imgbox"><img src="{?.img}{.img}{:}/img/default-img-pic.png{/}"  data-src="" class="img-responsive img-thumb"></div>
                        {? dateDiff(.date_s, date('y.m.d'), '.') > -1}<div class="d-day img-circle">D-{=dateDiff(.date_s, date('y.m.d'), '.')}</div>{/}
                        <div class="sort"><strong>Competition</strong></div>
                        <div class="caption">
                            <h3 class="ellipsis">{? dateDiff(.date_e, date('y.m.d H:i'), '.') < 0}<span class="label label-default">완료</span> {/}{.subject}</h3>
                            <span class="date"><span class="icon-calendar"></span> {.date_s}</span>
                        </div>
                    </a>
                </div>
            </div>
            {/}
            <!--/item -->
            {/}
            
            {/}
            <div class="col-xs-12 col-sm-4 col-md-3 shuffle_sizer"></div>
            
                   
        </div>
        
    </div>
    <!-- /container -->     
</div>
<!-- /rowContent --> 

<script src="/js/adding-removing.js"></script>
<script type="text/javascript">
//<![CDATA[
{? msg}
    alert('{msg}');
{/}
    
$(window).scroll(function(){
    if ($(window).scrollTop() === $(document).height() - $(window).height()){
        var v = $("#page").val();
        var next = parseInt(v)+1;
        Manipulator.prototype.onAddClick(next, '{c}');
    }
});

//]]>
</script>