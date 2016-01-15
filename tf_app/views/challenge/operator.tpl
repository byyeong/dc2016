 <!-- rowContent -->
    <div class="rowContent" id="competition"> 
        <div class="page-header">
            <div class="container">
                <h2><a href="/challenge">Challenge</a></h2>
                {? (s.per & settings->permission1) == settings->permission1}
                {? s.ids}
                <button  class="btn btn-primary pull-right" onclick=location.href='/challenge/edit'><span class="icon-pencil"></span> 경진대회 만들기</button>
                {:}
                <button  class="btn btn-primary pull-right" onclick="javascript:alert('로그인이 필요합니다.');"><span class="icon-pencil"></span> 경진대회 만들기</button>
                {/}
                {/}
            </div>
        </div>
        <!-- /page-header -->
        
        <!-- page-content -->
        <div class="page-content"> 
            <!-- container -->
            <div class="container">
                <div  class="row"> 
                    <!-- content -->
                    <div class="col-xs-12 col-sm-12 col-md-9 content editor">
                        
                        <div class="content-header">
                            <h3 class="content-heading"><a href="/member/edit_challenge_m">Challenge 관리</a> > 대회 운영 현황</h3> 
                        </div>
                        
                        
                        <div class="well applied-item">
                            <div class="media">
                                {? res.img}<a href="/challenge/views/{res.id}" class="pull-left media-object"><img class="img-responsive" src="{res.img}" ></a>{/}
                                <div class="media-body">
                                    <h4 class="media-heading"><a href="/challenge/views/{res.id}">{res.subject}</a></h4>
                                    <div class="item-status">
                                        <dl class="dl-horizontal ">
                                            <dt>주최/주관</dt>
                                            <dd><a href="/member/{res.ids}">{res.name}</a>{? res.organized}/{res.organized}{/} </dd>
                                            <dt>참가기간</dt>
                                            <dd>{=date_to_kr(res.date_s)} ~ {=date_to_kr(res.date_e)} 
                                                {? date('Y.m.dH:i') < res.sdate}<span class="label label-info">접수 준비</span>{/}
                                                {? date('Y.m.dH:i') > res.sdate && date('Y.m.dH:i') < res.edate}<span class="label label-primary">접수중</span>{/} 
                                                {? date('Y.m.dH:i') > res.edate}<span class="label label-warning">접수마감</span>{/} 
                                                {? date('Y.m.dH:i') > res.announce && res.winner}<span class="label label-default">수상자 발표</span>{/}
                                            </dd>
                                            <dt>발표일자</dt>
                                            <dd>{=date_to_kr(res.announce_d)}</dd>
                                            {? (res.user_id == s.id) || op}
                                            <dt>공개여부</dt>
                                            <dd>
                                                <select data-width="auto" class="selectpicker" name="open" onchange="change_status_cm(this, '{res.id}'); return false;">
                                                    <option value="1" {? res.open}selected="selected"{/}>공개</option>
                                                    <option value="0" {? !res.open}selected="selected"{/}>비공개</option>
                                                </select>
                                            </dd>
                                            {/}
                                        </dl>
                                    </div>
                                </div>
                                {? (res.user_id == s.id) || op}
                                <div class="list-controller pull-right">
                                    <a href="/challenge/edit/{res.id}" class="btn btn-primary btn-sm">세부정보 설정하기</a>
                                </div>
                                {/}
                            </div>
                            <!-- /media -->
                        </div>
                        <!-- /applied-item -->

                        <ol data-progtrckr-steps="7" class="stepProgress">
                            <li class="{? step > 0}step-done{:}step-todo{/}">정보입력</li>
                            <li class="{? step > 1}step-done{:}step-todo{/}">승인받기</li>
                            <li class="{? step > 2}step-done{:}step-todo{/}">세부정보 설정</li>
                            <li class="{? step > 3}step-done{:}step-todo{/}">접수중</li>
                            <li class="{? step > 4}step-done{:}step-todo{/}">접수마감</li>
                            <li class="{? step > 5}step-done{:}step-todo{/}">수상자 발표</li>
                        </ol>
                        
                        {? date('Y.m.dH:i') < res.sdate}
                        <div class="alert alert-info text-center">
                            <span class="icon-warning-sign"></span> 대회 시작 전입니다.
                        </div>
                        {/}
                        <!--  applied-list  -->
                        <div class="applied-list panel panel-default tab-content"> 
                            <div class="panel-heading">
                                <!--<h3 class="panel-title"><span class="icon-fixed-width  icon-check "></span>참가자 현황</h3>-->
                                {? (res.user_id == s.id) || op}<a class="pull-right btn btn-default btn-xs" href="/challenge/examine_excel/{res.id}">심사 현황 다운로드</a>
                                {? res.id > 134}<a class="pull-right btn btn-default btn-xs" href="/challenge/applied_files/{res.id}">지원서 첨부파일</a>{/}
                                <a class="pull-right btn btn-default btn-xs" href="/challenge/applied_excel/{res.id}">지원서 내역 다운로드</a>{/}
                                <ul class="nav nav-tabs">
                                  <li><a href="/challenge/applied_list/{res.id}?tab=dashboard">경진대회 진행 현황</a></li>
                                  <li><a href="/challenge/applied_list/{res.id}">참가자 현황</a></li>
                                  {? (res.user_id == s.id) || op}
                                  <li><a href="/challenge/examiner/{res.id}">심사위원</a></li>
                                  <li class="active"><a href="/challenge/operator/{res.id}">운영진</a></li>
                                  <li><a href="/challenge/winner/{res.id}">수상자선정</a></li>
                                  {/}
                                </ul> 
                            </div>
                            <div class="panel-body tab-pane active">
                    
                                <div class="edit-body" id="edit-managerList">
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
                                                <tr id="opr_{.user_id}">
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
                                    <div class="alert alert-warning">선정된 심사위원이 없습니다. 아래의 목록에서 심사위원을 선정하거나 초대해주세요.<br/>운영진을 초대하면 개설자와 동일하게 Challenge를 관리할 수 있습니다.</div>
                                    {/} 
                                </div>
                                <!-- /edit-body -->

                                <div class="edit-body" id="edit-invite">
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
                                                        <span class="help-block">경진대회 운영진 권한은 D.CAMP에 가입된 사용자에게만 줄 수 있습니다. 가입을 먼저 요청하세요.<br/>운영진을 초대하면 개설자와 동일하게 Challenge를 관리할 수 있습니다.</span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-xs-12 col-sm-3 col-md-3 control-label">초대 메시지</div>
                                                    <div class="col-xs-12 col-sm-9 col-md-9">
                                                        <textarea placeholder="초대 메세지를 작성해 주세요.  " row="3" class="form-control"  name="ex_cont"></textarea>
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
                                <!-- /edit-body --> 
                            </div>
                        </div>
                        <!-- /applied-list  --> 
                        
                        
                    </div>
                    <!-- / content -->
                    
                    <div class="col-xs-12 col-sm-12 col-md-3 sidebar">
                    
                        {? m_list}
                        <div class="panel writed-competition">
                            <h3 class="panel-title">개최한 경진대회</h3>
                            <ul class="media-list post-list">
                                {@ m_list}
                                <li class="media"> {? .img}<a href="/challenge/views/{.id}" class="pull-left media-object"> <img class="img-responsive" src="{.img}"> </a>{/}
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/challenge/views/{.id}">{.subject}</a></h4>
                                        <div class="media-meta"> <span class="author"><a href="/member/{.ids}">{.name}</a></span> <span class="time"><span class="icon-time"></span>&nbsp; {=trans_date_ago(.date_created)}</span> </div>
                                    </div>
                                    <!-- /media-content --> 
                                </li>
                                {/}
                            </ul>
                        </div>
                        <!-- /panel -->
                        {/}

                        {? e_list}
                        <div class="panel examined-competition">
                            <h3 class="panel-title">심사위원 위촉 경진대회</h3>
                            <ul class="media-list post-list">
                                {@ e_list}
                                <li class="media"> {? .img}<a href="/challenge/views/{.competition_id}" class="pull-left media-object"> <img class="img-responsive" src="{.img}"> </a>{/}
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/challenge/views/{.competition_id}">{.subject}</a></h4>
                                        <div class="media-meta"> <span class="author"><a href="/member/{.ids}">{.name}</a></span> <span class="time"><span class="icon-time"></span>&nbsp; {=trans_date_ago(.date_created)}</span> </div>
                                    </div>
                                    <!-- /media-content --> 
                                </li>
                                {/}
                            </ul>
                        </div>
                        <!-- /panel -->
                        {/}

                        {? a_list}
                        <div class="panel applied-competition">
                            <h3 class="panel-title">참가한 경진대회</h3>
                            <ul class="media-list post-list">
                                {@ a_list}
                                <li class="media"> {? .img}<a href="/challenge/views/{.cid}" class="pull-left media-object"> <img class="img-responsive" src="{.img}"> </a>{/}
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/challenge/views/{.cid}">{.subject}</a></h4>
                                        <div class="media-meta"> <span class="author"><a href="/member/{.ids}">{.name}</a></span> <span class="time"><span class="icon-time"></span>&nbsp; {=trans_date_ago(.date_created)}</span> </div>
                                    </div>
                                    <!-- /media-content --> 
                                </li>
                                {/}
                            </ul>
                        </div>
                        <!-- /panel -->
                        {/}
                    </div>
                    <!-- / sidebar --> 
                    
                </div>
                <!-- row --> 
            </div>
            <!-- /container --> 
        </div>
        <!-- /page-content --> 
        
    </div>
    <!-- /rowContent --> 
    
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