
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-edit"></span><span class="break"></span>경진대회 작성하기</h2>
                            <div class="actions"> <span class="break"></span> <a title="목록보기" data-toggle="tooltip" href="/admin_challenge"><span class="glyphicon  glyphicon-align-justify"></span></a> </div>
                        </div>
                        <!-- /panel-heading -->
                        
                        <div class="panel-heading">
                            <!--ol data-progtrckr-steps="7" class="stepProgress">
                                <li class="{? step > 0}step-done{:}step-todo{/}">정보입력</li>
                                <li class="{? step > 1}step-done{:}step-todo{/}">승인받기</li>
                                <li class="{? step > 2}step-done{:}step-todo{/}">세부정보 설정</li>
                                <li class="{? step > 3}step-done{:}step-todo{/}">접수준비</li>
                                <li class="{? step > 4}step-done{:}step-todo{/}">접수중</li>
                                <li class="{? step > 5}step-done{:}step-todo{/}">접수마감</li>
                                <li class="{? step > 6}step-done{:}step-todo{/}">수상자 발표</li>
                            </ol-->

                            <ul class="nav nav-tabs">
                                <li><a href="/admin_challenge/edit/{res.id}">{? res}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}신청 정보 입력</a></li>
                                {? res.status == 1}
                                <li><a href="/admin_challenge/edit_next/{res.id}">{? res.announce_d}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}대회 정보 입력</a></li>
                                <li><a href="/admin_challenge/apply_info/{res.id}">{? for}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}지원서 만들기</a></li>
                                <li><a href="/admin_challenge/score_info/{res.id}">{? sco}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}평가지 만들기</a></li>
                                <li class="active"><a href="/admin_challenge/operator/{res.id}">{? op}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}운영진 초대</a></li>
                                <li><a href="/admin_challenge/examiner/{res.id}">{? exn}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}심사위원 초대</a></li>
                                <li><a href="/admin_challenge/winner/{res.id}">{? res.winner}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}수상자 선정</a></li>
                                {/}
                            </ul>
                        </div>
                        
                        <div class="panel-body" id="edit-managerList">
                            <h4><span class="icon-user"></span> 경진대회 운영진</h4>
                            {? list}
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th class="td-name">이름</th> 
                                            <th class="td-group">소속</th>
                                            <th class="td-history">운영진 이력</th>
                                            <th class="td-info">운영진 정보 </th> 
                                            <th class="td-manage">관리</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {@ list}
                                        <tr>
                                            <td class="td-name"><a href="#" onclick="view_examiner('{.user_id}'); return false;">{.name}</a></td>                                             
                                            <td class="td-group"><a href="#">{.com.name}</a></td>
                                            <td class="td-history"><a href="#" onclick="view_examiner('{.user_id}'); return false;">{.comp}</td>
                                            <td class="td-info"> <a href="#" onclick="view_examiner('{.user_id}'); return false;" class="btn btn-default btn-xs">정보보기</a></td> 
                                            <td class="td-manage"><button onclick="del_operator('{.competition_id}','{.user_id}'); return false;" data-toggle="tooltip" class="btn btn-danger btn-xs" type="button" title="" data-original-title="삭제" aria-describedby="tooltip827632"><span class="icon-fixed-width icon-trash"></span></button></td>
                                        </tr>
                                        {/}
                                    </tbody>
                                </table>
                            </div>
                            <!-- /table -->
                            {:}
                            <div class="alert alert-warning">선정된 심사위원이 없습니다. 아래의 목록에서 심사위원을 선정하거나 초대해주세요.</div>
                            {/} 
                        </div>
                        <!-- /edit-body -->
                        
                        <div class="panel-body">
                            <h4><span class="icon-user"></span> 운영진 초대하기</h4>
                            <div class="well">
                                <form class="form-horizontal" role="form" onsubmit="return false;"  name="invitation_f">
                                    <fieldset>
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">이메일 주소 </div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <p><button class="btn btn-default" data-toggle="modal" data-target="#md-searchMember" onclick="search_member(); return false;"><span class="icon-user"></span> 회원검색 후 초대하기</button></p>
                                                <div class="input-group"> <span class="input-group-addon"><span class="icon-envelope-alt"></span></span>
                                                    <input type="text" class="form-control" placeholder="여러명일 경우에는 콤마(,)로 구분해주세요."  name="ex_email"> 
                                                </div>
                                                <span class="help-block">경진대회 운영진 권한은 D.CAMP에 가입된 사용자에게만 줄 수 있습니다. 가입을 먼저 요청하세요.</span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">초대 메시지</div>
                                            <div class="col-xs-12 col-sm-9 col-md-9">
                                                <textarea placeholder="초대 메세지를 작성해 주세요. " row="3" class="form-control"  name="ex_cont"></textarea>
                                            </div>
                                        </div>
                                        <div class="col-sm-offset-3 col-md-offset-3">
                                            <button class="btn btn-default" type="button">취소</button>
                                            <button class="btn btn-primary" type="submit" onclick="invitation(this); return false;">초대하기</button>
                                        </div>
                                        <input type="hidden" name="competition_id" value="{res.id}" />
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                        <!--/panel-body -->
                        </form>
                    </div>
                    <!-- /panel --> 
                    
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 
    
<script type="text/javascript">
//<![CDATA[

    function get_operator_list(_id)
    {
        var get_url = '/ajax_v3/get_operator/'+_id;
        $.get(get_url, function(_data){
            $('#edit-managerList').html(_data);
        });
    }

    function del_operator(_cid, _uid)
    {
        del_confirm('del_operator2('+_cid+', '+_uid+')');
    }
    
    function del_operator2(_cid, _uid)
    {
        var get_url = '/ajax_v3/delete_operator/'+_cid+'/'+_uid;
        $.get(get_url, function(_data){
            $('#opr_'+_uid).remove();
            $('.modal').modal('hide');
        });
    }
    
    function invitation (_this)
    {
        $(_this).attr("disabled", "disabled");
        if (!$('input[name=ex_email]').val()) {
            alert("회원검색을 통해 이메일을 입력해주세요.");
            document.invitation_f.ex_email.focus();
            $(_this).show();
            return false;
        }
        
        var url = '/ajax_v3/invitation_operator/';
        var set_data = $( "form[name=invitation_f]" ).serialize();

        $.post(url, set_data, function(_data){
            if (_data) {
                alert('이미 등록된 운영진이거나, 등록되지 않은 이메일 입니다.');
            }
                
            else {
                alert('초대 메일을 보냈습니다.');
                $('input[name=ex_email]').val('');
                $('textarea[name=ex_cont]').val('');
                
                get_operator_list('{res.id}');
            }
            $(_this).removeAttr("disabled");
        });
    }
    
    function view_examiner(_id)
    {
        var url = '/ajax_v3/get_examiner_per/'+_id;
        $.get(url, function(_data){
            $('#md-examinerInfo').html('');
            $('#md-examinerInfo').append(_data);
            $('#md-examinerInfo').modal('show');
        });
    }

    function search_member()
    {
        $('#md-searchMember').html('');
        var url = '/ajax_front/get_member_list/';
        $.get(url, function(_data){
            $('#md-searchMember').append(_data);
        });
    }

    function search_member_q()
    {
        var url = '/ajax_front/get_member_list_q/';
        var set_data ={
            "q":$('input[name=q]').val(),
        };
        $.post(url, set_data, function(_data){
            $('#md-searchMember .search-result').html('');
            $('#md-searchMember .search-result').append(_data);
        });
    }

    function set_email(_email)
    {
        $('#md-searchMember').modal('hide');
        var _e_email = $('input[name=ex_email]').val();
        if (_e_email !== '')
            $('input[name=ex_email]').val(_e_email +", "+ _email);
        else 
            $('input[name=ex_email]').val(_email);
    }
//]]>
</script>
<!-- modal -->
<div class="modal fade" id="md-examinerInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div>
<!-- /modal --> 

<!-- modal -->
<div class="modal fade" id="md-managerInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div>
<!-- /modal --> 

<!-- modal -->
<div class="modal fade" id="md-examinerInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div>
<!-- /modal --> 

<!-- modal #md-searchUser -->
<div class="modal fade" id="md-searchMember" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div>
<!-- /modal #md-searchUser -->