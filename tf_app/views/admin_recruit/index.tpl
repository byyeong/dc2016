
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                    
                    <!-- panel -->
                    <div class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon glyphicon-briefcase"></span><span class="break"></span> 채용정보 리스트</h2>
                            <div class="actions">
                                <span class="break"></span><a href="/admin_recruit/add" class="btn-add"  data-toggle="tooltip" title="스타트업 등록"><span class="glyphicon glyphicon-plus"></span></a> 
                            </div>
                        </div>
                        <!-- /panel-heading -->
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <!--<th class="td-check" width="40"><input type="checkbox"></th>-->
                                    <th class="td-company">회사명</th>
                                    <th class="td-subject" >제목</th>
                                    <th class="td-date" >채용 공고 기간</th>
                                    <th class="td-sector" >업무분야</th>
                                    <th class="td-status" >
                                        <select class="selectpicker" data-width="auto" name="state" >
                                            <optgroup label="상태">
                                                <option value="99" {? sort == 'state' && order == 99}selected="selected"{/}>전체</option>
                                                <option value="0" {? sort == 'state' && order == 0}selected="selected"{/}>승인대기</option>
                                                <option value="1" {? sort == 'state' && order == 1}selected="selected"{/}>승인</option>
                                                <option value="2" {? sort == 'state' && order == 2}selected="selected"{/}>반려</option>
                                            </optgroup>
                                        </select>
                                    </th>
                                    <th class="td-manage" >관리</th>
                                </tr>
                            </thead>
                            <tbody>
                                {@ res}
                                <tr>
                                    <!--<td class="td-check"><input type="checkbox"></td>-->
                                    <td class="td-company">{? .s_name}<a href="{.s_url}">{.s_name}</a>{:}<a href="/admin_startup/add/{.startup_id}">{.sname}</a>{/}</td>
                                    <td class="td-subject"><a href="/admin_recruit/add/{.rid}">{? .s_name}[EN] {/}{.title}</a></td>
                                    <td class="td-date">{.start} ~ {.end}</td>
                                    <td class="td-sector">{@ .sector}{? ..key_ == 0}{.._value}{:}, {.._value}{/}{/}</td>
                                    {? .rstate == 0}
                                    <td class="td-status"><span class="label label-default">승인대기</span></td>
                                    {/}{? .rstate == 1}
                                    <td class="td-status"><span class="label label-success">승인</span></td>
                                    {/}{? .rstate == 9}
                                    <td class="td-status"><span class="label label-warning">비공개</span></td>
                                    {/}
                                    <td class="td-manage">
                                        <button onclick="del_recruit('{.rid}', this); return false;" title="" data-toggle="tooltip" class="btn btn-danger btn-xs" type="button" data-original-title="삭제"><span class="glyphicon  glyphicon-trash  glyphicon-white"></span></button>
                                     </td>
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
                                <li><a href="/admin_recruit/{page - 1}?search={search}&sort={sort}&order={order}">&laquo;</a></li>
                                {/}

                                {@paging.pages}
                                {?.type == "dot"}
                                <li class="disabled"><a href="#">...</a></li>
                                {:}
                                <li {?.type == "current"}class="active"{/}><a href="/admin_recruit/{.page}?search={search}&sort={sort}&order={order}">{.page}</a></li>
                                {/}
                                {/}

                                {?page == paging.tot_page}
                                <li class="disabled"><a href="#">&raquo;</a></li>
                                {:}
                                <li><a href="/admin_recruit/{page + 1}?search={search}&sort={sort}&order={order}" >&raquo;</a></li>
                                {/}
                            </ul>
                            <form role="search" class="search" action="/admin_recruit">
                                <div class="input-group">
                                    <input type="text" class="form-control" name="search" value="{search}">
                                    <span class="input-group-btn">
                                    <button class="btn btn-default" type="submit" data-toggle="tooltip" title="검색"><span class="icon-search"></span></button>
                                    </span> 
                                </div>
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
        document.location.href = "/admin_recruit?search={search}&sort=state&order="+_val;
    }); 
}); 

function del_recruit(_id, _this) {
    if (confirm("삭제할까요?") === true){    //확인
        $.get('/ajax/del_recruit/'+_id,function(){
            $(_this).parent().parent().remove();
        });
    }else{   //취소
        return;
    }
}

//]]>
</script>