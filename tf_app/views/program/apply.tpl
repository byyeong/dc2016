
    <!-- rowContent -->
    <div class="rowContent" id="program"> 
        <div class="page-header">
            <div class="container">
                <h2><a href="/program">Benefit</a></h2>
                {? (s.per & settings->permission1) == settings->permission1}
                {? s.ids}
                <button  class="btn btn-primary pull-right" onclick=location.href='/program/edit'><span class="icon-pencil"></span> 프로그램 만들기</button>
                {:}
                <button  class="btn btn-primary pull-right" onclick="javascript:alert('로그인이 필요합니다.');"><span class="icon-pencil"></span> 프로그램 만들기</button>
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
                    <div class="col-xs-12 col-sm-12 col-md-9 content"> 

                        <div class="content-header">
                            <h3 class="content-heading"><span class="icon-edit"></span> 프로그램 신청하기</h3>
                        </div>

                        <div class="applied-item well">
                            <div class="media"> 
                                {? res.img}<a href="/program/views/{res.id}" class="pull-left media-object"><img class="img-responsive" src="{res.img}" ></a>{/}
                                <div class="media-body">
                                    <h4 class="media-heading"><a href="/program/views/{res.id}">{res.title}</a></h4>
                                    <div class="item-status">
                                        <dl class="dl-horizontal">
                                            <dt>지원기관</dt>
                                            <dd>{res.agency} </dd>
                                            <dt>성격</dt>
                                            <dd>{res.category} </dd>
                                            <dt>접수기간</dt>
                                            <dd>
                                                {? res.a_start}
                                                {=substr(res.a_start, 0, 10)} ({=date_to_day_only(substr(res.a_start, 0, 10))}) {=substr(res.a_start, 11)} ~ {=substr(res.a_end, 0, 10)} ({=date_to_day_only(substr(res.a_end, 0, 10))}) {=substr(res.a_end, 11)} &nbsp;
                                                {? date('Y.m.d H:i') < res.a_start}<span class="label label-info">접수 준비</span>&nbsp;{/}
                                                {? date('Y.m.d H:i') > res.a_start && date('Y.m.d H:i') < res.a_end}<span class="label label-primary">접수중</span>&nbsp;{/} 
                                                {? date('Y.m.d H:i') > res.a_end}<span class="label label-warning">접수마감</span>&nbsp;{/}
                                                {:}
                                                상시&nbsp;<span class="label label-primary">접수중</span>
                                                {/}
                                            </dd>
                                            <dt>인원</dt>
                                            <dd>{? res.cnt} {res.cnt}명{:}제한없음{/}</dd>
                                            <dt>담당자</dt>
                                            <dd>{? res.tel}{res.tel}&nbsp;{/}{res.addr}</dd>
                                        </dl>
                                    </div>
                                </div>
                            </div>
                        </div> 
                            
                        
                        <!-- editor -->
                        <div class="editor">
                            <div class="edit-body">
                                {? (date('Y.m.d H:i') > res.a_start && date('Y.m.d H:i') < res.a_end) || pre || !res.a_start}
                                 
                                    <form  role="form" name="apply_f" action="/program/save_apply" method="post" enctype="multipart/form-data" onsubmit="return false;">
                                    <input type="hidden" name="program_id" value="{res.id}" />
                                    <input type="hidden" name="user_id" value="{per.user_id}" />
                                    <input type="hidden" name="id" value="{per.id}" />
                                    <input type="hidden" id="up_file" value="0" />

                                    <div>
                                        {? (res.basic & 1) == 1}
                                        <div class="form-group"> 
                                            <label class="control-label">
                                                참가자 이름
                                            </label><span class="text-danger"> *</span>
                                            <input type="text" class="form-control" name="f_name" value="{per.f_name}" placeholder="이름(실명)을 입력해주세요."> 
                                        </div>
                                        <!-- / form-group-->
                                        {/}
                                        {? (res.basic & 2) == 2}
                                        <div class="form-group"> 
                                            <label class="control-label">
                                                휴대폰 번호
                                            </label><span class="text-danger"> *</span>
                                            <input type="text" class="form-control" name="f_tel" value="{per.f_tel}" placeholder="연락가능한 휴대폰 번호를 입력해주세요."> 
                                        </div>
                                        <!-- / form-group-->
                                        {/}
                                        {? (res.basic & 4) == 4}
                                        <div class="form-group"> 
                                            <label class="control-label">
                                                이메일 주소 
                                            </label><span class="text-danger"> *</span>
                                            <input type="text" class="form-control" name="f_email" value="{per.f_email}" placeholder="정보메일을 받을 수 있는 이메일을 입력해주세요."> 
                                        </div>
                                        <!-- / form-group-->
                                        {/}
                                        {? (res.basic & 8) == 8}
                                        <div class="form-group"> 
                                            <label class="control-label">
                                                간단한 자기소개
                                            </label><span class="text-danger"> *</span>
                                            <textarea rows="3" class="form-control" name="f_des" placeholder="간단한 자기소개를 해주세요.">{per.f_des}</textarea>
                                        </div>
                                        <!-- / form-group-->
                                        {/}
                                        {? (res.basic & 16) == 16}
                                        <div class="form-group"> 
                                            <label class="control-label">
                                                팀 소개
                                            </label><span class="text-danger"> *</span>
                                            <textarea rows="3" class="form-control" name="f_t_des"placeholder="팀 소개를 해주세요.">{per.f_t_des}</textarea>
                                        </div>
                                        <!-- / form-group-->
                                        {/}
                                        {? (res.basic & 32) == 32}
                                        <div class="form-group" id="f_t"> 
                                            <label class="control-label">
                                                참가회사 / 팀명
                                            </label><span class="text-danger"> *</span>
                                            {? st}
                                            <select class="form-control" name="f_team" onchange="get_startup_ch(); return false;">
                                                {@ st}
                                                <option value="{.sname}" rel="{.startup_id}" {? per.f_team == .sname}selected="selected"{/}>{.sname} </option>
                                                {/}
                                            </select>
                                            {:}
                                            <input type="text" class="form-control" name="f_team" value="{per.f_team}" placeholder="참가회사 / 팀명을 입력해주세요.">
                                            {/}
                                        </div>
                                        <!-- / form-group-->
                                        {/}
                                        {? (res.basic & 64) == 64}
                                        <div class="form-group" id="f_s"> 
                                            <label class="control-label">
                                                제품/서비스명
                                            </label><span class="text-danger"> *</span>
                                            <input type="text" class="form-control" name="f_service" value="{per.f_service}" placeholder="제품 / 서비스명을 입력해주세요.">
                                        </div>
                                        <!-- / form-group-->
                                        {/}
                                        {? (res.basic & 128) == 128}
                                        <div class="form-group" id="f_s_d"> 
                                            <label class="control-label">
                                                제품/서비스 한 줄 소개
                                            </label><span class="text-danger"> *</span>
                                            <input type="text" class="form-control" name="f_s_des" value="{per.f_s_des}" placeholder="준비하고 계시는 제품/서비스를 한 문장(50자 이내)으로 소개시켜 주세요."> 
                                        </div>
                                        <!-- / form-group-->
                                        {/}

                                        {? res.forms}
                                        {@ res.forms}
                                        {? .type == 'text'}
                                        <div class="form-group">
                                            <div class="control-label">{.title} {? .required}<span class="text-danger">*</span>{/}</div>
                                            <p class="help-block">{.sub}</p>
                                            <input type="text" class="form-control" name="form{.id}" value="{.ress}">
                                        </div>
                                        {/}
                                        {? .type == 'textarea'}
                                        <div class="form-group">
                                            <div class="control-label">{.title} {? .required}<span class="text-danger">*</span>{/}</div>
                                            <p class="help-block">{.sub}</p>
                                            <textarea rows="5" class="form-control" name="form{.id}">{.ress}</textarea>
                                        </div>
                                        {/}
                                        {? .type == 'query'}
                                        <div class="form-group">
                                            <div class="control-label">{.title} {? .required}<span class="text-danger">*</span>{/}</div>
                                            <p class="help-block">{.sub}</p>
                                            <ul class="list-unstyled">
                                                {@ .opts}
                                                <li class="radio">
                                                    <label>
                                                        <input type="radio" name="form{.id}" value="{..key_ + 1}" {? .ress == ..key_ + 1}checked="checked"{/}>
                                                        {..value_} </label>
                                                </li>
                                                {/}
                                            </ul>
                                        </div>
                                        {/}
                                        {/}
                                        {/}

                                    </div>

                                    {? res.form_file}
                                    {@ res.form_file}
                                    <div class="form-group">
                                        <div class="control-label">{.title} (8MB까지 가능){? .req}<span class="text-danger">*</span>{/}</div>
                                        {? .sub}<p class="help-block">{.sub}</p>{/}
                                        {? .val}
                                        <a href="/program/get_source?aid={per.id}&fid={.fid}">[업로드된 파일 다운로드]</a>
                                        {/}
                                        <div class="file">
                                            <input type="file" name="file_{.id}" onchange="limit_upload(this); return false;" style="display: inline;">
                                            <img src="/img/common/ajax-large-loader.gif" style="display: none;">
                                        </div>
                                        <input type="hidden" name="o_file_{.id}" value="{.val}" />
                                    </div>
                                    <!-- / form-group-->
                                    {/}
                                    {/}

                                    <br/>
                                    <div class="form-group">
                                        <div class="control-label">개인정보 3자 제공 동의<span class="text-danger">*</span></div>
                                        <div class="well" style="padding: 5px;">
                                            <p class="help-block">&nbsp;참가신청 시 입력하신 정보는 프로그램의 혜택 제공을 위하여 아래와 같이 제공됩니다.</p>
                                            <p class="help-block">&nbsp;&nbsp;- 제공받는 자 : 서비스 제공사</p>
                                            <p class="help-block">&nbsp;&nbsp;- 개인정보 이용 목적 : Benefit(스타트업 지원 프로그램) 혜택 제공</p>
                                            <p class="help-block">&nbsp;&nbsp;- 제공하는 개인정보 항목 : 이름, 연락처, 이메일 주소</p>
                                            <p class="help-block">&nbsp;&nbsp;- 개인정보 보유기간 : 회원탈퇴 시 또는 프로그램 이용 종료시까지 </p>
                                        </div>
                                        <input type="checkbox" name="check" style="margin: 10px 0 0;" > 개인정보 제공에 동의합니다.
                                    </div>
                                    
                                    {? !pre}
                                    <div class="form-actions text-center">
                                        <button type="button" class="btn btn-default" onclick="location.href='/program/views/{res.id}'">취소</button>
                                        <button type="button" id="sub_btn" class="btn btn-primary" onclick="go_apply(this); return false;">접수하기</button>
                                        {? per.id && per.user_id == s.id}
                                        <span class="pull-right"><a class="btn btn-warning" href="#" onclick="del_confirm('del_apply()'); return false;">신청 삭제</a> </span>
                                        {/}
                                    </div> 
                                    {/}
                                    <input type="hidden" id="f_ing" value="" />
                                </form>
                                {:}

                                {? date('Y.m.d H:i') < res.a_start}
                                 <div class="alert alert-info text-center">
                                     <span class="icon-warning-sign"></span>접수 준비 중입니다. 
                                </div>
                                {:}
                                {? !s}
                                <div class="alert alert-info text-center">
                                    <p>D.CAMP 회원이시면 누구나 신청 가능 합니다. 로그인 해주세요. ^^</p>
                                    <a class="btn btn-default btn-sm" href="/login">로그인하기</a>
                                </div>
                                {:}
                                <div class="alert alert-info text-center">
                                    <p>참가신청이 마감되었습니다. 결과 발표를 준비 중 입니다.</p>
                                    <a class="btn btn-default btn-sm" href="/program">경진대회 리스트 보기</a>
                                </div>
                                {/}
                                {/}

                                {/}
                            

                            </div>
                        </div>
                        <!-- /editor --> 
                        
                        
                    </div>
                    <!-- / content -->
                    
                    
                    {? sub}
                    <div class="col-xs-12 col-sm-12 col-md-3 sidebar">
                        <div class="panel recentporst">
                            <h3 class="panel-title">Recent Program</h3>
                            <ul class="media-list post-list">
                                {@ sub}
                                <li class="media">
                                    {?.img}<a class="pull-left media-object" href="/program/views/{.id}"> <img src="{.img}" class="img-responsive"> </a>{/}
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/program/views/{.id}"> {.title}</a></h4>
                                        <div class="media-meta"> <span class="icon-calendar"></span> {=substr(.a_start, 0, 10)} ({=date_to_day_only(substr(.a_start, 0, 10))}) ~ {=substr(.a_end, 0, 10)} ({=date_to_day_only(substr(.a_end, 0, 10))}) </div>
                                    </div>
                                </li>
                                 {/}
                            </ul>
                        </div>
                        <!-- /panel--> 
                    </div>
                    <!-- / sidebar --> 
                    {/}
                    
                    
                </div>
                <!-- row --> 
            </div>
            <!-- /container --> 
        </div>
        <!-- /page-content --> 
        <form  role="form" name="upload_f" method="post" enctype="multipart/form-data"></form>
    </div>
    <!-- /rowContent --> 
<script type="text/javascript">
//<![CDATA[
    function go_apply(_this)
    {
        var _error = 0;

        $( ".text-danger" ).each(function( index ) {
            domElement = $( this ).parent().parent().find("input");
            if (domElement.attr("type")=== 'text') {
                if (domElement.val() === '') {
                   _error = 1;
                    var _ti = $( this ).parent().text();
                    alert(_ti + " 항목에 값을 입력해주세요."); 
                    var _n = domElement.attr("name");
                    $(this).focus();
                    return false;
                }
            }
            else if (domElement.attr("type") === 'radio') {
                if($(':radio[name="'+domElement.attr("name")+'"]:checked').length < 1){
                    _error = 1;
                    var _ti = $( this ).parent().text();
                    alert(_ti + " 항목에 값을 체크해주세요."); 
                    $(this).focus();
                    return false;
                }
            }
            else if (domElement .attr("type") === 'file') {
                var o_f = domElement .attr("name");

                if ($('input[name=o_'+o_f+']').val() == '' && domElement.val() === '') {
                    _error = 1;
                    var _ti = $( this ).parent().text();
                    alert(_ti + " 항목에 파일을 선택해주세요."); 
                    $(this).focus();
                    return false;
                }
            }  
            else {
                domElement = $( this ).parent().parent().find("textarea");
                if (domElement.val() === '') {
                    _error = 1;
                    var _ti = $( this ).parent().text();
                    alert(_ti + " 항목에 값을 입력해주세요."); 
                    $(this).focus();
                    return false;
                }
            }

        });

        if ($('#f_ing').val() == 1) {
            _error = 1;
            alert("첨부 파일은 8MB까지 업로드 가능합니다. 파일을 확인해주세요."); 
            return false;
        }   

        if (!$('input[name=check]').is(':checked')) {
            _error = 1;
            alert("개인정보 제공에 동의해주세요.");
            return false;
        }

        if (_error == 1) {
            return false;
        }

        $(_this).hide();
        $("input:text,input:hidden").each(function(){
            $(this).attr("value", this.value);
        });
        $("textarea").each(function(){
            $(this).text(this.value);
        });
        $("input:radio:checked,input:checkbox:checked").each(function() {
            $(this).attr('checked', 'checked');
        });
        $("option:selected").each(function() {
            $(this).attr('selected', 'selected');
        });
    

        var frm = document.apply_f;
        frm.submit();
        
    }

    function del_apply()
    {
        window.location.href="/program/apply/{res.id}/{per.id}?req=del";
    }

    function get_startup_ch(_id) {
        var set_data ={
            "id"      : $("select[name=f_team] option:selected").attr('rel')
        };

        $.ajax({
            type : 'POST',
            data : set_data,
            url : '/ajax_v3/get_startup/',
            success : function(_data) {
                $('#f_s').html('');
                $('#f_s').html(_data);
                
                {? !per.id}
                get_service_ch($("select[name=f_service] option:selected").attr('rel'));
                {/}

                {? per.f_service}
                $("select[name=f_service]").val("{per.f_service}").attr("selected", "selected");
                {/}
            }
        });
    }

    function get_service_ch() {
        _id = $("select[name=f_service] option:selected").attr('rel');
        $.ajax({
            type : 'GET',
            dataType : 'json',
            url : '/ajax_v3/get_service_des/' + _id,
            success : function(_data) {
                if (_data) {
                    {? !per.f_s_des}
                    $('input[name=ser_id]').val(_id);
                    $('input[name=f_s_des]').val(_data.des_ele);
                    {/}
                }
            }
        });
    }

    {? st}
        get_startup_ch($("select[name=f_team] option:selected").attr('rel'));
    {/}

//]]>
</script>