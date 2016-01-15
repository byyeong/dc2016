
                <div class="content col-xs-12 col-sm-12 col-md-9">
                    <div class="content-header">                       
                         <h3 class="content-heading"> <span class="icon-map-marker"></span> {? res.type < 3}공간공유{:}디자인 라운지{/} 예약 내역 </h3>
                    </div>

                    <div class="form-horizontal">
                        {? res.type < 3}      
                        <div id="form-reserve-sharing" class="form-group-wrap well">

                            <div class="form-group">
                                <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 신청목적</div>
                                <div class="col-xs-12 col-sm-10 col-md-10 ">
                                    <select data-width="auto" class="selectpicker" id="check_type" onchange="sel_type(); return false;">
                                        <option value="1" {? res.type == 1} selected="selected"{/}>회의실 이용 신청 </option>
                                        <option value="2" {? res.type == 2} selected="selected"{/}>외부 행사 대관 신청</option>
                                    </select>
                                </div>
                            </div>
                            <!-- / form-group -->

                            <div class="form-group s_type_1" {? res.type == 2}style="display: none;"{/}>
                                <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 공간 선택</div>
                                <div class="col-xs-12 col-sm-10 col-md-10 ">
                                    <select class="selectpicker" data-width="auto" {? res.type == 1}name="space_id"{/}>
                                        {@ space}{? .type == 1}
                                        <option value="{.id}" {? res.space_id == .id}selected="selected"{/}>{? .opt}{.opt}F {/}{.name}</option>
                                        {/}{/}
                                    </select>
                                </div>
                            </div>
                            <!-- / form-group -->

                            <div class="form-group s_type_2" {? res.type == 1}style="display: none;"{/}>
                                <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 공간 선택</div>
                                <div class="col-xs-12 col-sm-10 col-md-10 ">
                                    <select class="selectpicker" data-width="auto" {? res.type == 2}name="space_id"{/}>
                                        {@ space}{? .type == 2}
                                        <option value="{.id}" {? res.space_id == .id}selected="selected"{/}>{? .opt}{.opt}F {/}{.name}</option>
                                        {/}{/}
                                    </select>
                                </div>
                            </div>
                            <!-- / form-group -->


                            <div class="form-group">
                                <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 신청 일자</div>
                                <div class="col-xs-12 col-sm-10 col-md-10 "> 
                                    <!-- datepicker -->
                                    <div class="bfh-datepicker" data-format="{?res.date}{res.date}{:}y.m.d{/}">
                                        <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                            <input type="text" class="form-control datepicker" id="date_2" name="date" value="{res.date}">
                                        </div>
                                    </div>
                                    <!-- /datepicker --> 
                                    <span class="help-block">공휴일은 휴무입니다. 신청일자 선택시 유의 하시기 바랍니다. (토요일은 6시까지만 공간공유가 가능합니다.)</span> 
                                </div>
                            </div>
                            <!-- / form-group -->

                            <div class="form-group">
                                <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 이용 시간</div>
                                <div class="col-xs-12 col-sm-10 col-md-10 "> 
                                    <div class="form-group-time">
                                        <div class="bfh-timepicker" data-time="{? res.start}{res.start}{:}10:00{/}" >
                                            <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                <input type="text" class="form-control timepicker" id="start_2" name="start" value="{res.start}" placeholder="시작시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                            </div>
                                        </div>
                                        <!-- /timepicker --> 
                                        <span class="sim">&sim;</span>
                                        <!-- timepicker -->
                                        <div class="bfh-timepicker" data-time="{? res.end}{res.end}{:}12:00{/}" >
                                            <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                <input type="text" class="form-control timepicker" id="end_2" name="end" value="{res.end}" placeholder="종료시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                            </div>
                                        </div>
                                        <!-- /timepicker -->  
                                    </div>
                                    <span class="help-block">&#183; 공간 예약 신청 시 최대 3시간 내 이용이 가능합니다. </span>
                                    <span class="help-block">&nbsp;&nbsp;그 이상 이용을 원하시는 경우 <a href="mailto:contact@dcamp.kr">contact@dcamp.kr</a> 로 문의해주세요.</span>
                                    <span class="help-block">&#183; 이용시간을 입력한 후 예약이 가능 한지 체크해주세요 </span>
                                </div>
                            </div>
                            <!-- / form-group -->

                            <div class="form-group">
                                <div class="col-xs-12 col-sm-2 col-md-2 control-label">신청자 소개</div>
                                <div class="col-xs-12 col-sm-10 col-md-10 ">
                                    <select class="selectpicker" data-width="auto" name="user_type" id="user_type" onchange="check_user(); return false;">
                                        <option value="1" {? res.user_type == 1}selected="selected"{/}>개인</option>
                                        <option value="2" {? res.user_type == 2}selected="selected"{/}>단체</option>
                                    </select>

                                    <!-- todo : 개인일때 노출 됨 -->
                                    <div class="form-group-sub" id="user_per" {? res.user_type == 2}style="display: none;"{/}>
                                        <p>
                                            <label>개인에 대한 간단한 소개를 써주세요.</label>
                                            <textarea class="form-control" rows="3" name="user_bio" placeholder="신청단체에 대한 간단한 소개를 써주세요">{res.user_bio}</textarea>
                                        </p>
                                    </div> 
                                    <!-- /form-group-sub -->  

                                    <!-- todo : 단체일때 노출 됨 -->
                                    <div class="form-group-sub" id="user_gr" {? res.user_type == 1 || !ress}style="display: none;"{/}>
                                        <p>
                                            <label>단체에 대한 간단한 소개를 써주세요.</label>
                                            <textarea class="form-control" name="group_bio" rows="3" placeholder="신청단체에 대한 간단한 소개를 써주세요">{res.group_bio}</textarea>
                                        </p>
                                        <p>
                                            <label>홈페이지 주소를 입력해주세요</label>
                                            <input type="text" name="group_web" value="{res.group_web}" class="form-control" placeholder="http://"></input>
                                        </p>
                                    </div> 
                                    <!-- /form-group-sub -->                                            
                                </div>
                            </div>
                            <!-- / form-group -->

                            <div class="form-group">
                                <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 행사명</div>
                                <div class="col-xs-12 col-sm-10 col-md-10 "> 
                                    <input type="text" class="form-control" name="purpose" id="purpose_2" value="{res.purpose}">
                                    <span class="help-block">행사명을 알려 주세요</span>                                             
                                </div>
                            </div>
                            <!-- / form-group -->

                            <div class="form-group">
                                <div class="col-xs-12 col-sm-2 col-md-2 control-label">관련 행사 주소</div>
                                <div class="col-xs-12 col-sm-10 col-md-10 ">
                                    <div class="input-group"> <span class="input-group-addon"><span class="icon-fixed-width icon-link"></span></span>
                                        <input type="text" placeholder="http://" class="form-control" name="rel_url" value="{res.rel_url}">
                                    </div>
                                    <!-- /input-group -->
                                    <span class="help-block">D.CAMP에서 진행되는 관련된 행사가 있으면 주소를 입력해주세요.</span> 
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-2 col-md-2 control-label">행사 소개</div>
                                <div class="col-xs-12 col-sm-10 col-md-10 "> 
                                    <textarea class="form-control" rows="3" name="purpose_des" id="purpose_des_2">{res.purpose_des}</textarea>  
                                    <span class="help-block">행사의 취지, 주요 프로그램 등을 자세히 알려 주세요</span>                                             
                                </div>
                            </div>
                            <!-- / form-group -->

                            <div class="form-group">
                                <div class="col-xs-12 col-sm-2 col-md-2 control-label">참여자</div>
                                <div class="col-xs-12 col-sm-10 col-md-10 "> 
                                    <textarea class="form-control" rows="3" name="users_info">{res.users_info}</textarea>  
                                    <span class="help-block">예상 인원수와 어떤 분들이 주로 참여하는 알려주세요</span>                                               
                                </div>
                            </div>
                            <!-- / form-group -->

                            <div class="form-group">
                                <div class="col-xs-12 col-sm-2 col-md-2 control-label">참가비 여부</div>
                                <div class="col-xs-12 col-sm-10 col-md-10 ">
                                    <label class="form-control-static">참가자들에게 비용을 받는 행사입니까?</label><br>
                                    <select class="selectpicker" data-width="auto" id="paid" name="paid" onchange="check_paid(); return false;">
                                        <option value="0" {? res.paid == 0}selected="selected"{/}>아니오</option>
                                        <option value="1" {? res.paid == 1}selected="selected"{/}>네</option>
                                    </select>

                                    <!-- todo : "네"일때 노출 됨 -->
                                    <div class="form-group-sub" id="paid_des" {? !res.paid}style="display: none;"{/}>
                                        <p>
                                            <label>참가비와 이를 받는 취지는 무엇입니까? </label>
                                            <textarea class="form-control" name="paid_des">{res.aid_des}</textarea>  
                                        </p>                                            
                                    </div>
                                    <!-- /form-group-sub -->
                                </div>
                            </div>
                            <!-- / form-group -->

                            <div class="form-group">
                                <div class="col-xs-12 col-sm-2 col-md-2 control-label">식사 여부</div>
                                <div class="col-xs-12 col-sm-10 col-md-10 ">
                                    <label class="form-control-static">참가자들이 식사를 하는 행사입니까?</label><br>
                                    <select class="selectpicker" data-width="auto" name="meal">
                                        <option value="0" {? res.meal == 0}selected="selected"{/}>아니오</option>
                                        <option value="1" {? res.meal == 1}selected="selected"{/}>네</option>
                                    </select> 
                                    <span class="help-block">핑거푸드나 도시락, 샌드위치와 같은 간단한 음식만 가능합니다.</span>                              
                                </div>
                            </div>
                            <!-- / form-group -->

                            <div class="form-group">
                                <div class="col-xs-12 col-sm-2 col-md-2 control-label">무료 초대여부</div>
                                <div class="col-xs-12 col-sm-10 col-md-10 ">
                                    <label class="form-control-static">유료 행사인 경우 D.CAMP 회원의 무료 초대가 가능한 행사입니까? </label><br>
                                    <select class="selectpicker" data-width="auto" name="Invit">
                                        <option value="0" {? res.Invit == 0}selected="selected"{/}>아니오</option>
                                        <option value="1" {? res.Invit == 1}selected="selected"{/}>네</option>
                                    </select>                           
                                </div>
                            </div>
                            <!-- / form-group -->

                            <div class="form-group">
                                <div class="col-xs-12 col-sm-2 col-md-2 control-label">연락처</div>
                                <div class="col-xs-12 col-sm-10 col-md-10 ">
                                    <div class="input-group">
                                        <span class="input-group-addon"><span class="icon-fixed-width icon-phone"></span></span>
                                        <input type="text" class="form-control" name="tel" value="{res.tel}">
                                    </div>
                                    <!-- /input-group -->  

                                    <div class="input-group">
                                        <span class="input-group-addon"><span class=" icon-fixed-width icon-envelope-alt"></span></span>
                                        <input type="text" class="form-control" name="email" value="{res.email}">
                                    </div>
                                    <!-- /input-group -->                     
                                </div>
                            </div>
                            <!-- / form-group -->

                            <div class="form-group">
                                <div class="col-xs-12 col-sm-2 col-md-2 control-label">개인정보 활용 동의</div>
                                <div class="col-xs-12 col-sm-10 col-md-10 ">
                                    <select class="selectpicker" data-width="auto" name="privacy" id="privacy">
                                        <option value="1" {? ress}selected="selected"{/}>네</option>
                                        <option value="0">아니오</option>
                                    </select>                      
                                </div>
                            </div>
                            <!-- / form-group -->

                        </div>
                        <!-- /form-reserve-sharing -->
                        {:}
                        <div id="form-reserve-design" class="form-group-wrap well">
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-2 col-md-2 control-label">공간 선택</div>
                                <div class="col-xs-12 col-sm-10 col-md-10 ">
                                    <select class="selectpicker" name="cnt">
                                        <option value="1" {? res.cnt == 1}selected="selected"{/}>원더우먼(iMac)</option>
                                        <option value="2" {? res.cnt == 2}selected="selected"{/}>배트맨 (PC)</option>
                                        <option value="3" {? res.cnt == 3}selected="selected"{/}>슈퍼걸 (iMac)</option>
                                        <option value="4" {? res.cnt == 4}selected="selected"{/}>조커(PC)</option>
                                    </select>
                                </div>
                            </div>
                            <!-- / form-group -->
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 신청 일자</div>
                                <div class="col-xs-12 col-sm-10 col-md-10 "> 
                                    <!-- datepicker -->
                                    <div class="bfh-datepicker" data-format="{?res.date}{res.date}{:}y.m.d{/}">
                                        <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                            <input type="text" class="form-control datepicker" id="date_3" name="date" value="{? rdate}{rdate}{:}{res.date}{/}">
                                        </div>
                                    </div>
                                    <!-- /datepicker --> 
                                    <span class="help-block">공휴일은 휴무입니다. 신청일자 선택시 유의 하시기 바랍니다. (토요일은 6시까지만 공간공유가 가능합니다.)</span> 
                                </div>
                            </div>
                            <!-- / form-group -->

                            <div class="form-group">
                                <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 이용 시간</div>
                                <div class="col-xs-12 col-sm-10 col-md-10 "> 
                                    <div class="form-group-time">
                                        <div class="bfh-timepicker" data-time="{? res.start}{res.start}{:}10:00{/}" >
                                            <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                <input type="text" class="form-control timepicker timepickermm" id="start_3" name="start" value="{res.start}" placeholder="시작시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                            </div>
                                        </div>
                                        <!-- /timepicker --> 
                                        <span class="sim">&sim;</span>
                                        <!-- timepicker -->
                                        <div class="bfh-timepicker" data-time="{? res.end}{res.end}{:}12:00{/}" >
                                            <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                <input type="text" class="form-control timepicker timepickermm" id="end_3" name="end" value="{res.end}" placeholder="종료시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                            </div>
                                        </div>
                                        <!-- /timepicker -->  
                                    </div>
                                    <span class="help-block">&#183; 공간 예약 신청 시 최대 3시간 내 이용이 가능합니다. </span>
                                    <span class="help-block">&nbsp;&nbsp;그 이상 이용을 원하시는 경우 <a href="mailto:contact@dcamp.kr">contact@dcamp.kr</a> 로 문의해주세요.</span>
                                    <span class="help-block">&#183; 이용시간을 입력한 후 예약이 가능 한지 체크해주세요 </span>
                                </div>
                            </div>
                            <!-- / form-group -->

                            <div class="form-group">
                                <div class="col-xs-12 col-sm-2 col-md-2 control-label">작업 내용</div>
                                <div class="col-xs-12 col-sm-10 col-md-10 ">
                                    <input type="text" class="form-control" name="purpose" value="{res.purpose}">
                                </div>
                            </div>
                            <!-- / form-group -->


                            <div class="form-group">
                                <div class="col-xs-12 col-sm-2 col-md-2 control-label">연락처</div>
                                <div class="col-xs-12 col-sm-10 col-md-10 ">
                                    <div class="input-group"> <span class="input-group-addon"><span class="icon-fixed-width icon-phone"></span></span>
                                        <input type="text" class="form-control" name="tel" value="{res.tel}">
                                    </div>
                                    <!-- /input-group -->
                                    
                                    <div class="input-group"> <span class="input-group-addon"><span class=" icon-fixed-width icon-envelope-alt"></span></span>
                                        <input type="text" class="form-control" name="email" value="{res.email}">
                                    </div>
                                    <!-- /input-group --> 
                                </div>
                            </div>
                            <!-- / form-group -->
                                    
                        </div>
                        <!-- /form-reserve-design -->  
                        {/}

                        <!-- panel-body -->
                        <form action="/member/edit_rsv_apr/{res.id}" >
                            <div class="panel-body">
                                <div class="form-group"> 
                                    <div class="col-xs-12 col-sm-2 col-md-2 control-label" >신청상태</div>
                                    <div class="col-xs-12 col-sm-10 col-md-10">
                                        <select name="state" class="selectpicker" data-width="auto">
                                            <option value="0" {? res.state == 0}selected{/}>승인대기</option>
                                            <option value="1" {? res.state == 1}selected{/}>승인</option>
                                            <option value="2" {? res.state == 2}selected{/}>반려</option>
                                        </select> 
                                        
                                        <!-- TODO : '반려'일때 노출 -->
                                        <div class="form-group-sub" style="margin-top:10px;">
                                            <label class="sr-only" for="inputReject">반려사유</label>
                                            <input type="text" class="form-control" id="inputReject" name="state_des" placeholder="반려사유를 적어주세요" {? res.state == 2}value="{res.state_des}"{/}{? res.state == 0}value="공간공유 승인을 위한 정보가 부족합니다. 신청 양식을 조금 더 충실히 작성해주세요."{/}> 
                                        </div>
                                        <!-- /form-group-sub --> 
                                    </div>
                                </div>
                                <!-- /form-group -->
                            </div>
                            <!-- /panel-body --> 
                            
                            <!-- panel-footer -->
                            <div class="panel-footer">
                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                        {? res.type < 3}
                                        <button type="button" class="btn btn-default" onclick="location.href='/member/edit_rsv1/'">취소</button>
                                        {:}
                                        <button type="button" class="btn btn-default" onclick="location.href='/member/edit_rsv2/'">취소</button>
                                        {/}
                                        <button type="submit" class="btn btn-primary">승인 확인</button>
                                    </div>
                                </div>
                            </div>
                            <!-- /panel-footer -->
                            <input type="hidden" name="id" value="{res.id}" />
                        </form>
                    </div>
                

                </div>
                <!-- /content -->

<div id="md-linkEvent" class="modal fade">
</div>
<!-- modal -->

<script type="text/javascript">
//<![CDATA[
$('.well input').attr('disabled', 'disabled');
$('.well select').attr('disabled', 'disabled');
$('.well textarea').attr('disabled', 'disabled');
//]]>
</script>