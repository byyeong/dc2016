            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2><span class="icon-align-justify"></span><span class="break"></span>Q&amp;A 목록</h2>
                        </div>
                        <!-- /panel-heading -->
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th width="60" class="td-num">번호</th>
                                    <th class="td-category">분류</th>
                                    <th class="td-subject">제목</th>
                                    <th class="td-name">작성자</th>
                                    <th class="td-date">날짜</th>
                                    <th class="td-status">
                                        <select class="selectpicker" data-width="auto" name="state" >
                                            <optgroup label="상태">
                                                <option value="1" {? order == 1}selected="selected"{/}>처리완료</option>
                                                <option value="0" {? order == 0}selected="selected"{/}>대기 중</option>
                                                <option value="99" {? order == 99}selected="selected"{/}>전체</option>
                                            </optgroup>
                                        </select>
                                    </th>
                                    <th class="td-status">노출여부</th>
                                    <th class="td-manage">관리 </th>
                                </tr>
                            </thead>
                            <tbody>
                                {@ qna}
                                <tr>
                                    <td class="td-num">{= qna_c - (pagesize*(page-1) + .key_)}</td>
                                    <td class="td-category">{.category}</td>
                                    <td class="td-subject"><a href="/admin_manage/edit_qna/{.id}">{.title}</a></td> 
                                    <td class="td-name">{.name}</td>
                                    <td class="td-date">{=str_replace('-', '.', substr(.date_created,0,10))}</td>
                                    <td class="td-status">
                                        {? .re_suc}
                                        <span class="btn-success btn-xs" type="button">처리완료 </span>
                                        {:}
                                        <span class="btn-primary btn-xs" type="button">처리중</span>
                                        {/}
                                    </td>
                                    <td class="td-status">
                                        {? .open}
                                        <span class="btn-success btn-xs" type="button">공개</span>
                                        {:}
                                        <span class="btn-danger btn-xs" type="button">비공개</span>
                                        {/}
                                    </td>
                                    <td class="td-manage">
                                        <button class="btn btn-default btn-xs" onclick="javascript:location.href='/admin_manage/edit_qna/{.id}'">답변하기</button>
                                        <!--button class="btn btn-warning btn-xs">삭제</button-->
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
                                    <li><a href="/admin_manage/qna/{page - 1}?order={order}">&laquo;</a></li>
                                    {/}

                                    {@paging.pages}
                                    {?.type == "dot"}
                                    <li class="disabled"><a href="#">...</a></li>
                                    {:}
                                    <li {?.type == "current"}class="active"{/}><a href="/admin_manage/qna/{.page}?order={order}">{.page}</a></li>
                                    {/}
                                    {/}

                                    {?page == paging.tot_page}
                                    <li class="disabled"><a href="#">&raquo;</a></li>
                                    {:}
                                    <li><a href="/admin_manage/qna/{page + 1}?order={order}" >&raquo;</a></li>
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
        document.location.href = "/admin_manage/qna?order="+_val;
    }); 
}); 

//]]>
</script>