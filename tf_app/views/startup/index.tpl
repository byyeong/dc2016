    <!-- #jumbo-header -->
    <div id="startup" class="jumbo-header hstyle-options{=rand(0, 9)}"> 
        <!-- #header --> 
        <div id="header">
             <div class="container">
                <div class="row">
                    <div id="profileHeader" class="col-xs-12 col-sm-12 col-md-8 col-md-offset-2">
                        
                        <div class="prf-info">
                            <div class="vimg">
                                <span style="background-image:url({? res.logo}{res.logo}{:}/img/default-img-company.png{/});"><img href="{? res.logo}{res.logo}{:}/img/default-img-company.png{/}"></span>
                            </div>
                            <h2>
                                <strong>{res.name}</strong>
                                {? s && edi.user_id == s.id}
                                <small>
                                    <a href="/startup/edit/{res.id}" data-toggle="tooltip" title="프로필수정">
                                        <span class="glyphicon glyphicon-cog"></span>
                                        <span class="sr-only">프로필수정</span>
                                    </a>
                                </small>
                                {/}
                            </h2>

                            <p class="lead">
                                {=htmlspecialchars(res.bio)} 
                            </p>                                                   
                             
                            <ul class="list-inline list-tags"> 
                                {@ bis}
                                <li>{._value}</li>
                                {/}
                            </ul> 

                            <p class="desc">
                                {=str_replace("\n","<br />", str_replace("&lt;","<", str_replace("&gt;",">", res.description)))}
                            </p> 
                        </div>
                        <!-- /prf-info -->

                        <dl class="prf-member">
                            <dt class="sr-only">멤버</dt>
                            <dd>
                                <ul class="list-inline" id="mem_list">
                                    {@ users}
                                        {? .status == 0}
                                            {? s && edi.user_id == s.id}
                                            <!-- 승인, 삭제 버튼 보임 -->
                                            <li id="mem{.mid}">
                                                <a href="#" class="prf-memberStading" onclick="apply_member('{.mid}', '{.smid}'); return false;" title="{.name}{?.role}({.role}){/}">
                                                    <img src="{? .picture}{.picture}{:}/img/default-img-member.png{/}" class="img-circle" alt="{.name}{?.role}({.role}){/}">
                                                </a>
                                            </li>
                                            {:}
                                                {? mem}
                                                <!-- 단순 승인대기 -->
                                                <li>
                                                    <a href="/member/{.ids}" class="prf-memberStading" title="{.name}{?.role}({.role}){/}">
                                                        <img src="{? .picture}{.picture}{:}/img/default-img-member.png{/}" class="img-circle" alt="{.name}">
                                                    </a>
                                                </li>
                                                {/}
                                            {/}
                                        {:}
                                            <li id="mem{.mid}">
                                                {? s && edi.user_id == s.id}
                                                    <button class="btn-link btn-xs" data-toggle="modal" data-target="#mdl-recongDelete" title="delete" data-mid="{.mid}", data-smid="{.smid}">
                                                        <i class="fa fa-times"></i>
                                                        <span class="sr-only">삭제</span>
                                                    </button>
                                                {/}
                                                <a href="/member/{.ids}" data-toggle="tooltip" data-placement="top" title="{.name}{?.role}({.role}){/}">
                                                    <img src="{? .picture}{.picture}{:}/img/default-img-member.png{/}" class="img-circle" alt="{.name}">
                                                </a>
                                            </li>
                                        {/}
                                    {/}


                                    <li>
                                        {? s && !mem && users}
                                        <a id="md-applyStaffB" href="#md-applyStaff" data-toggle="modal" title="구성원 신청하기">
                                            <span class="fa-stack fa-lg">
                                                <i class="fa fa-circle fa-stack-2x"></i>
                                                <i class="fa fa-plus fa-stack-1x fa-inverse"></i>
                                            </span>
                                            <span class="sr-only">구성원 신청하기</span>
                                        </a>
                                        {/}
                                        {? s && !users}
                                        <a id="md-applyStaffB" href="#md-applyStaff" data-toggle="modal" data-placement="top" title="구성원 등록하기">
                                            <span class="fa-stack fa-lg">
                                                <i class="fa fa-circle fa-stack-2x"></i>
                                                <i class="fa fa-plus fa-stack-1x fa-inverse"></i>
                                            </span>
                                            <span class="sr-only">구성원 등록하기</span>
                                        </a>
                                        {/}
                                        {? s && edi.user_id == s.id}
                                        <a id="md-applyStaffB" href="#md-addStaff" data-toggle="modal" data-placement="top" title="구성원 초대하기">
                                            <span class="fa-stack fa-lg">
                                                <i class="fa fa-circle fa-stack-2x"></i>
                                                <i class="fa fa-plus fa-stack-1x fa-inverse"></i>
                                            </span>
                                            <span class="sr-only">구성원 초대하기</span>
                                        </a>
                                        {/}
                                    </li>
                                </ul>
                            </dd>
                            {? jobs}
                            <dd id="notify-incruit">
                                <a href="/recruit?ing={res.id}" class="btn btn-info">현재 채용 중입니다. 채용공고 확인하기</a>
                            </dd>
                            {/}

                        </dl>
                        <!-- /prf-member -->

                        <div class="prf-networks">
                            {? s && edi.user_id == s.id}
                            <div class="nwk-employ">
                                <a href="/recruit/add" class="btn btn-link"> <i class="fa fa-briefcase"></i> 채용공고 작성하기</a>
                            </div>
                            {/}
                            <ul class="list-inline list-follow">
                                <li class="nwk-followership">
                                    
                                    {? s}
                                    {? follow}
                                    <button class="btn-network btn-following" onclick="add_follow_p(this, '{s.id}', '{res.id}', 2, 1); return false;"><span class="glyphicon glyphicon-ok"></span> <strong>Following</strong></button> 
                                    {:}
                                    <button class="btn-network btn-follow" onclick="add_follow_p(this, '{s.id}', '{res.id}', 2); return false;"><span class="glyphicon glyphicon-plus"></span> <strong>Follow</strong></button>
                                    {/}
                                    {:}
                                    <button class="btn-network btn-follow" onclick="javascript:alert('로그인이 필요합니다. 로그인 후 Follow 할 수 있습니다.');"><span class="glyphicon glyphicon-plus"></span> <strong>Follow</strong></button>
                                    {/}
                                    <!--
                                    <button class="btn-network btn-unfollow"><span class="glyphicon glyphicon-remove"></span> <strong>Unfollow</strong></button>                        
                                    -->
                                </li>
                                <li class="nwk-follower">
                                    <a href="#" onclick="get_follow(2, {res.id}, 0); return false;">
                                         <strong>Followers</strong>
                                         <span class="badge">{=sizeof(fl)}</span>
                                     </a>
                                </li>
                            </ul>

                            {? (res.website && res.website != "http://") || res.blog && res.blog != "http://" || res.facebook || res.twitter}
                            <ul class="list-inline list-links">
                                {? res.website && res.website != "http://"}
                                <li class="nwk-homepage">
                                    <a href="{=check_http(res.website)}" target="_blank">
                                        <span class="fa-stack fa-lg">
                                          <i class="fa fa-circle fa-stack-2x"></i>
                                          <i class="fa fa-header fa-stack-1x fa-inverse"></i>
                                        </span>
                                        <span class="sr-only">Hompage</span>
                                    </a>
                                </li>
                                {/}
                                {? res.blog && res.blog != "http://"}
                                <li class="nwk-blog">
                                    <a href="{=check_http(res.blog)}" target="_blank">
                                        <span class="fa-stack fa-lg">
                                          <i class="fa fa-circle fa-stack-2x"></i>
                                          <i class="fa fa-bold fa-stack-1x fa-inverse"></i>
                                        </span>
                                        <span class="sr-only">Blog</span>
                                    </a>
                                </li>
                                {/}
                                {? res.facebook}
                                <li class="nwk-facebook">
                                    <a href="http://facebook.com/{fb.ids}" target="_blank">
                                        <span class="fa-stack fa-lg">
                                          <i class="fa fa-circle fa-stack-2x"></i>
                                          <i class="fa fa-facebook fa-stack-1x fa-inverse"></i>
                                        </span>
                                        <span class="sr-only">Facebook</span>
                                    </a>
                                </li>
                                {/}
                                {? res.twitter}
                                <li class="nwk-twitter">
                                    <a href="http://twitter.com/{tw.ids}" target="_blank">
                                        <span class="fa-stack fa-lg">
                                          <i class="fa fa-circle fa-stack-2x"></i>
                                          <i class="fa fa-twitter fa-stack-1x fa-inverse"></i>
                                        </span>
                                        <span class="sr-only">Twitter</span>
                                    </a>
                                </li>
                                {/}
                                <!--li class="nwk-linkedin">
                                    <a href="#">
                                        <span class="fa-stack fa-lg">
                                          <i class="fa fa-circle fa-stack-2x"></i>
                                          <i class="fa fa-linkedin fa-stack-1x fa-inverse"></i>
                                        </span>
                                        <span class="sr-only">Linkedin</span>
                                    </a>
                                </li-->
                            </ul>
                            {/}
                        </div>
                        <!-- /prf-networks -->

                        <dl class="prf-footer"> 
                            
                            {? res.addr}
                            <dt class="sr-only">주소</dt>
                            <dd><i class="fa fa-flag"></i> &nbsp; {res.addr} </dd>
                            {/}
                            {? res.tel}
                            <dt class="sr-only">전화번호</dt>
                            <dd><i class="fa fa-phone"></i> &nbsp; {res.tel}</dd>
                            {/}
                            {? res.email}
                            <dt class="sr-only">이메일</dt>
                            <dd><i class="fa fa-envelope"></i> &nbsp; {res.email}</dd>
                            {/}
                            {? res.founded}
                            <dt class="sr-only">설립일</dt>
                            <dd><i class="fa fa-building-o"></i> &nbsp; {res.founded}</dd>
                            {/}
                            {? res.number}
                            <dt class="sr-only">임직원</dt>
                            <dd><i class="fa fa-group"></i> &nbsp; {res.number}명</dd> 
                            {/}
                        </dl>
                        <!-- /prf-footer -->
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
                            {? (s && edi.user_id == s.id) || ser_c}
                            <li><a href="#profile-content-goods" data-toggle="tab">제품/서비스</a></li>
                            {/}
                            {? res.stype == 1}
                            {? (s && edi.user_id == s.id)}
                            <li><a href="#profile-content-investment" data-toggle="tab">투자/인큐베이팅</a></li>
                            {/}
                            {/}
                            {? (s && edi.user_id == s.id) || sizeof(up) > 0}
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
                    <!-- start Contents -->
                    
                    <!-- /tab-content -->
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane" id="profile-content-goods">
                            
                            <!-- panel goods -->
                            <div class="panel panel-default goods">
                            </div>
                            <!-- /panel goods  --> 
<script type="text/javascript">
//<![CDATA[
function del_prev(_this)
{
    $(_this).parent().prev().attr("value", "");
}

get_service();
function get_service(_id)
{
    var get_url = '/ajax_v3/startup_get_service/{res.id}';
    $.get(get_url, function(_data) {

        $('.goods').html(_data);
        $('.quater').ellipsis({
            row: 4
        });
        if (_id) {
            var url = location.href;
            location.href = "#service_"+_id;
            history.replaceState(null,null,url);
        }
    });
}
//]]>
</script>
                        </div>
                        <!-- /tab-pane #profile-content-goods -->
                        
                        <div role="tabpanel" class="tab-pane" id="profile-content-investment">
                            <!-- panel investment -->
                            <div class="panel panel-default investment">
                            </div>
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

                        </div>
                        <!-- /tab-pane #profile-content-investment -->


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
get_timeline(2, '{res.id}', 1);
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
get_timeline_w(2, '{res.id}', 1);
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





                        <section role="tabpanel" class="tab-pane" id="profile-content-reference">
                        <!-- profile-reference -->
                            <div id="profile-reference" class="panel">
                                <div class="panel-heading">
                                    <strong>추천합니다</strong>
                                </div>
                                <!-- /panel-heading -->
                                
                                <div class="panel-body" id="ref_form">
                                    <div class="media form-edit-set" {? !s || edi.user_id != s.id}style="display: none;"{/}> 
                                        <a class="media-left" href="{? s}/member/{s.ids}{:}#{/}"> <img src="{? s}{s.picture}{:}../img/default-img-member.png{/}" class="media-object img-circle" data-toggle="tooltip" title="{s.name}"> </a>
                                        <div class="media-body">
                                            <form onsubmit="return false;" name="ref_form_0">
                                                <fieldset>
                                                    <input type="hidden" name="user_id" value="{s.id}" />
                                                    <input type="hidden" name="startup_id" value="{res.id}" />
                                                    <div class="input-group"> 
                                                        <label class="sr-only">초대할 이메일</label>
                                                        <span class="input-group-addon"><i class="fa fa-envelope"></i></span></span>
                                                        <input type="text" name="email" id="ref_email" class="form-control" placeholder="초대할 메일주소를 입력하세요">
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="sr-only">초대 메시지</label>
                                                        <textarea required row="3" name="contents" id="ref_contents" class="form-control" placeholder="레퍼런스에 초대할 내용을 작성해주세요">{res.name}님이 D.CAMP의 프로필/이력 페이지에  당신을 레퍼런스로 추가하고자 합니다. {res.name}에 대한 추천사를 남겨주세요.</textarea>
                                                    </div>
                                                    <div class="form-group form-submit">
                                                        <button class="btn btn-default btn-sm" onclick="submit_ref(0, this); return false;">초대 메일 보내기</button>
                                                    </div>
                                                </fieldset>
                                            </form>
                                        </div>
                                    </div>
                                                    
                                    <div class="media form-edit-set" > 
                                        <a class="media-left" href="{? s}/member/{s.ids}{:}#{/}"> <img src="{? s}{s.picture}{:}../img/default-img-member.png{/}" class="media-object img-circle" data-toggle="tooltip" title="{s.name}"> </a>
                                        <div class="media-body">
                                            <form onsubmit="return false;" name="ref_form_wr">
                                                <input type="hidden" name="req_id" value="{res.id}" />
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="sr-only">추천 메시지</label>
                                                        <textarea id="refer" name="reference" row="3" class="form-control" placeholder="{res.name}님에 대한 추천사를 남겨주세요"></textarea>
                                                    </div>
                                                    <div class="form-group form-submit">
                                                        {? s}
                                                        <button class="btn btn-default btn-sm" onclick="submit_ref_wr(); return false;">저장하기</button>
                                                        {:}
                                                        <button class="btn btn-primary" onclick="javascript:alert('로그인이 필요합니다. <br />로그인 후 레퍼런스를 작성해주세요.')">저장하기</button>
                                                        {/}
                                                    </div>
                                                </fieldset>
                                            </form>
                                        </div>
                                    </div>

                                    <!-- todo: normal 상태 -->
                                    <div id="ref_yes">
                                    </div>

                                </div>
<script type="text/javascript">
//<![CDATA[
get_reference();
function get_reference()
{
    var get_url = '/ajax_front/startup_get_ref/{res.id}';
    $.get(get_url, function(_data) {
        if (_data === '') {
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
                            </div>
                            <!-- profile-reference-->  
                        </section>
                        <!-- /tab-pane #profile-content-reference -->





                         
                    </div> 
                    <!-- /tab-content -->    




                    <!-- start Contents -->    
                </div> 
            </div>  
        </div> 
    </div>
    <!-- #content -->

<!-- modal #searchStartup -->
<div class="modal fade" id="md-applyStaff" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3 class="modal-title"> 구성원 {?!users}등록{:}신청{/}</h3>
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
                            <div class="col-sm-3 col-md-3 control-label">입사일</div>
                            <div class="col-sm-9 col-md-9">
                                <input type="text" class="form-control" name="start" placeholder="2015.01.01" >
                                <div class="checkbox check-workNow">
                                    <label>
                                        <input type="checkbox" checked disabled>
                                        재직중
                                    </label>
                                </div>
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
                <h3 class="modal-title"> 구성원  초대</h3>
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
                                <span class="input-group-addon"><span class="fa fa-envelope "></span></span>
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

<!-- Modal:mdl-recongAdd -->
<div class="modal fade" id="mdl-recongAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div>
<!-- /Modal:mdl-recongAdd -->

<!-- Modal:mdl-recongDelete -->
<div class="modal fade" id="mdl-recongDelete" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">구성원 삭제</h4>
            </div>
            <div class="modal-body">
                <p>해당 구성원을 {res.name}에서 삭제하겠습니까?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">아니오</button>
                <button type="button" class="btn btn-primary delete-member" data-mid="" data-smid="">예</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- /Modal:mdl-recongDelete -->

<script type="text/javascript">
//<![CDATA[

$(function(){
    //삭제 팝업
    $('#mdl-recongDelete').on('show.bs.modal', function (event) {
        var $button = $(event.relatedTarget); // Button that triggered the modal
        var del_mid = $button.data('mid');
        var del_smid = $button.data('smid');

        $('#mdl-recongDelete .delete-member').click(function(){
            delete_user(del_mid, del_smid);
        });
    })
});
    
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
                $(_this).parent().parent().parent().before(_data.data);
                $(".modal").modal("hide");
            }
            $('#staff_name').val('');
            $('#staff_email').val('');
            $(_this).show();
        }
    });
}

function delete_user(_user, _id){

    var get_url = '/ajax_front/delete_startup_member_state/'+_id+'/'+_user;
    $.ajax({
        type : 'POST',
        url : get_url,
        dataType : 'json',
        success : function(_data) {
            if (_data) {
                $('#mem'+_user).remove();

            }
            $(".modal").modal("hide");
        }
    });
}
    
function edit_state_user(_type, _id, _user) {
    _user = _user != undefined ? _user : '';
    var get_url = '/ajax_front/edit_startup_member_state/'+_type+"/"+_id+"/"+_user;
    
    $.ajax({
        type : 'POST',
        url : get_url,
        dataType : 'json',
        success : function(_data) {
            if (_type === 1) {
                $('#mem'+_user+' a').removeClass('prf-memberStading');    
                $('#mem'+_user+' a').attr('href', '/member/'+_data);

            } else {
                $('#mem'+_user).remove();
            }
            $(".modal").modal("hide");
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

function apply_member(_id, _smid) {
    $.get('/ajax_front/get_profile/'+_id+'/'+_smid, function(_data){
        $('#mdl-recongAdd').html(_data);
        $('#mdl-recongAdd').modal('show');
    })
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