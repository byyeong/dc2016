
            <div class="col-xs-12 col-sm-12 col-md-9 content">
                <div class="content-header">                    
                    <button class="btn btn-primary btn-sm pull-right" onclick="javascript:document.location.href='/challenge/edit'"><span class="icon-fixed-width icon-large icon-edit"></span> 경진대회 개최하기</button>
                    
                    <h3  class="content-heading"> <span class="icon-trophy"></span> Challenge 관리 </h3>                    
                    
                    <ul class="nav nav-tabs">
                        {? make} 
                        <li><a href="/member/edit_challenge_m"><span class="icon-fixed-width icon-pencil"></span> 개최한 경진대회</a>
                        </li>
                        {/}
                        {? op} 
                        <li><a href="/member/edit_challenge_op"><span class="icon-fixed-width icon-check"></span> 운영진 위촉 경진대회</a>
                        </li>
                        {/}
                        {? examine || st} 
                        <li class="active"><a href="/member/edit_challenge_ex"><span class="icon-fixed-width  icon-check "></span> 심사위원 위촉 경진대회</a>
                        </li>
                        {/}
                        <li><a href="/member/edit_challenge"><span class="icon-fixed-width  icon-edit "></span> 참가한 경진대회</a>
                        </li> 
                    </ul>
                </div>
                <div class="tab-content">
                    <div class="tab-pane active" id="examined">
                        <h4 class="sr-only"> 심사참여한 경진대회</h4>
                        {? examine}
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th class="td-num" width="60">번호</th>
                                        <th class="td-status" width="80">진행상태</th>
                                        <th class="td-subject">경진대회명</th>
                                        <th class="td-applier" width="80">참가자</th>
                                        <th class="td-examin" width="110">심사현황</th>
                                    </tr>
                                </thead>
                                <tbody>
                                
                                {@ examine}
                                <tr>
                                    <td class="td-num">{= res_cnt - (pagesize*(page-1) + .key_)}</td>
                                    <td class="td-status"> {? date('Y.m.dH:i') < .sdate}<span class="label label-info">접수준비</span>{/}
                                        {? date('Y.m.dH:i') > .sdate && date('Y.m.dH:i') < .edate}<span class="label label-primary">접수중</span>{/}
                                        {? date('Y.m.dH:i') > .announce && .winner}<span class="label label-default">수상자발표</span> {:}{? date('Y.m.dH:i') > .edate}<span class="label label-warning">접수마감</span>{/}{/} </td>
                                    <td class="td-subject"><a href="/challenge/views/{.id}">{.subject}{?.department} - {.department}{/}</a></td>
                                    <td class="td-applier"> <a href="/challenge/applied_list/{.id}"><span class="badge badge-primary">{.apply_cnt} <i class="icon-caret-right"></i></span></a> </td>
                                    <td class="td-applier"> {.examine_cnt}/{.apply_cnt} </td>
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
                                <li><a href="/member/edit_challenge_ex/{page - 1}">&laquo;</a></li>
                                {/}

                                {@paging.pages}
                                {?.type == "dot"}
                                <li class="disabled"><a href="#">...</a></li>
                                {:}
                                <li {?.type == "current"}class="active"{/}><a href="/member/edit_challenge_ex/{.page}">{.page}</a></li>
                                {/}
                                {/}

                                {?page == paging.tot_page}
                                <li class="disabled"><a href="#">&raquo;</a></li>
                                {:}
                                <li><a href="/member/edit_challenge_ex/{page + 1}" >&raquo;</a></li>
                                {/}
                            </ul>
                        </div>
                        <!-- /paging -->

                        {:}
                        <div class="alert alert-info">
                            <p><strong>Oops!</strong> 심사위원 위촉 내역이 없습니다. </p>
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