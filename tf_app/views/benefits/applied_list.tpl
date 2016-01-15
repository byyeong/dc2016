    <!-- rowContent -->
    <div class="rowContent" id="competition"> 
        <div class="page-header">
            <div class="container">
                <h2><a href="/benefits">Benefits</a></h2>
                {? (s.per & settings->permission1) == settings->permission1}
                {? s.ids}
                <button  class="btn btn-primary pull-right" onclick=location.href='/benefits/edit'><span class="icon-pencil"></span> 프로그램 만들기</button>
                {:}
                <button  class="btn btn-primary pull-right" onclick="javascript:alert('로그인이 필요합니다.');"><span class="icon-pencil"></span> 프로그램 만들기</button>
                {/}
                {/}
            </div>
        </div>
        <!-- /page-header -->
        
        <!-- page-content -->
        <div class="page-content"> 
            <!-- container -->
            <div class="container">
                <div  class="row"> 
                    <!-- content -->
                    <div class="col-xs-12 col-sm-12 col-md-9 content editor">
                        
                        <div class="content-header">
                            <h3 class="content-heading"><a href="/member/edit_benefit_m">Benefits 관리</a> > 프로그램 운영 현황</h3> 
                        </div>

                        <div class="well applied-item">
                            <div class="media">
                                {? res.img}<a href="/benefits/views/{res.id}" class="pull-left media-object"><img class="img-responsive" src="{res.img}" ></a>{/}
                                <div class="media-body">
                                    <h4 class="media-heading"><a href="/benefits/views/{res.id}">{res.subject}</a></h4>
                                    <div class="item-status">
                                        <dl class="dl-horizontal ">
                                            <dt>지원기관</dt>
                                            <dd>{res.agency} </dd>
                                            <dt>성격</dt>
                                            <dd>{res.category} </dd>
                                            <dt>접수기간</dt>
                                            <dd>
                                                {? res.a_start}
                                                {=substr(res.a_start, 0, 10)} ({=date_to_day_only(substr(res.a_start, 0, 10))}) {=substr(res.a_start, 11)} ~ {=substr(res.a_end, 0, 10)} ({=date_to_day_only(substr(res.a_end, 0, 10))}) {=substr(res.a_end, 11)} &nbsp;
                                                {? date('Y.m.d H:i') < res.a_start}<span class="label label-info">접수 준비</span>&nbsp;{/}
                                                {? date('Y.m.d H:i') > res.a_start && date('Y.m.d H:i') < res.a_end}<span class="label label-primary">접수중</span>&nbsp;{/} 
                                                {? date('Y.m.d H:i') > res.a_end}<span class="label label-warning">접수마감</span>&nbsp;{/}
                                                {:}
                                                상시 <span class="label label-primary">접수중</span>
                                                {/}
                                            </dd>
                                        </dl>
                                    </div>
                                </div>
                                {? (res.user_id == s.id) || op}
                                <div class="list-controller pull-right">
                                    <a href="/benefits/edit/{res.id}" class="btn btn-primary btn-sm">세부정보 설정하기</a>
                                </div>
                                {/}
                            </div>
                            <!-- /media -->
                        </div>
                        <!-- /applied-item -->

                        <div class="applied-list panel panel-default tab-content"> 
                            <div class="panel-heading">
                                {? date('Y.m.d H:i') > res.a_end}
                                <!--a class="pull-right btn btn-default btn-xs" href="/benefits/applied_excel/{res.id}">참가자 리스트 다운로드</a-->
                                {/}
                                <ul class="nav nav-tabs">
                                  <li {? tab == "dashboard"}class="active"{/}><a data-toggle="tab" href="#dashboard">프로그램 진행 현황</a></li>
                                  <li {? !tab}class="active"{/}><a data-toggle="tab" href="#apply_list">참가자 현황</a></li>
                                </ul> 
                            </div>
                            <div class="panel-body tab-pane {? tab == 'dashboard'}active{/}" id="dashboard">
                                
                                <div class="well ">
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-6 col-md-6">
                                            <dl class="dl-horizontal">
                                                <dt>총 접수 건수</dt>
                                                <dd><span class="badge badge-primary">{list_cnt}</span></dd>
                                            </dl>
                                        </div>
                                    </div>
                                </div>

                                
                                <h4><span class="glyphicon glyphicon-signal"></span> 일자별 접수 건수</h4>
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr> 
                                                <th width="33.33%" class="td-date">접수일</th> 
                                                <th width="33.33%" class="td-cnt">접수</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {@ d_list}
                                            <tr> 
                                                <td class="td-date">{.day}</td>
                                                <td class="td-cnt"><span class="badge badge-primary">{.all}</span></td>
                                            </tr>
                                            {/}
                                        </tbody>
                                    </table>
                                </div> 

                            </div>
                            <div class="panel-body tab-pane {? !tab}active{/}" id="apply_list">
                                <div class="table-heading text-right">
                                    <!--button class="btn btn-default btn-xs" onclick="window.print();"> 인쇄하기</button-->
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-hover table-striped">
                                        <thead>
                                            <tr>
                                                <th class="cell-num">번호</th>
                                                <th class="cell-name">참가자</th>
                                                <th class="cell-group">회사/팀</th>
                                                <th class="cell-date">신청일자</th>
                                                <th class="cell-content">참가내용보기</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {@ list}
                                            <tr>
                                                <td class="cell-num">{= list_cnt - (pagesize*(page-1) + .key_)}</td>
                                                <td class="cell-name">{? .ids}<a href="/member/{.ids}">{.name}</a>{:}{.f_name}{/}</td>
                                                <td class="cell-group">{?.team}{.team}{:}{.f_team}{/}</td>
                                                <td class="cell-date">{.date_created}</td>
                                                <td class="cell-content">
                                                    <a href="/benefits/applied_view/{.id}" class="btn btn-default btn-xs">내용보기</a>
                                                </td>                       
                                            </tr>
                                            {/}
                                        </tbody>
                                    </table>
                                </div>
                                <div class="paging text-center">
                                    <ul class="pagination">
                                        {?page == 1}
                                        <li class="disabled"><a href="#">&laquo;</a></li>
                                        {:}
                                        <li><a href="/benefits/applied_list/{res.id}/{page - 1}?alig={alig}">&laquo;</a></li>
                                        {/}
    
                                        {@paging.pages}
                                        {?.type == "dot"}
                                        <li class="disabled"><a href="#">...</a></li>
                                        {:}
                                        <li {?.type == "current"}class="active"{/}><a href="/benefits/applied_list/{res.id}/{.page}?alig={alig}" >{.page}</a></li>
                                        {/}
                                        {/}
    
                                        {?page >= paging.tot_page}
                                        <li class="disabled"><a href="#">&raquo;</a></li>
                                        {:}
                                        <li><a href="/benefits/applied_list/{res.id}/{page + 1}?alig={alig}" >&raquo;</a></li>
                                        {/}
                                    </ul>
                                </div> 
                                <!-- /paging --> 
                            </div>  

                        </div>
                        <!-- /applied-list  --> 
                        
                        
                    </div>
                    <!-- / content -->
                    
                    <div class="col-xs-12 col-sm-12 col-md-3 sidebar">
                    
                        {? m_list}
                        <div class="panel writed-competition">
                            <h3 class="panel-title">개최한 프로그램</h3>
                            <ul class="media-list post-list">
                                {@ m_list}
                                <li class="media"> {? .img}<a href="/benefits/views/{.id}" class="pull-left media-object"> <img class="img-responsive" src="{.img}"> </a>{/}
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/benefits/views/{.id}">{.subject}</a></h4>
                                        <div class="media-meta"> <span class="author"><a href="/member/{.ids}">{.name}</a></span> <span class="time"><span class="icon-time"></span>&nbsp; {=trans_date_ago(.date_created)}</span> </div>
                                    </div>
                                    <!-- /media-content --> 
                                </li>
                                {/}
                            </ul>
                        </div>
                        <!-- /panel -->
                        {/}

                        {? a_list}
                        <div class="panel applied-competition">
                            <h3 class="panel-title">참가한 프로그램</h3>
                            <ul class="media-list post-list">
                                {@ a_list}
                                <li class="media"> {? .img}<a href="/benefits/views/{.cid}" class="pull-left media-object"> <img class="img-responsive" src="{.img}"> </a>{/}
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/benefits/views/{.cid}">{.subject}</a></h4>
                                        <div class="media-meta"> <span class="author"><a href="/member/{.ids}">{.name}</a></span> <span class="time"><span class="icon-time"></span>&nbsp; {=trans_date_ago(.date_created)}</span> </div>
                                    </div>
                                    <!-- /media-content --> 
                                </li>
                                {/}
                            </ul>
                        </div>
                        <!-- /panel -->
                        {/}
                    </div>
                    <!-- / sidebar --> 
                    
                </div>
                <!-- row --> 
            </div>
            <!-- /container --> 
        </div>
        <!-- /page-content --> 
        
    </div>
    <!-- /rowContent --> 

<script type="text/javascript">
//<![CDATA[

// popover
$('.container').popover ({
    selector: "[data-toggle=popover]",
    trigger: "hover",
    title: "반려 사유",
    html: 'true',
    content : ""
})

//]]>
</script>