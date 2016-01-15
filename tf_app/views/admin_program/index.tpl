
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"><!-- section -->
                <section> 
                
                    <!-- panel -->
                    <div class="panel panel-default">
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-align-justify"></span><span class="break"></span>Benefits 목록</h2>
                            <div class="actions">
                                <span class="break"></span>
                                <a href="/admin_program/edit" data-toggle="tooltip" title="프로그램 추가"><span class="glyphicon  glyphicon-plus"></span></a> 
                            </div>
                        </div>
                        <!-- /panel-heading --> 
                        <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <!--<th class="td-check" width="20"><input type="checkbox"></th>-->
                                        <th class="td-date"><button class="btn btn-default dropdown-toggle" type="button">행사일{? order}{? order == "ASC"}<span class="icon-caret-up"></span>{:}<span class="icon-caret-down"></span>{/}{:}<span class="icon-caret-down"></span>{/}</button></th>
                                        <th class="td-name">개설자</th>
                                        <th class="td-type">종류</th>
                                        <th class="td-subject" >행사명</th>
                                        <th class="td-list" >신청자</th>
                                        <th class="td-date">개설일</th>
                                        <th class="td-status">
                                            <select class="selectpicker" data-width="auto" name="status" >
                                                <optgroup label="상태">
                                                    <option value="99" {? status == 99}selected="selected"{/}>전체</option>
                                                    <option value="0" {? status == 0}selected="selected"{/}>승인대기</option>
                                                    <option value="1" {? status == 1}selected="selected"{/}>승인</option>
                                                    <option value="2" {? status == 2}selected="selected"{/}>반려</option>
                                                </optgroup>
                                            </select>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {@ res}
                                    <tr>
                                        <!--<td class="td-check"><input type="checkbox" ></td>-->
                                        <td class="td-date">{? res.a_start}{res.a_start} ~ {res.a_end}{:}상시{/}</td>
                                        <td class="td-name">{.name}</td>
                                        <td class="td-type">{.category}</td>
                                        <td class="td-subject"><a href="/admin_program/edit/{.id}">{.title}</a></td>
                                        <td class="td-list">
                                            <button class="btn btn-default btn-xs"  onclick="location.href='/admin_program/applied_list/{.id}'">신청자 보기</button>
                                        </td>
                                        <td class="td-date">{=str_replace("-", ".", substr(.date_created, 0, 10))}</td>
                                        {? .status == 0}
                                        <td class="td-status"><button type="button" class="btn btn-default btn-xs" onclick="location.href='/admin_program/edit/{.id}'">승인대기</button></td>
                                        {/}
                                        {? .status == 1}
                                        <td class="td-status"><span class="label label-info" onclick="location.href='/admin_program/edit/{.id}'" style="cursor: pointer;">승인</span></td>
                                        {/}
                                        {? .status == 2}
                                        <td class="td-status"><span class="label label-warning" onclick="location.href='/admin_program/edit/{.id}'" style="cursor: pointer;">반려</span></td>
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
                                    <li><a href="/admin_program/{status}/{page - 1}?search={search}&order={order}">&laquo;</a></li>
                                    {/}

                                    {@paging.pages}
                                    {?.type == "dot"}
                                    <li class="disabled"><a href="#">...</a></li>
                                    {:}
                                    <li {?.type == "current"}class="active"{/}><a href="/admin_program/{status}/{.page}?search={search}&order={order}">{.page}</a></li>
                                    {/}
                                    {/}

                                    {?page == paging.tot_page}
                                    <li class="disabled"><a href="#">&raquo;</a></li>
                                    {:}
                                    <li><a href="/admin_program/{status}/{page + 1}?search={search}&order={order}" >&raquo;</a></li>
                                    {/}
                                </ul>
                                
                                <form role="search" class="search" action="/admin_program/99/1">
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
    $("select[name=status]").change(function() 
    { 
        var _val = $("select[name=status] option:selected").val();
        document.location.href = "/admin_program/"+_val+"/1?search={search}&order={order}";
    }); 

    $(".td-date button").click(function()
    {
        {? order == 'ASC'}
        document.location.href = "/admin_program/{status}/1?search={search}&order=DESC";
        {:}
        document.location.href = "/admin_program/{status}/1?search={search}&order=ASC";
        {/}
    });

}); 

//]]>
</script>