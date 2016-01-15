    <!-- rowContent -->
    <div class="rowContent"  id="userProfile"> 
        
        <!-- page-header -->
        <div class="page-header">
            <div class="container">
                <h2><a href="/office_hours/m_list">Office Hours</a></h2>

                <a href="/office_hours/m_info" class="btn btn-default btn-sm pull-right">
                    <span class="icon-fixed-width icon-large icon-user"></span> 멘토정보 수정하기 
                </a>
                <a href="/office_hours/m_apply_all" class="btn btn-default btn-sm pull-right">
                    <span class="fa fa-fw fa-check-square"></span> 신청자 모두보기 
                </a>
                <a href="/office_hours/m_add" class="btn btn-default btn-sm pull-right">
                    <span class="icon-fixed-width icon-large icon-edit"></span> Office Hours 추가하기
                </a>
                <a href="/office_hours/m_list" class="btn btn-primary btn-sm pull-right">
                    <span class="icon-fixed-width icon-large icon-list"></span> 전체 리스트보기
                </a>
            </div>
        </div>
        <!-- /page-header --> 
        
        <!-- page-content -->
        <div class="page-content"> 
            <!-- container -->
            <div class="container">

                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th width="50" class="td-num">번호</th> 
                            <th class="td-subject">제목 </th>
                            <th width="70" class="td-date">행사날짜</th>
                            <th width="160" class="td-date">접수기간</th>
                            <th width="70" class="td-date">발표일</th>
                            <th width="70" class="td-info">정보</th>
                            <th width="155" class="td-status">진행상태</th>
                            <th width="80" class="td-cnt">접수목록</th>
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
                            <td class="td-info"><a href="/office_hours/m_add/{.id}" class="btn btn-default btn-xs">정보수정</a></td>
                            <td class="td-status">
                                {? .is_open}
                                <span class="label label-success">공개</span>
                                {:}
                                <span class="label label-default">비공개</span>
                                {/}
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
                            </td>
                            <td class="td-cnt"><a href="/office_hours/m_apply_list/{.id}" class="btn btn-default btn-xs">{.app}/{.tot}</a></td>
                        </tr>
                        {/}
                    </tbody>
                </table>

            </div>
            <!-- /container --> 

            <div class="paging text-center">
                <ul style=" margin: 0;" class="pagination">
                    {?page == 1}
                    <li class="disabled"><a href="#">&laquo;</a></li>
                    {:}
                    <li><a href="/office_hours/m_list/{page - 1}">&laquo;</a></li>
                    {/}

                    {@paging.pages}
                    {?.type == "dot"}
                    <li class="disabled"><a href="#">...</a></li>
                    {:}
                    <li {?.type == "current"}class="active"{/}><a href="/office_hours/m_list/{.page}">{.page}</a></li>
                    {/}
                    {/}

                    {?page == paging.tot_page}
                    <li class="disabled"><a href="#">&raquo;</a></li>
                    {:}
                    <li><a href="/office_hours/m_list/{page + 1}" >&raquo;</a></li>
                    {/}
                </ul>
            </div>
            <!-- /paging --> 
            
        </div>
        <!-- /page-content --> 
    </div>
    <!-- /rowContent -->