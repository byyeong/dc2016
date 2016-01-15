
            <!-- contentswrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                    
                    <!-- panel -->
                    <div id="pane-entrance-checkin" class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon glyphicon-log-out"></span><span class="break"></span>퇴실 관리</h2>
                        </div>
                        <!-- /panel-heading --> 
                        
                        <!-- panel-body -->
                        <div class="panel-body highlight">
                            <form role="search" class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3" method="post" action="/admin_entrance/checkout">
                                <div class="input-group">
                                    <input type="text" name="q" required="required" class="form-control" placeholder="출입증번호를 입력하세요">
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
                                    <th class="td-checkin">입실시간</th>
                                    <th class="td-checkin">입실</th>
                                </tr>
                            </thead>
                            <tbody>
                                {?res}
                                <tr>
                                    <td class="td-mem">{? res.membership == 1}<span class="glyphicon glyphicon-ok text-primary"></span>{:}<span class="glyphicon glyphicon-minus text-danger"></span>{/}</td>
                                    <td class="td-name">{res.name}{? res.admin_des}  <span class="glyphicon glyphicon-warning-sign text-warning"></span>{/}</td>
                                    <td class="td-phone">{?res.gender == 1}남{/}{?res.gender == 2}여{/}</td>
                                    <td class="td-phone">{res.birth}</td>
                                    <td class="td-phone">{res.tel}</td>
                                    <td class="td-phone">{res.date_in}</td>
                                    <td class="td-checkin"><span class="glyphicon glyphicon-ok text-primary"></span></td>
                                </tr> 
                                {/}
                            </tbody>
                         </table>
                            
                         <!-- panel-body -->
                        {?res}
                        <form class="form-horizontal" method="post" action="/admin_entrance/checkout" name="checkout_form" onsubmit="return false;">
                               <input type="hidden" name="id" value="{res.id}" />
                        <div class="panel-body">
                            
                            <div class="form-group"  {? !res.locker}style="display: none;"{/}>
                                    <div class="col-xs-12 col-sm-2 col-md-2 control-label" >사물함 정리여부</div>
                                    <div class="col-xs-12 col-sm-10 col-md-10">
                                       <p class="form-control-static">사물함 정리를 완료하셨습니까? </p>
                                       <select class="selectpicker" data-width="auto" id="check_locker">
                                           <option value="0">No</option>
                                           <option value="1">Yes</option>
                                       </select>
                                    </div>
                                </div>
                                <!-- /form-group -->
                                <div class="form-group form-group-end">
                                    <div class="col-xs-12 col-sm-2 col-md-2 control-label" >퇴실여부</div>
                                    <div class="col-xs-12 col-sm-10 col-md-10">
                                       <p class="form-control-static">퇴실조치하시겠습니까? </p>
                                        <select class="selectpicker" data-width="auto" id="check_out">
                                           <option value="0">No</option>
                                           <option value="1">Yes</option>
                                       </select>
                                    </div>
                                </div>
                                <!-- /form-group -->
                           
                        </div>
                        <!-- /panel-body -->
                        <div class="panel-footer">
                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                    <button class="btn btn-primary" onclick="checkout(); return false;">확인</button>
                               </div>
                           </div>
                        </div>
                        </form>
                        {/}
                    </div>
                    <!-- /panel -->
                   
                    
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

function checkout() {
    {? res.locker}
    if ($('#check_locker option:selected').val() === '1' && $('#check_out option:selected').val() === '1') {
        document.checkout_form.submit();
    }
    else {
        return false;
    }
    {:}
    if ($('#check_out option:selected').val() === '1') {
        document.checkout_form.submit();
    }
    else {
        return false;
    }
    {/}
}

//]]>
</script>

