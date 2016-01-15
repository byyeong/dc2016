
                        {? res}
                        <div class="table-responsive">
                            <form name="e_pool_list">
                                <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th width="60" class="td-select"><input type="checkbox" id="check_all"></th>
                                        <th class="td-name">이름</th>
                                        <th class="td-group">소속</th>
                                        <th class="td-history">심사위원 이력</th>
                                        <th class="td-info">심사위원 소개</th>
                                    </tr>
                                </thead>
                                
                                <tbody>
                                    {@ res}
                                    <tr id="exm_{.id}">
                                        <td class="td-select"><input type="checkbox" name="id_con" value="{.user_id}" {? .ex}disabled="disabled"{/}></td>
                                        <td class="td-name"><a href="#" onclick="view_examiner('{.user_id}'); return false;">{.name}</a>{? .ex}(초대 됨){/}</td>
                                        <td class="td-group"><a href="/startup/{.com.sid}" target="_blank">{.com.name}</a></td>
                                        <td class="td-history" href="#" onclick="view_examiner('{.user_id}'); return false;">{.comp}</td>
                                        <td class="td-info"><a class="btn btn-default btn-xs" href="#" onclick="view_examiner('{.user_id}'); return false;" >정보보기</a></td>
                                    </tr>
                                    {/}
                                
                                </tbody>
                               
                            </table></form>
                        </div>
                                
                        <div class="list-controller"> 선택한 위원을
                            <button data-toggle="modal" data-target="#md-inviteExaminer" class="btn btn-primary btn-sm">심사위원으로 초대</button>
                            <ul class="pagination pull-right">
                                {?page == 1}
                                <li class="disabled"><a href="#">&laquo;</a></li>
                                {:}
                                <li><a href="#" onclick="get_examiner_pool('{page - 1}'); return false;">&laquo;</a></li>
                                {/}

                                {@paging.pages}
                                {?.type == "dot"}
                                <li class="disabled"><a href="#">...</a></li>
                                {:}
                                <li {?.type == "current"}class="active"{/}><a href="#" onclick="get_examiner_pool('{.page}'); return false;">{.page}</a></li>
                                {/}
                                {/}

                                {?page >= paging.tot_page}
                                <li class="disabled"><a href="#">&raquo;</a></li>
                                {:}
                                <li><a href="#" onclick="get_examiner_pool('{page + 1}'); return false;">&raquo;</a></li>
                                {/}
                            </ul>
                        </div>
                        {:}
                        <div class="alert alert-warning">  미리 선정된 심사위원이 없습니다. </div>
                        {/}
<script type="text/javascript">
//<![CDATA[
$("#check_all").click(function(){
    var chk = $(this).prop("checked");//.attr('checked');
    if(chk) {
        $("input[name=id_con]").prop('checked', true);
        $("input[name=id_con]:disabled").prop('checked', false);
    }
    else  $("input[name=id_con]").prop('checked', false);
});
//]]>
</script>