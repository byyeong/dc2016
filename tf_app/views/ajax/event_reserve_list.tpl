
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <!--<th class="td-check" width="40"><input type="checkbox"></th>-->
                                    <th class="td-num">번호</th>
                                    <th class="td-membership">회원등급</th>
                                    <th class="td-name">이름</th>
                                    <th class="td-tel">연락처</th>
                                    <th class="td-email">이메일</th>
                                    <th class="td-copany">소속</th>
                                    <th class="td-status">상태</th>
                                    {? ev.enroll_type == 0}<th class="td-status">신청승인</th>{/}
                                    <th class="td-date">신청일자</th>
                                </tr>
                            </thead>
                            <tbody>
                                {@ res}
                                <tr>
                                    <!--<td class="td-check"><input type="checkbox" ></td>-->
                                    <td class="td-num">{.rownum}</td>
                                    <td class="td-membership">{.mgname}</th>
                                    {? .user_id == '22222'}
                                    <td class="td-name">{.er_name}</td>
                                    <td class="td-tel">{.er_tel}</th>
                                    <td class="td-email">{.er_email}</th>
                                    <td class="td-copany">{.company}</td>
                                    {:}
                                    <td class="td-name"><a href="/member/{.ids}" target="_blank">{.mname}</a></td>
                                    <td class="td-tel">{.tel}</th>
                                    <td class="td-email">{.email}</th>
                                    <td class="td-copany">{.company}</td>
                                    {/}
                                    <td class="td-status">
                                    {? .state == 0}
                                        <span class="label label-warning">신청대기</span>
                                    {:}
                                        <span class="label label-success">참여대상</span>
                                    {/}
                                    </td>
                                    
                                    <td class="td-consent">
                                        {? .state == 0}
                                        <button type="button" class="btn btn-default btn-xs" onclick="edit_state(this, '{.id}', '1'); return false;">승인대기</button>
                                        {:}
                                        <button type="button" class="btn btn-default btn-xs" onclick="edit_state(this, '{.id}', '0'); return false;">승인취소</button>
                                        {/}
                                    </td>
                                    
                                    <td class="td-date">{.date_created}</td>
                                </tr>
                                {/}
                            </tbody>
                        </table>
                        <!-- panel-footer -->
                        <div class="panel-footer">
                            <div class="paging">
                                <ul class="pagination">
                                    {?page == 1}
                                    <li class="disabled"><a href="#" onclick="return false;">&laquo;</a></li>
                                    {:}
                                    <li><a href="#" onclick="get_list('{page - 1}', '{ev.id}'); return false;">&laquo;</a></li>
                                    {/}
                                    {@paging.pages}
                                    {?.type == "dot"}
                                    <li class="disabled"><a href="#">...</a></li>
                                    {:}
                                    <li {?.type == "current"}class="active"{/}><a href="#" onclick="get_list('{.page}', '{ev.id}'); return false;">{.page}</a></li>
                                    {/}
                                    {/}
                                    {?page == paging.tot_page}
                                    <li class="disabled"><a href="#" onclick="return false;">&raquo;</a></li>
                                    {:}
                                    <li><a href="#" onclick="get_list('{page + 1}', '{ev.id}'); return false;" >&raquo;</a></li>
                                    {/}
                                </ul>
                            </div>
                        </div>
                        
<script type="text/javascript">
//<![CDATA[

function edit_state(_this, _id, _state) {

    var get_url = '/ajax/event_edit_reserve/'+_id+"/"+_state;
    $.get(get_url, function(){
        if (_state === "1") {
            $(_this).html("승인취소");
            $(_this).attr("onclick", "edit_state(this, '"+_id+"', '0'); return false;");
            $(_this).parent().prev().html('<span class="label label-success">참여대상</span>');
        }
        else {
            $(_this).html("승인대기");
            $(_this).attr("onclick", "edit_state(this, '"+_id+"', '1'); return false;");
            $(_this).parent().prev().html('<span class="label label-warning">신청대기</span>');
        }
    });
}
    
//]]>
</script>