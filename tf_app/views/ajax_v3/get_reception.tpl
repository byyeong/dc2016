                      <h4><i class="fa fa-check-square-o"></i> 접수목록</h4>

                      <div class="table-responsive">
                          <form class="form-horizontal" role="form" name="rec_list">
                              <table class="table table-striped table-hover">
                                  <thead>
                                      <tr>
                                          <th width="60" class="td-select"><span class="icon-check"></span></th>
                                          <th class="td-name">참가자</th> 
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
                                          <td class="td-select"><input type="checkbox" name="id_rec" value="{.id}"></td>
                                          <td class="td-name">{?.f_name}{.f_name}{:}{.name}{/}</td>
                                          <td class="td-group">{?.f_team}{.f_team}{:}{.team}{/}</td>
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
                                          <td  colspan="7">접수목록이 없습니다.</td>
                                      </tr>
                                      {/}
                                  </tbody>
                                  
                              </table>
                          </form>
                      </div>
                      <!-- /table -->
                      {? res}
                      <div class="list-controller"> 
                          {? date('Y.m.dH:i') > r.edate}{/}
                          선택한 참가자를
                          <button class="btn btn-primary btn-sm" onclick="add_winner(); return false;">수상자 선정</button>
                          <form style="width: 220px; float: right; margin: 0 10px;" role="search" class="" action="javascript:get_reception('{cid}', '1');">
                              <div class="input-group">
                                  <input type="text" value="{search}" name="search" class="form-control">
                                  <span class="input-group-btn">
                                  <button class="btn btn-default" type="submit" data-toggle="tooltip" title="검색"><span class="icon-search"></span></button>
                                  </span> </div>
                          </form>
                          <ul class="pagination pull-right">
                              {?page == 1}
                              <li class="disabled"><a href="#">&laquo;</a></li>
                              {:}
                              <li><a href="#" onclick="get_reception('{cid}', '{page - 1}'); return false;">&laquo;</a></li>
                              {/}

                              {@paging.pages}
                              {?.type == "dot"}
                              <li class="disabled"><a href="#">...</a></li>
                              {:}
                              <li {?.type == "current"}class="active"{/}><a href="#" onclick="get_reception('{cid}', '{.page}'); return false;" >{.page}</a></li>
                              {/}
                              {/}

                              {?page >= paging.tot_page}
                              <li class="disabled"><a href="#">&raquo;</a></li>
                              {:}
                              <li><a href="#" onclick="get_reception('{cid}', '{page + 1}'); return false;" >&raquo;</a></li>
                              {/}
                          </ul>

                      </div>
                      <!-- /list-controller -->
                      {/}