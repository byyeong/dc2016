
<!-- rowContent -->
<div class="rowContent" id="community"> 
    <input type="hidden" id="id" value="{res.id}" />
    <div class="page-header">
            <div class="container">
                <h2><a href="/network/startup">Startup</a></h2>
            </div>
        </div>
    <!-- /page-header --> 
    
    <!-- page-content -->
    <div class="page-content" id="commu-profile"> 
        
        <!-- profile-header -->
        <div class="container profile-header">
            <div class="row"> 
            
                    <div class="col-xs-12 col-sm-12 col-md-9 ">
                        <div class="pull-left profile-img"><div><span><img src="{? res.logo}{res.logo}{:}/img/default-img-company.png{/}"></span></div></div>
                        <div class="profile-info">
                            <h3 class="profile-title">{res.name}</h3>
                            <p class="social" >
                                    {? res.website}<a href="{res.website}" target="_blank" class="btn btn-link btn-sm" data-toggle="tooltip" title="Homepage"><span class="icon icon-home" ></span></a> {/}
                                    {? res.facebook}<a href="{=check_url(res.facebook, 'facebook.com/')}" target="_blank" class="btn btn-link btn-sm" data-toggle="tooltip" title="Facebook"><span class="icon icon-facebook" ></span></a> {/}
                                    {? res.twitter}<a href="{=check_url(res.twitter, 'twitter.com/')}" target="_blank" class="btn btn-link btn-sm" data-toggle="tooltip" title="Twitter"><span class="icon icon-twitter"></span></a>{/} 
                                    &nbsp;
                                    
                                    {? s}
                                    {? follow}
                                    <button class="btn btn-sm following" onclick="add_follow(this, '{s.id}', '{res.id}', 2, 1); return false;">Following</button>
                                    {:}
                                    <button class="btn btn-sm btn-default follow" onclick="add_follow(this, '{s.id}', '{res.id}', 2); return false;">Follow</button>
                                    {/}
                                    &nbsp;
                                    {:}
                                    <button class="btn btn-sm btn-default follow" onclick="javascript:alert('로그인이 필요합니다. 로그인 후 Follow 할 수 있습니다.');">Follow</button>
                                    {/}
                                    
                                    {? s && edi.user_id == s.id}<button class="btn btn-default btn-sm" onclick="javascript:location.href='/startup/edit/{res.id}'">Edit Profile</button>{/}
                                </p>
                            
                                <p class="desc">{res.bio}</p>
                        </div>
                </div> 
                    
                <div class="col-xs-12 col-sm-12 col-md-3 profile-meta"> 
                    <dl class="dl-horizontal">
                        <dt>사무실</dt>
                        <dd>{res.addr}</dd>
                        <dt>이메일</dt>
                        <dd><a href="mailto:{res.email}">{res.email}</a></dd>
                        <dt>전화번호</dt>
                        <dd>{res.tel}</dd>
                        <dt>설립일</dt>
                        <dd>{res.founded}</dd>
                        <dt>임직원</dt>
                        <dd>{res.number}명</dd>
                    </dl>
                </div>
                <!-- /profile-meta -->
            </div>
        </div>
        <!-- /profile-header --> 
        
        <!-- profile-content -->
        <div class="container profile-content">
            <!-- row -->
            <div class="row"> 
                
                <!-- content -->
                <div class="col-xs-12 col-sm-12 col-md-9 content "> 
                    {? s && edi.user_id == s.id && point < 100}
                    <div id="profile-set-progress" class="alert alert-info">
                        <button aria-hidden="true" data-dismiss="alert" class="close" type="button" onclick="no_warning(this); return false;">×</button>
                        <p><strong>Um, oh</strong> 아직 스타트업 정보가 부족합니다. 아래 항목을 등록하셔서 스타트업 페이지 완성도를 높여보세요.</p>
                        <ul class="list-inline">
                            <li><a class="alert-link" href="/startup/edit/{res.id}">기업기본 정보</a></li>
                            <li><a class="alert-link" href="#introduce">스타트업 소개</a></li>
                            <li><a class="alert-link" href="#goods">제품/서비스 정보</a></li>
                        </ul>
                        <div class="progress progress-striped">
                          <div style="width: {point}%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="20" role="progressbar" class="progress-bar progress-bar-info">
                            <span class="sr-only">{point}% Complete</span>
                          </div>
                        </div>
                    </div>
                    {/}
                    <ul class="nav nav-tabs">
                            <li class="active"><a href=".profile-content-company" data-toggle="tab">프로필</a></li>
                            <li><a href=".profile-content-feed" data-toggle="tab">액티비티</a></li>
                    </ul>
                    
                    <div class="tab-content"> 
                    <!-- profile-content-company -->
                    <section class="profile-content-company tab-pane active"> 
                        
                        <!-- panel introduce -->
                        <div class="panel panel-default introduce" id="introduce">
                            <div class="panel-heading">
                                <h3>{? res.stype == 1}스타트업{/}{? res.stype == 2}창업유관기관{/} 소개</h3>
                                {? s && edi.user_id == s.id}<button class="btn btn-default btn-xs" onclick="edit_des(); return false;">Edit </button>{/}
                                {? res.is_rocket}<small style="color:#999; font-size:11px;" class="pull-right"> Sourced by <a style="color:#777;" target="_blank" href="http://rocketpun.ch/">Rocketpun.ch</a> </small>{/}
                            </div>
                            
                            
                            <!-- TODO : none 상태 -->
                            <div class="panel-body" id="desc" {? !res.description}style="display: none;"{/}>
                                <p>{=str_replace("\n","<br />", str_replace("&lt;","<", str_replace("&gt;",">", res.description)))}</p>
                                
                                <!-- carousel-introduce -->
                                <div id="carousel-introduce" class="carousel slide" data-ride="carousel">
                                </div> 
                                <!-- /carousel-introduce -->
<script type="text/javascript">
//<![CDATA[

function no_warning(_this)
{
    $(_this).parent().slideUp();
    cache_set('progress_{res.id}_{s.id}', '{s.id}');
}

function cache_set(_type, _user) {
    var get_url = '/ajax_front/use_cache/';
    var set_data ={
        "type"      : _type,
        "id"        : _user,
    };

    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function() {}
    });
}

get_slide('{res.id}');
function get_slide(_id)
{
    var get_url = '/ajax_front/get_slide/'+_id;
    $.get(get_url, function(_data) {
        if (_data) {
            $('#carousel-introduce').html(_data);
            $('#carousel-introduce').slideDown();
        } else {
            $('#carousel-introduce').slideUp();
        }
    });
}
//]]>
</script>
                            </div> 
                            <!-- /panel-body -->

                            <div class="panel-body" id="desc_no" {? res.description}style="display: none;"{/}>
                                <!-- alert -->                              
                                <div class="alert alert-info">
                                    <p class="text-info">입력된 내용이 없습니다</p>
                                </div>
                                <!-- /alert -->
                            </div> 

                            
                            <!-- TODO : edit 상태 -->
                            <div class="panel-body" id="edit_des" style="display: none;">
                                <form class="form-edit-set" id="edit_des_form" name="edit_des_form" onsubmit="return false;">
                                    <fieldset>
                                        <div class="form-group">
                                            <label>회사소개</label>
                                            <textarea row="5" class="form-control" placeholder="{? res.stype == 1}스타트업{/}{? res.stype == 2}엔젤클럽/투자회사/창업지원유관기관{/} 소개글을 입력해주세요." name="description">{res.description}</textarea>
                                        </div>
                                        <div class="form-group">
                                            <label>회사소개 슬라이드</label>
                                            <span class="help-block">슬라이드쉐어(http://slideshare.net)등에서 embed 코드를 입력해 주세요. 4개까지 입력 가능합니다.</span>
                                            
                                            <div class="input-group">
                                                <input type="text" placeholder="슬라이드 Embed 코드를 입력해주세요." class="form-control" name="slide_1" value="{=htmlspecialchars(res.slide_1)}">
                                                <span class="input-group-btn"><button title="삭제" data-toggle="tooltip" aria-hidden="true" class="btn btn-default" onclick="del_prev(this); return false;">×</button></span> 
                                            </div>
                                            <div class="input-group">
                                                <input type="text" placeholder="슬라이드 Embed 코드를 입력해주세요." class="form-control" name="slide_2" value="{=htmlspecialchars(res.slide_2)}">
                                                <span class="input-group-btn"><button title="삭제" data-toggle="tooltip" aria-hidden="true" class="btn btn-default" onclick="del_prev(this); return false;">×</button></span> 
                                            </div>      
                                            <div class="input-group">
                                                <input type="text" placeholder="슬라이드 Embed 코드를 입력해주세요." class="form-control" name="slide_3" value="{=htmlspecialchars(res.slide_3)}">
                                                <span class="input-group-btn"><button title="삭제" data-toggle="tooltip" aria-hidden="true" class="btn btn-default" onclick="del_prev(this); return false;">×</button></span> 
                                            </div>      
                                            <div class="input-group">
                                                <input type="text" placeholder="슬라이드 Embed 코드를 입력해주세요." class="form-control" name="slide_4" value="{=htmlspecialchars(res.slide_4)}">
                                                <span class="input-group-btn"><button title="삭제" data-toggle="tooltip" aria-hidden="true" class="btn btn-default" onclick="del_prev(this); return false;">×</button></span> 
                                            </div>                                                
                                        </div>
                                        <div class="form-actions"> 
                                            <button class="btn btn-default btn-xs" onclick="edit_des(); return false;">Cancel</button>
                                            <button class="btn btn-primary btn-xs" type="submit" onclick="submit_des(); return false;">Save</button>
                                             
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                            <!-- /panel-body -->      
                        </div>
                        <!-- /panel introduce -->

                        <!-- panel goods -->
                        <div class="panel panel-default goods" id="goods">
                        </div>
                        <!-- /panel goods  --> 
<script type="text/javascript">
//<![CDATA[
function del_prev(_this)
{
    $(_this).parent().prev().attr("value", "");
}

get_service();
function get_service()
{
    var get_url = '/ajax_front/startup_get_service/{res.id}';
    $.get(get_url, function(_data) {
        $('.goods').html(_data);
    });
}
//]]>
</script>

{? res.stype == 1}
                        <!-- panel investment -->
                        <div class="panel panel-default investment">
                        </div>
                        <!-- /panel investment --> 
<script type="text/javascript">
//<![CDATA[
get_investment();
function get_investment()
{
    var get_url = '/ajax_front/startup_get_inv/{res.id}';
    $.get(get_url, function(_data) {
        $('.investment').html(_data);
    });
}
//]]>
</script>
                        <!-- panel incubating -->
                        <div class="panel panel-default incubating">
                        </div>
                        <!-- /panel incubating --> 
<script type="text/javascript">
//<![CDATA[
get_incubating();
function get_incubating()
{
    var get_url = '/ajax_front/startup_get_inc/{res.id}';
    $.get(get_url, function(_data) {
        $('.incubating').html(_data);
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
                                <div class="media media-form rounded" {? !s || edi.user_id != s.id}style="display: none;"{/}> 
                                    <a class="pull-left" href="{? s}/member/{s.ids}{:}#{/}"> <img src="{? s}{s.picture}{:}../img/default-img-member.png{/}" class="media-object img-circle" data-toggle="tooltip" title="{s.name}"> </a>
                                    <div class="media-body">
                                        <form onsubmit="return false;" name="ref_form_0">
                                            <fieldset>
                                                <input type="hidden" name="user_id" value="{s.id}" />
                                                <input type="hidden" name="startup_id" value="{res.id}" />
                                                <div class="input-group"> <span class="input-group-addon"><span class="icon-envelope-alt"></span></span>
                                                    <input type="text" name="email" id="ref_email" class="form-control" placeholder="초대할 메일주소를 입력하세요">
                                                </div>
                                                <div class="form-group">
                                                    <textarea required row="3" name="contents" id="ref_contents" class="form-control" placeholder="레퍼런스에 초대할 내용을 작성해주세요">{res.name}님이 D.CAMP의 프로필/이력 페이지에  당신을 레퍼런스로 추가하고자 합니다. {res.name}에 대한 추천사를 남겨주세요.</textarea>
                                                </div>
                                                <button class="btn btn-primary" onclick="submit_ref(0, this); return false;">메일보내기</button>
                                            </fieldset>
                                        </form>
                                    </div>
                                </div>
                                                
                                <div class="media media-form rounded" {? !ref}style="display: none;"{/}> 
                                    <a class="pull-left media-object" href="{? s}/member/{s.ids}{:}#{/}"> <img src="{? s}{s.picture}{:}../img/default-img-member.png{/}" class="img-circle" data-toggle="tooltip" title="{s.name}"> </a>
                                    <div class="media-body">
                                        <form onsubmit="return false;" name="ref_form_wr">
                                            <input type="hidden" name="req_id" value="{res.id}" />
                                            <fieldset>
                                                <div class="form-group">
                                                    <textarea id="refer" name="reference" row="3" class="form-control" placeholder="{res.name}님에 대한 추천사를 남겨주세요"></textarea>
                                                </div>
                                                {? s}
                                                <button class="btn btn-primary" onclick="submit_ref_wr(); return false;">저장하기</button>
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
    var get_url = '/ajax_front/startup_get_ref/{res.id}';
    $.get(get_url, function(_data) {
        if (_data === '') {
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

    var get_url = '/ajax_front/startup_edit_ref';
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

function submit_ref_wr(){
    if ($('#refer').val() === '') {
        alert('추천사를 입력해주세요.');
        return false;
    }
    
    var frm = $('form[name=ref_form_wr]');

    var get_url = '/ajax_front/startup_write_ref';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            $('#refer').val('');
            get_reference();
        }
    });
}

//]]>
</script> 

                    </section>
                    <!-- /profile-content-company --> 
                    
                    <!-- profile-content-feed -->
                    <section class="profile-content-feed tab-pane">  
                        <!-- panel timeline -->
                        <div class="panel panel-default timeline">
                    
                    <!-- /profile-content-feed --> 
<script type="text/javascript">
//<![CDATA[
get_timeline(2, '{res.id}', 1);
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
                            <div class="panel-body  feed-list">
                                <ul class="media-list">
                                    {@ cur_act}
                                    {? .msg}
                                    <li class="media"> 
                                        {? .act_type == 1}
                                        <a class="pull-left" href="/member/{.ow_ids}"> <img src="{? .ow_picture}{.ow_picture}{:}/img/default-img-member.png{/}" class="media-object img-circle"  data-toggle="tooltip" title="{.ow_name}"> </a>
                                        <div class="media-body">
                                            <h4 class="media-heading"><a href="/member/{.ow_ids}">{.ow_name}</a></h4>
                                            <p>{.msg}</p>
                                        </div>
                                        {/}
                                        {? .act_type == 2}
                                        <a class="pull-left" href="/startup/{.ow_id}"> <img src="{?.ow_logo}{.ow_logo}{:}/img/default-img-company.png{/}" class="media-object img-circle" data-toggle="tooltip" title="{.ow_name}"> </a>
                                        <div class="media-body">
                                            <h4 class="media-heading"><a href="/startup/{.ow_id}">{.ow_name}</a></h4>
                                            <p>{.msg}</p>
                                        </div>
                                        {/}
                                    </li>
                                    {:}
                                    {? .target_type == 1}{? .data.title}
                                    {?.is_made}
                                    <li class="media"> <a class="pull-left" href="/member/{.mem.ids}"> <img src="{?.mem.picture}{.mem.picture}{:}/img/default-img-member.png{/}" class="media-object img-circle" data-toggle="tooltip" title="{.mem.name}"  > </a>
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
                                    <li class="media"> <a class="pull-left" href="/member/{.mem.ids}"> <img src="{?.mem.picture}{.mem.picture}{:}/img/default-img-member.png{/}" class="media-object img-circle"  data-toggle="tooltip" title="{.mem.name}"  > </a>
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
                                    <li class="media"> <a class="pull-left" href="/member/{.mem.ids}"> <img src="{?.mem.picture}{.mem.picture}{:}/img/default-img-member.png{/}" class="media-object img-circle" data-toggle="tooltip" title="{.mem.name}"  > </a>
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
                                    {/}
                                    {/}
                                </ul>
                                {?s.id == res.id && cur_act}<div class="pager"> <a href="/member/activity" class="btn btn-default btn-sm"> 더보기</a> </div>{/}
                            </div>
                            {/}
                        </div>
                        <!-- panel recentActivity -->

                </section>
                        
                </div>
                <!-- /content --> 
            </div>
            <!-- /row --> 
                
                
                <!-- sidebar -->
                <div class="col-xs-12 col-sm-12 col-md-3 sidebar"> 
                    
                    <!-- panel network -->
                    <div class="panel network"> 
                            <h3 class="panel-title">네트워크</h3> 
                          
                            <!-- tab -->
                            <ul id="followTab" class="nav nav-tabs">
                                <li class="active"><a href="#follower-list" data-toggle="tab">Follower <span class="badge">{=sizeof(fl)}</span></a></li>
                            </ul>
                            <div id="followList" class="tab-content">
                                <div class="tab-pane active" id="follower-list">
                                    <ul class="list-unstyled">
                                        {@ fl}
                                        <li><a href="/member/{.ids}"><img src="{? .picture}{.picture}{:}/img/default-img-member.png{/}" data-toggle="tooltip" title="{.name}" class="img-circle"></a></li>
                                        {/}
                                    </ul>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <!-- /tab --> 
                        
                    </div>
                    <!-- /panel network --> 
                    
                    <!-- panel field -->
                    {? bis}
                    <div class="panel field">
                        <h3 class="panel-title">{? res.stype == 1}사업분야{/}{? res.stype == 2}투자분야{/}</h3> 
                            <ul class="list-inline">
                                {@ bis}
                                <li>{._value}</li>
                                {/}
                            </ul> 
                    </div>
                    {/}
                    <!-- /panel field --> 
                    
                    <!-- panel technology -->
                    {? tech}
                    <div class="panel  technology">
                        <h3 class="panel-title">{? res.stype == 1}핵심기술{/}{? res.stype == 2}투자전략{/} </h3>
                         
                            <ul class="list-inline">
                                {@ tech}
                                <li>{._value}</li>
                                {/}
                            </ul>
                         
                    </div>
                    {/}
                    <!-- /panel technology --> 
                    
                    <!-- panel staff -->
                    <div class="panel staff">
                        <h3 class="panel-title">구성원</h3>
                            <!--<button class="btn btn-default btn-xs">Edit </button>-->
                            {? s && !mem && users}<button id="md-applyStaffB" href="#md-applyStaff" data-toggle="modal" class="btn btn-default btn-xs">구성원 신청 </button>{/}
                            {? s && !users}<button id="md-applyStaffB" href="#md-applyStaff" data-toggle="modal" class="btn btn-default btn-xs">구성원 등록 </button>{/}
                            {? s && edi.user_id == s.id}<button id="md-applyStaffB" href="#md-addStaff" data-toggle="modal" class="btn btn-default btn-xs">구성원 초대 </button>{/}
                        
                            <ul class="list-unstyled " id="mem_list">
                                {@ users}
                                {? .status == 0}
                                {? s && edi.user_id == s.id}
                                <li class="user alert alert-warning">
                                    <button type="button" class="close" aria-hidden="true" data-toggle="tooltip" title="삭제" onclick="edit_state_user(this, 3, '{.smid}', '{.mid}'); return false;">&times;</button>
                                    <a href="/member/{.ids}" class="alert-link"> <img class="img-circle" src="{? .picture}{.picture}{:}/img/default-img-member.png{/}" style="width:24px;"> {.name}</a>
                                    <button class="btn btn-warning btn-xs" onclick="edit_state_user(this, 1, '{.smid}', '{.mid}'); return false;">승인하기</button>
                                </li>
                                {:}
                                {? mem}
                                <li class="user alert alert-warning">
                                    <a href="/member/{.ids}" class="alert-link"> <img class="img-circle" src="{? .picture}{.picture}{:}/img/default-img-member.png{/}" style="width:24px;"> {.name}</a>{?.role} <small>{.role}</small>{/} (승인대기)
                                </li>
                                {/}{/}
                                {:}
                                <li> 
                                    <a href="/member/{.ids}"> <img class="img-circle" src="{? .picture}{.picture}{:}/img/default-img-member.png{/}" style="width:24px;"> {.name}</a> <small>{.role}</small> 
                                </li>
                                {/}
                                {/}
                                {? users_req}{@ users_req}
                                <li> 
                                    <img class="img-circle" src="/img/default-img-member.png" style="width:24px;"> {.name}
                                </li>
                                {/}
                                {/}
                            </ul>
                        
                    </div>
                    <!-- /panel staff --> 
                    
                    <!-- panel relation 
                    <div class="panel  relation"> 
                            <h3 class="panel-title">투자가/조언자</div>
                            <button class="btn btn-default btn-xs">Edit </button>
                         
                            <ul class="list-unstyled ">
                                <li> <a href="#"> <img class="img-circle" src="https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash4/211493_504444819_1718563_q.jpg"  > 유노윤호 </a> <small>Amazon</small> </li>
                                <li> <a href="#"> <img class="img-circle" src="https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash4/211493_504444819_1718563_q.jpg"  > 봉순이 </a> </li>
                            </ul>
                         
                    </div>
                    /panel relation -->
{? res.stype == 1}
                    <!-- panel recruit -->
                    <div class="panel recruit">
                        <h3 class="panel-title">구인공고</h3>
                            {? s && edi.user_id == s.id}<button class="btn btn-default btn-xs" onclick="javascript:location.href='/recruit/add/'">Add </button>{/}
                          
                            <ul class="list-unstyled">
                                {@ jobs}{? .end > date('Y.m.d')}
                                <li> <a href="/recruit/views/{.rid}"> {.title} </a>
                                    <p> 모집기간 : {.start}~{.end} <br>
                                        {? .job}모집분야 : {@ .job}{? ..key_ == 0}{.._value}{:}, {.._value}{/}{/} </p>{/}
                                </li>
                                {:}
                                {? mem}
                                <li> <a href="/recruit/views/{.rid}"> {.title} </a> <span class="label label-default">완료</span>
                                    <p> 모집기간 : {.start}~{.end} <br>
                                        {? .job}모집분야 : {@ .job}{? ..key_ == 0}{.._value}{:}, {.._value}{/}{/} </p>{/}
                                </li>
                                {/}
                                {/}
                                {/}
                            </ul> 
                    </div>
                    <!-- /panel --> 
{/}
                </div>
                <!-- /sidebar --> 
                
            
        </div>
        <!-- /profile-content --> 
        
    </div>
    <!-- /page-content --> 
    
</div>
<!-- /rowContent --> 

<!-- modal #searchStartup -->
<div class="modal fade" id="md-applyStaff" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3 class="modal-title"><span class="icon-user"></span> <span class="break"></span> 구성원 {?!users}등록{:}신청{/}</h3>
            </div>
            <!-- /modal-header -->
            <div class="modal-body">
                <div class="text-center">
                <h4 class="text-primary">'{res.name}'의 구성원인가요? </h4>
                {?!users}해당회사 정보의 편집권한을 가지게 됩니다.
                {:}해당회사의 관리자가 정보를 확인후 승인하면 구성원으로 등록됩니다. {/}
                </div>
            </div>
                
            <div class="modal-body"> 
                <h4 class="text-primary">'{res.name}'의 구성원인가요?</h4>
                <div class="well well-sm form-horizontal">
                    <form name="md-applyS" method="post" >
                        <input type="hidden" name="user_id" value="{s.id}" />
                        <input type="hidden" name="startup_id" value="{res.id}" />
                        <input type="hidden" name="is_ing" value="1" />
                        {?!users}<input type="hidden" name="status" value="1" />{/}
                        <div class="form-group">
                            <div class="col-sm-3 col-md-3 control-label">회사명</div>
                            <div class="col-sm-9 col-md-9">
                                <input type="text" class="form-control" value="{res.name}" placeholder="회사명" readonly > 
                            </div>
                        </div>
                        <!--/form-group -->
                        <div class="form-group">
                            <div class="col-sm-3 col-md-3 control-label">직위/직책</div>
                            <div class="col-sm-9 col-md-9">
                                <input type="text" class="form-control" name="role" placeholder=" " >
                            </div>
                        </div>
                        <!--/form-group -->
                        <div class="form-group">
                            <div class="col-sm-3 col-md-3 control-label">재직기간</div>
                            <div class="col-sm-9 col-md-9">
                                <!-- form-group-date -->
                                <div class="form-group-date"> 
                                    <!-- datepicker -->
                                    <div class="bfh-datepicker" data-format="y.m.d">
                                        <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                            <input type="text" class="form-control datepicker" placeholder="입사일" name="start" readonly>
                                        </div>
                                    </div>
                                    <!-- /datepicker -->  
                                    <div class="checkbox check-workNow">
                                        <label>
                                            <input type="checkbox" checked disabled>
                                            재직중</label>
                                    </div>
                                </div>
                                <!-- /form-group-date --> 
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <!-- /modal-body -->
            
            <!-- /modal-body -->
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" onclick="mem_apply('{res.id}'); return false;">확인</button>
            </div>
            <!-- /modal-footer --> 
        </div>
        <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 
</div>
<!-- /modal #searchStartup -->

<!-- modal #addStaff -->
<div class="modal fade" id="md-addStaff" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3 class="modal-title"><span class="icon-user"></span> <span class="break"></span> 구성원  초대</h3>
            </div>
            <!-- /modal-header -->
            <div class="modal-body"> 
                <form name="add_member_f" onsubmit="return false;" method="post" >
                <input type="hidden" name="user_id" value="{s.id}" />
                <input type="hidden" name="startup_id" value="{res.id}" />
                <h4 class="text-primary">초대할 구성원의 이름과 이메일 주소를 입력하세요</h4>
                <div class="well well-sm form-horizontal">
                    <div class="form-group">
                        <div class="col-sm-3 col-md-3 control-label">이름</div>
                        <div class="col-sm-9 col-md-9">
                            <input type="text" class="form-control" id="staff_name" name="name" value="" placeholder="이름을 반드시 기입해주세요."> 
                        </div>
                    </div>
                    <!--/form-group -->
                    
                    <div class="form-group">
                        <div class="col-sm-3 col-md-3 control-label">이메일</div>
                        <div class="col-sm-9 col-md-9">
                            <div class="input-group"> 
                                <span class="input-group-addon"><span class="icon-envelope-alt "></span></span>
                                <input type="text" name="email" id="staff_email" class="form-control" placeholder="메일주소를 반드시 기입해주세요.">
                            </div>
                        </div>
                    </div>
                    <!--/form-group -->
                 </div>
                </form>
            </div>
            <!-- /modal-body -->
            
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" onclick="add_member(this); return false;">확인</button>
            </div>
            <!-- /modal-footer --> 
        </div>
        <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 
</div>
<!-- /modal #addStaff -->

<script type="text/javascript">
//<![CDATA[

function add_member(_this) {
    if ($('#staff_name').val().length < 1 || $('#staff_email').val().length < 1) {
        return false;
    }
    $(_this).hide();    
    var get_url = '/ajax_front/startup_staff_apply';
    var frm = $('form[name=add_member_f]');
    var set_data = frm.serialize();
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            
            if (_data.msg) {
                $(".modal").modal("hide");
                alert(_data.msg);
            }
            else {
                $('#mem_list').append(_data.data);
                $(".modal").modal("hide");
            }
            $('#staff_name').val('');
            $('#staff_email').val('');
            $(_this).show();
        }
    });
}
    
function edit_state_user(_this, _type, _id, _user) {

    var get_url = '/ajax_front/edit_startup_member_state/'+_type+"/"+_id+"/"+_user;
    
    $.ajax({
        type : 'POST',
        url : get_url,
        dataType : 'json',
        success : function(_data) {

            if (_type === 1) {
                $(_this).parent().removeClass('alert-warning');    
                $(_this).parent().removeClass('alert');    
                $(_this).parent().html(_data.html);
            } else {
                $(_this).parent().remove();
            }

        }
    });
}

function mem_apply(_id) {
    var get_url = '/ajax_front/startup_member_apply';
    var frm = $('form[name=md-applyS]');
    var set_data = frm.serialize();
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            $('#md-applyStaffB').hide();
            {? users}$('#mem_list').append(_data.data);{/}
            $(".modal").modal("hide");
            {? !users}document.location.reload();{/}
        }
    });
}
//]]>
</script>