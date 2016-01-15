
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
        
        <div class="page-content"> 
            <!-- container -->
            <div class="container">
                <div  class="row"> 
                    <!-- content -->
                    <div class="col-xs-12 col-sm-12 col-md-9 content">
                    
                        <div id="article">
                            <div class="article-header">
                                <h3><a href="/competition/views/{res.id}">{res.subject}</a></h3> 
                                <div class="meta">
                                    <span class="author"><a  href="/member/{res.ids}">{res.name}</a></span>,
                                    <span class="time"><span class="icon-time"></span> {= trans_date_ago(res.date_created)}</span>
                                    {? res.user_id == s.id} &nbsp; <span class="modify"><a href="/competition/edit/{res.id}" class="btn btn-default btn-xs">수정하기</a></span>{/}
                                    <span class="pull-right">
                                        <a href="https://www.google.com/calendar/render?action=TEMPLATE&text={=str_replace('&', '%26', str_replace('#', '%23', res.subject))}&dates={=substr_replace(g_start, 'T', 8, 0)}Z/{=substr_replace(g_end, 'T', 8, 0)}Z&sprop=name:DCAMP&location={? res.space_id == 0}{res.space_etc}{:}D.CAMP {res.opt}F {=explode_ext(res.sname, '(')}{/}&details=주최·주관 : {=str_replace('&', '%26', res.organized)}%0A발표일자 : {res.announce_d} ({=date_to_day_only(res.announce_d)}) {res.announce_t}%0AURL : http://dcamp.kr/competition/views/{res.id}%0A&pli=1&sf=true&output=xml#h|month" class="btn btn-default btn-xs" target="_blank">
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
                                
                                {?res.file}
                                <dl class="dl-horizontal item-attach">
                                    <dt>첨부파일</dt>
                                    <dd><a href="/competition/get_cp_source?cp={res.id}&file={res.file}">{res.file}</a></dd>
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
                        {? s && (res.user_id == s.id || ex.euid == s.id)}
                        <div class="formApply">
                            <h3><span class="icon-edit"></span> 참가 신청하기</h3>
                            <div class="well text-center"> 
                                <div><a class="btn btn-primary" href="/competition/applied_list/{res.id}">&nbsp; &nbsp; &nbsp; &nbsp; <span class="icon-hand-right"></span>&nbsp; 참가자 목록 보기 &nbsp; &nbsp; &nbsp; &nbsp; </a></div>
                            </div>
                        </div>
                        <!-- /formApply -->
                        {:}

                        {? date('Y.m.dH:i') <= res.edate}
                        <!-- formApply -->
                        <div class="formApply">
                            <h3><span class="icon-edit"></span> 참가 신청하기</h3>
                            
                            {? s.id}
                            {? res.platform == 1 && !my}
                            <div class="well text-center"> 
                                <button class="btn btn-primary" onclick="location.href='/competition/apply/{res.id}'">&nbsp; &nbsp; &nbsp; &nbsp; <span class="icon-hand-right"></span>&nbsp; 참가 신청하기 &nbsp; &nbsp; &nbsp; &nbsp; </button>
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
                                <a href="/competition/apply/{res.id}/{my.id}" class="btn btn-default btn-sm">참가 신청 내용보기</a></div>
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
                                <a class="btn btn-default btn-sm" href="/competition">경진대회 리스트 보기</a>
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
                    {? sub}
                    <div class="col-xs-12 col-sm-12 col-md-3 sidebar">
                    
                        <!-- panel -->
                        <div class="panel recentporst">
                            <h3 class="panel-title">Recent Competition</h3>
                            <ul class="media-list post-list">
                                {@ sub}
                                <li class="media">
                                    {?.img}<a class="pull-left media-object" href="/competition/views/{.id}"> <img src="{.img}" class="img-responsive"> </a>{/}
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/competition/views/{.id}"> {.subject}</a></h4>
                                        <div class="media-meta"> <!--span class="icon-trophy"></span> {.name} &nbsp;&nbsp;  --><span class="icon-calendar"></span> {.date_s} ({=date_to_day_only(.date_s)}) {.time_s} ~ {.date_e} ({=date_to_day_only(.date_e)}) {.time_e} </div>
                                    </div>
                                </li>
                                 {/}
                            </ul>
                        </div>
                        <!-- /panel--> 
                       
                    </div>
                    <!-- / sidebar --> 
                    {/}
                </div>
                <!-- row --> 
            </div>
            <!-- /container --> 
        </div>
        <!-- /page-content --> 
        
    </div>
    <!-- /rowContent --> 
