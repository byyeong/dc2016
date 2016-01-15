
            <div class="col-xs-12 col-sm-12 col-md-9 content">
                <div class="content-header">                    
                    <button class="btn btn-primary btn-sm pull-right" onclick="javascript:document.location.href='/benefits/edit'"><span class="icon-fixed-width icon-large icon-edit"></span> 프로그램 만들기</button>
                    
                    <h3  class="content-heading"> <span class="icon-trophy"></span> Benefits 관리 </h3>                    
                    
                    <ul class="nav nav-tabs">
                        {? make} 
                        <li class="active"><a href="/member/edit_benefit_m"><span class="icon-fixed-width icon-pencil"></span> 개최한 프로그램</a>
                        </li>
                        {/}
                        <li><a href="/member/edit_benefit"><span class="icon-fixed-width  icon-edit "></span> 참가한 프로그램</a>
                        </li> 
                    </ul>
                </div>
                <div class="tab-content"> 
                    {? make}
                    <div class="tab-pane active" id="writed">
                        <h4 class="sr-only">개최한 Benefits</h4>

                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th class="td-num" width="60">번호</th>
                                        <th class="td-status" width="80">승인여부</th>
                                        <th class="td-status" width="80">진행상태</th>
                                        <th class="td-subject">프로그램명</th>
                                        <th class="td-applier" width="80">참가자</th>
                                        <th class="td-manage" width="110">대회 관리</th>
                                    </tr>
                                </thead>
                                <tbody>                                
                                {@ make}
                                <tr id="make_{.id}">
                                    <td class="td-num">{= res_cnt - (pagesize*(page-1) + .key_)}</td>
                                    <td class="td-status"> 
                                        {? .status == 0}<span class="label label-success">승인대기</span>{/}
                                        {? .status == 1}<span class="label label-default">승인</span>{/}
                                        {? .status == 2}<span class="label label-warning" data-placement="top" data-toggle="popover" data-content="{.status_des}">반려</span>{/} 
                                    </td>
                                    <td class="td-status"> 
                                        {? .a_start}
                                        {? date('Y.m.d H:i') < .a_start}<span class="label label-info">접수준비</span>{/}
                                        {? date('Y.m.d H:i') > .a_start && date('Y.m.d H:i') < .a_end}<span class="label label-primary">접수중</span>{/}
                                        {? date('Y.m.d H:i') > .a_end}<span class="label label-warning">접수마감</span>{/}
                                        {:}
                                        <span class="label label-primary">상시접수</span>
                                        {/}
                                    </td>
                                    <td class="td-subject"><a href="/benefits/applied_list/{.id}?tab=dashboard">
                                        {.title}{?.agency} - {.agency}{/}</a>
                                        <a title="" data-toggle="tooltip" href="/benefits/views/{.id}" data-original-title="내용보기"><i class="fa fa-external-link"></i></a>
                                    </td>
                                    <td class="td-applier"> 
                                        {? .cnt} 
                                        <a href="/benefits/applied_list/{.id}" title="참가자보기" data-toggle="tooltip"><span class="badge badge-primary"> {.cnt} <i class="icon-caret-right"></i></span> </a> 
                                        {:} 
                                        <a href="/benefits/applied_list/{.id}" title="참가자보기" data-toggle="tooltip"><span class="badge badge-default">0 <i class="icon-caret-right"></i></span></a> 
                                        {/} 
                                    </td>
                                    <td class="td-manage">
                                        <a href="/benefits/edit/{.id}" class="btn btn-default btn-xs" data-toggle="tooltip" title="수정하기"><span class="icon-fixed-width icon-pencil"></span></a> &nbsp; 
                                        <button data-toggle="tooltip" class="btn btn-danger btn-xs" type="button" title="삭제" onclick="del_pro('{.id}'); return false;">
                                        <span class="icon-fixed-width icon-trash"></span> <span class="sr-only">삭제</span>
                                        </button>
                                    </td>
                                </tr>
                                {/}
                                </tbody>                                
                            </table>
                        </div>
                        <!--/table --> 

                        <div class="paging text-center">
                            <ul class="pagination" style=" margin: 0;">
                                {?page == 1}
                                <li class="disabled"><a href="#">&laquo;</a></li>
                                {:}
                                <li><a href="/member/edit_benefit_m/{page - 1}">&laquo;</a></li>
                                {/}

                                {@paging.pages}
                                {?.type == "dot"}
                                <li class="disabled"><a href="#">...</a></li>
                                {:}
                                <li {?.type == "current"}class="active"{/}><a href="/member/edit_benefit_m/{.page}">{.page}</a></li>
                                {/}
                                {/}

                                {?page == paging.tot_page}
                                <li class="disabled"><a href="#">&raquo;</a></li>
                                {:}
                                <li><a href="/member/edit_benefit_m/{page + 1}" >&raquo;</a></li>
                                {/}
                            </ul>
                        </div>
                        <!-- /paging -->

                        {:}

                        <div class="alert alert-info">
                            <p><strong>Oops!</strong> 개최한 내역이 없습니다. </p>
                        </div>
                        {/} 

                    </div>
                    <!-- /tab-pane --> 

                </div>
                <!-- /tab-content --> 
                
            </div>
            <!-- /content --> 

<!-- /rowContent --> 
<script type="text/javascript">
//<![CDATA[

{? msgt}
_m = "Benefits(스타트업 지원 프로그램) 개설 신청이 잘 접수되었습니다.<br><br>신청 내용은 승인 후 상세 정보를 입력하실 수 있습니다.<br>승인은 최대 48시간이 소요됩니다.<br><br>빠른 승인 필요하신 경우에는 Support 메뉴를 통해 문의 부탁드립니다.";
msg_confirm_cm('move_support();', _m);
{/}

function move_support()
{
    location.href = "/support/qna";
}

// popover
$('.container').popover ({
    selector: "[data-toggle=popover]",
    trigger: "hover",
    title: "반려 사유",
    html: 'true',
    content : ""
}) 

function del_pro(_id)
{
    del_confirm('del_pro2('+_id+')');
}

function del_pro2(_id)
{
    var get_url = '/ajax_v3/del_benefit/'+_id;
    $.get(get_url, function(){
        window.location.reload(true);
    });
}

//]]>
</script>