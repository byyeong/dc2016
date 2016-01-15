
<div class="content col-xs-12 col-sm-12 col-md-9">
    <div class="content-header">
        <h3 class="content-heading"> <i class="fa fa-clock-o"></i> Recruit 목록</h3>
    </div>

    {? res}
    <div class="table-responsive">
        <table class="table table-hover table-striped">
            <thead>
            <tr>
                <th width="50" class="td-num">번호</th>
                <th width="90" class="td-subject">회사명 </th>
                <th class="td-subject">제목</th>
                <th width="140" class="td-date">공고 기간</th>
                <th width="80" class="td-status">승인 여부</th>
            </tr>
            </thead>
            <tbody>
            {@ res}
            <tr>
                <td class="td-num">{= res_cnt - (pagesize*(page-1) + .key_) }</td>
                <td class="td-subject"><a href="/recruit/add/{.id}">{.sname}</a></td>
                <td class="td-subject"><a href="/recruit/add/{.id}">{.title}</a></td>
                <td class="td-date">{.start}~{.end}</td>
                <td class="td-status">
                    {? .state == 0}
                    <span class="label label-default">승인 대기</span>
                    {/}
                    {? .state == 1}
                    <span class="label label-success">승인</span>
                    {/}
                    {? .state == 2}
                    <span class="label label-default">반려</span>
                    {/}
                    {? .state == 9}
                    <span class="label label-warning">비공개</span>
                    {/}

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
            <li><a href="/member/recruit/{page - 1}">&laquo;</a></li>
            {/}

            {@paging.pages}
            {?.type == "dot"}
            <li class="disabled"><a href="#">...</a></li>
            {:}
            <li {?.type == "current"}class="active"{/}><a href="/member/recruit/{.page}">{.page}</a></li>
            {/}
            {/}

            {?page == paging.tot_page}
            <li class="disabled"><a href="#">&raquo;</a></li>
            {:}
            <li><a href="/member/recruit/{page + 1}" >&raquo;</a></li>
            {/}
        </ul>
    </div>
    <!-- /paging -->
    {:}
    <div class="alert alert-info">
        <p><strong>Oops!</strong> 신청한 내역이 없습니다. Recruit를 신청해주세요.</p>
    </div>
    {/}

</div>
<!-- /content -->