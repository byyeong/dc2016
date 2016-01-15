<!-- rowContent -->
<div class="rowContent" id="reservation">
    <div class="page-header">
        <div class="container">
            <h2><a href="/space"> Reservation</a></h2>
        </div>
    </div>
    <!-- /page-header --> 
    
    <!-- page-content -->
    <div class="page-content"> 
        <!-- container -->
        <div class="container">  

                <div class="full-content floor-desc "> 
                <h3><span class="icon-share-alt"></span> 여럿이 함께 모여 내일을 준비하는 공간, 여러분과 공유합니다 </h3>      
                <div class="row">
                    <div class="carousel-wrap col-sm-12 col-md-10">
                        <div class="carousel slide" id="carousel-example-generic">
                            <ol class="carousel-indicators">
                                <li class="active" data-slide-to="0" data-target="#carousel-example-generic"></li>
                                <li data-slide-to="1" data-target="#carousel-example-generic"></li>
                                <li data-slide-to="2" data-target="#carousel-example-generic"></li>
                            </ol>
                            <div class="carousel-inner ">
                                <div class="item active row"> 
                                    <div class="col-sm-12 col-md-5"><img data-src="holder.js/420x160" src="/img/4f.jpg" class="img-responsive"></div>
                                    <div class="col-sm-12 col-md-7 caption"> <strong>4F: Solo, but not alone</strong>
                                        <p>여럿이 함께 모여 내일을 준비하는 공간입니다. 선정릉이 창 밖으로 펼쳐지며, 열정 가득한 이들의 에너지를 피부로 느낄 수 있습니다. 열심히 작업한 뒤 커피 한 잔의 여유를 만끽 하세요. 회의 공간도 있습니다. D.CAMP의 Co-working space로 여러분을 초대합니다.</p>
                                    </div>
                                </div>
                                <!--/item -->
                                <div class="item row"> 
                                    <div class="col-sm-12 col-md-5"><img data-src="holder.js/420x160" src="/img/5f.jpg" class="img-responsive"></div>
                                    <div class="col-sm-12 col-md-7 caption"> <strong>5F : Stay Hungry, Stay Foolish</strong>
                                        <p>남다른 열정과 아이디어, 가능성을 지닌 스타트업들이 내일을 준비하는 공간입니다. Kstartup, 그리고 청년창업사관학교 우수 졸업자들이 이미 터를 잡았습니다. 짧은 기간 동안 현재의 제품과 서비스를 업그레이드하기 위해 가속도를 냅니다. 필요한 경험과 지식을 나눌 수 있는 D.CAMP 교육 프로그램도 여기서 진행됩니다.</p>
                                    </div>
                                </div>
                                <!--/item -->
                                <div class="item row"> 
                                    <div class="col-sm-12 col-md-5"><img data-src="holder.js/420x160" src="/img/6f.jpg" class="img-responsive"></div>
                                    <div class="col-sm-12 col-md-7 caption"> <strong>6F : We Are All Connected</strong>
                                        <p>다양하고 풍부한 관계 속에서 새로운 가치가 탄생합니다. 대한민국 창업 생태계를 꽃 피우기 위해 D.CAMP가 준비한 200석 규모의 다목적 홀입니다. 선정릉의 환상적 풍경이 내려다 뵈는 멋진 테라스도 있습니다.</p>
                                    </div>
                                </div>
                                <!--/item -->
                            </div>
                        </div>
                        <!-- /carousel -->
                    </div>

                    <div class="col-sm-12 col-md-2 text-center">
                        {? (s.per & settings->permission2) == settings->permission2 || (s.per & settings->permission1) == settings->permission1}
                        <button class="btn btn-default btn-primary" onclick="javascript:location.href='/space#floor-formApply'">예약하기</button>
                        {:}
                        <button class="btn btn-default btn-primary" onclick="javascript:alert('공간공유 신청 권한이 없습니다.');">예약하기</button>
                        {/}
                    </div>
                </div>
                <!-- /floor-desc -->
            </div>
            
            <br />
            <div id="floor-formApply" class="editor">
                {? ok}
                <div class="edit-body">
                    <div class="complete">
                        <h4 class="text-center"><span class="icon icon-smile icon-large"></span>&nbsp;  신청완료!!</h4>
                        <div class="well text-center">예약 신청이 완료되었습니다. <br>
                            신청한 예약는 승인대기 중이며, 승인완료되면 안내 메일을 보내드립니다.</div>
                        <div class="text-center"><a href="#" class="btn btn-default">홈으로</a></div>
                    </div>
                </div>
                {:}
                <div class="edit-header">
                    <h3><span class="icon-edit"></span> 공간 예약하기</h3>
                    <p>D.CAMP는 미팅, 회의, 행사 등 여러 목적으로 사용되는 공간을 공유하고 있습니다. <br>
                    아래의 목적을 선택후 해당 내용을 입력해주세요. </p>
                </div>
                   
                <div class="edit-body" {? ok}style="display: none;"{/}>
                    {? s.id == ress.user_id}
                    <div class="apply-form">
                        <div class="form-horizontal">
                              
                            <div id="form-reserve-sharing" class="form-group-wrap well" {? ress.type > 2}style="display: none"{/}>
                                <form class="form-horizontal" name="space_r2_form" id="space_r2_form" method="post" action="/space/reserve/{ress.id}" onsubmit="return false;">
                                    <input type="hidden" name="id" value="{ress.id}" />
                                    {? (s.per & settings->permission1) == settings->permission1}
                                    <input type="hidden" name="state" value="1">
                                    {:}<input type="hidden" name="state" value="0">{/}
                                    <input type="hidden" name="user_id" value="{ress.user_id}" />
                                    <input type="hidden" name="user_name" value="{ress.user_name}" />
                                    <input type="hidden" name="date_created" value="true" />
                                    <fieldset>

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 신청목적</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 ">
                                            <select data-width="auto" class="selectpicker" id="check_type" onchange="sel_type(); return false;">
                                                <option value="1" {? ress.type == 1} selected="selected"{/}>회의실 이용 신청 </option>
                                                <option value="2" {? ress.type == 2} selected="selected"{/}>외부 행사 대관 신청</option>
                                            </select>
                                        </div>
                                    </div>
                                    <!-- / form-group -->

                                    <div class="form-group s_type_1" {? ress.type == 2}style="display: none;"{/}>
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 공간 선택</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 ">
                                            <select class="selectpicker" data-width="auto" {? ress.type == 1}name="space_id"{/}>
                                                {@ space}{? .type == 1}
                                                <option value="{.id}" {? ress.space_id == .id}selected="selected"{/}>{? .opt}{.opt}F {/}{.name}</option>
                                                {/}{/}
                                            </select>
                                        </div>
                                    </div>
                                    <!-- / form-group -->

                                    <div class="form-group s_type_2" {? ress.type == 1}style="display: none;"{/}>
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 공간 선택</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 ">
                                            <select class="selectpicker" data-width="auto" {? ress.type == 2}name="space_id"{/}>
                                                {@ space}{? .type == 2}
                                                <option value="{.id}" {? ress.space_id == .id}selected="selected"{/}>{? .opt}{.opt}F {/}{.name}</option>
                                                {/}{/}
                                            </select>
                                        </div>
                                    </div>
                                    <!-- / form-group -->


                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 신청 일자</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 "> 
                                            <!-- datepicker -->
                                            <div class="bfh-datepicker" data-format="{?ress.date}{ress.date}{:}y.m.d{/}">
                                                <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                    <input type="text" class="form-control datepicker" id="date_2" name="date" value="{ress.date}">
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
                                                <div class="bfh-timepicker" data-time="{? ress.start}{ress.start}{:}10:00{/}" >
                                                    <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                        <input type="text" class="form-control timepicker" id="start_2" name="start" value="{ress.start}" placeholder="시작시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                    </div>
                                                </div>
                                                <!-- /timepicker --> 
                                                <span class="sim">&sim;</span>
                                                <!-- timepicker -->
                                                <div class="bfh-timepicker" data-time="{? ress.end}{ress.end}{:}12:00{/}" >
                                                    <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                        <input type="text" class="form-control timepicker" id="end_2" name="end" value="{ress.end}" placeholder="종료시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                    </div>
                                                </div>
                                                <!-- /timepicker -->  
                                                <button title="" data-toggle="tooltip" type="button" class="btn btn-default " data-original-title="예약체크" onclick="time_check('space_r2_form', 2); return false;"><span class="icon-ok"></span><span class="sr-only">예약가능 체크</span></button>
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
                                                <option value="1" {? ress.user_type == 1}selected="selected"{/}>개인</option>
                                                <option value="2" {? ress.user_type == 2}selected="selected"{/}>단체</option>
                                            </select>

                                            <!-- todo : 개인일때 노출 됨 -->
                                            <div class="form-group-sub" id="user_per" {? ress.user_type == 2}style="display: none;"{/}>
                                                <p>
                                                    <label>개인에 대한 간단한 소개를 써주세요.</label>
                                                    <textarea class="form-control" rows="3" name="user_bio" placeholder="신청단체에 대한 간단한 소개를 써주세요">{ress.user_bio}</textarea>
                                                </p>
                                            </div> 
                                            <!-- /form-group-sub -->  

                                            <!-- todo : 단체일때 노출 됨 -->
                                            <div class="form-group-sub" id="user_gr" {? ress.user_type == 1 || !ress}style="display: none;"{/}>
                                                <p>
                                                    <label>단체에 대한 간단한 소개를 써주세요.</label>
                                                    <textarea class="form-control" name="group_bio" rows="3" placeholder="신청단체에 대한 간단한 소개를 써주세요">{ress.group_bio}</textarea>
                                                </p>
                                                <p>
                                                    <label>홈페이지 주소를 입력해주세요</label>
                                                    <input type="text" name="group_web" value="{ress.group_web}" class="form-control" placeholder="http://"></input>
                                                </p>
                                            </div> 
                                            <!-- /form-group-sub -->                                            
                                        </div>
                                    </div>
                                    <!-- / form-group -->

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 행사명</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 "> 
                                            <input type="text" class="form-control" name="purpose" id="purpose_2" value="{ress.purpose}">
                                            <span class="help-block">행사명을 알려 주세요</span>                                             
                                        </div>
                                    </div>
                                    <!-- / form-group -->

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">관련 행사 주소</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 ">
                                            <div class="input-group"> <span class="input-group-addon"><span class="icon-fixed-width icon-link"></span></span>
                                                <input type="text" placeholder="http://" class="form-control" name="rel_url" value="{ress.rel_url}">
                                            </div>
                                            <!-- /input-group -->
                                            <span class="help-block">D.CAMP에서 진행되는 관련된 행사가 있으면 주소를 입력해주세요.</span> 
                                        </div>
                                    </div>
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">행사 소개</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 "> 
                                            <textarea class="form-control" rows="3" name="purpose_des" id="purpose_des_2">{ress.purpose_des}</textarea>  
                                            <span class="help-block">행사의 취지, 주요 프로그램 등을 자세히 알려 주세요</span>                                             
                                        </div>
                                    </div>
                                    <!-- / form-group -->

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">참여자</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 "> 
                                            <textarea class="form-control" rows="3" name="users_info">{ress.users_info}</textarea>  
                                            <span class="help-block">예상 인원수와 어떤 분들이 주로 참여하는 알려주세요</span>                                               
                                        </div>
                                    </div>
                                    <!-- / form-group -->

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">참가비 여부</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 ">
                                            <label class="form-control-static">참가자들에게 비용을 받는 행사입니까?</label><br>
                                            <select class="selectpicker" data-width="auto" id="paid" name="paid" onchange="check_paid(); return false;">
                                                <option value="0" {? ress.paid == 0}selected="selected"{/}>아니오</option>
                                                <option value="1" {? ress.paid == 1}selected="selected"{/}>네</option>
                                            </select>

                                            <!-- todo : "네"일때 노출 됨 -->
                                            <div class="form-group-sub" id="paid_des" {? !ress.paid}style="display: none;"{/}>
                                                <p>
                                                    <label>참가비와 이를 받는 취지는 무엇입니까? </label>
                                                    <textarea class="form-control" name="paid_des">{ress.aid_des}</textarea>  
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
                                                <option value="0" {? ress.meal == 0}selected="selected"{/}>아니오</option>
                                                <option value="1" {? ress.meal == 1}selected="selected"{/}>네</option>
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
                                                <option value="0" {? ress.Invit == 0}selected="selected"{/}>아니오</option>
                                                <option value="1" {? ress.Invit == 1}selected="selected"{/}>네</option>
                                            </select>                           
                                        </div>
                                    </div>
                                    <!-- / form-group -->

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">연락처</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 ">
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="icon-fixed-width icon-phone"></span></span>
                                                <input type="text" class="form-control" name="tel" value="{ress.tel}">
                                            </div>
                                            <!-- /input-group -->  

                                            <div class="input-group">
                                                <span class="input-group-addon"><span class=" icon-fixed-width icon-envelope-alt"></span></span>
                                                <input type="text" class="form-control" name="email" value="{ress.email}">
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

                                    <div class="form-group form-submit"> 
                                        <div class="col-xs-12 col-sm-offset-2 col-md-offset-2 col-sm-10 col-md-10">
                                            {? ress.date > date('Y.m.d')}
                                            <button class="btn btn-default" type="button" onclick="javascript:location.href='/space'">취소</button>
                                            <button class="btn btn-primary" type="submit" onclick="submit_space_r('space_r2_form', 2); return false;">재신청</button>
                                            <small>재신청 시, 다시 승인을 받아야 합니다.</small>
                                            {/}
                                            <span class="pull-right"><a class="btn btn-warning" href="#" onclick="del_confirm('submit_space_c({ress.id})'); return false;">삭제</a> </span>
                                        </div> 
                                    </div>

                                    </fieldset>
                                </form>
                            </div>
                            <!-- /form-reserve-sharing -->

                            <div id="form-reserve-design" class="form-group-wrap well" {? ress.type < 3}style="display: none"{/}>
                                <form name="space_r3_form" class="form-horizontal" id="space_r3_form" method="post" action="/space/reserve/{ress.id}" onsubmit="return false;">
                                    <fieldset>
                                        <h4>'D.esign 라운지' 예약하기</h4>

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label">공간 선택</div>
                                            <div class="col-xs-12 col-sm-10 col-md-10 ">
                                                <select class="selectpicker" name="cnt">
                                                    <option value="1" {? ress.cnt == 1}selected="selected"{/}>원더우먼(iMac)</option>
                                                    <option value="2" {? ress.cnt == 2}selected="selected"{/}>배트맨 (PC)</option>
                                                    <option value="3" {? ress.cnt == 3}selected="selected"{/}>슈퍼걸 (iMac)</option>
                                                    <option value="4" {? ress.cnt == 4}selected="selected"{/}>조커(PC)</option>
                                                </select>
                                            </div>
                                        </div>
                                        <!-- / form-group -->
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 신청 일자</div>
                                            <div class="col-xs-12 col-sm-10 col-md-10 "> 
                                                <!-- datepicker -->
                                                <div class="bfh-datepicker" data-format="{?ress.date}{ress.date}{:}y.m.d{/}">
                                                    <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                        <input type="text" class="form-control datepicker" id="date_3" name="date" value="{? rdate}{rdate}{:}{ress.date}{/}">
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
                                                    <div class="bfh-timepicker" data-time="{? ress.start}{ress.start}{:}10:00{/}" >
                                                        <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                            <input type="text" class="form-control timepicker timepickermm" id="start_3" name="start" value="{ress.start}" placeholder="시작시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                        </div>
                                                    </div>
                                                    <!-- /timepicker --> 
                                                    <span class="sim">&sim;</span>
                                                    <!-- timepicker -->
                                                    <div class="bfh-timepicker" data-time="{? ress.end}{ress.end}{:}12:00{/}" >
                                                        <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                            <input type="text" class="form-control timepicker timepickermm" id="end_3" name="end" value="{ress.end}" placeholder="종료시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                        </div>
                                                    </div>
                                                    <!-- /timepicker -->  
                                                    <button title="" data-toggle="tooltip" type="button" class="btn btn-default " data-original-title="예약체크" onclick="time_check('space_r3_form', 3); return false;"><span class="icon-ok"></span><span class="sr-only">예약가능 체크</span></button>
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
                                                <input type="text" class="form-control" name="purpose" value="{ress.purpose}">
                                            </div>
                                        </div>
                                        <!-- / form-group -->


                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label">연락처</div>
                                            <div class="col-xs-12 col-sm-10 col-md-10 ">
                                                <div class="input-group"> <span class="input-group-addon"><span class="icon-fixed-width icon-phone"></span></span>
                                                    <input type="text" class="form-control" name="tel" value="{ress.tel}">
                                                </div>
                                                <!-- /input-group -->
                                                
                                                <div class="input-group"> <span class="input-group-addon"><span class=" icon-fixed-width icon-envelope-alt"></span></span>
                                                    <input type="text" class="form-control" name="email" value="{ress.email}">
                                                </div>
                                                <!-- /input-group --> 
                                            </div>
                                        </div>
                                        <!-- / form-group -->

                                        <div class="form-group form-submit">
                                            <div class="col-xs-12 col-sm-offset-2 col-md-offset-2 col-sm-10 col-md-10">
                                                {? ress.date > date('Y.m.d')}
                                                <button class="btn btn-default" type="button" onclick="javascript:location.href='/space'">취소</button>
                                                <button class="btn btn-primary" type="submit" onclick="submit_space_r('space_r3_form', 3); return false;">재신청</button>
                                                <small>재신청 시, 다시 승인을 받아야 합니다.</small>
                                                {/}
                                                <span class="pull-right"><a class="btn btn-warning" href="#" onclick="del_confirm('submit_space_c({ress.id})'); return false;">삭제</a> </span>
                                            </div>
                                        </div> 
                                        
                                        <input type="hidden" name="id" value="{ress.id}" />
                                        {? (s.per & settings->permission1) == settings->permission1}
                                        <input type="hidden" name="state" value="1">
                                        {:}<input type="hidden" name="state" value="0">{/}
                                        <input type="hidden" name="user_id" value="{ress.user_id}" />
                                        <input type="hidden" name="user_name" value="{ress.user_name}" />
                                        <input type="hidden" name="date_created" value="true" />
                                        <input type="hidden" name="spacee_id" value="{ress.space_id}" />
                                        <input type="hidden" name="space_id" value="{ress.space_id}" />
                                    </fieldset>
                                </form>
                            </div>
                            <!-- /form-reserve-design -->  
                            
                        </div>
                    </div>
                    {:}
                    신청자 정보가 일치하지 않습니다. 공간공유를 신청한 계정으로 로그인 해주세요.
                    {/}
                </div>
                {/}
            </div>
            <!-- / panel --> 
            
             
        </div>
        <!-- /container -->
    </div>
    <!-- /page-content --> 
    
</div>
<!-- /rowContent --> 

<script type="text/javascript">
//<![CDATA[
    
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
    
    // popover
    $('.container').popover ({
        selector: "[data-toggle=popover]",
        trigger: "hover",
        title: "공간예약정보",
        html: 'true',
        content : ""
    }) 
    
    function time_check(_form, _id) {
            
        if ($('#start_'+_id).val() > $('#end_'+_id).val()) {
            alert("시작 시간이 종료 시간보다 늦습니다.");
            document.space_r_form.start.focus();
            return false;
        }
        
        var now = new Date(); 
        var todayAtMidn = new Date(now.getFullYear(), now.getMonth(), now.getDate(), now.getHours(), now.getMinutes());
        var _date = $('#date_'+_id).val();
        var specificDate = new Date(_date.substr(0,4),(_date.substr(5,2)-1),_date.substr(8,2), $('#start_'+_id).val().substr(0,2), $('#start_'+_id).val().substr(3,2));

        if (todayAtMidn.getTime() > specificDate.getTime())
        {
            alert("신청일자 시작 시간이 현재 시간보다 빠릅니다.");
            document._form.start.focus();
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

        if (_form != 'space_r3_form') {
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
            
        if ($('#start_'+_id).val() > $('#end_'+_id).val()) {
            alert("시작 시간이 종료 시간보다 큽니다.");
            $('#start_'+_id).focus();
            return false;
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
                    if (_id < 3)
                        document.space_r2_form.submit();
                    else if (_id == 3)
                        document.space_r3_form.submit();
                }
            }
        });

    }
    
    function submit_space_c(_id) {
        alert("처리되었습니다.");
        
        location.href='/space/reserve/{ress.id}?cancel='+_id;
    }
    
{*    
    function check_space(){
        var frm = $('form[name=space_r_form]');
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
            }
        });
    }
*}

//]]>
</script>    