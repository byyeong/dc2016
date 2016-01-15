    <!-- rowContent -->
    <div class="rowContent" id="competition"> 
        <div class="page-header">
            <div class="container">
                <h2><a href="/competition">Competition</a></h2>
                {? (s.per & settings->permission1) == settings->permission1}
                {? s.ids}
                <button  class="btn btn-primary pull-right" onclick=location.href='/competition/edit'><span class="icon-pencil"></span> 경진대회 만들기</button>
                {:}
                <button  class="btn btn-primary pull-right" onclick="javascript:alert('로그인이 필요합니다.');"><span class="icon-pencil"></span> 경진대회 만들기</button>
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
                    <div class="col-xs-12 col-sm-12 col-md-9 content">
                        
                        <div class="content-header">
                            <h3 class="content-heading"><span class="icon-trophy"></span> 경진 대회 참가자 보기</h3> 
                        </div>
                        
                        
                        <div class="well applied-item">
                            <div class="media">
                                {? res.img}<a href="/competition/views/{res.id}" class="pull-left media-object"><img class="img-responsive" src="{res.img}" ></a>{/}
                                <div class="media-body">
                                    <h4 class="media-heading"><a href="/competition/views/{res.id}">{res.subject}</a></h4>
                                    <div class="item-status">
                                        <dl class="dl-horizontal ">
                                            <dt>주최/주관</dt>
                                            <dd><a href="/member/{res.ids}">{res.name}</a>{? res.organized}/{res.organized}{/} </dd>
                                            <dt>참가기간</dt>
                                            <dd>{=date_to_kr(res.date_s)} ~ {=date_to_kr(res.date_e)} 
                                                {? date('Y.m.dH:i') < res.sdate}<span class="label label-info">접수 준비</span>{/}
                                                {? date('Y.m.dH:i') > res.sdate && date('Y.m.dH:i') < res.edate}<span class="label label-primary">접수중</span>{/} 
                                                {? date('Y.m.dH:i') > res.edate}<span class="label label-warning">접수마감</span>{/} 
                                                {? date('Y.m.dH:i') > res.announce && res.winner}<span class="label label-default">수상자 발표</span>{/}
                                            </dd>
                                            <dt>발표일자</dt>
                                            <dd>{=date_to_kr(res.announce_d)}</dd>
                                        </dl>
                                    </div>
                                </div>
                            </div>
                            <!-- /media -->
                        </div>
                        <!-- /applied-item -->
                        
                        <!--  applied-list  -->
                        <div class="applied-list panel panel-default tab-content"> 
                            <div class="panel-heading">
                                <!--<h3 class="panel-title"><span class="icon-fixed-width  icon-check "></span>참가자 현황</h3>-->
                                {? res.user_id == s.id}<a class="pull-right btn btn-default btn-xs" href="/competition/examine_excel/{res.id}">심사 현황 다운로드</a>{/} 
                                <a class="pull-right btn btn-default btn-xs" href="/competition/applied_excel/{res.id}">참가자 리스트 다운로드</a>
                                <ul class="nav nav-tabs">
                                  <li  class="active"><a data-toggle="tab" href="#apply_list"><span class="icon-fixed-width  icon-reorder "></span> 참가자 현황</a></li>
                                  {? res.user_id == s.id}<li><a data-toggle="tab" href="#examiner_list"><span class="icon-fixed-width  icon-check "></span> 심사위원 현황</a></li> {/}
                                </ul> 
                            </div>
                            <div class="panel-body active tab-pane" id="apply_list">
                                <div class="table-responsive">
                                    <table class="table table-hover table-striped">
                                        <thead>
                                            <tr>
                                                <th class="cell-num">번호</th>
                                                <th class="cell-name">참가자</th>
                                                <th class="cell-group">회사/팀</th>
                                                <th class="cell-date">신청일자</th>
                                                <th class="cell-content">참가내용보기</th>
                                                <th class="cell-status">상태</th> 
                                                <th class="cell-score" >
                                                    <a href="/competition/applied_list/{res.id}?alig={? alig}{? alig == 'down'}up{/}{:}down{/}">심사점수 <span class="{? alig}icon-caret-{alig}{/}"></span></a>
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {@ list}
                                            <tr>
                                                <td class="cell-num">{= list_cnt - (pagesize*(page-1) + .key_)}</td>
                                                <td class="cell-name"><a href="/member/{.ids}">{.name}</a></td>
                                                <td class="cell-group">{.team}</td>
                                                <td class="cell-date">{.date_created}</td>
                                                <td class="cell-content"><a href="/competition/applied_view/{.id}" class="btn btn-default btn-xs">내용보기</a></td>
                                                <td class="cell-status">
                                                    {? .status == 0}
                                                    <span class="label label-default">접수대기</span>
                                                    {/}{? .status == 1}
                                                    <span class="label label-success">접수</span>
                                                    {/}{? .status == 2}
                                                    <span class="label label-warning" data-placement="top" data-toggle="popover" data-content="{.status_des}">반려</span>
                                                    {/}
                                                </td> 
                                                <td class="cell-score">
                                                    {? .score}<span class="badge badge-info">{.score}</span>
                                                    {:}<span class="icon-minus text-muted"></span>{/}
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
                                        <li><a href="/competition/applied_list/{res.id}/{page - 1}?alig={alig}">&laquo;</a></li>
                                        {/}
    
                                        {@paging.pages}
                                        {?.type == "dot"}
                                        <li class="disabled"><a href="#">...</a></li>
                                        {:}
                                        <li {?.type == "current"}class="active"{/}><a href="/competition/applied_list/{res.id}/{.page}?alig={alig}" >{.page}</a></li>
                                        {/}
                                        {/}
    
                                        {?page >= paging.tot_page}
                                        <li class="disabled"><a href="#">&raquo;</a></li>
                                        {:}
                                        <li><a href="/competition/applied_list/{res.id}/{page + 1}?alig={alig}" >&raquo;</a></li>
                                        {/}
                                    </ul>
                                </div> 
                                <!-- /paging --> 
                            </div>  
                            {? res.user_id == s.id}
                            <div class="panel-body tab-pane" id="examiner_list">
                            </div>  
<script type="text/javascript">
//<![CDATA[
get_examiner_list( {res.id}, 1);

function get_examiner_list( _id, _page)
{

    var get_url = '/ajax_front/get_examiner/'+_id+'?tpl=get_examiner_in&page='+_page;
    $.get(get_url, function(_data) {
        $('#examiner_list').html(_data);
    });

}

//]]>
</script>
                            {/}

                        </div>
                        <!-- /applied-list  --> 
                        
                        
                    </div>
                    <!-- / content -->
                    
                    <div class="col-xs-12 col-sm-12 col-md-3 sidebar">
                    
                        {? m_list}
                        <div class="panel writed-competition">
                            <h3 class="panel-title">개최한 경진대회</h3>
                            <ul class="media-list post-list">
                                {@ m_list}
                                <li class="media"> {? .img}<a href="/competition/views/{.id}" class="pull-left media-object"> <img class="img-responsive" src="{.img}"> </a>{/}
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/competition/views/{.id}">{.subject}</a></h4>
                                        <div class="media-meta"> <span class="author"><a href="/member/{.ids}">{.name}</a></span> <span class="time"><span class="icon-time"></span>&nbsp; {=trans_date_ago(.date_created)}</span> </div>
                                    </div>
                                    <!-- /media-content --> 
                                </li>
                                {/}
                            </ul>
                        </div>
                        <!-- /panel -->
                        {/}

                        {? e_list}
                        <div class="panel examined-competition">
                            <h3 class="panel-title">심사위원 위촉 경진대회</h3>
                            <ul class="media-list post-list">
                                {@ e_list}
                                <li class="media"> {? .img}<a href="/competition/views/{.competition_id}" class="pull-left media-object"> <img class="img-responsive" src="{.img}"> </a>{/}
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/competition/views/{.competition_id}">{.subject}</a></h4>
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
                            <h3 class="panel-title">참가한 경진대회</h3>
                            <ul class="media-list post-list">
                                {@ a_list}
                                <li class="media"> {? .img}<a href="/competition/views/{.cid}" class="pull-left media-object"> <img class="img-responsive" src="{.img}"> </a>{/}
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/competition/views/{.cid}">{.subject}</a></h4>
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

// $("th.cell-score").hover(function() {
//     $(this).css('cursor','pointer');
// }, function() {
//     $(this).css('cursor','auto');
// });

//]]>
</script>