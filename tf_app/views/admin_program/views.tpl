
    <!-- rowContent -->
    <div class="rowContent" id="program">
         
        <div class="page-header">
            <div class="container">
                <h2><a href="/admin_program">스타트업 지원 프로그램</a></h2>
                {? (s.per & settings->permission1) == settings->permission1}
                {? s.ids}
                <button  class="btn btn-primary pull-right" onclick=location.href='/admin_program/edit'><span class="icon-pencil"></span> 프로그램 만들기</button>
                {:}
                <button  class="btn btn-primary pull-right" onclick="javascript:alert('로그인이 필요합니다.');"><span class="icon-pencil"></span> 프로그램 만들기</button>
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
                                <h3> {res.title} </h3>
                                <div class="meta">
                                    <span class="author"><a  href="/member/{res.ids}">{res.ids} ({res.name})</a></span> &nbsp; 
                                    <span class="time"><span class="icon-time"></span> {= trans_date_ago(res.date_created)}</span>
                                    {? res.user_id == s.id} &nbsp; <span class="modify"><a href="/admin_program/edit/{res.id}" class="btn btn-default btn-xs">관리자 페이지</a></span>{/}
                                    <span class="pull-right">
                                        <a href="https://www.google.com/calendar/render?action=TEMPLATE&text={=str_replace('&', '%26', str_replace('#', '%23', res.title))}&dates={=substr_replace(g_start, 'T', 8, 0)}Z/{=substr_replace(g_end, 'T', 8, 0)}Z&sprop=name:DCAMP&details=지원기관 : {=str_replace('&', '%26', res.agency)}%0AURL : http://dcamp.kr/admin_program/views/{res.id}%0A&pli=1&sf=true&output=xml#h|month" class="btn btn-default btn-xs" target="_blank">
                                            <i class="fa fa-calendar"></i> 구글캘린더에 등록하기
                                        </a>
                                    </span>
                                </div>
                            </div>
                            <div class="article-body">
                                <div class="item-status">
                                    <dl class="dl-horizontal">
                                        <dt>지원기관</dt>
                                        <dd>{res.agency} </dd>
                                        <dt>성격</dt>
                                        <dd>{res.category} </dd>
                                        <dt>접수기간</dt>
                                        <dd>{=substr(res.a_start, 0, 10)} ({=date_to_day_only(substr(res.a_start, 0, 10))}) {=substr(res.a_start, 11)} ~ {=substr(res.a_end, 0, 10)} ({=date_to_day_only(substr(res.a_end, 0, 10))}) {=substr(res.a_end, 11)} &nbsp;
                                            {? date('Y.m.d H:i') < res.a_start}<span class="label label-info">접수 준비</span>&nbsp;{/}
                                            {? date('Y.m.d H:i') > res.a_start && date('Y.m.d H:i') < res.a_end}<span class="label label-primary">접수중</span>&nbsp;{/} 
                                            {? date('Y.m.d H:i') > res.a_end}<span class="label label-warning">접수마감</span>&nbsp;{/}
                                        </dd>
                                        <dt>인원</dt>
                                        <dd>{? res.cnt} {res.cnt}명{:}제한없음{/}</dd>
                                        <dt>담당자 연락처</dt>
                                        <dd>{? res.tel}{res.tel}&nbsp;{/}{res.addr}</dd>
                                    </dl>
                                </div>
                                
                                <article>
                                    {res.content}
                                </article>                                
                                
                                {? res.file}
                                <dl class="dl-horizontal item-attach">
                                    <dt>첨부파일</dt>
                                    <dd><a href='/admin_program/get_cp_file?cid={res.id}'>{res.filename}</a></dd>
                                    
                                </dl>
                                {/}
                            </div>
                            <!-- /article-body -->
                            
                        </div>
                        <!-- / article --> 
                        {? s && (res.user_id == s.id)}
                        <div class="formApply">
                            <h3><span class="icon-edit"></span> 참가 신청하기</h3>
                            <div class="well text-center"> 
                                <div><a class="btn btn-primary" href="/admin_program/applied_list/{res.id}">&nbsp; &nbsp; &nbsp; &nbsp; <span class="icon-hand-right"></span>&nbsp; 참가자 목록 보기 &nbsp; &nbsp; &nbsp; &nbsp; </a></div>
                            </div>
                        </div>
                        <!-- /formApply -->
                        {:}

                        {? date('Y.m.d H:i') <= res.a_end}
                        <!-- formApply -->
                        <div class="formApply">
                            <h3><span class="icon-edit"></span> 참가 신청하기</h3>
                            
                            {? s.id || res.logined}
                            {? !my}
                            <div class="well text-center"> 
                                <button class="btn btn-primary" onclick="location.href='/admin_program/apply/{res.id}'">&nbsp; &nbsp; &nbsp; &nbsp; <span class="icon-hand-right"></span>&nbsp; 참가 신청하기 &nbsp; &nbsp; &nbsp; &nbsp; </button>
                            </div>
                            {:}
                            <div class="well complete text-center"> 
                                <h4><span class="icon icon-smile icon-large"></span>&nbsp;  신청완료!!</h4>
                                <p>참가신청이 접수 되었습니다.  [마이페이지]에서 상태를 확인 할 수 있습니다.</p>
                                <div><a class="btn btn-default btn-sm" href="/">홈으로</a>
                                <a href="/admin_program/apply/{res.id}/{my.id}" class="btn btn-default btn-sm">참가 신청 내용보기</a></div>
                            </div>
                            {/}
                            {:}
                            <div class="well text-center">  
                                <p>D.CAMP 회원이시면 누구나 신청 가능 합니다. 로그인 해주세요. ^^</p>
                                <div><a class="btn btn-default btn-sm" href="/login">로그인하기</a></div>
                            </div>
                            {/}                                
                                
                        </div>
                        {:}
                        <div class="formApply">
                            <div class="alert alert-info text-center">
                                <p>참가신청이 마감되었습니다.</p>
                                <a class="btn btn-default btn-sm" href="/admin_program">프로그램 리스트 보기</a>
                            </div>
                        </div>
                        {/}
                        
                        {/}

                        <div id="comment">
                            
<script type="text/javascript">
//<![CDATA[
get_timeline(9, '{res.id}', 1);
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
                        <div class="panel recentporst">
                            <h3 class="panel-title">Recent Program</h3>
                            <ul class="media-list post-list">
                                {@ sub}
                                <li class="media">
                                    {?.img}<a class="pull-left media-object" href="/admin_program/views/{.id}"> <img src="{.img}" class="img-responsive"> </a>{/}
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/admin_program/views/{.id}"> {.title}</a></h4>
                                        <div class="media-meta"> <span class="icon-calendar"></span> {=substr(.a_start, 0, 10)} ({=date_to_day_only(substr(.a_start, 0, 10))}) ~ {=substr(.a_end, 0, 10)} ({=date_to_day_only(substr(.a_end, 0, 10))}) </div>
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
