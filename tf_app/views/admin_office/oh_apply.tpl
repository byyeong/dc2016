            <!-- contentswrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                    
                    <!-- panel --> 
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2>
                                <span class="icon-align-justify"></span><span class="break"></span>
                                접수목록 - {oh.mname}멘토 {oh.subject}
                            </h2>
                            
                            <div class="actions"> 
                                <span class="break"></span> 
                                <button class="btn btn-primary btn-xs" onclick="fix_status(this, {oh.id}); return false;" {? oh.status}disabled="disabled"{/}>선정 내용 확정하기</button>
                                <span class="break"></span> 
                                <a title="Office Hours 목록 " data-toggle="tooltip" href="/admin_office">
                                    <span class="icon-align-justify"></span>
                                </a> 
                            </div>
                        </div>
                        <!-- /panel-heading -->
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th width="60" class="td-num">번호</th>
                                    <th class="td-name">이름</th>
                                    <th class="td-company">회사/팀</th>
                                    <th class="td-service">제품/서비스명</th>
                                    <th class="td-phone">휴대폰번호</th>
                                    <th class="td-email">이메일주소</th>
                                    <th class="td-cnt">신청이력 <small>(선정이력/접수이력)</small></th>
                                    <th class="td-status">선정여부</th>
                                    <th class="td-view">신청내용</th>
                                </tr>
                            </thead>
                            <tbody>
                                {@ res}
                                <tr>
                                    <td class="td-num">{= res_cnt - (pagesize*(page-1) + .key_)}</td>
                                    <td class="td-name">{.name}</td>
                                    <td class="td-company">{.team}</td>
                                    <td class="td-service">{.s_subject}</td>
                                    <td class="td-phone">{.tel}</td>
                                    <td class="td-email">{.email}</td>
                                    <td class="td-cnt">{.suc}/{.tot}</td>
                                    <td class="td-status">
                                        {? .status == 0}<span class="label label-primary">심사중</span>{/}
                                        {? .status == 1}<span class="label label-success">선정</span>{/}
                                        {? .status == 2}<span class="label label-default">미선정</span>{/}
                                        {? .suc_t} <small>{=date_to_kr(oh.e_start)}{.suc_t.start}</small>{? .confirm}[확정]{/}{/}
                                    </td>
                                    <td class="td-view"><a href="/admin_office/oh_apply_detail/{.id}" class="btn btn-default btn-xs">내용보기</a></td>
                                </tr>
                                {/}
                            </tbody>
                        </table>
                        <div class="panel-footer">
                            <div class="paging">
                                <ul class="pagination">
                                    {?page == 1}
                                    <li class="disabled"><a href="#">&laquo;</a></li>
                                    {:}
                                    <li><a href="/admin_office/oh_apply/{oh.id}/{page - 1}">&laquo;</a></li>
                                    {/}

                                    {@paging.pages}
                                    {?.type == "dot"}
                                    <li class="disabled"><a href="#">...</a></li>
                                    {:}
                                    <li {?.type == "current"}class="active"{/}><a href="/admin_office/oh_apply/{oh.id}/{.page}">{.page}</a></li>
                                    {/}
                                    {/}

                                    {?page == paging.tot_page}
                                    <li class="disabled"><a href="#">&raquo;</a></li>
                                    {:}
                                    <li><a href="/admin_office/oh_apply/{oh.id}/{page + 1}" >&raquo;</a></li>
                                    {/}
                                </ul>
                            </div>
                        </div>
                        <!-- /panel-footer --> 
                    </div>
                    <!-- /panel --> 
                    
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 