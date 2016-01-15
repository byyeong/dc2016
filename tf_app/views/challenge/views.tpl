
    <!-- rowContent -->
    <div class="rowContent" id="competition">
         
        {? res.top_img}
        <div class="page-header" id="post-heading" {? res.top_img}style="background-image:url({res.top_img});"{/}>
            <div class="headmask">
                <div class="container">
                    <h2>{res.top_title}</h2> 
                    <p>{res.top_sub}</p>
                </div>
            </div>
        </div>
        {:}
        <div class="page-header" id="post-heading" style="background-image:url(/images/bg-default.png);">
            <div class="headmask">
                <div class="container">
                    <h2>{?res.top_title}{res.top_title}{:}{res.subject}{/}</h2> 
                    {? res.top_sub}<p>{res.top_sub}</p>{/}
                </div>
            </div>
        </div>
        {/}
        <!-- /page-header -->
        
        <div class="page-content"> 
            <!-- container -->
            <div class="container">
                <div  class="row"> 
                    <!-- content -->
                    <div class="col-xs-12 col-sm-12 col-md-9 content">
                    
                        <div id="article">
                            <div class="article-header">
                                <div class="meta">
                                    <span class="author"><a  href="/member/{res.ids}">{res.ids} ({res.name})</a></span>,
                                    <span class="time"><span class="icon-time"></span> {= trans_date_ago(res.date_created)}</span>
                                    {? res.user_id == s.id} &nbsp; <span class="modify"><a href="/challenge/edit/{res.id}" class="btn btn-default btn-xs">관리자 페이지</a></span>{/}
                                    <span class="pull-right">
                                        <a href="https://www.google.com/calendar/render?action=TEMPLATE&text={=str_replace('&', '%26', str_replace('#', '%23', res.subject))}&dates={=substr_replace(g_start, 'T', 8, 0)}Z/{=substr_replace(g_end, 'T', 8, 0)}Z&sprop=name:DCAMP&location={? res.space_id == 0}{res.space_etc}{:}D.CAMP {res.opt}F {=explode_ext(res.sname, '(')}{/}&details=주최·주관 : {=str_replace('&', '%26', res.organized)}%0A발표일자 : {res.announce_d} ({=date_to_day_only(res.announce_d)}) {res.announce_t}%0AURL : http://dcamp.kr/challenge/views/{res.id}%0A&pli=1&sf=true&output=xml#h|month" class="btn btn-default btn-xs" target="_blank">
                                            <i class="fa fa-calendar"></i> 구글캘린더에 등록하기
                                        </a>
                                    </span>
                                </div>
                            </div>
                            <div class="article-body">
                                <div class="item-status">
                                    <dl class="dl-horizontal">
                                        {? res.organized}<dt>주최&middot;주관</dt>
                                        <dd>{res.organized} </dd>{/}
                                        {? res.backing}<dt>후원기관</dt>
                                        <dd>{res.backing} </dd>{/}
                                        <dt>신청기한</dt>
                                        <dd>{res.date_s} ({=date_to_day_only(res.date_s)}) {res.time_s} ~ {res.date_e} ({=date_to_day_only(res.date_e)}) {res.time_e} &nbsp;
                                            {? date('Y.m.dH:i') < res.sdate}<span class="label label-info">접수 준비</span>&nbsp;{/}
                                            {? date('Y.m.dH:i') > res.sdate && date('Y.m.dH:i') < res.edate}<span class="label label-primary">접수중</span>&nbsp;{/} 
                                            {? date('Y.m.dH:i') > res.edate}<span class="label label-warning">접수마감</span>&nbsp;{/}
                                            {? date('Y.m.dH:i') > res.announce && res.winner}<span class="label label-default">수상자 발표</span>{/}
                                        </dd>
                                        <dt>발표일자</dt>
                                        <dd>{res.announce_d} ({=date_to_day_only(res.announce_d)}) {res.announce_t}</dd>
                                    </dl>
                                </div>
                                
                                <article>
                                    {res.contents}
                                </article>                                
                                
                                {? res.a_file}
                                <dl class="dl-horizontal item-attach">
                                    <dt>첨부파일</dt>
                                    <dd>{@ res.a_file}{? .key_ != 0}<br/>{/}
                                    <a href='/challenge/get_cp_file?cid={.competitions_id}&fid={.id}&file={.name}'>{.name}</a>{/}</dd>
                                    
                                </dl>
                                {/}
                            </div>
                            <!-- /article-body -->
                            
                            {? res.winner && res.winner_open && date('Y.m.dH:i') > res.announce}
                            <div class="article-winner"> 
                                <h4><span class="icon-fixed-width icon-trophy"></span> 수상자 발표</h4> 
                                <article>
                                    {res.winner}
                                </article> 
                            </div>
                            {/}
                            <!-- /article-winner -->
                        </div>
                        <!-- / article --> 
                        {? s && (res.user_id == s.id || ex.euid == s.id || op)}
                        <div class="formApply">
                            <h3><span class="icon-edit"></span> 참가 신청하기</h3>
                            <div class="well text-center"> 
                                <div><a class="btn btn-primary" href="/challenge/applied_list/{res.id}">&nbsp; &nbsp; &nbsp; &nbsp; <span class="icon-hand-right"></span>&nbsp; 참가자 목록 보기 &nbsp; &nbsp; &nbsp; &nbsp; </a></div>
                            </div>
                        </div>
                        <!-- /formApply -->
                        {:}

                        {? date('Y.m.dH:i') <= res.edate}
                        <!-- formApply -->
                        <div class="formApply">
                            <h3><span class="icon-edit"></span> 참가 신청하기</h3>
                            
                            {? s.id || res.logined}
                            {? res.platform == 1 && !my}
                            <div class="well text-center"> 
                                {? res.group}
                                <div class="row">
                                    <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-8 col-md-offset-2">
                                        <button class="btn btn-primary btn-block" onclick="location.href='/challenge/apply/{res.id}'">&nbsp; &nbsp; &nbsp; &nbsp; <span class="icon-hand-right"></span>&nbsp; '{res.department}' 신청하기 &nbsp; &nbsp; &nbsp; &nbsp; </button>
                                        {@ res.group}
                                        <button class="btn btn-primary btn-block" onclick="location.href='/challenge/apply/{.id}'">&nbsp; &nbsp; &nbsp; &nbsp; <span class="icon-hand-right"></span>&nbsp; '{.department}' 신청하기 &nbsp; &nbsp; &nbsp; &nbsp; </button>
                                        {/}
                                    </div>
                                </div>
                                {:}
                                <button class="btn btn-primary" onclick="location.href='/challenge/apply/{res.id}'">&nbsp; &nbsp; &nbsp; &nbsp; <span class="icon-hand-right"></span>&nbsp; 참가 신청하기 &nbsp; &nbsp; &nbsp; &nbsp; </button>
                                {/}
                            </div>
                            {/}{? res.platform == 0}
                            <div class="well text-center">
                                <p>외부에서 진행되는 경진대회입니다. 참가 신청하려면 아래의 버튼을 클릭하세요.</p>
                                <a class="btn btn-primary" target="_blank" href='{res.platform_out}'>
                                    &nbsp; &nbsp; &nbsp; &nbsp; <span class="icon-hand-right"></span>&nbsp; 참가 신청하기 &nbsp; &nbsp; &nbsp; &nbsp; 
                                </a>
                            </div>
                            {/}
                            {? res.platform == 1 && my}
                            <div class="well complete text-center"> 
                                <h4><span class="icon icon-smile icon-large"></span>&nbsp;  신청완료!!</h4>
                                <p>참가신청이 접수 되었습니다.  [마이페이지]에서 상태를 확인 할 수 있습니다.</p>
                                <div><a class="btn btn-default btn-sm" href="/">홈으로</a>
                                <a href="/challenge/apply/{res.id}/{my.id}" class="btn btn-default btn-sm">참가 신청 내용보기</a></div>
                            </div>
                            {/}
                            {:}
                            <div class="well text-center">  
                                <p>D.CAMP 회원이시면 누구나 신청 가능 합니다. 로그인 해주세요. ^^</p>
                                <div><a class="btn btn-default btn-sm" href="/login">로그인하기</a></div>
                            </div>
                            {/}                                
                                
                        </div>
                        <!-- /formApply -->
                        {:}
                        <div class="formApply">
                            <div class="alert alert-info text-center">
                                <p>참가신청이 마감되었습니다. 결과 발표를 준비 중 입니다.</p>
                                <a class="btn btn-default btn-sm" href="/challenge">경진대회 리스트 보기</a>
                            </div>
                        </div>
                        {/}
                        
                        {/}

                        <div id="comment">
                            
<script type="text/javascript">
//<![CDATA[
get_timeline(7, '{res.id}', 1);
function get_timeline(_type, _id, _page)
{
    var get_url = '/ajax_front/get_timeline/'+_type+'/'+_id+'/'+_page;
    $.get(get_url, function(_data) {
        $('#comment').html(_data);
    });
}
//]]>
</script> 
                        </div>
                        <!-- /comment --> 
                        
                    </div>
                    <!-- / content -->
                    
                    <div class="col-xs-12 col-sm-12 col-md-3 sidebar">
                        {? sub}
                        <div class="panel recentporst">
                            <h3 class="panel-title">최신 Challenge</h3>
                            <ul class="media-list post-list">
                                {@ sub}
                                <li class="media">
                                    <a class="pull-left media-object" href="/challenge/views/{.id}"> <img src="{?.img}{.img}{:}/img/default-img-news.png{/}" class="img-responsive"> </a>
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/challenge/views/{.id}"> {.subject}</a></h4>
                                        <div class="media-meta"> <!--span class="icon-trophy"></span> {.name} &nbsp;&nbsp;  --><span class="icon-calendar"></span> {.date_s} ({=date_to_day_only(.date_s)}) {.time_s} ~ {.date_e} ({=date_to_day_only(.date_e)}) {.time_e} </div>
                                    </div>
                                </li>
                                 {/}
                            </ul>
                        </div>
                        <!-- /panel--> 
                        {/}
                        
                        {? ev}
                        <!-- panel -->
                        <div class="panel  recentpost">
                            <h3 class="panel-title">최신 Event</h3> 
                            <ul class="media-list post-list">
                                {@ ev}
                                <li class="media"> 
                                    <a class="pull-left media-object" href="/event/apply/{.id}"> <img src="{?.picture}{.picture}{:}/img/default-img-news.png{/}" class="img-responsive" > </a>
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/event/apply/{.id}">{.title}</a></h4>
                                        <div class="media-meta">
                                            <span class="date">{?.date}{.date} {? .start}{.start}{/}{/} {?.date_e}~ {.date_e} {? .end}{.end}{/}{/}</span>&nbsp;
                                            <!--span class="author"><a  href="/member/{.ids}">{.mname}</a></span--> 
                                            <!--span class="time"><span class="icon-time"></span>&nbsp; {= trans_date_ago(res.date_created)}</span--> 
                                        </div>
                                    </div>
                                    <!-- /media-content --> 
                                </li>
                                {/}
                            </ul> 
                        </div>
                        <!-- /panel--> 
                        {/}

                        <!-- panel -->
                        <div id="loungebox" class="panel panel-default ">
                            <div class="panel-header">
                                <div class="cover">
                                    <h3 class="panel-title">D.CAMP Lounge</h3>
                                    <p>지금 D.CAMP에 {u_cnt}+명이 함께하고 있습니다</p>
                                </div>
                            </div>
                            <div class="panel-body">
                                <!-- media -->
                                <ul class="media-list">
                                    {@ lounge}
                                    <li class="media" id="com3397">
                                        <a class="media-left" href="/member/{.ids}">
                                            <img src="{.picture}" alt="{.name}" class="avatar img-circle">
                                        </a>
                                        <div class="media-body">
                                            <h4 class="media-heading">
                                                <a href="/member/{.ids}">{.name}</a> 
                                            </h4>
                                            <div class="media-content"> 
                                                <p>{=trans_url(add_brs(.contents))}</p>
                                            </div>
                                            {? .p_name}
                                            <div class="media-footer">
                                                <small>
                                                <a href="/lounge/event/{.p_id}">{.p_name} </a>
                                                </small>
                                            </div>
                                            {/}
                                            <div class="media-meta">
                                                <a class="date" href="/lounge/comment/{.id}">{=substr(.date_created, 0, -3)}</a>
                                                <span class="like">
                                                    <span class="glyphicon glyphicon-heart"></span> 
                                                    <span class="sr-only">좋아요 </span> 
                                                    <span class="cnt">{.like}</span>
                                                </span>
                                                <span class="comment">
                                                    <span class="glyphicon glyphicon-comment"></span> 
                                                    <span class="sr-only">댓글 </span>  
                                                    <span class="cnt">{.com}</span> 
                                                </span>
                                            </div>
                                        </div>
                                    </li>
                                    {/}
                                </ul> 
                            </div>
                            <div class="panel-footer">
                                <a href="/lounge">라운지 가기</a>
                            </div>
                        </div>
                        <!-- /panel--> 
                        
                        <div class="panel">
                            <div class="fb-page" data-href="https://www.facebook.com/dcamp.kr" data-width="263" data-small-header="false" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="true" data-show-posts="false"><div class="fb-xfbml-parse-ignore"><blockquote cite="https://www.facebook.com/dcamp.kr"><a href="https://www.facebook.com/dcamp.kr">D.CAMP</a></blockquote></div></div>
                        </div>
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
