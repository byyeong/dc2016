
            
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2><span class="icon-align-justify"></span><span class="break"></span>뉴스레터 목록</h2>
                            <div class="actions"> <span class="break"></span> <a title="뉴스레터 추가" data-toggle="tooltip" href="/admin_newsletter/add"><span class="icon-plus"></span></a> </div>
                        </div>
                        <!-- /panel-heading -->
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th width="60" class="td-num">번호</th>
                                    <th class="td-subject">뉴스레터 제목</th>
                                    <th width="100" class="td-date">작성일</th>
                                    <th width="100" class="td-status">미리보기</th>
                                    <th class="td-status" width="80">관리</th>
                                </tr>
                            </thead>
                            <tbody>
                                {@ res}
                                <tr>
                                    <td class="td-num">{= res_cnt - (pagesize*(page-1) + .key_)}</td>
                                    <td class="td-subject"><a href="/admin_newsletter/add/{.id}">{.subject}</a></td>
                                    <td class="td-date">{.date}</td>
                                    <td class="td-status"><button class="btn btn-default btn-xs" type="button" onclick="newsletterPop('{.id}', 0);">미리보기</button></td>
                                    <td class="td-status">
                                        <button type="button" class="btn btn-danger btn-xs" data-toggle="tooltip" title="삭제" onclick="del_newslt('{.id}', this); return false;"><span class="glyphicon  glyphicon-trash  glyphicon-white"></span></button>
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
                                    <li><a href="/admin_newsletter/{page - 1}">&laquo;</a></li>
                                    {/}

                                    {@paging.pages}
                                    {?.type == "dot"}
                                    <li class="disabled"><a href="#">...</a></li>
                                    {:}
                                    <li {?.type == "current"}class="active"{/}><a href="/admin_newsletter/{.page}">{.page}</a></li>
                                    {/}
                                    {/}

                                    {?page == paging.tot_page}
                                    <li class="disabled"><a href="#">&raquo;</a></li>
                                    {:}
                                    <li><a href="/admin_newsletter/{page + 1}" >&raquo;</a></li>
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
            <!-- /End Page Cotents --> 
            