<!-- rowContent -->
<div class="rowContent" id="community"> 
    <input type="hidden" id="id" value="{res.id}" />
    <input type="hidden" id="page_owner" value="{res.name}" />
    
    <div class="page-header">
            <div class="container">
                <h2><a href="/network/people">People</a></h2>
            </div>
        </div>
    <!-- /page-header --> 
    
    <!-- page-content -->
    <div class="page-content" id="commu-profile"> 
        
        <!-- profile-header -->
        <div class="container profile-header">
            <div class="row"> 
                
                    <div class="col-xs-12 col-sm-12 col-md-9">
                        <div class="profile-img pull-left"><div><span><img src="{? res.picture}{res.picture}{? ! strpos(res.picture, '?')}?date={=date('his')}{/}{:}/img/default-img-member.png{/}"></span></div></div>
                        <div class="profile-info">
                            <h3 class="profile-title">{res.name}<small>({res.ids})</small></h3>
                            <p class="social">
                                   {? fb}<a target="_blank" class="btn btn-link btn-sm" href="http://facebook.com/{fb.ids}" data-toggle="tooltip" title="Facebook"><span class="icon icon-facebook" ></span></a> {/}
                                    {? tw}<a target="_blank" class="btn btn-link btn-sm"  href="http://twitter.com/{tw.ids}" data-toggle="tooltip" title="Twitter"><span class="icon icon-twitter"></span></a> {/}
                                    &nbsp;
                                    
                                    {? s}
                                    {? s.id != res.id}
                                    {? follow}
                                    <button class="btn btn-sm following" onclick="add_follow(this, '{s.id}', '{res.id}', 1, 1); return false;">Following</button>
                                    {:}
                                    <button class="btn btn-sm btn-default follow" onclick="add_follow(this, '{s.id}', '{res.id}', 1); return false;">Follow</button>
                                    {/}
                                    &nbsp;
                                    {/}
                                    {:}
                                    <button class="btn btn-sm btn-default follow" onclick="javascript:alert('로그인이 필요합니다. 로그인 후 Follow 할 수 있습니다.');">Follow</button>
                                    {/}
                                    
                                    {? s.name == res.name}
                                    <button class="btn btn-default btn-xs" onclick="javascript:location.href='/member/edit'">Edit Profile</button>
                                    {/} 
                                </p>
                               <p class="desc"> {res.bio}</p>
                        </div>
                    </div>
                    <!-- /profile-info -->
                     
                            <div class="col-xs-12 col-sm-12 col-md-3 profile-meta c_company">
                            </div>
                            <!-- /profile-meta -->
<script type="text/javascript">
//<![CDATA[

get_company();
function get_company()
{
    var get_url = '/ajax_front/get_current_company/{res.id}';
    $.get(get_url, function(_data) {
        $('.c_company').html(_data);
    });
}
//]]>
</script>

            </div>
        </div>
        <!-- /profile-header --> 
        
        <!-- profile-content -->
        <div class="container profile-content">
            <div class="row"> 
                
                <!-- content -->
                <div class="col-xs-12 col-sm-12 col-md-9 content"> 
                    {? s.id == res.id && point < 100}
                    <div id="profile-set-progress" class="alert alert-info">
                        <button aria-hidden="true" data-dismiss="alert" class="close" type="button" onclick="no_warning(this); return false;">×</button>
                        <p><strong>Um, oh</strong> 아직 프로필 정보가 부족합니다. 아래 항목을 등록하셔서 프로필 페이지 완성도를 높여보세요.</p>
                        <ul class="list-inline">
                            <li><a class="alert-link" href="/member/edit">기본 정보</a></li>
                            <li><a class="alert-link" href="#" onclick="go_profile(); return false;">프로필 정보</a></li>
                        </ul>
                        <div class="progress progress-striped">
                          <div style="width: {point}%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="20" role="progressbar" class="progress-bar progress-bar-info">
                            <span class="sr-only">{point}% Complete</span>
                          </div>
                        </div>
                    </div>
                    {/}
                    <ul class="nav nav-tabs">
                            <li {? s.id != res.id} class="active"{/}><a href="#profile-content-user" data-toggle="tab">프로필</a></li>
                            <li {? s.id == res.id} class="active"{/}><a href="#profile-content-feed" data-toggle="tab">액티비티</a></li>
                    </ul>
                    
                    <div class="tab-content"> 
                    <!-- profile-content-user -->
                    <section class="tab-pane {? s.id != res.id} active{/}" id="profile-content-user"> 
                        
                        
                        <!-- panel scholarship -->
                        <div class="panel panel-default scholarship">
                        </div>
                        <!-- /panel scholarship  --> 
<script type="text/javascript">
//<![CDATA[
function no_warning(_this)
{
    $(_this).parent().slideUp();
    cache_set('progress_mem_{res.id}', '{res.id}');
}

function go_profile()
{
    $('.nav-tabs li').removeClass("active");
    $('.nav-tabs  li:eq(0)').addClass("active");
    $('.tab-pane').removeClass("active");
    $('#profile-content-user').addClass("active");
}
get_edu();
function get_edu()
{
    var get_url = '/ajax_front/member_get_edu/{res.id}';
    $.get(get_url, function(_data) {
        $('.scholarship').html(_data);
    });
}
//]]>
</script>

{? res.utype == 1}
                        <!-- panel career -->
                        <div class="panel panel-default career">
                        </div>
                        <!-- /panel career --> 
<script type="text/javascript">
//<![CDATA[

get_career();
function get_career()
{
    var get_url = '/ajax_front/member_get_career/{res.id}';
    $.get(get_url, function(_data) {
        $('.career').html(_data);
        get_company();
    });
}
//]]>
</script>
{/}

{? res.utype == 2}
                        <!-- panel career -->
                        <div class="panel panel-default investment">
                        </div>
                        <!-- /panel career --> 
<script type="text/javascript">
//<![CDATA[

get_investment();
function get_investment()
{
    var get_url = '/ajax_front/member_get_investment/{res.id}';
    $.get(get_url, function(_data) {
        $('.investment').html(_data);
    });
}
//]]>
</script>
{/}

{? res.utype == 1}
                        <!-- panel project -->
                        <div class="panel panel-default project">
                        </div>
                        <!-- /panel project --> 
<script type="text/javascript">
//<![CDATA[
get_project();
function get_project()
{
    var get_url = '/ajax_front/member_get_pj/{res.id}';
    $.get(get_url, function(_data) {
        $('.project').html(_data);
    });
}
//]]>
</script>
{/}
                        <!-- panel reference -->
                        <div class="panel panel-default reference" id="reference_space">
                            <div class="panel-heading">
                                <h3>레퍼런스</h3>
                            </div>
                            <!-- /panel-heading -->                             
                            <div class="panel-body" id="ref_form">
                                <div class="media media-form rounded" {? !s || s.id != res.id}style="display: none;"{/}> 
                                    <a class="pull-left media-object " href="{? s}/member/{s.ids}{:}#{/}"> <img src="{? s}{s.picture}{:}../img/default-img-member.png{/}" class="img-circle" data-toggle="tooltip" title="{s.name}"> </a>
                                    <div class="media-body">
                                        <form onsubmit="return false;" name="ref_form_0">
                                            <fieldset>
                                                <input type="hidden" name="uid" value="{s.id}" />
                                                <div class="input-group"> <span class="input-group-addon"><span class="icon-envelope-alt"></span></span>
                                                    <input type="text" required="required" name="email" id="ref_email" class="form-control" placeholder="초대할 메일주소를 입력하세요">
                                                </div>
                                                <div class="form-group">
                                                    <textarea required row="3" name="contents" id="ref_contents" class="form-control" placeholder="레퍼런스에 초대할 내용을 작성해주세요">{res.name}님이 D.CAMP의 프로필/이력 페이지에  당신을 레퍼런스로 추가하고자 합니다. {res.name}님에 대한 추천사를 남겨주세요.</textarea>
                                                </div>
                                                <button class="btn btn-primary" onclick="submit_ref(0, this); return false;">메일보내기</button>
                                            </fieldset>
                                        </form>
                                    </div>
                                </div>
                                                
                                <div class="media media-form rounded" {? !ref}style="display: none;"{/}> 
                                    <a class="pull-left media-object " href="{? s}/member/{s.ids}{:}#{/}"> <img src="{? s}{s.picture}{:}../img/default-img-member.png{/}" class="img-circle" data-toggle="tooltip" title="{s.name}"> </a>
                                    <div class="media-body">
                                        <form onsubmit="return false;" name="ref_form_wr">
                                            <input type="hidden" name="req_id" value="{res.id}" />
                                            <fieldset>
                                                <div class="form-group">
                                                    <textarea id="refer" name="reference" row="3" class="form-control" placeholder="{res.name}님에 대한 추천사를 남겨주세요"></textarea>
                                                </div>
                                                {? s}
                                                <button class="btn btn-primary" onclick="submit_ref_wr(this); return false;">저장하기</button>
                                                {:}
                                                <button class="btn btn-primary" onclick="javascript:alert('로그인이 필요합니다. <br />로그인 후 레퍼런스를 작성해주세요.')">저장하기</button>
                                                {/}
                                            </fieldset>
                                        </form>
                                    </div>
                                </div>

                                <!-- todo: normal 상태 -->
                                <div id="ref_yes">
                                </div>
                            
                            </div>
                        </div>
                        <!-- panel reference --> 
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
            $('.reference #ref_yes').html(_data);
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
                    <!-- /profile-content-user --> 
                    
                    <!-- profile-content-feed -->
                    <section class="tab-pane {? s.id == res.id} active{/}" id="profile-content-feed"> 
                    
                        <div class="panel panel-default timeline">
                    <!-- /profile-content-feed --> 
<script type="text/javascript">
//<![CDATA[
get_timeline(1, '{res.id}', 1);
function get_timeline(_type, _id, _page)
{
    var get_url = '/ajax_front/get_timeline/'+_type+'/'+_id+'/'+_page;
    $.get(get_url, function(_data) {
        $('.timeline').html(_data);
    });
}
//]]>
</script> 
                        </div>

                        <div class="panel panel-default recentActivity">
                            <div class="panel-heading">
                                <h3>최근 액티비티</h3>
                            </div>
                            <!-- /panel-heading -->
                            
                            {? cur_act}
                            <div class="panel-body">
                                <ul class="media-list feed-list">
                                    {@ cur_act}
                                    {? .msg}
                                    <li class="media"> 
                                        {? .act_type == 1}
                                        <a class="pull-left media-object" href="/member/{.ow_ids}"> 
                                            <img src="{? .ow_picture}{.ow_picture}{:}/img/default-img-member.png{/}" class="img-circle"  data-toggle="tooltip" title="{.ow_name}"> 
                                        </a>
                                        <div class="media-body">
                                            <h4 class="media-heading"><a href="/member/{.ow_ids}">{.ow_name}</a></h4>
                                            <p>{.msg}</p>
                                        </div>
                                        {/}
                                        {? .act_type == 2}
                                        <a class="pull-left media-object" href="/startup/{.ow_id}"> 
                                            <img src="{?.ow_logo}{.ow_logo}{:}/img/default-img-company.png{/}" class="img-circle"  data-toggle="tooltip" title="{.ow_name}"> 
                                        </a>
                                        <div class="media-body">
                                            <h4 class="media-heading"><a href="/startup/{.ow_id}">{.ow_name}</a></h4>
                                            <p>{.msg}</p>
                                        </div>
                                        {/}
                                    </li>
                                    {:}
                                    {? .target_type == 1}{? .data.title}
                                    {?.is_made}
                                    <li class="media"> 
                                        <a class="pull-left media-object" href="/member/{.mem.ids}"> 
                                            <img src="{?.mem.picture}{.mem.picture}{:}/img/default-img-member.png{/}" class="img-circle" data-toggle="tooltip" title="{.mem.name}" >
                                        </a>
                                        <div class="media-body">
                                            <h4 class="media-heading"> 이벤트 신청 현황</h4>
                                            <span class="time"><span class="icon-time"></span>&nbsp; {.date_created}</span>
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
                                    {:}
                                    <li class="media"> 
                                        <a class="pull-left media-object" href="/member/{.mem.ids}">
                                            <img src="{?.mem.picture}{.mem.picture}{:}/img/default-img-member.png{/}" class=" img-circle"  data-toggle="tooltip" title="{.mem.name}">
                                        </a>
                                        <div class="media-body">
                                            <h4 class="media-heading"> 이벤트 참여 현황</h4>
                                            <span class="time"><span class="icon-time"></span>&nbsp; {.date_created}</span>
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
                                    {/}{/}
                                    {? .target_type == 2}{? .data.purpose}
                                    <li class="media"> 
                                        <a class="pull-left media-object" href="/member/{.mem.ids}"> 
                                            <img src="{?.mem.picture}{.mem.picture}{:}/img/default-img-member.png{/}" class="img-circle"  data-toggle="tooltip" title="{.mem.name}"  > 
                                        </a>
                                        <div class="media-body">
                                            <h4 class="media-heading"> 공간공유 신청 현황 </h4>
                                            <span class="time"><span class="icon-time"></span>&nbsp; {.date_created}</span>
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
                                    {/}{/}
                                    {? .target_type == 11}{? .data.subject}
                                    <li class="media"> 
                                        <a class="pull-left media-object" href="/member/{.mem.ids}"> <img src="{?.mem.picture}{.mem.picture}{:}/img/default-img-member.png{/}" class=" img-circle"  data-toggle="tooltip" title="{.mem.name}"  > </a>
                                        <div class="media-body">
                                            <h4 class="media-heading"> 경진대회 참여 현황 </h4>
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
                                    {/}{/}
                                    {/}
                                    {/}
                                </ul>
                                {?s.id == res.id && cur_act}<div class="pager"> <a href="/member/activity" class="btn btn-default btn-sm"> 더보기</a> </div>{/}
                            </div>
                            {/}
                        </div>
                        <!-- panel recentActivity -->

                        <div class="panel panel-default recentFollow">
                            <div class="panel-heading">
                                <h3>최근 Follow 액티비티</h3>
                            </div>
                            <!-- /panel-heading -->
                            {? flw_act}
                            <div class="panel-body">
                                <ul class="media-list feed-list">
                                    {@ flw_act}
                                    {? .msg}
                                    <li class="media"> 
                                        {? .act_type == 1}
                                        <a class="pull-left media-object" href="/member/{.ow_ids}"> 
                                            <img src="{? .ow_picture}{.ow_picture}{:}/img/default-img-member.png{/}" class="img-circle" data-toggle="tooltip" title="{.ow_name}"> 
                                        </a>
                                        <div class="media-body">
                                            <h4 class="media-heading"><a href="/member/{.ow_ids}">{.ow_name}</a></h4>
                                            <p>{.msg}</p>
                                        </div>
                                        {/}
                                        {? .act_type == 2}
                                        <a class="pull-left media-object" href="/startup/{.ow_id}"> 
                                            <img src="{?.ow_logo}{.ow_logo}{:}/img/default-img-company.png{/}" class="img-circle" data-toggle="tooltip" title="{.ow_name}"> 
                                        </a>
                                        <div class="media-body">
                                            <h4 class="media-heading"><a href="/startup/{.ow_id}">{.ow_name}</a></h4>
                                            <p>{.msg}</p>
                                        </div>
                                        {/}
                                    </li>
                                    {:}
                                    {? .target_type == 1}{? .data.title}
                                    {?.is_made}
                                    <li class="media"> 
                                        <a class="pull-left media-object" href="/member/{.mem.ids}"> 
                                            <img src="{?.mem.picture}{.mem.picture}{:}/img/default-img-member.png{/}" class="img-circle" data-toggle="tooltip" title="{.mem.name}"  >
                                        </a>
                                        <div class="media-body">
                                            <h4 class="media-heading"> 이벤트 신청 현황</h4>
                                            <span class="time"><span class="icon-time"></span>&nbsp; {.date_created}</span>
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
                                    {:}
                                    <li class="media"> 
                                        <a class="pull-left media-object" href="/member/{.mem.ids}"> 
                                            <img src="{?.mem.picture}{.mem.picture}{:}/img/default-img-member.png{/}" class="img-circle"   data-toggle="tooltip" title="{.mem.name}"  >
                                        </a>
                                        <div class="media-body">
                                            <h4 class="media-heading"> 이벤트 참여 현황</h4>
                                            <span class="time"><span class="icon-time"></span>&nbsp; {.date_created}</span>
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
                                    {/}{/}
                                    {? .target_type == 2}{? .data.purpose}
                                    <li class="media">
                                        <a class="pull-left" href="/member/{.mem.ids}">
                                            <img src="{?.mem.picture}{.mem.picture}{:}/img/default-img-member.png{/}" class="media-object img-circle"  data-toggle="tooltip" title="{.mem.name}">
                                        </a>
                                        <div class="media-body">
                                            <h4 class="media-heading"> 공간공유 신청 현황 </h4>
                                            <span class="time"><span class="icon-time"></span>&nbsp; {.date_created}</span>
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
                                    {/}{/}
                                    {? .target_type == 11}{? .data.subject}
                                    <li class="media"> 
                                        <a class="pull-left media-object" href="/member/{.mem.ids}"> <img src="{?.mem.picture}{.mem.picture}{:}/img/default-img-member.png{/}" class=" img-circle"  data-toggle="tooltip" title="{.mem.name}"  > </a>
                                        <div class="media-body">
                                            <h4 class="media-heading"> 경진대회 참여 현황 </h4>
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
                                    {/}{/}
                                    {/}
                                    {/}
                                </ul>
                                {?s.id == res.id && flw_act}<div class="pager"> <a href="/member/activity" class="btn btn-default  btn-sm"> 더보기</a> </div>{/}
                            </div>
                            {/}
                        </div>
                        <!-- panel recentFollow --> 

                    </section>
                </div>
                <!-- /tab-content --> 
                </div>
                <!-- /content --> 
                
                
                <!-- sidebar -->
                <div class="col-xs-12 col-sm-12 col-md-3 sidebar"> 
                    
                    <!-- panel -->
                    <div class="panel network"> 
                            <h3 class="panel-title">네트워크</h3> 
                            <!-- tab -->
                            <ul id="followTab" class="nav nav-tabs">
                                <li class="active"><a href="#follower-list" data-toggle="tab">Follower <span class="badge">{=sizeof(fl)}</span></a></li>
                                <li><a href="#following-list" data-toggle="tab">Following <span class="badge">{=sizeof(fi)}</span></a></li>
                            </ul>
                            <div id="followList" class="tab-content">
                                <div class="tab-pane active" id="follower-list">
                                    <ul class="list-unstyled">
                                        {@ fl}
                                        {? .type == 1}
                                        <li><a href="/member/{.ids}"><img src="{? .picture}{.picture}{:}/img/default-img-member.png{/}"  data-toggle="tooltip" title="{.name}" class="img-circle"></a></li>
                                        {/}{? .type == 2}
                                        <li><a href="/starup/{.id}"><img src="{? .logo}{.logo}{:}/img/default-img-company.png{/}"   data-toggle="tooltip" title="{.name}" class="img-circle"></a></li>
                                        {/}
                                        {/}
                                    </ul>
                                </div>
                                <div class="tab-pane" id="following-list">
                                    <ul class="list-unstyled">
                                        {@ fi}
                                        {? .type == 1}
                                        <li><a href="/member/{.ids}"><img src="{? .picture}{.picture}{:}/img/default-img-member.png{/}"  data-toggle="tooltip" title="{.name}" class="img-circle"></a></li>
                                        {/}
                                        {? .type == 2}
                                        <li><a href="/startup/{.id}"><img src="{? .logo}{.logo}{:}/img/default-img-company.png{/}"   data-toggle="tooltip" title="{.name}" class="img-circle"></a></li>
                                        {/}
                                        {/}
                                    </ul>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <!-- /tab -->  
                    </div>
                    <!-- /panel --> 
                    
                    {? res.utype == 1}
                    <!-- panel region -->
                    <div class="panel  region">
                        <h3 class="panel-title">관심지역 </h3> 
                            <ul class="list-inline">
                                {? local}{@ local}
                                <li>{._value}</li>
                                {/}{/}
                            </ul>
                         
                    </div>
                    <!-- /panel region --> 

                    <!-- panel interest -->
                    <div class="panel interest">
                        <h3 class="panel-title">업무분야 </h3>
                            <ul class="list-inline ">
                                {? inter}{@ inter}
                                <li>{._value}</li>
                                {/}{/}
                            </ul> 
                    </div>
                    <!-- /panel interest --> 
                    
                    <!-- panel skill -->
                    <div class="panel skill">
                        <h3 class="panel-title">업무역량</h3>
                            <ul class="list-inline">
                                {? skill}{@ skill}
                                <li>{._value}</li>
                                {/}{/}
                            </ul>
                        
                    </div>
                    <!-- /panel skill --> 
                    {/}
                    
                    {? res.utype == 2}
                    <!-- panel region -->
                    <div class="panel  region">
                        <h3 class="panel-title">관심시장</h3>
                            <ul class="list-inline">
                                {? market}{@ market}
                                <li>{._value}</li>
                                {/}{/}
                            </ul> 
                    </div>
                    <!-- /panel region --> 

                    <!-- panel interest -->
                    <div class="panel  interest">
                        <h3 class="panel-title">투자분야 </h3> 
                            <ul class="list-inline ">
                                {? invest}{@ invest}
                                <li>{._value}</li>
                                {/}{/}
                            </ul> 
                    </div>
                    <!-- /panel interest --> 
                    
                    <!-- panel skill -->
                    <div class="panel  skill"> 
                         <h3 class="panel-title">투자역량 </h3>
                            <ul class="list-inline">
                                {? skill}{@ skill}
                                <li>{._value}</li>
                                {/}{/}
                            </ul> 
                    </div>
                    <!-- /panel skill --> 
                    {/}
                    
                    {? event && s.id == res.id}
                    <!-- panel event -->
                    <div class="panel panel-default event">
                        <h3 class="panel-title">내가 만든 이벤트</h3>
                        {? event} 
                            <ul class="list-unstyled">
                                {@ event}{? .date > date('Y.m.d')}
                                <li><a href="/event/apply/{.id}"> {.title} </a>
                                    <button class="btn btn-default btn-xs" onclick="javascript:location.href='/event/add/{.id}'">Edit</button>
                                    {? .state == 0}<span class="label label-info">승인대기</span></p>{/}
                                    {? .state == 1}<span class="label label-success">승인</span></p>{/}
                                    {? .state == 2}<span class="label label-warning">반려</span></p>{/}
                                    
                                    <p>
                                        행사위치 : {? .space_id}{.sname} {.opt}F{:}{.space_etc}{/} <br>
                                        행사일시 : {.date} {.start} ~ {.date_e} {.end} 
                                    </p>
                                </li>
                                {/}{/}
                            </ul> 
                        {/}
                    </div>
                    <!-- /panel event --> 
                    {/}

                </div>
                <!-- /sidebar --> 
                
            </div>
        </div>
        <!-- /profile-content --> 
        
    </div>
    <!-- /page-content --> 
    
</div>
<!-- /rowContent --> 

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
    var form =  $(_this).parent().parent().parent().parent().parent().parent().attr('id');
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
//]]>
</script> 