<!-- rowContent -->
<div class="rowContent" id="event">
    <div class="page-header">
            <div class="container">
                <h2><a href="/event">Event</a></h2> 
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
                
                    <div id="article">
                        <div class="article-header">
                            <h3> {res.title} </h3>
                            <div class="meta">
                                <span class="author"><a  href="/member/{res.ids}">{res.mname}</a></span>,
                                <span class="time"><span class="icon-time"></span> {= trans_date_ago(res.date_created)}</span> 
                                <span class="pull-right">
                                    <a href="https://www.google.com/calendar/render?action=TEMPLATE&text={=str_replace('&', '%26', str_replace('#', '%23', res.title))}&dates={=substr_replace(g_start, 'T', 8, 0)}Z/{=substr_replace(g_end, 'T', 8, 0)}Z&sprop=name:DCAMP&location={? res.space_id == 0}{res.space_etc}{:}D.CAMP {res.opt}F {=explode_ext(res.sname, '(')}{/}&details=신청기한 : {? res.apply_start}{res.apply_start} {/}{? res.apply_end} ~ {res.apply_end} {/}%0A신청현황 : {?res.cnt}{res.cnt}{:}제한없음{/}%0AURL : http://dcamp.kr/event/apply/{res.id}%0A&pli=1&sf=true&output=xml#h|month" class="btn btn-default btn-xs" target="_blank">
                                        <i class="fa fa-calendar"></i> 구글캘린더에 등록하기
                                    </a>
                                </span>
                                {? res.user_id == s.id} &nbsp; <span class="modify"><a href="/event/add/{res.id}" class="btn btn-default btn-xs">수정하기</a></span>{/}
                             </div>
                        </div>
                        
                        <div class="article-body"> 
                            <div class="item-status">
                                <dl class="dl-horizontal">
                                    <dt>신청기한</dt>
                                    <dd>{? res.apply_start}{res.apply_start} {/}{? res.apply_end} ~ {res.apply_end} {/}</dd>
                                    {? !res.is_profile}
                                    <dt>일시</dt>
                                    <dd>{? datetimeDiff(res.date_e, res.end, date('y.m.d H:i'), '.') < 0}<span class="label label-default">완료</span> {/}{?res.date}{res.date} ({=date_to_day_only(res.date)}) {? res.start}{res.start}{/}{/} {?res.date_e}~ {res.date_e} ({=date_to_day_only(res.date_e)}) {? res.end}{res.end}{/}{/}</dd>
                                    
                                    {? res.space_etc || res.space_id > 0}
                                    <dt>장소</dt>
                                    <dd>{? res.space_id == 0}{res.space_etc}{:}{res.opt}F {=explode_ext(res.sname, '(')}{/}</dd>
                                    {/}
                                    <!--
                                    <dt>시간</dt>
                                    <dd>{res.start} ~ {res.end}</dd> 
                                    -->
                                    <dt>신청현황</dt>
                                    <dd>{? res.enroll == 1}신청자 <span class="badge">{res.rcnt}</span> / {/} 정원 <span class="badge">{?res.cnt}{res.cnt}{:}제한없음{/}</span></dd>
                                    {/}
                                    {? res.file}
                                    <dt>자료첨부</dt>
                                    <dd><a href="/event/get_ev_source?ev={res.id}&file={res.filename}">{res.filename}</a></dd>
                                    {/}
                                </dl> 
                            </div>
                            
                            <div class="fb-like" data-href="http://dcamp.kr/event/apply/{res.id}" data-width="The pixel width of the plugin" data-height="The pixel height of the plugin" data-colorscheme="light" data-layout="standard" data-action="like" data-show-faces="true" data-send="false"></div>
                            
                            <article>
                                {res.contents}
                            </article>
                            <!--div class="text-center">
                                <a href="/lounge/event/{res.id}" class="btn btn-default"><i class="fa fa-users"></i>&nbsp; 이벤트 라운지 가기 &nbsp;<i class="fa fa-long-arrow-right"></i></a>
                            </div-->
                        </div>
                    </div>
                    <!-- / article -->
                    
                    <div class="formApply" {? !already}style="display: none;"{/} id="event_res"> 
                        <h3><span class="icon-edit"></span> 이벤트 참가 신청하기</h3> 
                        
                        <div  id="applyE_res" >
                            <div class="well complete"> 
                                <h4 class="text-center"><span class="icon icon-smile icon-large"></span>&nbsp;  신청완료!!</h4>
                                <p class="text-center">이벤트 참가 신청이 완료되었습니다. 개인 액티비티에서 확인 가능합니다.</p>
                                <div class="text-center">
                                    <a href="/" class="btn btn-default">홈으로</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <a href="#" onclick="del_apply('{already.id}'); return false;" class="btn btn-default">신청취소</a>
                                </div>
                            </div>
                        </div>
                        {? part}
                        <div class="applicant">
                            <h4><span class="icon-ok"></span> 이벤트 참가 신청자</h4>
                            {? s.id == res.user_id}<span class="pull-right"><button class="btn btn-default btn-xs" onclick="javascript:document.location.href='/ajax/info_excel/{res.id}'"><span class="icon-download-alt"></span> Excel</button></span>{/}
                            <ul class="list-unstyled list-inline list-applicant">
                                {@ part}
                                <li><a href="/member/{.ids}"><img src="{.picture}" class="img-circle" title="{.mname}" data-toggle="tooltip"></a></li> 
                                {/}
                            </ul>
                        </div>
                        {/}
                        {? part2}
                        <div class="applicant">
                            <h4><span class="icon-plus"></span> 이벤트 참가 대기자</h4>
                            {? s.id == res.user_id}<span class="pull-right"><button class="btn btn-default btn-xs" onclick="javascript:document.location.href='/ajax/info_excel/{res.id}'"><span class="icon-download-alt"></span> Excel</button></span>{/}
                            <ul class="list-unstyled list-inline list-applicant">
                                {@ part2}
                                <li><a href="/member/{.ids}"><img src="{.picture}" class="img-circle" title="{.mname}" data-toggle="tooltip"></a></li> 
                                {/}
                            </ul>
                        </div>
                        {/}
                    </div>

{? res.state == 1 || (res.state == 0 && res.is_profile == 1)}          
    {? res.apply_end > date('Y.m.d H:i') && res.apply_start < date('Y.m.d H:i')}
        {? ((s.per & settings->permission3) == settings->permission3 || (s.per & settings->permission1) == settings->permission1) 
                && res.enroll == 1}
                    <div class="formApply" {? already}style="display: none;"{/} id="event_app"> 
                         <h3><span class="icon-edit"></span> 이벤트 참가 신청하기</h3> 
                        
                        <div class="well" id="applyE_form" {? already}style="display: none;"{/}>
                            <form class="form-horizontal" role="form" name="e_apply_form">
                                <input type="hidden" name="event_id" value="{res.id}" />
                                <input type="hidden" name="user_id" value="{s.id}" />
                                <input type="hidden" name="enroll" value="{res.enroll}" />
                                <input type="hidden" name="enroll_type" value="{res.enroll_type}" />
                                <input type="hidden" name="cnt" value="{res.cnt}" />
                                <input type="hidden" name="rcnt" value="{res.rcnt}" />
                                <fieldset>
                                    <!-- todo: 이벤트 상세에서 처리 되고 있는 부분 
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label ">신청현황</div>
                                        <div class="col-xs-12 col-sm-8 col-md-8">
                                            <p class="form-control-static"> 정원 <span class="badge badge-info">50</span>명 / 
                                                신청자 <span class="badge badge-success">50</span>명 / 
                                                대기자 <span class="badge badge-warning">50</span>명 </p>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-md-2 control-label ">이름</div>
                                        <div class="col-xs-12 col-sm-8 col-md-8">
                                            <p class="form-control-static"><strong>{s.name}</strong></p>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label ">이메일</div>
                                        <div class="col-xs-12 col-sm-8 col-md-8">
                                            <p class="form-control-static">{s.email}</p>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label ">소속</div>
                                        <div class="col-xs-12 col-sm-8 col-md-8">
                                            <div class="input-group"> <span class="input-group-addon"><span class="icon-building"></span></span>
                                                <input type="text" class="form-control" value="{s.company}" placeholder="소속된 회사명을 입력해주세요" name="company">
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    <!--
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label ">홈페이지</div>
                                        <div class="col-xs-12 col-sm-8 col-md-8">
                                            <div class="input-group"> <span class="input-group-addon"><span class="icon-home"></span></span>
                                                <input type="text" class="form-control" value="{s.website}" placeholder="" name="homepage">
                                            </div>
                                        </div>
                                    </div>
                                    //-->
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label ">연락처</div>
                                        <div class="col-xs-12 col-sm-8 col-md-8">
                                            <div class="input-group"> <span class="input-group-addon"><span class="icon-phone"></span></span>
                                                <input type="tel" class="form-control" value="{s.tel}" placeholder="연락가능한 전화번호를 입력해주세요">
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    {? !res.is_profile}
                                    <div class="form-group form-submit">
                                        <div class="col-sm-offset-2 col-md-offset-2">
                                            <button type="submit" class="btn btn-primary" onclick="submit_apply(this); return false;">신청하기</button>
                                        </div>
                                    </div>
                                    {:}
                                    <div class="form-group form-submit">
                                        <div class="col-sm-offset-2 col-md-offset-2">
                                            <button type="submit" class="btn btn-primary" data-target="#md-profile" data-toggle="modal" onclick="show_profile(); return false;">프로필 수정하고, 이벤트 신청하기</button>
                                        </div>
                                    </div>
                                    {/}
                                </fieldset>
                            </form>
                        </div>
                        {? part}                    
                        <div class="applicant">
                            <h4><span class="icon-ok"></span> 이벤트 참가 신청자</h4>
                            {? s.id == res.user_id}<span class="pull-right"><button class="btn btn-default btn-xs" onclick="javascript:document.location.href='/ajax/info_excel/{res.id}'"><span class="icon-download-alt"></span> Excel</button></span>{/}
                            <ul class="list-unstyled list-inline list-applicant">
                                {@ part}
                                <li><a href="/member/{.ids}"><img src="{.picture}" class="img-circle" title="{.mname}" data-toggle="tooltip"></a></li> 
                                {/}
                            </ul>
                        </div>
                        {/}
                        {? part2}                    
                        <div class="applicant">
                            <h4><span class="icon-plus"></span> 이벤트 참가 대기자</h4>
                            {? s.id == res.user_id}<span class="pull-right"><button class="btn btn-default btn-xs" onclick="javascript:document.location.href='/ajax/info_excel/{res.id}'"><span class="icon-download-alt"></span> Excel</button></span>{/}
                            <ul class="list-unstyled list-inline list-applicant">
                                {@ part2}
                                <li><a href="/member/{.ids}"><img src="{.picture}" class="img-circle" title="{.mname}" data-toggle="tooltip"></a></li> 
                                {/}
                            </ul>
                        </div>
                        {/}
                    </div>
        {:}
                    {? res.enroll == 1}
                    <div class="formApply" > 
                            <h3><span class="icon-edit"></span> 이벤트 참가 신청하기</h3> 
                        
                        <div id="applyE_res">
                            <div class="well complete text-center"> 
                                 <p>본 이벤트는 로그인 하신 뒤에 신청할 수 있습니다. </p>
                                <a href="/login" class="btn btn-default btn-sm">로그인하기</a>
                            </div>
                        </div>
                        {? part}
                        <div class="applicant">
                            <h4><span class="icon-ok"></span> 이벤트 참가 신청자</h4>
                            {? s.id == res.user_id}<span class="pull-right"><button class="btn btn-default btn-xs" onclick="javascript:document.location.href='/ajax/info_excel/{res.id}'"><span class="icon-download-alt"></span> Excel</button></span>{/}
                            <ul class="list-unstyled list-inline list-applicant">
                                {@ part}
                                <li><a href="/member/{.ids}"><img src="{.picture}" class="img-circle" title="{.mname}" data-toggle="tooltip" ></a></li> 
                                {/}
                            </ul>
                        </div>
                        {/}
                        {? part2}
                        <div class="applicant">
                            <h4><span class="icon-plus"></span> 이벤트 참가 대기자</h4>
                            {? s.id == res.user_id}<span class="pull-right"><button class="btn btn-default btn-xs" onclick="javascript:document.location.href='/ajax/info_excel/{res.id}'"><span class="icon-download-alt"></span> Excel</button></span>{/}
                            <ul class="list-unstyled list-inline list-applicant">
                                {@ part2}
                                <li><a href="/member/{.ids}"><img src="{.picture}" class="img-circle" title="{.mname}" data-toggle="tooltip"></a></li> 
                                {/}
                            </ul>
                        </div>
                        {/}
                    </div>
                    {/}
        {/}
        {? res.enroll == 3 && res.enroll_url}
                    <div class="formApply"> 
                            <h3><span class="icon-edit"></span> 이벤트 참가 신청하기</h3>              
                            <!-- todo : 외부 신청일때 -->
                            <div class="well text-center">
                                <p>이 이벤트는 외부에서 진행되는 이벤트입니다. 참가 신청하려면 아래의 버튼을 클릭하세요</p>
                                <a class="btn btn-primary btn-sm" target="_blank" href="{res.enroll_url}">&nbsp; &nbsp; &nbsp; &nbsp; <span class="icon-hand-right"></span>&nbsp; 참가 신청하기 &nbsp; &nbsp; &nbsp; &nbsp; </a> 
                            </div> 
                    </div>
        {/}
    {:}
    {? res.apply_start > date('Y.m.d H:i')}
                    <div class="formApply"> 
                            <h3><span class="icon-edit"></span> 이벤트 참가 신청하기</h3>              
                            <div class="well warning text-center">
                                <p>아직 신청기간이 아닙니다. 기다려주세요. ^^ </p>
                                <small>참가 신청 기간 :  {? res.apply_start}{=date_to_kr(res.apply_start)} {=date_to_time(substr(res.apply_start,11))}{/}{? res.apply_end} ~ {=date_to_kr(res.apply_end)} {=date_to_time(substr(res.apply_end,11))}{/} 까지 </small>
                                 
                       </div>
                    </div>
    {/}
    {? res.apply_end < date('Y.m.d H:i')}
                    <div class="formApply" {? already}style="display: none;"{/}> 
                        <h3><span class="icon-edit"></span> 이벤트 참가 신청하기</h3>              
                        <div class="warning"> 
                            <div class="alert alert-info text-center">
                                <span class="icon-warning-sign"></span> 신청기간이 종료되었습니다.
                            </div>
                        </div> 
                        {? part}
                        <div class="applicant">
                            <h4><span class="icon-ok"></span> 이벤트 참가 신청자</h4>
                            {? s.id == res.user_id}<span class="pull-right"><button class="btn btn-default btn-xs" onclick="javascript:document.location.href='/ajax/info_excel/{res.id}'"><span class="icon-download-alt"></span> Excel</button></span>{/}
                            <ul class="list-unstyled list-inline list-applicant">
                                {@ part}
                                <li><a href="/member/{.ids}"><img src="{.picture}" class="img-circle" title="{.mname}" data-toggle="tooltip" ></a></li> 
                                {/}
                            </ul>
                        </div>
                        {/}
                        {? part2}
                        <div class="applicant">
                            <h4><span class="icon-plus"></span> 이벤트 참가 대기자</h4>
                            {? s.id == res.user_id && !part}<span class="pull-right"><button class="btn btn-default btn-xs" onclick="javascript:document.location.href='/ajax/info_excel/{res.id}'"><span class="icon-download-alt"></span> Excel</button></span>{/}
                            <ul class="list-unstyled list-inline list-applicant">
                                {@ part2}
                                <li><a href="/member/{.ids}"><img src="{.picture}" class="img-circle" title="{.mname}" data-toggle="tooltip"></a></li> 
                                {/}
                            </ul>
                        </div>
                        {/}
                    </div>
    {/}
    {/}
{/}
                    
                    <!-- pager -->
                    
                    <!-- reply -->
                    <div id="comment">
<script type="text/javascript">
//<![CDATA[
get_timeline(3, '{res.id}', 1);
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

                    <!--
                    <ul class="pager">
                        <li><a href="#">&larr; 이전</a></li>
                        <li><a href="#">다음 &rarr;</a></li>
                    </ul>
                    //-->
                    <!-- /pager -->
                </div>
                <!-- / content -->
                

                
                <div class="sidebar col-xs-12 col-sm-12 col-md-3"> 
                    <!--
                    {@ res_s}
                    <div  class="item">
                        <div class="inner">
                            <a href="/event/apply/{.id}"> 
                            <h3>{.title}</h3>
                            <div class="metainfo">  
                                <span class="icon-calendar"></span> {.date} &nbsp;
                                <span class="icon-time"></span> {.start} &nbsp;
                                {? .date_e} ~ &nbsp;
                                <span class="icon-calendar"></span> {.date_e} &nbsp;
                                <span class="icon-time"></span> {.end}
                                {/}
                                <span class="icon-caret-right"></span>
                            </div>
                            </a>
                        </div>
                    </div>
                    {/}
                    -->
                    {? res_s}
                    <!-- panel -->
                    <div class="panel  recentpost">
                        <h3 class="panel-title">최신 Event</h3> 
                        <ul class="media-list post-list">
                            {@ res_s}
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

                    {? res_c}
                    <!-- panel -->
                    <div class="panel  recentpost">
                        <h3 class="panel-title">최신 Challenge</h3> 
                        <ul class="media-list post-list">
                            {@ res_c}
                            <li class="media"> 
                                <a class="pull-left media-object" href="/challenge/views/{.id}"> <img src="{?.img}{.img}{:}/img/default-img-news.png{/}" class="img-responsive" > </a>
                                <div class="media-body">
                                    <h4 class="media-heading"><a href="/challenge/views/{.id}">{.subject}</a></h4>
                                    <div class="media-meta">
                                        <span class="date">{?.date_s}{.date_s} {? .time_s}{.time_s}{/}{/} {?.date_e}~ {.date_e} {? .time_e}{.time_e}{/}{/}</span>&nbsp;
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

<!-- modal #md-compEditor -->
<div class="modal fade" id="md-profile" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div>
<!-- /modal #md-compEditor -->

<script type="text/javascript">
//<![CDATA[

function submit_apply(_this) {
    $(_this).hide();
    var frm = $('form[name=e_apply_form]');

    var get_url = '/ajax_front/event_apply';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            if (_data.id) {
                alert('이벤트에 참여 하였습니다.');
                window.location.reload();
            }
            else {
                alert("이미 신청한 이벤트입니다.");
            }
            {*$('#event_app').slideUp();
            $('#event_res').slideDown();*}
        }
    });
}

function show_profile() {
    $.get('/ajax_front/bp_edit_profile', function(_data) {
        $("#md-profile").html(_data);
        // $("#ui-datepicker-div").css("z-index", "9999"); 
    })
}
    

function submit_edit(){

    
    if ($('input[name=birth]').val().length < 1) {
        alert("생년월일을 입력해주세요.");
        return false;
    }
    
    if ($('input[name=gender]:radio:checked').length == 0) {
        alert("성별을 선택해주세요.");
        return false;
    }

    if ($('textarea[name=bio]').val().length < 1) {
        alert("자기소개를 입력해주세요.");
        return false;
    }

    if ($('input[name=email]').val().length < 1) {
        alert("이메일을 입력해주세요.");
        return false;
    }

    if ($('input[name=tel]').val().length < 1) {
        alert("연락처를 입력해주세요.");
        return false;
    }

    var siteset2="";
    var c_length2 = $('input[name=interr]').length;

    for(var j=0; j < c_length2; j++){
        if(document.edit_form.interr[j].checked) {
            siteset2 +=document.edit_form.interr[j].value + ","
        }
    }
    
    if (siteset2 == "") {
        alert("업무분야를 체크해주세요.");
        return false;
    }

    // var c_length3 = $('#cnt_sk').val();
    // var _sk = 0;
    // for(var k=0; k < c_length3; k++){
    //     console.log(k);
    //     if($('input[name=skill_' + k + ']').val().length > 0) {
    //         _sk = 1;
    //         break; 
    //     }
    // }

    // if (_sk == 0) {
    //     alert("업무관련기술을 하나이상 작성해주세요.");
    //     return false;
    // }

    var siteset="";
    var c_length = $('input[name=locall]').length;

    for(var i=0; i < c_length; i++){
        if(document.edit_form.locall[i].checked) {
            siteset +=document.edit_form.locall[i].value + ","
        }
    }

    if (siteset == "") {
        alert("관심지역을 체크해주세요.");
        return false;
    }

    var frm = $('form[name=edit_form]');
    var temp = '<input type="hidden" name="local" value="'+siteset.substring(0, siteset.length-1)+'" />';
    var temp2 = '<input type="hidden" name="inter_" value="'+siteset2.substring(0, siteset2.length-1)+'" />';
    frm.append(temp);
    frm.append(temp2);
    var set_data = frm.serialize();
    var get_url = '/ajax_front/bp_apply';
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            $(".modal").modal("hide");
            $("#md-profile").html("");
            // alert('이벤트에 참여 하였습니다.');
            submit_apply($('fieldset button'));
        }
    });
}

function del_apply(_id) {
    msg_confirm('del_apply_('+_id+')', '정말 신청 취소 하겠습니까?');
}

function del_apply_(_id) {
    
    var _url = '/ajax_front/del_event_apply/'+_id;
    $.get(_url, function (){
        $('.modal').modal('hide');
        alert('이벤트 신청이 취소되었습니다.');
        window.location.reload();
    });
        
}
//]]>
</script>