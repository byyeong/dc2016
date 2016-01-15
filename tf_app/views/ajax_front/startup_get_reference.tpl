                            <div class="panel-heading">
                                <h3>레퍼런스</h3>
                                {? s && edi.user_id == s.id}<button class="btn btn-default btn-xs" onclick="add_ref(); return false;">Add </button>{/}
                            </div>
                            <!-- /panel-heading --> 
                            
                            <div class="panel-body" id="ref_form_0" style="display: none;">
                                <!-- TODO : edit 상태 -->
                                <form class="form-edit-set" name="ref_form_0">
                                    <input type="hidden" name="startup_id" value="{id}" />
                                    <fieldset>
                                        <div class="form-group">
                                            <label class="sr-only" for="inputReference1-">레퍼런스명</label>
                                            <input type="text" class="form-control" id="inputReference-1" placeholder="레퍼런스명" name="reference">
                                        </div>
                                        <div class="form-group">
                                            <label class="sr-only" for="inputReferenceDesc-1">레퍼런스 설명</label>
                                            <textarea class="form-control" rows="3" id="inputReferenceDesc-1" placeholder="레퍼런스 설명을 입력하세요" name="description"></textarea>
                                        </div>
                                        <div class="form-actions">
                                            <button class="btn btn-default btn-xs" onclick="add_ref(this); return false;">Cancel</button>
                                            <button class="btn btn-primary btn-xs" type="submit" onclick="submit_edit_ref(0); return false;">Save</button>
                                        </div>
                                    </fieldset>
                                </form>
                                    
                            </div>
                            <!-- /panel-body -->
                            
                            <div class="panel-body" {? !reference}style="display: none;"{/}>
                                <ul class="item-list">
                                     <!-- TODO : normal 상태 -->
                                     {@ reference}
                                     <li class="item">
                                        <h4>{.reference}</h4>
                                        {? s && edi.user_id == s.id}<button class="btn btn-default btn-xs" onclick="edit_ref(this); return false;">Edit</button>{/}
                                        <div class="desc">{.description}</div>
                                    </li>
                                    </li>
                                    <li class="item edit" style="display: none;"> 
                                        <!-- TODO : edit 상태 -->
                                        <form class="form-edit-set" name="ref_form_{.id}">
                                            <input type="hidden" name="id" value="{.id}" />
                                            <input type="hidden" name="startup_id" value="{.startup_id}" />
                                            <fieldset>
                                                <button type="button" class="close" aria-hidden="true" data-toggle="tooltip" title="삭제" onclick="del_ref('{.id}'); return false;">&times;</button>
                                                <div class="form-group">
                                                    <label class="sr-only" for="inputReference1-">레퍼런스명</label>
                                                    <input type="text" class="form-control" id="inputReference-1" placeholder="레퍼런스명" name="reference" value="{.reference}">
                                                </div>
                                                <div class="form-group">
                                                    <label class="sr-only" for="inputReferenceDesc-1">레퍼런스 설명</label>
                                                    <textarea class="form-control" rows="3" id="inputReferenceDesc-1" placeholder="레퍼런스 설명을 입력하세요" name="description">{.description}</textarea>
                                                </div>
                                                <div class="form-actions">
                                                    <button class="btn btn-default btn-xs" onclick="edit_ref2(this); return false;">Cancel</button>
                                                    <button class="btn btn-primary btn-xs" type="submit" onclick="submit_edit_ref('{.id}'); return false;">Save</button>
                                                </div>
                                            </fieldset>
                                        </form>
                                    </li>
                                    {/}
                                </ul>
                            </div>
                            <!-- /panel-body --> 
                            
                            <!-- TODO : none 상태 -->
                            <div class="panel-body" {? reference}style="display: none;"{/}> 
                                <!-- alert -->
                                <div class="alert alert-info">
                                    <p class="text-info">입력된 내용이 없습니다</p>
                                </div>
                                <!-- /alert --> 
                            </div>
                                
<script type="text/javascript">
//<![CDATA[




function close_edit_service(_this) {
    $(_this).parent().parent().parent().parent().parent().slideToggle();
}

function close_edit_service2(_this) {
    $(_this).parent().parent().parent().parent().parent().parent().slideToggle();
}



function add_ref()
{
    $('#ref_form_0').slideToggle();
}

function add_ref2(_this)
{
    $(_this).parent().parent().parent().slideToggle();
}

function submit_edit_ref(_id){
    var frm = $('form[name=ref_form_'+_id+']');

    var get_url = '/ajax_front/startup_edit_ref';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            $('form[name=ref_form_'+_id+']').parent().slideToggle();
            get_reference();
        }
    });
}

function del_ref(_id){
    del_confirm('del_ref2('+_id+')');
}

function del_ref2(_id){
    var get_url = '/ajax_front/startup_del_ref/'+_id;
    
    $.ajax({
        type : 'POST',
        url : get_url,
        dataType : 'json',
        success : function(_data) {
            $('form[name=ref_form_'+_id+']').parent().slideToggle();
            get_reference();
            $('#md-warning').modal('hide');
        }
    });
}

function edit_ref(_this) {
    $(_this).parent().next().slideToggle();
}

function edit_ref2(_this) {
    $(_this).parent().parent().parent().parent().slideToggle();
}
//]]>
</script>