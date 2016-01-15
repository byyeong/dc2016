
            <!-- contentswrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                     
                    <!-- panel -->
                    <div id="pane-entrance-checkin" class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon glyphicon-log-in"></span><span class="break"></span>출입증 발급</h2>
                        </div>
                        <!-- /panel-heading --> 
                                              
                        <form class="form-horizontal" name="checkin_form" method="post" action="/admin_entrance/checkin_pass/{res.id}" onsubmit="return false;">
                            <input type="hidden" name="user_id" value="{res.id}" />
                            <!-- panel-body -->
                            <div class="panel-body info-field">
                                <fieldset> 
                                    <legend>회원정보</legend> 
                                        <dl class="dl-horizontal"> 
                                            <dt>이름</dt>
                                            <dd><strong>{res.name}</strong></dd>
                                        </dl>
                                        <dl class="dl-horizontal"> 
                                            <dt>프로필이미지</dt>
                                            <dd><img  class="img-thumbnail img-responsive" src="{?res.picture}{res.picture}{:}/img/default-img-member.png{/}"></dd>
                                        </dl>
                                        <dl class="dl-horizontal"> 
                                            <dt>이메일</dt>
                                            <dd>{res.email}</dd>
                                        </dl>
                                        <dl class="dl-horizontal"> 
                                            <dt>총 방문수</dt>
                                            <dd>{?res.login_all}{res.login_all}{:}0{/}</dd>
                                        </dl>
                                        <dl class="dl-horizontal"> 
                                            <dt>이번 달 방문수</dt>
                                            <dd>{?res.login_mon}{res.login_mon}{:}0{/}</dd>
                                        </dl>
                                        <br >
                                        <dl class="dl-horizontal">
                                            <dt>멤버십</dt>
                                            <dd>{? res.membership == 1}<span class="icon-ok text-primary"></span>{:}<span class="icon-minus text-danger"></span>{/}</dd>
                                        </dl>
                                        {? res.membership == 1}
                                        <dl class="dl-horizontal"> 
                                            <dt>멤버십 승인일</dt>
                                            <dd>{? res.membership == 1}{=str_replace("-", ".", substr(res.date_ms.date_edited, 0, 10))}{/}</dd>
                                        </dl>
                                        {/}
                                        <dl class="dl-horizontal">
                                            <dt>추천인/추천기관</dt>
                                            <dd>{res.com.name}{? res.com && res.mem_} / {/}{res.mem_.name}</dd>
                                        </dl>
                                        <dl class="dl-horizontal">
                                            <dt>창업 관련 활동</dt>
                                            <dd>{res.mem.act}</dd>
                                        </dl>
                                        <dl class="dl-horizontal">
                                            <dt>기타 경력</dt>
                                            <dd>{res.mem.career}</dd>
                                        </dl>
                                        <br >
                                        <dl class="dl-horizontal text-danger"> 
                                            <dt><span class="glyphicon glyphicon-warning-sign"></span> 메모</dt>
                                            <dd><textarea class="form-control">{res.admin_des}</textarea></dd>
                                        </dl> 
                                </fieldset>
                            </div>
                            <!-- /panel-body -->  
                            <!-- panel-body -->
                            <div class="panel-body">
                                <fieldset>
                                    <legend>입실정보입력</legend>
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >출입증 번호</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <select class="selectpicker" data-width="auto" name="pass" id="c_pass">
                                                <option value="0">선택</option>
                                                {@ pass}{? !.date_in}
                                                <option value="{.ppass}">{.ppass}</option>
                                                {/}{/}
                                            </select>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    <div class="form-group form-group-end"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >일일사물함 배정</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <select class="selectpicker" data-width="auto" name="locker">
                                                <option>사물함 배정 안함</option>
                                                {@ locker}{? !.date_in}
                                                <option value="{.llocker}">{.llocker}</option>
                                                {/}{/}
                                            </select>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                </fieldset>
                            </div>
                            <!-- /panel-body -->
                            <div class="panel-footer">
                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                        <button class="btn btn-primary" onclick="go_submit(this); return false;">확인</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!--/panel --> 
                     
                    
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 
            
<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}

function go_submit(_this) {
    
    if ($('#c_pass option:selected').val() === '0') {
        alert('출입증 번호를 선택해주세요.');
        return false;
    }
    else {
        $(_this).hide();
        document.checkin_form.submit();
    }
}

//]]>
</script>
