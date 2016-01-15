
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                
                <!-- section -->
                <section> 
                    
                    <!-- panel -->
                    <div class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-align-justify"></span><span class="break"></span> 공간공유 신청 목록</h2>
                            <div class="actions"> <span class="break"></span> <a title="" data-toggle="tooltip" class="btn-add" href="/admin_space/reserve" data-original-title="공간공유 추가"><span class="glyphicon  glyphicon-plus"></span></a> </div>
                        </div>
                        <!-- /panel-heading -->
                        
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <!--<th class="td-check" width="20"><input type="checkbox"></th>-->
                                    <th class="td-status" width="140" >
                                        <select class="selectpicker" data-width="auto" name="type">
                                            <optgroup label="공간구분">
                                                <option value="99" {? !type}selected="selected"{/}>전체</option>
                                                <option value="1" {? type == 1}selected="selected"{/}>D.CAMP 회의실</option>
                                                <option value="2" {? type == 2}selected="selected"{/}>외부 행사 대관</option>
                                            </optgroup>
                                        </select>
                                    </th>
                                    <th class="td-time" width="140">
                                        <button class="btn btn-default dropdown-toggle" type="button">모임 일자 및 시간{? order_t}{? order_e == "ASC"}<span class="icon-caret-up"></span>{:}<span class="icon-caret-down"></span>{/}{:}<span class="icon-caret-down"></span>{/}</button>
                                    </th>
                                    <!--th class="td-kind" width="100" >분류</th-->
                                    <th class="td-floor" width="100">장소</th>
                                    <th class="td-purpose">목적</th>
                                    <th class="td-name" width="80">신청자</th> 
                                    <!--th class="td-grade" width="80">
                                        <select class="selectpicker" data-width="auto" name="membership" >
                                            <optgroup label="등급">
                                                <option value="99" {? sort == 'membership' && order == 99}selected="selected"{/}>전체</option>
                                                <option value="0" {? sort == 'membership' && order == 0}selected="selected"{/}>일반</option>
                                                <option value="1" {? sort == 'membership' && order == 1}selected="selected"{/}>멤버십</option>
                                            </optgroup>
                                        </select>
                                    </th-->                                    
                                    <th class="td-date" width="80">신청일자</th>
                                    <th class="td-status" width="60" >
                                        <select class="selectpicker" data-width="auto" name="state" >
                                            <optgroup label="상태">
                                                <option value="99" {? sort == 'state' && order == 99}selected="selected"{/}>전체</option>
                                                <option value="0" {? sort == 'state' && order == 0}selected="selected"{/}>승인대기</option>
                                                <option value="1" {? sort == 'state' && order == 1}selected="selected"{/}>승인</option>
                                                <option value="2" {? sort == 'state' && order == 2}selected="selected"{/}>반려</option>
                                            </optgroup>
                                        </select>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                {@ res}
                                <tr>
                                    <!--<td class="td-check"><input type="checkbox" ></td>-->
                                    <td class="td-type">{?.stype == 1}D.CAMP 회의실{/}{?.stype == 2}외부 행사 대관 {/}</a></td>
                                    <td class="td-time">{.date} {.start} ~ {.end}</td>
                                    <!--th class="td-kind">회의실/대관</th-->
                                    <td class="td-floor">{.opt}F {.name}</a></td>
                                    <td class="td-purpose"><a href="/admin_space/reserve/{.id}">{.purpose}</a></td>
                                    <td class="td-name">{.ids}</td>
                                    <!--td class="td-grade">{? .membership == 1}멤버십{:}일반{/}</td-->
                                    <td class="td-date">{=str_replace("-", ".", substr(.date_created, 0, 10))}</td>
                                    {? .state == 0}
                                    <td class="td-status" style="cursor: pointer"><button type="button" class="btn btn-default btn-xs" onclick="location.href='/admin_space/approve/{.id}'">승인대기</button></td>
                                    {/}
                                    {? .state == 2}
                                    <td class="td-status" style="cursor: pointer"><span class="label label-warning" onclick="location.href='/admin_space/approve/{.id}'">반려</span></td>
                                    {/}
                                    {? .state == 9}
                                    <td class="td-status" style="cursor: pointer"><span class="label label-warning" onclick="location.href='/admin_space/approve/{.id}'">취소</span></td>
                                    {/}
                                    {? .state == 1}
                                    <td class="td-status" style="cursor: pointer"><span class="label label-info" onclick="location.href='/admin_space/approve/{.id}'">승인</span></td>
                                        {? .state == 3}
                                    <td class="td-status"><span class="label label-success">이용중</span></td>
                                        {/}
                                        {? .state == 4}
                                    <td class="td-status"><span class="label label-default">이용완료</span></td>
                                        {/}
                                    {/}
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
                                    <li><a href="/admin_space/{page - 1}?type={type}&sort={sort}&order={order}&order_t={order_t}&order_e={order_e}">&laquo;</a></li>
                                    {/}

                                    {@paging.pages}
                                    {?.type == "dot"}
                                    <li class="disabled"><a href="#">...</a></li>
                                    {:}
                                    <li {?.type == "current"}class="active"{/}><a href="/admin_space/{.page}?type={type}&sort={sort}&order={order}&order_t={order_t}&order_e={order_e}">{.page}</a></li>
                                    {/}
                                    {/}

                                    {?page == paging.tot_page}
                                    <li class="disabled"><a href="#">&raquo;</a></li>
                                    {:}
                                    <li><a href="/admin_space/{page + 1}?type={type}&sort={sort}&order={order}&order_t={order_t}&order_e={order_e}" >&raquo;</a></li>
                                    {/}
                                </ul>
                            </div>
                        </div>
                        <!-- /panel-footer --> 
                    </div>
                    <!-- /panel --> 
                    
                </section>
                <!-- /section --> 
                
            </div>
            <!-- /contentwrap --> 

<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}
    
$(document).ready(function(){ 
    $("select[name=type]").change(function() 
    { 
        var _val = $("select[name=type] option:selected").val();
        document.location.href = "/admin_space?type="+_val+"&sort={sort}&order={order}";
    }); 

    $("select[name=membership]").change(function() 
    { 
        var _val = $("select[name=membership] option:selected").val();
        document.location.href = "/admin_space?type={type}&sort=membership&order="+_val;
    }); 

    $("select[name=state]").change(function() 
    { 
        var _val = $("select[name=state] option:selected").val();
        document.location.href = "/admin_space?type={type}&sort=state&order="+_val;
    }); 

    $(".td-time button").click(function()
    {
        {? order_e == 'ASC'}document.location.href = "/admin_space?type={type}&sort={sort}&order={order}&order_t=order_t&order_e=DESC";
        {:}document.location.href = "/admin_space?type={type}&sort={sort}&order={order}&order_t=order_t&order_e=ASC";{/}
    });
}); 

//]]>
</script>