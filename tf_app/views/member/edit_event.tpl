
                <div class="content col-xs-12 col-sm-12 col-md-9">
                    <div class="content-header">

                        <button class="btn btn-primary btn-sm pull-right" onclick="javascript:document.location.href='/event/add'"><span class="icon-fixed-width icon-large icon-edit"></span> 이벤트 작성하기</button>
                        
                        <h3 class="content-heading"> <span class="icon-calendar"></span> 이벤트 관리 </h3>
                        
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="/member/edit_event"><span class="icon-fixed-width icon-ok"></span> 신청한 이벤트</a></li>
                            <li><a href="/member/edit_event_m"><span class="icon-fixed-width  icon-pencil "></span> 작성한 이벤트</a></li>
                        </ul>
                    </div>
                    <div class="tab-content">
                        <div class="tab-pane active" id="applied"> {? apply} 
                            <!--
                            <ul class="item-list">
                                {@ apply}
                                <li id="ev_apply_{.id}"> <a href="/event/apply/{.event_id}">{.ev.title} </a> &nbsp;&nbsp;
                                    {? .ev.date > date('Y.m.d')}
                                    <button onclick="del_apply('{.id}');" class="btn btn-default btn-xs">신청취소</button>
                                    {/}
                                    {? .state == 0}<span class="label label-info">참여 접수</span>
                                    </p>
                                    {/}
                                    {? .state == 1}<span class="label label-success">참여대상</span>
                                    </p>
                                    {/}
                                    {? .state == 2}<span class="label label-warning">반려</span>
                                    </p>
                                    {/}
                                    <p> 일정 : {.ev.date} {.ev.start} ~ {.ev.date_e} {.ev.end} <br>
                                        장소 : {? .ev.space_id}{.ev.sname} {.ev.opt}F{:}{.ev.space_etc}{/} </p>
                                </li>
                                {/}
                            </ul>
                            -->
                            <div class="table-responsive">
                                <table class="table table-hover table-striped">
                                    <thead>
                                        <tr>
                                            <th class="td-num" width="60">번호</th>
                                            <th class="td-status" width="60">상태</th>
                                            <th class="td-subject">제목</th>
                                            <th class="td-date" width="260">일정</th>
                                            <th class="td-space" width="160">장소</th>
                                            <th class="td-manage" width="80">관리</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    
                                    {@ apply}
                                    <tr  id="ev_apply_{.id}">
                                        <td class="td-num">{= res_cnt - (pagesize*(page-1) + .key_)}</td>
                                        <td class="td-status"> {? .state == 0}<span class="label label-info">참여 접수</span>{/}
                                            {? .state == 1}<span class="label label-success">참여대상</span>{/}
                                            {? .state == 2}<span class="label label-warning">반려</span>{/} </td>
                                        <td class="td-subject"><a href="/event/apply/{.event_id}">{.ev.title} </a></td>
                                        <td class="td-date">{.ev.date} {.ev.start} ~ {.ev.date_e} {.ev.end}</td>
                                        <td class="td-space"> {? .ev.space_id}{.ev.sname} {.ev.opt}F{:}{.ev.space_etc}{/}</td>
                                        <td class="td-manage"> {? .ev.date > date('Y.m.d')}
                                            <button onclick="del_apply('{.id}');" class="btn btn-default btn-xs">신청취소</button>
                                            {/} </td>
                                    </tr>
                                    {/}
                                        </tbody>
                                    
                                </table>
                            </div>

                            <div class="paging text-center">
                                <ul class="pagination" style=" margin: 0;">
                                    {?page == 1}
                                    <li class="disabled"><a href="#">&laquo;</a></li>
                                    {:}
                                    <li><a href="/member/edit_event/{page - 1}">&laquo;</a></li>
                                    {/}

                                    {@paging.pages}
                                    {?.type == "dot"}
                                    <li class="disabled"><a href="#">...</a></li>
                                    {:}
                                    <li {?.type == "current"}class="active"{/}><a href="/member/edit_event/{.page}">{.page}</a></li>
                                    {/}
                                    {/}

                                    {?page == paging.tot_page}
                                    <li class="disabled"><a href="#">&raquo;</a></li>
                                    {:}
                                    <li><a href="/member/edit_event/{page + 1}" >&raquo;</a></li>
                                    {/}
                                </ul>
                            </div>
                            <!-- /paging -->

                            {:}
                            <div class="alert alert-info">
                                <p><strong>Oops!</strong> 신청한 내역이 없습니다. </p>
                                <p>
                                    <button class="btn btn-primary btn-sm" onclick="javascript:document.location.href='/?c=event'"><span class="icon-fixed-width icon-large icon-reorder"></span> 이벤트 보기</button>
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
function del_apply(_id) {
    msg_confirm('del_apply_('+_id+')', '정말 신청 취소 하겠습니까?');
}

function del_apply_(_id) {
    
    var _url = '/ajax_front/del_event_apply/'+_id;
    $.get(_url, function (){
        $('#ev_apply_'+_id).remove();
        $('.modal').modal('hide');
    });
        
}
//]]>
</script>