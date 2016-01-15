<script>
  $(function() {
    $( ".datepicker" ).datepicker({ dateFormat: 'yy.mm.dd' }).val();
  });
</script>                              
                            <div class="panel-heading">
                                <h3>투자내역</h3>
                                {? s && edi.user_id == s.id}
                                <button class="btn btn-default btn-xs" onclick="add_inv(); return false;">추가하기 </button>{/}
                            </div>
                            <!-- /panel-heading --> 

                            <div class="panel-body" id="inv_form_0" style="display: none;">
                                <ul class="item-list">
                                    <li class="item edit"> 
                                        <!-- TODO : edit 상태 -->
                                        <form  class="form-edit-set" name="inv_form_0">
                                            <input type="hidden" name="startup_id" value="{id}" />
                                            <fieldset>
                                                <button title="" data-toggle="tooltip" aria-hidden="true" class="close" type="button" data-original-title="닫기" onclick="add_inv(); return false;">×</button>
                                                <div class="form-group">
                                                    <label class="sr-only" for="inputIncubator">투자자/기관</label>
                                                    <input type="text" class="form-control input-sm" id="inputIncubator" placeholder="투자자/기관" name="investor">
                                                </div>
                                                <!-- /form-group -->
                                                
                                                <div class="form-group from-group-money">
                                                    <label class="sr-only" for="inputIncubateEmail" >이메일 주소</label>
                                                    <div class="input-group input-group-sm"> 
                                                        <span class="input-group-addon"><span class="fa fa-fw fa-envelope"></span></span>
                                                        <input type="email" id="inputIncubateEmail" class="form-control" placeholder="이메일 주소" name="email" >
                                                    </div>
                                                </div>
                                                <!-- /form-group -->
                                                
                                                <div class="form-group form-group-date">
                                                    <label class="sr-only" for="inputInvestDate">투자일</label>
                                                    <!-- datepicker -->
                                                    <div class="bfh-datepicker" data-format="y.m.d">
                                                        <div class="input-group bfh-datepicker-toggle input-group-sm" data-toggle="bfh-datepicker"> 
                                                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                            <input type="text" class="form-control datepicker" placeholder="투자일" name="date" readonly>
                                                        </div>
                                                    </div>
                                                    <!-- /datepicker --> 
                                                </div>
                                                <!-- /form-group-date -->
                                                
                                                <div class="form-group from-group-money">
                                                    <label for="inputInvestMoney" class="sr-only">투자금액</label>
                                                    <div class="input-group input-group-sm"> 
                                                        <span class="input-group-addon"><span class="fa fa-fw fa-won"></span></span>
                                                        <input type="text" id="inputInvestMoney" class="form-control" placeholder="투자금액" name="investment">
                                                    </div>
                                                </div>
                                                <!-- /form-group -->
                                                
                                                <div class="form-group">
                                                    <label class="sr-only" for="inputIncubator">투자타입</label>
                                                    <input type="text" class="form-control input-sm" id="inputIncubator" placeholder="투자타입" name="type">
                                                </div>
                                                <!-- /form-group -->
                                                
                                                <div class="form-group form-submits">
                                                    <button class="btn btn-primary btn-sm" type="submit" onclick="submit_edit_inv(0); return false;">저장하기</button>
                                                    <button class="btn btn-default btn-sm pull-right" onclick="add_inv(this); return false;">취소하기</button>
                                                </div>
                                            </fieldset>
                                        </form>
                                    </li>
                                </ul>
                            </div>
                            <!-- /panel-body --> 
                            
                            <div class="panel-body" {@ !invest}style="display: none;"{/}>
                                <ul class="item-list">
                                    {@ invest}
                                    <li class="item">
                                        <!-- TODO : normal 상태 -->
                                        <h4>{.investor}{? .type}({.type}){/} <small><a href="mailto:{.email}">{.email}</a></small></h4>
                                        {? s && edi.user_id == s.id}<button class="btn btn-default btn-xs" onclick="edit_inv(this); return false;">수정하기</button>{/}
                                        <p><span class="icon-calendar"></span> {.date} </p>
                                    </li>
                                    <li class="item edit" style="display: none;"> 
                                        <!-- TODO : edit 상태 -->
                                        <form  class="form-edit-set" name="inv_form_{.id}">
                                            <input type="hidden" name="startup_id" value="{.startup_id}" />
                                            <input type="hidden" name="id" value="{.id}" />
                                            <fieldset>
                                                <button type="button" class="close" aria-hidden="true" data-toggle="tooltip" title="닫기" onclick="edit_inv2(this); return false;">&times;</button>
                                                <div class="form-group">
                                                    <label class="sr-only" for="inputIncubator">투자자/기관</label>
                                                    <input type="text" class="form-control input-sm" id="inputIncubator" placeholder="투자자/기관" name="investor" value="{.investor}">
                                                </div>
                                                <!-- /form-group -->
                                                
                                                <div class="form-group from-group-money">
                                                    <label class="sr-only" for="inputIncubateEmail" >이메일 주소</label>
                                                    <div class="input-group input-group-sm"> 
                                                        <span class="input-group-addon"><span class="fa fa-fw fa-envelope"></span></span>
                                                        <input type="email" id="inputIncubateEmail" class="form-control" placeholder="이메일 주소" name="email" value="{.email}">
                                                    </div>
                                                </div>
                                                <!-- /form-group -->
                                                
                                                <div class="form-group form-group-date">
                                                    <label class="sr-only" for="inputInvestDate">투자일</label>
                                                    <!-- datepicker -->
                                                    <div class="bfh-datepicker" data-format="{.date}">
                                                        <div class="input-group bfh-datepicker-toggle input-group-sm" data-toggle="bfh-datepicker"> 
                                                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                            <input type="text" class="form-control datepicker" placeholder="투자일" name="date" value="{.date}" readonly>
                                                        </div>
                                                    </div>
                                                    <!-- /datepicker --> 
                                                </div>
                                                <!-- /form-group-date -->
                                                
                                                <div class="form-group from-group-money">
                                                    <label for="inputInvestMoney" class="sr-only">투자금액</label>
                                                    <div class="input-group input-group-sm"> 
                                                        <span class="input-group-addon"><span class="fa fa-fw fa-won"></span></span>
                                                        <input type="text" id="inputInvestMoney" class="form-control" placeholder="투자금액" name="investment" value="{.investment}">
                                                    </div>
                                                </div>
                                                <!-- /form-group -->
                                                
                                                <div class="form-group">
                                                    <label class="sr-only" for="inputIncubator">투자타입</label>
                                                    <input type="text" class="form-control input-sm" id="inputIncubator" placeholder="투자타입" name="type" value="{.type}">
                                                </div>
                                                <!-- /form-group -->
                                                
                                                <div class="form-group form-submit">
                                                    <button class="btn btn-primary btn-sm" type="submit" onclick="submit_edit_inv('{.id}'); return false;">저장하기</button>
                                                    <button class="btn btn-default btn-sm pull-right" onclick="del_inv('{.id}'); return false;">삭제하기</button>
                                                </div>
                                            </fieldset>
                                        </form>
                                    </li>
                                    {/}
                                </ul>
                            </div>
                            <!-- /panel-body --> 
                            
                            <!-- TODO : none 상태 -->
                            <div class="panel-body" {@ invest}style="display: none;"{/}> 
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



function add_inv()
{
    $('#inv_form_0').slideToggle();
}

function add_ref2(_this)
{
    $(_this).parent().parent().parent().slideToggle();
}

function submit_edit_inv(_id){
    var frm = $('form[name=inv_form_'+_id+']');

    var get_url = '/ajax_front/startup_edit_inv';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            $('form[name=inv_form_'+_id+']').parent().slideToggle();
            get_investment();
        }
    });
}

function del_inv(_id){
    del_confirm('del_inv2('+_id+')');
}

function del_inv2(_id){
    var get_url = '/ajax_front/startup_del_inv/'+_id;
    
    $.ajax({
        type : 'POST',
        url : get_url,
        dataType : 'json',
        success : function(_data) {
            $('form[name=inv_form_'+_id+']').parent().slideToggle();
            get_investment();
            $('#md-warning').modal('hide');
        }
    });
}

function edit_inv(_this) {
    $(_this).parent().next().slideToggle();
}

function edit_inv2(_this) {
    $(_this).parent().parent().parent().slideToggle();
}
//]]>
</script>