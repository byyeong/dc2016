            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2><span class="icon-align-justify"></span><span class="break"></span>분류 관리 </h2>
                            <div class="actions"> 
                                <span class="break"></span> 
                                <a title="추가하기" data-toggle="tooltip" href="/admin_manage/edit_faq_category">
                                    <span class="icon-plus"></span>
                                </a> 
                            </div>
                        </div>
                        <!-- /panel-heading -->
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th width="60" class="td-num">번호</th>
                                    <th class="td-category">분류명</th>
                                    <th class="td-manage">관리 </th>
                                </tr>
                            </thead>
                            <tbody>
                                {@ res}
                                <tr>
                                    <td class="td-num">{= res_c - (pagesize*(page-1) + .key_)}</td>
                                    <td class="td-category"><a href="/admin_manage/edit_faq_category/{.id}">{.category}</a></td> 
                                    <td class="td-manage">
                                        <button class="btn btn-warning btn-xs" onclick="del_qna_cat(this, {.id}, 1); return false;">삭제</button>
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
                                    <li><a href="/admin_manage/faq_category/{page - 1}">&laquo;</a></li>
                                    {/}

                                    {@paging.pages}
                                    {?.type == "dot"}
                                    <li class="disabled"><a href="#">...</a></li>
                                    {:}
                                    <li {?.type == "current"}class="active"{/}><a href="/admin_manage/faq_category/{.page}">{.page}</a></li>
                                    {/}
                                    {/}

                                    {?page == paging.tot_page}
                                    <li class="disabled"><a href="#">&raquo;</a></li>
                                    {:}
                                    <li><a href="/admin_manage/faq_category/{page + 1}" >&raquo;</a></li>
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

//]]>
</script>