
                <div class="content col-xs-12 col-sm-12 col-md-9">
                    <div class="content-header">

                        <button class="btn btn-primary btn-sm pull-right" onclick="javascript:document.location.href='/event/add'"><span class="icon-fixed-width icon-large icon-edit"></span> 이벤트 작성하기</button>
                        
                        <h3 class="content-heading"> <span class="icon-calendar"></span> 이벤트 관리 </h3>
                        
                        <ul class="nav nav-tabs">
                            <li><a href="/member/edit_event"><span class="icon-fixed-width icon-ok"></span> 신청한 이벤트</a></li>
                            <li class="active"><a href="/member/edit_event_m" ><span class="icon-fixed-width  icon-pencil "></span> 작성한 이벤트</a></li>
                        </ul>
                    </div>
                    <div class="tab-content">
                        <div class="tab-pane active" id="writed"> {? event} 
                            <!--
                            <ul class="media-list post-list">
                                {@ event}
                                <li class="media"> {? .picture}<a href="/event/apply/{.id}" class="pull-left"> <img class="media-object" src="{.picture}"> </a>{/}
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/event/apply/{.id}">{.title}</a></h4>
                                        &nbsp;&nbsp;
                                        {? .date > date('Y.m.d')}
                                        <button class="btn btn-default btn-xs" onclick="javascript:location.href='/event/add/{.id}'">Edit</button>
                                        {/}
                                        {? .state == 0}<span class="label label-info">승인대기</span>
                                        {/}
                                        {? .state == 1}<span class="label label-success">승인</span>
                                        {/}
                                        {? .state == 2}<span class="label label-warning">반려</span>
                                        {/}
                                        <p> 일정 : {.date} {.start} ~ {.date_e} {.end} <br>
                                            장소 : {? .space_id}{.sname} {.opt}F{:}{.space_etc}{/}
                                            {?.state  == 2} <br>
                                            반려사유 : {.state_des}
                                            {/} </p>
                                        <div class="media-actions"><span class="category">{.ename}</span> <span class="icon-time"></span>&nbsp; {=trans_date_ago(.date_created)}</span> </div>
                                    </div> 
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
                                            <th class="td-manage" width="120">관리</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    
                                    {@ event}
                                    <tr id="ev_{.id}">
                                        <td class="td-num">{= res_cnt - (pagesize*(page-1) + .key_)}</td>
                                        <td class="td-status"> {? .state == 0}<span class="label label-info">승인대기</span>{/}
                                            {? .state == 1}<span class="label label-success">승인</span>{/}
                                            {? .state == 2}<span class="label label-warning" data-placement="top" data-toggle="popover" data-content="{.state_des}">반려</span>{/} </td>
                                        <td class="td-subject"><a href="/event/apply/{.id}">{.title}</a></td>
                                        <td class="td-date">{.date} {.start} ~ {.date_e} {.end}</td>
                                        <td class="td-space"> {? .space_id}{.sname} {.opt}F{:}{.space_etc}{/}</td>
                                        <td class="td-manage"> 
                                            {? .date > date('Y.m.d')} 
                                            <a title="수정하기" data-toggle="tooltip" class="btn btn-default btn-xs" href="/event/add/{.id}" > <span class="icon-fixed-width icon-pencil"></span> <span class="sr-only">Edit</span> </a> &nbsp; 
                                            {/}
                                            <a title="신청자 보기" data-toggle="tooltip" class="btn btn-default btn-xs" href="/event/info/{.id}" > <span class="icon-fixed-width icon-user"></span> <span class="sr-only">신청자 보기</span> </a> &nbsp; 
                                            <button data-toggle="tooltip" class="btn btn-danger btn-xs" type="button" title="삭제" onclick="del_event('{.id}'); return false;"> <span class="icon-fixed-width icon-trash"></span> <span class="sr-only">삭제</span> </button>
                                        </td>
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
                                    <li><a href="/member/edit_event_m/{page - 1}">&laquo;</a></li>
                                    {/}

                                    {@paging.pages}
                                    {?.type == "dot"}
                                    <li class="disabled"><a href="#">...</a></li>
                                    {:}
                                    <li {?.type == "current"}class="active"{/}><a href="/member/edit_event_m/{.page}">{.page}</a></li>
                                    {/}
                                    {/}

                                    {?page == paging.tot_page}
                                    <li class="disabled"><a href="#">&raquo;</a></li>
                                    {:}
                                    <li><a href="/member/edit_event_m/{page + 1}" >&raquo;</a></li>
                                    {/}
                                </ul>
                            </div>
                            <!-- /paging -->

                            {:}
                            <div class="alert alert-info">
                                <p><strong>Oops!</strong> 작성한 내역이 없습니다. </p>
                            </div>
                            {/} </div>
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

function del_event(_id) {
    msg_confirm('del_event_('+_id+')', '정말 삭제 하겠습니까?');
}

function del_event_(_id) {
    
    var _url = '/ajax_front/del_event/'+_id;
    $.get(_url, function (){
        $('#ev_'+_id).remove();
        $('.modal').modal('hide');
    });
        
}
//]]>
</script>