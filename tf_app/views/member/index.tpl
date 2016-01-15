    <div id="member" class="jumbo-header hstyle-options{=rand(0, 9)}"> 
        <div id="header">
             <div class="container">
                <div class="row">

                    <div id="profileHeader" class="col-xs-12 col-sm-12 col-md-8 col-md-offset-2">
                        {? s.id == res.id}
                        <div id="radarSwich">
                            <div class="checkbox-inline">
                                <label class="control-label">채용레이다</label>
                                <input {? res.wanted}checked{/} type="checkbox" data-toggle="toggle" data-size="mini" id="edit_recruit">                             
                                <span data-toggle="tooltip" data-placement="top" title="관련 업무 분야의 채용공고가 올라오면 메일로 알려드립니다.">
                                    <i class="fa fa-info-circle"></i>
                                    <span class="sr-only">관련 업무 분야의 채용공고가 올라오면 메일로 알려드립니다.</span>
                                </span>
                            </div>
                        </div>
                        <!-- /#radarSwich -->
                        {/}
                        <div class="prf-info">
                            <div class="vimg">
                                <span style="background-image:url({? res.picture}{res.picture}{? ! strpos(res.picture, '?')}?date={=date('his')}{/}{:}/img/default-img-member.png{/});"><img href="{? res.picture}{res.picture}{? ! strpos(res.picture, '?')}?date={=date('his')}{/}{:}/img/default-img-member.png{/};"></span>
                            </div>

                            <h2>
                                <strong>{res.name}</strong>
                                {? s.name == res.name}
                                <small>
                                    <a href="/member/edit" data-toggle="tooltip" title="프로필수정">
                                        <span class="glyphicon glyphicon-cog"></span>
                                        <span class="sr-only">프로필수정</span>
                                    </a>
                                </small>
                                {/}
                            </h2>
                            <p class="lead">
                                {=htmlspecialchars(res.bio)}
                            </p>
                                                   
                            {? inter} 
                            <ul class="list-inline list-tags"> 
                                {@ inter}
                                <li><a href="/network/people/1/{.id}">{._value}</a></li>
                                {/}
                            </ul> 
                            {/}
                        </div>
                        <!-- /prf-info -->

                        <div class="prf-networks">
                            <ul class="list-inline list-follow">
                                <li class="nwk-followership">
                                    {? s}
                                    {? s.id != res.id}
                                    {? follow}
                                    <button class="btn-network btn-following" onclick="add_follow_p(this, '{s.id}', '{res.id}', 1, 1); return false;"><span class="glyphicon glyphicon-ok"></span> <strong>Following</strong></button> 
                                    {:}
                                    <button class="btn-network btn-follow" onclick="add_follow_p(this, '{s.id}', '{res.id}', 1); return false;"><span class="glyphicon glyphicon-plus"></span> <strong>Follow</strong></button>
                                    {/}
                                    {/}
                                    {:}
                                    <button class="btn-network btn-follow" onclick="javascript:alert('로그인이 필요합니다. 로그인 후 Follow 할 수 있습니다.');"><span class="glyphicon glyphicon-plus"></span> <strong>Follow</strong></button>
                                    {/}
                                    <!--button class="btn-network btn-unfollow"><span class="glyphicon glyphicon-remove"></span> <strong>Unfollow</strong></button-->
                                </li>

                                <li class="nwk-follower">
                                    <a href="#" onclick="get_follow(1, {res.id}, 0); return false;">
                                         <strong>Followers</strong>
                                         <span class="badge">{=sizeof(fl)}</span>
                                     </a>
                                </li>
                                <li class="nwk-following">
                                    <a href="#" onclick="get_follow(1, {res.id}, 1); return false;">
                                         <strong>Following</strong>
                                         <span class="badge">{=sizeof(fi)} </span>
                                     </a>
                                </li>
                            </ul>
                            {? res.homepage || res.blog || fb || tw|| res.linkedin}
                            <ul class="list-inline list-links">
                                {? res.homepage}
                                <li class="nwk-homepage">
                                    <a href="{=check_http(res.homepage)}" target="_blank" data-toggle="tooltip" data-placement="top" title="Hompage">
                                        <span class="fa-stack fa-lg">
                                          <i class="fa fa-circle fa-stack-2x"></i>
                                          <i class="fa fa-header fa-stack-1x fa-inverse"></i>
                                        </span>
                                        <span class="sr-only">Homepage</span>
                                    </a>
                                </li>
                                {/}
                                {? res.blog}
                                <li class="nwk-blog">
                                    <a href="{=check_http(res.blog)}" target="_blank" data-toggle="tooltip" data-placement="top" title="Blog">
                                        <span class="fa-stack fa-lg">
                                          <i class="fa fa-circle fa-stack-2x"></i>
                                          <i class="fa fa-bold fa-stack-1x fa-inverse"></i>
                                        </span>
                                        <span class="sr-only">Blog</span>
                                    </a>
                                </li>
                                {/}
                                {? fb}
                                <li class="nwk-facebook">
                                    <a href="http://facebook.com/{fb.ids}" target="_blank" data-toggle="tooltip" data-placement="top" title="Facebook">
                                        <span class="fa-stack fa-lg">
                                          <i class="fa fa-circle fa-stack-2x"></i>
                                          <i class="fa fa-facebook fa-stack-1x fa-inverse"></i>
                                        </span>
                                        <span class="sr-only">Facebook</span>
                                    </a>
                                </li>
                                {/}
                                {? tw}
                                <li class="nwk-twitter">
                                    <a href="http://twitter.com/{tw.ids}" target="_blank" data-toggle="tooltip" data-placement="top" title="Twitter">
                                        <span class="fa-stack fa-lg">
                                          <i class="fa fa-circle fa-stack-2x"></i>
                                          <i class="fa fa-twitter fa-stack-1x fa-inverse"></i>
                                        </span>
                                        <span class="sr-only">Twitter</span>
                                    </a>
                                </li>
                                {/}
                                {? res.linkedin}
                                <li class="nwk-linkedin">
                                    <a href="{=check_http(res.linkedin)}" target="_blank" data-toggle="tooltip" data-placement="top" title="Linkedin">
                                        <span class="fa-stack fa-lg">
                                          <i class="fa fa-circle fa-stack-2x"></i>
                                          <i class="fa fa-linkedin fa-stack-1x fa-inverse"></i>
                                        </span>
                                        <span class="sr-only">Linkedin</span>
                                    </a>
                                </li>
                                {/}
                            </ul>
                            {/}
                        </div>
                        <!-- /prf-networks -->
                    </div>
                    
                </div>
            </div>
        </div>
        <!-- /#header --> 

        <!-- #nav-content -->
        <nav id="nav-content">
            <div class="container">
                <div class="row"> 
                    <div class="col-xs-12 col-sm-12 col-md-8 col-md-offset-2">

                        <ul class="nav nav-tabs list-inline">
                            {? p_show}
                            <li><a href="#profile-content-user" data-toggle="tab">프로필</a></li>
                            {/}
                            {? a_show}
                            {? s.id != res.id && res.public_act & 1 == 1}{:}
                            <li><a href="#profile-content-activity" data-toggle="tab">최근활동</a></li>
                            {/}{/}
                            {? u_show}
                            <li><a href="#profile-content-update" data-toggle="tab">업데이트</a></li>
                            {/}
                            <li><a href="#profile-content-feed" data-toggle="tab">방명록</a></li>
                            <li><a href="#profile-content-reference" data-toggle="tab">추천합니다</a></li>
                        </ul>

                    </div>
                </div>
            </div>
        </nav>
        <!-- /#nav-content -->
    </div>
    <!-- /#jumbo-header -->

    <!-- #content --> 
    <div id="content" class="content-wrapper"> 
        <div class="container">  
            <div class="row"> 
                <div class="col-xs-12 col-sm-12 col-md-8 col-md-offset-2">
                    <!-- Start Contents -->

                    <div class="tab-content"> 

                        <!-- profile-content-user -->
                        <section class="tab-pane" id="profile-content-user"> 

                            <header class="sr-only">
                                <h3>프로필</h3>
                            </header>

                            <!-- profile-school -->
                            <div id="profile-school" class="panel">
                            </div>
                            <!-- /profile-school  --> 
<script type="text/javascript">
//<![CDATA[
$('#edit_recruit').change(function(){
    var c = this.checked ? 1 : 0;
    $.get('/ajax_front/edit_recruit/'+c, function() {
    });
});

get_edu();
function get_edu()
{
    var get_url = '/ajax_front/member_get_edu/{res.id}';
    $.get(get_url, function(_data) {
        $('#profile-school').html(_data);
    });
}
//]]>
</script>



                                
{? res.utype == 1}
                            <!-- profile-career -->
                            <div id="profile-career" class="panel">
                            </div>
                            <!-- /profile-career --> 
<script type="text/javascript">
//<![CDATA[
get_career();
function get_career()
{
    var get_url = '/ajax_front/member_get_career/{res.id}';
    $.get(get_url, function(_data) {
        $('#profile-career').html(_data);
    });
}
//]]>
</script>
{/}

{? res.utype == 2}
                            <!-- profile-investment -->
                            <div id="profile-investment" class="panel">
                            </div>
                            <!-- /profile-investment --> 
<script type="text/javascript">
//<![CDATA[

get_investment();
function get_investment()
{
    var get_url = '/ajax_front/member_get_investment/{res.id}';
    $.get(get_url, function(_data) {
        $('#profile-investment').html(_data);
    });
}
//]]>
</script>
{/}

{? res.utype == 1}
                            <!-- profile-project -->
                            <div id="profile-project" class="panel">
                            </div>
                            <!-- /panel project --> 
<script type="text/javascript">
//<![CDATA[
get_project();
function get_project()
{
    var get_url = '/ajax_front/member_get_pj/{res.id}';
    $.get(get_url, function(_data) {
        $('#profile-project').html(_data);
    });
}
//]]>
</script>
{/}                          
                                   
                        </section>
                        <!-- /tab - profile-content-user --> 
                            




                        <!-- tab - profile-content-feed -->
                        <section class="tab-pane" id="profile-content-activity"> 
                            <header class="sr-only">
                                <h3>최근활동</h3>
                            </header>                                

                            <!-- feed-recentActivity -->
                            <div id="feed-recentActivity" class="panel">
                                <div class="panel-heading">
                                    <strong>최근활동</strong>
                                </div>
                                <!-- /panel-heading -->
                                
                                <div class="panel-body">
                                    <ul class="media-list">
                                        {@ cur_act}
                                        {? .msg}
                                        <li class="media"> 
                                            {? .act_type == 1}
                                            <a class="media-left" href="/member/{.ow_ids}"> 
                                                <img src="{? .ow_picture}{.ow_picture}{:}/img/default-img-member.png{/}" class="img-circle media-object"  data-toggle="tooltip" title="{.ow_name}" style="height: 54px; width: 54px;"> 
                                            </a>
                                            <div class="media-body">
                                                <div class="media-heading">
                                                    <strong><a href="/member/{.ow_ids}">{.ow_name}</a></strong>
                                                    <span class="date"><span class="glyphicon glyphicon-time"></span>{=trans_date_ago(.date_created)}</span>
                                                </div>
                                                <p>{.msg}</p>
                                            </div>
                                            {/}
                                            {? .act_type == 2}
                                            <a class="media-left" href="/startup/{.ow_id}"> 
                                                <img src="{?.ow_logo}{.ow_logo}{:}/img/default-img-company.png{/}" class="img-circle media-object"  data-toggle="tooltip" title="{.ow_name}" style="height: 54px; width: 54px;"> 
                                            </a>
                                            <div class="media-body">
                                                <div class="media-heading">
                                                    <strong><a href="/startup/{.ow_id}">{.ow_name}</a></strong>
                                                    <span class="date"><span class="glyphicon glyphicon-time"></span>{=trans_date_ago(.date_created)}</span>
                                                </div>
                                                <p>{.msg}</p>
                                            </div>
                                            {/}
                                        </li>
                                        {:}
                                        {? .target_type == 1}{? .data.title}
                                        {?.is_made}
                                        {? .act_result != 2}
                                        <li class="media"> 
                                            <a class="media-left" href="/member/{.mem.ids}"> 
                                                <img src="{?.mem.picture}{.mem.picture}{:}/img/default-img-member.png{/}" class="img-circle media-object" data-toggle="tooltip" title="{.mem.name}" style="height: 54px; width: 54px;">
                                            </a>
                                            <div class="media-body">
                                                <div class="media-heading"> 
                                                    <strong>이벤트 신청 현황</strong>
                                                    <span class="date"><span class="glyphicon glyphicon-time"></span>{=trans_date_ago(.date_created)}</span>
                                                </div>
                                                <p>{.mem.name}님이 신청한 <strong><a href="/event/apply/{.data.id}">{.data.title}</a></strong> 이벤트 진행 상황입니다. 
                                                    {? .act_result == 0}<span class="label label-info">승인대기</span></p>{/}
                                                    {? .act_result == 1}<span class="label label-success">승인</span></p>{/}
                                                    {? .act_result == 2}<span class="label label-warning">반려</span></p>{/}
                                                <ul>
                                                    <li>이벤트명 : {.data.title}</li>
                                                    <!--<li>접수기간 : 2013년 7월 11일(목) 11:00 ~2013년 7월 21일(일) 18:00</li>-->
                                                    <li>일정 : {.data.date} {.data.start}~{.data.end}</li>
                                                    <li>장소 : {? .data.space_etc}{.data.space_etc}{:}{.data.sname} {.data.opt}층{/}</li>
                                                </ul>
                                            </div>
                                        </li>
                                        {/}
                                        {:}
                                        {? .act_result != 2}
                                        <li class="media"> 
                                            <a class="media-left" href="/member/{.mem.ids}">
                                                <img src="{?.mem.picture}{.mem.picture}{:}/img/default-img-member.png{/}" class=" img-circle media-object"  data-toggle="tooltip" title="{.mem.name}" style="height: 54px; width: 54px;">
                                            </a>
                                            <div class="media-body">
                                                <div class="media-heading"> 
                                                    <strong>이벤트 참여 현황</strong>
                                                    <span class="date"><span class="glyphicon glyphicon-time"></span>{=trans_date_ago(.date_created)}</span>
                                                </div>
                                                <p>{.mem.name}님이 참여 신청한 <strong><a href="/event/apply/{.data.id}">{.data.title}</a></strong> 이벤트 진행 상황입니다. 
                                                    {? .act_result == 0}<span class="label label-info">참여 접수</span></p>{/}
                                                    {? .act_result == 1}<span class="label label-success">참여대상</span></p>{/}
                                                    {? .act_result == 2}<span class="label label-warning">반려</span></p>{/}
                                                <ul>
                                                    <li>이벤트명 : {.data.title}</li>
                                                    <!--<li>접수기간 : 2013년 7월 11일(목) 11:00 ~2013년 7월 21일(일) 18:00</li>-->
                                                    <li>일정 : {.data.date} {.data.start}~{.data.end}</li>
                                                    <li>장소 : {? .data.space_etc}{.data.space_etc}{:}{.data.sname} {.data.opt}층{/}</li>
                                                </ul>
                                            </div>
                                        </li>
                                        {/}
                                        {/}
                                        {/}{/}
                                        {? .target_type == 2}{? .data.purpose}{? .act_result != 2}
                                        <li class="media"> 
                                            <a class="media-left" href="/member/{.mem.ids}"> 
                                                <img src="{?.mem.picture}{.mem.picture}{:}/img/default-img-member.png{/}" class="img-circle media-object"  data-toggle="tooltip" title="{.mem.name}" style="height: 54px; width: 54px;"> 
                                            </a>
                                            <div class="media-body">
                                                <div class="media-heading"> 
                                                    <strong>공간공유 신청 현황</strong>
                                                    <span class="date"><span class="glyphicon glyphicon-time"></span>{=trans_date_ago(.date_created)}</span>
                                                </div>
                                                <p>{.mem.name}님이 참여 신청한 <strong><a href="#">{.data.purpose}</a></strong> 공간공유 신청 진행 상황입니다. 
                                                    {? .act_result == 0}<span class="label label-info">승인대기</span></p>{/}
                                                    {? .act_result == 1}<span class="label label-success">승인</span></p>{/}
                                                    {? .act_result == 2}<span class="label label-warning">반려</span></p>{/}
                                                <ul>
                                                    <li>목적 : {.data.purpose}</li>
                                                    <!--<li>접수기간 : 2013년 7월 11일(목) 11:00 ~2013년 7월 21일(일) 18:00</li>-->
                                                    <li>일정 : {.data.date} {.data.start}~{.data.end}</li>
                                                    <li>장소 : {? .data.space_etc}{.data.space_etc}{:}{.data.name} {.data.opt}층{/}</li>
                                                </ul>
                                            </div>
                                        </li>
                                        {/}{/}{/}
                                        {? .target_type == 11}{? .data.subject}{? .act_result != 2}
                                        <li class="media"> 
                                            <a class="media-left" href="/member/{.mem.ids}"> <img src="{?.mem.picture}{.mem.picture}{:}/img/default-img-member.png{/}" class=" img-circle media-object"  data-toggle="tooltip" title="{.mem.name}" style="height: 54px; width: 54px;"> </a>
                                            <div class="media-body">
                                                <div class="media-heading"> 
                                                    <strong>경진대회 참여 현황 </strong>
                                                    <span class="date"><span class="glyphicon glyphicon-time"></span>{=trans_date_ago(.date_created)}</span>
                                                </div>
                                                <div class="media-content">
                                                    <p>{.mem.name}님이 신청한 <strong><a href="/competition/views/{.data.id}">{.data.subject}</a></strong> 경진대회 참여 현황입니다. 
                                                        {? .act_result == 0}<span class="label label-info">승인대기</span></p>{/}
                                                        {? .act_result == 1}<span class="label label-success">승인</span></p>{/}
                                                        {? .act_result == 2}<span class="label label-warning">반려</span></p>{/}
                                                    <ul>
                                                        <li>경진대회명 : {.data.subject}</li>
                                                        <!--<li>접수기간 : 2013년 7월 11일(목) 11:00 ~2013년 7월 21일(일) 18:00</li>-->
                                                        <li>주최·주관 : {.data.organized}</li>
                                                        <li>참가기간 : {.data.date_s} ({=date_to_day_only(.data.date_s)}) {.data.time_s} ~ {.data.date_e} ({=date_to_day_only(.data.date_e)}) {.data.time_e}</li>
                                                        <li>발표일자 : {.data.announce_d} ({=date_to_day_only(.data.announce_d)}) {.data.announce_t}</li>
                                                    </ul>
                                                </div>
                                                <div class="media-met"><span class="time"><span class="icon-time"></span>&nbsp; {.date_created}</span></div>
                                            </div>
                                        </li>
                                        {/}{/}{/}
                                        {? .target_type == 13}
                                        <li class="media"> 
                                            <a class="media-left" href="/member/{.mem.ids}"> <img src="{?.mem.picture}{.mem.picture}{:}/img/default-img-member.png{/}" class=" img-circle media-object"  data-toggle="tooltip" title="{.mem.name}" style="height: 54px; width: 54px;"> </a>
                                            <div class="media-body">
                                                <h4 class="media-heading"> Office Hours 참여 현황 </h4>
                                                <div class="media-content">
                                                    <p>{.mem.name}님이 신청한 <strong><a href="/office_hours/views/{.res.id}">{.res.subject}</a></strong> Office Hours 참여 현황입니다. 
                                                        {? .act_result == 0}<span class="label label-info">심사중</span></p>{/}
                                                        {? .act_result == 1}<span class="label label-success">선정</span></p>{/}
                                                        {? .act_result == 2}<span class="label label-warning">미선정</span></p>{/}
                                                    <ul>
                                                        <li>주최&middot;주관 : {.res.hosted}</li>
                                                        <li>참가 장소 : {.res.place}</li>
                                                        <li>참가 일자 : {=substr(.res.e_start, 0, 10)} ({=date_to_day_only(.res.e_start)}) {=substr(.res.e_start, 11)} ~ {=substr(.res.e_end, 0, 10)} ({=date_to_day_only(.res.e_end)}) {=substr(.res.e_end, 11)}</li>
                                                        <li>접수 기간 : {=substr(.res.a_start, 0, 10)} ({=date_to_day_only(.res.a_start)}) {=substr(.res.a_start, 11)} ~ {=substr(.res.a_end, 0, 10)} ({=date_to_day_only(.res.a_end)}) {=substr(.res.a_end, 11)} </li>
                                                        <li>발표 일자 : {=substr(.res.r_date, 0, 10)} ({=date_to_day_only(.res.r_date)}) {=substr(.res.r_date, 11)} / 메일을 통해 개별 안내 </li>
                                                    </ul>
                                                </div>
                                                <div class="media-meta"><span class="time"><span class="icon-time"></span>&nbsp; {.date_created}</span></div>
                                            </div>
                                        </li>
                                        {/}
                                        {/}
                                        {/}
                                    </ul>


                                    {?s.id == res.id && cur_act}
                                    <div class="pager"> <a href="/member/activity" class="btn btn-default btn-sm"> 더보기</a> </div>
                                    {/}
                                </div>
                            </div>
                            <!-- /feed-recentActivity -->

                        </section>
                        <!-- /tab - profile-content-feed --> 





                        <!-- tab - profile-content-feed -->
                        <section class="tab-pane" id="profile-content-update"> 
                            <header class="sr-only">
                                <h3>업데이트</h3>
                            </header>
                            
                            <!-- feed-timeline -->
                            <div id="feed-timeline" class="panel"> 
                            </div>
                            <!-- feed-timeline -->
<script type="text/javascript">
//<![CDATA[
get_timeline(1, '{res.id}', 1);
function get_timeline(_type, _id, _page)
{
var get_url = '/ajax_front/get_timeline/'+_type+'/'+_id+'/'+_page+'/1';
$.get(get_url, function(_data) {
    $('#feed-timeline').html(_data);
});
}
//]]>
</script> 
                        </section>
                        <!-- /tab - profile-content-feed --> 





                        <!-- tab - profile-content-feed -->
                        <section class="tab-pane" id="profile-content-feed"> 
                            <header class="sr-only">
                                <h3>방명록</h3>
                            </header>
                            
                            <!-- feed-timeline -->
                            <div id="feed-wall" class="panel">
                            </div>
                            <!-- feed-timeline -->
<script type="text/javascript">
//<![CDATA[
get_timeline_w(1, '{res.id}', 1);
function get_timeline_w(_type, _id, _page)
{
var get_url = '/ajax_front/get_timeline/'+_type+'/'+_id+'/'+_page+'/2';
$.get(get_url, function(_data) {
    $('#feed-wall').html(_data);
});
}
//]]>
</script> 
                        </section>
                        <!-- /tab - profile-content-feed --> 





                        <!-- tab - profile-content-recommend -->
                        <section class="tab-pane" id="profile-content-reference"> 
                            <header class="sr-only">
                                <h3>추천합니다</h3>
                            </header>
                            
                            <!-- profile-reference -->
                            <div id="profile-reference" class="panel">
                                <div class="panel-heading">
                                    <strong>추천합니다</strong>
                                </div>
                                <!-- /panel-heading -->
                                                          
                                <div class="panel-body" id="ref_form">
                                    <!-- todo : 사용자 본인일 때 -->
                                    <!-- media -->
                                    <div class="media form-edit-set" {? !s || s.id != res.id}style="display: none;"{/}>
                                        <form role="form" onsubmit="return false;" name="ref_form_0">
                                            <fieldset> 
                                                <a class="media-left" href="{? s}/member/{s.ids}{:}#{/}"> 
                                                    <img src="{? s}{s.picture}{:}../img/default-img-member.png{/}" class="media-object img-circle" data-toggle="tooltip" title="{s.name}">
                                                </a>
                                                <div class="media-body">
                                                    <div class="form-group">
                                                        <label class="sr-only">초대할 이메일</label>
                                                        <div class="input-group"> 
                                                            <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                                                            <input type="text" class="form-control" placeholder="초대할 메일주소를 입력하세요" name="email" id="ref_email">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="sr-only">초대 메시지</label>
                                                        <textarea row="3" class="form-control"  name="contents" id="ref_contents"placeholder="레퍼런스에 초대할 내용을 작성해주세요">{res.name}님이 D.CAMP의 프로필/이력 페이지에  당신을 레퍼런스로 추가하고자 합니다. {res.name}님에 대한 추천사를 남겨주세요.</textarea>
                                                    </div>
                                                    <div class="form-group form-submit">
                                                        <button class="btn btn-default btn-sm" onclick="submit_ref(0, this); return false;">초대 메일 보내기</button>
                                                    </div>
                                                </div>
                                                <input type="hidden" name="uid" value="{s.id}" />
                                            </fieldset>
                                        </form>
                                    </div>
                                    <!-- /media --> 
                                    
                                    <!-- todo : 작성가능한 사용자일 때 -->
                                    <!-- media -->
                                    <div class="media form-edit-set" {? s.id == res.id}style="display: none;"{/}>
                                        <form role="form" onsubmit="return false;" name="ref_form_wr">
                                            <fieldset>  
                                                <a class="media-left" href="{? s}/member/{s.ids}{:}#{/}"> 
                                                    <img src="{? s}{s.picture}{:}/img/default-img-member.png{/}" class="media-object img-circle" data-toggle="tooltip" title="userName">
                                                </a>
                                                <div class="media-body">
                                                    <div class="form-group">
                                                        <label class="sr-only">추천 메시지</label>
                                                        <textarea row="3" class="form-control" id="refer" name="reference" placeholder="{res.name}님에 대한 추천사를 남겨주세요"></textarea>
                                                    </div>
                                                    {? s}
                                                    <div class="form-group form-submit">
                                                        <button class="btn btn-default btn-sm" onclick="submit_ref_wr(this); return false;">저장하기</button>
                                                    </div>
                                                    {:}
                                                    <div class="form-group form-submit">
                                                        <button class="btn btn-default btn-sm" onclick="javascript:alert('로그인이 필요합니다. <br />로그인 후 레퍼런스를 작성해주세요.')">저장하기</button>
                                                    </div>
                                                    {/} 
                                                </div>
                                                <input type="hidden" name="req_id" value="{res.id}" />
                                            </fieldset>
                                        </form>
                                    </div>
                                    <!-- /media --> 

                                    <!-- todo: normal 상태 -->
                                    <ul class="media-list" id="ref_yes">
                                    </ul>
                                </div>

                            </div>
                            <!-- profile-reference-->       
<script type="text/javascript">
//<![CDATA[
get_reference();
function get_reference()
{
    var get_url = '/ajax_front/member_get_ref/{res.id}';
    $.get(get_url, function(_data) {
        if (_data === '') {
            {? !ref && res.id != s.id}$('.reference').hide();{/}
        } else {
            $('#profile-reference #ref_yes').html(_data);
        }
    });
}

function submit_ref(_id, _this){
    if ($('#ref_email').val() === '') {
        alert('초대할 메일주소를 입력해주세요.');
        return false;
    }
    $(_this).hide();
    var frm = $('form[name=ref_form_'+_id+']');

    var get_url = '/ajax_front/member_edit_ref';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            $(_this).show();
            $('#ref_email').val('');
            alert('메일을 보냈습니다.');
        }
    });
}

function submit_ref_wr(_this){
    if ($('#refer').val() === '') {
        alert('추천사를 입력해주세요.');
        return false;
    }
    $(_this).hide();
    var frm = $('form[name=ref_form_wr]');

    var get_url = '/ajax_front/member_write_ref';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            $('#refer').val('');
            $(_this).show();
            get_reference();
        }
    });
}

//]]>
</script> 
                        </section>
                        <!-- /tab - profile-content-feed --> 
                    </div>
                    <!-- /tab-content -->                      
                
                <!-- /End Contents -->
                </div> 
            </div>
        </div>
    </div>
    <!-- /#content -->








<!-- Modal -->
<div class="modal fade" id="md-profilecheck" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="alert alert-warning">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4><span class="icon-frown icon-large"></span> Oops!</h4>
            <p> 생년월일, 성별이 필수값으로 추가되었습니다. 정보를 입력해주세요. </p>
            <p> 
                <a href="/member/edit" class="btn btn-warning btn-sm"><span class="icon-hand-right"></span> 개인정보 수정하기</a>
                <!--<button class="btn btn-default btn-sm pull-right" data-dismiss="modal" aria-hidden="true">오늘 그만보기</button>-->
            </p>
        </div>
    </div>
</div>
<!-- /modal -->

<!-- modal #searchStartup -->
<div class="modal fade" id="md-searchStartup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div>

<!-- modal #md-compEditor -->
<div class="modal fade" id="md-compEditor" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3 class="modal-title"><span class="icon-building"></span> <span class="break"></span> 스타트업 등록하기</h3>
            </div>
            <!-- /modal-header -->
            <div class="modal-body">
                <form class="form-horizontal" role="form" name="add_st_form" >
                    <input type="hidden" name="user_id" value="{s.id}" />
                    <input type="hidden" id="form_t" name="form_t" value="" />
                    <fieldset>
                        <div class="form-group">
                            <div  class="col-lg-3 control-label">회사명</div>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" placeholder="회사명" id="md-compEditor_com" name="name">
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div  class="col-lg-3 control-label">한 줄 설명</div>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" placeholder="한 줄 설명" name="bio">
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-lg-3 control-label">로고</div>
                            <div class="col-lg-9">
                                <input type="hidden" name="img" id="img" value="">
                                <!--<iframe width="100%" scrolling="no" height="160px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img/160x160?old=" allowtransparency="true"></iframe>//-->
                                <img class="img-thumbnail" src="/img/default-img-company.png" id="img_img" onclick="toggle_img();return false;">
                                <div id="div_img_change" style="display: none;">
                                    <iframe  height="500" frameborder="0" width="100%" scrolling="no" id="frm" allowTransparency="true" src="/ajax_front/form_file?which=img" ></iframe>
                                </div>
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-lg-3 control-label"> 설립일 </div>
                            <div class="col-lg-9"> 
                                <input type="text" class="form-control" name="founded" placeholder="2013.10.01">
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-lg-3 control-label">임직원수</div>
                            <div class="col-lg-9">
                                <div class="input-group"> <span class="input-group-addon"><span class="icon-group"></span></span>
                                    <input type="number" class="form-control" name="number">
                                    <span class="input-group-addon">명</span> </div>
                                <!-- /input-group --> 
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-lg-3 control-label">사업분야</div>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="bussiness" >
                                <span class="help-block">콤마(,)를 사용해서 구분해주세요</span> </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-lg-3 control-label">핵심기술</div>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="tech" >
                                <span class="help-block">콤마(,)를 사용해서 구분해주세요</span> </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-lg-3 control-label">웹사이트</div>
                            <div class="col-lg-9">
                                <input type="url" class="form-control" value="http://" name="website">
                                <!-- alert -->
                                <div class="alert alert-dismissable web_err" style="display: none;">
                                    <p class="text-danger"><strong>Oops!</strong> 웹사이트의 형식이 맞지 않습니다.</p>
                                </div>
                                <!-- /alert -->
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-lg-3 control-label">블로그</div>
                            <div class="col-lg-9">
                                <input type="url" class="form-control" value="http://" name="blog">
                                <!-- alert -->
                                <div class="alert alert-dismissable blog_err" style="display: none;">
                                    <p class="text-danger"><strong>Oops!</strong> 블로그의 형식이 맞지 않습니다.</p>
                                </div>
                                <!-- /alert -->
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-lg-3 control-label">SNS</div>
                            <div class="col-lg-9">
                                <p class="input-group"> <span class="input-group-addon"><span class="icon-twitter"></span> &nbsp;  Twitter</span>
                                    <input type="text" placeholder="twitter url" class="form-control" name="twitter" >
                                </p>
                                <!-- /input-group -->
                                <p class="input-group"> <span class="input-group-addon"><span class="icon-facebook"></span> &nbsp;  Facebook</span>
                                    <input type="text" placeholder="facebook url" class="form-control" name="facebook">
                                </p>
                                <!-- /input-group --> 
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-lg-3 control-label">메일주소</div>
                            <div class="col-lg-9">
                                <input type="email" class="form-control" placeholder="" name="email">
                                <!-- alert -->
                                <div class="alert alert-dismissable email_err" style="display: none;">
                                    <p class="text-danger"><strong>Oops!</strong> 이메일의 형식이 맞지 않습니다. </p>
                                </div>
                                <!-- /alert -->
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-lg-3 control-label">주소</div>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" placeholder="" name="addr">
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-lg-3 control-label">연락처</div>
                            <div class="col-lg-9">
                                <input type="tel" class="form-control" placeholder="" name="tel">
                            </div>
                        </div>
                        <!-- /form-group -->
                    </fieldset>
                </form>
            </div>
            <!-- /modal-body -->

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" onclick="st_submit(this); return false;">확인</button>
            </div>
            <!-- /modal-footer --> 
        </div>
        <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 
</div>
<!-- /modal #md-compEditor -->

<!-- modal #md-compEditor -->
<div class="modal fade" id="md-invEditor" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div>
<!-- /modal #md-compEditor -->

<script type="text/javascript">
//<![CDATA[
{? ref_al}
   msg_confirm_yesno("javascript:location.href='/member/edit_reference'", '{ref_al}', "cache_set('ref_{res.id}', '{res.id}')");
{/}    
    
{? (s.id == res.id) && ( !res.birth || !res.gender)}
    $('#md-profilecheck').modal('show');
{/}
    
function cache_set(_type, _user) {
    var get_url = '/ajax_front/use_cache/';
    var set_data ={
        "type" 		: _type,
        "id" 		: _user,
    };

    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function() {}
    });
}

function find_com(_this, _type){
    var key = $(_this).parent().parent().find('input[name=company]').val().replace(/(^\s*)|(\s*$)/gi, "");
    var form =  $(_this).parent().parent().parent().parent().parent().parent().parent().attr('id');
    var get_url = '/ajax_front/get_search_startup2/'+_type;
    var set_data ={
        "data" 		: key,
        "v" 		: 1,
        "form"          : form,
    };
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {

            $('#md-searchStartup').html(_data);
            $('#md-searchStartup').modal('show');
        }
    });
}

function enter_startup(_form, _type){
    var tt = $('#search_in').val();
    tt = tt.replace(/(^\s*)|(\s*$)/gi, "");
    $('.modal').modal('hide');
    if (_type === '1') {
        $('#md-compEditor_com').val(tt);
        $('#form_t').val(_form);
        $('#md-compEditor').modal('show');
    }
    else {
   
        var get_url = '/ajax_front/get_add_investment/';
        var set_data ={
            "data" 		: tt,
            "v" 		: 1,
            "form"          : _form,
        };

        $.ajax({
            type : 'POST',
            url : get_url,
            data : set_data,
            dataType : 'html',
            success : function(_data) {
                $('#md-invEditor').html(_data);
                $('#md-invEditor').modal('show');
            }
        });
    }
}

function recive_com(_val, _form){
    $('#'+_form+' [name=company]').val(_val);
    $('#'+_form+' [name=company]').attr('readonly', 'readonly');
    $('#md-searchStartup').modal('hide');
}

function st_submit(_this) {
    $('.alert-dismissable').hide();
    
    if ($('input[name=website]').val().length > 7) {
        var t = valid_url($('input[name=website]').val());
        if (t === false) {
            $('.web_err').show();
            document.add_st_form.website.focus();
            return false;
        }
    }
    if ($('input[name=blog]').val().length > 7) {
        var t = valid_url($('input[name=blog]').val());
        if (t === false) {
            $('.blog_err').show();
            document.add_st_form.blog.focus();
            return false;
        }
    }
    if ($('input[name=email]').val().length > 0) {
        var t = valid_email(document.add_st_form.email);
        if (t === false) {
            $('.email_err').show();
            document.add_st_form.email.focus();
            return false;
        }
    }
    var get_url = '/ajax_front/add_startup/';
    {? res.utype == 1}
    var frm = $('form[name=add_st_form]');
    {/}{? res.utype == 2}
    var frm = $('form[name=add_inv_form]');
    {/}
    var set_data = frm.serialize();;
    var _form = $('#form_t').val();
    {? res.utype == 2}_form = $('#form_inv').val();{/}
    $(_this).hide();
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            {? res.utype == 1}
            $('#'+_form+' [name=company]').val($('#md-compEditor_com').val());
            {/}{? res.utype == 2}
            $('#'+_form+' [name=company]').val($('#md-invEditor_com').val());
            {/}
            $('#'+_form+' [name=company]').attr('readonly', 'readonly');
            $(_this).show();
            $('.modal').modal('hide');
        }
    });
}
{? tab}
$('a[href=#{tab}]').parent().addClass('active');
{/}

if ($('.nav-tabs li.active').length < 1) {
    $('.nav-tabs li:eq(0)').addClass('active');    
}

var target = $('ul.nav.nav-tabs > li.active a').attr('href');
$('#'+target.substring(1)).addClass('active');
//]]>
</script> 