
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"><!-- section -->
                <section> 
                
                    <!-- panel -->
                    <div class="panel panel-default">
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-align-justify"></span><span class="break"></span>책 목록</h2>
                            <div class="actions">
                                <span class="break"></span>
                                <a href="/admin_event/book_add" data-toggle="tooltip" title="책 추가"><span class="glyphicon  glyphicon-plus"></span></a> 
                            </div>
                        </div>
                        <!-- /panel-heading --> 
                        <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th class="td-name">이벤트 일자</th>
                                        <th class="td-type">책 제목</th>
                                        <th class="td-floor">이벤트 URL</th>
                                        <th class="td-type" >멘토 정보</th>
                                        <th class="td-list" >관련 분야</th>
                                        <th class="td-list" >관리</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {@ res}
                                    <tr>
                                        <td class="td-name"><a href="/admin_event/book_add/{.id}">{.dates}</a></td>
                                        <td class="td-type">{.title}</td>
                                        <td class="td-floor">{.url}</td>
                                        <td class="td-type">{.mento_name}</a></td>
                                        <td class="td-list">{.tags}</td>
                                        <th class="td-list" ><a href="/admin_event/book_add/{.id}"><span class="label label-default">수정/삭제</span></a></th>
                                    </tr>
                                    {/}
                                </tbody>
                            </table>
                    </div>
                    <!-- /panel --> 
                
                
                </section>
                <!-- /section --></div>
            <!-- /contentwrap --> 
