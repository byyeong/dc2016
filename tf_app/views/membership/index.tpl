<!-- rowContent -->
<div class="rowContent"  id="membership"> 
    
    <!-- page-header -->
    <div class="page-header">
        <div class="container">
            <h2>Membership</h2>
        </div>
    </div>
    <!-- /page-header --> 
     
    <!-- page-content -->
    <div class="page-content"> 
        <!-- container -->
        <div class="container"> 
            <div class="full-content">
                 
                <div class="membership-desc">
                    <h3><span class="icon-group"></span> 큰 꿈을 지닌 이들이 함께 모여 창업을 준비할 수 있는 열린 공간과 다양한 교육,행사 참여의 기회를 드립니다.</h3> 
                         
                    <!-- step -->
                    <div class="step desc">
                        <h4><span class="icon-hand-right"></span> 멤버십 가입절차 안내 </h4>
                        <div class="well">
                            <ul class="list-unstyled row">
                                <li class="col-xs-12 col-sm-12 col-md-2"><strong>Step 1.</strong> D.CAMP 가입</li> 
                                <li class="col-xs-12 col-sm-12 col-md-2"><strong>Step 2.</strong> 프로필 정보 입력</li> 
                                <li class="col-xs-12 col-sm-12 col-md-2"><strong>Step 3.</strong> 멤버십 가입 신청</li> 
                                <li class="col-xs-12 col-sm-12 col-md-2"><strong>Step 4.</strong> 멤버십 가입 진행</li> 
                                <li class="col-xs-12 col-sm-12 col-md-2"><strong>Step 5.</strong> 멤버십 가입 승인</li>
                            </ul>
                        </div>
                    </div>
                    <!-- /step -->  
                
                    <!-- support -->
                    <div class="support desc">
                        <h4><span class="icon-exclamation-sign"></span> 멤버십 혜택 안내 </h4>
                         <p>복합 창업 생태계 허브 D.CAMP는 예비 창업자와 스타트업에게 다양한 혜택과 지원을 준비해 놓고 있습니다.<br> D.CAMP 멤버십 가입을 하게 되면 아래와 같은 혜택이 주어지게 됩니다.</p>
                         <div class="well">
                            <ul>
                                <li>협업공간 사용(이용시간 : 월~금, 오전 10시~오후 10시)</li>
                                <li>각종 회의실 예약사용</li>
                                <li>회원 간 네트워크 기회 제공</li>
                                <li>재단 및 센터 주최 각종 행사의 우선 참여권</li>
                                <li>다양한 교육 및 멘토링, 컨설팅 기회 제공</li>
                                <li>활동상에 따라 재단의 투자 및 인큐베이팅 대상 선정 시 가산점</li>
                            </ul>
                            <span class="help-block">D.CAMP 방문시 가입 여부 확인 뒤 출입증(반납용) 지급</span>
                         </div>
                    </div>
                    <!-- /support -->  
                </div>                        
                        
                        
                {? s}
                <!-- editor -->
                <div class="editor">
                    <div class="edit-header">
                        <h3><span class="icon-edit"></span> 멤버십 신청하기 </h3>
                    </div>
                    <div class="edit-body">
                        {? res && res.state == 0}                                
                        <div class="complete">
                            <div class="alert alert-info">
                                <p><strong><span class="icon-smile"></span> Please!</strong> 이미 진행중인 멤버십 신청이 있습니다. 승인을 기다려주세요. ^^</p>
                                <small style="margin-top: 10px;">신청일자 : {=substr(str_replace("-",".",res.date_created), 0, 10)}</small>
                            </div>
                        </div>
                        {/} 
                        
                        {? res && res.state == 1}
                        <div class="complete">
                            <div class="alert alert-success">
                                <p><span class="icon-smile icon-large"></span> 현재 D.CAMP 멤버십 회원입니다. 다른 분들께도 많이 소개해주세요!</p>
                            </div>
                            <div data-send="false" data-show-faces="true" data-action="like" data-layout="standard" data-colorscheme="light" data-height="The pixel height of the plugin" data-width="The pixel width of the plugin" data-href="http://dcamp.kr/membership" class="fb-like"></div>
                        </div>
                        {/}
                        
                        {? res && res.state == 2}
                        <div class="complete">
                            <div class="alert alert-danger"><span class="icon-frown icon-large"></span> 멤버십 회원 승인이 반려되었습니다. 아래 내용을 확인하시고 다시 신청해주세요.</div>  
                            <div class="well">                                   
                                 {res.state_des} 
                                <p><small>신청일자 : {=substr(str_replace("-",".",res.date_created), 0, 10)} / 반려일자 : {=substr(str_replace("-",".",res.date_edited), 0, 10)}</small></p>
                                <div class="form-actions text-center"><button onclick="new_form(this); return false;" type="submit" class="btn btn-primary">멤버십 가입신청</button></div>
                            </div>
                        </div>
                        {/}                                 
                        
                        {? s.picture && s.email} 
                        <form name="mbs_form" action="/membership/complete" onsubmit="return false;" method="post" role="form" {? res}style="display: none;"{/}>
                            <fieldset>
                                <input type="hidden" name="id" value="{res.id}" />
                                <input type="hidden" name="state" value="0" />
                                <input type="hidden" name="user_id" value="{s.id}" />
                                <input type="hidden" name="cnt_com" value="1" />
                                <input type="hidden" name="cnt_rec" value="1" />
                            
                                <div class="form-group">
                                    <div class="control-label">D.CAMP 멤버십을 추천하신 분이나 추천기관을 알려주세요.</div>
                                    <div class="control-input">
                                        <label class="sr-only">추천인</label>
                                        <p class="input-group">
                                            <span class="input-group-addon"><span class="icon-fixed-width icon-user"></span></span>
                                            <input type="text" placeholder="추천인" class="form-control" name="recommended_1" onkeydown="return ignoreEnter(event);">
                                            <span class="input-group-btn">
                                                <button class="btn btn-default" type="button" data-toggle="modal" href="#md-searchUser" onclick="find_rec(1); return false;"><span class="icon-search"></span></button>
                                            </span> 
                                        </p>

                                         <label class="sr-only">추천기관</label>
                                        <p class="input-group">
                                            <span class="input-group-addon"><span class="icon-fixed-width icon-building"></span></span>
                                            <input type="text" placeholder="추천기관" class="form-control" name="company_1" onkeydown="return ignoreEnter(event);">
                                            <span class="input-group-btn">
                                                <button class="btn btn-default" type="button" data-toggle="modal" href="#md-searchStartup" onclick="find_com(1); return false;"><span class="icon-search"></span></button>
                                            </span> 
                                        </p>
                                    </div>
                                </div>
                                <!-- / form-group -->

                                <div class="form-group">
                                    <div class="control-label">창업 관련 활동 : 창업과 관련해서 어떤 활동을 하셨는지 알려주세요 <span class="text-danger">*</span> </div>
                                    <div class="control-input">
                                        <textarea placeholder="창업과 관련해서 어떤 활동을 하셨는지 알려주세요" rows="3" class="form-control" name="act"></textarea>
                                    </div>
                                </div>
                                <!-- / form-group -->

                                <div class="form-group">
                                    <div class="control-label">기타경력 : 알리고 싶은 다른 경력도 알려주세요 <span class="text-danger">*</span></div>
                                    <div class="control-input">
                                        <textarea placeholder="알리고 싶은 다른 경력도 알려주세요" rows="3" class="form-control" name="career"></textarea>
                                    </div>
                                </div>
                                <!-- / form-group -->

                                <div class="form-group form-submit">
                                    <button onclick="sub_mbs(); return false;" class="btn btn-primary">멤버십 가입신청</button>
                                </div>
                            </fieldset>
                        </form> 
                        {:}                                
                        <!-- todo : 신청이 불가능한 상태일때 --> 
                        <div class="alert alert-warning">                                     
                            <p>
                                <strong><span class="icon-warning-sign"></span> Oops! </strong> 
                                멥버십 가입은 프로필 기본정보가 모두 입력된 상태에서만 가능합니다. <br> 프로필 정보 수정을 한 후 다시 멤버십 가입 신청을 해주세요.
                            </p>
                            <p class="text-center" style=" margin-top: 10px;"><button class="btn btn-warning btn-sm" onClick="location.href='/member/edit'">프로필 정보 수정하기</button></p>
                        </div>                                
                        {/}<!--s.picture && s.email -->                               
                        
                    </div>
                </div>
                <!-- /editor -->   
                {:}
                <div class="editor">
                    <h3><span class="icon-edit"></span>  멤버십 신청하기 </h3>                            
                    <div class="edit-body">
                        <div class="alert alert-info">                                    
                            <p><strong><span class="icon-warning-sign"></span> Oops!</strong> 멤버십 신청은 회원가입 및 로그인 하신 뒤에 신청해주세요. ^^</p>
                            <p class="text-center" style=" margin-top: 10px;"><button class="btn btn-warning btn-sm" onClick="location.href='/login'">로그인하기</button></p>
                        </div>
                    </div>
                </div>
                {/}     
                <!-- /editor --> 
                    
            </div> 
        </div>
        <!-- /container --> 
    </div>
    <!-- /page-content --> 
</div>
<!-- /rowContent --> 


<!-- modal #md-searchStartup -->
<div class="modal fade" id="md-searchStartup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    
</div>
<!-- /modal #md-searchStartup -->

<!-- modal #md-searchUser -->
<div class="modal fade" id="md-searchUser" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    
</div>
<!-- /modal #md-searchUser -->

<script type="text/javascript">
//<![CDAT

function new_form(_this) {
    $(_this).parent().parent().parent().toggle();
    $(_this).parent().parent().parent().next().toggle();
}
function add_com(_this){
    var cnt = $('input[name=cnt_com]').val();
    var n_num = parseInt(cnt)+1;
    $('#add_c input').attr('name', 'company_'+n_num);
    $('#add_c button').attr('onclick', 'find_com('+n_num+'); return false;');
    $('input[name=cnt_com]').val(n_num);
    $(_this).before($('#add_c').html());
}

function add_rec(_this){
    var cnt = $('input[name=cnt_rec]').val();
    var n_num = parseInt(cnt)+1;
    $('#add_r input').attr('name', 'recommended_'+n_num);
    $('#add_r button').attr('onclick', 'find_rec('+n_num+'); return false;');
    $('input[name=cnt_rec]').val(n_num);
    $(_this).before($('#add_r').html());
}

function find_com(_v){
    var key = $('input[name=company_'+_v+']').val();
    var get_url = '/ajax_front/get_search_company/';
    var set_data ={
        "data" 		: key,
        "v" 		: _v,
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
    $('input[name=company_'+_v+']').val(_val);
}

function find_rec(_v){
    var key = $('input[name=recommended_'+_v+']').val();
    var get_url = '/ajax_front/get_search_member/';
    var set_data ={
        "data" 		: key,
        "v" 		: _v,
    };
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {

            $('#md-searchUser').html(_data);

        }
    });
}

function recive_rec(_v, _val){
    $('input[name=recommended_'+_v+']').val(_val);
}

function sub_mbs(){

    if ($('input[name=company_1]').val() === '' && $('input[name=recommended_1]').val() === '') {
        alert("추천기관, 추천인 중 하나이상 입력하셔야 합니다.");
        return false;
    }

    document.mbs_form.submit();
}

//]]>
</script> 