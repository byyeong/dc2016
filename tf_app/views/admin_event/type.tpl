
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap">
            <!-- section -->
            <section> 
                
                <!-- panel #pane-eventType-list -->
                <div id="pane-eventType-list" class="panel panel-default"> 
                    <!-- panel-heading -->
                    <div class="panel-heading">
                        <h2><span class="glyphicon  glyphicon-cog"></span><span class="break"></span>이벤트 종류</h2>
                        <div class="actions"> <span class="break"></span> <a href="/admin_event/type_add" data-toggle="tooltip" title="종류추가하기"><span class="glyphicon  glyphicon-plus"></span></a> </div>
                    </div>
                    <!-- /panel-heading -->
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th class="td-type">이벤트 종류</th>
                                <th class="td-desc">이벤트 설명</th>
                                <th class="td-status">노출여부</th>
                            </tr>
                        </thead>
                        <tbody>
                            {@ res}
                            <tr>
                                <td class="td-type">
                                    <!--<span class="label label-warning"><span class="glyphicon  glyphicon-eye-close glyphicon-white"></span></span>-->
                                    <a href="/admin_event/type_add/{.id}">{.name}</a>
                                </td>
                                <td class="td-desc">{.description}</td>
                                {? .visible}
                                <td class="td-status"><span class="label label-success">보임</span></td>
                                {:}
                                <td class="td-status"><span class="label label-warning">숨김</span></td>
                                {/}
                            </tr>
                            {/}
                        </tbody>
                    </table>
                </div>
                <!-- /panel #pane-eventType-list -->                 
           
                
            </section>
            <!-- /section --> 
        </div>
        <!-- /contentwrap --> 