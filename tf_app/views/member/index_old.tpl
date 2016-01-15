<!-- rowContent -->
<div class="rowContent" id="community"> 
    <input type="hidden" id="id" value="{res.id}" />
    <input type="hidden" id="page_owner" value="{res.name}" />
    <!-- page-header -->
    <div class="page-header">
        <div class="container">
            <h1>커뮤니티 <small>Community</small></h1>
        </div>
    </div>
    <!-- /page-header --> 
    
    <!-- page-content -->
    <div class="page-content" id="commu-profile"> 
        
        <!-- profile-header -->
        <div class="profile-header">
            <div class="container">
                <div class="row box">
                
                    <div class="col-md-2 profile-img">
                        <div class="img-thumbnail"><span><img src="{? res.picture}{res.picture}?date={=date('his')}{:}/img/default-img-member.png{/}"></span></div>
                    </div>
                    <!-- /profile-img -->
                    
                    <div class="col-md-10 profile-info">
                        <h2>{res.name}<small>({res.ids})</small></h2>
                        
                        <div class="row">
                            <div class="col-md-7 profile-desc">
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
                            
                            <div class="col-md-5 profile-meta c_company">
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
                    <!-- /profile-info -->                    
                    
                </div>
            </div>
        </div>
        <!-- /profile-header --> 
        
        <!-- profile-content -->
        <div class="container profile-content">
            <div class="row"> 
                
                <!-- content -->
                <div class="content col-md-8"> 
                    
                    <!-- profile-content-user -->
                    <section class="profile-content-user"> 
                        
                        
                        <!-- panel scholarship -->
                        <div class="panel panel-default scholarship">
                        </div>
                        <!-- /panel scholarship  --> 
<script type="text/javascript">
//<![CDATA[

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
                        <!-- panel reference 
                        <div class="panel panel-default reference">
<script type="text/javascript">
//<![CDATA[
get_reference();
function get_reference()
{
    var get_url = '/ajax_front/member_get_ref/{res.id}';
    $.get(get_url, function(_data) {
        $('.reference').html(_data);
    });
}
//]]>
</script> 
                        </div>
                         //panel reference --> 
                    </section>
                    <!-- /profile-content-user --> 
                    
                    <!-- profile-content-feed -->
                    <section class="profile-content-feed"> 
                    </section>
                    <!-- /profile-content-feed --> 
<script type="text/javascript">
//<![CDATA[
get_timeline(1, '{res.id}', 1);
function get_timeline(_type, _id, _page)
{
    var get_url = '/ajax_front/get_timeline/'+_type+'/'+_id+'/'+_page;
    $.get(get_url, function(_data) {
        $('.profile-content-feed').html(_data);
    });
}
//]]>
</script> 

                </div>
                <!-- /content --> 
                <!-- sidebar -->
                <div class="sidebar col-md-4"> 
                    
                    <!-- panel network 
                    <div class="panel panel-default network">
                        <div class="panel-heading">
                            <h4>네트워크</h4>
                        </div>
                        <div class="panel-body"> 
                            <!-- tab 
                            <ul id="followTab" class="nav nav-tabs">
                                <li class="active"><a href="#follower-list" data-toggle="tab">Follower <span class="badge">200</span></a></li>
                                <li><a href="#following-list" data-toggle="tab">Following <span class="badge">200</span></a></li>
                            </ul>
                            <div id="followList" class="tab-content">
                                <div class="tab-pane active" id="follower-list">
                                    <ul class="list-unstyled">
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="단내양"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                    </ul>
                                </div>
                                <div class="tab-pane" id="following-list">
                                    <ul class="list-unstyled">
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                        <li><img data-src="holder.js/40x40" data-toggle="tooltip" title="userName"></li>
                                    </ul>
                                </div>
                            </div>
                            <!-- /tab 
                        </div>
                    </div>
                    <!-- /panel network --> 
                    
                    <!-- panel network -->
                    <div class="panel panel-default network">
                        <div class="panel-heading">
                            <h4>네트워크</h4>
                        </div>
                        <div class="panel-body"> 
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
                                        <li><a href="/member/{.ids}"><img src="{? .picture}{.picture}{:}/img/default-img-member.png{/}" data-src="holder.js/40x40" data-toggle="tooltip" title="{.name}" class="img-circle"></a></li>
                                        {/}{? .type == 2}
                                        <li><a href="/starup/{.id}"><img src="{? .logo}{.logo}{:}/img/default-img-company.png{/}" data-src="holder.js/40x40" data-toggle="tooltip" title="{.name}" class="img-circle"></a></li>
                                        {/}
                                        {/}
                                    </ul>
                                </div>
                                <div class="tab-pane" id="following-list">
                                    <ul class="list-unstyled">
                                        {@ fi}
                                        {? .type == 1}
                                        <li><a href="/member/{.ids}"><img src="{? .picture}{.picture}{:}/img/default-img-member.png{/}" data-src="holder.js/40x40" data-toggle="tooltip" title="{.name}" class="img-circle"></a></li>
                                        {/}
                                        {? .type == 2}
                                        <li><a href="/startup/{.id}"><img src="{? .logo}{.logo}{:}/img/default-img-company.png{/}" data-src="holder.js/40x40" data-toggle="tooltip" title="{.name}" class="img-circle"></a></li>
                                        {/}
                                        {/}
                                    </ul>
                                </div>
                            </div>
                            <!-- /tab --> 
                        </div>
                    </div>
                    <!-- /panel network --> 
                    
                    <!-- panel region -->
                    <div class="panel panel-default region">
                        <div class="panel-heading">
                            <h4>관심지역 </h4>
                        </div>
                        <div class="panel-body">
                            <ul class="list-inline">
                                {? local}{@ local}
                                <li>{._value}</li>
                                {/}{/}
                            </ul>
                        </div>
                    </div>
                    <!-- /panel region --> 
                    
                    <!-- panel skill -->
                    <div class="panel panel-default skill">
                        <div class="panel-heading">
                            <h4>업무역량 </h4>
                        </div>
                        <div class="panel-body">
                            <ul class="list-inline">
                                {? skill}{@ skill}
                                <li>{._value}</li>
                                {/}{/}
                            </ul>
                        </div>
                    </div>
                    <!-- /panel skill --> 
                    
                    <!-- panel interest -->
                    <div class="panel panel-default interest">
                        <div class="panel-heading">
                            <h4>업무분야 </h4>
                        </div>
                        <div class="panel-body">
                            <ul class="list-inline ">
                                {? inter}{@ inter}
                                <li>{._value}</li>
                                {/}{/}
                            </ul>
                        </div>
                        
                    </div>
                    <!-- /panel interest --> 
                    
                    {? event && s.id == res.id}
                    <!-- panel event -->
                    <div class="panel panel-default event">
                        <div class="panel-heading">
                            <h4>내가 만든 이벤트</h4>
                        </div>
                        {? event}
                        <div class="panel-body">
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
                        </div>
                        {/}
                    </div>
                    <!-- /panel event --> 
                    {/}
                    
                    {? space && s.id == res.id}
                    <!-- panel event -->
                    <div class="panel panel-default event">
                        <div class="panel-heading">
                            <h4>내가 신청한 공간공유</h4>
                        </div>
                        {? space}
                        <div class="panel-body">
                            <ul class="list-unstyled">
                                {@ space}
                                <li><a href="/space/apply/{.id}" > {.purpose} </a> 
                                    <button class="btn btn-default btn-xs" onclick="javascript:location.href='/space/apply/{.id}'">Edit</button>
                                    {? .state == 0}<span class="label label-info">승인대기</span></p>{/}
                                    {? .state == 1}<span class="label label-success">승인</span></p>{/}
                                    {? .state == 2}<span class="label label-warning">반려</span></p>{/}
                                    
                                    <p>
                                        일정 : {.date} {.start} ~ {.end} <br>
                                        장소 : {.name} {.opt}
                                    </p>
                                </li>
                                {/}
                            </ul>
                        </div>
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

<script type="text/javascript">
//<![CDATA[

function find_com(_this){
    var key = $(_this).parent().parent().find('input[name=company]').val().replace(/(^\s*)|(\s*$)/gi, "");
    var form =  $(_this).parent().parent().parent().parent().parent().parent().attr('id');
    var get_url = '/ajax_front/get_search_startup2/';
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

function enter_startup(_form){
    var tt = $('#search_in').val();
    tt = tt.replace(/(^\s*)|(\s*$)/gi, "");
    $('#md-compEditor_com').val(tt);
    $('#form_t').val(_form);
    $('#md-compEditor').modal('show');
    /*
    var get_url = '/ajax_front/get_add_startup/';
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
            $('#md-compEditor').html(_data);
            $('#md-compEditor').modal('show');
        }
    });
    */
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
    var frm = $('form[name=add_st_form]');
    var set_data = frm.serialize();;
    var _form = $('#form_t').val();
    $(_this).hide();
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            $('#'+_form+' [name=company]').val($('#md-compEditor_com').val());
            $('#'+_form+' [name=company]').attr('readonly', 'readonly');
            $(_this).show();
            $('.modal').modal('hide');
        }
    });
}
//]]>
</script> 