<script>
  $(function() {
    $( ".datepicker" ).datepicker({ dateFormat: 'yy.mm.dd' }).val();
  });
</script>                            
                            <div class="panel-heading">
                                <strong>경력 사항</strong>
                                {? s.id == id}
                                <button class="btn btn-default btn-xs" onclick="add_career(); return false;">추가하기</button>
                                {/}
                            </div>
                            <!-- /panel-heading --> 
                            
                            <div class="panel-body" id="edit_form_no" style="display: none"> 
                                <ul class="item-list">
                                    <li class="item edit"> 
                                        <!-- todo : edit 상태 -->
                                        <form class="form-edit-set" name="edit_career_form_0" id="edit_career_form_0" onkeydown="return captureReturnKey(event);">
                                            <input type="hidden" name="user_id" value="{id}" />
                                            <fieldset>
                                                <button type="button" class="close" data-toggle="tooltip" data-placement="top" title="닫기" onclick="add_career(this); return false;">&times;</button>
                                               
                                                <div class="form-group-career form-inline"> 
                                                    <div class="form-group">
                                                        <div class="input-group">
                                                            <label class="sr-only">회사명</label>
                                                            <div class="input-group input-group-sm">
                                                                <input type="text" class="form-control" id="inputCompany" placeholder="회사명" name="company" value="" >
                                                                <span class="input-group-btn">
                                                                    <button onclick="find_com(this, 1); return false;" class="btn btn-default" type="button" ><span class="glyphicon glyphicon-search"></span><span class="sr-only">검색</span></button>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>                          
                                                    <div class="form-group">
                                                        <label class="sr-only">직위/역할</label>
                                                        <input type="text" class="form-control input-sm" id="inputJob" placeholder="직위/역할" name="role" value="">
                                                    </div>    
                                                    <div class="form-group">
                                                        <div class="checkbox check-workNow">
                                                            <label><input type="checkbox" name="is_ing" value="1" onchange="check_is_ing(this); return false;"> 재직중</label>
                                                        </div>
                                                    </div>                     
                                                </div>
                                                <!-- /form-group-career -->
                                                
                                                <!-- form-group-date -->
                                                <div class="form-inline">
                                                    <div class="form-period">
                                                        <!-- datepicker -->
                                                        <div class="form-group form-start bfh-datepicker" data-format="y.m.d">
                                                            <label class="sr-only">입사일</label>
                                                            <div class="input-group input-group-sm bfh-datepicker-toggle" data-toggle="bfh-datepicker"> 
                                                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                <input type="text" class="form-control datepicker" placeholder="입사일"  name="start" value="" >
                                                            </div>
                                                        </div>
                                                        <!-- /datepicker -->  

                                                        <!-- datepicker -->
                                                        <div class="form-group form-end bfh-datepicker" data-format="y.m.d">
                                                            <label class="sr-only">퇴사일</label>
                                                            <div class="input-group input-group-sm bfh-datepicker-toggle" data-toggle="bfh-datepicker"> 
                                                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                <input type="text" class="form-control datepicker" placeholder="퇴사일"  name="end" value="" >
                                                            </div>
                                                        </div>
                                                        <!-- /datepicker -->   
                                                    </div>
                                                        
                                                </div>
                                                <!-- /form-group-date -->
                                                
                                                <div class="form-group form-submit">
                                                    <button class="btn btn-primary btn-sm" onclick="submit_career(this, 0); return false;">저장하기</button>
                                                </div>
                                            </fieldset>
                                        </form>
                                    </li>
                                </ul>
                                
                            </div>
                            <!-- /panel-body --> 
                            
                            <!-- todo : normal 상태 -->
                            <div class="panel-body" {? !res}style="display: none"{/}>
                                <ul class="item-list">
                                    {@ res}
                                    <li class="item">
                                        <div class="item-set">
                                            {? s.id == id}
                                            <button class="btn btn-default btn-xs btn-itemEdit" data-toggle="tooltip" data-placement="top" title="수정" onclick="edit_career(this); return false;">
                                                <span class="glyphicon glyphicon-edit"></span><span class="sr-only">수정하기</span>
                                            </button>
                                            {/}
                                            <h4 class="item-heading"><a href="/startup/{.startup_id}">{.sname}</a></h4>
                                            <span>{.role}</span>
                                            {? .start || .end || .is_ing}
                                            <span class="date"><span class="glyphicon glyphicon-time"></span>
                                            {? .is_ing && .status == 0}
                                            승인 대기 중
                                            {:}
                                            {? .start}
                                            {=str_replace("-", ".", .start)} 
                                            {/}
                                            {? .is_ing}
                                            ~ now
                                            {:}
                                            {? .end}
                                            ~ {=str_replace("-", ".", .end)}
                                            {/}
                                            {/}
                                            </span>
                                            {/}
                                            {/}
                                        </div>
                                        
                                    </li>
                                    <li class="item edit" style="display: none;"> 
                                        <!-- todo : edit 상태 -->
                                        <form class="form-edit-set" name="edit_career_form_{.id}" id="edit_career_form_{.id}" onsubmit="return false;">
                                            <input type="hidden" name="user_id" value="{.user_id}" />
                                            <input type="hidden" name="id" value="{.id}" />
                                            <fieldset>
                                                <button type="button" class="close" data-toggle="tooltip" data-placement="top" title="닫기" onclick="close_form(this);; return false;">&times;</button>
                                                
                                                <!-- form-group-career -->
                                                <div class="form-group-career form-inline">
                                                    <div class="form-group">
                                                        <div class="input-group">
                                                            <label class="sr-only">회사명</label>
                                                            <div class="input-group input-group-sm">
                                                                <input type="text" class="form-control" id="inputCompany" placeholder="회사명" name="company" value="{.sname}" readonly>
                                                                <span class="input-group-btn">
                                                                    <button onclick="find_com(this, 1); return false;" class="btn btn-default" type="button" data-toggle="modal" href="#md-searchStartup"><span class="glyphicon glyphicon-search"></span><span class="sr-only">검색</span></button>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="sr-only">직위/역할</label>
                                                        <input type="text" class="form-control input-sm" id="inputJob" placeholder="직위/역할" name="role" value="{.role}">
                                                    </div>

                                                    <div class="form-group">
                                                        <div class="checkbox check-workNow">
                                                            <label><input type="checkbox" name="is_ing" value="1" {? .is_ing}checked="checked"{/} onchange="check_is_ing(this); return false;">재직중</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- /form-group-career -->
                                                
                                                <!-- form-group-date -->
                                                <div class="form-inline">
                                                    <div class="form-period">
                                                    <!-- datepicker -->
                                                        <div class="form-group form-start bfh-datepicker" data-format="y.m.d">
                                                            <label class="sr-only">입사일</label>
                                                            <div class="input-group input-group-sm bfh-datepicker-toggle" data-toggle="bfh-datepicker">
                                                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                <input type="text" class="form-control datepicker" placeholder="입사일"  name="start" value="{=str_replace("-", ".", .start)}">
                                                            </div>
                                                        </div>
                                                        <!-- /datepicker -->  
                                                         
                                                        <!-- datepicker -->
                                                        <div class="form-group form-end bfh-datepicker" data-format="y.m.d" {? .is_ing} style="display: none"{/}>
                                                            <label class="sr-only">퇴사일</label>
                                                            <div class="input-group input-group-sm bfh-datepicker-toggle" data-toggle="bfh-datepicker">
                                                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                <input type="text" class="form-control datepicker" placeholder="퇴사일"  name="end" value="{=str_replace("-", ".", .end)}">
                                                            </div>
                                                        </div>
                                                        <!-- /datepicker -->  
                                                    </div>
                                                </div>
                                                <!-- /form-group-date -->
                                               
                                                <div class="form-group form-submit">
                                                    <button class="btn btn-primary btn-sm" onclick="submit_career(this, '{.id}'); return false;">저장하기</button>
                                                    <button class="btn btn-default btn-sm pull-right" onclick="del_car('{.id}'); return false;">삭제하기</button>
                                                </div>
                                            </fieldset>
                                        </form>
                                    </li>
                                    {/}
                                </ul>
                            </div>
                            <!-- /panel-body --> 
                            
                            <!-- todo : none 상태 -->
                            <div class="panel-body" {? res}style="display: none"{/}> 
                                <!-- alert -->
                                <div class="alert alert-info">
                                    <p class="text-info"><strong>Oops!</strong> 입력된 내용이 없습니다. 해당 내용을 추가해주세요.</p>
                                </div>
                                <!-- /alert --> 
                            </div>
                                
                            
<script type="text/javascript">
//<![CDATA[

{? (s.id != id ) && ! res}
$('#profile-career').hide();
{/}

function check_is_ing(_this) {
    
    if ($(_this).is(":checked") === true) {
        $(_this).parent().parent().parent().find('.date-sim').hide();
        $(_this).parent().parent().parent().find('input[name=end]').parent().parent().hide();
    }
    else {
        $(_this).parent().parent().parent().find('.date-sim').show();
        $(_this).parent().parent().parent().find('input[name=end]').parent().parent().show();
    }
}

function add_career() {
    $('#edit_form_no').slideToggle();
}

function edit_career(_this){
    $(_this).parent().parent().next().slideToggle();
}

function captureReturnKey(e) { 
    if(e.keyCode===13) 
    return false; 
} 

function submit_career(_this, _id){
    var key = $(_this).parent().parent().find('input[name=company]').val();
    if ($(_this).parent().parent().find('input[name=company]').attr('readonly') !== 'readonly') {
        alert('등록되지 않은 회사명입니다. 검색버튼을 클릭 후 회사를 등록해주세요.');
        return false;
    }

    if (key === '') {
        alert('회사명을 입력해주세요.');
        return false;
    }
    
    var frm = $('form[name=edit_career_form_'+_id+']');
    var get_url = '/ajax_front/member_edit_career';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            $('form[name=edit_career_form_'+_id+']').parent().slideToggle();
            get_career();
            if($("input[name=is_ing]").is(':checked')) {
                alert("관련 기업 등록이 완료되었습니다. <br>"+$("input[name=company]").val()+" 구성원들의 승인 후 기업 프로필 관련 기능을 정상적으로 이용할 수 있습니다.");
            } 
        }
    });
}

function close_form(_this) {
    $(_this).parent().parent().parent().parent().slideToggle();
}

function del_car(_id){
    del_confirm('del_car2('+_id+')');
}

function del_car2(_id){
    var get_url = '/ajax_front/member_del_career/'+_id;
    
    $.ajax({
        type : 'POST',
        url : get_url,
        dataType : 'json',
        success : function(_data) {
            $('form[name=edit_career_form_'+_id+']').parent().slideToggle();
            get_career();
            // get_project();
            $('#md-warning').modal('hide');
        }
    });
}
//]]>
</script>             
                            