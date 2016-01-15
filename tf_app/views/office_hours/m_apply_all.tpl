    <!-- rowContent -->
    <div class="rowContent"  id="officehours"> 
        
        <!-- page-header -->
        <div class="page-header">
            <div class="container">
                <h2><a href="/office_hours/m_list">Office Hours</a></h2>
                
                <a href="/office_hours/m_info" class="btn btn-default btn-sm pull-right">
                    <span class="fa fa-fw fa-user"></span> 멘토정보 수정하기 
                </a>
                <a href="/office_hours/m_apply_all" class="btn btn-primary btn-sm pull-right">
                    <span class="fa fa-fw fa-check-square"></span> 신청자 모두보기 
                </a>
                <a href="/office_hours/m_add" class="btn btn-default btn-sm pull-right">
                    <span class="fa fa-fw fa-edit"></span> Office Hours 추가하기
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

                  <div class="table-responsive">
                    <table class="table table-hover table-striped">
                        <thead>
                            <tr>
                                <th width="50" class="td-num">번호</th> 
                                <th class="td-name">이름</th>
                                <th class="td-company">회사/팀</th>
                                <th class="td-subject">제품/서비스명</th>
                                <th class="td-phone">휴대폰번호</th>
                                <th class="td-email">이메일 주소</th>
                                <th class="td-cnt">신청이력<small>(선정/접수)</small></th>
                            </tr>
                        </thead>
                        <tbody>
                            {@ res}
                            <tr>
                                <td class="td-num">{= res_cnt - (pagesize*(page-1) + .key_)}</td> 
                                <td class="td-name"><a href="/member/{.url.ids}">{.i.name}</a></td>
                                <td class="td-company"><a href="{.i.profile_url}">{.i.team}</a></td>
                                <td class="td-subject">{.i.s_subject} </td>
                                <td class="td-phone">{.i.tel}</td>
                                <td class="td-email"><a href="mailto:{.i.email}">{.i.email}</a></td>
                                <td class="td-cnt"><a class="btn btn-default btn-xs"  onclick="get_record('{.mento_id}', '{.i.user_id}'); return false;">{.suc}/{.tot}</a></td>
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
                        <li><a href="/office_hours/m_apply_all/{page - 1}">&laquo;</a></li>
                        {/}

                        {@paging.pages}
                        {?.type == "dot"}
                        <li class="disabled"><a href="#">...</a></li>
                        {:}
                        <li {?.type == "current"}class="active"{/}><a href="/office_hours/m_apply_all/{.page}">{.page}</a></li>
                        {/}
                        {/}

                        {?page == paging.tot_page}
                        <li class="disabled"><a href="#">&raquo;</a></li>
                        {:}
                        <li><a href="/office_hours/m_apply_all/{page + 1}" >&raquo;</a></li>
                        {/}
                    </ul>
                </div>
                <!-- /paging --> 

            </div>
            <!-- /container --> 
        </div>
        <!-- /page-content --> 
    </div>
    <!-- /rowContent -->

<div id="md-recordHours" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="z-index: 1050;"></div>
