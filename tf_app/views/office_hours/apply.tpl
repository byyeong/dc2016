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
                        <!-- editor -->
                        <div class="editor">
                            <header class="edit-header">
                                <h3><i class="fa fa-pencil-square-o"></i> 참가 신청하기</h3>
                            </header>

                            <div class="edit-body info-field">
                                <div class="row">
                                    
                                    <div class="left col-xs-12 col-sm-12 col-md-4">
                                        <div class="featured-img">
                                            <span style="background-image:url({res.picture});">
                                                <img src="/images/img_trans.png"  class="img-responsive">
                                            </span>
                                        <img src="{res.picture}" class="sr-only">
                                        </div>
                                    </div>
                                    <div class="right col-xs-12 col-sm-12 col-md-8">
                                        <h4>{res.subject}</h4>
                                        <!-- status-info -->
                                        <div class="status-info">
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
                                        </div>
                                        <!-- /status-info --> 
                                    </div>

                                </div>
                            </div>
                            <!-- /edit-body -->

                            <div class="edit-body">
                                <form role="form" method="post" onsubmit="return false;" name="f_apply" enctype="multipart/form-data" action="/office_hours/save_apply"> 
                                    <fieldset>
                                        <h3>신청자 정보 </h3>
                                        <br>
                                        {? st}
                                        <div class="form-group"> 
                                            <label class="control-label">
                                                참가자 이름
                                            </label><span class="text-danger"> *</span>
                                            <input type="text" class="form-control" name="name" value="{app.name}" placeholder="이름(실명)을 입력해주세요."> 
                                        </div>
                                        <!-- / form-group-->

                                        <div class="form-group"> 
                                            <label class="control-label">
                                                휴대폰 번호
                                            </label><span class="text-danger"> *</span>
                                            <input type="text" class="form-control" name="tel" value="{app.tel}" placeholder="연락가능한 휴대폰 번호를 입력해주세요."> 
                                        </div>
                                        <!-- / form-group-->

                                        <div class="form-group"> 
                                            <label class="control-label">
                                                이메일 주소 
                                            </label><span class="text-danger"> *</span>
                                            <input type="text" class="form-control" name="email" value="{app.email}" placeholder="정보메일을 받을 수 있는 이메일을 입력해주세요."> 
                                        </div>
                                        <!-- / form-group-->

                                        <div class="form-group"> 
                                            <label class="control-label">
                                                간단한 자기소개
                                            </label><span class="text-danger"> *</span>
                                            <textarea rows="3" class="form-control" name="m_description" placeholder="간단한 자기소개를 해주세요.">{app.m_description}</textarea>
                                        </div>
                                        <!-- / form-group-->

                                        <div class="form-group"> 
                                            <label class="control-label">
                                                이야기 나누고 싶은 상담주제
                                            </label><span class="text-danger"> *</span>
                                            <textarea rows="3" class="form-control" name="topic" placeholder="이야기 나누고 싶은 상담주제를 입력해주세요.">{app.topic}</textarea>
                                        </div>
                                        <!-- / form-group-->

                                        <div class="form-group"> 
                                            <label class="control-label">
                                                팀 소개
                                            </label><span class="text-danger"> *</span>
                                            <textarea rows="3" class="form-control" name="t_description"placeholder="팀 소개를 해주세요.">{app.t_description}</textarea>
                                        </div>
                                        <!-- / form-group-->

                                        <div class="form-group"> 
                                            <label class="control-label">
                                                참가회사 / 팀명
                                            </label><span class="text-danger"> *</span>
                                            <select class="form-control" name="team">
                                                {@ st}
                                                <option value="{.sname}" rel="{.startup_id}" {? app.team == .sname}selected="selected"{/}>{.sname} </option>
                                                {/}
                                            </select>
                                        </div>
                                        <!-- / form-group-->

                                        <div id="more-companyInfo" class="collapse in" aria-expanded="true"></div>

                                        {? form}
                                        <br>
                                        <h3>추가질문  </h3>
                                        <br>
                                        {@ form}
                                        <div class="form-group"> 
                                            <label class="control-label">
                                                {.subject}
                                            </label>
                                            <textarea rows="3" class="form-control" name="form_{.id}">{.contents}</textarea>
                                        </div>
                                        <!-- / form-group-->
                                        {/}
                                        {/}

                                        <div class="form-group"> 
                                            <label class="control-label">
                                                첨부파일 (8MB까지 가능) {? app.file}:: <a href="/office_hours/get_source?apply_id={app.id}">{app.filename}</a>{/}
                                            </label></label><span class="text-danger"> *</span>
                                            <input type="file" name="file" onchange="limit_upload(this); return false;"> 
                                            <img src="/img/common/ajax-large-loader.gif" style="display: none;">
                                            <input style="margin-top:5px;" type="text" class="form-control" name="file_link" value="{app.file_link}" placeholder="첨부파일이 8MB 이상인 경우, 다운받을 수 있는 링크를 입력해주세요."> 
                                        </div>
                                        <!-- / form-group-->

                                        {? res.a_end > date('Y.m.d H:i')}
                                        <div class="form-group form-submit">
                                            <button class="btn btn-default" type="button" onclick="javascript:location.href='/office_hours/views/{res.id}'">취소</button>
                                            <button class="btn btn-primary" type="submit" onclick="submit_apply({? app.id}{app.id}{:}0{/});">{? app.id}수정{:}참가 접수{/}하기</button>
                                            (선정을 위해, 되도록 모든 항목을 입력해주세요.)
                                        </div> 
                                        <!-- / form-group-->
                                        {/}
                                        <input type="hidden" name="id" value="{app.id}" />
                                        <input type="hidden" name="oh_id" value="{res.id}" />
                                        <input type="hidden" name="ser_id" value="" />
                                        <input type="hidden" name="st_id" value="" />
                                        <input type="hidden" id="f_ing" value="" />
                                        {:}
                                        <div class="form-group"> 
                                            <div class="well">
                                                Office Hours 신청은 관리 권한이 있는 기업 프로필 페이지가 있어야 신청 할 수 있습니다. 
                                                <br>기업 프로필 페이지는 아래와 같은 절차로 만들 수 있습니다.
                                                <ul>
                                                    <li>개인 프로필 페이지로 이동합니다.</li>
                                                    <li>프로필 페이지의 관련 기업을 추가합니다.</li>
                                                    <li>기업 프로필 페이지가 생성됩니다. </li>
                                                    <li>반드시 '재직중'으로 체크하셔야 기업 프로필 페이지 관리 권한이 주어집니다. </li>
                                                    <li>기업 프로필 페이지의 '제품/서비스 정보'를 입력합니다.</li>
                                                </ul>
                                            </div>
                                            <br>
                                            {? s.id}
                                            <a href="/member/{s.ids}" class="btn btn-default btn-sm">내 프로필 페이지로 이동</a>
                                            {:}
                                            <a href="/login" class="btn btn-default btn-sm">로그인</a>
                                            {/}
                                        </div>
                                        {/}
                                    </fieldset>
                                </form>
                            </div>
                            <!-- /edit-body -->
                        </div>
                        <!-- /editor -->
                    </div>
                    <!-- /content -->


                    {? other}
                    <!-- sidebar -->
                    <div class="sidebar col-xs-12 col-sm-12 col-md-4">
                        <section class="list-mentors">
                            <header>
                                <h3>Mentors</h3>
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
<script>

{? app.team}
get_startup($("select[name=team] option:selected").attr('rel'), '{app.s_subject}');
{:}
get_startup('{st_f.startup_id}', "{st_f.sname}");
{/}

$('select[name=team]').change(function(){
    get_startup($("select[name=team] option:selected").attr('rel'));
});

$('select[name=s_subject]').change(function(){
    _id = $("select[name=s_subject] option:selected").attr('rel');
    $.ajax({
        type : 'GET',
        url : '/ajax_v2/get_service_des/' + _id,
        success : function(_data) {
            $('input[name=s_description]').val(_data);
        }
    });
});

</script>

