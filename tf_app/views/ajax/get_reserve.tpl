
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
                                    <th class="td-subject">목적</th>
                                    <th class="td-person">정보</th>
                                </tr>
                            </thead>
                            <tbody>
                                {@ res}
                                <tr>
                                    <td class="td-time">{.start} ~ {.end}</td>
                                    <td class="td-floor">{.opt}F {.name}</td>
                                    <td class="td-subject"><a href="/admin_space/reserve/{.id}">{.purpose}</a> {? .rel_url}<a href="{.rel_url}" target="_blank" title="" data-toggle="tooltip" class="btn btn-link btn-xs" data-original-title="사이트에서 보기"><span class="glyphicon  glyphicon-share"></span></a>{/}
                                    </td>
                                    <td class="td-person">
                                        {? .stype==3}
                                        공간 : 
                                        {? .cnt==1}원더우먼(iMac){/}{? .cnt==2}배트맨(PC){/}{? .cnt==3}슈퍼걸(iMac){/}{? .cnt==4}조커(PC){/}
                                        {:}
                                        인원 : <span class="badge badge-info">{.cnt}</span>명
                                        {/}
                                    </td>
                                </tr>
                                {/}
                            </tbody>
                        </table>
                        {:}
                        <!-- TODO : 해당하는 이벤트가 없을 경우 .panel-body 출력 -->
                        <div class="panel-body">
                            <div class="alert alert-warning">
                                <strong>Oops</strong> 선택된 날짜에 공유된 일정이 없습니다.
                            </div>
                        </div>
                        {/}
                    </div>