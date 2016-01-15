<script>
  $(function() {
    $(".datepicker").datepicker({ dateFormat: 'yy.mm.dd' }).val();
    $('.selectpicker').selectpicker();
  });
</script>                            
                            <div class="panel-heading">
                                <strong>참여 프로젝트</strong>
                                {? s.id == id}
                                <button class="btn btn-default btn-xs" onclick="add_pj(); return false;">추가하기 </button>
                                {/}
                            </div>
                            <!-- /panel-heading --> 
                            
                            <div class="panel-body" id="pj_no_form" style="display: none;">
                                <ul class="item-list">
                                    <li class="item edit">
                                        
                                        <form role="form" class="form-edit-set" name="edit_pj_form_0">
                                            <input type="hidden" name="uid" value="{id}" />
                                            <fieldset>
                                                <button type="button" class="close" aria-hidden="true" data-toggle="tooltip" title="닫기" onclick="add_pj(); return false;">&times;</button>
                                                <div class="form-group-project form-inline">                                        
                                                    <div class="form-group">
                                                        <label class="sr-only">회사선택</label>
                                                        <select class="selectpicker" data-width="auto" name="startup_id">
                                                            <optgroup label="회사선택">
                                                                {@ st}
                                                                <option value="{.startup_id}">{.sname}</option>
                                                                {/}
                                                            </optgroup>
                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="sr-only">프로젝트명</label>
                                                        <input type="text" class="form-control input-sm" id="inputProject"  name="project" placeholder="프로젝트명">
                                                    </div> 
                                                    <div class="form-group">
                                                        <label class="sr-only">담당업무</label>
                                                        <input type="text" class="form-control input-sm" id="inputWork" name="role" placeholder="담당업무">
                                                    </div>          
                                                    <div class="form-group">
                                                        <div class="checkbox check-workNow">
                                                            <label><input type="checkbox" name="is_ing" value="1" onchange="check_is_ing(this); return false;"> 참여중</label>
                                                        </div>
                                                    </div>                 
                                                </div>
                                                
                                                <!-- form-group-date -->
                                                <div class="form-inline">
                                                    <div class="form-period">
                                                        <div class="form-group form-start bfh-datepicker" data-format="y.m.d">
                                                            <label class="sr-only">시작일</label>
                                                            <div class="input-group input-group-sm bfh-datepicker-toggle" data-toggle="bfh-datepicker"> 
                                                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span> 
                                                                <input type="text" class="form-control datepicker" name="start" placeholder="시작일" readonly>
                                                            </div>
                                                        </div>
                                                        <!-- /datepicker --> 
                                                                                                             
                                                        <!-- datepicker -->
                                                        <div class="form-group form-end bfh-datepicker" data-format="y.m.d">
                                                            <label class="sr-only">완료일</label>
                                                            <div class="input-group input-group-sm bfh-datepicker-toggle" data-toggle="bfh-datepicker"> 
                                                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span> 
                                                                <input type="text" class="form-control datepicker" name="end" placeholder="완료일" readonly>
                                                            </div>
                                                        </div>
                                                        <!-- /datepicker -->   
                                                    </div>
                                                </div>
                                                <!-- /form-group-date -->
                                                
                                                <div class="form-group form-submit">
                                                    <button class="btn btn-primary btn-sm" onclick="submit_pj(0); return false;">저장하기</button>
                                                </div>
                                            </fieldset>
                                        </form>
                                    </li>
                                </ul>
                            </div>
                            
                            <!-- /panel-body -->
                            <div class="panel-body" id="pj_yes" {? !res}style="display: none;"{/}>
                                <ul class="item-list">
                                    {@ res}
                                    <li class="item">
                                        <div class="item-set">
                                            {? s.id == id}<button class="btn btn-default btn-xs btn-itemEdit" data-toggle="tooltip" data-placement="top" title="수정" onclick="close_pj(this); return false;">
                                                <span class="glyphicon glyphicon-edit"></span><span class="sr-only">수정하기</span>
                                            </button>
                                            {/}
                                            <h4 class="item-heading">{.project}</h4>
                                            <span>{.role}</span>
                                            <span class="date"><span class="glyphicon glyphicon-time"></span> {=str_replace("-", ".", .start)} ~ {? .is_ing}now{:}{=str_replace("-", ".", .end)}{/}</span>
                                            <span class="at">at <a href="/startup/{.startup_id}">{.name}</a></span>
                                        </div>
                                    </li>
                                    <li  class="item edit" style="display: none;">
                                        
                                        <form role="form" class="form-edit-set" name="edit_pj_form_{.id}">
                                            <input type="hidden" name="uid" value="{id}" />
                                            <input type="hidden" name="id" value="{.id}" />
                                            <fieldset>
                                                <button type="button" class="close" aria-hidden="true" data-toggle="tooltip" title="닫기" onclick="close_pj2(this); return false;">&times;</button>
                                                <div class="form-group-project form-inline">
                                                    <div class="form-group">
                                                        <label class="sr-only">회사선택</label>
                                                        <select class="selectpicker" data-width="auto" name="startup_id">
                                                            <optgroup label="회사선택">
                                                                <?for({i}=0;{i}<sizeof({st});{i}++){ ?>
                                                                <option value="{st[i].startup_id}">{st[i].sname}</option>
                                                                <? }?>
                                                            </optgroup>
                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="sr-only" for="inputProject">프로젝트명</label>
                                                        <input type="text" class="form-control input-sm" id="inputProject" placeholder="프로젝트명" name="project" value="{.project}">
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="sr-only" for="inputWork">담당업무</label>
                                                        <input type="text" class="form-control input-sm" id="inputWork" placeholder="담당업무" name="role" value="{.role}">
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="checkbox check-workNow">
                                                            <label><input type="checkbox" name="is_ing" value="1" {? .is_ing}checked="checked"{/} onchange="check_is_ing(this); return false;"> 참여중</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <!-- form-group-date -->
                                                <div class="form-inline">
                                                    <div class="form-period">
                                                        <div class="form-group form-start bfh-datepicker" data-format="y.m.d">
                                                            <label class="sr-only">시작일</label>
                                                            <div class="input-group input-group-sm bfh-datepicker-toggle" data-toggle="bfh-datepicker"> 
                                                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span> 
                                                                <input type="text" class="form-control datepicker" name="start" value="{=str_replace("-", ".", .start)}" placeholder="시작일" readonly>
                                                            </div>
                                                        </div>
                                                        <!-- /datepicker -->  
                                                        
                                                        <!-- datepicker -->
                                                        <div class="form-group form-end bfh-datepicker" data-format="y.m.d" {? .is_ing} style="display: none"{/}>
                                                            <label class="sr-only">완료일</label>
                                                            <div class="input-group input-group-sm bfh-datepicker-toggle" data-toggle="bfh-datepicker"> 
                                                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span> 
                                                                <input type="text" class="form-control datepicker" name="end" value="{=str_replace("-", ".", .end)}" placeholder="완료일" readonly>
                                                            </div>
                                                        </div>
                                                        <!-- /datepicker -->                   
                                                    </div>
                                                </div>
                                                <!-- /form-group-date -->
                                                
                                                <div class="form-group form-submit">
                                                    <button class="btn btn-primary btn-sm" onclick="submit_pj('{.id}'); return false;">저장하기</button>
                                                    <button class="btn btn-default btn-sm pull-right" onclick="del_pj('{.id}'); return false;">삭제하기</button>
                                                </div>
                                            </fieldset>
                                        </form>
                                    </li>
                                    {/}
                                </ul>
                            </div>
                            
                            <!-- todo : none 상태 -->
                            <div class="panel-body" id="pj_no" {? res}style="display: none;"{/}> 
                                <!-- alert -->
                                <div class="alert alert-info">
                                    <p class="text-info"><strong>Oops!</strong> 입력된 내용이 없습니다. 해당 내용을 추가해주세요.</p>
                                </div>
                                <!-- /alert --> 
                            </div>
                            
                            
                                            
<script type="text/javascript">
//<![CDATA[

{? (s.id != id ) && ! res}
$('#profile-project').hide();
{/}

function add_pj() {
    $('#pj_no_form').slideToggle();
}

function close_pj(_this){
    $(_this).parent().parent().next().slideToggle();
}

function close_pj2(_this){
    $(_this).parent().parent().parent().slideToggle();
}

function submit_pj(_id){
    var frm = $('form[name=edit_pj_form_'+_id+']');

    var get_url = '/ajax_front/member_edit_pj';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            $('form[name=edit_pj_form_'+_id+']').parent().slideToggle();
            get_project();
        }
    });
}

function del_pj(_id){
    del_confirm('del_pj2('+_id+')');
}

function del_pj2(_id){
    var get_url = '/ajax_front/member_del_pj/'+_id;
    
    $.ajax({
        type : 'POST',
        url : get_url,
        dataType : 'json',
        success : function(_data) {
            $('form[name=edit_pj_form_'+_id+']').parent().slideToggle();
            get_project();
            $('#md-warning').modal('hide');
        }
    });
}

//]]>
</script>   