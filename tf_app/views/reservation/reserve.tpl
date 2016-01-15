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
            <!-- content -->
            <div class="content ">
                
                <div id="floor-formApply" class="panel panel-default">
                    <div class="panel-heading">
                        <h3>예약하기</h3>
                    </div> 
                    {? ok == 1}
                    <div class="panel-body" id="applyE_res">
                        <div class="complete"> 
                            <h3 class="text-center"><span class="icon icon-smile icon-large"></span>&nbsp;  예약완료!!</h3>
                            <div class="well text-center">예약 신청이 완료되었습니다.<br>관리자의 승인대기 중이며, 개인 액티비티에서 확인 가능합니다.</div>
                            <div class="text-center"><a href="/" class="btn btn-default">홈으로</a></div>
                        </div>
                    </div>
                    {/}
                    {? ok == 2}
                    <div class="panel-body" id="applyE_res">
                        <div class="complete"> 
                            <h3 class="text-center"><span class="icon icon-smile icon-large"></span>&nbsp;  예약완료!!</h3>
                            <div class="well text-center">예약 신청이 완료되었습니다.</div>
                            <div class="text-center"><a href="/" class="btn btn-default">홈으로</a></div>
                        </div>
                    </div>
                    {/}   
                    <div class="panel-body applycheck" {? ok}style="display: none;"{/}>
                        {? s}
                        <div class="apply-form">
                            <form class="form-horizontal" name="space_r_form" method="post" action="/space/reserve" onsubmit="return false;">
                                <input type="hidden" name="id" value="{res.id}" />
                                <fieldset>
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-3 col-md-3 control-label">신청일자</div>
                                        <div class="col-xs-12 col-sm-8 col-md-8 control-input"> 
                                            <!-- datepicker -->
                                            <div class="bfh-datepicker" data-format="{?res.date}{res.date}{:}y.m.d{/}">
                                                <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                    <input type="text" class="form-control datepicker" id="inputStartDate" name="date" value="{res.date}">
                                                </div>
                                                <div class="bfh-datepicker-calendar">
                                                    <table class="calendar table table-bordered">
                                                        <thead>
                                                            <tr class="months-header">
                                                                <th class="month" colspan="4"> <a class="previous" href="#"><span class="icon-chevron-left"></span></a> <span></span> <a class="next" href="#"><span class="icon-chevron-right"></span></a> </th>
                                                                <th class="year" colspan="3"> <a class="previous" href="#"><span class="icon-chevron-left"></span></a> <span></span> <a class="next" href="#"><span class="icon-chevron-right"></span></a> </th>
                                                            </tr>
                                                            <tr class="days-header"> </tr>
                                                        </thead>
                                                        <tbody>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <!-- /datepicker --> 
                                        </div>
                                    </div>
                                    <!-- / form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-3 col-md-3 control-label">신청자</div>
                                        <div class="col-xs-12 col-sm-8 col-md-8 control-input">
                                            <input type="hidden" class="form-control" name="user_id" value="{?res.user_id}{res.user_id}{:}{s.id}{/}">
                                            <input type="text" class="form-control" name="user_name" value="{?res.user_name}{res.user_name}{:}{s.name}{/}">
                                        </div>
                                    </div>
                                    <!-- / form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-3 col-md-3 control-label">장소</div>
                                        <div class="col-xs-12 col-sm-8 col-md-8 control-input">
                                            <select class="selectpicker" data-width="auto" name="space_id">
                                                {@ space}
                                                <option value="{.id}" {? res.space_id == .id}selected="selected"{/}>{? .opt}{.opt}F {/}{.name}</option>
                                                {/}
                                            </select>
                                        </div>
                                    </div>
                                    <!-- / form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-3 col-md-3 control-label">목적</div>
                                        <div class="col-xs-12 col-sm-8 col-md-8 control-input">
                                            <input type="text" class="form-control" name="purpose" value="{res.purpose}">
                                        </div>
                                    </div>
                                    <!-- / form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-3 col-md-3 control-label">시작 시간</div>
                                        <div class="col-xs-12 col-sm-8 col-md-8 control-input"> 
                                            <!-- timepicker -->
                                            <div class="bfh-timepicker" data-time="{? res.start}{res.start}{:}10:00{/}" >
                                                <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> 
                                                    <span class="input-group-addon"><span class="icon-time"></span></span>
                                                    <input type="text" class="form-control timepicker" id="start_3" name="start" value="{res.start}" placeholder="시작시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                </div>
                                            </div>
                                            <!-- /timepicker --> 
                                        </div>
                                    </div>
                                    <!-- / form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-3 col-md-3 control-label">종료 시간</div>
                                        <div class="col-xs-12 col-sm-8 col-md-8 control-input"> 
                                            <!-- timepicker -->
                                            <div class="bfh-timepicker" data-time="{? res.end}{res.end}{:}12:00{/}" >
                                                <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> 
                                                    <span class="input-group-addon"><span class="icon-time"></span></span>
                                                    <input type="text" class="form-control timepicker" id="end_3" name="end" value="{res.end}" placeholder="종료시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default " type="button"><span class="icon-ok"></span><span class="sr-only">예약가능 체크</span></button>
                                                    </span>
                                                </div>
                                            </div>
                                            <!-- /timepicker --> 
                                        </div>
                                    </div>
                                    <!-- / form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-3 col-md-3 control-label">인원</div>
                                        <div class="col-xs-12 col-sm-8 col-md-8 control-input">
                                            <div class="input-group"> <span class="input-group-addon"><span class="icon-group"></span></span>
                                                <input type="number" class="form-control" name="cnt" value="{res.cnt}">
                                                <span class="input-group-addon">명</span> </div>
                                            <!-- /input-group --> 
                                        </div>
                                    </div>
                                    <!-- / form-group -->
                                    
                                    <div class="form-group form-submit">
                                        <div class="col-sm-offset-3 col-md-offset-3">
                                            <button class="btn btn-default" type="button" {? res}onclick="submit_space_c('{res.id}'); return false;"{:}onclick="location.href='/'"{/}>취소</button>
                                            <button class="btn btn-primary" type="submit" onclick="submit_space_r(); return false;">신청</button>
                                        </div>
                                    </div>
                                </fieldset>
                            </form>
                        </div>
                        {:}
                        로그인이 필요합니다.
                        {/}
                    </div>
                </div>
                <!-- / panel --> 
            
            </div>
            <!-- /content -->
        </div>
        <!-- /container --> 
    </div>
    <!-- /page-content --> 
    
</div>
<!-- /rowContent --> 

<script type="text/javascript">
//<![CDATA[
    
    function submit_space_r() {
        
        if (!$('input[name=date]').val()) {
            alert("신청일자를 입력해주세요.");
            document.space_r_form.date.focus();
            return false;
        }
        if (!$('input[name=purpose]').val()) {
            alert("목적을 입력해주세요.");
            document.space_r_form.purpose.focus();
            return false;
        }
        if (!$('input[name=cnt]').val() || $('input[name=cnt]').val() < 1) {
            alert("인원을 입력해주세요.");
            document.space_r_form.cnt.focus();
            return false;
        }
    
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
                else {
                    document.space_r_form.submit();
                }
            }
        });

    }
    
    function submit_space_c(_id) {
        alert("취소되었습니다.");
        
        location.href='/space/reserve/?cancel='+_id;
    }
    
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

//]]>
</script>    