                        <h4><span class="icon-user"></span> 경진대회 운영진</h4>
                        {? list}
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th class="td-name">이름</th> 
                                        <th class="td-group">소속</th>
                                        <th class="td-history">운영진 이력</th>
                                        <th class="td-info">운영진 정보 </th> 
                                    </tr>
                                </thead>
                                <tbody>
                                    {@ list}
                                    <tr>
                                        <td class="td-name"><a href="#" onclick="view_examiner('{.user_id}'); return false;">{.name}</a></td>                                             
                                        <td class="td-group"><a href="#">{.com.name}</a></td>
                                        <td class="td-history"><a href="#" onclick="view_examiner('{.user_id}'); return false;">{.comp}</td>
                                        <td class="td-info"> <a href="#" onclick="view_examiner('{.user_id}'); return false;" class="btn btn-default btn-xs">정보보기</a></td> 
                                    </tr>
                                    {/}
                                </tbody>
                            </table>
                        </div>
                        <!-- /table -->
                        {:}
                        <div class="alert alert-warning">선정된 심사위원이 없습니다. 아래의 목록에서 심사위원을 선정하거나 초대해주세요.</div>
                        {/} 