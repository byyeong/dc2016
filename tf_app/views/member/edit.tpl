
            <div class="col-xs-12 col-sm-12 col-md-9 content">
                <div class="content-header">
                    <h3 class="content-heading"> <span class="icon-user"></span> 개인정보 수정 </h3>
                </div>
                
                <div class="edit-body modifyProfile">
                    <form class="form-horizontal" role="form" method="post" name="edit_form" action="/member/edit" onsubmit="return false;">
                        <input type="hidden" name="id" value="{res.id}" />
                        <input type="hidden" name="ids" value="{res.ids}" />
                        <input type="hidden" name="grade" value="{res.grade}" />
                        <input type="hidden" name="state" value="{res.state}" />
                        {? res.utype == 1}
                        <input type="hidden" name="cnt_sk" id="cnt_sk" value="{? sizeof(res_sk) > 0}{=sizeof(res_sk)}{:}1{/}" />
                        {/}
                        {? res.utype == 2}
                        <input type="hidden" name="cnt_fl_i" id="cnt_fl_i" value="{? sizeof(res_in) > 0}{=sizeof(res_in)}{:}1{/}" />
                        <input type="hidden" name="cnt_sk_i" id="cnt_sk_i" value="{? sizeof(res_sk) > 0}{=sizeof(res_sk)}{:}1{/}" />
                        <input type="hidden" name="cnt_mk_i" id="cnt_mk_i" value="{? sizeof(res_mk) > 0}{=sizeof(res_mk)}{:}1{/}" />
                        {/}
                        <fieldset>
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">이름</div>
                                <div class="col-xs-12 col-sm-9 col-md-9">
                                    <input type="text" class="form-control" name="name" id="name" value="{res.name}" />
                                </div>
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">아이디</div>
                                <div class="col-xs-12 col-sm-9 col-md-9">
                                    <p class="form-control-static">{res.ids}</p>
                                </div>
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">비밀번호</div>
                                <div class="col-xs-12 col-sm-9 col-md-9">
                                    <button class="btn btn-default btn-sm" id="edit_btn_pwd" >비밀번호 수정</button>
                                </div>
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">생년월일</div>
                                <div class="col-xs-12 col-sm-9 col-md-9">
                                    <div class="bfh-datepicker" data-format="y.m.d">
                                        <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                            <input type="text" class="form-control datepicker" name="birth" value="{res.birth}" readonly required="required">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">성별</div>
                                <div class="col-xs-12 col-sm-9 col-md-9">
                                    <label class="radio-inline">
                                        <input type="radio" {? res.gender == 1}checked="checked"{/} name="gender" value="1">
                                        남자</label>
                                    <label class="radio-inline">
                                        <input type="radio" {? res.gender == 2}checked="checked"{/} name="gender" value="2">
                                        여자</label>
                                </div>
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">프로필이미지</div>
                                <div class="col-xs-12 col-sm-9 col-md-9">
                                    <input type="hidden" name="pic" id="pic" value="" />
                                    <!--
                                                    <img class="img-thumbnail" src="{res.picture}" id="pic_img" onclick="toggle_img();return false;">
                                                    <div id="div_img_change" style="display: none;">
                                                        <iframe  height="610" frameborder="0" width="100%" scrolling="no" id="frm" allowTransparency="true" src="/ajax_front/form_file?sub_dir={=substr(res.picture, 1)}&which=pic" ></iframe>
                                                    </div>
                                                    //--> 
                                    <img class="img-thumbnail" src="{res.picture}{? ! strpos(res.picture, '?')}?date={=date('his')}{/}" id="pic_img" onclick="toggle_img();return false;">
                                    <div id="div_img_change" style="display: none;">
                                        <iframe  height="500" frameborder="0" width="100%" scrolling="no" id="frm" allowTransparency="true" src="/ajax_front/form_file?sub_dir={=substr(res.picture, 1)}&which=pic" ></iframe>
                                    </div>
                                </div>
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">자기소개</div>
                                <div class="col-xs-12 col-sm-9 col-md-9">
                                    <textarea row="3" id="inputSelfintroduce" class="form-control" name="bio">{=htmlspecialchars(res.bio)}</textarea>
                                </div>
                                <!-- /control-input --> 
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                            <span class="col-xs-12 col-sm-3 col-md-3 control-label">채용 정보</span>
                            <div class="col-xs-12 col-sm-9 col-md-9">
                            <label class="checkbox-inline">
                            <input type="checkbox" name="wanted" value="1" {? res.wanted}checked='checked'{/}>
                            구직 중
                            <label>
                            </div>
                            </div>
                            <!-- /form-group--> 
                            
                            {? res.utype == 1}
                            <div class="form-group"> <span class="col-xs-12 col-sm-3 col-md-3 control-label">업무분야</span>
                                <div class="col-xs-12 col-sm-9 col-md-9"> {@ inv}
                                    <label class="checkbox-inline">
                                        <input type="checkbox" name="interr" value="{.id}" {? .checked}checked='checked'{/}>
                                        {._value}</label>
                                    {/} </div>
                            </div>
                            <!-- /form-group-->
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">업무역량</div>
                                <div class="col-xs-12 col-sm-9 col-md-9"> 
                                    <!-- /well --> 
                                    {? res_sk}{@ res_sk}
                                    <p class="form-group-tag" id="add_sk_{.key_+1}">
                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                        <input type="text" class="form-control suggest_job" name="skill_{.key_+1}" value="{._value}" placeholder="업무관련기술을 하나씩 입력해주세요. 예) 워드 / 엑셀 / 포토샵" onkeydown="return ignoreEnter(event);">
                                    </p>
                                    {/}{:}
                                    <p class="form-group-tag" id="add_sk_1">
                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                        <input type="text" class="form-control suggest_job" id="feeds_contents" name="skill_1" placeholder="업무관련기술을 하나씩 입력해주세요. 예) 워드 / 엑셀 / 포토샵" onkeydown="return ignoreEnter(event);">
                                    </p>
                                    {/} 
                                    <!-- /well --> 
                                    <span class="help-block">업무와 관련된 기술/경험을 등록해주세요.. 예) HTML5, Jqery 등</span>
                                    <button type="button" class="btn btn-default btn-sm" onclick="add_sk(this); return false;"><span class="icon-plus"></span> 업무역량  추가</button>
                                </div>
                            </div>
                            <!-- /form-group-->

                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">홈페이지</div>
                                <div class="col-xs-12 col-sm-9 col-md-9">
                                    <input type="text" class="form-control" name="homepage" id="homepage" value="{res.homepage}" />
                                </div>
                            </div>
                            <!-- /form-group -->

                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">블로그</div>
                                <div class="col-xs-12 col-sm-9 col-md-9">
                                    <input type="text" class="form-control" name="blog" id="blog" value="{res.blog}" />
                                </div>
                            </div>
                            <!-- /form-group -->

                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">링크드인</div>
                                <div class="col-xs-12 col-sm-9 col-md-9">
                                    <input type="text" class="form-control" name="linkedin" id="linkedin" value="{res.linkedin}" />
                                </div>
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">관심지역</div>
                                <div class="col-xs-12 col-sm-9 col-md-9"> {@ local}
                                    <label class="checkbox-inline">
                                        <input type="checkbox" name="locall" value="{.id}" {? .checked}checked='checked'{/}>
                                        {._value}</label>
                                    {/} </div>
                                <!-- /control-input --> 
                            </div>
                            <!-- /form-group --> 
                            {/}
                            
                            {? res.utype ==2}
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">투자 분야</div>
                                <div class="col-xs-12 col-sm-9 col-md-9"> 
                                    <!-- /well --> 
                                    {? res_in}{@ res_in}
                                    <p class="form-group-tag" id="add_sk_{.key_+1}">
                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                        <input type="text" class="form-control suggest_job" name="field_{.key_+1}" value="{._value}" placeholder="" onkeydown="return ignoreEnter(event);">
                                    </p>
                                    {/}{:}
                                    <p class="form-group-tag" id="add_sk_1">
                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                        <input type="text" class="form-control suggest_job" id="feeds_contents" name="field_1" placeholder="" onkeydown="return ignoreEnter(event);">
                                    </p>
                                    {/} 
                                    <!-- /well -->
                                    <button type="button" class="btn btn-default btn-sm" onclick="add_fl_i(this); return false;"><span class="icon-plus"></span> 추가 하기</button>
                                </div>
                            </div>
                            <!-- /form-group-->
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">투자 역량</div>
                                <div class="col-xs-12 col-sm-9 col-md-9"> 
                                    <!-- /well --> 
                                    {? res_sk}{@ res_sk}
                                    <p class="form-group-tag" id="add_sk_{.key_+1}">
                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                        <input type="text" class="form-control suggest_job" name="skill_{.key_+1}" value="{._value}" placeholder="" onkeydown="return ignoreEnter(event);">
                                    </p>
                                    {/}{:}
                                    <p class="form-group-tag" id="add_sk_1">
                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                        <input type="text" class="form-control suggest_job" id="feeds_contents" name="skill_1" placeholder="" onkeydown="return ignoreEnter(event);">
                                    </p>
                                    {/} 
                                    <!-- /well -->
                                    <button type="button" class="btn btn-default btn-sm" onclick="add_sk_i(this); return false;"><span class="icon-plus"></span> 추가 하기</button>
                                </div>
                            </div>
                            <!-- /form-group-->
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">관심 시장</div>
                                <div class="col-xs-12 col-sm-9 col-md-9"> 
                                    <!-- /well --> 
                                    {? res_mk}{@ res_mk}
                                    <p class="form-group-tag" id="add_sk_{.key_+1}">
                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                        <input type="text" class="form-control suggest_market" name="market_{.key_+1}" value="{._value}" placeholder="" onkeydown="return ignoreEnter(event);">
                                    </p>
                                    {/}{:}
                                    <p class="form-group-tag" id="add_sk_1">
                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                        <input type="text" class="form-control suggest_market" id="feeds_contents" name="market_1" placeholder="" onkeydown="return ignoreEnter(event);">
                                    </p>
                                    {/} 
                                    <!-- /well -->
                                    <button type="button" class="btn btn-default btn-sm" onclick="add_mk_i(this); return false;"><span class="icon-plus"></span> 추가 하기</button>
                                </div>
                            </div>
                            <!-- /form-group--> 
                            {/}
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">SNS</div>
                                <div class="col-xs-12 col-sm-9 col-md-9">
                                    <p class="input-group"> <span class="input-group-addon" ><span class="icon-twitter"></span>&nbsp; Twitter</span>
                                        <input type="text" placeholder="옆의 버튼을 눌러 연동해주세요" class="form-control" name="tw_ids" value="{tw.ids}" readonly>
                                        <span class="input-group-btn">
                                        <button class="btn btn-default" type="button" data-toggle="tooltip" title="연동하기" onclick="tw_connect(); return false;"><span class="icon-signin"></span></button>
                                        </span> </p>
                                    <!-- /input-group -->
                                    <div class="input-group"> <span class="input-group-addon"><span class="icon-facebook"></span>&nbsp; Facebook</span>
                                        <input type="text" placeholder="옆의 버튼을 눌러 연동해주세요" class="form-control" name="fb_ids" value="{fb.ids}" readonly>
                                        <span class="input-group-btn">
                                        <button class="btn btn-default" type="button" data-toggle="tooltip" title="연동하기" onclick="fb_connect(); return false;"><span class="icon-signin"></span></button>
                                        </span> </div>
                                    <!-- /input-group --> 
                                </div>
                                <!-- /control-input --> 
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">메일주소</div>
                                <div class="col-xs-12 col-sm-9 col-md-9">
                                    <input type="email" class="form-control" placeholder="myemailID@email.com" name="email" value="{res.email}" onkeydown="return ignoreEnter(event);">
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="email_rec" value="1" {?res.email_rec == "1"}checked{/} id="optionsRadioEmail-yes">
                                            메일을 받습니다. </label>
                                    </div>
                                    <!-- /radio -->
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="email_rec" value="0" {?res.email_rec == "0"}checked{/} id="optionsRadioEmail-no">
                                            메일을 받지 않습니다. </label>
                                    </div>
                                    <!-- /radio --> 
                                </div>
                                <!-- /control-input --> 
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">연락처</div>
                                <div class="col-xs-12 col-sm-9 col-md-9">
                                    <input type="tel" class="form-control" placeholder="010-1234-5678" name="tel" value="{res.tel}" onkeydown="return ignoreEnter(event);" onKeyup="onlyNumber(this);">
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="sms_rec" value="1" {?res.sms_rec == "1"}checked{/} id="optionsRadioSms-yes" >
                                            SMS를 받습니다. </label>
                                    </div>
                                    <!-- /radio -->
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="sms_rec" value="0" {?res.sms_rec == "0"}checked{/} id="optionsRadioSms-no" >
                                            SMS를 받지 않습니다. </label>
                                    </div>
                                    <!-- /radio --> 
                                </div>
                                <!-- /control-input --> 
                            </div>
                            <!-- /form-group -->

                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">활동 비공개</div>
                                <div class="col-xs-12 col-sm-9 col-md-9"> 
                                    <label class="checkbox-inline">
                                        <input type="checkbox" name="public_act1" value="1" {? (res.public_act & 1) == 1}checked="checked"{/}> 최근활동 탭 비공개
                                    </label>
                                    <label class="checkbox-inline">
                                        <input type="checkbox" name="public_act2" value="2" {? (res.public_act & 2) == 2}checked="checked"{/}> 개별 활동 비공개
                                    </label>
                                </div>
                                <!-- /control-input --> 
                            </div>
                            <!-- /form-group -->

                            <div class="form-actions">
                                <div class="col-xs-12 col-sm-offset-3 col-sm-9 col-md-offset-3 col-md-9"> 
                                    <a href="javascript:window.location.reload();" class="btn btn-default" >취소</a> <a href="#" class="btn btn-primary" onclick="submit_edit(); return false;">확인</a>
                                    <button class="btn btn-default btn-sm pull-right" data-toggle="collapse" data-target="#leaving">회원 탈퇴하기</button>
                                </div>
                            </div>
                        </fieldset>
                    </form>
                </div>
                <!-- /modifyProfile -->
                
                <div class="deleteProfile">
                    <div id="leaving" class="collapse">
                        <div class="row">
                            <div class="col-xs-12 col-sm-3 col-md-3 text-right"><strong>회원 탈퇴안내</strong></div>
                            <div class="col-xs-12 col-sm-8 col-md-8">
                                <div class="alert alert-danger"> D.CAMP 회원 탈퇴를 하게 되면 장소이용을 포함하여 회원으로 누릴 수 있는 모든 혜택을 지원받지 못하게 됩니다. <br>
                                    또한 멤버십에 가입되어 있는 경우 기존 멤버십과 연동되어 있는 개인 및 회사, 포트폴리오 정보가 삭제되고 동일한 ID로 재가입 할 수 없습니다. <br>
                                    삭제된 정보는 복구가 불가능합니다. 이점 유의하시기 바랍니다. </div>
                                <p> 회원 탈퇴를 계속 진행하려면 아래 탈퇴 버튼을 눌러주세요. </p>
                                <button class="btn btn-danger" onclick="javascript:document.location.href='/regist/signout/'">회원 탈퇴하기</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- / deleteProfile --> 
                
            </div>
            <!-- /content --> 


<!-- modal #searchStartup -->
<div class="modal fade" id="md-searchStartup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"> </div>
<!-- /modal #searchStartup --> 

<!-- modal #md-changePassword -->
<div class="modal fade" id="md-changePassword" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3 class="modal-title"><span class="icon-lock"></span> <span class="break"></span> 비밀번호 수정</h3>
            </div>
            <!-- /modal-header -->
            <div class="modal-body">
                <form class="form-horizontal" role="form" name="edit_pwd_form">
                    <div class="form-group">
                        <label for="" class="col-sm-3 col-md-3 control-label">현재 비밀번호</label>
                        <div class="col-xs-12 col-sm-8 col-md-8 ">
                            <input type="password" class="form-control" placeholder=" " name="c_pwd">
                        </div>
                    </div>
                    <!-- / form-group -->
                    
                    <div class="form-group">
                        <label for="" class="col-sm-3 col-md-3 control-label">새 비밀번호 입력</label>
                        <div class="col-xs-12 col-sm-8 col-md-8">
                            <div class="input-group"> <span class="input-group-addon"><span class="icon-lock"></span></span>
                                <input type="password" placeholder="New Password" class="form-control" name="pwd">
                            </div>
                        </div>
                    </div>
                    <!-- / form-group -->
                    
                    <div class="form-group">
                        <label for="" class="col-sm-3 col-md-3 control-label">새 비밀번호 확인</label>
                        <div class="col-xs-12 col-sm-8 col-md-8">
                            <div class="input-group"> <span class="input-group-addon"><span class="icon-lock"></span></span>
                                <input type="password" placeholder="New Password Check" class="form-control" name="pwd2">
                            </div>
                        </div>
                    </div>
                    <!-- / form-group -->
                </form>
                <p id='pwd_er' class="text-danger"></p>
            </div>
            <!-- /modal-body -->
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" onclick="submit_edit_pwd(); return false;">확인</button>
            </div>
            <!-- /modal-footer --> 
        </div>
        <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 
</div>
<!-- /modal #md-changePassword --> 

<script type="text/javascript">
//<![CDATA[

{? job}
$( ".suggest_job" ).autocomplete({source: {job}}, {
    matchContains: true,
    minChars: 0,
    width: 172,
    max: 10,
    multiple: false,
    scroll: true,
    scrollHeight: 300,
    formatItem: function(item){ 
        return item._value; 
    }
});
{/}
    
{? skill}
$( ".suggest_skill" ).autocomplete({source: {skill}}, {
    matchContains: true,
    minChars: 0,
    width: 172,
    max: 10,
    multiple: false,
    scroll: true,
    scrollHeight: 300,
    formatItem: function(item){ 
        return item._value; 
    }
});
{/}

{? market}
$( ".suggest_market" ).autocomplete({source: {market}}, {
    matchContains: true,
    minChars: 0,
    width: 172,
    max: 10,
    multiple: false,
    scroll: true,
    scrollHeight: 300,
    formatItem: function(item){ 
        return item._value; 
    }
});
{/}  

$( "#edit_btn_pwd" ).click(function(e){
    // console.log($(this).attr("id"));
    // console.log(e.keyCode);
    // if (e.keyCode == 13){ 
    //     console.log(111);
    // }
    // else {
    //     console.log(222);
    // }
    if ($(this).attr("id") === "edit_btn_pwd") {
        var _val = $('#md-changePassword').css('display');

        if (_val === 'none') {
            $('#md-changePassword').modal('show');
        } else {
            // $('#md-changePassword').modal('hide');
        }
    }
})

{*function edit_pwd(_this){
    console.log($(_this).attr("id"));
    if ($(_this).attr("id") === "edit_btn_pwd") {
        var _val = $('#md-changePassword').css('display');

        if (_val === 'none') {
            $('#md-changePassword').modal('show');
        } else {
            $('#md-changePassword').modal('hide');
        }
    }
}*}

function fb_connect(){
    var popUrl = '/fb/?next=/member/edit&id={res.id}';	//팝업창에 출력될 페이지 URL
    var popOption = "width=1000, height=600, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
            window.open(popUrl,"",popOption);
}

function recive_fb_info(_ids, _err) {
    if (!_err)
        $('input[name=fb_ids]').val(_ids);
    else 
        alert('이미 연동된 페이스북 계정입니다.');
}

function tw_connect(){
    var popUrl = '/twitter/?next=/member/edit&id={res.id}';	//팝업창에 출력될 페이지 URL
    var popOption = "width=1000, height=600, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
            window.open(popUrl,"",popOption);
}

function recive_tw_info(_ids, _err) {
    if (!_err)
        $('input[name=tw_ids]').val(_ids);
    else {
        alert('이미 연동된 트위터 계정입니다.');
    }
        
}

function submit_edit(){
    if ($('input[name=email]').val().length < 1) {
        alert("이메일을 입력해주세요.");
        return false;
    }
    
    if ($('input[name=birth]').val().length < 1) {
        alert("생년월일을 입력해주세요.");
        return false;
    }
    
    if ($('input[name=gender]:radio:checked').length == 0) {
        alert("성별을 선택해주세요.");
        return false;
    }

    var siteset="";
    var c_length = $('input[name=locall]').length;

    for(var i=0; i < c_length; i++){
        if(document.edit_form.locall[i].checked) {
            siteset +=document.edit_form.locall[i].value + ","
        }
    }

    var siteset2="";
    var c_length2 = $('input[name=interr]').length;

    for(var j=0; j < c_length2; j++){
        if(document.edit_form.interr[j].checked) {
            siteset2 +=document.edit_form.interr[j].value + ","
        }
    }
    
    var frm = $('form[name=edit_form]');
    var temp = '<input type="hidden" name="local" value="'+siteset.substring(0, siteset.length-1)+'" />';
    var temp2 = '<input type="hidden" name="inter_" value="'+siteset2.substring(0, siteset2.length-1)+'" />';
    frm.append(temp);
    frm.append(temp2);
    document.edit_form.submit();
}

function submit_edit_pwd() {
    $('#pwd_er').html('');
    if ($('input[name=c_pwd]').val().length < 1) {
        $('#pwd_er').html("현재 비밀번호를 입력해주세요.");
        return false;
    }
    
    if ($('input[name=pwd]').val().length < 1 || $('input[name=pwd2]').val().length < 1) {
        $('#pwd_er').html("새 비밀번호를 입력해주세요.");
        return false;
    }
    
    if ($('input[name=pwd]').val() !== $('input[name=pwd2]').val()) {
        $('#pwd_er').html("새 비밀번호를 한 번 더 확인해주세요.");
        return false;
    }
    
{*    if ($('input[name=c_pwd]').val() === $('input[name=pwd]').val()) {
        $('#pwd_er').html("새 비밀번호와 현재 비밀번호가 동일합니다. 변경해주세요.");
        return false;
    }*}
    
    var get_url = '/ajax_front/member_edit_pwd/';
    var frm = $('form[name=edit_pwd_form]');
    var set_data = frm.serialize();;
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            if (_data.res === 404) {
                $('#pwd_er').html("사용자 정보가 일치하지 않습니다.");
            } else if (_data.res === 9) {
                $('#pwd_er').html("현재 비밀번호가 일치하지 않습니다.");
            } else {
                
                $('input[name=c_pwd]').val();
                $('input[name=pwd]').val();
                $('input[name=pwd2]').val();
                $(".modal").modal("hide");
                alert("비밀번호가 변경되었습니다.");
            }
        }
    });
}

function find_com(){

    var key = $('input[name=company]').val();
    var get_url = '/ajax_front/get_search_startup2/';
    var set_data ={
        "data" 		: key,
        "v" 		: 1,
    };
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {

            $('#md-searchStartup').html(_data);

        }
    });
}

function recive_com(_val){
    $('input[name=company]').val(_val);
    $('#md-searchStartup').modal('hide');
}

function enter_startup(){
    $('#md-compEditor_com').val($('#new_startup').val());
    $('#md-compEditor').modal('show');
}

function st_submit() {

    var get_url = '/ajax_front/add_startup/';
    var frm = $('form[name=add_st_form]');
    var set_data = frm.serialize();;
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            $('input[name=company]').val($('#md-compEditor_com').val());
            $('.modal').modal('hide');
        }
    });
}

function del_box(_this)
{
    $(_this).parent().remove();
}

function add_sk(_this)
{   
    var v = $("#cnt_sk").val();
    var get_url = "/ajax_front/member_add_s";
    var set_data ={
        "data": parseInt(v)+1,
    };
    
    $.post(get_url, set_data,function(_data) {
        $(_this).before(_data);
        $("#cnt_sk").val(parseInt(v)+1);
        {? skill}
        $( ".suggest_skill" ).autocomplete({source: {skill}}, {
            matchContains: true,
            minChars: 0,
            width: 172,
            max: 10,
            multiple: false,
            scroll: true,
            scrollHeight: 300,
            formatItem: function(item){ 
                return item._value; 
            }
        });
        {/}
    });
}

function add_fl_i(_this)
{   
    var v = $("#cnt_fl_i").val();
    var get_url = "/ajax_front/member_add_s/fl";
    var set_data ={
        "data": parseInt(v)+1,
    };
    
    $.post(get_url, set_data,function(_data) {
        $(_this).before(_data);
        $("#cnt_fl_i").val(parseInt(v)+1);
        {? job}
        $( ".suggest_job" ).autocomplete({source: {job}}, {
            matchContains: true,
            minChars: 0,
            width: 172,
            max: 10,
            multiple: false,
            scroll: true,
            scrollHeight: 300,
            formatItem: function(item){ 
                return item._value; 
            }
        });
        {/}
    });
}

function add_sk_i(_this)
{   
    var v = $("#cnt_sk_i").val();
    var get_url = "/ajax_front/member_add_s/st";
    var set_data ={
        "data": parseInt(v)+1,
    };
    
    $.post(get_url, set_data,function(_data) {
        $(_this).before(_data);
        $("#cnt_sk_i").val(parseInt(v)+1);
        {? job}
        $( ".suggest_job" ).autocomplete({source: {job}}, {
            matchContains: true,
            minChars: 0,
            width: 172,
            max: 10,
            multiple: false,
            scroll: true,
            scrollHeight: 300,
            formatItem: function(item){ 
                return item._value; 
            }
        });
        {/}
    });
}

function add_mk_i(_this)
{   
    var v = $("#cnt_mk_i").val();
    var get_url = "/ajax_front/member_add_s/mk";
    var set_data ={
        "data": parseInt(v)+1,
    };
    
    $.post(get_url, set_data,function(_data) {
        $(_this).before(_data);
        $("#cnt_mk_i").val(parseInt(v)+1);
        {? skill}
        $( ".suggest_market" ).autocomplete({source: {market}}, {
            matchContains: true,
            minChars: 0,
            width: 172,
            max: 10,
            multiple: false,
            scroll: true,
            scrollHeight: 300,
            formatItem: function(item){ 
                return item._value; 
            }
        });
        {/}
    });
}

//]]>
</script>