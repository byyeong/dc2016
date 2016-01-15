
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap">
                <!-- section -->
                <section> 
                    
                    
                    <!-- panel #pane-floor-edit-->
                    <div id="pane-floor-edit" class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-edit"></span><span class="break"></span> 공간 예약</h2>
                            <div class="actions"> <span class="break"></span> <a href="/admin_space" class="btn-add"  data-toggle="tooltip" title="예약 목록"><span class="glyphicon  glyphicon-align-justify"></span></a> </div>
                        </div>
                        <!-- /panel-heading -->

                        <!-- panel-body --> 
                        <!-- todo : 외부행사 신청 일때 -->
                        <div class="panel-body" id="form-rentalRoom" >
                            {? !res}
                            <div class="form-group-wrap well">
                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 목적</div>
                                    <div class="col-xs-12 col-sm-10 col-md-10 ">
                                        <select class="selectpicker" data-width="auto" name="purpose">
                                            <option value="1">공간공유</option>
                                            <option value="2">D.esign 라운지</option>
                                        </select> 
                                    </div>
                                </div><br/>
                                <!-- / form-group --> 
                            </div>
                            <br/>
                            {/}
                            <div class="form-group-wrap well" id="form-reserve-sharing" {? res.type == 3}style="display: none;"{/}>
                                <form onsubmit="return false;" action="/admin_space/reserve/{res.id}" method="post" id="space_r2_form" name="space_r2_form" class="form-horizontal">
                                <input type="hidden" value="{res.id}" name="id">
                                <input type="hidden" value="{?res}{res.user_id}{:}{s.id}{/}" name="user_id">
                                <input type="hidden" name="user_name" value="{?res.user_name}{res.user_name}{:}{s.name}{/}" >
                                {? !res}<input type="hidden" name="state" value="1">{/}
                                <fieldset>
                                    <h4>공간공유</h4><br/>

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label"></div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 ">
                                            <input type="checkbox" {? res.reserved}checked="checked"{/} value="1" name="reserved" onchange="reserve_check();"> 내부 예약 (체크 등록되면 해당일 전체 시간에 대해서 예약을 허용하지 않습니다.)
                                        </div>
                                    </div>
                                    <!-- / form-group --> 

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 신청목적</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 ">
                                            <select class="selectpicker" data-width="auto" onchange="sel_type(); return false;" id="check_type">
                                                <option value="1" {? res.type == 1}selected="selected"{/}>회의실 이용 신청 </option>
                                                <option value="2" {? res.type == 2}selected="selected"{/}>외부 행사 대관 신청</option>
                                            </select>
                                        </div>
                                    </div>
                                    <!-- / form-group --> 

                                    <div class="form-group s_type_1" {?res.type == 2}style="display: none;"{/}>
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 공간 선택</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 ">
                                            <select class="selectpicker" {? res.type == 1 || ! res}name="space_id"{/} data-width="auto" onchange="reserve_check();">
                                                {@ space}{? .type == 1}
                                                <option value="{.id}" {? res.space_id == .id}selected="selected"{/}>{? .opt}{.opt}F {/}{.name}</option>
                                                {/}{/}
                                            </select>
                                        </div>
                                    </div>
                                    <!-- / form-group -->

                                    <div class="form-group s_type_2" {? !res || res.type == 1}style="display: none;"{/}>
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 공간 선택</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 ">
                                            <select class="selectpicker" {? res.type == 2}name="space_id"{/} data-width="auto" onchange="reserve_check();">
                                                {@ space}{? .type == 2}
                                                <option value="{.id}" {? res.space_id == .id}selected="selected"{/}>{? .opt}{.opt}F {/}{.name}</option>
                                                {/}{/}
                                            </select>
                                        </div>
                                    </div>
                                    <!-- / form-group -->
                                    <script type="text/javascript">
                                    //<![CDATA[
                                        function reserve_check() {
                                            if ( ! $("#form-reserve-sharing input[name=id]").val()) {
                                                if ($("#form-reserve-sharing input[name=reserved]").is(":checked")) {
                                                    _sp = $("#form-reserve-sharing select[name=space_id] option:selected").val();
                                                    $.getJSON( "/ajax/get_space_time/"+_sp, function( json ) {
                                                        $("#form-reserve-sharing input[name=start]").val(json.start);
                                                        $("#form-reserve-sharing input[name=end]").val(json.end);
                                                    });
                                                }
                                            }
                                                
                                        }
                                    //]]>
                                    </script>    

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">신청 일자</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 "> 
                                            <!-- datepicker -->
                                            <div class="bfh-datepicker" data-format="{?res.date}{res.date}{:}y.m.d{/}">
                                                <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                    <input type="text" class="form-control datepicker" id="date_2" name="date" value="{res.date}" >
                                                </div>
                                            </div>
                                            <!-- /datepicker --> 
                                            <span class="help-block">공휴일은 휴무입니다. 신청일자 선택시 유의 하시기 바랍니다. (토요일은 6시까지만 공간공유가 가능합니다.)</span> </div>
                                    </div>
                                    <!-- / form-group -->

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 이용 시간</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 "> 
                                            <div class="form-group-time">
                                                <div class="bfh-timepicker" data-time="{? res.start}{res.start}{:}09:00{/}" >
                                                    <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                        <input type="text" class="form-control timepicker timepickermm" id="start_2" name="start" value="{res.start}" placeholder="시작시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                    </div>
                                                </div>
                                                <!-- /timepicker --> 
                                                <span class="sim">&sim;</span>
                                                <!-- timepicker -->
                                                <div class="bfh-timepicker" data-time="{? res.end}{res.end}{:}22:00{/}" >
                                                    <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                        <input type="text" class="form-control timepicker timepickermm" id="end_2" name="end" value="{res.end}" placeholder="종료시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                    </div>
                                                </div>
                                                <!-- /timepicker -->  
                                                <button title="" data-toggle="tooltip" type="button" class="btn btn-default " data-original-title="예약체크" onclick="time_check('space_r2_form', 2); return false;"><span class="icon-ok"></span><span class="sr-only">예약가능 체크</span></button>
                                            </div>
                                            <span class="help-block">이용시간을 입력한 후 예약이 가능 한지 체크해주세요 </span>
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
                                                    <label>개인에 대한 간단한 소개를 써주세요.</label>
                                                    <textarea class="form-control" rows="3" name="user_bio" placeholder="개인에 대한 간단한 소개를 써주세요">{res.user_bio}</textarea> 
                                            </div>
                                            <!-- /form-group-sub --> 

                                            <!-- todo : 단체일때 노출 됨 -->
                                            <div class="form-group-sub" id="user_gr" {? res.user_type == 1 || !res}style="display: none;"{/}> 
                                                    <label>단체에 대한 간단한 소개를 써주세요.</label>
                                                    <textarea class="form-control" name="group_bio" rows="3" placeholder="단체에 대한 간단한 소개를 써주세요">{res.group_bio}</textarea> 
                                                    <label>홈페이지 주소를 입력해주세요.</label>
                                                    <input type="text" class="form-control" placeholder="http://" name="group_web" value="{res.group_web}">
                                                    </input> 
                                            </div>
                                            <!-- /form-group-sub --> 
                                        </div>
                                    </div>
                                    <!-- / form-group -->

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span>행사명</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 ">
                                            <input type="text" class="form-control" name="purpose" id="purpose_2" value="{res.purpose}">
                                        </div>
                                    </div>

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
                                            <span class="help-block">행사제목, 행사의 취지, 주요 프로그램 등을 자세히 알려 주세요</span> </div>
                                    </div>
                                    <!-- / form-group -->

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">참여자</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 ">
                                            <textarea class="form-control" rows="3" name="users_info">{res.users_info}</textarea>
                                            <span class="help-block">예상 인원수와 어떤 분들이 주로 참여하는 알려주세요</span> </div>
                                    </div>
                                    <!-- / form-group -->

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">참가비 여부</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 ">
                                            <label class="form-control-static">참가자들에게 비용을 받는 행사입니까?</label>
                                            <br>
                                            <select class="selectpicker" data-width="auto" id="paid" name="paid"  onchange="check_paid(); return false;">
                                                <option value="0" {? res.paid == 0}selected="selected"{/}>아니오</option>
                                                <option value="1" {? res.paid == 1}selected="selected"{/}>네</option>
                                            </select>

                                            <!-- todo : "네"일때 노출 됨 -->
                                            <div class="form-group-sub" id="paid_des" {? !res.paid}style="display: none;"{/}>
                                                <p>
                                                    <label>참가비와 이를 받는 취지는 무엇입니까? </label>
                                                    <textarea class="form-control" name="paid_des">{res.paid_des}</textarea>
                                                </p>
                                            </div>
                                            <!-- /form-group-sub --> 
                                        </div>
                                    </div>
                                    <!-- / form-group -->

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">식사 여부</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 ">
                                            <label class="form-control-static">참가자들이 식사를 하는 행사입니까?</label>
                                            <br>
                                            <select class="selectpicker" data-width="auto" name="meal">
                                                <option value="0" {? res.meal == 0}selected="selected"{/}>아니오</option>
                                                <option value="1" {? res.meal == 1}selected="selected"{/}>네</option>
                                            </select>
                                            <span class="help-block">핑거푸드나 도시락, 샌드위치와 같은 간단한 음식만 가능합니다.</span> </div>
                                    </div>
                                    <!-- / form-group -->

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">무료 초대여부</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 ">
                                            <label class="form-control-static">유료 행사인 경우 D.CAMP 회원의 무료 초대가 행사입니까? </label>
                                            <br>
                                            <select class="selectpicker" data-width="auto"  name="Invit">
                                                <option value="0" {? res.Invit == 0}selected="selected"{/}>아니오</option>
                                                <option value="1" {? res.Invit == 1}selected="selected"{/}>네</option>
                                            </select>
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

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">개인정보 활용 동의</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 ">
                                            <select class="selectpicker" data-width="auto" name="privacy" id="privacy">
                                                <option value="0" >아니오</option>
                                                <option value="1" {? res}selected="selected"{/}>네</option>
                                            </select>       
                                        </div>
                                    </div>
                                    <!-- / form-group --> 
                                    <div class="btn-toolbar">
                                        <div class="col-xs-12 col-sm-offset-2 col-sm-2 col-md-offset-2 col-md-2">
                                            <button type="button" class="btn btn-default" onclick="javascript:document.location.href='/admin_space';">취소</button>
                                            <button type="submit" class="btn btn-primary" onclick="submit_space_r('space_r2_form', 2); return false;">예약</button>
                                        </div>
                                    </div> 
                                </fieldset>
                                </form>
                            </div>

                            <!-- /form-reserve-sharing --> 
                            <div class="form-group-wrap well" id="form-reserve-design" {? res.type != 3}style="display: none;"{/}>
                                <form name="space_r3_form" class="form-horizontal" id="space_r3_form" method="post" action="/admin_space/reserve/{res.id}" onsubmit="return false;">
                                    <fieldset>
                                        <h4>디자인 라운지</h4><br/>

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label">좌석 선택</div>
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
                                                    <div class="bfh-timepicker" data-time="{? res.start}{res.start}{:}09:00{/}" >
                                                        <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                            <input type="text" class="form-control timepicker timepickermm" id="start_3" name="start" value="{res.start}" placeholder="시작시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                        </div>
                                                    </div>
                                                    <!-- /timepicker --> 
                                                    <span class="sim">&sim;</span>
                                                    <!-- timepicker -->
                                                    <div class="bfh-timepicker" data-time="{? res.end}{res.end}{:}22:00{/}" >
                                                        <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                            <input type="text" class="form-control timepicker timepickermm" id="end_3" name="end" value="{res.end}" placeholder="종료시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                        </div>
                                                    </div>
                                                    <!-- /timepicker -->  
                                                    <button title="" data-toggle="tooltip" type="button" class="btn btn-default " data-original-title="예약체크" onclick="time_check('space_r3_form', 3); return false;"><span class="icon-ok"></span><span class="sr-only">예약가능 체크</span></button>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- / form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label">작업 내용</div>
                                            <div class="col-xs-12 col-sm-10 col-md-10 ">
                                                <textarea class="form-control" rows="3" name="purpose">{res.purpose}</textarea>
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

                                        <div class="form-group form-submit">
                                            <div class="col-xs-12 col-sm-offset-2 col-md-offset-2 col-sm-10 col-md-10">
                                                <button class="btn btn-default" type="button" onclick="javascript:location.href='/admin_space'">취소</button>
                                                <button class="btn btn-primary" type="submit" onclick="submit_space_r('space_r3_form', 3); return false;">예약</button>
                                            </div>
                                        </div> 
                                        
                                        <input type="hidden" name="id" value="{res.id}" />
                                        {? !res}<input type="hidden" name="state" value="1">{/}
                                        <input type="hidden" value="{?res}{res.user_id}{:}{s.id}{/}" name="user_id">
                                        <input type="hidden" name="user_name" value="{?res.user_name}{res.user_name}{:}{s.name}{/}" >
                                        <input type="hidden" name="space_id" value="{? res}{res.space_id}{:}{ds.id}{/}" />
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                        <!-- /panel-body --> 

                        
                    </div>
                    <!-- /panel #pane-floor-edit --> 
                    
                    
                </section>
                <!-- /section -->
            </div>
            <!-- /contentwrap --> 
            
<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}

$(document).ready(function(){ 
    $("select[name=purpose]").change(function() 
    { 
        var _val = $("select[name=purpose] option:selected").val();
        if (_val == "1") {
            $("#form-reserve-design").slideUp();
            $("#form-reserve-sharing").slideDown();
        }   
        else if (_val == "2") {
            $("#form-reserve-sharing").slideUp();
            $("#form-reserve-design").slideDown();
        }
    }); 

    $('.timepickermm').timepicker({
        'timeFormat': 'H:i',
        'minTime': '9:00am',
        'maxTime': '10:00pm'
    });
});

    function sel_type() {
        var _id = $('#check_type option:selected').val();
        
        if (_id === "1") {
            $('.s_type_1').show();
            $('.s_type_2').hide();
            $('.s_type_1 select').attr('name', 'space_id');
            $('.s_type_2 select').attr('name', '');
        } else {
            $('.s_type_2').show();
            $('.s_type_1').hide();
            $('.s_type_2 select').attr('name', 'space_id');
            $('.s_type_1 select').attr('name', '');
        }
    }
    
    function check_user() {
        var _id = $('#user_type').val();
        $('#user_per, #user_gr').slideUp();
        if (_id === "1") {
            $('#user_per').slideDown();
        } else {
            $('#user_gr').slideDown();
        } 
    }
    
    function check_paid() {
        var _id = $('#paid').val();
        if (_id === "1") {
            $('#paid_des').slideDown();
        } else {
            $('#paid_des').slideUp();
        }   
    }
    
    function time_check(_form, _id) {
            
        if ($('#start_'+_id).val() > $('#end_'+_id).val()) {
            alert("시작 시간이 종료 시간보다 큽니다.");
            document.space_r2_form.start.focus();
            return false;
        }
        
        var now = new Date(); 
        var todayAtMidn = new Date(now.getFullYear(), now.getMonth(), now.getDate(), now.getHours(), now.getMinutes());
        var _date = $('#date_'+_id).val();
        var specificDate = new Date(_date.substr(0,4),(_date.substr(5,2)-1),_date.substr(8,2), $('#start_'+_id).val().substr(0,2), $('#start_'+_id).val().substr(3,2));

        if (todayAtMidn.getTime() > specificDate.getTime())
        {
            alert("신청일자 시작 시간이 현재 시간보다 빠릅니다.");
            document.space_r2_form.start.focus();
            return false;
        }
        
        var frm = $('form[name='+_form+']');
        var get_url = '/ajax_front/check_space';
        var set_data = frm.serialize();

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
                    alert('이용할 수 있습니다.');
                }
            }
        });

    }

    function submit_space_r(_form, _id) {
        
        if (!$('#date_'+_id).val()) {
            alert("신청일자를 입력해주세요.");
            $('#date_'+_id).focus();
            return false;
        }

        if ($('#start_'+_id).val() > $('#end_'+_id).val()) {
            alert("시작 시간이 종료 시간보다 큽니다.");
            $('#start_'+_id).focus();
            return false;
        }

        if ( ! $('input[name=reserved]').val()) {
            if (!$('#purpose_'+_id).val()) {
                alert("행사명을 입력해주세요.");
                $('#purpose_'+_id).focus();
                return false;
            }
            if ($('#privacy').val() !== "1") {
                alert("개인정보 활용에 동의해주세요.");
                $('#privacy').focus();
                return false;
            }
        }
            
        var now = new Date(); 
        var todayAtMidn = new Date(now.getFullYear(), now.getMonth(), now.getDate(), now.getHours(), now.getMinutes());
        var _date = $('#date_'+_id).val();
        var specificDate = new Date(_date.substr(0,4),(_date.substr(5,2)-1),_date.substr(8,2), $('#start_'+_id).val().substr(0,2), $('#start_'+_id).val().substr(3,2));

        if (todayAtMidn.getTime() > specificDate.getTime())
        {
            alert("신청일자 시작 시간이 현재 시간보다 빠릅니다.");
            $('#start_'+_id).focus();
            return false;
        }

        var frm = $('form[name='+_form+']');
        var get_url = '/ajax_front/check_space';
        var set_data = frm.serialize();

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
                    if (_id === 3)
                        document.space_r3_form.submit();
                    else
                        document.space_r2_form.submit();
                }
            }
        });

    }
    
//]]>
</script>    