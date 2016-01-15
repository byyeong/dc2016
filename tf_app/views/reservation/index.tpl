<!-- rowContent -->
<div class="rowContent" id="reservation"> 
    <div class="page-header">
        <div class="container">
            <h2><a href="/space"> Reservation</a></h2>
        </div>
    </div>
    <!-- /page-header -->
    
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
                        <button class="btn btn-default btn-primary" onclick="javascript:location.href='#floor-formApply'">예약하기</button>
                        {:}
                        <button class="btn btn-default btn-primary" onclick="javascript:alert('공간공유 신청 권한이 없습니다.'); return false;">예약하기</button>
                        {/}
                    </div>
                </div>
                <!-- /floor-desc -->
            </div>
            
            
            {? (s.per & settings->permission7) == settings->permission7}
            <div class="well help-bizmember">
                <h5><span class="icon-briefcase"></span> &nbsp;  비즈니스센터 입주기업 회원 혜택</h5>
                <ul>
                    <li>비즈니스센터 입주기업은 공간 예약 신청시, 매달 10시간까지는 별도의 승인 절차 없이 예약이 가능합니다.</li>
                    <li>48시간 이내의 신청은 다른 신청자들과 마찬가지로 승인 과정을 통해서 사용해야 합니다. 이 경우에는 공간 예약 잔여 시간이 차감되지 않습니다.</li>
                </ul>
                <div class="text-center text-primary"><strong><span class="icon-time"></span> &nbsp;  {=date("Y")}년 {=date("m")}월, 공간 예약 잔여 시간은 {rest}시간 입니다.</strong></div>
            </div>
            {/}
                        
            <div class="floor-status" id="floor-status">
                <h3><span class="icon-reorder "></span> Reservation 현황</h3>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover table-striped">
                            <thead>
                                <tr>
                                    <th class="floor" width="60">&nbsp;</th>
                                    {@ res}
                                    <th {? .key_ == 5}class="sat"{/}{? .key_ == 6}class="sun"{/}>{.day} <small>{.date}</small></th>
                                    {/}
                                </tr>
                            </thead>
                            <tbody>
                                {? ev2}
                                <tr>
                                    <th>2F</th>
                                    {@ ev2}{? .space}
                                    <td>
                                        <ul class="list-unstyled">
                                            {@ .space}{? ..event}
                                            
                                            <li class="head"><strong> {=explode_ext(..name, '(')} </strong></li>
                                            {@ ..event}
                                            <li> <strong data-placement="top" data-toggle="popover" data-content="<img src='{...picture}' style='width: 30px;'> {...mname}님{? ...cnt} / {...cnt}명{/}">{...purpose}</strong> <span class="time"><span class="icon icon-time"></span> {...start}~{...end}</span> </li>
                                            
                                            {/}
                                            <li class="divider"></li>
                                            {/}{/}
                                        </ul>
                                    </td>
                                    {:}
                                    <td><div class="none"><span class="icon icon-ellipsis-horizontal "></span></div></td>
                                    {/}{/}
                                </tr>
                                {/}
                                {? ev4}
                                <tr>
                                    <th>4F</th>
                                    {@ ev4}{? .space}
                                    <td>
                                        <ul class="list-unstyled">
                                            {@ .space}{? ..event}
                                            
                                            <li class="head"><strong> {=explode_ext(..name, '(')} </strong></li>
                                            {@ ..event}
                                            <li> <strong data-placement="top" data-toggle="popover" data-content="<img src='{...picture}' style='width: 30px;'> {...mname}님{? ...stype==3}/ {? ...cnt==1}원더우먼(iMac){/}{? ...cnt==2}배트맨(PC){/}{? ...cnt==3}슈퍼걸(iMac){/}{? ...cnt==4}조커(PC){/}{:}{? ...cnt} / {...cnt}명{/}{/}">{...purpose}</strong> <span class="time"><span class="icon icon-time"></span> {...start}~{...end}</span> </li>
                                            
                                            {/}
                                            <li class="divider"></li>
                                            {/}{/}
                                        </ul>
                                    </td>
                                    {:}
                                    <td><div class="none"><span class="icon icon-ellipsis-horizontal "></span></div></td>
                                    {/}{/}
                                </tr>
                                {/}
                                {? ev5}
                                <tr>
                                    <th>5F</th>
                                    {@ ev5}{? .space}
                                    <td><ul class="list-unstyled">
                                            {@ .space}{? ..event}
                                            <li class="head"><strong> {=explode_ext(..name, '(')} </strong></li>
                                            {@ ..event}
                                            <li> <strong data-placement="top" data-toggle="popover" data-content="<img src='{...picture}' style='width: 30px;'> {...mname}님{? ...cnt} / {...cnt}명{/}">{...purpose}</strong> <span class="time"><span class="icon icon-time"></span> {...start}~{...end}</span> </li>
                                           
                                            {/}
                                            <li class="divider"></li>
                                            {/}{/}
                                        </ul>
                                    </td>
                                    {:}
                                    <td><div class="none"><span class="icon icon-ellipsis-horizontal "></span></div></td>
                                    {/}{/}
                                </tr>
                                {/}
                                {? ev6}
                                <tr>
                                    <th>6F</th>
                                    {@ ev6}{? .space}
                                    <td><ul class="list-unstyled">3
                                            {@ .space}{? ..event}2
                                            <li class="head"><strong> {=explode_ext(..name, '(')} </strong></li>
                                            {@ ..event}
                                            <li> <strong data-placement="top" data-toggle="popover" data-content="<img src='{...picture}' style='width: 30px;'> {...mname}님{? ...cnt} / {...cnt}명{/}">{...purpose}</strong> <span class="time"><span class="icon icon-time"></span> {...start}~{...end}</span> </li>
                                            
                                            {/}
                                            <li class="divider"></li>
                                            {/}{/}
                                        </ul>
                                    </td>
                                    {:}
                                    <td><div class="none"><span class="icon icon-ellipsis-horizontal "></span></div></td>
                                    {/}{/}
                                </tr>
                                {/}
                            </tbody>
                        </table> 
                    </div>
                    <!-- /table -->
                    <ul class="pager">
                        <li><a href="/reservation/{date}/1#floor-status"><span class="icon-chevron-left"></span></a></li>
                        <li><a href="/reservation/{date}/2#floor-status"><span class="icon-chevron-right"></span></a></li>
                    </ul>
              </div>  
              <!-- /floor-status -->
                     
                
            <div class="editor" id="floor-formApply">
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
                    {? s}{? (s.per & settings->permission2) == settings->permission2 || (s.per & settings->permission1) == settings->permission1} 
                    <div class="form-horizontal">
                        <div id="form-reserve-use" class="well">
                            <fieldset>
                            <h4> 예약 목적을 선택해주세요.</h4>
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 신청목적</div>
                                <div class="col-xs-12 col-sm-10 col-md-10 ">
                                    <select class="selectpicker" data-width="auto" name="purpose">
                                        <option value="1">공간공유</option>
                                        {*<option value="2">D.esign 라운지</option>*}
                                    </select> 
                                </div>
                            </div>
                            <!-- / form-group -->
                            <!--div class="form-group form-submit"> 
                                <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10 "> 
                                    <button class="btn btn-default" type="button"> 예약하기 </button>
                                </div>
                            </div-->
                            <!-- / form-group -->   
                            </fieldset>
                        </div>
                        <!-- /form-reserve-use -->
                                                   
                        <div id="form-reserve-sharing" class="form-group-wrap well">
                            <form name="space_r2_form" class="form-horizontal" id="space_r2_form" method="post" action="/space/reserve" onsubmit="return false;">
                                <fieldset>
                                    <h4>'공간공유' 예약하기</h4>

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 신청목적</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 ">
                                            <select data-width="auto" class="selectpicker" id="check_type" onchange="sel_type(); return false;">
                                                <option value="1">회의실 이용 신청 </option>
                                                <option value="2">외부 행사 대관 신청</option>
                                            </select>
                                        </div>
                                    </div>
                                    <!-- / form-group -->
        
                                    <div class="form-group s_type_1">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 공간 선택</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 ">
                                            <select class="selectpicker" data-width="auto" name="space_id">
                                                {@ space}{? .type == 1}
                                                <option value="{.id}" {? ress.space_id == .id}selected="selected"{/}>{? .opt}{.opt}F {/}{.name}</option>
                                                {/}{/}
                                            </select>
                                        </div>
                                    </div>
                                    <!-- / form-group -->

                                    <div class="form-group s_type_2" style="display: none;">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label"><span class="text-danger">*</span> 공간 선택</div>

                                        <div class="col-xs-12 col-sm-10 col-md-10 ">
                                            <select class="selectpicker" data-width="auto">
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
                                                    <input type="text" class="form-control datepicker" id="date_2" name="date" value="{? rdate}{rdate}{:}{ress.date}{/}">
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
                                                <input type="text" placeholder="http://" class="form-control" name="rel_url">
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
                                            <span class="help-block">핑거푸드나 샌드위치와 같은 간단한 음식만 가능합니다.</span>                              
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
                                                <option value="1" {? res}selected="selected"{/}>네</option>
                                                <option value="0">아니오</option>
                                            </select>                      
                                        </div>
                                    </div>
                                    <!-- / form-group -->

                                    <div class="form-group form-submit">
                                        <div class="col-xs-12 col-sm-offset-2 col-md-offset-2 col-sm-10 col-md-10">
                                            <button class="btn btn-default" type="button" {? res}onclick="submit_space_c('{ress.id}'); return false;"{:}onclick="javascript:document.location.href='/'"{/}>취소</button>
                                            <button class="btn btn-primary" type="submit" onclick="submit_space_r('space_r2_form', 2); return false;">예약하기</button>
                                        </div>
                                    </div>
                                    <input type="hidden" name="rest" value="{rest*60}" />
                                    <input type="hidden" name="id" value="{ress.id}" />
                                    <input type="hidden" name="user_id" value="{?ress.user_id}{ress.user_id}{:}{s.id}{/}" >
                                    <input type="hidden" name="user_name" value="{?ress.user_name}{ress.user_name}{:}{s.name}{/}" >
                                    {? (s.per & settings->permission1) == settings->permission1}<input type="hidden" name="state" value="1">{/}
                                </fieldset>
                            </form>
                        </div>
                        <!-- /form-reserve-sharing -->

                        <div id="form-reserve-design" class="form-group-wrap well" style="display: none;">
                            <form name="space_r3_form" class="form-horizontal" id="space_r3_form" method="post" action="/space/reserve" onsubmit="return false;">
                                <fieldset>
                                    <h4>'D.esign 라운지' 예약하기</h4>

                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">좌석 선택</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10 ">
                                            <select class="selectpicker" name="cnt">
                                                <option value="1">원더우먼(iMac)</option>
                                                <option value="2">배트맨 (PC)</option>
                                                <option value="3">슈퍼걸 (iMac)</option>
                                                <option value="4">조커(PC)</option>
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
                                            <button class="btn btn-default" type="button" {? res}onclick="submit_space_c('{ress.id}'); return false;"{:}onclick="javascript:document.location.href='/'"{/}>취소</button>
                                            <button class="btn btn-primary" type="submit" onclick="submit_space_r('space_r3_form', 3); return false;">예약하기</button>
                                        </div>
                                    </div> 
                                    <input type="hidden" name="space_id" value="{ds.id}" />
                                    <input type="hidden" name="id" value="{ress.id}" />
                                    <input type="hidden" name="user_id" value="{?ress.user_id}{ress.user_id}{:}{s.id}{/}" >
                                    <input type="hidden" name="user_name" value="{?ress.user_name}{ress.user_name}{:}{s.name}{/}" >
                                    {? (s.per & settings->permission1) == settings->permission1}<input type="hidden" name="state" value="1">{/}
                                </fieldset>
                            </form>
                        </div>
                        <!-- /form-reserve-design -->  
                    </div>
                        
                    {:}
                    <div class="alert alert-warning text-center">
                        <p>공간 예약은 '<a href="http://dcamp.kr/membership">멤버십 회원</a>'만 가능합니다. 지금 바로 <a href="http://dcamp.kr/membership">멤버십 회원</a>으로 신청해 보세요. </p>
                    </div>
                    {/}
                    {:}
                    <div class="alert text-center">
                        <p>공간 예약은 디캠프 회원에게 제공됩니다. <br>이미 가입하셨다면 로그인 후 진행해주세요.</p><br>
                        <a href="/login" class="btn btn-default  btn-sm">로그인하기</a>
                    </div>
                    {/}
                    
                </div>
                {/}
            </div>
            <!-- / editor --> 
            
             
        </div>
        <!-- /container -->
    </div>
    <!-- /page-content --> 
    
</div>
<!-- /rowContent --> 

<script type="text/javascript">
//<![CDATA[
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
                    if (_data.msg) {
                        alert(_data.msg);
                    } else {
                        alert('이용할 수 있습니다.');
                    }
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

        $('.form-actions .btn-primary').hide();
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
                    if (_id === 1)
                        document.space_r1_form.submit();
                    else if (_id === 2)
                        document.space_r2_form.submit();
                    else if (_id === 3)
                        document.space_r3_form.submit();
                }
            }
        });

    }
    
    function submit_space_c(_id) {
        alert("취소되었습니다.");
        
        location.href='/space/reserve/?cancel='+_id;
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