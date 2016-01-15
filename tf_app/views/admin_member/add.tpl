    <!-- contentwrap -->
    <div class="col-md-10 contentswrap">
        <!-- section -->
        <section>
                <!-- panel -->
                <div class="panel panel-default">
                        <!-- panel-heading -->
                        <div class="panel-heading">
                                <h2><span class="glyphicon  glyphicon-user"></span><span class="break"></span>회원 정보</h2>
                                <div class="actions">
                                    <span class="break"></span>
                                    <a href="/admin_member" class="btn-list" data-toggle="tooltip" title="목록보기"><span class="glyphicon  glyphicon-align-justify"></span></a>
                                </div>
                        </div>
                        <!-- /panel-heading -->
                        <form class="form-horizontal" rol="form" action="/admin_member/add/{res.id}" method="post" name="edit_form">
                            <input type="hidden" name="id" value="{res.id}" />
                            <input type="hidden" name="grade" value="{res.grade}" />
                            <!-- panel-body -->
                            <div class="panel-body">
                                <fieldset>
                                    <h3>회원 기본 정보</h3>
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >이름</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <input readonly type="text" class="form-control"  id="memberName" name="name" value="{res.name}">
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >아이디</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <input readonly type="text" class="form-control"  id="memberID" name="ids" value="{res.ids}">
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    <!--
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >비밀번호 입력</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <input type="password" class="form-control" id="memberPW" name="pwd" value="">
                                        </div>
                                    </div>
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >비밀번호 확인</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <input type="password" class="form-control" id="memberRePW" name="pwd2" value="">
                                        </div>
                                    </div>
                                    //-->
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >프로필이미지</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> <input type="hidden" name="pic" id="pic" value="">
                                            <!--<iframe width="100%" scrolling="no" height="160px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/pic/160x160?old={=safe_js(res.picture)}" allowtransparency="true"></iframe>-->
                                            <img class="img-thumbnail" src="{? res.picture}{res.picture}{? ! strpos(res.picture, '?')}?date={=date('his')}{/}{:}/img/default-img-member.png{/}" id="pic_img">
                                            <div id="div_img_change" style="display: none;">
                                                <iframe  height="500" frameborder="0" width="100%" scrolling="no" id="frm" allowTransparency="true" src="/ajax_front/form_file?which=pic" ></iframe>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >교육</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> <ul class="form-control-static">
                                            {@ edu}
                                            <li>
                                                {.education} {?.education_sp}  <small>{.education_sp}{/} /{? .education_st == 0} 졸업{/}{? .education_st == 1} 재학 중{/}{? .education_st == 2} 중퇴{/}</small>
                                            </li>
                                            {/}
                                            </ul>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >소갯말</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> <textarea readonly rows="3" class="form-control" id="memberDesc" name="bio">{=htmlspecialchars(res.bio)}</textarea>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >관심지역</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> {@ local}
                                            <label class="checkbox-inline"><input type="checkbox" disabled name="locall" value="{.id}" {? .checked}checked='checked'{/}>{._value}</label>
                                            {/}
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >업무역량</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> {@res_in}{?.key_ == 0}{._value}{:}, {._value}{/}{/}
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >관심분야</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> {@res_sk}{?.key_ == 0}{._value}{:}, {._value}{/}{/}
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >SNS</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> <div class="input-group"> <span class="input-group-addon">Twitter</span>
                                                <input type="text" class="form-control" placeholder="mytwitterID" disabled>
                                            </div>
                                            <div class="input-group"> <span class="input-group-addon">Facebook</span>
                                                <input type="text" class="form-control" placeholder="myfacebookID" disabled>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >메일주소</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> <input readonly type="text" class="form-control" name="email" value="{res.email}">
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >메일 수신 여부</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> <div class="radio">
                                                <label><input type="radio" name="email_rec" value="1" {?res.email_rec == "1"}checked{/} {? !res}checked{/}> 메일을 받습니다.</label>
                                           </div>
                                           <div class="radio">
                                                <label><input type="radio" name="email_rec" value="0" {?res.email_rec == "0"}checked{/}> 메일을 받지 않습니다.</label>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >연락처</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> <input type="text" class="form-control" name="tel" value="{res.tel}" readonly>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group form-group-end">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >SMS 수신 여부</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> <div class="radio">
                                                <label>
                                                    <input type="radio" name="sms_rec" value="1" {?res.sms_rec == "1"}checked{/} {? !res}checked{/}>
                                                    SMS를 받습니다.</label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="sms_rec" value="0" {?res.sms_rec == "0"}checked{/}>
                                                    SMS를 받지 않습니다.</label>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                </fieldset>
                            </div>
                            <!-- /panel-body --> 
                            
                            <div class="panel-body">
                                <fieldset>
                                    <h3>경력사항</h3>
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >관련기업/관련기간</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> <ul class="form-control-static">
                                            {@ career}
                                            <li>
                                                 {.sname} <small>{.role}</small>
                                                 <div class="date">
                                                    {? .start}
                                                    {=str_replace("-", ".", .start)} 
                                                    {/}
                                                    {? .is_ing}
                                                    ~ 재직 중
                                                    {:}
                                                    {? .end}
                                                    ~ {=str_replace("-", ".", .end)}
                                                    {/}
                                                    {/}
                                                </div>
                                             </li>
                                            {/}
                                            </ul>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >참여 프로젝트</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> <ul>
                                            {@ project}
                                                <li>
                                                    {.project} {.role} at <a href="/admin_startup/add/{.startup_id}">{.name}</a>
                                                    <div class="date">{=str_replace("-", ".", .start)} ~ {? .is_ing}참여중{:}{=str_replace("-", ".", .end)}{/}</div>
                                                </li>
                                            {/}
                                            </ul>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                </fieldset>
                            </div>
                            <!-- /panel-body --> 
                            
                            <div class="panel-body">
                                <fieldset>
                                    <h3>회원관리</h3>
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >회원등급</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> <select name="grade" class="selectpicker" data-width="auto">
                                                {@ grade}
                                                <option value="{.id}" {? res.grade == .id}selected="selected"{/}>{.name} {? .id == 2}(변경불가){/}</option>
                                                {/}
                                            </select>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >회원가입일</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> <div class="form-control-static">{=str_replace("-", ".", substr(res.date_created, 0, 10))}</div>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >최근접속일</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> <div class="form-control-static">{?res.last_login}{res.last_login} ({=dateDiff(date('Y-m-d'), res.last_login, '-')}일전){:}-{/}</div>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <!--
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >관리자 메모</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <input type="text" class="form-control" id="memberInputMemo" value="">
                                        </div>
                                    </div>
                                    //-->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >회원 상태 처리</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> <select class="selectpicker" data-width="auto" name="state">
                                                <option value="0" {? res.state == "0"}selected="selected"{/}>승인대기</option>
                                                <option value="1" {? res.state == "1"}selected="selected"{/}>승인</option>
                                                <option value="2" {? res.state == "2"}selected="selected"{/}>반려</option>
                                                <option value="3" {? res.state == "3"}selected="selected"{/}>탈퇴</option>
                                            </select> 
                                            
                                            <div class="form-group-sub"> 
                                                <label class="sr-only" for="projectName1">탈퇴사유</label>
                                                <input type="text" class="form-control" id="projectName1" placeholder="탈퇴사유를 적어주세요" name="state_des" value="{res.state_des}"> 
                                            </div>
                                            <!-- /form-group-sub --> 
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2  control-label text-danger"> <span class="glyphicon glyphicon-warning-sign"></span>  메모하기</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> <textarea class="form-control" name="admin_des" >{res.admin_des}</textarea>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                </fieldset>
                            </div>
                            <!-- /panel-body --> 
                            {? (s.per & settings->permission1) == settings->permission1}
                            <div class="panel-footer">
                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                    <button type="button" class="btn btn-default"> 취소</button>
                                    <button type="submit" class="btn btn-primary"> 확인</button>
                                    </div>
                                </div>
                            </div>
                            {/}
                        </form>
                    </div>
                    <!-- /panel -->


            </section>
            <!-- /section -->
    </div>
    <!-- /contentwrap -->
    <form method="post" enctype="multipart/form-data" name="form_file"></form>
<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}

function add_com(_this)
{
    var v = $("#cnt_co").val();
    var v2 = parseInt(v)+1;
    var get_url = "/ajax/member_add_career";
    var set_data ={
        "data": v2,
    };
    
    $.post(get_url, set_data,function(_data) {
        $(_this).before(_data);
        $("#cnt_co").val(parseInt(v)+1);

    });
}

function add_pje(_this)
{
    var v = $("#cnt_pj").val();
    var get_url = "/ajax/member_add_project";
    var set_data ={
        "data": parseInt(v)+1,
    };
    
    $.post(get_url, set_data,function(_data) {
        $(_this).before(_data);
        $("#cnt_pj").val(parseInt(v)+1);
    });
}

function del_box_ca(_this, _id)
{
    var get_url = "/ajax/member_del_career";
    var set_data ={
        "uid": '{res.id}',
        "cid": _id,
    };
    
    $.post(get_url, set_data,function(_data) {
        $(_this).parent().remove();
    });
    
}

function del_box_pj(_this, _id)
{
    var get_url = "/ajax/member_del_project";
    var set_data ={
        "uid": '{res.id}',
        "pid": _id,
    };
    
    $.post(get_url, set_data,function(_data) {
        $(_this).parent().remove();
    });
}

//]]>
</script>