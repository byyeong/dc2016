
            <!-- Start Page Cotents --> 
            <!-- sidebar -->
            <div class="col-md-2 sidebar">
                <div class="sidebar-nav hidden-print">
                    <ul class="nav list-group">
                        <li class="list-group-item active"><a href="/admin_membership">멤버십신청자 관리</a></li>
                    </ul>
                </div>
            </div>
            <!-- /sidebar --> 
            <!-- contentswrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section > 
                    
                    <!-- panel -->
                    <div class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon glyphicon-user"></span><span class="break"></span>신청자 목록</h2> 
                            <div class="actions"> 
                                <span class="break"></span><a title="" data-toggle="tooltip" class="btn-down" href="/admin_membership/excel" data-original-title="다운로드"><span class="glyphicon glyphicon-download-alt"></span> Excel</a>
                            </div>
                        </div>
                        <!-- /panel-heading -->
                        <!-- table -->
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <!--<th class="td-check" width="20"><input type="checkbox"></th>-->
                                    <th class="td-grade">회원등급</th>
                                    <th class="td-name">이름</th>
                                    <th class="td-id" >아이디</th>
                                    <th class="td-company">추천기관/추천인</th>
                                    <th class="td-date">신청일자</th>
                                    <th class="td-view">신청내용</th>
                                    <th class="td-status">
                                        <select data-width="auto" class="selectpicker" name="state">
                                            <optgroup label="상태">
                                                <option value="99" {? sort == 'r.state' && order == 99}selected="selected"{/}>전체</option>
                                                <option value="0" {? sort == 'r.state' && order == 0}selected="selected"{/}>승인대기</option>
                                                <option value="1" {? sort == 'r.state' && order == 1}selected="selected"{/}>승인</option>
                                                <option value="2" {? sort == 'r.state' && order == 2}selected="selected"{/}>반려</option>
                                                <option value="3" {? sort == 'r.state' && order == 3}selected="selected"{/}>탈퇴</option>
                                            </optgroup>
                                        </select>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                {@ res}
                                <tr>
                                    <!--<td class="td-check"><input type="checkbox"></td>-->
                                    <td class="td-grade">{.mgname}</td>
                                    <td class="td-name"><a href="/admin_member/add/{.user_id}">{.name}</a> <small>{? .referee} ({.referee}){/}</small></td>
                                    <td class="td-id">{.ids}</td>
                                    <td class="td-company">{.com.name}{? .com && .mem} / {/}{.mem.name}</td>
                                    <td class="td-date">{=str_replace("-", ".", substr(.date_created, 0, 16))}</td>
                                    <td class="td-view"><button class="btn btn-default btn-xs" onclick="show_info('{.id}'); return false;">내용확인</button></td>
                                    <td class="td-status" id="state_{.user_id}">
                                        {? .mstate == 3}
                                        <span class="label label-danger">탈퇴</span>
                                        {:}
                                        {? .state == 0}
                                        <span class="label label-default">승인대기</span>
                                        {/}{? .state == 1}
                                        <span class="label label-success">승인</span>
                                        {/}{? .state == 2}
                                        <span class="label label-warning">반려</span>
                                        {/}
                                        {/}
                                    </td>
                                </tr>
                                {/}
                            </tbody>
                        </table>
                        <!-- /table -->
                        <!-- panel-footer -->
                        <div class="panel-footer">
                            <ul class="pagination" style=" margin: 0;">
                                {?page == 1}
                                <li class="disabled"><a href="#">&laquo;</a></li>
                                {:}
                                <li><a href="/admin_membership/{page - 1}?search={search}&sort={sort}&order={order}">&laquo;</a></li>
                                {/}

                                {@paging.pages}
                                {?.type == "dot"}
                                <li class="disabled"><a href="#">...</a></li>
                                {:}
                                <li {?.type == "current"}class="active"{/}><a href="/admin_membership/{.page}?search={search}&sort={sort}&order={order}">{.page}</a></li>
                                {/}
                                {/}

                                {?page == paging.tot_page}
                                <li class="disabled"><a href="#">&raquo;</a></li>
                                {:}
                                <li><a href="/admin_membership/{page + 1}?search={search}&sort={sort}&order={order}" >&raquo;</a></li>
                                {/}
                            </ul>
                            <form role="search" class="search" action="/admin_membership">
                                <div class="input-group">
                                    <input type="text" class="form-control" name="search" value="{search}">
                                    <span class="input-group-btn">
                                    <button class="btn btn-default" type="submit" data-toggle="tooltip" title="검색"><span class="icon-search"></span></button>
                                    </span> </div>
                            </form>
                        </div>
                        <!-- /panel-footer -->
                    </div>
                    <!-- /panel --> 
                
                
                </section>
                <!-- /section --></div>
            <!-- /contentwrap --> 
            <!-- /End Page Cotents --> 

<!-- /container --> 

<!-- modal -->
<div class="modal fade" id="md-mbshipView" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    
</div>
<!-- /modal -->

<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}
    
$(document).ready(function(){ 
    $("select[name=state]").change(function() 
    { 
        var _val = $("select[name=state] option:selected").val();
        document.location.href = "/admin_membership?sort=r.state&order="+_val;
    }); 
}); 

function show_info(_id) {
    var get_url = '/ajax/get_ms_info/'+_id+"/1";
    
    $.ajax({
        type : 'POST',
        url : get_url,
        dataType : 'html',
        success : function(_data) { 
            $('#md-mbshipView').html(_data);
            $('#md-mbshipView').modal('show');
        }
    });
}
function mem_permit(_this, _id) {
    var _st = $(_this).val();
    var get_url = '/ajax/permit_membership/'+_id+'/'+_st;
    
    $.ajax({
        type : 'POST',
        url : get_url,
        dataType : 'json',
        success : function(_data) { 
            document.location.reload(true);
            
{*            alert('변경되었습니다.');
            if (_st === 1) {
                $(_this).html('승인');
                $(_this).removeClass('btn btn-default btn-xs');
                $(_this).addClass('label label-success');
                $(_this).attr('onclick', 'mem_permit(this, '+_id+', 0); return false;');
            }
            else {
                $(_this).html('승인대기');
                $(_this).removeClass('label label-success');
                $(_this).addClass('btn btn-default btn-xs');
                $(_this).attr('onclick', 'mem_permit(this, '+_id+', 1); return false;');
            }*}
        }
    });
}
    
//]]>
</script>