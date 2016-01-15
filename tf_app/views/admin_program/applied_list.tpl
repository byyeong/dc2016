
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                    
                    <!-- panel #pane-event-edit -->
                    <div id="pane-event-edit" class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-edit"></span><span class="break"></span> Benefits 신청자</h2>
                        </div>
                        <!-- /panel-heading -->
                        <div class="applied-list panel panel-default tab-content"> 
                            <div class="panel-heading">   
                                <!-- tab-content -->
                                <ul class="nav nav-tabs">
                                  <li {? tab == "dashboard"}class="active"{/}><a data-toggle="tab" href="#dashboard">프로그램 진행 현황</a></li>
                                  <li {? !tab}class="active"{/}><a data-toggle="tab" href="#apply_list">참가자 현황</a></li>
                                </ul> 
                            </div>
                            
                            <div class="panel-body tab-pane {? tab == 'dashboard'}active{/}" id="dashboard">
                                <div class="well ">
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-6 col-md-6">
                                            <dl class="dl-horizontal">
                                                <dt>총 접수 건수</dt>
                                                <dd><span class="badge badge-primary">{list_cnt}</span></dd>
                                            </dl>
                                        </div>
                                    </div>
                                </div>

                                
                                <h4><span class="glyphicon glyphicon-signal"></span> 일자별 접수 건수</h4>
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr> 
                                                <th width="33.33%" class="td-date">접수일</th> 
                                                <th width="33.33%" class="td-cnt">접수</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {@ d_list}
                                            <tr> 
                                                <td class="td-date">{.day}</td>
                                                <td class="td-cnt"><span class="badge badge-primary">{.all}</span></td>
                                            </tr>
                                            {/}
                                        </tbody>
                                    </table>
                                </div> 

                            </div>

                            <div class="panel-body tab-pane {? !tab}active{/}" id="apply_list">
                                <div class="table-responsive">
                                    <table class="table table-hover table-striped">
                                        <thead>
                                            <tr>
                                                <th class="cell-num">번호</th>
                                                <th class="cell-name">참가자</th>
                                                <th class="cell-group">회사/팀</th>
                                                <th class="cell-date">신청일자</th>
                                                <th class="cell-content">참가내용보기</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {@ list}
                                            <tr>
                                                <td class="cell-num">{= list_cnt - (pagesize*(page-1) + .key_)}</td>
                                                <td class="cell-name">{? .ids}<a href="/member/{.ids}">{.name}</a>{:}{.f_name}{/}</td>
                                                <td class="cell-group">{?.team}{.team}{:}{.f_team}{/}</td>
                                                <td class="cell-date">{.date_created}</td>
                                                <td class="cell-content">
                                                    <a href="/admin_program/applied_view/{.id}" class="btn btn-default btn-xs">내용보기</a>
                                                </td>                       
                                            </tr>
                                            {/}
                                        </tbody>
                                    </table>
                                </div>
                                <br/>
                                <div class="paging text-center">
                                    <ul class="pagination">
                                        {?page == 1}
                                        <li class="disabled"><a href="#">&laquo;</a></li>
                                        {:}
                                        <li><a href="/admin_program/applied_list/{res.id}/{page - 1}?alig={alig}">&laquo;</a></li>
                                        {/}

                                        {@paging.pages}
                                        {?.type == "dot"}
                                        <li class="disabled"><a href="#">...</a></li>
                                        {:}
                                        <li {?.type == "current"}class="active"{/}><a href="/admin_program/applied_list/{res.id}/{.page}?alig={alig}" >{.page}</a></li>
                                        {/}
                                        {/}

                                        {?page >= paging.tot_page}
                                        <li class="disabled"><a href="#">&raquo;</a></li>
                                        {:}
                                        <li><a href="/admin_program/applied_list/{res.id}/{page + 1}?alig={alig}" >&raquo;</a></li>
                                        {/}
                                    </ul>
                                </div> 
                                <!-- /paging --> 
                            </div>  
                        </div>
                    </div>
                    <!-- /panel #pane-event-edit --> 

                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 
            <!-- /End Page Cotents --> 
        </div>
    </div>
</div>
<!-- /container --> 