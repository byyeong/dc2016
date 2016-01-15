
                            <h3 class="panel-title"><span class="icon-time"></span> {date}</h3>
                            <div class="table-responsive">
                                {? res}
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th width="120" class="td-time">시간</th>
                                            <th class="td-subject">내용</th>
                                            <th width="240" class="td-space">장소</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {@ res}
                                        <tr>
                                            <td class="td-time">{.start} ~ {.end}</td>
                                            <td class="td-subject"><p>{.purpose} </p>
                                             {? .rel_url}<a class="btn btn-default btn-xs" href="{.rel_url}"><span class="icon-share"></span> 이벤트보기 </a> {/}
                                            </td>
                                            <td class="td-space">{.opt}F {.name}</td>
                                        </tr>
                                        {/}
                                    </tbody>
                                </table>
                                {:}
                                <div class="panel-body">
                                    <div class="alert alert-warning">
                                        <strong>Oops</strong> 선택된 날짜에 공유된 일정이 없습니다.
                                    </div>
                                </div>
                                {/}
                            </div>
                            <!-- /table --> 
