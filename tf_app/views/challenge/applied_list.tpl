    <!-- rowContent -->
    <div class="rowContent" id="competition"> 
        <div class="page-header">
            <div class="container">
                <h2><a href="/challenge">Challenge</a></h2>
                {? (s.per & settings->permission1) == settings->permission1}
                {? s.ids}
                <button  class="btn btn-primary pull-right" onclick=location.href='/challenge/edit'><span class="icon-pencil"></span> 경진대회 만들기</button>
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
                    <div class="col-xs-12 col-sm-12 col-md-9 content editor">
                        
                        <div class="content-header">
                            <h3 class="content-heading"><a href="/member/edit_challenge_m">Challenge 관리</a> > 대회 운영 현황</h3> 
                        </div>

                        <div class="well applied-item">
                            <div class="media">
                                {? res.img}<a href="/challenge/views/{res.id}" class="pull-left media-object"><img class="img-responsive" src="{res.img}" ></a>{/}
                                <div class="media-body">
                                    <h4 class="media-heading"><a href="/challenge/views/{res.id}">{res.subject}</a></h4>
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
                                            {? (res.user_id == s.id) || op}
                                            <dt>공개여부</dt>
                                            <dd>
                                                <select data-width="auto" class="selectpicker" name="open" onchange="change_status_cm(this, '{res.id}'); return false;">
                                                    <option value="1" {? res.open}selected="selected"{/}>공개</option>
                                                    <option value="0" {? !res.open}selected="selected"{/}>비공개</option>
                                                </select>
                                            </dd>
                                            {/}
                                        </dl>
                                    </div>
                                </div>
                                {? (res.user_id == s.id) || op}
                                <div class="list-controller pull-right">
                                    <a href="/challenge/edit/{res.id}" class="btn btn-primary btn-sm">세부정보 설정하기</a>
                                </div>
                                {/}
                            </div>
                            <!-- /media -->
                        </div>
                        <!-- /applied-item -->
                        {? (res.user_id == s.id) || op}
                        <ol data-progtrckr-steps="7" class="stepProgress">
                            <li class="{? step > 0}step-done{:}step-todo{/}">정보입력</li>
                            <li class="{? step > 1}step-done{:}step-todo{/}">승인받기</li>
                            <li class="{? step > 2}step-done{:}step-todo{/}">세부정보 설정</li>
                            <li class="{? step > 3}step-done{:}step-todo{/}">접수중</li>
                            <li class="{? step > 4}step-done{:}step-todo{/}">접수마감</li>
                            <li class="{? step > 5}step-done{:}step-todo{/}">수상자 발표</li>
                        </ol>
                        {/}
                        {? date('Y.m.dH:i') < res.sdate}
                        <div class="alert alert-info">
                            <div class="text-center"><span class="icon-warning-sign"></span> 대회 시작 전입니다.</div>
                            다음 준비를 마무리하셨나요?
                            <br/><br/>
                            <strong>1. 세부정보 설정 하기 :</strong> 대회 상세 정보 및 지원서를 작성해 주세요.
                            <br/>
                            <strong>2. 심사위원 :</strong> 평가를 진행할 심사위원들을 초대하세요.
                            <br/>
                            <strong>3. 운영진 :</strong> 대회를 함께 운영할 운영진을 초대할 수도 있습니다.
                        </div>
                        {/}
                        {? ex && res.ex_notice}
                        <div class="examiner-notice alert alert-info">
                            <h4><i class="fa fa-microphone"></i> 운영진 공지사항</h4>
                            <p>{=add_brs(res.ex_notice)}</p>
                        </div>
                        {/}
                        <!--  applied-list  -->
                        <div class="applied-list panel panel-default tab-content"> 
                            <div class="panel-heading">
                                <!--<h3 class="panel-title"><span class="icon-fixed-width  icon-check "></span>참가자 현황</h3>-->
                                {? (res.user_id == s.id) || op}<a class="pull-right btn btn-default btn-xs" href="/challenge/examine_excel/{res.id}">심사 현황 다운로드</a>
                                {? res.id > 134}<a class="pull-right btn btn-default btn-xs" href="/challenge/applied_files/{res.id}">지원서 첨부파일</a>{/}
                                <a class="pull-right btn btn-default btn-xs" href="/challenge/applied_excel/{res.id}">지원서 내역 다운로드</a>{/} 
                                {? ex && date('Y.m.dH:i') > res.edate && date('Y.m.dH:i') < res.announce}
                                {? (res.user_id != s.id) && !op}
                                <a class="pull-right btn btn-default btn-xs" href="/challenge/applied_excel/{res.id}">지원서 내역 다운로드</a>{/}{/}
                                <ul class="nav nav-tabs">
                                  <li {? tab == "dashboard"}class="active"{/}><a data-toggle="tab" href="#dashboard">경진대회 진행 현황</a></li>
                                  <li {? !tab}class="active"{/}><a data-toggle="tab" href="#apply_list">참가자 현황</a></li>
                                  {? (res.user_id == s.id) || op}
                                  <li {? tab == "ext_ex"}class="active"{/}><a href="/challenge/examiner/{res.id}">심사위원</a></li>
                                  <li {? tab == "ext_op"}class="active"{/}><a href="/challenge/operator/{res.id}">운영진</a></li>
                                  <li {? tab == "ext_wn"}class="active"{/}><a href="/challenge/winner/{res.id}">수상자선정</a></li>
                                  {/}
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
                                        <div class="col-xs-12 col-sm-6 col-md-6">
                                            <dl class="dl-horizontal">
                                                <dt>반려 건수</dt>
                                                <dd><span class="badge badge-warning">{list_cnt_reject}</span></dd>
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
                                                <th width="33.33%" class="td-cnt">반려</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {@ d_list}
                                            <tr> 
                                                <td class="td-date">{.day}</td>
                                                <td class="td-cnt"><span class="badge badge-primary">{.all}</span></td>
                                                <td class="td-cnt"><span class="badge badge-warning">{.rej}</span></td>
                                            </tr>
                                            {/}
                                        </tbody>
                                    </table>
                                </div> 
                                
                                <h4><span class="glyphicon glyphicon-signal"></span> 심사 현황</h4>
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr> 
                                                <th width="33.33%" class="td-name">심사위원</th> 
                                                <th width="33.33%" class="td-cnt">심사 완료</th>
                                                <th width="33.33%" class="td-cnt">남은 평가</th>
                                            </tr>
                                        </thead>
                                        <tbody id="ex_all">
                                        </tbody>
                                    </table>
                                </div>

                            </div>
                            <div class="panel-body tab-pane {? !tab}active{/}" id="apply_list">
                                <div class="table-heading text-right">
                                    <button class="btn btn-default btn-xs" onclick="window.print();"> 인쇄하기</button>
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
                                                <th class="cell-status">상태</th> 
                                                <th class="cell-score" >
                                                    <a href="/challenge/applied_list/{res.id}?alig={? alig}{? alig == 'down'}up{/}{:}down{/}">심사점수 <span class="{? alig}icon-caret-{alig}{/}"></span></a>
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {@ list}
                                            <tr>
                                                <td class="cell-num">{= list_cnt - (pagesize*(page-1) + .key_)}</td>
                                                <td class="cell-name">{? .ids}<a href="/member/{.ids}">{.name}</a>{:}{.f_name}{/}</td>
                                                <td class="cell-group">{?.f_team}{.f_team}{:}{.team}{/}</td>
                                                <td class="cell-date">{.date_created}</td>
                                                <td class="cell-content">
                                                    {? (res.user_id == s.id) || op}
                                                    <a href="/challenge/applied_view/{.id}" class="btn btn-default btn-xs">내용보기</a>
                                                    {:}
                                                    {? date('Y.m.dH:i') < res.announce}
                                                    <a href="/challenge/applied_view/{.id}" class="btn btn-default btn-xs">내용보기</a>
                                                    {:}<span class="icon-minus text-muted"></span>{/}
                                                    {/}
                                                </td>
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
                                <div>
                                    <ul class="pagination">
                                        {?page == 1}
                                        <li class="disabled"><a href="#">&laquo;</a></li>
                                        {:}
                                        <li><a href="/challenge/applied_list/{res.id}/{page - 1}?alig={alig}&search={search}">&laquo;</a></li>
                                        {/}
    
                                        {@paging.pages}
                                        {?.type == "dot"}
                                        <li class="disabled"><a href="#">...</a></li>
                                        {:}
                                        <li {?.type == "current"}class="active"{/}><a href="/challenge/applied_list/{res.id}/{.page}?alig={alig}&search={search}" >{.page}</a></li>
                                        {/}
                                        {/}
    
                                        {?page >= paging.tot_page}
                                        <li class="disabled"><a href="#">&raquo;</a></li>
                                        {:}
                                        <li><a href="/challenge/applied_list/{res.id}/{page + 1}?alig={alig}&search={search}" >&raquo;</a></li>
                                        {/}
                                    </ul>
                                    <form style="width: 220px; float:right" role="search" class="" action="/challenge/applied_list/{res.id}?alig={alig}">
                                        <div class="input-group">
                                            <input type="text" value="{search}" name="search" class="form-control">
                                            <span class="input-group-btn">
                                            <button class="btn btn-default" type="submit" data-toggle="tooltip" title="검색"><span class="icon-search"></span></button>
                                            </span> </div>
                                    </form>
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
                            <h3 class="panel-title">개최한 경진대회</h3>
                            <ul class="media-list post-list">
                                {@ m_list}
                                <li class="media"> 
                                    <a href="/challenge/views/{.id}" class="pull-left media-object"> <img class="img-responsive" src="{? .img}{.img}{:}/img/default-img-news.png{/}"> </a>
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/challenge/views/{.id}">{.subject}</a></h4>
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
                                <li class="media"> <a href="/challenge/views/{.competition_id}" class="pull-left media-object"> <img class="img-responsive" src="{? .img}{.img}{:}/img/default-img-news.png{/}"> </a>
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/challenge/views/{.competition_id}">{.subject}</a></h4>
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
                                <li class="media"><a href="/challenge/views/{.cid}" class="pull-left media-object"> <img class="img-responsive" src="{? .img}{.img}{:}/img/default-img-news.png{/}"> </a>
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/challenge/views/{.cid}">{.subject}</a></h4>
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

get_examiner_all( {res.id});
function get_examiner_all( _id)
{

    var get_url = '/ajax_v3/get_examiner/'+_id+'?tpl=get_examiner_all&pagesize=0';
    $.get(get_url, function(_data) {
        $('#ex_all').html(_data);
    });

}

//]]>
</script>