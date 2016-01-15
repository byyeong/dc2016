<script>
  $(function() {
    $( ".datepicker" ).datepicker({ dateFormat: 'yy.mm.dd' }).val();
  });
</script>                              
                            <div class="panel-heading">
                                <h3>인큐베이팅 프로그램 / 기관 참여 내역</h3>
                                {? s && edi.user_id == s.id}
                                <button class="btn btn-default btn-xs" onclick="add_inc(); return false;">추가하기 </button>
                                {/}
                            </div>
                            <!-- /panel-heading --> 
                            
                            <div class="panel-body" id="inc_form_0" style="display: none;">
                                <ul class="item-list">
                                    <li class="item edit"> 
                                        <!-- TODO : edit 상태 -->
                                        <form  class="form-edit-set" name="inc_form_0">
                                            <input type="hidden" name="startup_id" value="{id}" />
                                            <fieldset>
                                                <button type="button" class="close" aria-hidden="true" data-toggle="tooltip" title="닫기" onclick="add_inc(); return false;">&times;</button>
                                                <div class="form-group">
                                                    <label class="sr-only" for="inputIncubator">인큐베이터</label>
                                                    <input type="text" class="form-control input-sm" id="inputIncubator" placeholder="인큐베이터" name="incubator">
                                                </div>
                                                <!-- /form-group -->
                                                
                                                <div class="form-group">
                                                    <label class="sr-only" for="inputIncubator">프로그램 상세</label>
                                                    <textarea name="description" placeholder="상세내용을 입력하세요" rows="3" class="form-control input-sm"></textarea>
                                                </div>
                                                <!-- /form-group -->
                                                
                                                <div class="form-group">
                                                    <label class="sr-only" for="inputIncubateEmail" >이메일 주소</label>
                                                    <div class="input-group input-group-sm"> 
                                                        <span class="input-group-addon"><span class="fa fa-fw fa-envelope"></span></span>
                                                        <input type="email" id="inputIncubateEmail" class="form-control" placeholder="이메일 주소" name="email">
                                                    </div>
                                                </div>
                                                <!-- /form-group -->
                                                
                                                <div class="form-group">
                                                    <label class="sr-only" for="inputIncubateDate">인큐베이팅 기간</label>
                                                    
                                                    <!-- form-group-date -->
                                                    <div class="form-inline">
                                                        <div class="form-period">
                                                            <div class="form-group form-start">
                                                                <label class="sr-only" for="inputIncubateStartDate">시작일</label>
                                                                <!-- datepicker -->
                                                                <div class="bfh-datepicker" data-format="y.m.d">
                                                                    <div class="input-group bfh-datepicker-toggle input-group-sm" data-toggle="bfh-datepicker"> 
                                                                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                        <input type="text" class="form-control datepicker" placeholder="시작일" name="start">
                                                                    </div>
                                                                </div>
                                                                <!-- /datepicker --> 
                                                            </div>
                                                        
                                                            <div class="form-group form-end">
                                                                <label class="sr-only" for="inputIncubateEndDate">종료일</label>
                                                                
                                                                <!-- datepicker -->
                                                                <div class="bfh-datepicker" data-format="y.m.d">
                                                                    <div class="input-group bfh-datepicker-toggle input-group-sm" data-toggle="bfh-datepicker"> 
                                                                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                        <input type="text" class="form-control datepicker" placeholder="종료일" name="end">
                                                                    </div>
                                                                </div>
                                                                <!-- /datepicker --> 
                                                            </div>
                                                        </div>
                                                        <!--
                                                        <div class="checkbox check-workNow">
                                                            <label>
                                                                <input type="checkbox">
                                                                참여중</label>
                                                        </div>
                                                        //-->
                                                    </div>
                                                    <!-- /form-group-date --> 
                                                </div>
                                                <!-- /form-group -->
                                                
                                                <div class="form-group form-submit">
                                                    <button class="btn btn-primary btn-sm" type="submit" onclick="submit_edit_inc(0); return false;">저장하기</button>
                                                    <button class="btn btn-default btn-sm pull-rights" onclick="add_inc(this); return false;">삭제하기</button>
                                                </div>
                                            </fieldset>
                                        </form>
                                    </li>
                                </ul>
                            </div>
                            <!-- /panel-body --> 

                            <div class="panel-body" {@ !incubat}style="display: none;"{/}>
                                <ul class="item-list">
                                    {@ incubat}
                                    <li class="item">
                                        <!-- TODO : normal 상태 -->
                                        <h4>{.incubator} <small><a href="mailto:#">{.email}</a></small></h4>
                                        {? s && edi.user_id == s.id}<button class="btn btn-default btn-xs" onclick="edit_inc(this); return false;">수정하기</button>{/}
                                        <p><span class="icon-calendar"></span> {.start} ~ {.end} </p>
                                        <div class="desc">{.description}</div>
                                    </li>
                                    <li class="item edit" style="display: none;"> 
                                        <!-- TODO : edit 상태 -->
                                        <form  class="form-edit-set" name="inc_form_{.id}">
                                            <input type="hidden" name="startup_id" value="{.startup_id}" />
                                            <input type="hidden" name="id" value="{.id}" />
                                            <fieldset>
                                                <button type="button" class="close" aria-hidden="true" data-toggle="tooltip" title="닫기" onclick="edit_inc2(this); return false;">&times;</button>
                                                <div class="form-group">
                                                    <label class="sr-only" for="inputIncubator">인큐베이터</label>
                                                    <input type="text" class="form-control input-sm" id="inputIncubator" placeholder="인큐베이터" name="incubator" value="{.incubator}">
                                                </div>
                                                <!-- /form-group -->
                                                
                                                <div class="form-group">
                                                    <label class="sr-only" for="inputIncubator">프로그램 상세</label>
                                                    <textarea name="description" placeholder="상세내용을 입력하세요" rows="3" class="form-control input-sm">{.description}</textarea>
                                                </div>
                                                <!-- /form-group -->
                                                
                                                <div class="form-group">
                                                    <label class="sr-only" for="inputIncubateEmail" >이메일 주소</label>
                                                    <div class="input-group input-group-sm"> 
                                                        <span class="input-group-addon"><span class="fa fa-fw fa-envelope"></span></span>
                                                        <input type="email" id="inputIncubateEmail" class="form-control" placeholder="이메일 주소"  name="email" value="{.email}">
                                                    </div>
                                                </div>
                                                <!-- /form-group -->
                                                
                                                <div class="form-group">
                                                    <label class="sr-only" for="inputIncubateDate">인큐베이팅 기간</label>
                                                    
                                                    <!-- form-group-date -->
                                                    <div class="form-inline">
                                                        <div class="form-period">
                                                            <div class="form-group form-start">
                                                                <label class="sr-only" for="inputIncubateStartDate">시작일</label>
                                                                <!-- datepicker -->
                                                                <div class="bfh-datepicker" data-format="{.start}">
                                                                    <div class="input-group bfh-datepicker-toggle input-group-sm" data-toggle="bfh-datepicker"> 
                                                                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                        <input type="text" class="form-control datepicker" placeholder="시작일" name="start" value="{.start}">
                                                                    </div>
                                                                </div>
                                                                <!-- /datepicker --> 
                                                            </div>

                                                            <div class="form-group form-end">
                                                                <label class="sr-only" for="inputIncubateEndDate">종료일</label>
                                                                
                                                                <!-- datepicker -->
                                                                <div class="bfh-datepicker" data-format="{.end}">
                                                                    <div class="input-group bfh-datepicker-toggle input-group-sm" data-toggle="bfh-datepicker"> 
                                                                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                        <input type="text" class="form-control datepicker" placeholder="종료일" name="end" value="{.end}">
                                                                    </div>
                                                                </div>
                                                                <!-- /datepicker --> 
                                                            </div>
                                                        </div>
                                                         
                                                        <!--
                                                        <div class="checkbox check-workNow">
                                                            <label>
                                                                <input type="checkbox" name="incubator" value="{.incubator}">
                                                                참여중</label>
                                                        </div>
                                                        //-->
                                                    </div>
                                                    <!-- /form-group-date --> 
                                                </div>
                                                <!-- /form-group -->
                                                
                                                <div class="form-group form-submit">
                                                    <button class="btn btn-primary btn-sm" type="submit" onclick="submit_edit_inc('{.id}'); return false;">저장하기</button>
                                                    <button class="btn btn-default btn-sm pull-right" onclick="del_inc('{.id}'); return false;">삭제하기</button>
                                                </div>
                                            </fieldset>
                                        </form>
                                    </li>
                                    {/}
                                </ul>
                            </div>
                            <!-- /panel-body --> 
                            
                            <!-- TODO : none 상태 -->
                            <div class="panel-body" {@ incubat}style="display: none;"{/}> 
                                <!-- alert -->
                                <div class="alert alert-info">
                                    <p class="text-info"><strong>Oops!</strong> 입력된 내용이 없습니다. [추가하기]를 클릭해서 해당 내용을 입력해주세요.</p>
                                </div>
                                <!-- /alert --> 
                            </div>
                            <!-- /panel-body --> 

                        </div>
                        <!-- /panel incubating --> 
<script type="text/javascript">
//<![CDATA[

function close_edit_service(_this) {
    $(_this).parent().parent().parent().parent().parent().slideToggle();
}

function close_edit_service2(_this) {
    $(_this).parent().parent().parent().parent().parent().parent().slideToggle();
}



function add_inc()
{
    $('#inc_form_0').slideToggle();
}

function add_ref2(_this)
{
    $(_this).parent().parent().parent().slideToggle();
}

function submit_edit_inc(_id){
    var frm = $('form[name=inc_form_'+_id+']');

    var get_url = '/ajax_front/startup_edit_inc';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            $('form[name=inc_form_'+_id+']').parent().slideToggle();
            get_incubating();
        }
    });
}

function del_inc(_id){
    del_confirm('del_inc2('+_id+')');
}

function del_inc2(_id){
    var get_url = '/ajax_front/startup_del_inc/'+_id;
    
    $.ajax({
        type : 'POST',
        url : get_url,
        dataType : 'json',
        success : function(_data) {
            $('form[name=inc_form_'+_id+']').parent().slideToggle();
            get_incubating();
            $('#md-warning').modal('hide');
        }
    });
}

function edit_inc(_this) {
    $(_this).parent().next().slideToggle();
}

function edit_inc2(_this) {
    $(_this).parent().parent().parent().slideToggle();
}
//]]>
</script>