
                    <div class="content col-xs-12 col-sm-12 col-md-9">
                        <div class="content-header">   
                            <h3 class="content-heading"> <i class="fa fa-clock-o"></i> Office Hours  목록</h3>
                        </div>
     
                        {? res}
                        <div class="table-responsive">
                            <table class="table table-hover table-striped">
                                <thead>
                                    <tr>
                                        <th width="50" class="td-num">번호</th> 
                                        <th class="td-subject">제목 </th>
                                        <th width="70" class="td-date">행사날짜</th>
                                        <th width="140" class="td-date">접수기간</th>
                                        <th width="70" class="td-date">발표일</th>
                                        <th width="90" class="td-status">진행상태</th>
                                        <th width="80" class="td-manage">관리 </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {@ res}
                                    <tr>
                                        <td class="td-num">{= res_cnt - (pagesize*(page-1) + .key_)}</td> 
                                        <td class="td-subject"><a href="/office_hours/views/{.id}">{.subject}</a></td>
                                        <td class="td-date">{=substr(.e_start,0,10)}~{=substr(.e_end,0,10)}</td>
                                        <td class="td-date">{=substr(.a_start,0,10)}~{=substr(.a_end,0,10)}</td>
                                        <td class="td-date">{=substr(.r_date,0,10)}</td>
                                        <td class="td-status">
                                            {? .a_start > date('Y.m.d H:i')}
                                            <span class="label label-default">접수대기중</span>
                                            {/}
                                            {? .a_start <= date('Y.m.d H:i') && .a_end > date('Y.m.d H:i')}
                                            <span class="label label-success">접수중</span>
                                            {/}
                                            {? .a_end < date('Y.m.d H:i')}
                                            {? .status}
                                            <span class="label label-info">마감(선정완료)</span>
                                            {:}
                                            <span class="label label-info">접수마감(선정중)</span>
                                            {/}
                                            {/}
                                            {? .astatus == 0}<span class="label label-primary">심사중</span>{/}
                                            {? .astatus == 1}<span class="label label-success">선정</span>{/}
                                            {? .astatus == 2}<span class="label label-default">미선정</span>{/}
                                        </td>
                                        <td class="td-manage">
                                             <a title="" data-toggle="tooltip" class="btn btn-default btn-xs" href="/office_hours/apply/{.id}/{.aid}" data-original-title="수정하기"><span class="icon-fixed-width icon-pencil"></span></a>
                                             <button title="삭제" type="button" class="btn btn-danger btn-xs" data-toggle="tooltip" onclick="del_apply('{.aid}'); return false;"><span class="icon-fixed-width icon-trash"></span></button>
                                        </td>
                                    </tr>
                                    {/}
                                </tbody> 
                            </table>
                        </div>
    
                        <div class="paging text-center">
                            <ul style=" margin: 0;" class="pagination">
                                {?page == 1}
                                <li class="disabled"><a href="#">&laquo;</a></li>
                                {:}
                                <li><a href="/member/edit_office/{page - 1}">&laquo;</a></li>
                                {/}

                                {@paging.pages}
                                {?.type == "dot"}
                                <li class="disabled"><a href="#">...</a></li>
                                {:}
                                <li {?.type == "current"}class="active"{/}><a href="/member/edit_office/{.page}">{.page}</a></li>
                                {/}
                                {/}

                                {?page == paging.tot_page}
                                <li class="disabled"><a href="#">&raquo;</a></li>
                                {:}
                                <li><a href="/member/edit_office/{page + 1}" >&raquo;</a></li>
                                {/}
                            </ul>
                        </div>
                        <!-- /paging --> 
                        {:}
                        <div class="alert alert-info">
                            <p><strong>Oops!</strong> 신청한 내역이 없습니다. Office Hours를 신청해주세요.</p>
                        </div>
                        {/}
                    
                    </div>
                    <!-- /content --> 