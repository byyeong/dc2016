
                <div class="content col-xs-12 col-sm-12 col-md-9">
                    <div class="content-header">                       
                         <h3 class="content-heading"> <span class="icon-map-marker"></span> 공간공유 예약 내역 </h3>
                    </div>
                    {? res} 
                    <div class="table-responsive">
                        <table class="table table-hover table-striped">
                            <thead>
                                <tr>
                                    <th width="60" class="td-num">번호</th>
                                    <th width="120" class="td-date">신청일자</th>
                                    <th width="120" class="td-space">공간</th>
                                    <th width="120" class="td-space">장소</th>
                                    <th class="td-subject">행사명</th>
                                    <th width="80" class="td-name">신청자</th>
                                    <th width="60" class="td-status">상태</th>
                                </tr>
                            </thead>
                            <tbody>
                            
                            {@ res}
                            <tr id="s_l_{.id}">
                                <td class="td-num">{= res_cnt - (pagesize*(page-1) + .key_)}</td>
                                <td class="td-date">{.date} {.start} ~ {.end}</td>
                                <td class="td-space">
                                    {?.stype == 1}D.CAMP 회의실{/}
                                    {?.stype == 2}외부 행사 대관{/}
                                    {?.stype == 3}디자인 라운지{/}
                                </td>
                                <td class="td-space"> {.name} {.opt}F</td>
                                <td class="td-subject"><a href="/space/apply/{.id}" > {.purpose} </a>{? .rel_url}<p class="move_e"><a class="btn btn-default btn-xs" href="{.rel_url}"><span class="icon-share"></span> 이벤트보기 </a></p>{/}</td>
                                <td class="td-name">{.mname}({.ids})</td>
                                <td class="td-status">
                                    <a href="/member/edit_rsv_apr/{.id}"> 
                                        {? .state == 0}<span class="label label-info">승인대기</span>{/}
                                        {? .state == 1}<span class="label label-success">승인</span>{/}
                                        {? .state == 2}<span class="label label-warning" data-placement="top" data-toggle="popover" data-content="{.state_des}">반려</span>{/} 
                                    </a>
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
                            <li><a href="/member/edit_rsv1/{page - 1}">&laquo;</a></li>
                            {/}

                            {@paging.pages}
                            {?.type == "dot"}
                            <li class="disabled"><a href="#">...</a></li>
                            {:}
                            <li {?.type == "current"}class="active"{/}><a href="/member/edit_rsv1/{.page}">{.page}</a></li>
                            {/}
                            {/}

                            {?page == paging.tot_page}
                            <li class="disabled"><a href="#">&raquo;</a></li>
                            {:}
                            <li><a href="/member/edit_rsv1/{page + 1}" >&raquo;</a></li>
                            {/}
                        </ul>
                    </div>
                    <!-- /paging -->

                    {:}
                    <div class="alert alert-info">
                        <p><strong>Oops!</strong> 신청한 내역이 없습니다. </p>
                    </div>
                    {/} 

                </div>
                <!-- /content -->

<div id="md-linkEvent" class="modal fade">
</div>
<!-- modal -->

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

function submit_space_c(_id) {
    alert("취소되었습니다.");
    
    location.href='/space/reserve/?cancel='+_id;
}

function get_event_space_link(_id)
{
    var get_url = '/ajax_front/get_event_link/'+_id;
    $.get(get_url, function(_data) {
        $('#md-linkEvent').html(_data);
    });
}

function submit_sel(_id) {
    var get_url = '/ajax_front/get_event_link/{res.id}';
    var frm = $('form[name=e_s_l_form]');
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {
            if ($('input[name=rel_url]').val().length > 0) {
                $('#s_l_'+_id).find(".td-subject .move_e").remove();
                var _u = '<p class="move_e"><a class="btn btn-default btn-xs" href="'+$('input[name=rel_url]').val()+'"><span class="icon-share"></span> 이벤트보기 </a></p>';
                $('#s_l_'+_id).find(".td-subject").append(_u);
            }
            $('.modal').modal('hide');

        }
    });
}
//]]>
</script>