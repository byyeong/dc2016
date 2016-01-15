           
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                    
                    
                    <!-- panel #pane-event-approve -->
                    <div id="pane-event-approve" class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-cog"></span><span class="break"></span> 이벤트 승인하기</h2>
                            <div class="actions"> <span class="break"></span> <a href="/admin_event"  data-toggle="tooltip" title="목록보기"><span class="glyphicon  glyphicon-align-justify"></span></a> </div>
                        </div>
                        <!-- /panel-heading -->
                        <form class="form-horizontal" action="/admin_event/approve/{res.id}" method="post">
                            <input type="hidden" name="id" value="{res.id}" />
                            <input type="hidden" name="user_id" value="{res.user_id}" />
                            <!-- panel-body -->
                            <div class="panel-body info-field"> 
                                
                                <fieldset>
                                    <legend>이벤트 정보</legend>
                                    <dl class="dl-horizontal">
                                        <dt>개설일자</dt>
                                        <dd> {=str_replace("-", ".", res.date)} </dd>
                                    </dl>
                                    <!-- /dl-horizontal -->
                                    
                                    <dl class="dl-horizontal">
                                        <dt>개설자</dt>
                                        <dd> {res.mname} </dd>
                                    </dl>
                                    <!-- /dl-horizontal -->
                                    
                                    <dl class="dl-horizontal">
                                        <dt>이벤트 장소</dt>
                                        <dd> {? res.space_id == 0}{res.space_etc}{:}{res.opt}F {res.sname}{/} </dd>
                                    </dl>
                                    <!-- /dl-horizontal -->
                                    
                                    <dl class="dl-horizontal">
                                        <dt>성격</dt>
                                        <dd> {res.ename} </dd>
                                    </dl>
                                    <!-- /dl-horizontal -->
                                    
                                    <dl class="dl-horizontal">
                                        <dt>행사명</dt>
                                        <dd> {res.title} </dd>
                                    </dl>
                                    <!-- /dl-horizontal -->
                                    
                                    <dl class="dl-horizontal">
                                        <dt>시간</dt>
                                        <dd> {res.start} ~ {res.end} </dd>
                                    </dl>
                                    <!-- /dl-horizontal -->
                                    
                                    <dl class="dl-horizontal">
                                        <dt>인원</dt>
                                        <dd> {res.cnt}명 </dd>
                                    </dl>
                                    <!-- /dl-horizontal -->
                                    
                                    <dl class="dl-horizontal">
                                        <dt>참여 선정 방법</dt>
                                        <dd> <span class="label label-info"> {? res.enroll == 1}선착순{:}관리자 선정{/} </span> </dd>
                                    </dl>
                                    <!-- /dl-horizontal --> 
                                </fieldset>
                            </div>
                            
                            <!-- panel-body -->
                            <div class="panel-body"> 
                                <fieldset>
                                    <legend>신청 승인하기</legend>
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >신청상태</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                                <select name="state" class="selectpicker" data-width="auto" >
                                                    <option value="0" {? res.state == 0}selected="selected"{/}>승인대기</option>
                                                    <option value="1" {? res.state == 1}selected="selected"{/}>승인</option>
                                                    <option value="2" {? res.state == 2}selected="selected"{/}>반려</option>
                                                </select>
                                              
                                            <div class="form-group-sub">
                                                <label class="sr-only" for="inputReject">반려사유</label>
                                                <input type="text" class="form-control" name="state_des" value="{? res.state == 0}이벤트에 대한 '공간 공유' 승인 내역을 확인할 수 없습니다.  '공간 공유' 신청을 먼저 부탁드립니다.{:}{res.state_des}{/}" id="inputReject" placeholder="반려사유를 적어주세요" >
                                            </div>
                                            <!-- /form-group-sub -->  
                                        </div>
                                    </div>
                                </fieldset>
                            </div>
                            <!-- /panel-body --> 
                            
                            <!-- pane-footer -->
                            <div class="panel-footer">
                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                    <button type="button" class="btn btn-default">취소</button>
                                    <button type="submit" class="btn btn-primary" onclick="javascript:$(this).hide();">확인</button>
                                    </div>
                                </div>
                            </div>
                            <!-- /panel-footer -->
                        </form>
                    </div>
                    <!-- /panel #pane-event-approve --> 
                    
                    
                    
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 
            
<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}

//]]>
</script>        