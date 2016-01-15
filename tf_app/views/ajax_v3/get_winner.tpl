                        {? date('Y.m.dH:i') < r.edate}
                        <div class="alert alert-info text-center">
                            <span class="icon-warning-sign"></span> 서류를 접수 마감 후 수상자를 선정할 수 있습니다.
                        </div>
                        {:} 
                        <form class="form-horizontal" role="form" name="win_list">    
                          <table class="table table-striped table-hover">
                              <thead>
                                  <tr>
                                      <th width="60" class="td-select"><span class="icon-check"></span></th>
                                      <th class="td-name">수상자</th> 
                                      <th class="td-group">회사/팀</th>
                                      <th class="td-date">신청일자</th>
                                      <th class="td-content">참가내용 보기</th>
                                      <th class="td-status">상태</th>
                                      <th class="td-score">심사점수</th>
                                  </tr>
                              </thead>
                              
                              <tbody>
                                  {? res}
                                  {@ res}
                                  <tr>
                                      <td class="td-select"><input type="checkbox" name="id_win" value="{.id}"></td>
                                      <td class="td-name">{.name}</td>
                                      <td class="td-group">{.team}</td>
                                      <td class="td-date">{=substr(str_replace('-', '.', .date_created), 0, 10)}</td>
                                      <td class="td-content"><a class="btn btn-default btn-xs" href="/challenge/applied_view/{.id}">내용보기</a></td>
                                      <td class="td-status">
                                          {? .status == 0}<span class="label label-default">접수대기</span>{/}
                                          {? .status == 1}<span class="label label-success">접수</span>{/}
                                          {? .status == 2}<span class="label label-warning">반려</span>{/}
                                      </td>
                                      <td class="td-score"><span class="badge badge-info">{.score} </span></td>
                                  </tr>
                                  {/}
                                  {:}
                                  <tr>
                                      <td colspan="7">수상자 목록이 없습니다.</td>
                                  </tr>
                                  {/}
                              </tbody>
                              
                          </table>
                      </form>
                      {/}