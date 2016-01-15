<script>
$(function() {
    $( ".datepicker" ).datepicker({ dateFormat: 'yy.mm.dd',  viewMode: 2 });
});
</script>

                                                    <!-- well -->
                                                    <div class="well well-small" id="add_incubate_{v}">
                                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >인큐베이터</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10"> 
                                                                <input type="text" class="form-control" name="incubator_{v}" >
                                                            </div>
                                                        </div>
                                                            
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >프로그램 상세</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10"> 
                                                                <textarea name="des_{v}" class="form-control" rows="3"></textarea>
                                                            </div>
                                                        </div>
                                                            
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >이메일 주소</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10"> 
                                                                <input type="email" class="form-control" name="ic_email_{v}" >
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >인큐베이팅 기간</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10"> 
                                                                <!-- form-inline -->
                                                                <div class="form-inline">
                                                                    <div class="form-group">
                                                                        <label class="sr-only" for="inputStartTime">시작일</label>
                                                                        <div class="bfh-datepicker" data-format="y.m.d">
                                                                            <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                                                <input type="text" class="form-control datepicker" name="start_{v}" value="" placeholder="" readonly>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <span>&sim;</span>
                                                                    <div class="form-group">
                                                                        <label class="sr-only" for="inputEndtTime">종료일</label>
                                                                        <div class="bfh-datepicker" data-format="y.m.d">
                                                                            <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                                                <input type="text" class="form-control datepicker" name="end_{v}" value="" placeholder="" readonly>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <!-- /form-inline --> 
                                                            </div>
                                                        </div>
                                                        
                                                    </div>
                                                    <!-- /well --> 