    <!-- rowContent -->
    <div id="officehours" class="rowContent"> 
        <!-- page-header -->
        <div class="page-header">
            <div class="container">
                <h2><a href="/office_hours">Office Hours</a></h2>
            </div>
        </div>
        <!-- /page-header -->

        <!-- page-content -->
        <div class="page-content"> 
            <div class="container">
                <div class="row">
                <!-- Start Contents -->
                
                    <!-- content -->
                    <div class="content col-xs-12 col-sm-12 col-md-8">

                        <!-- article -->
                        <div class="article">
                            <div class="article-header">
                                <h3>{res.subject}</h3>
                                <div class="meta">
                                    <span class="pull-right">
                                        <a href="https://www.google.com/calendar/render?action=TEMPLATE&text={=str_replace('&', '%26', str_replace('#', '%23', res.subject))}&dates={=substr_replace(g_start, 'T', 8, 0)}Z/{=substr_replace(g_end, 'T', 8, 0)}Z&sprop=name:DCAMP&location={res.place}&details=주최·주관 : {=str_replace('&', '%26', res.hosted)}%0A접수 기간 : {=substr(res.a_start, 0, 10)} ({=date_to_day_only(res.a_start)}) {=substr(res.a_start, 11)} ~ {=substr(res.a_end, 0, 10)} ({=date_to_day_only(res.a_end)}) {=substr(res.a_end, 11)} %0A발표일자 : {=substr(res.r_date, 0, 10)} ({=date_to_day_only(res.r_date)}) {=substr(res.r_date, 11)}%0AURL : http://dcamp.kr/competition/views/{res.id}%0A&pli=1&sf=true&output=xml#h|month" class="btn btn-default btn-xs" target="_blank">
                                            <i class="fa fa-calendar"></i> 구글캘린더에 등록하기
                                        </a>
                                    </span>
                                </div>
                            </div>


                            <div class="article-body">
                                <!-- status-info -->
                                <div class="item-status">
                                    <dl class="dl-horizontal">
                                        <dt>주최&middot;주관</dt>
                                        <dd>{res.hosted}</dd>
                                        <dt>참가 장소</dt>
                                        <dd>{res.place}</dd>
                                        <dt>참가 일자 </dt>
                                        <dd>{=substr(res.e_start, 0, 10)} ({=date_to_day_only(res.e_start)}) {=substr(res.e_start, 11)} ~ {=substr(res.e_end, 0, 10)} ({=date_to_day_only(res.e_end)}) {=substr(res.e_end, 11)} </dd>
                                        <dt>접수 기간</dt>
                                        <dd>{=substr(res.a_start, 0, 10)} ({=date_to_day_only(res.a_start)}) {=substr(res.a_start, 11)} ~ {=substr(res.a_end, 0, 10)} ({=date_to_day_only(res.a_end)}) {=substr(res.a_end, 11)} {? res.a_start > date('Y.m.d H:i')}<span class="badge">D-{=dateDiff(res.a_start, date('Y.m.d'), '.')}</span>{/}</dd>
                                        <dt>발표 일자</dt>
                                        <dd>{=substr(res.r_date, 0, 10)} ({=date_to_day_only(res.r_date)}) {=substr(res.r_date, 11)} / 메일을 통해 개별 안내 {? res.r_date > date('Y.m.d H:i')}<span class="badge">D-{=dateDiff(res.r_date, date('Y.m.d'), '.')}</span>{/}</dd>
                                    </dl>
                                    {? res.a_start > date('Y.m.d H:i')}
                                    <div class="alert alert-warning">
                                        현재 접수 중이 아닙니다. <button class="btn btn-default btn-xs">접수 기간 알림받기</button>
                                    </div>
                                    {/}
                                </div>
                                <!-- /status-info -->

                                <!-- mentor-info -->
                                <div class="mentor-info">
                                    <div class="row">
                                        <div class="left col-xs-12 col-sm-2 col-md-3">
                                            <div class="vimg">
                                                <span style="background-image:url({mento.picture});">
                                                    <img src="/images/img_trans.png"  class="img-responsive">
                                                </span>
                                                <img src="{mento.picture}" class="sr-only">
                                            </div>
                                        </div>
                                        <div class="right col-xs-12 col-sm-10 col-md-9">
                                            <h4>
                                                <strong>{mento.name}</strong>
                                                <small>{mento.derpartment}{? mento.position}({mento.position}){/}</small>
                                            </h4>
                                            <dl>
                                                <dt>소개</dt>
                                                <dd>
                                                    {=add_brs(mento.description)}
                                                </dd>
                                            </dl>
                                            {? bios}
                                            <dl>
                                                <dt>약력</dt>
                                                <dd>
                                                    <ul>
                                                        {@ bios}
                                                        <li>{.bios}</li>
                                                        {/}
                                                    </ul>
                                                </dd>
                                            </dl>
                                            {/}
                                            {? article}
                                            <dl>
                                                <dt>관련기사</dt>
                                                <dd>
                                                    <ul>
                                                        {@ article}
                                                        <li><a href="{=check_http(.url)}" target="_blank">{.title}</a></li>
                                                        {/}
                                                    </ul>
                                                </dd>
                                            </dl>
                                            {/}
                                        </div>
                                    </div>
                                </div>
                                <!-- /mentor-info -->

                                <article>
                                {res.description}
                                </article> 
                            </div>
                        </div>
                        <!-- /article -->

                        <!-- formApply -->
                        <div class="formApply">
                            <header>
                                <h3><i class="fa fa-pencil-square-o"></i> 참가 신청하기</h3>
                            </header>
                            {? done}
                            <div  id="applyE_res" >
                                <div class="well complete"> 
                                    <h4 class="text-center"><span class="icon icon-smile icon-large"></span>&nbsp;  신청완료!!</h4>
                                    <p class="text-center">Office Hours 참가 신청이 완료되었습니다. <a href="/member/edit_office">[Office Hours 내역]</a>에서 확인 가능합니다.</p>
                                    <div class="text-center"><a href="/member/edit_office" class="btn btn-default btn-sm">확인</a></div>
                                </div>
                            </div>
                            {:}
                            {? res.a_start > date('Y.m.d H:i')}
                            <div class="alert alert-warning">
                                현재 접수 중이 아닙니다. <button class="btn btn-default btn-xs">접수 기간 알림받기</button>
                            </div>
                            {/}
                            {? res.a_start <= date('Y.m.d H:i') && res.a_end > date('Y.m.d H:i') }
                            <div class="well">
                                {? s.id}
                                <button class="btn btn-primary btn-sm" onclick="window.location.href='/office_hours/apply/{res.id}'"><i class="fa fa-hand-o-right"></i> 참가 신청하기</button>
                                {:}
                                <p>D.CAMP 회원이시면 누구나 신청 가능 합니다. 로그인 해주세요. ^^ <button class="btn btn-default btn-sm" onclick="javascript:location.href='/login'">로그인하기 </button></p>
                                {/}
                            </div>
                            {/}
                            {/}
                        </div>
                        <!-- /formApply -->

                        <!-- #comment -->
                        <div id="comment">
                        </div>
                        <!-- /#comment -->
<script type="text/javascript">
//<![CDATA[
get_timeline(8, '{res.mento_id}', 1);
function get_timeline(_type, _id, _page)
{
    var get_url = '/ajax_front/get_timeline_2015/'+_type+'/'+_id+'/'+_page;
    $.get(get_url, function(_data) {
        $('#comment').html(_data);
    });
}
//]]>
</script> 
                        

                    </div>
                    <!-- /content -->
                    {? other}
                    <!-- sidebar -->
                    <div class="sidebar col-xs-12 col-sm-12 col-md-4">
                        {? other}
                        <section class="list-mentors">
                            <header>
                                <h3>접수 중인 Mentors</h3>
                            </header>
                            <ul class="list-unstyled">
                                {@ other}
                                <li> 
                                    <a href="/office_hours/views/{.hid}">
                                        <div class="vimg">
                                            <span style="background-image:url({.picture});">
                                                <img src="/images/img_trans.png"  class="img-responsive">
                                            </span>
                                            <img src="{.picture}" class="sr-only">
                                        </div>
                                        <h4>
                                            <strong class="ellipsis">{.name}</strong>
                                            <small class="ellipsis">{.department}{? .position}({.position}){/}</small>
                                        </h4>
                                    </a>
                                </li>
                                {/}
                            </ul>
                        </section>
                        {/}

                        <div class="panel">
                            <div class="fb-page" data-href="https://www.facebook.com/dcamp.kr" data-width="263" data-small-header="false" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="true" data-show-posts="false"><div class="fb-xfbml-parse-ignore"><blockquote cite="https://www.facebook.com/dcamp.kr"><a href="https://www.facebook.com/dcamp.kr">D.CAMP</a></blockquote></div></div>
                        </div>
                    </div>
                    <!-- /sidebar -->
                    {/}
                <!-- /End Contents -->
                </div>
            </div>
        </div>
        <!-- /page-content -->
    </div>
    <!-- /rowContent -->