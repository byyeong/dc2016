<!-- rowContent -->
    <div class="rowContent" id="recruit"> 
        
        <!-- page-header -->
        <div class="page-header">
            <div class="container">
                <h2><a href="/event/promotions">Promotions</a></h2>
            </div>
        </div>
        <!-- /page-header --> 
        
        <!-- page-content -->
        <div class="page-content"> 
            <!-- container -->
            <div class="container"> 
                <div class="row">
                <div class="content col-xs-12 col-sm-12 col-md-12">
                    <div class="content-header">
                        <button onclick="javascript:location.href='/event/promotions_res/2/excel'" class="btn btn-primary btn-sm pull-right"><span class="icon-fixed-width icon-large icon-edit"></span> 엑셀 다운로드 </button>
                        <h3 class="content-heading"> <span class="icon-calendar"></span> 프로모션 결과  </h3>

                    </div>
                    <div class="tab-content">
                        <div id="applied" class="tab-pane active">  

                            <div class="table-responsive">
                                <table class="table table-hover table-striped">
                                    <thead>
                                        <tr>
                                            <th width="50" class="td-num">번호</th>
                                            <th width="60" class="td-status">참가자</th>
                                            <th width="150" class="td-subject">스타트업</th>
                                            <th width="250" class="td-date">회사설명</th>
                                            <th class="td-space">목표</th>
                                            <th width="80" class="td-manage">참가시간</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {@ res}
                                        <tr>
                                            <td class="td-num">{.key_+1}</td>
                                            <td class="td-status"> <a href="/member/{.ids}">{.name}</a> </td>
                                            <td class="td-subject"><a href="/startup/{.id}">{.sname}</a></td>
                                            <td class="td-date">{.file}</td>
                                            <td class="td-space">{.form}</td>
                                            <td class="td-manage">{.date_created}</td>
                                        </tr>
                                        {/}
                                    </tbody>
                                    
                                </table>
                            </div>

                        </div>
                        <!-- /tab-pane -->
                        
                    </div>
                    <!-- /tab-content --> 
                </div>
                <!-- /content -->
                
                
                
                
            </div>

                    
                    
                 
            </div>
            <!-- /container --> 
        </div>
        <!-- /page-content -->         
    </div>
    <!-- /rowContent -->
