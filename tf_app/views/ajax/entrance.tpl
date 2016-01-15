
                    <!-- panel-heading -->
                    <div class="panel-heading">
                        <h2><span class="icon-align-justify"></span><span class="break"></span>현재 입퇴실 현황</h2>
                    </div>
                    <!-- /panel-heading -->

                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th class="td-mem">멤버십여부</th>
                                <th class="td-name">이름</th>
                                <th class="td-name">성별</th>
                                <th class="td-name">생년월일</th>
                                <th class="td-phone">휴대폰번호</th>
                                <th class="td-loker">사물함</th>
                                <th class="td-pass">출입증</th>
                                <th class="td-checkin">입실시간</th>
                                <th class="td-checkin">입실</th>
                                <th class="td-checkout">퇴실</th>
                            </tr>
                        </thead>
                        <tbody>
                            {@ res_curr}
                            <tr>
                                <td class="td-mem">{? .membership == 1}<span class="icon-ok text-primary"></span>{:}<span class="icon-minus text-danger"></span>{/}</td>
                                <td class="td-name"><a data-target="#md-entranceInfo" data-toggle="modal" href="#" onclick="get_entranc_info('{.id}'); return false;">{.name}</a>{? .admin_des}  <span class="icon-warning-sign text-warning"></span>{/}</td>
                                <td class="td-phone">{?.gender == 1}남{/}{?.gender == 2}여{/}</td>
                                <td class="td-phone">{.birth}</td>
                                <td class="td-phone">{.tel}</td>
                                <td class="td-loker">{? .locker}{.locker}{:}-{/}</td>
                                <td class="td-pass">{? .pass}{.pass}{:}-{/}</td>
                                <td class="td-checkin">{.date_in}</td>
                                <td class="td-checkin"><span class="icon-ok text-primary"></span></td>
                                <td class="td-checkout">{? .date_out}<span class="icon-ok text-primary"></span>{:}<span class="icon-minus text-danger"></span>{/}</td>
                            </tr>
                            {/}
                        </tbody>
                    </table>
                    {? res_curr}    
                    <!-- panel-footer -->
                    <div class="panel-footer">
                        <div class="paging">
                            <ul class="pagination">
                                {?page == 1}
                                <li class="disabled"><a href="#">&laquo;</a></li>
                                {:}
                                <li><a href="#" onclick="get_entrance('{page - 1}'); return false;">&laquo;</a></li>
                                {/}

                                {@paging.pages}
                                {?.type == "dot"}
                                <li class="disabled"><a href="#">...</a></li>
                                {:}
                                <li {?.type == "current"}class="active"{/}><a href="#" onclick="get_entrance('{.page}'); return false;">{.page}</a></li>
                                {/}
                                {/}

                                {?page >= paging.tot_page}
                                <li class="disabled"><a href="#">&raquo;</a></li>
                                {:}
                                <li><a href="#" onclick="get_entrance('{page + 1}'); return false;">&raquo;</a></li>
                                {/}
                            </ul>
                        </div>
                    </div>
                    <!-- /panel-footer --> 
                    {/}
                    
<!-- modal -->
<div class="modal fade" id="md-entranceInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div>
<!-- /modal --> 

<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}

function get_entranc_info(_id) {
    var get_url = "/ajax/entrance_user/"+_id;
    
    $.get(get_url, function(_data) {
        $("#md-entranceInfo").html(_data);
    });
}

//]]>
</script>