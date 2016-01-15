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
                <a href="/office_hours/m_list" class="btn btn-default btn-sm pull-right">
                    <span class="icon-fixed-width icon-large icon-list"></span> 전체 리스트보기
                </a>
            </div>
        </div>
        <!-- /page-header --> 
        
        <!-- page-content -->
        <div class="page-content"> 
            <!-- container -->
            <div class="container">

                <div class="well applied-item">
                    <div class="media">
                        <a href="/office_hours/views/{oh.id}" class="pull-left media-object">
                            <span style="background-image:url({oh.picture});">
                                <img class="img-responsive" src="/images/img_trans.png">
                            </span>
                        </a>
                        <div class="media-body">
                            <h4 class="media-heading">
                                <a href="/office_hours/views/{oh.id}">
                                    {oh.subject}
                                </a>
                            </h4>
                            <div class="item-status">
                                <dl class="dl-horizontal">
                                    <dt>주최&middot;주관</dt>
                                    <dd>{oh.hosted}</dd>
                                    <dt>참가 장소</dt>
                                    <dd>{oh.place}</dd>
                                    <dt>참가 일자 </dt>
                                    <dd>{=substr(oh.e_start, 0, 10)} ({=date_to_day_only(oh.e_start)}) {=substr(oh.e_start, 11)} ~ {=substr(oh.e_end, 0, 10)} ({=date_to_day_only(oh.e_end)}) {=substr(oh.e_end, 11)} / 팀당 1시간</dd>
                                    <dt>접수 기간</dt>
                                    <dd>{=substr(oh.a_start, 0, 10)} ({=date_to_day_only(oh.a_start)}) {=substr(oh.a_start, 11)} ~ {=substr(oh.a_end, 0, 10)} ({=date_to_day_only(oh.a_end)}) {=substr(oh.a_end, 11)} {? oh.a_start > date('Y.m.d H:i')}<span class="badge">D-{=dateDiff(oh.a_start, date('Y.m.d'), '.')}</span>{/}</dd>
                                    <dt>발표 일자</dt>
                                    <dd>{=substr(oh.r_date, 0, 10)} ({=date_to_day_only(oh.r_date)}) {=substr(oh.r_date, 11)} / 메일을 통해 개별 안내 {? oh.r_date > date('Y.m.d H:i')}<span class="badge">D-{=dateDiff(oh.r_date, date('Y.m.d'), '.')}</span>{/}</dd>
                                </dl> 
                            </div>
                        </div>
                    </div>
                    <div class="inspect-fixed pull-right">
                        <button class="btn btn-primary btn-sm" onclick="fix_status(this, {oh.id}); return false;" {? oh.status}disabled="disabled"{/}>선정 내용 확정하기</button>
                    </div>
                </div>
                <!-- /applied-item -->

                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th width="60" class="td-num">번호</th>
                            <th class="td-name">이름</th>
                            <th class="td-company">회사/팀</th>
                            <th class="td-service">제품/서비스명</th>
                            <th class="td-phone">휴대폰번호</th>
                            <th class="td-email">이메일주소</th>
                            <th class="td-cnt">신청이력 <small>(선정이력/접수이력)</small></th>
                            <th class="td-status">선정여부</th>
                            <th class="td-view">신청내용</th>
                        </tr>
                    </thead>
                    <tbody>
                        {@ res}
                        <tr>
                            <td class="td-num">{= res_cnt - (pagesize*(page-1) + .key_)}</td>
                            <td class="td-name">{.name}</td>
                            <td class="td-company">{.team}</td>
                            <td class="td-service">{.s_subject}</td>
                            <td class="td-phone">{.tel}</td>
                            <td class="td-email">{.email}</td>
                            <td class="td-cnt"><a class="btn btn-default btn-xs"  onclick="get_record('{oh.mento_id}', '{.user_id}'); return false;">{.suc}/{.tot}</a></td>
                            <td class="td-status">
                                {? .status == 0}<span class="label label-primary">심사중</span>{/}
                                {? .status == 1}<span class="label label-success">선정</span>{/}
                                {? .status == 2}<span class="label label-default">미선정</span>{/}
                                {? .suc_t} <small>{=date_to_kr(oh.e_start)} {.suc_t.start}</small>{? .confirm}[확정]{/}{/}
                            </td>
                            <td class="td-view"><a href="/office_hours/m_apply/{.id}" class="btn btn-default btn-xs">내용보기</a></td>
                        </tr>
                        {/}
                    </tbody>
                </table>
                <div class="paging  text-center">
                    <ul class="pagination">
                        {?page == 1}
                        <li class="disabled"><a href="#">&laquo;</a></li>
                        {:}
                        <li><a href="/office_hours/m_apply_list/{oh.id}/{page - 1}">&laquo;</a></li>
                        {/}

                        {@paging.pages}
                        {?.type == "dot"}
                        <li class="disabled"><a href="#">...</a></li>
                        {:}
                        <li {?.type == "current"}class="active"{/}><a href="/office_hours/m_apply_list/{oh.id}/{.page}">{.page}</a></li>
                        {/}
                        {/}

                        {?page == paging.tot_page}
                        <li class="disabled"><a href="#">&raquo;</a></li>
                        {:}
                        <li><a href="/office_hours/m_apply_list/{oh.id}/{page + 1}" >&raquo;</a></li>
                        {/}
                    </ul>
                </div>

            </div>
            <!-- /container --> 
        </div>
        <!-- /page-content --> 
    </div>
    <!-- /rowContent -->

    <div id="md-recordHours" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="z-index: 1050;"></div>