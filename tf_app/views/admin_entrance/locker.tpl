
            <!-- contentswrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                    
                    <!-- panel -->
                    <div id="pane-entrance-locker" class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon glyphicon-lock"></span><span class="break"></span>사물함 사용목록</h2>
                            <div class="actions"> 
                                <span class="break"></span>
                                <a title="" data-toggle="tooltip" class="btn-list" href="/admin_entrance/locker_edit" data-original-title="사물함 번호관리"><span class="glyphicon  glyphicon-cog"></span></a> 
                            </div>
                        </div>
                        <!-- /panel-heading --> 
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th class="td-num">사물함 번호</th>
                                    <th class="td-name">현재 사용중인 멤버</th> 
                                    <th class="td-time">입실시간</th> 
                                </tr>
                            </thead>
                            <tbody>
                                {@res}
                                <tr>
                                    <td class="td-num">{.locker}</td>
                                    <td class="td-name"><a href="#">{.name}</a></td> 
                                    <td class="td-time">{=str_replace("-", ".", substr(.date_in, 0, 16))}</td> 
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
                                    <li><a href="/admin_entrance/locker/{page - 1}">&laquo;</a></li>
                                    {/}

                                    {@paging.pages}
                                    {?.type == "dot"}
                                    <li class="disabled"><a href="#">...</a></li>
                                    {:}
                                    <li {?.type == "current"}class="active"{/}><a href="/admin_entrance/locker/{page}" >{.page}</a></li>
                                    {/}
                                    {/}

                                    {?page >= paging.tot_page}
                                    <li class="disabled"><a href="#">&raquo;</a></li>
                                    {:}
                                    <li><a href="/admin_entrance/locker/{page + 1}" >&raquo;</a></li>
                                    {/}
                                </ul>
                            </div>
                        </div>
                        <!-- /panel-footer --> 
                    </div>
                    <!--/panel --> 
                    
                    
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 
