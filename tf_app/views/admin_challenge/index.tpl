
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-align-justify"></span><span class="break"></span>경진대회 목록</h2>
                            <div class="actions"> <span class="break"></span> <a title="경진대회 추가" data-toggle="tooltip" href="/admin_challenge/edit"><span class="glyphicon  glyphicon-plus"></span></a> </div>
                        </div>
                        <!-- /panel-heading -->
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th width="60" class="td-num">번호</th>
                                    <th class="td-subject">경진대회명</th>
                                    <th class="td-name">주최자</th>
                                    <th class="td-group">기관/단체</th>
                                    <th class="td-date">접수마감일</th>
                                    <th class="td-date">발표일</th>
                                    <th class="td-cnt">접수건수</th>
                                    <th class="td-status">
                                        <select class="selectpicker" data-width="auto" name="state" >
                                            <optgroup label="상태">
                                                <option value="99" {? order == 99}selected="selected"{/}>전체</option>
                                                <option value="0" {? order == 0}selected="selected"{/}>접수중</option>
                                                <option value="1" {? order == 1}selected="selected"{/}>접수준비중</option>
                                                <option value="2" {? order == 2}selected="selected"{/}>마감</option>
                                            </optgroup>
                                        </select>
                                    </th>
                                    <th class="td-status">승인여부</th>
                                </tr>
                            </thead>
                            <tbody>
                                {@ res}
                                <tr>
                                    <td class="td-num">{= res_cnt - (pagesize*(page-1) + .key_)}</td>
                                    <td class="td-subject"><a href="/admin_challenge/edit/{.id}">{.subject}</a></td>
                                    <td class="td-name">{.name}</td>
                                    <td class="td-group">{.organized}</td>
                                    <td class="td-date">{.date_e}</td>
                                    <td class="td-date">{.announce_d}</td>
                                    {? date('Y.m.dH:i') < .sdate}
                                    <td class="td-cnt">
                                        {? .cnt}
                                        <span class="badge badge-info">{.cnt}</span>
                                        {:}
                                        <span class="glyphicon glyphicon-minus text-muted"></span>
                                        {/}
                                    </td>
                                    <td class="td-status"><span class="label label-info">접수준비</span></td>
                                    {/}
                                    {? date('Y.m.dH:i') > .sdate && date('Y.m.dH:i') < .edate}
                                    <td class="td-cnt">
                                        {? .cnt}
                                        <span class="badge badge-primary">{.cnt}</span>
                                        {:}
                                        <span class="glyphicon glyphicon-minus text-muted"></span>
                                        {/}
                                    </td>
                                    <td class="td-status"><span class="label label-primary">접수중</span></td>
                                    {/}
                                    {? date('Y.m.dH:i') > .edate}
                                    {? date('Y.m.dH:i') > .announce && .winner}
                                    <td class="td-cnt">
                                        {? .cnt}
                                        <span class="badge">{.cnt}</span>
                                        {:}
                                        <span class="glyphicon glyphicon-minus text-muted"></span>
                                        {/}
                                    </td>
                                    <td class="td-status"><span class="label label-default">수상자발표</span></td>
                                    {:}
                                    <td class="td-cnt">
                                        {? .cnt}
                                        <span class="badge badge-warning">{.cnt}</span>
                                        {:}
                                        <span class="glyphicon glyphicon-minus text-muted"></span>
                                        {/}
                                    </td>
                                    <td class="td-status"><span class="label label-warning">접수마감</span></td>
                                    {/}
                                    {/}
                                    <td class="td-status">
                                        {? .status == 0}<button onclick="location.href='/admin_challenge/edit/{.id}'" class="btn btn-default btn-xs" type="button">승인대기</button>{/}
                                        {? .status == 1}<button onclick="location.href='/admin_challenge/edit/{.id}'"  class="btn btn-success btn-xs" type="button">승인</button>{/}
                                        {? .status == 2}<button onclick="location.href='/admin_challenge/edit/{.id}'"  class="btn btn-warning btn-xs" type="button">반려</button>{/}
                                    </td>
                                </tr>
                                {/}
                            </tbody>
                        </table>
                        <div class="panel-footer">
                            <div class="paging">
                                <ul class="pagination">
                                    {?page == 1}
                                    <li class="disabled"><a href="#">&laquo;</a></li>
                                    {:}
                                    <li><a href="/admin_challenge/{page - 1}?order={order}">&laquo;</a></li>
                                    {/}

                                    {@paging.pages}
                                    {?.type == "dot"}
                                    <li class="disabled"><a href="#">...</a></li>
                                    {:}
                                    <li {?.type == "current"}class="active"{/}><a href="/admin_challenge/{.page}?order={order}">{.page}</a></li>
                                    {/}
                                    {/}

                                    {?page == paging.tot_page}
                                    <li class="disabled"><a href="#">&raquo;</a></li>
                                    {:}
                                    <li><a href="/admin_challenge/{page + 1}?order={order}" >&raquo;</a></li>
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
    $("select[name=state]").change(function() 
    { 
        var _val = $("select[name=state] option:selected").val();
        document.location.href = "/admin_challenge?order="+_val;
    }); 
}); 

//]]>
</script>