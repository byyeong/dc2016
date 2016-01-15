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
                     D.CAMP는 은행권청년창업재단이 운영하는 대한민국 최초의 복합 창업 생태계 허브입니다.<br>
                    예비 창업자와 스타트업, 투자자, 각종 지원 기관 등이 협업하고 교류하는 열린터를 지향합니다.   
                </div>
                
                <div class="panel-body regist-ex text-center">
                    <button class="btn btn-primary btn-lg" onclick="fb_connect(); return false;"><span class="icon-facebook"></span> &nbsp;  Facebook으로 회원가입</button> 
                    <p id="error_fb" style="display: none;">이미 등록된 페이스북 계정입니다.</p>
                </div>
                
                <form class="" role="form" name="regist_f_st1" action="/regist/step2" method="post">
                    <input type="hidden" name="secret" value="" />
                    <input type="hidden" name="fb_ids" value="" />
                    <input type="hidden" name="grade" value="1" />
                    <fieldset>
                        <div class="panel-body  form-horizontal regist-input">
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">개인정보보호방침 </div>
                                <div class="col-sm-8 col-md-9">
                                    <label class="checkbox-inline"><input type="checkbox" id="policy1"> 개인정보보호방침 에 동의합니다.</label>  &nbsp; 
                                    <a href="/policy_privacy" class="btn btn-default btn-xs">내용보기</a>                                 
                                </div>
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">서비스이용약관  </div>
                                <div class="col-sm-8 col-md-9 ">                                    
                                    <label class="checkbox-inline"><input type="checkbox" id="policy2"> 서비스이용약관 에 동의합니다.</label> &nbsp;   
                                    <a href="/policy_service" class="btn btn-default btn-xs">내용보기</a>                                
                                </div>
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">회원 구분</div>
                                <div class="col-sm-8 col-md-9 ">
                                    <select class="selectpicker" name="utype">
                                        <option value="1">일반회원</option>
                                        <option value="2">투자자 / 창업지원 유관기관 구성원</option>
                                    </select>
                                </div>
                            </div>
                            <!-- /form-group --> 
                              
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">이름</div>
                                <div class="col-sm-8 col-md-9">
                                    <input type="text" class="form-control" placeholder="이름" name="name">
                                </div>
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">아이디</div>
                                <div class="col-sm-8 col-md-9">
                                    <input type="text" class="form-control" style='ime-mode:disabled' placeholder="아이디" name="ids" onblur="check_ids(this); return false;" onkeyup="setNumHyp(this); return false;">
                                    
                                    <div class="alert alert-dismissable" style="display: none;">
                                        <p class="text-danger"><span class="icon-warning-sign"></span> 사용할 수 없는 아이디입니다. 아이디는 영문, 숫자와 언더바(_)만 사용할 수 있습니다.</p>
                                    </div>
                                    
                                </div>
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">비밀번호</div>
                                <div class="col-sm-8 col-md-9">
                                    <input type="password" class="form-control" placeholder="비밀번호" name="pwd">
                                </div>
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">비밀번호 확인</div>
                                <div class="col-sm-8 col-md-9">
                                    <input type="password" class="form-control" placeholder="비밀번호 재입력"  name="pwd2">
                                    
                                </div>
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">이메일 주소</div>
                                <div class="col-sm-8 col-md-9">
                                    <input type="email" class="form-control" placeholder="이메일 주소"  name="email" onblur="check_email(this); return false;" value="{e}">
                                    
                                    <div class="alert alert-dismissable" style="display: none;">
                                        <p class="text-danger"><span class="icon-warning-sign"></span> 이미 입력된 이메일 주소입니다. 다른 이메일 주소를 입력해주세요.</p>
                                    </div>
                                    
                                    <span class="help-block">입력한 메일 주소로 회원가입을 위한 인증 메일을 발송합니다.</span>
                                </div>
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">생년월일</div>
                                <div class="col-sm-8 col-md-9">
                                    <div class="bfh-datepicker" data-format="y.m.d">
                                        <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                            <input type="text" class="form-control datepicker" name="birth" value="" readonly required="required">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">성별</div>
                                <div class="col-sm-8 col-md-9">
                                    <label class="radio-inline"><input type="radio" checked="checked" name="gender" value="1">남자</label>
                                    <label class="radio-inline"><input type="radio" name="gender" value="2">여자</label>
                                </div>
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">프로필이미지</div>
                                <div class="col-sm-8 col-md-9" id="reg_pic">
                                    <input type="hidden" name="img" id="img" value="" />
                                    <!--
                                    <iframe scrolling="no" height="160px" width="160px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img/160x160?old={=safe_js('/img/default-img-member.png')}" allowtransparency="true"></iframe>
                                    //-->
                                    <img class="img-thumbnail" src="/img/default-img-member.png" id="img_img" onclick="toggle_img();return false;">
                                </div>
                            </div>
                            <!-- /form-group --> 
                            
                            <div class="form-group">
                                <div id="div_img_change" style="display: none;">
                                    <iframe  height="500" frameborder="0" width="100%" scrolling="no" id="frm" allowTransparency="true" src="/ajax_front/form_file?which=img" ></iframe>
                                </div>
                            </div>

                        </div>
                        <!-- /form-group --> 
                        
                        <div class="panel-footer">
                            <div class="col-sm-offset-4 col-md-offset-3">
                                <a href="#" class="btn btn-primary" onclick="submit_st1(); return false;" id="submitBtn">다음단계</a>
                            </div>
                        </div>
                        <!-- /panel-body -->
                    </fieldset>
                </form>
            </div>
            <!-- /panel --> 
            
        </div>
    </div>
</div>
<!-- /content-->

<script type="text/javascript">
//<![CDAT
function setNumHyp(obj){
    $(obj).next().hide();
    val=obj.value;
    if ( val.match(/[^a-zA-Z0-9\_]/) != null ) {
        val_l = val.length;
        $(obj).val(val.substring(0, val_l-1));
        $(obj).next().show();
        return false;
    }
}

function check_ids(_this) {
    $(_this).next().hide();
    var _val = $(_this).val();
    var get_url = '/ajax_front/check_ids/'+_val;
    
    $.ajax({
        type : 'POST',
        url : get_url,
        dataType : 'json',
        success : function(_data) {
            if (_data.id) {
                $(_this).next().show();
                document.regist_f_st1.ids.focus();
                $('#submitBtn').attr('disabled', 'disabled');
            }
            else {
                $('#submitBtn').removeAttr('disabled');
            }
        }
    });
}

function check_email(_this) {
    if ($(_this).val().length < 1) 
        return false;
    $(_this).next().hide();
    var _val = $(_this).val();
    var get_url = '/ajax_front/check_email/'+_val;
    
    $.ajax({
        type : 'POST',
        url : get_url,
        dataType : 'json',
        success : function(_data) {
            if (_data.id) {
                $(_this).next().show();
                document.regist_f_st1.email.focus();
                $('#submitBtn').attr('disabled', 'disabled');
            }
            else {
                $('#submitBtn').removeAttr('disabled');
            }
        }
    });
}

function submit_st1(){

    if ($("input:checkbox[id='policy1']").is(":checked") !== true ) {
        alert("개인정보보호방침에 동의해주세요.");
        return false;
    }
    
    if ($("input:checkbox[id='policy2']").is(":checked") !== true ) {
        alert("서비스이용약관에 동의해주세요.");
        return false;
    }
    
    if (!$('input[name=name]').val()) {
        alert("이름을 입력해주세요.");
        document.regist_f_st1.name.focus();
        return false;
    }
    
    if (!$('input[name=ids]').val()) {
        alert("아이디를 입력해주세요.");
        document.regist_f_st1.ids.focus();
        return false;
    }
    
    if ($('input[name=pwd]').val() === '' || $('input[name=pwd]').val() === '') {
        alert("비밀번호를 한번 더 확인해주세요.");
        return false;
    }
    
    if ($('input[name=pwd]').val() !== $('input[name=pwd2]').val()) {
        alert("비밀번호를 한번 더 확인해주세요.");
        return false;
    }
    
    if (!$('input[name=email]').val()) {
        alert("메일주소를 입력해주세요.");
        document.regist_f_st1.email.focus();
        return false;
    }
    
    if (!$('input[name=birth]').val()) {
        alert("생년월일을 입력해주세요.");
        document.regist_f_st1.birth.focus();
        return false;
    }
    
    var _ids = $('input[name=ids]').val();
    var get_url = '/ajax_front/check_ids/'+_ids;
    $.ajax({
        type : 'POST',
        url : get_url,
        dataType : 'json',
        success : function(_data) {
            if (_data.id) {
                $('input[name=ids]').next().show();
                document.regist_f_st1.ids.focus();
                $('#submitBtn').attr('disabled', 'disabled');
                return false;
            }
        }
    });
    
    _ids = $('input[name=email]').val();
    get_url = '/ajax_front/check_email/'+_ids;
    $.ajax({
        type : 'POST',
        url : get_url,
        dataType : 'json',
        success : function(_data) {
            if (_data.id) {
                $('input[name=email]').next().show();
                document.regist_f_st1.email.focus();
                $('#submitBtn').attr('disabled', 'disabled');
                return false;
            }
        }
    });

    document.regist_f_st1.submit();
}

function fb_connect(){
    var popUrl = 'fb/?next=/regist';	//팝업창에 출력될 페이지 URL
    var popOption = "width=1000, height=600, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
            window.open(popUrl,"",popOption);
}

function recive_fb_info(_name, _email, _pic, _ids, _secret) {
    $('#error_fb').slideUp();
    $('input[name=fb_ids]').val(_ids);
    $('input[name=secret]').val(_secret);
    $('input[name=name]').val(_name);
    $('input[name=email]').val(_email);
    //var temp = '<iframe scrolling="no" height="160px" width="160px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img/160x160?old='+_pic+'" allowtransparency="true"></iframe>'
    //$('#photo_uploader').remove();
    $('#img_img').attr('src',_pic);
    $('#img').val(_pic);
}

function error()
{
    $('#error_fb').slideDown();
}
//]]>
</script> 