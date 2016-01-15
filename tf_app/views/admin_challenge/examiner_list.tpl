
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-align-justify"></span><span class="break"></span>심사위원 라이브러리</h2>
                            <div class="actions"> <span class="break"></span> <a title="심사위원 추가" data-toggle="tooltip" href="/admin_challenge/examiner_add"><span class="glyphicon  glyphicon-plus"></span></a> </div>
                        </div>
                        <!-- /panel-heading -->
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th width="60" class="td-num">번호</th>
                                    <th class="td-name">이름</th>
                                    <th class="td-group">소속</th>
                                    <th class="td-history">심사위원 이력</th>
                                    <th class="td-info">심사위원 정보</th>
                                    <th class="td-status">상태</th>
                                    <th class="td-status">관리</th> 
                                </tr>
                            </thead>
                            <tbody>
                                {@ res}
                                <tr id="ex_{.id}">
                                    <td class="td-num">{= res_cnt - (pagesize*(page-1) + .key_)}</td>
                                    <td class="td-name">{?.name}<a href="#" onclick="view_examiner('{.user_id}'); return false;">{.name}</a>{:}초대중...{/}</td>
                                    <td class="td-group">{?.name}<a href="/admin_startup/add/{.com.id}">{.com.name}</a>{:}{.email}{/}</td>
                                    <td class="td-history"><a href="#" onclick="view_examiner('{.user_id}'); return false;">{.comp}</a></td>  
                                    <td class="td-info"> <a href="#" onclick="view_examiner('{.user_id}'); return false;" class="btn btn-default btn-xs">정보보기</a></td>
                                    <td class="td-status">
                                        {? .status == 0}<span class="label label-default">초대중</span>{/}
                                        {? .status == 1}<span class="label label-success">승락</span>{/}
                                        {? .status == 2}<a onclick="get_reject('{.id}', '{.competition_id}'); return false;" href="#"><span class="label label-warning">거절</span>{/}
                                    </td>
                                    <td class="td-status">
                                        <button type="button" class="btn btn-danger btn-xs" data-toggle="tooltip" title="삭제" onclick="del_examiner('{.id}'); return false;">
                                        <span class="glyphicon  glyphicon-trash  glyphicon-white"></span>
                                        </button>
                                    </td> 
                                </tr>
                                {/}
                            </tbody>
                        </table>
                        <div class="panel-footer">
                            <div class="paging">
                                <ul class="pagination">
                                    {?page == 1}
                                    <li class="disabled"><a href="#">&laquo;</a></li>
                                    {:}
                                    <li><a href="/admin_challenge/examiner_list/{page - 1}">&laquo;</a></li>
                                    {/}

                                    {@paging.pages}
                                    {?.type == "dot"}
                                    <li class="disabled"><a href="#">...</a></li>
                                    {:}
                                    <li {?.type == "current"}class="active"{/}><a href="/admin_challenge/examiner_list/{.page}">{.page}</a></li>
                                    {/}
                                    {/}

                                    {?page == paging.tot_page}
                                    <li class="disabled"><a href="#">&raquo;</a></li>
                                    {:}
                                    <li><a href="/admin_challenge/examiner_list/{page + 1}" >&raquo;</a></li>
                                    {/}
                                </ul>
                            </div>
                        </div>
                        <!-- /panel-footer --> 
                    </div>
                    <!-- /panel --> 
                    
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 
<script type="text/javascript">
//<![CDATA[

{? msg}
alert('{msg}')
{/}

function view_examiner(_id)
{
    var url = '/ajax_front/get_examiner_per/'+_id;
    $.get(url, function(_data){
        $('#md-examinerInfo').html('');
        $('#md-examinerInfo').append(_data);
        $('#md-examinerInfo').modal('show');
    });
}

function del_examiner(_id){
    if (confirm("삭제 하시겠습니까?")){
         var url = '/ajax/del_examiner/'+_id;
        $.get(url, function(_data){
            $('#ex_'+_id).remove();
        });
    }else{
      return false;
    }
    
}

//]]>
</script>

<!-- modal -->
<div class="modal fade" id="md-examinerInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div>
<!-- /modal --> 

<!-- modal -->
<div class="modal fade" id="md-managerRefuse" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div>
<!-- /modal --> 