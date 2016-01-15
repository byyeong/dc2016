
            <!-- contentswrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section > 
                    
                    <!-- panel -->
                    <div class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon glyphicon-user"></span><span class="break"></span>회원 목록</h2>
                            {? (s.per & settings->permission1) == settings->permission1}
                            <div class="actions"> 
                                <span class="break"></span><a href="/admin_member/add" class="btn-list"  data-toggle="tooltip" title="회원추가"><span class="glyphicon glyphicon-plus"></span></a> 
                                <span class="break"></span><a title="" data-toggle="tooltip" class="btn-down" href="/admin_member/excel" data-original-title="다운로드"><span class="glyphicon glyphicon-download-alt"></span> Excel</a>
                            </div>
                            {/}
                        </div>
                        <!-- /panel-heading -->
                        <!-- table -->
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <!--<th class="td-check" width="20"><input type="checkbox"></th>-->
                                    <th class="td-status">
                                        <select class="selectpicker" data-width="auto" name="utype">
                                            <optgroup label="회원 타입">
                                            <option value="99" {? type == 'utype' && type_e == 99}selected="selected"{/}>전체</option>
                                            <option value="1" {? type == 'utype' && type_e == 1}selected="selected"{/}>일반회원</option>
                                            <option value="2" {? type == 'utype' && type_e == 2}selected="selected"{/}>투자자 / 창업지원 유관기관 구성원</option>
                                            </optgroup>
                                        </select>
                                    </th>
                                    <th class="td-status">
                                        <select class="selectpicker" data-width="auto" name="grade">
                                            <optgroup label="회원 등급(권한)">
                                            <option value="99" {? grade_t == 'grade' && grade_e == 99}selected="selected"{/}>전체</option>
                                            {@ grade}
                                            <option value="{.id}" {? grade_t == 'grade' && grade_e == .id}selected="selected"{/}>{.name}</option>
                                            {/}
                                            </optgroup>
                                        </select>
                                    </th>
                                    <th class="td-name">이름</th>
                                    <th class="td-id" >아이디</th>
                                    <th class="td-company">직장명</th>
                                    <th class="td-date">등록일자</th>
                                    <th class="td-status">
                                        <select class="selectpicker" data-width="auto" name="state" >
                                            <optgroup label="상태">
                                                <option value="99" {? sort == 'state' && order == 99}selected="selected"{/}>전체</option>
                                                <option value="0" {? sort == 'state' && order == 0}selected="selected"{/}>승인대기</option>
                                                <option value="1" {? sort == 'state' && order == 1}selected="selected"{/}>승인</option>
                                                <option value="2" {? sort == 'state' && order == 2}selected="selected"{/}>반려</option>
                                                <option value="3" {? sort == 'state' && order == 3}selected="selected"{/}>탈퇴</option>
                                            </optgroup>
                                        </select>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                {@ res}
                                <tr>
                                    <!--<td class="td-check"><input type="checkbox"></td>-->
                                    <td class="td-grade">{? .utype == 1} 일반회원{/}{? .utype == 2} 투자자/창업지원유관기관구성원{/}</td>
                                    <td class="td-grade">{.gname}</td>
                                    <td class="td-name"><a href="/admin_member/add/{.id}">{.name}</a></td>
                                    <td class="td-id">{.ids}</td>
                                    <td class="td-company">{.company}</td>
                                    <td class="td-date">{=str_replace("-", ".", substr(.date_created, 0, 10))}</td>
                                    {? (s.per & settings->permission1) == settings->permission1}
                                    <td class="td-status">
                                        {? .state == 0}
                                        <button type="button" class="btn btn-default btn-xs" onclick="location.href='/admin_member/approve/{.id}'">승인대기</button>
                                        {/}{? .state == 1}
                                        <a href="/admin_member/approve/{.id}"><span class="label label-success">승인</span></a>
                                        {/}{? .state == 2}
                                        <a href="/admin_member/approve/{.id}"><span class="label label-warning">반려</span></a>
                                        {/}{? .state == 3}
                                        <a href="/admin_member/approve/{.id}"><span class="label label-danger">탈퇴</span></a>
                                        {/}
                                    </td>
                                    {:}
                                    <td class="td-status">
                                        {? .state == 0}
                                        <button type="button" class="btn btn-default btn-xs">승인대기</button>
                                        {/}{? .state == 1}
                                        <span class="label label-success">승인</span>
                                        {/}{? .state == 2}
                                        <span class="label label-warning">반려</span>
                                        {/}{? .state == 3}
                                        <span class="label label-danger">탈퇴</span>
                                        {/}
                                    </td>
                                    {/}
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
                                <li><a href="/admin_member/{page - 1}?search={search}&sort={sort}&order={order}&grade_t={grade_t}&grade_e={grade_e}&type=utype&type_e={type_e}">&laquo;</a></li>
                                {/}

                                {@paging.pages}
                                {?.type == "dot"}
                                <li class="disabled"><a href="#">...</a></li>
                                {:}
                                <li {?.type == "current"}class="active"{/}><a href="/admin_member/{.page}?search={search}&sort={sort}&order={order}&grade_t={grade_t}&grade_e={grade_e}&type=utype&type_e={type_e}">{.page}</a></li>
                                {/}
                                {/}

                                {?page == paging.tot_page}
                                <li class="disabled"><a href="#">&raquo;</a></li>
                                {:}
                                <li><a href="/admin_member/{page + 1}?search={search}&sort={sort}&order={order}&grade_t={grade_t}&grade_e={grade_e}&type=utype&type_e={type_e}" >&raquo;</a></li>
                                {/}
                            </ul>
                            <form role="search" class="search" action="/admin_member">
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

<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}
    
$(document).ready(function(){ 
    $("select[name=utype]").change(function() 
    { 
        var _val = $("select[name=utype] option:selected").val();
        document.location.href = "/admin_member?search={search}&sort={sort}&order={order}&grade_t={grade_t}&grade_e={grade_e}&type=utype&type_e="+_val;
    }); 

    $("select[name=state]").change(function() 
    { 
        var _val = $("select[name=state] option:selected").val();
        document.location.href = "/admin_member?search={search}&sort=state&order="+_val+"&grade_t={grade_t}&grade_e={grade_e}&type=utype&type_e={type_e}";
    }); 
    
    $("select[name=grade]").change(function() 
    { 
        var _val = $("select[name=grade] option:selected").val();
        document.location.href = "/admin_member?search={search}&sort={sort}&order={order}&grade_t=grade&grade_e="+_val+"&type=utype&type_e={type_e}";
    }); 
}); 

//]]>
</script>