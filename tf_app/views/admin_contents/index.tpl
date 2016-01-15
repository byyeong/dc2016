<!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-align-justify"></span><span class="break"></span>Blog 목록</h2>
                            <div class="actions"> <span class="break"></span> <a title="콘텐츠 추가" data-toggle="tooltip" href="/admin_contents/edit"><span class="glyphicon  glyphicon-plus"></span></a> </div>
                        </div>
                        
                        
                        <!-- /panel-heading -->
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th width="60" class="td-num">번호</th>
                                    <th class="td-category">카테고리</th>
                                    <th class="td-subject">글제목</th>
                                    <th class="td-name">작성자</th>
                                    <th class="td-date">작성일</th>
                                    <th class="td-status">
                                        <select class="selectpicker" data-width="auto" name="state" >
                                            <optgroup label="상태">
                                                <option value="99" {? order == 99}selected="selected"{/}>전체</option>
                                                <option value="0" {? order == 0}selected="selected"{/}>승인대기</option>
                                                <option value="1" {? order == 1}selected="selected"{/}>승인</option>
                                            </optgroup>
                                        </select>
                                    </th>
                                    <th class="td-status" width="80">관리</th>
                                </tr>
                            </thead>
                            <tbody>
                                {@ res}
                                <tr>
                                    <td class="td-num">{= res_cnt - (pagesize*(page-1) + .key_)}</td>
                                    <td class="td-category">{.cname}</td>
                                    <td class="td-subject">{? .hidden}<span class="icon-lock text-warning"></span> {/}<a href="/admin_contents/edit/{.id}">{.subject}</a></td>
                                    <td class="td-name"><a href="/admin_member/add/{.mid}">{.mname}</a></td>
                                    <td class="td-date">{=str_replace("-",".",substr(.date_created, 0, 10))}</td>
                                    <td class="td-status">
                                        {? .state}
                                        <button onclick="location.href='/admin_contents/edit/{.id}'" class="btn btn-success btn-xs" type="button">승인</button>
                                        {:}
                                        <button onclick="location.href='/admin_contents/edit/{.id}'" class="btn btn-default btn-xs" type="button">승인대기</button>
                                        {/}
                                    </td>
                                    <td class="td-status">
                                        <button type="button" class="btn btn-danger btn-xs" data-toggle="tooltip" title="삭제" onclick="del_cont('{.id}', this); return false;"><span class="glyphicon  glyphicon-trash  glyphicon-white"></span></button>
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
                                    <li><a href="/admin_contents/{page - 1}?sort=c.state&order={order}">&laquo;</a></li>
                                    {/}

                                    {@paging.pages}
                                    {?.type == "dot"}
                                    <li class="disabled"><a href="#">...</a></li>
                                    {:}
                                    <li {?.type == "current"}class="active"{/}><a href="/admin_contents/{.page}?sort=c.state&order={order}" >{.page}</a></li>
                                    {/}
                                    {/}

                                    {?page >= paging.tot_page}
                                    <li class="disabled"><a href="#">&raquo;</a></li>
                                    {:}
                                    <li><a href="/admin_contents/{page + 1}?sort=c.state&order={order}" >&raquo;</a></li>
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
        document.location.href = "/admin_contents?sort=c.state&order="+_val;
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