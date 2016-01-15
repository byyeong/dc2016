
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                    
                    <!-- panel -->
                    <div class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon glyphicon-briefcase"></span><span class="break"></span> 스타트업 리스트</h2>
                            <div class="actions">
                                <span class="break"></span><a href="/admin_startup/add" class="btn-add"  data-toggle="tooltip" title="스타트업 등록"><span class="glyphicon glyphicon-plus"></span></a><span class="break"></span><a title="" data-toggle="tooltip" class="btn-down" href="/admin_startup/excel" data-original-title="다운로드"><span class="glyphicon glyphicon-download-alt"></span> Excel</a>
                            </div>
                        </div>
                        <!-- /panel-heading -->
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <!--<th class="td-check" width="40"><input type="checkbox"></th>-->
                                    <th class="td-company">회사명</th>
                                    <th class="td-scale">규모</th>
                                    <th class="td-desc" >한줄설명</th>
                                    <th class="td-status" >
                                        <select class="selectpicker" data-width="auto" name="state" >
                                            <optgroup label="상태">
                                                <option value="99" {? sort == 'state' && order == 99}selected="selected"{/}>전체</option>
                                                <option value="0" {? sort == 'state' && order == 0}selected="selected"{/}>승인대기</option>
                                                <option value="1" {? sort == 'state' && order == 1}selected="selected"{/}>승인</option>
                                                <option value="2" {? sort == 'state' && order == 2}selected="selected"{/}>비공개</option>
                                            </optgroup>
                                        </select>
                                    </th>
                                    <th class="td-date" >등록일자</th>
                                </tr>
                            </thead>
                            <tbody>
                                {@ res}
                                <tr>
                                    <!--<td class="td-check"><input type="checkbox"></td>-->
                                    <td class="td-company"><a href="/admin_startup/add/{.id}">{.name}</a></td>
                                    <td class="td-scale">{.number}</td>
                                    <td class="td-desc">{.bio}</td>
                                    {? res.state == 0}
                                    <td class="td-status"><span class="label label-default">승인대기</span></td>
                                    {/}{? res.state == 1}
                                    <td class="td-status"><span class="label label-success">승인</span></td>
                                    {/}{? res.state == 2}
                                    <td class="td-status"><span class="label label-warning">비공개</span></td>
                                    {/}
                                    <td class="td-date">{=str_replace("-", ".", substr(.date_created, 0, 10))}</td>
                                </tr>
                                {/}
                            </tbody>
                        </table>
                        <!-- panel-footer-->
                        <div class="panel-footer">
                            <ul class="pagination" style=" margin: 0;">
                                {?page == 1}
                                <li class="disabled"><a href="#">&laquo;</a></li>
                                {:}
                                <li><a href="/admin_startup/{page - 1}?search={search}&sort={sort}&order={order}">&laquo;</a></li>
                                {/}

                                {@paging.pages}
                                {?.type == "dot"}
                                <li class="disabled"><a href="#">...</a></li>
                                {:}
                                <li {?.type == "current"}class="active"{/}><a href="/admin_startup/{.page}?search={search}&sort={sort}&order={order}">{.page}</a></li>
                                {/}
                                {/}

                                {?page == paging.tot_page}
                                <li class="disabled"><a href="#">&raquo;</a></li>
                                {:}
                                <li><a href="/admin_startup/{page + 1}?search={search}&sort={sort}&order={order}" >&raquo;</a></li>
                                {/}
                            </ul>
                            <form role="search" class="search" action="/admin_startup">
                                <div class="input-group">
                                    <input type="text" class="form-control" name="search" value="{search}">
                                    <span class="input-group-btn">
                                    <button class="btn btn-default" type="submit" data-toggle="tooltip" title="검색"><span class="icon-search"></span></button>
                                    </span> </div>
                            </form>
                        </div>
                        <!-- /panel-footer--> 
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
        document.location.href = "/admin_startup?search={search}&sort=state&order="+_val;
    }); 
}); 

//]]>
</script>