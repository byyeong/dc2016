<script>
  $(function() {
    $( ".datepicker" ).datepicker({ dateFormat: 'yy.mm.dd' }).val();
  });
</script>                                                    
<!-- well -->
                                                    <div class="well well-small" id="add_investment_{v}">
                                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                                        <div class="form-group"> 
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >투자자/기관</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10"> 
                                                                <input type="text" class="form-control" name="investor_{v}" >
                                                            </div>
                                                        </div>
                                                        <div class="form-group"> 
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >이메일 주소</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10"> 
                                                                <input type="email" class="form-control" name="iv_email_{v}" >
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >투자 일자</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10"> 
                                                                <div class="form-inline">
                                                                    <label class="sr-only" for="inputStartDate">투자일</label>
                                                                    <!-- datepicker -->
                                                                    <div class="bfh-datepicker" data-format="y-m-d">
                                                                        <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                                            <input type="text" class="form-control datepicker" id="inputStartDate" placeholder="" name="date_{v}" readonly>
                                                                        </div>
                                                                    </div>
                                                                    <!-- /datepicker --> 
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >투자 금액</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10"> 
                                                                <div class="form-inline"> 
                                                                    <!-- lenght-number -->
                                                                    <div class="form-group">
                                                                        <label for="inputMoney" class="sr-only">금액입력</label>
                                                                        <div class="input-group length-money"> <span class="input-group-addon">₩</span>
                                                                            <input type="text" id="inputMoney" class="form-control" name="investment_{v}">
                                                                        </div>
                                                                    </div>
                                                                    <!-- /lenght-number --> 
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >투자 형태</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10"> 
                                                                <input type="text" class="form-control" name="type_{v}" >
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- /well -->