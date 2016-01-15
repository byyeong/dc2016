<!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section>
                
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-search"></span><span class="break"></span> 필자 검색 및 등록하기</h2> 
                        </div>
                        <!-- /panel-heading -->
                        
                         <div class="panel-body highlight">
                            <form class="col-md-8 col-lg-offset-2" role="search" method="post">
                                <div class="input-group">
                                    <input type="text" value="{q}" required="required" name="q" placeholder="이름, 주민번호앞자리, 핸드폰 번호를 입력한 후 검색하세요" class="form-control">
                                    <span class="input-group-btn">
                                    <button type="submit" class="btn btn-default  ">검색</button>
                                    </span> </div>
                            </form>
                        </div>
                        <!-- /panel-body -->
                        
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th class="td-mem">멤버십여부</th>
                                    <th class="td-name">이름</th>
                                    <th class="td-gender">성별</th>
                                    <th class="td-birth">생년월일</th>
                                    <th class="td-phone">휴대폰번호</th>
                                    <th class="td-company">소속</th>
                                    <th class="td-checkin">필자등록</th>
                                </tr>
                            </thead>
                            <tbody>
                                {@ res}
                                <tr>
                                    <td class="td-mem">{? .membership == 1}<span class="glyphicon glyphicon-ok text-primary"></span>{:}<span class="glyphicon glyphicon-minus text-danger"></span>{/}</td>
                                    <td class="td-name"><a href="/admin_member/add/{.id}">{.name}</a>{? .admin_des}  &nbsp;<span class="glyphicon glyphicon-warning-sign text-warning"></span> {/}</td>
                                    <td class="td-gender">{? .gender == 1}남{/}{? .gender == 2}여{/}</td>
                                    <td class="td-birth">{.birth}</td>
                                    <td class="td-phone">{.tel}</td>
                                    <td class="td-company">{.company}</td>
                                    <td class="td-checkin"><a class="btn btn-default btn-xs" href="#" onclick="add_category_user(this, '{cat}', '{.id}', 0);">등록하기</a></td>
                                </tr>
                                {/}
                            </tbody>
                        </table>
                    </div>
                    <!-- /panel --> 
                    
                    
                    <div class="panel panel-default"  > 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon glyphicon-user"></span><span class="break"></span>등록된 필자</h2>
                        </div>
                        <!-- /panel-heading -->
                        
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th class="td-mem">멤버십여부</th>
                                    <th class="td-name">이름</th>
                                    <th class="td-gender">성별</th>
                                    <th class="td-birth">생년월일</th>
                                    <th class="td-phone">휴대폰번호</th>
                                    <th class="td-company">소속</th>
                                    <th class="td-num">글 수</th>
                                    <th class="td-update">마지막 업데이트</th>
                                    <th class="td-status">관리</th>
                                </tr>
                            </thead>
                            <tbody>
                                {@ res_alr}
                                <tr>
                                    <td class="td-mem">{? .membership == 1}<span class="glyphicon glyphicon-ok text-primary"></span>{:}<span class="glyphicon glyphicon-minus text-danger"></span>{/}</td>
                                    <td class="td-name"><a href="/admin_member/add/{.id}">{.name}</a>{? .admin_des}  &nbsp;<span class="glyphicon glyphicon-warning-sign text-warning"></span> {/}</td>
                                    <td class="td-gender">{? .gender == 1}남{/}{? .gender == 2}여{/}</td>
                                    <td class="td-birth">{.birth}</td>
                                    <td class="td-phone">{.tel}</td>
                                    <td class="td-company">{.company}</td>
                                    <td class="td-num">{.cnt}</td>
                                    <td class="td-update">{.last_con.date_created}</td>
                                    <td class="td-status"><button title="" data-toggle="tooltip" class="btn btn-danger btn-xs" type="button" data-original-title="삭제" onclick="add_category_user(this, '{cat}', '{.id}', 1);"><span class="glyphicon  glyphicon-trash  glyphicon-white"></span></button></td>
                                </tr>
                                {/}
                            </tbody>
                        </table>

                    </div>
                    <!-- /panel --> 
                </section>
                <!-- /section --> 
                
            </div>
            <!-- /contentwrap --> 
            
<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}

function add_category_user(_this, _cat, _id, _del) {
    $(_this).hide();
    var get_url = "/ajax/edit_user_con_cat/"+_cat+"/"+_id+"?del="+_del;
    
    $.get(get_url, function() {
        document.location.href = "/admin_contents/category_edit/{cat}";
    });
}

//]]>
</script>