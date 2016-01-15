            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-align-justify"></span><span class="break"></span>Showcase 목록</h2>
                        </div>
                        
                        
                        <!-- /panel-heading -->
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th class="td-num" width="60">번호</th>
                                    <th class="td-name">회사명</th>
                                    <th class="td-subject">제품/서비스명</th>
                                    <th class="td-desc">한 줄 설명</th>
                                    <th class="td-name">작성자</th>
                                    <th class="td-founded {? sort == 'founded'}active{/}">
                                        <button type="button" class="btn btn-default dropdown-toggle">런칭일자{? order}{? order == "ASC"}<span class="icon-caret-up"></span>{:}<span class="icon-caret-down"></span>{/}{:}<span class="icon-caret-down"></span>{/}</button>
                                    </th>
                                    <th class="td-date {? sort == 'date_created'}active{/}">
                                        <button type="button" class="btn btn-default dropdown-toggle">등록일자{? order}{? order == "ASC"}<span class="icon-caret-up"></span>{:}<span class="icon-caret-down"></span>{/}{:}<span class="icon-caret-down"></span>{/}</button>
                                    </th>
                                    <th class="td-status {? sort == 'status_bz'}active{/}">
                                        <select class="selectpicker" data-width="auto" name="state" >
                                            <optgroup label="상태">
                                                <option value="99" {? order == 99}selected="selected"{/}>전체</option>
                                                <option value="0" {? order == 0}selected="selected"{/}>대기</option>
                                                <option value="1" {? order == 1}selected="selected"{/}>승인</option>
                                                <option value="2" {? order == 2}selected="selected"{/}>반려</option>
                                            </optgroup>
                                        </select>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                {@ res}
                                <tr>
                                    <td class="td-num" width="60">{= res_cnt - (pagesize*(page-1) + .key_)}</td>
                                    <td class="td-name">{?.c}<a href="/admin_startup/add/{.c.id}">{.c.name}</a>{:}{.startup_name}{/}</td>
                                    <td class="td-subject"><a href="/admin_showcase/views/{.id}">{.name}</a></td>
                                    <td class="td-desc">{.des_ele}</td>
                                    <td class="td-name">{.u.name}</td>
                                    <td class="td-date">{.founded}</td>
                                    <td class="td-date">{=substr(str_replace('-', '.', .date_created), 0, 10)}</td>
                                    <td class="td-status">
                                        {? .status_bz == 0}<button type="button" class="btn btn-default btn-xs" onclick="location.href='/admin_showcase/views/{.id}'">대기</button>{/}
                                        {? .status_bz == 1}<button type="button" class="btn btn-success btn-xs" onclick="location.href='/admin_showcase/views/{.id}'">승인</button>{/}
                                        {? .status_bz == 2}<button type="button" class="btn btn-warning btn-xs" onclick="location.href='/admin_showcase/views/{.id}'">반려</button>{/}
                                    </td>  
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
                                    <li><a href="/admin_showcase/{page - 1}?search={search}&sort={sort}&order={order}">&laquo;</a></li>
                                    {/}

                                    {@paging.pages}
                                    {?.type == "dot"}
                                    <li class="disabled"><a href="#">...</a></li>
                                    {:}
                                    <li {?.type == "current"}class="active"{/}><a href="/admin_showcase/{.page}?search={search}&sort={sort}&order={order}" >{.page}</a></li>
                                    {/}
                                    {/}

                                    {?page >= paging.tot_page}
                                    <li class="disabled"><a href="#">&raquo;</a></li>
                                    {:}
                                    <li><a href="/admin_showcase/{page + 1}?search={search}&sort={sort}&order={order}" >&raquo;</a></li>
                                    {/}
                                </ul>

                                <form role="search" class="search" action="/admin_showcase">
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
                <!-- /section --> 
            </div>
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
        document.location.href = "/admin_showcase?sort=status_bz&order="+_val;
    }); 

    $(".td-founded button").click(function()
    {
        {? sort == 'founded' && order == 'ASC'}document.location.href = "/admin_showcase?search={search}&sort=founded&order=DESC";
        {:}document.location.href = "/admin_showcase?search={search}&sort=founded&order=ASC";{/}
    });

    $(".td-date button").click(function()
    {
        {? sort == 'date_created' && order == 'ASC'}document.location.href = "/admin_showcase?search={search}&sort=date_created&order=DESC";
        {:}document.location.href = "/admin_showcase?search={search}&sort=date_created&order=ASC";{/}
    });
}); 


function del_cont(_id, _this) {
    if (confirm("삭제할까요?") === true){    //확인
        $.get('/ajax/del_contents/'+_id, function(){
            $(_this).parent().parent().remove();
        });
    }else{   //취소
        return;
    }
}

//]]>
</script>