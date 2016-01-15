
            <script>
                $('.dropdown-toggle').dropdown();
            </script>
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap">
                <!-- section -->
                <section> 
                    
                    <!-- panel -->
                    <div class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-cog"></span><span class="break"></span>공간 정보 등록</h2>
                            <div class="actions"> <span class="break"></span> <a title="" data-toggle="tooltip" class="btn-add" href="/admin_space/list_" data-original-title="공간 목록"><span class="glyphicon  glyphicon-align-justify"></span></a> </div>
                        </div>
                        <!-- /panel-heading -->
                        
                        <form class="form-horizontal" action="/admin_space/add" method="post">
                            <input type="hidden" id="f_name" name="option" value="">
                            <input type="hidden" id="f_id" name="id" value="{res.id}">
                            <!-- panel-body -->
                            <div class="panel-body">
                                <fieldset>
                                    <legend>공간 정보 입력</legend>
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >장소</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                             
                                            <div class="form-inline">
                                            <select name="opt" class="selectpicker" data-width="auto">
                                                <option value="2" {? res.opt == 2}selected{/}>2F</option>
                                                <option value="4" {? res.opt == 4}selected{/}>4F</option>
                                                <option value="5" {? res.opt == 5}selected{/}>5F</option>
                                                <option value="6" {? res.opt == 6}selected{/}>6F</option>
                                            </select> 
                                            
                                           <input type="text" class="form-control" placeholder="다목적홀" name="name" value="{res.name}">
                                            
                                            <select name="type" class="selectpicker" data-width="auto">
                                                <option value="1" {? res.type == 1}selected{/}>D.CAMP 회의실</option>
                                                <option value="2" {? res.type == 2}selected{/}>외부 행사 대관</option>
                                                <option value="3" {? res.type == 3}selected{/}>디자인 라운지 좌석 이용</option>
                                            </select>
                                            </div>
                                            
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >공유 허가 시간</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <!-- form-group-time -->
                                            <div class="form-group-time">
                                                    <!-- timepicker -->                                         
                                                    <div class="bfh-timepicker" data-time="{?res.start}{res.start}{:}08:00{/}" >
                                                      <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker">
                                                        <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
                                                        <input type="text" class="form-control timepicker" id="start_3" name="start" value="{res.start}" placeholder="시작시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                      </div>
                                                    </div>
                                                    <!-- /timepicker --> 
                                                <span>&sim;</span> 
                                                    <!-- timepicker -->                                         
                                                    <div class="bfh-timepicker" data-time="{?res.end}{res.end}{:}18:00{/}">
                                                      <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker">
                                                        <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
                                                        <input type="text" class="form-control timepicker" id="end_3" name="end" value="{res.end}" placeholder="종료시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                      </div>
                                                    </div>
                                                    <!-- /timepicker --> 
                                                
                                            </div>
                                           <!-- /form-group-time --> 
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >공유 허가 요일</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <label class="checkbox-inline">
                                                <input type="checkbox" id="inlineCheckbox1" value="1" name="day1" {? (res.days & settings->day1) == settings->day1}checked="checked"{/}>
                                                월 </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" id="inlineCheckbox2" value="2" name="day2" {? (res.days & settings->day2) == settings->day2}checked="checked"{/}>
                                                화 </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" id="inlineCheckbox3" value="4" name="day3" {? (res.days & settings->day3) == settings->day3}checked="checked"{/}>
                                                수 </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" id="inlineCheckbox4" value="8" name="day4" {? (res.days & settings->day4) == settings->day4}checked="checked"{/}>
                                                목 </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" id="inlineCheckbox5" value="16" name="day5" {? (res.days & settings->day5) == settings->day5}checked="checked"{/}>
                                                금 </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" id="inlineCheckbox6" value="32" name="day6" {? (res.days & settings->day6) == settings->day6}checked="checked"{/}>
                                                토 </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" id="inlineCheckbox7" value="64" name="day7" {? (res.days & settings->day7) == settings->day7}checked="checked"{/}>
                                                일 </label>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >공간 선택 목록 노출</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <label class="radio-inline">
                                                <input type="radio" name="visible" value="1" {? res.visible}checked="checked"{/}>
                                                보임 </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="visible" value="0" {? !res.visible}checked="checked"{/}>
                                                숨김 </label>
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
                                    <button type="button" class="btn btn-default">취소</button>
                                    <button type="submit" class="btn btn-primary">등록</button>
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