                    <div class="panel panel-default" id="pane-calendar-date"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="icon-time"></span><span class="break"></span> {date}</h2>
                        </div>
                        <!-- /panel-heading -->

                        {? res}
                        <!-- TODO : 리스트가 있을 경우 출력 .table 출력 -->
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th class="td-time">시간</th>
                                    <th class="td-floor">장소</th>
                                    <th class="td-type">성격</th>
                                    <th class="td-subject">행사명</th>
                                    <th class="td-person">정원/신청인원/대기자</th>
                                </tr>
                            </thead>
                            <tbody>
                                {@ res}
                                <tr>
                                    <td class="td-time">{.start} ~ {.end}</td>
                                    <td class="td-floor">{? .opt}F{.opt}F {/}{.sname}</td>
                                    <td class="td-type">{.ename}</td>
                                    <td class="td-subject">{.title}</td>
                                    <td class="td-person">
                                        <span title="정원" data-toggle="tooltip" class="badge badge-info">{.cnt}</span> &nbsp; 
                                        <span title="신청인원" data-toggle="tooltip" class="badge badge-success">{.rcnt}</span> &nbsp; 
                                        <span title="대기자" data-toggle="tooltip" class="badge badge-warning">{? .rcnt - .cnt > 0}{.rcnt - .cnt}{:}0{/}</span>
                                    </td>
                                </tr>
                                {/}
                            </tbody>
                        </table>
                        {:}
                        <!-- TODO : 해당하는 이벤트가 없을 경우 .panel-body 출력 -->
                        <div class="panel-body">
                            <div class="alert alert-warning">
                                <strong>Oops</strong> 선택된 날짜에 이벤트가 없습니다.
                            </div>
                        </div>
                        {/}
                        
                    </div>