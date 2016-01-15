                                {? res}
                                <div class="table-responsive">
                                    <table class="table table-hover table-striped">
                                        <thead>
                                            <tr>
                                                <th class="td-num">번호</th>
                                                <th class="td-name">심사위원</th> 
                                                <th class="td-cnt">심사 완료</th>
                                                <th class="td-cnt">남은 평가</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {@ res}
                                            <tr>
                                                <td class="td-num">{= res_cnt - (pagesize*(page-1) + .key_)}</td>
                                                <td class="td-name">{.name}</td>
                                                <td class="td-cnt"><span class="badge badge-info">{.end}</span></td>
                                                <td class="td-cnt"><span class="badge badge-warning">{apply_cnt - .end}</span></span> 
                                                </td>
                                            </tr>
                                            {/}
                                        </tbody>
                                    </table>
                                </div>
                                <div class="paging text-center">
                                    <ul class="pagination">
                                        {?page == 1}
                                        <li class="disabled"><a href="#">&laquo;</a></li>
                                        {:}
                                        <li><a href="#" onclick="get_examiner_list('{cid}', '{page - 1}'); return false;">&laquo;</a></li>
                                        {/}
    
                                        {@paging.pages}
                                        {?.type == "dot"}
                                        <li class="disabled"><a href="#">...</a></li>
                                        {:}
                                        <li {?.type == "current"}class="active"{/}><a href="#" onclick="get_examiner_list('{cid}', '{.page}'); return false;" >{.page}</a></li>
                                        {/}
                                        {/}
    
                                        {?page >= paging.tot_page}
                                        <li class="disabled"><a href="#">&raquo;</a></li>
                                        {:}
                                        <li><a href="#" onclick="get_examiner_list('{cid}', '{page + 1}'); return false;" >&raquo;</a></li>
                                        {/}
                                    </ul>
                                </div> 
                                <!-- /paging --> 
                                {:}
                                <div class="alert alert-info">
                                    <p><strong>Oops!</strong> 등록된 심사위원이 없습니다.</p>
                                </div>
                                {/}