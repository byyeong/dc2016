
            <!-- contentswrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 

                    <!-- panel -->
                    <div id="pane-entrance-locker" class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon glyphicon-cog"></span><span class="break"></span>월별 사물함 갯수 지정</h2>
                        </div>
                        <!-- /panel-heading --> 
                        <div class="panel-body">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    
                                    <div class="col-xs-12 col-sm-10 col-md-10 ">
                                        <form method="post" action="/admin_entrance/monthly_locker/">
                                            <input type="hidden" name="m_locker_id" value="{m_locker.id}" />
                                        <div class="input-group" style="width:160px;">
                                            <input type="text" class="form-control" name="m_locker" value="{m_locker._value}" required="required" placeholder="사물함 갯수">
                                            <div class="input-group-btn">
                                                <button class="btn btn-default">확인</button>
                                            </div>
                                        </div>
                                        </form>
                                    </div>
                                    <div class="col-xs-12 col-sm-2 col-md-2 control-label">월별 사물함으로 {m_locker._value}개를 사용합니다. </div>
                                </div>
                            </div>
                        </div>             
                    </div>
                    <!--/panel --> 
                    
                    <!-- panel -->
                    <div id="pane-locker-user" class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-align-justify"></span><span class="break"></span>월별 사물함 이용 회원</h2>
                        </div>
                        <!-- /panel-heading --> 

                        <!-- panel-body -->
                        <div class="panel-body info-field">
                            <form action="/admin_entrance/monthly_locker/" name="send_m" method="post">
                                <select class="selectpicker" data-width="auto" name="year" onchange="send_month();">
                                    {@ year_}
                                    <option value="{.value_}" {? substr(date_, 0, 4) == .value_} selected="selected"{/}>{.value_}년</option>
                                    {/}
                                </select>

                                <select class="selectpicker" data-width="auto" name="month" onchange="send_month();">
                                    <option value="01" {? substr(date_, 5, 2) == '01'} selected="selected"{/}>1월</option>
                                    <option value="02" {? substr(date_, 5, 2) == '02'} selected="selected"{/}>2월</option>
                                    <option value="03" {? substr(date_, 5, 2) == '03'} selected="selected"{/}>3월</option>
                                    <option value="04" {? substr(date_, 5, 2) == '04'} selected="selected"{/}>4월</option>
                                    <option value="05" {? substr(date_, 5, 2) == '05'} selected="selected"{/}>5월</option>
                                    <option value="06" {? substr(date_, 5, 2) == '06'} selected="selected"{/}>6월</option>
                                    <option value="07" {? substr(date_, 5, 2) == '07'} selected="selected"{/}>7월</option>
                                    <option value="08" {? substr(date_, 5, 2) == '08'} selected="selected"{/}>8월</option>
                                    <option value="09" {? substr(date_, 5, 2) == '09'} selected="selected"{/}>9월</option>
                                    <option value="10" {? substr(date_, 5, 2) == '10'} selected="selected"{/}>10월</option>
                                    <option value="11" {? substr(date_, 5, 2) == '11'} selected="selected"{/}>11월</option>
                                    <option value="12" {? substr(date_, 5, 2) == '12'} selected="selected"{/}>12월</option>
                                </select>
                            </form>
                        </div>
                        
                        <!-- panel-body -->
                        <div class="panel-body">
                            <ul class="nav nav-tabs">
                                <li class="active"><a href="#appliableUser" data-toggle="tab">신청 가능한 회원 <span class="badge badge-default">{res_cnt}</span></a></li>
                                <li><a href="#appliedUser" data-toggle="tab">신청한 회원 <span class="badge badge-info">{already_cnt}</span></a></li>
                            </ul>
                        </div>
                        <!-- /panel-body -->
                        
                        <div class="tab-content">
                            <div class="tab-pane active" id="appliableUser">
                            </div>
                            <!-- /tab-pane -->
                            
                            <div class="tab-pane" id="appliedUser"> 
                            </div>
                            <!-- /tab-pane --> 
                        </div>
                        <!-- /tab-content-->

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

get_possible(1, '{date_}');
function get_possible(_page, _date) {
    var get_url = "/ajax/locker_month_possible/"+_page+"/"+_date;
    
    $.get(get_url, function(_data) {
        $("#appliableUser").html(_data);
    });
}

get_already(1, '{date_}');
function get_already(_page, _date) {
    var get_url = "/ajax/locker_month_already/"+_page+"/"+_date;
    
    $.get(get_url, function(_data) {
        $("#appliedUser").html(_data);
    });
}

function send_month() {
    document.send_m.submit();
}
//]]>
</script>