                            <div class="panel-heading">
                                <strong>교육</strong>
                                {? s.id == id}
                                <button class="btn btn-default btn-xs" onclick="edit_edu(); return false;">추가하기</button>
                                {/}
                            </div>
                            <!-- /panel-heading --> 
                            
                            <div class="panel-body" id="edit_edu_no" style="display: none;">
                                <ul class="item-list">
                                    <li class="item edit">
                                        
                                        <form role="form" class="form-edit-set" name="edu_form_0" >
                                            <input type="hidden" name="uid" value="{id}" />
                                            <fieldset>
                                                <button title="닫기" data-placement="top" data-toggle="tooltip" class="close" type="button" onclick="edit_edu(); return false;">×</button>
                                                <div class="form-inline">
                                                    <div class="form-group">
                                                        <label class="sr-only">학교/기관명</label>
                                                        <input type="text" class="form-control input-sm" placeholder="학교/기관명" name="education" value="">
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="sr-only">전공/프로그램</label>
                                                        <input type="text" class="form-control input-sm" placeholder="전공/프로그램" name="education_sp" value="">
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="sr-only">재학여부</label>
                                                        <select class="selectpicker" data-width="auto" name="education_st">
                                                            <option value="1" >재학 중</option>
                                                            <option value="0" >졸업</option>
                                                            <option value="2" >중퇴</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group form-submit">
                                                    <button class="btn btn-primary btn-sm" onclick="submit_edu(0); return false;">저장하기</button>
                                                </div>
                                            </fieldset>
                                        </form>
                                    </li>
                                </ul>
                            </div>
                            
                            <!-- todo : normal 상태 -->
                            <div class="panel-body" id="edit_edu" {? !res}style="display: none;"{/}>
                                <ul class="item-list">
                                    {@ res}
                                    <li class="item">
                                        <div class="item-set"> 
                                            {? s.id == id}
                                            <button title="수정" data-placement="top" data-toggle="tooltip" class="btn btn-default btn-xs btn-itemEdit"  onclick="toggle_ppn(this); return false;">
                                                <span class="glyphicon glyphicon-edit"></span><span class="sr-only">수정하기</span>
                                            </button>
                                            {/}
                                            <h4>{res.education}</h4>
                                            <span>{res.education_sp}{? res.education_st == 0} 졸업{/}{? res.education_st == 1} 재학 중{/}{? res.education_st == 2} 중퇴{/}</span>                      
                                        </div>
                                    </li>
                                    <li class="item edit" style="display: none;">
                                        
                                        <form role="form" class="form-inline form-edit-set" name="edu_form_{.id}" >
                                            <input type="hidden" name="id" value="{res.id}" />
                                            <input type="hidden" name="uid" value="{res.user_id}" />
                                            <fieldset>
                                                <button title="닫기" data-placement="top" data-toggle="tooltip" class="close" type="button" onclick="toggle_ppp(this); return false;">×</button>
                                                <div class="form-inline">
                                                    <div class="form-group">
                                                        <label class="sr-only">학교/기관명</label>
                                                        <input type="text" class="form-control input-sm" placeholder="학교/기관명" name="education" value="{res.education}">
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="sr-only">전공/프로그램</label>
                                                        <input type="text" class="form-control input-sm" placeholder="전공/프로그램" name="education_sp" value="{res.education_sp}">
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="sr-only">재학여부</label>
                                                        <select class="selectpicker" data-width="auto" name="education_st">
                                                            <option value="1" {?res.education_st == 1}selected="selected"{/}>재학 중</option>
                                                            <option value="0" {?res.education_st == 0}selected="selected"{/}>졸업</option>
                                                            <option value="2" {?res.education_st == 2}selected="selected"{/}>중퇴</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-actions">
                                                    <button class="btn btn-primary btn-sm" onclick="submit_edu('{res.id}'); return false;">저장하기</button>
                                                    <button class="btn btn-default btn-sm pull-right" onclick="del_edu('{.id}'); return false;">삭제하기</button>
                                                </div>
                                            </fieldset>
                                        </form>
                                    </li>
                                    {/}
                                </ul>
                            </div>
                                
                            <div class="panel-body" id="edu_no" {? res}style="display: none;"{/}>
                                <div class="alert alert-info">
                                    <p class="text-info"><strong>Oops!</strong> 입력된 내용이 없습니다. 해당 내용을 추가해주세요.</p>
                                </div>
                            </div>
                    
<script type="text/javascript">
//<![CDATA[
{? (s.id != id ) && ! res}
$('#profile-school').hide();
{/}

$('.selectpicker').selectpicker();

function add_edu() {
    $('#edu_form').slideToggle();
}

function submit_edu(_id){
    var frm = $('form[name=edu_form_'+_id+']');

    var get_url = '/ajax_front/member_edit_edu';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            $('form[name=edu_form_'+_id+']').parent().slideToggle();
            get_edu();
        }
    });
}

function del_edu(_id){
    del_confirm('del_edu2('+_id+')');
}

function del_edu2(_id){
    var get_url = '/ajax_front/member_del_edu/'+_id;
    
    $.ajax({
        type : 'POST',
        url : get_url,
        dataType : 'json',
        success : function(_data) {
            $('form[name=edu_form_'+_id+']').parent().slideToggle();
            get_edu();
            $('#md-warning').modal('hide');
        }
    });
}
//]]>
</script>   