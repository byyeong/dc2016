
                        {? res}
                        <div class="table-responsive">
                            <form name="e_pool_list">
                                <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th width="60" class="td-select"><span class="icon-check" ></span></th>
                                        <th class="td-name">이름</th>
                                        <th class="td-email">이메일</th>
                                        <th class="td-group">소속</th>
                                        <th class="td-history">심사위원 이력</th>
                                        <th class="td-desc">심사위원 소개</th>
                                        <!--<th class="td-manage">관리</th>-->
                                    </tr>
                                </thead>
                                
                                <tbody>
                                    {@ res}
                                    <tr id="exm_{.id}">
                                        <td class="td-select"><input type="checkbox" name="id_con" value="{.user_id}"></td>
                                        <td class="td-name"><a onclick="view_examiner('{.user_id}'); return false;" href="#">{.name}</a></td>
                                        <td class="td-email">{.memail}</td>
                                        <td class="td-group"><a href="#">{.com.name}</a></td>
                                        <td class="td-history"><a href="#">{.comp.subject}</a></td>
                                        <td class="td-desc"> {=htmlspecialchars(.bio)}</td>
                                        <!--<td class="td-manage">
                                            <button title="삭제" type="button" class="btn btn-danger btn-xs" data-toggle="tooltip" onclick="del_examiner('{.id}'); return false;"><span class="icon-fixed-width icon-trash"></span></button>
                                        </td>-->
                                    </tr>
                                    {/}
                                
                                </tbody>
                               
                            </table></form>
                        </div>
                                
                        <div class="list-controller"> 선택한 위원을
                            <button class="btn btn-primary btn-sm" onclick="add_examiner(); return false;">심사위원 선정</button>
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