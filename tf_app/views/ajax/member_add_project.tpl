<script>
  $(function() {
    $( ".datepicker" ).datepicker({ dateFormat: 'yy.mm.dd' }).val();
  });
</script>                                            
                                            <!-- repat -->
                                            <div class="well form-sub-line" id="add_project_{v}">
                                                <button type="button" class="close" aria-hidden="true" data-toggle="tooltip" title="삭제" onclick="del_box(this); return false;" >&times;</button>
                                                <div class="form-inline">
                                                    <div class="form-group">
                                                        <label class="sr-only" for="projectName1">프로젝트명</label>
                                                        <input type="text" class="form-control" id="projectName1" name="project_{v}" placeholder="프로젝트명">
                                                    </div>
                                                </div>
                                                <div class="form-group-date">
                                                    <label class="sr-only" for="inputProjectStartDate">시작일</label>
                                                    <!-- datepicker -->
                                                    <div class="bfh-datepicker" data-format="y-m-d">
                                                        <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> 
                                                            <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                            <input type="text" class="form-control datepicker" name="p_start_{v}" placeholder="시작일" readonly>
                                                        </div>
                                                    </div>
                                                    <!-- /datepicker --> 
                                                   <span> &sim; </span> 
                                                    <label class="sr-only" for="inputProjectEndDate">종료일</label>
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