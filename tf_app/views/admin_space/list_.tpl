
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap">
                
                <!-- section -->
                <section> 
                    
                    <!-- panel -->
                    <div class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-cog"></span><span class="break"></span> 공간 목록</h2>
                            <div class="actions"> 
                                <span class="break"></span> 
                                <a title="" data-toggle="tooltip" class="btn-add" href="/admin_space/add" data-original-title="공간 추가"><span class="glyphicon  glyphicon-plus"></span></a>
                            </div>
                        </div>
                        <!-- /panel-heading -->
                        
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <!--<th class="td-check" width="20"><input type="checkbox"></th>-->
                                    <th class="td-type">분류</th>
                                    <th class="td-floor">장소</th>
                                    <th class="td-time">공유 허가 시간</th>
                                    <th class="td-day">공유 요일</th>
                                    <th class="td-status">공간 관리</th>
                                </tr>
                            </thead>
                            <tbody>
                                {@ res}
                                <tr>
                                    <!--<td class="td-check"><input type="checkbox" ></td>-->
                                    <td class="td-type">
                                        {?.type == 1}D.CAMP 회의실{/}
                                        {?.type == 2}외부 행사 대관{/}
                                        {?.type == 3}D.esign 라운지{/}
                                    </th>
                                    <td class="td-floor"><a href="/admin_space/add/{.id}">{.opt}F {.name}</a></td>
                                    <td class="td-time">{.start} ~ {.end}</td>
                                    <td class="td-day">{=return_day(.days)}</td>
                                    {? .visible}
                                    <td class="td-status">
                                        <span class="label label-success">보임</span>
                                        <button data-original-title="삭제" type="button" class="btn btn-danger btn-xs" data-toggle="tooltip" title="" onclick="del_space(this, {.id}); return false;"><span class="glyphicon  glyphicon-trash  glyphicon-white"></span></button>
                                    </td>
                                    {:}
                                    <td class="td-status">
                                        <span class="label label-warning">숨김</span>
                                        <button data-original-title="삭제" type="button" class="btn btn-danger btn-xs" data-toggle="tooltip" title="" onclick="del_space(this, {.id}); return false;"><span class="glyphicon  glyphicon-trash  glyphicon-white"></span></button>
                                    </td>
                                    {/}
                                </tr>
                                {/}
                            </tbody>
                        </table>
                        
                        <!-- panel-footer -->
                        <div class="panel-footer">
                            <div class="paging">
                                <ul class="pagination">
                                    {?page == 1}
                                    <li class="disabled"><a href="#">&laquo;</a></li>
                                    {:}
                                    <li><a href="/admin_space/list_/{page - 1}">&laquo;</a></li>
                                    {/}

                                    {@paging.pages}
                                    {?.type == "dot"}
                                    <li class="disabled"><a href="#">...</a></li>
                                    {:}
                                    <li {?.type == "current"}class="active"{/}><a href="/admin_space/list_/{.page}">{.page}</a></li>
                                    {/}
                                    {/}

                                    {?page == paging.tot_page}
                                    <li class="disabled"><a href="#">&raquo;</a></li>
                                    {:}
                                    <li><a href="/admin_space/list_/{page + 1}" >&raquo;</a></li>
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
function del_space(_this, _id) {

        
    if (confirm("선택된 공간을 삭제할까요?") === true){    //확인
            var get_url = '/ajax/del_space/'+_id;

            $.ajax({
                type : 'POST',
                url : get_url,
                dataType : 'json',
                success : function(_data) {
                    $(_this).parent().parent().hide();
                }
            });
    }else{
            return;
    }
}
//]]>
</script> 