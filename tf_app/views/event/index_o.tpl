<!-- rowContent -->
<div class="rowContent" id="event">
    <div class="page-header">
        <div class="container">
            <h2><a href="../event/">Event</a></h2>
            <button  class="btn btn-primary pull-right" onclick=location.href='../event/add'><span class="icon-pencil"></span> 이벤트 만들기</button>
                <select data-width="auto" class="selectpicker sort-options pull-right" >
                    <option value="ing">진행중인 이벤트</option>
                    <option value="end">종료된 이벤트</option>
                </select>
        </div>
    </div>
    <!-- /page-header --> 
    
    <!-- page-content -->
    <div class="page-content"> 
        {? c_res}{@ c_res}
        <!-- content-header -->
        <div class="content-header">
            <div class="container"  id="event-featured">
                <h2 class="sr-only">오늘의 이벤트/행사</h2>
                
                <!-- featured -->
                <div class="media"> <a href="/event/apply/{.id}" class="thumb pull-left"><img src="{.picture}" data-src="holder.js/300x170" class="media-object img-responsive"></a>
                    <div class="media-body caption">
                        <h3><a href="/event/apply/{.id}">{.title}</a></h3>
                        <dl class="dl-horizontal  item-status">
                            <dt>장소</dt>
                            <dd><span class="icon icon-map-marker"></span> {? .space_id == 0}{.space_etc}{:}{.opt}F {.sname}{/}</dd>
                            <dt>일시</dt>
                            <dd><span class="icon icon-time"></span> {=str_replace("-", ".", .date)} {.time}</dd>
                            <dt>신청기간</dt>
                            <dd><span class="icon icon-calendar"></span> {.start}~{.end}</dd>
                            <dt>신청현황</dt>
                            <dd><span class="icon icon-user"></span> 정원 <span class="badge">{.cnt}</span> / 신청자 <span class="badge">{.rcnt}</span></dd>
                        </dl>
                        <p>{.summary}</p>
                        <button class="btn btn-default btn-xs">참여신청하기</button>
                    </div>
                </div>
                <!-- /featured --> 
                
            </div>
        </div>
        <!-- /content-header --> 
        {/}{/}
        <!-- container -->
        <div class="container" id="event-list"> 
            <!-- content -->
            <div class="content">
                <div  class="row">
                    {@ res}
                    <div class="col-md-4">
                        <div class="thumbnail"> <a href="/event/apply/{.id}" class="thumb"> <img src="{.picture}"  data-src="holder.js/300x170" class="img-responsive" > </a>
                            <div class="caption">
                                <h3><a href="/event/apply/{.id}">{.title}</a></h3>
                                <dl class="dl-horizontal  item-status">
                                    <dt>장소</dt>
                                    <dd><span class="icon icon-map-marker"></span> {? .space_id == 0}{.space_etc}{:}{.opt}F {.sname}{/}</dd>
                                    <dt>일시</dt>
                                    <dd><span class="icon icon-time"></span> {=str_replace("-", ".", .date)} {.time}</dd>
                                    <dt>신청기간</dt>
                                    <dd><span class="icon icon-calendar"></span> {.start}~{.end}</dd>
                                    <dt>신청현황</dt>
                                    <dd><span class="icon icon-user"></span> 정원 <span class="badge">{.cnt}</span> / 신청자 <span class="badge">{.rcnt}</span></dd>
                                </dl>
                            </div>
                            <div class="action-wrap">
                                <button type="button" class="btn btn-default btn-xs" onclick="location.href='/event/apply/{.id}'">참여신청하기</button>
                            </div>
                        </div>
                        <!-- /thumbnail --> 
                    </div>
                    {/}
                </div>
                <!-- row -->
                
                <div class="paging text-center">
                    <ul class="pagination">
                        {?page == 1}
                        <li class="disabled"><a href="#">&laquo;</a></li>
                        {:}
                        <li><a href="/event/{page - 1}">&laquo;</a></li>
                        {/}

                        {@paging.pages}
                        {?.type == "dot"}
                        <li class="disabled"><a href="#">...</a></li>
                        {:}
                        <li {?.type == "current"}class="active"{/}><a href="/event/{.page}">{.page}</a></li>
                        {/}
                        {/}

                        {?page == paging.tot_page}
                        <li class="disabled"><a href="#">&raquo;</a></li>
                        {:}
                        <li><a href="/event/{page + 1}" >&raquo;</a></li>
                        {/}
                    </ul>
                </div>
                <!-- /paging --> 
                
            </div>
            <!-- /content --> 
        </div>
        <!-- /container --> 
    </div>
    <!-- /page-content --> 
    
</div>
<!-- /rowContent --> 