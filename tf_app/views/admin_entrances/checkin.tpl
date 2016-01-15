
            <!-- contentswrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                    
                    <!-- panel -->
                    <div id="pane-entrance-checkin" class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon glyphicon-log-in"></span><span class="break"></span>입실 관리</h2>
                        </div>
                        <!-- /panel-heading --> 
                        
                        <!-- panel-body -->
                        <div class="panel-body highlight">
                            <form role="search" class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3" method="post">
                                <div class="input-group">
                                    <input type="text" value="{q}" required="required" name="q" class="form-control" placeholder="이름, 핸드폰 번호, 생년월일을 입력한 후 검색하세요">
                                    <span class="input-group-btn">
                                    <button class="btn btn-default" type="submit"  data-toggle="tooltip" title="검색"><span class="icon-search"></span></button>
                                    </span> </div>
                            </form>
                        </div>
                        <!-- /panel-body -->
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th class="td-mem">멤버십여부</th>
                                    <th class="td-name">이름</th>
                                    <th class="td-name">성별</th>
                                    <th class="td-name">생년월일</th>
                                    <th class="td-phone">휴대폰번호</th>
                                    <th class="td-checkin">출입증발급</th>
                                </tr>
                            </thead>
                            <tbody>
                                {@ res}
                                <tr>
                                    <td class="td-mem">{? .membership == 1}<span class="glyphicon glyphicon-ok text-primary"></span>{:}<span class="glyphicon glyphicon-minus text-danger"></span>{/}</td>
                                    <td class="td-name">{.name}{? .admin_des}  <span class="glyphicon glyphicon-warning-sign text-warning"></span>{/}</td>
                                    <td class="td-phone">{?.gender == 1}남{/}{?.gender == 2}여{/}</td>
                                    <td class="td-phone">{.birth}</td>
                                    <td class="td-phone">{.tel}</td>
                                    <td class="td-checkin"><a href="/admin_entrance/checkin_pass/{.id}" class="btn btn-default btn-xs">발급하기</a></td>
                                </tr>
                                {/}
                            </tbody>
                        </table>
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