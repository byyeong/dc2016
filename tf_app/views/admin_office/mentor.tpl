            <!-- contentswrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                    
                    <!-- panel --> 
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2>
                                <span class="icon-align-justify"></span><span class="break"></span>
                                멘토 목록 
                            </h2>
                            <div class="actions"> 
                                <span class="break"></span> 
                                <a title="멘토 추가" data-toggle="tooltip" href="/admin_office/edit_mentor">
                                    <span class="icon-plus"></span>
                                </a> 
                            </div>
                        </div>
                        <!-- /panel-heading -->
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th width="60" class="td-num">번호</th>
                                    <th class="td-id">DAMP ID</th>
                                    <th class="td-name">이름</th>
                                    <th class="td-company">소속</th>
                                    <th class="td-position">직책</th>
                                    <th class="td-info">멘토정보</th>
                                    <th class="td-info">관리</th>
                                    <th class="td-public">공개 </th>
                                </tr>
                            </thead>
                            <tbody>
                                {@ res}
                                <tr>
                                    <td class="td-num">{= res_cnt - (pagesize*(page-1) + .key_)}</td>
                                    <td class="td-id">{.ids}</td>
                                    <td class="td-name">{.name}</td>
                                    <td class="td-company">{.department}</td>
                                    <td class="td-position">{.position}</td>
                                    <td class="td-info"><a href="/admin_office/edit_mentor/{.id}" class="btn btn-default btn-xs">정보수정</a></td>
                                    <td class="td-info">
                                        <button data-toggle="tooltip" class="btn btn-danger btn-xs" type="button" title="삭제" onclick="del_mentor(this, '{.id}'); return false;"><span class="icon-fixed-width icon-trash"></span></button>
                                    </td>
                                    <td class="td-status">
                                        {? .hide}
                                        <span class="label label-success">공개</span>
                                        {:}
                                        <span class="label label-default">비공개</span>
                                        {/}
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
                                    <li><a href="/admin_office/mentor/{page - 1}">&laquo;</a></li>
                                    {/}

                                    {@paging.pages}
                                    {?.type == "dot"}
                                    <li class="disabled"><a href="#">...</a></li>
                                    {:}
                                    <li {?.type == "current"}class="active"{/}><a href="/admin_office/mentor/{.page}">{.page}</a></li>
                                    {/}
                                    {/}

                                    {?page == paging.tot_page}
                                    <li class="disabled"><a href="#">&raquo;</a></li>
                                    {:}
                                    <li><a href="/admin_office/mentor/{page + 1}" >&raquo;</a></li>
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