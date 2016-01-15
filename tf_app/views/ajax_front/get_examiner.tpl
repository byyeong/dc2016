
                        {? res}
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th class="td-name">이름</th>
                                        <th class="td-email">이메일</th>
                                        <th class="td-group">소속</th>
                                        <th class="td-history">심사위원 이력</th>
                                        <th class="td-desc">심사위원 소개</th>
                                        <th class="td-manage">관리</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {@ res}
                                    <tr id="exm_{.id}">
                                        <td class="td-name"><a onclick="view_examiner('{.user_id}'); return false;" href="#">{.name}</a></td>
                                        <td class="td-email">{.memail}</td>
                                        <td class="td-group"><a href="#">{.com.name}</a></td>
                                        <td class="td-history"><a href="#">{.comp.subject}</a></td>
                                        <td class="td-desc"> {=htmlspecialchars(.bio)}</td>
                                        <td class="td-manage">
                                            <button title="삭제" type="button" class="btn btn-danger btn-xs" data-toggle="tooltip" onclick="del_examiner('{.id}'); return false;"><span class="icon-fixed-width icon-trash"></span></button></td>
                                    </tr>
                                    {/}
                                </tbody>
                            </table>
                        </div>
                        {:}
                        <div class="alert alert-warning">  선정된 심사위원이 없습니다. 아래의 목록에서 심사위원을 선정하거나 초대해주세요.  </div>
                        {/}