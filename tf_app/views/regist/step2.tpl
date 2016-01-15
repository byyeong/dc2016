<!-- content -->
<div id="regist-member" class="content"> 
    <div class="row">
        <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-8 col-md-offset-2"> 
        
         
            <!-- header -->
            <div class="header">
                <h1><a href="/"><img src="/img/logo.png" alt="D.CAMP"></a> <small>회원가입</small></h1>
            </div>
            <!-- /header --> 
             
            <!-- panel -->
            <div class="panel panel-default">
                <div class="panel-body guide-wrap"> 
                     아래 정보는프로필 페이지를 만들기 위해 필요한 기본정보입니다. <br>
                    D.CAMP 회원가입은 아래정보를 입력하지 않아도 가입 가능합니다. 
                    멤버십 가입을 하기 위해서는 아래 정보가 반드시 입력되어야 합니다. 
                     
                </div>
                <form class="form-horizontal" role="form" name="regist_f_st2" action="/regist/step3" method="post">
                    <input type="hidden" name="id" value="{id}" />
                    
                    <fieldset>
                        <div class="panel-body regist-input">
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">자기소개</div>
                                <div class="col-sm-8 col-md-9 control-input">
                                    <textarea row="3" id="inputSelfintroduce" class="form-control" name="bio"></textarea>
                                </div>
                                <!-- /control-input --> 
                            </div>
                            <!-- /form-group -->
                        {? utype == 1}
                            <input type="hidden" name="cnt_sk" id="cnt_sk" value="1" />

                            <div class="form-group"> 
                                <span class="col-lg-3 control-label">업무분야</span>
                                <div class="col-lg-8  control-input">
                                    {@ inv}
                                    <label class="checkbox-inline"><input type="checkbox" name="inter" value="{.id}">{._value}</label>
                                    {/}
                                </div>
                            </div>
                            <!-- /form-group-->
                            
                            <div class="form-group"> 
                                <span class="col-lg-3 control-label">업무 관련 기술</span>
                                <div class="col-lg-8  control-input">
                                    <!-- /well --> 
                                    <p class="form-group-tag" id="add_sk_1">
                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                        <input type="text" class="form-control suggest_job" name="skill_1" placeholder="업무 관련 기술을 하나씩 입력해주세요.">
                                    </p>
                                    <!-- /well --> 
                                    <span class="help-block">업무와 관련된 기술/경험을 등록해주세요.. 예) HTML5, Jqery 등</span>
                                    <button type="button" class="btn btn-default btn-sm" onclick="add_sk(this); return false;"><span class="icon-plus"></span> 추가 하기 </button>
                                </div>
                            </div>
                            <!-- /form-group-->
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">관심지역</div>
                                <div class="col-sm-8 col-md-9 control-input">
                                    {@ local}
                                    <label class="checkbox-inline"><input type="checkbox" name="locall" value="{.id}">{._value}</label>
                                    {/}
                                </div>
                                <!-- /control-input --> 
                            </div>
                            <!-- /form-group -->
                        {/}
                        {? utype == 2}
                        
                            <input type="hidden" name="cnt_fl_i" id="cnt_fl_i" value="1" />
                            <input type="hidden" name="cnt_sk_i" id="cnt_sk_i" value="1" />
                            <input type="hidden" name="cnt_mk_i" id="cnt_mk_i" value="1" />
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">투자 분야</div>
                                <div class="col-sm-8 col-md-9 control-input">

                                    <!-- /well --> 
                                    <p class="form-group-tag" id="add_field_1">
                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                        <input type="text" class="form-control suggest_job" name="field_1" placeholder="">
                                    </p>
                                    <!-- /well --> 
                                    <button type="button" class="btn btn-default btn-sm" onclick="add_fl_i(this); return false;"><span class="icon-plus"></span> 추가 하기 </button>

                                </div>
                                <!-- /control-input --> 
                            </div>
                            <!-- /form-group -->

                            <div class="form-group"> 
                                <span class="col-lg-3 control-label">투자 역량</span>
                                <div class="col-lg-9  control-input">
                                    <!-- /well --> 
                                    <p class="form-group-tag" id="add_sk_1">
                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                        <input type="text" class="form-control suggest_job" name="skill_1" placeholder="">
                                    </p>
                                    <!-- /well --> 
                                    <button type="button" class="btn btn-default btn-sm" onclick="add_sk_i(this); return false;"><span class="icon-plus"></span> 추가 하기 </button>
                                </div>
                            </div>
                            <!-- /form-group-->
                            
                            <div class="form-group"> 
                                <span class="col-lg-3 control-label">관심 시장</span>
                                <div class="col-lg-9  control-input">
                                    <!-- /well --> 
                                    <p class="form-group-tag" id="add_market_1">
                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                        <input type="text" class="form-control suggest_market" name="market_1" placeholder="">
                                    </p>
                                    <!-- /well --> 
                                    <button type="button" class="btn btn-default btn-sm" onclick="add_mk_i(this); return false;"><span class="icon-plus"></span> 추가 하기 </button>
                                </div>
                            </div>
                            <!-- /form-group-->
                            
                        {/}
                            
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">SNS</div>
                                <div class="col-sm-8 col-md-9 control-input ">
                                    <p class="input-group"> <span class="input-group-addon"><span class="icon-twitter"></span>&nbsp; Twitter</span>
                                        <input type="text" placeholder="mytwitterID" class="form-control" name="twitter" readonly>
                                        <span class="input-group-btn">
                                            <button id="btn_tw" class="btn btn-default" type="button" data-toggle="tooltip" title="연동하기" onclick="tw_connect(); return false;"><span class="icon-signin"></span></button>
                                        </span> 
                                    </p>
                                    <p id="error_tw" style="display: none;">이미 등록된 계정입니다.</p>
                                    <!-- /input-group -->
                                    <div class="input-group"> <span class="input-group-addon"><span class="icon-facebook"></span>&nbsp; Facebook</span>
                                        <input type="text" placeholder="myfacebookID" class="form-control" name="facebook" value="{fb_ids}" readonly>
                                        <span class="input-group-btn">
                                            <button id="btn_fb" class="btn btn-default" type="button" data-toggle="tooltip" title="연동하기" onclick="fb_connect(); return false;" {? fb_ids}disabled{/}><span class="icon-signin"></span></button>
                                        </span> 
                                    </div>
                                     <!-- /input-group -->
                                     <p id="error_fb" style="display: none;">이미 등록된 계정입니다.</p>
                                </div>
                                <!-- /control-input --> 
                            </div>
                            <!-- /form-group -->
                            
                            <!--
                            <div class="form-group">
                                <div class="col-lg-3 control-label">메일주소</div>
                                <div class="col-lg-8 control-input">
                                    <input type="email" class="form-control" placeholder="myemailID@email.com" name="email">
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="email_rec" id="optionsRadioEmail-yes" value="1" checked>
                                            메일을 받습니다. </label>
                                    </div>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="email_rec" id="optionsRadioEmail-no" value="0" >
                                            메일을 받지 않습니다. </label>
                                    </div>
                                </div>
                            </div>
                            //-->
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">연락처</div>
                                <div class="col-sm-8 col-md-9 control-input">
                                    <input type="tel" class="form-control" placeholder="010-1234-5678" name="tel" onKeyup="onlyNumber(this);">
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="sms_rec" id="optionsRadioSms-yes" value="1" checked>
                                            SMS를 받습니다. </label>
                                    </div>
                                    <!-- /radio -->
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="sms_rec" id="optionsRadioSms-no" value="1" >
                                            SMS를 받지 않습니다. </label>
                                    </div>
                                    <!-- /radio --> 
                                </div>
                                <!-- /control-input --> 
                            </div>
                            <!-- /form-group --> 
                            
                        </div>
                        <!-- /panel-body -->
                        
                        <div class="panel-footer">
                            <div class="col-sm-offset-4 col-md-offset-3">
                                <a href="#" class="btn btn-primary" onclick="submit_st2(); return false;">등록하기</a> &nbsp;
                                <a href="#" class="btn btn-default" onclick="submit_st2(); return false;">나중에 입력하기</a>
                            </div>
                        </div>
                        <!-- /panel-footer -->
                    </fieldset>
                </form>
            </div>
            <!-- /panel --> 
            
             
        </div>
    </div>
</div>
<!-- /container-->

<!-- modal #searchStartup -->
<div class="modal fade" id="md-searchStartup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    
</div>
<!-- /modal #searchStartup -->

<script type="text/javascript">
//<![CDAT

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
function submit_st2(){
    var siteset="";
    var c_length = $('input[name=locall]').length;

    for(var i=0; i < c_length; i++){
        if(document.regist_f_st2.locall[i].checked) {
            siteset +=document.regist_f_st2.locall[i].value + ","
        }
    }
    var frm = $('form[name=regist_f_st2]');
    var temp = '<input type="hidden" name="local" value="'+siteset.substring(0, siteset.length-1)+'" />';

    var siteset2="";
    var c_length2 = $('input[name=inter]').length;

    for(var j=0; j < c_length2; j++){
        if(document.regist_f_st2.inter[j].checked) {
            siteset2 +=document.regist_f_st2.inter[j].value + ","
        }
    }
    var frm = $('form[name=regist_f_st2]');
    var temp = '<input type="hidden" name="local" value="'+siteset.substring(0, siteset.length-1)+'" />';
    var temp2 = '<input type="hidden" name="inter_" value="'+siteset2.substring(0, siteset2.length-1)+'" />';
    frm.append(temp);
    frm.append(temp2);
    document.regist_f_st2.submit();
}

function tw_connect(){
    var popUrl = '/twitter/?id={id}';	//팝업창에 출력될 페이지 URL
    var popOption = "width=1000, height=600, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
            window.open(popUrl,"",popOption);
}

function recive_tw_info(_ids) {
    $('#error_tw').slideUp();
    $('input[name=twitter]').val(_ids);
    $('#btn_tw').attr('disabled', 'disabled');
}

function fb_connect(){
    var popUrl = '/fb/?next=/regist/step2&id={id}';	//팝업창에 출력될 페이지 URL
    var popOption = "width=1000, height=600, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
            window.open(popUrl,"",popOption);
}

function recive_fb_info(_ids) {
    $('#error_fb').slideUp();
    $('input[name=facebook]').val(_ids);
    $('#btn_fb').attr('disabled', 'disabled');
}

function error(_type)
{
    if (_type === 'fb')
        $('#error_fb').slideDown();
    else if (_type === 'tw')
        $('#error_tw').slideDown();
}

function find_com(){
    var key = $('input[name=company]').val();
    var get_url = '/ajax_front/get_search_company/';
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

function recive_com(_v, _val){
    $('input[name=company]').val(_val);
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

function add_int(_this)
{   
    var v = $("#cnt_int").val();
    var get_url = "/ajax_front/member_add_i";
    var set_data ={
        "data": parseInt(v)+1,
    };
    
    $.post(get_url, set_data,function(_data) {
        $(_this).before(_data);
        $("#cnt_int").val(parseInt(v)+1);
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
    });
}
//]]>
</script> 