
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"><!-- section -->
                <section> 
                
                    <!-- panel -->
                    <div class="panel panel-default">
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-align-justify"></span><span class="break"></span>이벤트 목록</h2>
                            <div class="actions">
                                <span class="break"></span>
                                <a href="/admin_event/add" data-toggle="tooltip" title="이벤트 추가"><span class="glyphicon  glyphicon-plus"></span></a> 
                            </div>
                        </div>
                        <!-- /panel-heading --> 
                        <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <!--<th class="td-check" width="20"><input type="checkbox"></th>-->
                                        <th class="td-date"><button class="btn btn-default dropdown-toggle" type="button">행사일{? order_t}{? order_e == "ASC"}<span class="icon-caret-up"></span>{:}<span class="icon-caret-down"></span>{/}{:}<span class="icon-caret-down"></span>{/}</button></th>
                                        <th class="td-name">개설자</th>
                                        <th class="td-floor">장소</th>
                                        <th class="td-type">종류</th>
                                        <th class="td-subject" >행사명</th>
                                        <th class="td-list" >신청자</th>
                                        <th class="td-date">개설일</th>
                                        <th class="td-status">
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
                                        <td class="td-date">{=str_replace("-", ".", .date)} {.start} ~ {=str_replace("-", ".", .date_e)} {.end}</td>
                                        <td class="td-name">{? .user_name}{.user_name}{:}{.mname}{/}</td>
                                        <td class="td-floor">{? .space_id == 0}{.space_etc}{:}{.opt}F {.sname}{/}</td>
                                        <td class="td-type">{.ename}</td>
                                        <td class="td-subject"><a href="/admin_event/add/{.id}">{.title}</a></td>
                                        <td class="td-list">
                                            
                                            {? .state_expand == "before"}
                                            <button class="btn btn-info btn-xs"  onclick="location.href='/admin_event/info/{.id}'">신청자 보기</button>
                                            {:}
                                            <button class="btn btn-default btn-xs"  onclick="location.href='/admin_event/info/{.id}'">신청자 보기</button>
                                            {/}
                                        </td>
                                        <td class="td-date">{=str_replace("-", ".", substr(.date_created, 0, 10))}</td>
                                        {? .state == 0}
                                        <td class="td-status"><button type="button" class="btn btn-default btn-xs" onclick="location.href='/admin_event/approve/{.id}'">승인대기</button></td>
                                        {/}

                                        {? .state == 1}
                                        <td class="td-status"><span class="label label-info" onclick="location.href='/admin_event/approve/{.id}'" style="cursor: pointer;">승인</span></td>
                                        {/}
                                        
                                        <!--
                                        {? .state == 1}
                                        {? .state_expand == "before"}
                                        <td class="td-status"><span class="label label-info" onclick="location.href='/admin_event/approve/{.id}'">승인</span></td>
                                        {/}
                                        {? .state_expand == "ing"}
                                        <td class="td-status"><span class="label label-success" >이용중</span></td>
                                        {/}
                                        {? .state_expand == "end"}
                                        <td class="td-status"><span class="label label-default" >이용완료</span></td>
                                        {/}
                                        {/}
                                        -->
                                        {? .state == 2}
                                        <td class="td-status"><span class="label label-warning" onclick="location.href='/admin_event/approve/{.id}'">반려</span></td>
                                        {/}
                                        
                                        {? .state == 9}
                                        <td class="td-status"><span class="label label-warning" onclick="location.href='/admin_event/approve/{.id}'">취소</span></td>
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
                                    <li><a href="/admin_event/{page - 1}?search={search}&sort={sort}&order={order}&order_t={order_t}&order_e={order_e}">&laquo;</a></li>
                                    {/}

                                    {@paging.pages}
                                    {?.type == "dot"}
                                    <li class="disabled"><a href="#">...</a></li>
                                    {:}
                                    <li {?.type == "current"}class="active"{/}><a href="/admin_event/{.page}?search={search}&sort={sort}&order={order}&order_t={order_t}&order_e={order_e}">{.page}</a></li>
                                    {/}
                                    {/}

                                    {?page == paging.tot_page}
                                    <li class="disabled"><a href="#">&raquo;</a></li>
                                    {:}
                                    <li><a href="/admin_event/{page + 1}?search={search}&sort={sort}&order={order}&order_t={order_t}&order_e={order_e}" >&raquo;</a></li>
                                    {/}
                                </ul>
                                <form role="search" class="search" action="/admin_event">
                                <div class="input-group">
                                    <input type="text" class="form-control" name="search" value="{search}">
                                    <span class="input-group-btn">
                                    <button class="btn btn-default" type="submit" data-toggle="tooltip" title="검색"><span class="icon-search"></span></button>
                                    </span> 
                                </div>
                            </form>
                            </div>
                            
                            
                        </div>
                        <!-- /panel-footer --> 
                    </div>
                    <!-- /panel --> 
                
                
                </section>
                <!-- /section --></div>
            <!-- /contentwrap --> 
<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}
    
$(document).ready(function(){ 
    $("select[name=state]").change(function() 
    { 
        var _val = $("select[name=state] option:selected").val();
        document.location.href = "/admin_event?search={search}&order_t={order_t}&order_e={order_e}&sort=state&order="+_val;
    }); 

    $(".td-date button").click(function()
    {
        {? order_e == 'ASC'}document.location.href = "/admin_event?search={search}&type={type}&sort={sort}&order={order}&order_t=order_t&order_e=DESC";
        {:}document.location.href = "/admin_event?search={search}&type={type}&sort={sort}&order={order}&order_t=order_t&order_e=ASC";{/}
    });

}); 

//]]>
</script>