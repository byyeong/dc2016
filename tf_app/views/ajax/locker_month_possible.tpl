                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th class="td-name">회원명</th>
                                            <th class="td-email">이메일</th>
                                            <th class="td-date">멤버십 승인 일자</th>
                                            <th class="td-date">총 방문 횟수</th>
                                            <th class="td-date">이번 달 방분횟수</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {@ res}
                                        <tr>
                                            <td class="td-name"><a href="/admin_member/add/{.mid}"><img src="{.picture}"> {.name}</a></td>
                                            <td class="td-email">{.email}</td>
                                            <td class="td-date">{? .membership == 1}{.mbs_date}{/}</td>
                                            <td class="td-email">{.cnt_a}</td>
                                            <td class="td-email">{.cnt}</td>
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
                                            <li><a href="#" onclick="get_possible('{page - 1}', '{date}'); return false;">&laquo;</a></li>
                                            {/}

                                            {@paging.pages}
                                            {?.type == "dot"}
                                            <li class="disabled"><a href="#">...</a></li>
                                            {:}
                                            <li {?.type == "current"}class="active"{/}><a href="#" onclick="get_possible('{.page}', '{date}'); return false;">{.page}</a></li>
                                            {/}
                                            {/}

                                            {?page >= paging.tot_page}
                                            <li class="disabled"><a href="#">&raquo;</a></li>
                                            {:}
                                            <li><a href="#" onclick="get_possible('{page + 1}', '{date}'); return false;">&raquo;</a></li>
                                            {/}
                                        </ul>
                                    </div>
                                </div>
                                <!-- /panel-footer --> 