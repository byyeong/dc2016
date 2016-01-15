<script>
  $(function() {
    $(".datepicker").datepicker({ dateFormat: 'yy.mm.dd',  viewMode: 2 });
  });
</script>
    <div class="modal-dialog" style="width: 850px">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3 class="modal-title"><span class="icon-building"></span> <span class="break"></span> 이벤트 참여를 위해 프로필을 가득 채워주세요!</h3>
            </div>
            <!-- /modal-header -->
            <div class="modal-body">
                <form class="form-horizontal" role="form" method="post" name="edit_form" action="/member/edit" onsubmit="return false;">
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
                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">아이디</div>
                            <div class="col-xs-12 col-sm-9 col-md-9">
                                <p class="form-control-static">{res.ids}</p>
                            </div>
                        </div>
                        <!-- /form-group -->

                        <div class="form-group">
                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">이름</div>
                            <div class="col-xs-12 col-sm-9 col-md-9">
                                <p class="form-control-static">{res.name}</p>
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
                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">업무관련기술</div>
                            <div class="col-xs-12 col-sm-9 col-md-9"> 
                                <!-- /well --> 
                                <span class="help-block">업무와 관련된 기술/경험을 등록해주세요.. 예) HTML5, Jqery 등</span>
                                {? res_sk}{@ res_sk}
                                <p class="form-group-tag input_sk" id="add_sk_{.key_+1}">
                                    <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                    <input type="text" class="form-control suggest_job" name="skill_{.key_+1}" value="{._value}" placeholder="업무관련기술을 하나씩 입력해주세요. 예) 워드 / 엑셀 / 포토샵" onkeydown="return ignoreEnter(event);">
                                </p>
                                {/}{:}
                                <p class="form-group-tag input_sk" id="add_sk_1">
                                    <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                    <input type="text" class="form-control suggest_job" id="feeds_contents" name="skill_1" placeholder="업무관련기술을 하나씩 입력해주세요. 예) 워드 / 엑셀 / 포토샵" onkeydown="return ignoreEnter(event);">
                                </p>
                                {/} 
                                <!-- /well --> 
                                
                                <button type="button" class="btn btn-default btn-sm" onclick="add_sk(this); return false;"><span class="icon-plus"></span> 업무역량  추가</button>
                            </div>
                        </div>
                        <!-- /form-group-->
                        
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">관심지역</div>
                            <div class="col-xs-12 col-sm-9 col-md-9"> 
                                {@ local}
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

                    </fieldset>
                </form>
            </div>
            <!-- /modal-body -->

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" onclick="submit_edit(); return false;">이벤트 신청하기</button>
            </div>
            <!-- /modal-footer --> 
        </div>
        <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 

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