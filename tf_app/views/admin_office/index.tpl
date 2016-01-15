            <!-- contentswrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                    
                    <!-- panel --> 
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2>
                                <span class="icon-align-justify"></span><span class="break"></span>
                                Office Hours 목록
                            </h2>
                            <div class="actions"> 
                                <span class="break"></span> 
                                <a title="Office Hours 추가" data-toggle="tooltip" href="/admin_office/edit_oh">
                                    <span class="icon-plus"></span>
                                </a> 
                            </div>
                        </div>
                        <!-- /panel-heading -->
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th width="60" class="td-num">번호</th>
                                    <th class="td-name">멘토</th>
                                    <th class="td-subject">OH 제목</th>
                                    <th class="td-date">행사날짜</th>
                                    <th class="td-date">접수기간</th>
                                    <th class="td-date">발표일 </th>
                                    <th class="td-info">정보</th>
                                    <th class="td-status">
                                        <select class="selectpicker" data-width="auto" name="state" >
                                            <optgroup label="상태">
                                                <option value="99" {? order == 99}selected="selected"{/}>전체</option>
                                                <option value="0" {? order == 0}selected="selected"{/}>접수중</option>
                                                <option value="1" {? order == 1}selected="selected"{/}>접수대기중</option>
                                                <option value="2" {? order == 2}selected="selected"{/}>마감</option>
                                            </optgroup>
                                        </select>
                                    </th>
                                    <th class="td-cnt">선정/접수</th>
                                </tr>
                            </thead>
                            <tbody>
                                {@ res}
                                <tr>
                                    <td class="td-num">{= res_cnt - (pagesize*(page-1) + .key_)}</td>
                                    <td class="td-name">{.name}</td>
                                    <td class="td-subject">{.subject}</td>
                                    <td class="td-date">{=substr(.e_start,0,10)}~{=substr(.e_end,0,10)}</td>
                                    <td class="td-date">{=substr(.a_start,0,10)}~{=substr(.a_end,0,10)}</td>
                                    <td class="td-date">{=substr(.r_date,0,10)}</td>
                                    <td class="td-info">
                                        <a href="/admin_office/edit_oh/{.id}" class="btn btn-default btn-xs">정보수정</a>
                                        <button data-toggle="tooltip" class="btn btn-danger btn-xs" type="button" title="삭제" onclick="del_oh(this, '{.id}'); return false;"><span class="icon-fixed-width icon-trash"></span></button>
                                    </td>
                                    <td class="td-status">
                                        {? .is_open}
                                        <span class="label label-success">공개</span>
                                        {:}
                                        <span class="label label-default">비공개</span>
                                        {/}
                                        {? .a_start > date('Y.m.d H:i')}
                                        <span class="label label-default">접수대기중</span>
                                        {/}
                                        {? .a_start <= date('Y.m.d H:i') && .a_end > date('Y.m.d H:i')}
                                        <span class="label label-success">접수중</span>
                                        {/}
                                        {? .a_end < date('Y.m.d H:i')}
                                        {? .status}
                                        <span class="label label-info">마감(선정완료)</span>
                                        {:}
                                        <span class="label label-info">접수마감(선정중)</span>
                                        {/}
                                        {/}
                                    </td>
                                    <td class="td-cnt"><a href="/admin_office/oh_apply/{.id}" class="btn btn-default btn-xs">{.app}/{.tot}</a></td>
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
                                    <li><a href="/admin_office/{page - 1}?order={order}">&laquo;</a></li>
                                    {/}

                                    {@paging.pages}
                                    {?.type == "dot"}
                                    <li class="disabled"><a href="#">...</a></li>
                                    {:}
                                    <li {?.type == "current"}class="active"{/}><a href="/admin_office/{.page}?order={order}">{.page}</a></li>
                                    {/}
                                    {/}

                                    {?page == paging.tot_page}
                                    <li class="disabled"><a href="#">&raquo;</a></li>
                                    {:}
                                    <li><a href="/admin_office/{page + 1}?order={order}" >&raquo;</a></li>
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
        document.location.href = "/admin_office?order="+_val;
    }); 
}); 

//]]>
</script>