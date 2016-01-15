<!-- contentswrap -->

<div class="col-md-10 contentswrap"> 
    <!-- section -->
    <section> 
        
        <!-- panel -->
        <div class="panel panel-default"> 
            <!-- panel-heading -->
            <div class="panel-heading">
                <h2> <span class="glyphicon  glyphicon-file"></span><span class="break"></span>회원
                    신청 승인 </h2>
                <div class="actions"> <span class="break"></span><a href="/admin_member" class="btn-list" data-toggle="tooltip" title="목록보기"><span class="glyphicon  glyphicon-align-justify"></span></a> </div>
            </div>
            <!-- /panel-heading -->
            
            <form class="form-horizontal" action="/admin_member/approve/{res.id}" method="post">
                <input type="hidden" name="id" value="{res.id}" />
                <!-- panel-body -->
                <div class="panel-body info-field">
                    <fieldset>
                        <legend>회원 정보</legend>
                        <dl class="dl-horizontal">
                            <dt>이름</dt>
                            <dd>{res.name}</dd>
                        </dl>
                        <!-- /dl-horizontal -->
                        
                        <dl class="dl-horizontal">
                            <dt>아이디</dt>
                            <dd>{res.ids}</dd>
                        </dl>
                        <!-- /dl-horizontal -->
                        
                        <dl class="dl-horizontal">
                            <dt>프로필이미지</dt>
                            <dd> <img src="{res.picture}" data-src="holder.js/160x160" alt="{res.ids}" class="img-thumbnail"> </dd>
                        </dl>
                        <!-- /dl-horizontal -->
                        
                        <dl class="dl-horizontal">
                            <dt>교육</dt>
                            <dd>{res.education} {? res.education_st == 0}졸업{:}재학중{/}</dd>
                        </dl>
                        <!-- /dl-horizontal -->
                        
                        <dl class="dl-horizontal">
                            <dt>회사/역할</dt>
                            <dd>{res.company} / {res.company_role}</dd>
                        </dl>
                        <!-- /dl-horizontal -->
                        
                        <dl class="dl-horizontal">
                            <dt>소갯말</dt>
                            <dd>{=htmlspecialchars(res.bio)}</dd>
                        </dl>
                        <!-- /dl-horizontal -->
                        
                        <dl class="dl-horizontal">
                            <dt>관심지역</dt>
                            <dd>{@res_lo}{.location} {/}</dd>
                        </dl>
                        <!-- /dl-horizontal -->
                        
                        <dl class="dl-horizontal">
                            <dt>업무역량</dt>
                            <dd>{@res_sk}{.skill} {/}</dd>
                        </dl>
                        <!-- /dl-horizontal -->
                        
                        <dl class="dl-horizontal">
                            <dt>관심분야</dt>
                            <dd>{@res_in}{.interist} {/}</dd>
                        </dl>
                        <!-- /dl-horizontal -->
                        
                        <dl class="dl-horizontal">
                            <dt>SNS</dt>
                            <dd> Twitter <strong>{sns_tw.ids}</strong> </dd>
                            <dd> Facebook <strong>{sns_fa.ids}</strong> </dd>
                        </dl>
                        <!-- /dl-horizontal -->
                        
                        <dl class="dl-horizontal">
                            <dt>메일주소</dt>
                            <dd>{res.email}</dd>
                        </dl>
                        <!-- /dl-horizontal -->
                        
                        <dl class="dl-horizontal">
                            <dt>메일 수신 여부</dt>
                            <dd>{? res.email_rec == 0}메일을 받지 않습니다.{:}메일을 받습니다.{/}</dd>
                        </dl>
                        <!-- /dl-horizontal -->
                        
                        <dl class="dl-horizontal">
                            <dt>연락처</dt>
                            <dd>{res.tel}</dd>
                        </dl>
                        <!-- /dl-horizontal -->
                        
                        <dl class="dl-horizontal">
                            <dt>SMS 수신 여부</dt>
                            <dd>{? res.sms_rec == 0}SMS를 받지 않습니다.{:}SMS를 받습니다.{/}</dd>
                        </dl>
                        <!-- /dl-horizontal -->
                    </fieldset>
                </div>
                <!-- /panel-body --> 
                
                <!-- panel-body -->
                <div class="panel-body">
                    <fieldset>
                        <legend>회원 승인</legend>
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >회원등급</div>
                            <div class="col-xs-12 col-sm-10 col-md-10">
                                <input type="hidden" name="grade" value="{res.grade}" />
                                <select class="selectpicker" data-width="auto" disabled="disabled">
                                    {@ grade}                                                      
                                    <option value="{.id}" {? res.grade == .id}selected="selected"{/}>{.name}</option>
                                    {/}                                                          
                                </select>
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >회원 상태 처리</div>
                            <div class="col-xs-12 col-sm-10 col-md-10">
                                <select name="state" class="selectpicker" data-width="auto" >
                                    <option value="0" {? res.state == 0}selected="selected"{/}>승인대기</option>
                                    <option value="1" {? res.state == 1}selected="selected"{/}>승인</option>
                                    <option value="2" {? res.state == 2}selected="selected"{/}>반려</option>
                                    <option value="3" {? res.state == 3}selected="selected"{/}>탈퇴</option>
                                </select>
                                <div class="form-group-sub">
                                    <label class="sr-only" for="inputJoinReject">반려사유</label>
                                    <input type="text" class="form-control" id="inputJoinReject" placeholder="반려사유를 적어주세요" name="state_des" value="{? res.state == 2}{res.state_des}{/}">
                                </div>
                                <!-- /form-group-sub --> 
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                    </fieldset>
                </div>
                <!-- /panel-body -->
                <div class="panel-footer">
                    <div class="form-group">
                        <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                            <button type="button" class="btn btn-default">취소</button>
                            <button type="submit" class="btn btn-primary">확인</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <!-- /panel --> 
        
    </section>
    <!-- /section --> 
</div>
<!-- /contentwrap -->