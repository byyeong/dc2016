                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th class="td-name">회원명</th>
                                            <th class="td-email">이메일</th>
                                            <th class="td-date">멤버십 승인 일자</th>
                                            <th class="td-num">사물함 번호</th>
                                            <th class="td-date">총 방문 횟수</th>
                                            <th class="td-date">이번 달 방분횟수</th>
                                            <th class="td-status">관리</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {@res}
                                        <tr>
                                            <td class="td-name"><a href="/admin_member/add/{.mid}"><img src="{.picture}"> {.name}</a></td>
                                            <td class="td-email">{.email}</td>
                                            <td class="td-date">{? .membership == 1}{.mbs_date}{/}</td>
                                            <td class="td-num">{.locker_id}</td>
                                            <td class="td-email">{.cnt_a}</td>
                                            <td class="td-email">{.cnt}</td>
                                            <th class="td-status"><a data-target="#md-lockerInfo" data-toggle="modal" class="btn btn-default btn-xs" href="#" onclick="get_info('{.date}', '{.user_id}'); return false;">수정하기</a></th>
                                        </tr>
                                        {/}
                                    </tbody>
                                </table>
                                
                                <!-- panel-footer -->
                                <div class="panel-footer">
                                    <div class="paging">
                                        <ul class="pagination">
                                            {?page == 1}
                                            <li class="disabled"><a href="#">&laquo;</a></li>
                                            {:}
                                            <li><a href="#" onclick="get_already({page - 1}, '{date}'); return false;">&laquo;</a></li>
                                            {/}

                                            {@paging.pages}
                                            {?.type == "dot"}
                                            <li class="disabled"><a href="#">...</a></li>
                                            {:}
                                            <li {?.type == "current"}class="active"{/}><a href="#" onclick="get_already({.page}, '{date}'); return false;">{.page}</a></li>
                                            {/}
                                            {/}

                                            {?page >= paging.tot_page}
                                            <li class="disabled"><a href="#">&raquo;</a></li>
                                            {:}
                                            <li><a href="#" onclick="get_already({page + 1}, '{date}'); return false;">&raquo;</a></li>
                                            {/}
                                        </ul>
                                    </div>
                                </div>
                                <!-- /panel-footer -->
                                
<!-- modal -->
<div class="modal fade" id="md-lockerInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div>
<!-- /modal --> 

<script type="text/javascript">
//<![CDAT
function get_info(_date, _user)
{
    var get_url = "/ajax/get_locker_info/"+_date+"/"+_user;

    $.get(get_url, function(_data) {
        $("#md-lockerInfo").html(_data);
    });
}
//]]>
</script>   