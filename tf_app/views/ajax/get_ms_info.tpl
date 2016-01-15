    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">멤버쉽 신청내용  <span>{res.name}({res.ids})</span> </h4>
            </div>
            <!-- modal-body -->
            <div class="modal-body">
                
                <div class="self-info">
                    <div class="row">
                    
                        <div class="col-md-4">
                            <img src="{res.picture}" class="img-responsive">
                        </div>
                        <div class="col-md-8">
                            <dl>
                                <dt>교육</dt>
                                
                                <dd>
                                    {@ res.edu}
                                    {.education} {.education_sp}{? .education_st == 0} 졸업{/}{? .education_st == 1} 재학 중{/}{? .education_st == 2} 중퇴{/}<br>
                                    {/}
                                </dd>
                                
                            </dl>
                            <dl>
                                <dt>회사/역할</dt>
                                <dd>
                                    {@ res.car}
                                    {.sname}{?.role} / {.role}{/} <br>
                                    {/}
                                </dd>
                            </dl>
                            <dl>
                                <dt>자기소개</dt>
                                <dd>{=htmlspecialchars(res.bio)}</dd>
                            </dl>
                            <dl>
                                <dt>SNS</dt>
                                <dd>
                                    {?res.fb}<a href="http://facebook.com/{res.fb.ids}" target="_blank" class="btn btn-default btn-sm"><span class="icon-fixed-width icon-facebook"></span></a>{/}
                                    {?res.tw}<a href="http://twitter.com/{res.tw.ids}" target="_blank" class="btn btn-default btn-sm"><span class="icon-fixed-width icon-twitter"></span></a>{/}
                                </dd>
                            </dl>
                        </div>
                        
                    </div>
                </div>
                
                <div class="apply-info">
                    <dl class="dl-horizontal">
                        <dt>추천인/추천기관</dt>
                        <dd>{res.com.name}{? res.com && res.mem} / {/}{res.mem.name}</dd>
                    </dl>
                    <dl class="dl-horizontal">
                        <dt>창업 관련 활동</dt>
                        <dd>{res.act}</dd>
                    </dl>
                    <dl class="dl-horizontal">
                        <dt>기타 경력</dt>
                        <dd>{res.career}</dd>
                    </dl>
                </div>
                
                <div class="accept-info">
                    <form class="form-horizontal" role="form" name="ms_state_form" action="/ajax/permit_membership" method="post">
                        <input type="hidden" name="user_id" value="{res.user_id}" />
                        <input type="hidden" name="id" value="{res.id}" />
                        <div class="form-group">
                            <div class="control-label">멤버십 상태 변경</div>
                            <div class="control-item">
                                <label class="radio-inline"><input type="radio" name="state" value="0" {?res.state == 0}checked="checked"{/}> 승인대기</label>
                                <label class="radio-inline"><input type="radio" name="state" value="1" {?res.state == 1}checked="checked"{/}> 승인</label>
                                <label class="radio-inline"><input type="radio" name="state" value="2" {?res.state == 2}checked="checked"{/}> 반려</label>
                                
                                <div style="padding-top:10px;">
                                <textarea class="form-control" rows="3" name="state_des" >{? res.state == 0}멤버십 승인을 위한 정보가 부족합니다. 개인 프로필 및 멤버십 회원 신청 양식을 조금 더 자세히 입력해주세요.{:}{res.state_des}{/}</textarea>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            
            </div>
            <!-- /modal-body -->
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" onclick="go_sub(this);">저장하기</button>
            </div>
        </div>
        <!-- /modal-content --> 
    </div>
    <!-- /modal-dialog --> 
<script type="text/javascript">
//<![CDAT
function go_sub(_this) {
    $(_this).hide();
    var get_url = '/ajax/permit_membership';
    var frm = $('form[name=ms_state_form]');
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) { 
            var _val = $(":radio[name=state]:checked").val();
            var _id = $("input[name=user_id]").val();

            $('#state_'+_id).html('');
            if (_val === '0') {
                $('#state_'+_id).html('<span class="label label-default">승인대기</span>');
            } else if (_val === '1') {
                $('#state_'+_id).html('<span class="label label-success">승인</span>');
            } else if (_val === '2') {
                $('#state_'+_id).html('<span class="label label-warning">반려</span>');
            } 
            $('#md-mbshipView').modal('hide');
        }
    });
}
//]]>
</script> 