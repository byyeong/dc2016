
    <!-- rowContent -->
    <div class="rowContent" id="competition"> 
        <div class="page-header">
            <div class="container">
                <h2><a href="/competition">Challenge</a></h2>
                {? (s.per & settings->permission1) == settings->permission1}
                {? s.ids}
                <button  class="btn btn-primary pull-right" onclick=location.href='/competition/edit'><span class="icon-pencil"></span> 경진대회 만들기</button>
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
                                {? res.img}<a href="/competition/views/{res.id}" class="pull-left media-object"><img class="img-responsive" src="{res.img}" ></a>{/}
                                <div class="media-body">
                                    <h4 class="media-heading"><a href="/competition/views/{res.id}">{res.subject}</a></h4>
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
                                {? (date('Y.m.dH:i') > res.sdate && date('Y.m.dH:i') < res.edate)}
                                 
                                    <form  role="form" name="apply_f" action="/competition/apply/{res.id}/{per.id}" method="post" enctype="multipart/form-data" onsubmit="return false;">
                                    <input type="hidden" name="competition_id" value="{res.id}" />
                                    <input type="hidden" name="user_id" value="{s.id}" />
                                    <input type="hidden" name="id" value="{per.id}" />
                                    <input type="hidden" name="status" value="0" />
                                    <input type="hidden" name="form" value="" />
                                    <input type="hidden" id="up_file" value="0" />
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

                                    {? res.form_file}
                                    {@ res.form_file}
                                    <br />
                                    <div class="form-group">
                                        <div class="control-label">{.title} (8MB까지 가능){? .req}<span class="text-danger">*</span>{/}</div>
                                        {? .sub}<p class="help-block">{.sub}</p>{/}
                                        {? .val}
                                        <a href="/competition/get_source?file={.val}">[업로드된 파일 다운로드]</a>
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
                                    <div class="form-actions text-center">
                                        <button type="button" class="btn btn-default" onclick="location.href='/competition/views/{res.id}'">취소</button>
                                        <button type="button" id="sub_btn" class="btn btn-primary" onclick="go_apply(this); return false;">참가 접수하기</button>
                                        {? per.user_id == s.id}
                                        <span class="pull-right"><a class="btn btn-warning" href="#" onclick="del_confirm('del_apply()'); return false;">참가신청 삭제</a> </span>
                                        {/}
                                    </div> 
                                    <input type="hidden" id="f_ing" value="" />
                                </form>
                                {:}

                                {? date('Y.m.dH:i') < res.sdate}
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
                                    <a class="btn btn-default btn-sm" href="/competition">경진대회 리스트 보기</a>
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
                        <!--
                        {@ sub}
                        <div class="item">
                            <div class="text">
                                <h3><a href="/competition/views/{.id}"> {.subject}</a></h3>
                                <div class="metainfo"> <span class="icon-trophy"></span> {.name} &nbsp;&nbsp; <span class="icon-calendar"></span> {.date_s} ~ {.date_e} <span class="icon-caret-right"></span> </div>
                            </div>
                        </div>
                        {/}
                        -->
                        <!-- panel -->
                        <div class="panel recentporst">
                            <h3 class="panel-title">Recent Challenge</h3>
                            <ul class="media-list post-list">
                                {@ sub}
                                <li class="media">
                                    {?.img}<a class="pull-left media-object" href="/competition/views/{.id}"> <img src="{.img}" class="img-responsive"> </a>{/}
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/competition/views/{.id}"> {.subject}</a></h4>
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
        //console.log($('#form_cont').html());
        frm.submit();
        
    }

    function del_apply()
    {
        window.location.href="/competition/apply/{res.id}/{per.id}?req=del";
    }

//]]>
</script>