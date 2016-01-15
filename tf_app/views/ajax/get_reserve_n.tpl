                        <div class="panel-body" id="schedule-aday">
                            <h3 class="panel-title">
                                <span class="icon-time"></span> {date}   
                                {? (s.per & settings->permission2) == settings->permission2 || (s.per & settings->permission1) == settings->permission1}<a href="/space?rdate={date}#floor-formApply" class="btn btn-default btn-sm pull-right">공간공유 신청하기</a>
                                {:}
                                <a href="#" onclick="javascript:alert('로그인이 필요합니다.'); return false;" class="btn btn-default btn-sm pull-right">공간공유 신청하기</a>
                                {/}
                            </h3>
                            <div class="table-responsive">
                                {? res}
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th width="120" class="td-time">시간</th>
                                            <th class="td-subject">내용</th>
                                            <th width="240" class="td-space">장소</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {@ res}
                                        <tr id="rel_{.id}">
                                            <td class="td-time">{.start} ~ {.end}</td>
                                            <td class="td-subject"><p>{.purpose} </p>
                                             {? .rel_url}<a class="btn btn-default btn-xs move_e" href="{.rel_url}"><span class="icon-share"></span> 이벤트보기 </a> {/}{? (s.per & settings->permission1) == settings->permission1} <button data-target="#md-linkEvent" data-toggle="modal" class="btn btn-primary btn-xs make_l" onclick="get_event_space_link('{.id}'); return false;"><span class="icon-link"></span> 이벤트 연결하기 </button>{/}
                                            </td>
                                            <td class="td-space">{.opt}F {=explode_ext(.name, '(')}</td>
                                        </tr>
                                        {/}
                                    </tbody>
                                </table>
                                {:}
                                <div class="panel-body">
                                    <div class="alert alert-warning">
                                        <strong>Oops</strong> 선택된 날짜에 공유된 일정이 없습니다.
                                    </div>
                                </div>
                                {/}
                            </div>
                            <!-- /table --> 
                        </div>
<script type="text/javascript">
//<![CDATA[
    function submit_sel(_id) {
        var get_url = '/ajax_front/get_event_link/{res.id}';
        var frm = $('form[name=e_s_l_form]');
        var set_data = frm.serialize();
        
        $.ajax({
            type : 'POST',
            url : get_url,
            data : set_data,
            dataType : 'html',
            success : function(_data) {
                if ($('input[name=rel_url]').val().length > 0) {
                    // $(".move_e").remove();
                    var _u = '<a class="btn btn-default btn-xs move_e" href="'+$('input[name=rel_url]').val()+'"><span class="icon-share"></span> 이벤트보기 </a> ';
                    $('#rel_'+_id+' .make_l').before(_u);
                }
                else {
                    $('#rel_'+_id+" .move_e").remove();
                }
                $('.modal').modal('hide');

            }
        });
    }
//]]>
</script>    