
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap">
            <!-- section -->
            <section> 
                
                <!-- panel #pane-eventType-list -->
                <div id="pane-eventType-list" class="panel panel-default"> 
                    <!-- panel-heading -->
                    <div class="panel-heading">
                        <h2><span class="glyphicon  glyphicon-cog"></span><span class="break"></span>Benefits 성격 종류</h2>
                        <div class="actions"> <span class="break"></span> <a href="/admin_program/category_edit" data-toggle="tooltip" title="성격추가하기"><span class="glyphicon  glyphicon-plus"></span></a> </div>
                    </div>
                    <!-- /panel-heading -->
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th class="td-type">성격</th>
                                <th class="td-type">노출</th>
                            </tr>
                        </thead>
                        <tbody>
                            {@ res}
                            <tr>
                                <td class="td-type">
                                    <a href="/admin_program/category_edit/{.id}">{.category}</a>
                                </td>
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