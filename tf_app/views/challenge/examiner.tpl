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
                                  <li class="active"><a href="/challenge/examiner/{res.id}">심사위원</a></li>
                                  <li><a href="/challenge/operator/{res.id}">운영진</a></li>
                                  <li><a href="/challenge/winner/{res.id}">수상자선정</a></li>
                                  {/}
                                </ul> 
                            </div>
                            <div class="panel-body tab-pane active">
                                
                                <div class="edit-body" id="examinerList">
                                </div> 

                                <br/><br/>
                                <div class="edit-body tab-field">
                                
                                    <ul class="nav nav-tabs">
                                        <li class="active"><a href="#selecting" data-toggle="tab">등록된 심사위원 초대</a></li>
                                        <li><a href="#inviting" data-toggle="tab">외부 심사위원 초대하기</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div class="tab-pane active" id="selecting">
                                            <h5 class="sr-only">심사위원 선정하기</h5>
                                        </div>
                                        <!-- /tab-pane -->
                                        
                                        <div class="tab-pane" id="inviting">
                                            <h5 class="sr-only">심사위원 초대하기</h5>
                                            <br/>
                                            <form class="form-horizontal" role="form" name="invitation_f">
                                                <fieldset>
                                                    <input type="hidden" name="competition_id" value="{res.id}" />
                                                    <div class="form-group">
                                                        <div class="col-xs-12 col-sm-3 col-md-3 control-label">이메일 주소 </div>
                                                        <div class="col-xs-12 col-sm-9 col-md-9">
                                                            <p><button data-target="#md-searchMember" data-toggle="modal" class="btn btn-default" onclick="search_member(); return false;"><span class="icon-user"></span> 회원검색 후 초대하기</button></p>
                                                            <div class="input-group"> <span class="input-group-addon"><span class="icon-envelope-alt"></span></span>
                                                                <input type="text" placeholder="초대할 메일주소를 입력하세요" name="ex_email" class="form-control"> 
                                                            </div>
                                                            <span class="help-block">여러명일 경우에는 콤마(,)로 구분해주세요. </span> </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="col-xs-12 col-sm-3 col-md-3 control-label">초대 메시지</div>
                                                        <div class="col-xs-12 col-sm-9 col-md-9">
                                                            <textarea name="ex_cont" placeholder="심사일정, 심사비, 심사위원 위촉에 관한 인사말 등을 작성해주세요." rows="6" class="form-control"></textarea>
                                                        </div>
                                                    </div>
                                                    <div class="form-group form-submit">
                                                        <div class="col-sm-offset-3 col-md-offset-3">
                                                            <button class="btn btn-default" type="button">취소</button>
                                                            <button class="btn btn-primary" type="submit" onclick="invitation(this); return false;">초대하기</button>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </form>
                                        </div>
                                        <!-- /tab-pane --> 
                                    </div>
                                    <!-- tab-content --> 
                                    
                                </div> 

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
    get_examiner_list('{res.id}');
    function get_examiner_list(_id)
    {
        $('#examinerList .table-responsive').remove();
        $('#examinerList .alert-warning').remove();
        var get_url = '/ajax_v3/get_examiner/'+_id;
        $.get(get_url, function(_data){
            $('#examinerList').html(_data);
        });
    }
    
    function del_examiner(_id)
    {
        del_confirm('del_examiner2('+_id+')');
    }
    
    function del_examiner2(_id)
    {
        var get_url = '/ajax_v3/delete_examiner/'+_id;
        $.get(get_url, function(_data){
            $('#exm_'+_id).remove();
            $('.modal').modal('hide');
        });
    }
    
    get_examiner_pool(1);
    function get_examiner_pool(_page)
    {
        $('#selecting .table-responsive').remove();
        $('#selecting .list-controller').remove();
        var get_url = '/ajax_v3/get_examiner_pool/'+_page+'/{res.id}';
        $.get(get_url, function(_data){
            $('#selecting').append(_data);
        });
    }
    
    function add_examiner(_this)
    {
        var siteset="";
        var c_length = $('input[name=id_con]').length;

        if (c_length > 1) {
            for(var i=0; i < c_length; i++){
                if(document.e_pool_list.id_con[i].checked) {
                    siteset += document.e_pool_list.id_con[i].value + ",";
                }
            }
        }
        else {
            if(document.e_pool_list.id_con.checked) {
                siteset += document.e_pool_list.id_con.value + ",";
            }
        }

        if (siteset == "") {
            $('.modal').modal('hide');
            alert('선택된 위원이 없습니다.');
            return false;
        }
        else {
            $(_this).attr("disabled", "disabled");

            var url = '/ajax_v3/add_examiner/';
            var set_data ={
                "competition_id":'{res.id}',
                "users": siteset.substring(0, siteset.length-1),
                "cont": $('#cont_i').val(),
            };
            //alert(siteset.substring(0, siteset.length-1));
            
            $.post(url, set_data, function(_data){
                $('input[name=id_con]').each(function() {
                    this.checked = false;                        
                });
                $('.modal').modal('hide');
                get_examiner_list('{res.id}');
                get_examiner_pool(1);
                if (_data) alert('이미 선정된 심사위원이 있습니다.');
                $(_this).removeAttr("disabled");
            });
        }       
    }
    
    function invitation (_this)
    {
        $(_this).attr("disabled", "disabled");
        if (!$('input[name=ex_email]').val()) {
            alert("이메일 주소를 입력해주세요.");
            document.invitation_f.ex_email.focus();
            $(_this).show();
            return false;
        }
        
        var url = '/ajax_v3/invitation_email/';
        var set_data = $( "form[name=invitation_f]" ).serialize();

        $.post(url, set_data, function(_data){
            if (_data) {
                alert('유효하지 않은 메일이거나, 이미 초대된 심사원위원 입니다.');
            }
            else {
                alert('초대 메일을 보냈습니다.');
                get_examiner_list('{res.id}');
            }
            $('input[name=ex_email]').val('');
            $('textarea[name=ex_cont]').val('');
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

    function ex_confirm(_this)
    {
        
        var siteset="";
        var c_length = $('input[name=ex_con]').length;

        if (c_length > 1) {
            for(var i=0; i < c_length; i++){
                if(document.ex_list.ex_con[i].checked) {
                    siteset += document.ex_list.ex_con[i].value + ",";
                }
            }
        }
        else {
            if(document.ex_list.ex_con.checked) {
                siteset += document.ex_list.ex_con.value + ",";
            }
        }

        if (siteset == "") {
            alert('선택된 위원이 없습니다.');
            return false;
        }
        
        $(_this).attr("disabled", "disabled");
        var url = '/ajax_v3/examiner_confirm/';
        var set_data ={
            "competition_id":'{res.id}',
            "users": siteset.substring(0, siteset.length-1),
        };
        //alert(siteset.substring(0, siteset.length-1));
        
        $.post(url, set_data, function(_data){
            get_examiner_list('{res.id}');
        });
    }

//]]>
</script>
<!-- modal -->
<div class="modal fade" id="md-examinerInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">심사위원 정보 </h4>
            </div>
            <!-- modal-body -->
            <div class="modal-body">
                <div class="member-info">
                    <div class="row">
                        <div class="col-md-4"> <img src="../img/default-img-member.png" class="img-responsive"> </div>
                        <div class="col-md-8">
                            <dl class="dl-horizontal">
                                <dt>이름</dt>
                                <dd><a href="community-profile.html"><strong>Minjung Shim</strong></a></dd>
                            </dl>
                            <dl class="dl-horizontal">
                                <dt>아이디</dt>
                                <dd>mjush79</dd>
                            </dl>
                            <dl class="dl-horizontal">
                                <dt>이메일</dt>
                                <dd><a href="#">member@company.com</a></dd>
                            </dl>
                            <dl class="dl-horizontal">
                                <dt>전화번호</dt>
                                <dd>010-1234-5678</dd>
                            </dl>
                            <dl class="dl-horizontal">
                                <dt>소속/역할</dt>
                                <dd><a href="#">ALLtoou</a> / 이사</dd>
                            </dl>
                        </div>
                    </div>
                </div>
                <!-- /member-info -->
                
                <div class="member-detail">
                    <dl class="dl-horizontal">
                        <dt>자기소개</dt>
                        <dd>SNMP(Social Network Marketing Platform) 발명가, 기획자, 마켓터 (주)엔비즈닷넷 CMO 청운대학교 MOIT 겸임교수</dd>
                    </dl>
                    <dl class="dl-horizontal">
                        <dt>심사위원 이력</dt>
                        <dd>
                            <ul>
                                <li><a href="#">경진대회명 </a></li>
                                <li><a href="#">경진대회명 </a></li>
                            </ul>
                        </dd>
                    </dl>
                </div>
                <!-- /member-detail --> 
            </div>
            <!-- /modal-body -->
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary">확인</button>
            </div>
        </div>
        <!-- /modal-content --> 
    </div>
    <!-- /modal-dialog --> 
</div>
<!-- /modal --> 

<!-- modal -->
<div class="modal fade" id="md-managerInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div>
<!-- /modal --> 

<!-- modal -->
<div class="modal fade" id="md-managerRefuse" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div>
<!-- /modal --> 

<!-- modal -->
<div class="modal fade" id="md-examinerInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div>
<!-- /modal --> 

<!-- modal #md-searchUser -->
<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="md-searchMember" class="modal fade" style="display: none;">
</div>
<!-- /modal #md-searchUser -->

<!-- modal -->
<div class="modal fade" id="md-inviteExaminer" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">심사위원 선정 초대메일 보내기 </h4>
            </div>
            <!-- modal-body -->
            <div class="modal-body">  
                
                <form class="form-horizontal" role="form">
                    <fieldset>
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">초대 메시지</div>
                            <div class="col-xs-12 col-sm-9 col-md-9">
                                <textarea placeholder="심사일정, 심사비, 심사위원 위촉에 관한 인사말 등을 작성해주세요." rows="6" class="form-control" id="cont_i"></textarea>
                            </div>
                        </div> 
                    </fieldset>
                </form>

            </div>
            <!-- /modal-body -->
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" onclick="add_examiner(this); return false;">초대하기</button>
            </div>
        </div>
        <!-- /modal-content --> 
    </div>
    <!-- /modal-dialog --> 
</div>
<!-- /modal --> 