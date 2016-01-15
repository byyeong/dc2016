<script>
  $(function() {
    $( ".datepicker" ).datepicker({ dateFormat: 'yy.mm.dd' }).val();
  });
</script>
                                            <!-- repat  -->
                                            <div class="well form-sub-line" id="add_career_{v}">
                                                <button type="button" class="close" aria-hidden="true" data-toggle="tooltip" title="삭제" onclick="del_box(this); return false;" >&times;</button>
                                                <div class="form-inline">
                                                    <div class="form-group">
                                                        <label class="sr-only" for="careerCompany-1">회사명</label>
                                                        <input type="text" class="form-control"  id="careerCompany-1" name="company_{v}"  placeholder="회사명">
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="sr-only" for="careerWork-1">직책</label>
                                                        <input type="text" class="form-control" id="careerWork-1" name="role_{v}" placeholder="직책">
                                                    </div>
                                                </div>                                                
                                                <div class="form-group-date">
                                                    <label class="sr-only" for="inputStartDate">입사일</label>
                                                    <!-- datepicker -->
                                                    <div class="bfh-datepicker" data-format="y-m-d">
                                                        <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> 
                                                            <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                            <input type="text" class="form-control datepicker" name="c_start_{v}" placeholder="입사일" readonly>
                                                        </div>
                                                    </div>
                                                    <!-- /datepicker --> 
                                                   <span> &sim; </span> 
                                                    <label class="sr-only" for="inputEndDate">퇴사일</label>
                                                    <!-- datepicker -->
                                                    <div class="bfh-datepicker" data-format="y-m-d">
                                                        <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> 
                                                            <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                            <input type="text" class="form-control datepicker" name="p_end_{v}" placeholder="종료일" readonly>
                                                        </div>
                                                    </div>
                                                    <!-- /datepicker -->
                                                </div>
                                            </div>
                                            <!-- /repat -->
                                            