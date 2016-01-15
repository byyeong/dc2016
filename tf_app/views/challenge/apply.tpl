
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
                    <div class="col-xs-12 col-sm-12 col-md-9 content"> 

                        <div class="content-header">
                            <h3 class="content-heading"><span class="icon-edit"></span> 경진 대회 참가 신청하기</h3>
                        </div>

                        <div class="applied-item well">
                            <div class="media"> 
                                {? res.img}<a href="/challenge/views/{res.id}" class="pull-left media-object"><img class="img-responsive" src="{res.img}" ></a>{/}
                                <div class="media-body">
                                    <h4 class="media-heading"><a href="/challenge/views/{res.id}">{res.subject}</a></h4>
                                    <div class="item-status">
                                        <dl class="dl-horizontal">
                                            <dt>주최/주관</dt>
                                            <dd><a href="/member/{res.ids}">{res.name}</a>{? res.organized}/{res.organized}{/} </dd>
                                            <dt>참가기간</dt>
                                            <dd>{res.date_s} ({=date_to_day_only(res.date_s)}) {res.time_s} ~ {res.date_e} ({=date_to_day_only(res.date_e)}) {res.time_e} &nbsp;
                                                {? date('Y.m.dH:i') < res.sdate}<span class="label label-info">접수 준비</span>{/} &nbsp;
                                                {? date('Y.m.dH:i') > res.sdate && date('Y.m.dH:i') < res.edate}<span class="label label-primary">접수중</span>{/}  &nbsp;
                                                {? date('Y.m.dH:i') > res.edate}<span class="label label-warning">접수마감</span>{/}  &nbsp;
                                                {? date('Y.m.dH:i') > res.announce && res.winner}<span class="label label-default">수상자 발표</span>{/}
                                            </dd>
                                            <dt>발표일자</dt>
                                            <dd>{res.announce_d} ({=date_to_day_only(res.announce_d)}) {res.announce_t}</dd>
                                        </dl>
                                    </div>
                                </div>
                            </div>
                        </div> 
                            
                        
                        <!-- editor -->
                        <div class="editor">
                            <div class="edit-body">
                                {? (date('Y.m.dH:i') > res.sdate && date('Y.m.dH:i') < res.edate) || pre}
                                 
                                    <form  role="form" name="apply_f" action="/challenge/save_apply/{res.id}/{per.id}" method="post" enctype="multipart/form-data" onsubmit="return false;">
                                    <input type="hidden" name="competition_id" value="{res.id}" />
                                    <input type="hidden" name="user_id" value="{per.user_id}" />
                                    <input type="hidden" name="id" value="{per.id}" />
                                    <input type="hidden" name="status" value="0" />
                                    <input type="hidden" name="form" value="" />
                                    <input type="hidden" id="up_file" value="0" />
                                    {? res.form}
                                    <div class="form-group">
                                        <div class="control-label">참가자 이름 <span class="text-danger">*</span></div>
                                        <input type="text" class="form-control" value="{? per.name}{per.name}{:}{s.name}{/}" disabled>
                                    </div>
                                    <!-- / form-group-->
                                    <div class="form-group">
                                        <div class="control-label">참가 회사/팀 <span class="text-danger">*</span></div>
                                        <input type="text" class="form-control" name="team" value="{per.team}" onkeyup="">
                                    </div>

                                    <br />
                                    <div id="form_cont">
                                        {? per.form}{=str_replace('pull-right', 'pull-right" style="display: none;', str_replace("\'","'",per.form))}
                                        {:}{=str_replace('pull-right', 'pull-right" style="display: none;', str_replace("ui-state-default","",str_replace("disabled","",str_replace('<i class="icon-move pull-left"></i>','',str_replace('<li',"<div",str_replace("</li","</div",str_replace("\'","'",res.form)))))))}
                                        {/}
                                    </div>
                                    {:}
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
                                    {/}

                                    {? res.form_file}
                                    {@ res.form_file}
                                    <br />
                                    <div class="form-group">
                                        <div class="control-label">{.title} (8MB까지 가능){? .req}<span class="text-danger">*</span>{/}</div>
                                        {? .sub}<p class="help-block">{.sub}</p>{/}
                                        {? .val}
                                        <a href="/challenge/get_source?cp={res.id}&file={.val}">[업로드된 파일 다운로드]</a>
                                        {/}
                                        <div class="file">
                                            <input type="file" name="file_{.id}" onchange="limit_upload(this); return false;" style="display: inline;">
                                            <img src="/img/common/ajax-large-loader.gif" style="display: none;">
                                        </div>
                                        <input type="hidden" name="o_file_{.id}" value="{.val}" />
                                    </div>
                                    {/}
                                    {/}
                                    <!-- / form-group-->
                                    {? !pre}
                                    <div class="form-actions text-center">
                                        <button type="button" class="btn btn-default" onclick="location.href='/challenge/views/{res.id}'">취소</button>
                                        <button type="button" id="sub_btn" class="btn btn-primary" onclick="go_apply(this); return false;">참가 접수하기</button>
                                        {? per && per.user_id == s.id && s.id}
                                        <span class="pull-right"><a class="btn btn-warning" href="#" onclick="del_confirm('del_apply()'); return false;">참가신청 삭제</a> </span>
                                        {/}
                                    </div> 
                                    {/}
                                    <input type="hidden" id="f_ing" value="" />
                                </form>
                                {:}

                                {? date('Y.m.dH:i') < res.sdate}
                                 <div class="alert alert-info text-center">
                                     <span class="icon-warning-sign"></span>접수 준비 중입니다. 
                                </div>
                                {:}
                                <div class="alert alert-info text-center">
                                    <p>참가신청이 마감되었습니다. 결과 발표를 준비 중 입니다.</p>
                                    <a class="btn btn-default btn-sm" href="/challenge">경진대회 리스트 보기</a>
                                </div>
                                {/}

                                {/}
                            

                            </div>
                        </div>
                        <!-- /editor --> 
                        
                        
                    </div>
                    <!-- / content -->
                    
                    
                    {? sub}
                    <div class="col-xs-12 col-sm-12 col-md-3 sidebar">
                        <!-- panel -->
                        <div class="panel recentporst">
                            <h3 class="panel-title">Recent Challenge</h3>
                            <ul class="media-list post-list">
                                {@ sub}
                                <li class="media">
                                    <a class="pull-left media-object" href="/challenge/views/{.id}"> <img src="{?.img}{.img}{:}/img/default-img-news.png{/}" class="img-responsive"> </a>
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/challenge/views/{.id}"> {.subject}</a></h4>
                                        <div class="media-meta"> <!--span class="icon-trophy"></span> {.name} &nbsp;&nbsp;  --><span class="icon-calendar"></span> {.date_s} ({=date_to_day_only(.date_s)}) {.time_s} ~ {.date_e} ({=date_to_day_only(.date_e)}) {.time_e} </div>
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
        frm.form.value = $('#form_cont').html();
        frm.submit();
        
    }

    function del_apply()
    {
        window.location.href="/challenge/apply/{res.id}/{per.id}?req=del";
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
                
                {? !res.id}
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

    {? st && !per.f_service}
        get_startup_ch($("select[name=f_team] option:selected").attr('rel'));
    {/}

//]]>
</script>