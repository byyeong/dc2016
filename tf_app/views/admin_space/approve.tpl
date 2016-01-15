            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                
                <!-- section -->
                <section> 
                    
                    <!-- panel -->
                    <div class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-edit"></span> <span class="break"></span> 공간 예약 승인</h2>
                            <div class="actions"> <span class="break"></span> <a href="floor-reserve-list.html" class="btn-add"  data-toggle="tooltip" title="신청 목록"><span class="glyphicon  glyphicon-align-justify"></span></a> </div>
                        </div>
                        <!-- /panel-heading -->
                        <form class="form-horizontal" action="/admin_space/approve/{res.id}" method="post" return false; name="approve_f" onsubmit="return false;">
                            <input type="hidden" name="id" value="{res.id}" />
                            <!-- panel-body -->
                            <div class="panel-body info-field">
                                <fieldset>
                                    <legend>신청정보</legend>
                                    <dl class="dl-horizontal">
                                        <dt>신청일자</dt>
                                        <dd> {res.date} </dd>
                                    </dl>
                                    <!-- /dl-horizontal -->
                                    
                                    <dl class="dl-horizontal">
                                        <dt>신청자</dt>
                                        <dd> {res.ids} </dd>
                                    </dl>
                                    <!-- /dl-horizontal -->
                                    
                                    <dl class="dl-horizontal">
                                        <dt>장소</dt>
                                        <dd> {res.opt}F {res.name} </dd>
                                    </dl>
                                    <!-- /dl-horizontal -->
                                    
                                    <dl class="dl-horizontal">
                                        <dt>목적</dt>
                                        <dd> {res.purpose} </dd>
                                    </dl>
                                    <!-- /dl-horizontal -->
                                    
                                    <dl class="dl-horizontal">
                                        <dt>시간</dt>
                                        <dd> {res.start} ~ {res.end} </dd>
                                    </dl>
                                    <!-- /dl-horizontal -->
                                    
                                    <dl class="dl-horizontal">
                                        {? res.type == 3}
                                        <dt >공간</dt>
                                        <dd>
                                            {? res.cnt == 1}원더우먼(iMac){/}
                                            {? res.cnt == 2}배트맨 (PC){/}
                                            {? res.cnt == 3}슈퍼걸 (iMac){/}
                                            {? res.cnt == 4}조커(PC){/} 
                                        </dd>
                                        {:}
                                        <dt >인원</dt>
                                        <dd>{res.cnt}명 </dd>
                                        {/}
                                    </dl>
                                    <!-- /dl-horizontal -->
                                </fieldset>
                            </div>
                            <!-- /panel-body --> 
                            
                            <!-- panel-body -->
                            <div class="panel-body">
                                <fieldset>
                                    <legend>승인하기</legend>
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >신청상태</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                                <select name="state" class="selectpicker" data-width="auto">
                                                    <option value="0" {? res.state == 0}selected{/}>승인대기</option>
                                                    <option value="1" {? res.state == 1}selected{/}>승인</option>
                                                    <option value="2" {? res.state == 2}selected{/}>반려</option>
                                                </select> 
                                            
                                            <!-- TODO : '반려'일때 노출 -->
                                            <div class="form-group-sub">
                                                <label class="sr-only" for="inputReject">반려사유</label>
                                                <input type="text" class="form-control" id="inputReject" name="state_des" placeholder="반려사유를 적어주세요" {? res.state == 2}value="{res.state_des}"{/}{? res.state == 0}value="공간공유 승인을 위한 정보가 부족합니다. 신청 양식을 조금 더 충실히 작성해주세요."{/}> 
                                            </div>
                                            <!-- /form-group-sub --> 
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                </fieldset>
                            </div>
                            <!-- /panel-body --> 
                            
                            <!-- panel-footer -->
                            <div class="panel-footer">
                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                    <button type="button" class="btn btn-default" onclick="location.href='/admin_space/'">취소</button>
                                    <button type="submit" class="btn btn-primary" onclick="submit_approve(); return false;">확인</button>
                                    </div>
                                </div>
                            </div>
                            <!-- /panel-footer -->
                        </form>
                    </div>
                    <!-- /panel --> 
                    
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 
<script type="text/javascript">
//<![CDATA[

    function submit_approve() {
  
        if ($('select[name=state] option:selected').val() == 1) {
            var get_url = '/ajax_front/check_space';
            var set_data = {
                'id' : '{res.id}',
                'space_id' : '{res.space_id}',
                'date' : '{res.date}',
                'start' : '{res.start}',
                'end' : '{res.end}'
            }

            $.ajax({
                type : 'POST',
                url : get_url,
                data : set_data,
                dataType : 'json',
                success : function(_data) {
                    
                    if (_data.error) {
                        alert(_data.msg);
                    }
                    else {
                        document.approve_f.submit();
                    }
                }
            });
        }
        else {
            document.approve_f.submit();
        }
            

    }
    
//]]>
</script>    