
            <div class="col-xs-12 col-sm-12 col-md-9 content">
                <div class="content-header">                    
                    <button class="btn btn-primary btn-sm pull-right" onclick="javascript:document.location.href='/competition/edit'"><span class="icon-fixed-width icon-large icon-edit"></span> 경진대회 개최하기</button>
                    
                    <h3  class="content-heading"> <span class="icon-trophy"></span> 경진대회 관리 </h3>                    
                    
                    <ul class="nav nav-tabs">
                        <li><a href="/member/edit_competition"><span class="icon-fixed-width  icon-edit "></span> 참가한 경진대회</a>
                        </li>
                        {? make} 
                        <li class="active"><a href="/member/edit_competition_m"><span class="icon-fixed-width icon-pencil"></span> 개최한 경진대회</a>
                        </li>
                        {/}
                        {? examine || st} 
                        <li><a href="/member/edit_competition_ex"><span class="icon-fixed-width  icon-check "></span> 심사위원 위촉 경진대회</a>
                        </li>
                        {/} 
                    </ul>
                </div>
                <div class="tab-content"> 
                    {? make}
                    <div class="tab-pane active" id="writed">
                        <h4 class="sr-only">개최한 경진대회</h4>

                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th class="td-num" width="60">번호</th>
                                        <th class="td-status" width="80">승인여부</th>
                                        <th class="td-status" width="80">진행상태</th>
                                        <th class="td-subject">경진대회명</th>
                                        <th class="td-applier" width="80">참가자</th>
                                        <th class="td-examiner" width="120">심사위원</th>
                                        <th class="td-manage" width="110">관리</th>
                                    </tr>
                                </thead>
                                <tbody>                                
                                {@ make}
                                <tr id="make_{.id}">
                                    <td class="td-num">{= res_cnt - (pagesize*(page-1) + .key_)}</td>
                                    <td class="td-status"> {? .status == 0}<span class="label label-success">승인대기</span>{/}
                                        {? .status == 1}<span class="label label-default">승인</span>{/}
                                        {? .status == 2}<span class="label label-warning" data-placement="top" data-toggle="popover" data-content="{.status_des}">반려</span>{/} </td>
                                    <td class="td-status"> {? date('Y.m.dH:i') < .sdate}<span class="label label-info">접수준비</span>{/}
                                        {? date('Y.m.dH:i') > .sdate && date('Y.m.dH:i') < .edate}<span class="label label-primary">접수중</span>{/}
                                        {? date('Y.m.dH:i') > .announce && .winner}<span class="label label-default">수상자발표</span> {:}{? date('Y.m.dH:i') > .edate}<span class="label label-warning">접수마감</span>{/}{/} </td>
                                    <td class="td-subject"><a href="/competition/views/{.id}">{.subject}</a></td>
                                    <td class="td-applier"> 
                                        {? .cnt} 
                                        <a href="/competition/applied_list/{.id}" title="참가자보기" data-toggle="tooltip"><span class="badge badge-primary"> {.cnt} <i class="icon-caret-right"></i></span> </a> 
                                        {:} 
                                        <a href="/competition/applied_list/{.id}" title="참가자보기" data-toggle="tooltip"><span class="badge badge-default">0 <i class="icon-caret-right"></i></span></a> 
                                        {/} 
                                    </td>
                                    <td class="td-examiner"> 
                                        <a href="/competition/examiner/{.id}" title="심사위원보기" data-toggle="tooltip"><span class="badge {? .exm}badge-info{:}badge-default{/}" > {.exm} <i class="icon-caret-right"></i></span></a>
                                        <!-- a href="" class="btn btn-default btn-xs">관리</a -->
                                    </td>
                                    <td class="td-manage">
                                        <a href="/competition/edit/{.id}" class="btn btn-default btn-xs" data-toggle="tooltip" title="수정하기"><span class="icon-fixed-width icon-pencil"></span></a> &nbsp; 
                                        {? .open}
                                        <button data-toggle="tooltip" class="btn btn-default btn-xs" type="button" title="비공개하기" onclick="change_status(this, '{.id}', 0); return false;">
                                        <span class="icon-fixed-width icon-eye-close"></span> <span class="sr-only">비공개하기</span>
                                        </button>
                                        {:}
                                        <button data-toggle="tooltip" class="btn btn-warning btn-xs" type="button" title="공개하기" onclick="change_status(this, '{.id}', 1); return false;">
                                        <span class="icon-fixed-width icon-eye-open"></span> <span class="sr-only">공개하기</span>
                                        </button>
                                        {/}
                                        <button data-toggle="tooltip" class="btn btn-danger btn-xs" type="button" title="삭제" onclick="del_comp('{.id}'); return false;">
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
                                <li><a href="/member/edit_competition_m/{page - 1}">&laquo;</a></li>
                                {/}

                                {@paging.pages}
                                {?.type == "dot"}
                                <li class="disabled"><a href="#">...</a></li>
                                {:}
                                <li {?.type == "current"}class="active"{/}><a href="/member/edit_competition_m/{.page}">{.page}</a></li>
                                {/}
                                {/}

                                {?page == paging.tot_page}
                                <li class="disabled"><a href="#">&raquo;</a></li>
                                {:}
                                <li><a href="/member/edit_competition_m/{page + 1}" >&raquo;</a></li>
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

function del_comp(_id)
{
    del_confirm('del_comp2('+_id+')');
}

function del_comp2(_id)
{
    var get_url = '/ajax_front/del_competition/'+_id;
    $.get(get_url, function(){
        window.location.reload(true);
    });
}

function change_status(_this, _id, _type)
{
    var get_url = '/ajax_front/change_status_competition/'+_id+'/'+_type;
    $.get(get_url, function(){
        var st0 = '<button data-toggle="tooltip" class="btn btn-default btn-xs" type="button" title="비공개하기" onclick="change_status(this, '+_id+', 0); return false;"><span class="icon-fixed-width icon-eye-close"></span></button>';
        var st1 = '<button data-toggle="tooltip" class="btn btn-warning btn-xs" type="button" title="공개하기" onclick="change_status(this, '+_id+', 1); return false;"><span class="icon-fixed-width icon-eye-open"></span></button>';
        if (_type === 1) {
            $(_this).after(st0);
        }
        else {
            $(_this).after(st1);
        }
        $(_this).remove();
    });
}
//]]>
</script>