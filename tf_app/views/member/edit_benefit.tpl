        
            <div class="col-xs-12 col-sm-12 col-md-9 content">
                <div class="content-header">                    
                    <button class="btn btn-primary btn-sm pull-right" onclick="javascript:document.location.href='/benefits/edit'"><span class="icon-fixed-width icon-large icon-edit"></span>  프로그램 만들기</button>
                    
                    <h3  class="content-heading"> <span class="icon-trophy"></span> Benefits 관리 </h3>                    
                    
                    <ul class="nav nav-tabs">
                        {? make} 
                        <li><a href="/member/edit_benefit_m"><span class="icon-fixed-width icon-pencil"></span> 개최한  프로그램</a>
                        </li>
                        {/}
                        <li class="active"><a href="/member/edit_benefit"><span class="icon-fixed-width  icon-edit "></span> 참가한 프로그램</a>
                        </li>
                    </ul>
                </div>
                <div class="tab-content"> 
                    <div class="tab-pane active" id="applied">
                        <h4 class="sr-only">참가신청한 Benefits</h4>
                        {? applied}
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th class="td-num" width="60">번호</th>
                                        <th class="td-status" width="80">진행상태</th>
                                        <th class="td-subject">프로그램명</th>
                                        <th class="td-date" width="180">접수기간</th>
                                        <th class="td-manage" width="120">신청내용</th>
                                    </tr>
                                </thead>
                                <tbody>
                                
                                {@ applied}
                                <tr>
                                    <td class="td-num">{= res_cnt - (pagesize*(page-1) + .key_)}</td>
                                    <td class="td-status"> 
                                        {? .a_start}
                                        {? date('Y.m.d H:i') < .a_start}<span class="label label-info">접수준비</span>{/}
                                        {? date('Y.m.d H:i') > .a_start && date('Y.m.d H:i') < .a_end}<span class="label label-primary">접수중</span>{/}
                                        {? date('Y.m.d H:i') > .a_end}<span class="label label-warning">접수마감</span>{/}
                                        {:}
                                        <span class="label label-primary">상시접수</span>
                                        {/} 
                                    </td>
                                    <td class="td-subject"><a href="/benefits/views/{.id}">{.title}{?.agency} - {.agency}{/}</a></td>
                                    <td class="td-date">
                                        {? .a_start}{=substr(.a_start, 0, 10)} ~ {=substr(.a_end, 0, 10)}{:}상시{/}</td>
                                    <td class="td-manage">
                                        {? .a_start}
                                        {? date('Y.m.d H:i') > .a_start && date('Y.m.d H:i') < .a_end}<a href="/benefits/apply/{.id}/{.caid}" class="btn btn-default btn-xs">내용보기</a>
                                        {:}마감{/}
                                        {:}
                                        <a href="/benefits/apply/{.id}/{.caid}" class="btn btn-default btn-xs">내용보기</a>
                                        {/} 
                                    </td>
                                </tr>
                                {/}
                                </tbody>
                                
                            </table>
                        </div>
                        <!-- /table --> 

                        <div class="paging text-center">
                            <ul class="pagination" style=" margin: 0;">
                                {?page == 1}
                                <li class="disabled"><a href="#">&laquo;</a></li>
                                {:}
                                <li><a href="/member/edit_benefit/{page - 1}">&laquo;</a></li>
                                {/}

                                {@paging.pages}
                                {?.type == "dot"}
                                <li class="disabled"><a href="#">...</a></li>
                                {:}
                                <li {?.type == "current"}class="active"{/}><a href="/member/edit_benefit/{.page}">{.page}</a></li>
                                {/}
                                {/}

                                {?page == paging.tot_page}
                                <li class="disabled"><a href="#">&raquo;</a></li>
                                {:}
                                <li><a href="/member/edit_benefit/{page + 1}" >&raquo;</a></li>
                                {/}
                            </ul>
                        </div>
                        <!-- /paging -->
                        
                        {:}
                        <div class="alert alert-info">
                            <p><strong>Oops!</strong> 신청한 내역이 없습니다. </p>
                            <p>
                                <button class="btn btn-primary btn-sm" onclick="javascript:document.location.href='/benefits'"><span class="icon-fixed-width icon-large icon-reorder"></span> 프로그램 보기</button>
                            </p>
                        </div>
                        {/} 
                    </div>
                    <!-- /tab-pane -->                     
                </div>
                <!-- /tab-content --> 
                
            </div>
            <!-- /content --> 

<script type="text/javascript">
//<![CDATA[

// popover
$('.container').popover ({
    selector: "[data-toggle=popover]",
    trigger: "hover",
    title: "반려 사유",
    html: 'true',
    content : ""
}) 

//]]>
</script>