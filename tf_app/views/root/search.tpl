<!-- rowContent -->
<div class="rowContent"  id="searching"> 
    <!-- page-header -->
    <div class="page-header">
        <div class="container">
            <h2> Search </h2>
        </div>
    </div>
    <!-- /page-header --> 
    
    <!-- page-content -->
    <div class="page-content"> 
        <!-- container -->
        <div class="container"> 
            
            <!-- content -->
            <div class="full-content">
                <div class="panel panel-default filter-box">
                    <div class="search-form">
                        <form role="form" method="post" action="/search" name="search_f">
                            {*<div class="panel-body">
                                <dl class="dl-horizontal filter-form">
                                    <dt>검색 대상 선택</dt>
                                    <dd>
                                        <label class="radio-inline">
                                            <input type="radio" name="cat" value="1" {? cat == 1}checked{/} onchange="javascript:document.search_f.submit();">
                                            개인</label>
                                        <label class="radio-inline">
                                            <input type="radio" name="cat" value="2" {? cat == 2}checked{/} onchange="javascript:document.search_f.submit();">
                                            기업</label>
                                        <label class="radio-inline">
                                            <input type="radio" name="cat" value="3" {? cat == 3}checked{/} onchange="javascript:document.search_f.submit();">
                                            채용정보</label>
                                        <label class="radio-inline">
                                            <input type="radio" name="cat" value="4" {? cat == 4}checked{/} onchange="javascript:document.search_f.submit();">
                                            BLOG</label>
                                    </dd>
                                    <!--
                                    <dt>검색 항목 선택</dt>
                                    <dd>
                                        <label>
                                            <input type="checkbox">
                                            Founder</label>
                                        <label>
                                            <input type="checkbox">
                                            Team Member</label>
                                        <label>
                                            <input type="checkbox">
                                            Investor</label>
                                        <label>
                                            <input type="checkbox">
                                            Incubator</label>
                                        <label>
                                            <input type="checkbox">
                                            지역</label>
                                        <label>
                                            <input type="checkbox">
                                            관심분야</label>
                                        <label>
                                            <input type="checkbox">
                                            업무역량</label>
                                        <label>
                                            <input type="checkbox">
                                            교육</label>
                                    </dd>
                                    //-->
                                </dl>
                            </div>*}


                            <fieldset>
                                <div class="input-group col-md-6 col-md-offset-3">
                                    <input type="text" placeholder=" " name="key" value="{key}" class="form-control">
                                    <span class="input-group-btn">
                                    <button   class="btn btn-default"><span class="icon-search"></span><span class="sr-only">검색하기</span></button>
                                    </span> </div>
                                <!-- /input-group -->
                            </fieldset>


                        </form>
                    </div>
                </div>
                <!-- / panel -->
                
                <!-- todo : 검색결과 없을때 -->
                {? all_cnt == 0 }
                <div class="alert alert-danger">
                    <p><strong>Oops!</strong> 검색결과가 없습니다. 다시 입력해주세요.</div>
                </div>
                {/}
                <!-- todo : 검색결과 있을때 
                <h2 class="result-cnt"><span class="icon-search"></span> <strong>'000'</strong>에 대한 <span class="cnt">00</span>건이 검색되었습니다</h2>
                //-->

                <div class="row result-content">
                    <div class="col-xs-12 col-sm-4 col-md-3 left">
                        <ul class="nav nav-pills nav-stacked">
                            <li role="presentation" class="{?cat=='event'}active{/}">
                                <a href="/search/event?key={key}">Event <span class="badge">{event_cnt}</span></a>
                            </li>
                            <li role="presentation" class="{?cat=='challenge'}active{/}">
                                <a href="/search/challenge?key={key}">Challenge <span class="badge">{challenge_cnt}</span></a>
                            </li>
                            <li role="presentation" class="{?cat=='office_hours'}active{/}">
                                <a href="/search/office_hours?key={key}">Office Hours <span class="badge">{office_hours_cnt}</span></a>
                            </li>
                            <li role="presentation" class="{?cat=='recruit'}active{/ }">
                                <a href="/search/recruit?key={key}">Recruit <span class="badge">{recruit_cnt}</span></a>
                            </li>
                            <li role="presentation" class="{?cat=='benefit'}active{/ }">
                                <a href="/search/benefit?key={key}">Benefits <span class="badge">{benefit_cnt}</span></a>
                            </li>
                            <li role="presentation" class="{?cat=='blog'}active{/ }">
                                <a href="/search/blog?key={key}">Blog <span class="badge">{blog_cnt}</span></a>
                            </li>
                            <li role="presentation" class="{?cat=='showcase'}active{/ }">
                                <a href="/search/showcase?key={key}">Showcase <span class="badge">{showcase_cnt}</span></a>
                            </li>
                            <li role="presentation" class="{?cat=='startup' }active{/ }">
                                <a href="/search/startup?key={key}">Startup <span class="badge">{startup_cnt}</span></a>
                            </li>
                            <li role="presentation" class="{?cat=='people' }active{/ }">
                                <a href="/search/people?key={key}">People <span class="badge">{people_cnt}</span></a>
                            </li>
                        </ul>
                    </div>

                    <div class="col-xs-12 col-sm-8 col-md-9 right">
                        {?cat=='event'}
                        <div class="result-box type-event">
                            <h3>Event</h3>

                            <!-- media-list -->
                            <ul class="media-list">
                                {? event}
                                {@ event}
                                <li class="media">
                                    <a class="pull-left" href="/event/{.id}">
                                        {?.picture}
                                        <img src="{.picture}" class="media-object" data-src="holder.js/40x40" >
                                        {:}
                                        <img src="/images/img_default.png" class="media-object" data-src="holder.js/40x40" >
                                        {/}
                                    </a>
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/event/{.id}" class="highlight-target">{.title}</a> </h4>
                                        <p class="highlight-target">{=substr(strip_tags(.summary), 0, 300)}</p>
                                        <ul>
                                            {? .sname}<li class="highlight-target">행사 장소 : {=substr(.sname, 0, -2)}</li>{/}
                                            <li class="highlight-target">행사 일정 : {.ss}</li>
                                            {? .apply_start}<li class="highlight-target">접수기간 : {.apply_start} ~ {.apply_end}</li>{/}
                                        </ul>
                                        <div class="status highlight-target">
                                            {.mname}, {.date_created}
                                        </div>
                                    </div>
                                </li>
                                {/}
                                {:}
                                <li>Event 검색 결과가 없습니다.</li>
                                {/}
                            </ul>
                            <!-- /media-list -->

                        </div>
                        {/}
                        <!-- / result-event -->

                        {?cat=='challenge'}
                        <div class="result-box">
                            <h3>Challenge</h3>

                            <!-- media-list -->
                            <ul class="media-list">
                                {? challenge}
                                {@ challenge}
                                <li class="media">
                                    <a class="pull-left" href="/challenge/views/{.id}">
                                        {?.img}
                                        <img src="{.img}" class="media-object" data-src="holder.js/40x40" >
                                        {:}
                                        <img src="/images/img_default.png" class="media-object" data-src="holder.js/40x40" >
                                        {/}
                                    </a>
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/challenge/views/{.id}" class="highlight-target">{.subject}</a> </h4>
                                        <p class="highlight-target">{=substr(strip_tags(.summary), 0, 300)}</p>
                                        <ul>
                                            <li class="highlight-target">주최/주관 : {.organized}</li>
                                            <li class="highlight-target">신청기한 : {.sdate } ~ {.edate }</li>
                                            <li class="highlight-target">발표일자 : {.announce}</li>
                                        </ul>
                                        <div class="status highlight-target">
                                            {.name}, {.date_created}
                                        </div>
                                    </div>
                                </li>
                                {/}
                                {:}
                                <li>Challange 검색 결과가 없습니다.</li>
                                {/}
                            </ul>
                            <!-- /media-list -->

                        </div>
                        {/}
                        <!-- / result-challange -->

                        {?cat=='office_hours'}
                        <div class="result-box type-office-hours">
                            <h3>Office Hours</h3>

                            <!-- media-list -->
                            <ul class="media-list">
                                {? office_hours}
                                {@ office_hours}
                                <li class="media">
                                    <a class="pull-left" href="/office_hours/views/{.id}">
                                        {?.img}
                                        <img src="{.picture}" class="media-object" data-src="holder.js/40x40" >
                                        {:}
                                        <img src="/images/img_default.png" class="media-object" data-src="holder.js/40x40" >
                                        {/}
                                    </a>
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/office_hours/views/{.id}" class="highlight-target">{.subject}</a> </h4>
                                        <p class="highlight-target">{=substr(strip_tags(.description), 0, 300)}</p>
                                        <ul>
                                            <li class="highlight-target">주최/주관 : {.hosted}</li>
                                            <li class="highlight-target">신청기한 : {.e_start } ~ {.e_end }</li>
                                            <li class="highlight-target">접수기간 : {.a_start } ~ {.a_end }</li>
                                            <li class="highlight-target">발표일자 : {.r_date}</li>
                                        </ul>
                                    </div>
                                </li>
                                {/}
                                {:}
                                <li>Office Hours 검색 결과가 없습니다.</li>
                                {/}
                            </ul>
                            <!-- /media-list -->

                        </div>
                        {/}
                        <!-- / result-office_hours -->

                        {?cat=='recruit'}
                        <div class="result-box type-recruit">
                            <h3>Recruit</h3>

                            <!-- media-list -->
                            <ul class="media-list">
                                {? recruit}
                                {@ recruit}
                                <li class="media">
                                    <a class="pull-left" href="/startup/{.id}">
                                        {?.logo}
                                        <img src="{.logo}" class="media-object" data-src="holder.js/40x40" data-toggle="tooltip" title="{.name}"  >
                                        {:}
                                        <img src="/images/img_default.png" class="media-object" data-src="holder.js/40x40" >
                                        {/}
                                    </a>
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/recruit/views/{.id}" class="highlight-target">{.title}</a></h4>
                                        <p class="highlight-target">{=substr(strip_tags(.contents), 0, 300)}</p>
                                        <ul>
                                            <li class="highlight-target">채용공고기간 : <span class="icon icon-calendar"></span> {.start}~{.end}</li>

                                            {? .inv}<li class="highlight-target">업무분야 : <span class="icon icon-tasks"></span> {@ .inv}{.._value} {/}</li>{/}
                                        </ul>
                                    </div>
                                </li>
                                {/}
                                {:}
                                <li>Recruit 검색 결과가 없습니다.</li>
                                {/}
                            </ul>
                            <!-- /media-list -->

                        </div>
                        {/}
                        <!-- / result-recruit -->

                        {?cat=='benefit'}
                        <div class="result-box type-recruit">
                            <h3>Benefits</h3>

                            <!-- media-list -->
                            <ul class="media-list">
                                {? benefit}
                                {@ benefit}
                                <li class="media">
                                    <a class="pull-left" href="/benefits/views/{.id}">
                                        {?.img}
                                        <img src="{.img}" class="media-object" data-src="holder.js/40x40" >
                                        {:}
                                        <img src="/images/img_default.png" class="media-object" data-src="holder.js/40x40" >
                                        {/}
                                    </a>
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/benefits/views/{.id}" class="highlight-target">{.title}</a></h4>
                                        <p class="highlight-target">{=substr(strip_tags(.summary), 0, 300)}</p>
                                        <ul>
                                            <li class="highlight-target">지원기관 : {.agency }</li>
                                            <li class="highlight-target">성격 : {.category }</li>
                                            <li class="highlight-target">접수기간 : <span class="icon icon-calendar"></span> {?.a_start}{.a_start}~{.a_end}{:}상시{/}</li>
                                        </ul>
                                        <div class="status highlight-target">
                                            {.name}, {.date_created}
                                        </div>
                                    </div>
                                </li>
                                {/}
                                {:}
                                <li>Benefit 검색 결과가 없습니다.</li>
                                {/}
                            </ul>
                            <!-- /media-list -->

                        </div>
                        {/}
                        <!-- / result-benefit -->

                        {?cat=='blog'}
                        <div class="result-box">
                            <h3>Blog</h3>

                            <!-- media-list -->
                            <ul class="media-list">
                                {? blog}
                                {@ blog}
                                <li class="media">
                                    <a class="pull-left" href="/contents/views/{.id}">
                                        {?.picture}
                                        <img src="{.picture}" class="media-object" data-src="holder.js/40x40" >
                                        {:}
                                        <img src="/images/img_default.png" class="media-object" data-src="holder.js/40x40" >
                                        {/}
                                    </a>
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/contents/views/{.id}" class="highlight-target">{.subject}</a></h4>
                                        <p class="highlight-target">{=substr(strip_tags(.contents), 0, 300)}</p>
                                        <div class="status highlight-target">
                                            {.mname}, {.date_created}
                                        </div>
                                    </div>
                                </li>
                                {/}
                                {:}
                                <li>Blog 검색 결과가 없습니다.</li>
                                {/}
                            </ul>
                            <!-- /media-list -->

                        </div>
                        {/}
                        <!-- / result-blog -->

                        {?cat=='showcase'}
                        <div class="result-box">
                            <h3>Showcase</h3>

                            <!-- media-list -->
                            <ul class="media-list">
                                {? showcase}
                                {@ showcase}
                                <li class="media">
                                    <a class="pull-left" href="/showcase/views/{.id}" data-id="{.id}">
                                        {?.img1}
                                        <img src="{.img1}" class="media-object" data-src="holder.js/40x40" >
                                        {:}
                                        <img src="/images/img_default.png" class="media-object" data-src="holder.js/40x40" >
                                        {/}
                                    </a>
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/showcase/views/{.id}" data-id="{.id}" class="highlight-target">{.name}</a></h4>
                                        <p class="highlight-target">{=substr(strip_tags(.des_ele), 0, 300)}</p>
                                        <div class="status highlight-target">
                                            {.startup_name}, {.date_created}
                                        </div>
                                    </div>
                                </li>
                                {/}
                                {:}
                                <li>Showcase 검색 결과가 없습니다.</li>
                                {/}
                            </ul>
                            <!-- /media-list -->

                        </div>
                        {/}
                        <!-- / result-showcase -->

                        {?cat=='startup'}
                        <div class="result-box">
                            <h3>Startup</h3>

                            <!-- media-list -->
                            <ul class="media-list">
                                {? startup}
                                {@ startup}
                                <li class="media">
                                    <a class="pull-left" href="/startup/{.id}">
                                        {?.logo}
                                        <img src="{.logo}" class="media-object" data-src="holder.js/40x40" >
                                        {:}
                                        <img src="/images/img_default.png" class="media-object" data-src="holder.js/40x40" >
                                        {/}
                                    </a>
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/startup/{.id}" class="highlight-target">{.name}</a></h4>
                                        <p class="highlight-target">{=substr(strip_tags(.bio), 0, 300)}</p>
                                        <ul>
                                            {? .addr}<li class="highlight-target">지역 : {.addr}</li>{/}
                                            {? .bi}<li class="highlight-target">사업분야 : {@ .bi}{?..key_ == 0}{..skill}{:}, {..skill}{/}{/}</li>{/}
                                            {? .te}<li class="highlight-target">핵심기술 : {@ .te}{?..key_ == 0}{..skill}{:}, {..skill}{/}{/}</li>{/}
                                        </ul>
                                    </div>
                                </li>
                                {/}
                                {:}
                                <li>Startup 검색 결과가 없습니다.</li>
                                {/}
                            </ul>
                            <!-- /media-list -->

                        </div>
                        {/}
                        <!-- / result-startup -->

                        {?cat=='people'}
                        <div class="result-box">
                            <h3>People</h3>

                            <!-- media-list -->
                            <ul class="media-list">
                                {? people}
                                {@ people}
                                <li class="media">
                                    <a class="pull-left" href="/member/{.ids}">
                                        {?.picture}
                                        <img src="{.picture}" class="media-object" data-src="holder.js/40x40" >
                                        {:}
                                        <img src="/images/img_default.png" class="media-object" data-src="holder.js/40x40" >
                                        {/}
                                    </a>
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/member/{.ids}" class="highlight-target">{.name} ({.ids})</a> </h4>
                                        <small>{? .com.role} {.com.role} /{/} {?.com.name}{.com.name}{/}</small>
                                        <p class="highlight-target">{=substr(strip_tags(.bio), 0, 300)}</p>
                                        <ul>
                                            {? .local}<li class="highlight-target">관심지역 : {=substr(.local, 0, -2)}</li>{/}
                                            {? .inv}<li class="highlight-target">업무분야 : {=substr(.inv, 0, -2)}</li>{/}
                                            {? .sk}<li class="highlight-target">업무역량 : {@ .sk}{? ..key_ == 0}{.._value}{:}{.._value}, {/}{/}</li>{/}
                                            {? .education}<li class="highlight-target">교육 : {@ .education}{..education }{/}</li>{/}
                                        </ul>

                                    </div>
                                </li>
                                {/}
                                {:}
                                <li>People 검색 결과가 없습니다.</li>
                                {/}
                            </ul>
                            <!-- /media-list -->

                        </div>
                        {/}
                        <!-- / result-people -->

                        {? all_cnt}
                        <nav>
                            <ul class="pagination">
                                {?page == 1}
                                <li class="disabled"><a href="#">&laquo;</a></li>
                                {:}
                                <li><a href="/search/{cat}/{page - 1}?key={key}">&laquo;</a></li>
                                {/}

                                {@paging.pages}
                                {?.type == "dot"}
                                <li class="disabled"><a href="#">...</a></li>
                                {:}
                                <li {?.type == "current"}class="active"{/}><a href="/search/{cat}/{.page}?key={key}">{.page}</a></li>
                                {/}
                                {/}

                                {?page == paging.tot_page}
                                <li class="disabled"><a href="#">&raquo;</a></li>
                                {:}
                                <li><a href="/search/{cat}/{page + 1}?key={key}" >&raquo;</a></li>
                                {/}
                            </ul>
                        </nav>
                        {/}
                    </div>
                    <!-- / column right -->
                </div>
                <!-- / result-content -->
                
            </div>
            <!-- /content --> 
            
        </div>
        <!-- /container --> 
    </div>
    <!-- /page-content --> 
</div>
<!-- /rowContent -->
<script>
    $(function(){

        var keyword = "{key}";
        $(".highlight-target").each(function(){

            var str = $(this).text();
            $(this).html(str.replace(/{key}/gi, "\<span class=\"highlight\"\>{key}\<\/span\>"));
        });
    });
</script>