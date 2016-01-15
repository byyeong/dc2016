
            <!-- contentswrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                    
                    <!-- panel -->
                    <div id="pane-entrance-dash" class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon glyphicon-inbox"></span><span class="break"></span>입출입 대시보드</h2>
                        </div>
                        <!-- /panel-heading --> 
                        <!-- panel-body -->
                        <div class="panel-body info-field">                            
                            <dl class="col-lg-5">
                                <dt>오늘 총 방문자수</dt>
                                <dd><span class="badge badge-info">{tot_to}</span> 명</dd>
                            </dl>
                            <dl class="col-lg-5">
                                <dt>현재 입실자수</dt>
                                <dd><span class="badge badge-success">{tot_in}</span> 명</dd>
                            </dl>
                            <div class="col-lg-2"> <a href="/admin_entrance/analytics" class="btn btn-default btn-sm">자세한 통계보기</a> </div>
                        </div>
                        <!-- /panel-body --> 
                        <!-- panel-body -->
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-6"> 
                                    <a href="/admin_entrance/checkin" class="btn btn-info btn-block"><span class="glyphicon glyphicon-log-in"></span><br>
                                    입실관리</a> 
                                </div>
                                <div class="col-md-6"> 
                                    <a href="/admin_entrance/checkout" class="btn btn-warning btn-block"><span class="glyphicon glyphicon-log-out"></span><br>
                                    퇴실관리</a> 
                                </div>
                            </div>
                            <!--/row --> 
                        </div>
                        <!-- /panel-body --> 
                    </div>
                    <!--/panel --> 
                    
                    <!-- panel -->
                    <div id="pane-entrance-status" class="panel panel-default"> 
                    </div>
                    <!--/panel --> 
                    
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 

<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}

get_entrance(1);
function get_entrance(_page) {
    var get_url = "/ajax/entrance/"+_page;
    
    $.get(get_url, function(_data) {
        $("#pane-entrance-status").html(_data);
    });
}

//]]>
</script>
