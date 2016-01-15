
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
                            <h3 class="content-heading"><a href="/member/edit_challenge_m">Challenge 관리</a> > 대회 운영 현황</h3> 
                        </div>
                        
                        <div class="well applied-item">
                            <div class="media ">
                                {? res.img}<a href="/challenge/views/{res.id}" class="pull-left media-object"><img class="img-responsive" src="{res.img}" ></a>{/}
                                <div class="media-body">
                                    <h4 class="media-heading"><a href="/challenge/views/{res.id}">{res.subject}</a></h4>
                                    <div class="item-status">
                                        <dl class="dl-horizontal ">
                                            <dt>주최/주관</dt>
                                            <dd> <a href="/member/{res.ids}">{res.name}</a>{? res.organized}/{res.organized}{/} </dd>
                                            <dt>참가기간</dt>
                                            <dd>{=date_to_kr(res.date_s)} ~ {=date_to_kr(res.date_e)} 
                                                {? date('Y.m.dH:i') < res.sdate}<span class="label label-info">접수 준비</span>{/}
                                                {? date('Y.m.dH:i') > res.sdate && date('Y.m.dH:i') < res.edate}<span class="label label-primary">접수중</span>{/} 
                                                {? date('Y.m.dH:i') > res.edate}<span class="label label-warning">접수마감</span>{/} 
                                                {? date('Y.m.dH:i') > res.announce && res.winner}<span class="label label-default">수상자 발표</span>{/}
                                            </dd>
                                            <dt>발표일자</dt>
                                            <dd>{=date_to_kr(res.announce_d)}</dd>
                                        </dl>
                                    </div>
                                </div>
                            </div>
                            <!-- /media -->
                        </div>
                        <!-- /applied-item -->  
                        
                        <div class="applied-view panel panel-default"> 
                            <div class="panel-heading"> 
                                <button onClick="window.print()" class="btn btn-default btn-xs pull-right">인쇄하기</button>
                                <a class="btn btn-default btn-xs pull-right" href="/challenge/applied_list/{res.id}">참가자 목록보기</a>
                                <h3 class="panel-title"><span class="icon-fixed-width  icon-check "></span>참가자 내용</h3>
                            </div>
                             <div class="panel-body">
                                <h4><span class="icon-fixed-width  icon-check "></span>경진대회 참가자 내용</h4>
                                {? per.ids}
                                <div class="media well" id="applicant-info"> 
                                    <a href="/member/{per.ids}" class="pull-left media-object"><img class="img-responsive" src="{per.picture}" ></a>
                                    <div class="media-body">
                                        <h5 class="media-heading"><a href="/member/{per.ids}">{per.name}</a></h5>
                                        <div class="item-status">
                                            <dl class="dl-horizontal "> 
                                                <dt>회사/팀</dt>
                                                <dd><!--<a href="/startup/{per.com.sid}">{per.com.name}</a>-->{per.team}</dd>
                                                <dt>접수일자</dt>
                                                <dd>{=date_to_kr(per.date_created)}</dd>
                                                <dt>접수상태</dt>
                                                <dd>
                                                    {? per.status == 0}<span class="label label-default">접수대기</span> {/}
                                                    {? per.status == 1}<span class="label label-success">접수</span> {/}
                                                    {? per.status == 2}<span class="label label-warning">반려</span> {/}
                                                </dd>
                                            </dl>
                                        </div>
                                    </div>
                                </div>
                                <!-- /media -->
                                {/}
                                <div class="answered">
                                    <br />
                                    {? per.form&& per.form != 'undefined'}
                                    {=str_replace("\'","'",per.form)}
                                    {:}
                                    {? res.forms}
                                    {? (res.basic & 1) == 1}
                                    <dl>
                                        <dt>참가자 이름 <span class="text-danger">*</span></dt>
                                        <dd>{per.f_name}</dd>
                                    </dl>
                                    {/}
                                    {? (res.basic & 2) == 2}
                                    <dl>
                                        <dt>휴대폰 번호 <span class="text-danger">*</span></dt>
                                        <dd>{per.f_tel}</dd>
                                    </dl>
                                    {/}
                                    {? (res.basic & 4) == 4}
                                    <dl>
                                        <dt>이메일 주소 <span class="text-danger">*</span></dt>
                                        <dd>{per.f_email}</dd>
                                    </dl>
                                    {/}
                                    {? (res.basic & 8) == 8}
                                    <dl>
                                        <dt>간단한 자기소개 <span class="text-danger">*</span></dt>
                                        <dd>{per.f_des}</dd>
                                    </dl>
                                    {/}
                                    {? (res.basic & 16) == 16}
                                    <dl>
                                        <dt>팀 소개 <span class="text-danger">*</span></dt>
                                        <dd>{per.f_t_des}</dd>
                                    </dl>
                                    {/}
                                    {? (res.basic & 32) == 32}
                                    <dl>
                                        <dt>참가회사 / 팀명 <span class="text-danger">*</span></dt>
                                        <dd>{per.f_team}</dd>
                                    </dl>
                                    {/}
                                    {? (res.basic & 64) == 64}
                                    <dl>
                                        <dt>제품/서비스명 <span class="text-danger">*</span></dt>
                                        <dd>{per.f_service}</dd>
                                    </dl>
                                    {/}
                                    {? (res.basic & 128) == 128}
                                    <dl>
                                        <dt>제품/서비스 한 줄 소개 <span class="text-danger">*</span></dt>
                                        <dd>{per.f_s_des}</dd>
                                    </dl>
                                    {/}
                                    {@ res.forms}
                                    <dl>
                                        <dt>{.title}{? .req} <span class="text-danger">*</span>{/}</dt>
                                        {? .type == 'query'}
                                        {@ .opts}
                                        <div class="radio">
                                            <label>
                                                <input type="radio" name="form{.id}" value="{..key_ + 1}" {? .ress == ..key_ + 1}checked="checked"{/}>
                                                {..value_} </label>
                                        </div>
                                        {/}
                                        {:}
                                        <dd>{=add_brs(.ress)}</dd>
                                        {/}
                                    </dl>
                                    {/}
                                    {/}
                                    {/}

                                    
                                    {? res.form_file}
                                    {@ res.form_file}
                                    <dl>
                                        <dt>{.title}{? .req} <span class="text-danger">*</span>{/}</dt>
                                        <dd>
                                            {? .val}
                                            <span class="icon-file"></span>
                                            <a href="/challenge/get_source?cp={res.id}&file={.val}">{.val}</a>
                                            {/}
                                        </dd>
                                    </dl>
                                    {/}
                                    {/}
                                </div>
                                <!-- /answered  -->                              
                            </div>
                            
                            {? examiner}
                            <!-- todo : 심사자 경우 - 접수 완료후 채점 중일때 -->
                            <div class="panel-body score-field">
                                <h4><span class="icon-fixed-width  icon-check "></span> 심사 채점하기</h4>
                                {? res.edate > date("Y.m.dH:i")}
                                <div class="alert alert-info">현재 해당 경진대회가 접수중입니다. 접수마감 이후에 채점할 수 있습니다.</div>
                                {/}
                                {? score && res.edate < date("Y.m.dH:i")}
                                <div class="marking"> 
                                    <!--
                                    <span class="pull-right" data-toggle="tooltip" title="채점자 명수">
                                        <span class="sr-only">채점자</span> 
                                        <span class="badge">40/50</span>
                                    </span>
                                    //-->
                                    <form class="form-horizontal " role="form" name="scoring_f" onsubmit="return false;">
                                        <fieldset>
                                            <input type="hidden" name="user_id" value="{s.id}" />
                                            <input type="hidden" name="apply_id" value="{per.id}" />
                                            <input type="hidden" name="competition_id" value="{res.id}" />
                                            {@ score}
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-4 col-md-2 control-label">{.name}</div>
                                                <div class="col-xs-12 col-sm-8 col-md-10">
                                                    <input type="text" class="form-control score_f" value="{.scoring}" name="score_{.id}" onkeyup="get_total(); return false;" onkeypress="onlyNumberCom(this);" style="ime-mode:disabled">
                                                    / {.score}</div>
                                            </div>
                                            {/}
                                            <div id="total-score" class="form-group has-success">
                                                <div class="col-xs-12 col-sm-4 col-md-2 control-label">총점</div>
                                                <div class="col-xs-12 col-sm-8 col-md-10">
                                                    <input type="text" disabled="disabled" class="form-control" value="" id="total_score">
                                                    / {res.score}</div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-4 col-md-2 control-label">심사평</div>
                                                <div class="col-xs-12 col-sm-8 col-md-10">
                                                    <textarea placeholder="참가내용에 대한 심사총평을 써주세요" name="memo" class="form-control">{score[0].memo}</textarea>
                                                </div>
                                            </div>
                                            <div class="form-actions">
                                                <div class="col-sm-offset-4 col-md-offset-2">
                                                    {? date('Y.m.dH:i') < res.announce}
                                                    <button class="btn btn-primary" onclick="add_scoring(); return false;">저장</button>
                                                    {:}발표일자가 경과되어 채점할 수 없습니다.{/}
                                                </div>
                                            </div>
                                        </fieldset>
                                    </form>
                                </div>
                                {/} 
                            </div> 
                            {/}
                                
                            {? res.user_id == s.id || op}
                            <!-- todo :  주최자 경우 - 접수중일때 -->
                            <div class="panel-body status-field">  
                                {? res.edate < date("Y.m.dH:i")}
                                <div id="scoring">
                                    <h4><span class="icon-fixed-width  icon-check "></span> 심사 결과 보기 <small class="total text-primary">총합점수  <span class="badge badge-info" id="per_total"></span></small></h4>

                                    <div class="media-list">
                                        {@ ex_user}
                                        <div class="media">
                                          <div class="pull-left media-object">
                                            <img src="{.picture}" class="img-responsive">
                                          </div>
                                          <div class="media-body">
                                            <strong class="media-heading"><a href="/member/{.ids}">{.name}</a></strong>
                                            <div class="well">
                                                <dl class="dl-horizontal">
                                                    {@ ex_user.score}
                                                    <dt>{..name}</dt> <dd>{? ..scoring}<span class="badge">{..scoring}</span>{:}<span class="icon-minus text-muted"></span>{/}</dd>
                                                    {/}
                                                    <dt>총점</dt> <dd><span class="badge badge-info total_">{.total}</span></dd>
                                                </dl>
                                            </div>
                                            <blockquote>
                                                <p>{? .score[0].memo}{.score[0].memo}{:}심사평이 없습니다.{/}</p>
                                            </blockquote>
                                          </div>
                                        </div>
                                        {/}
                                    </div>
                                    <!-- /media-list -->
                                </div>
                                {/}
                                <div id="receiving">
                                    <h4><span class="icon-fixed-width  icon-check "></span> 참가 접수상태  </h4>
                                    <form class="form-horizontal" role="form" method="post" name="applied_view_status_f">
                                        <fieldset>
                                            <input type="hidden" name="id" value="{per.id}" />
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-4 col-md-2 control-label">접수여부</div>
                                                <div class="col-xs-12 col-sm-8 col-md-10">
                                                    <select class="selectpicker" data-width="auto" name="status">
                                                        <option value="0" {? per.status == 0}selected="selected"{/}>접수대기</option>
                                                        <option value="1" {? per.status == 1}selected="selected"{/}>접수</option>
                                                        <option value="2" {? per.status == 2}selected="selected"{/}>반려</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-4 col-md-2 control-label">반려사유</div>
                                                <div class="col-xs-12 col-sm-8 col-md-10">
                                                    <textarea class="form-control" placeholder="반려사유를 입력해주세요" name="status_des">{? per.status == 2}{per.status_des}{/}</textarea>
                                                </div>
                                            </div>
                                            <div class="form-group form-submit">
                                                <div class="col-xs-12 col-sm-offset-4 col-sm-8 col-md-offset-2 col-md-10">
                                                    {? date('Y.m.dH:i') < res.announce}
                                                    <button class="btn btn-primary" onclick="change_status(); return false;">확인</button>
                                                    {:}발표일자가 경과되었습니다.{/}
                                                </div>
                                            </div>
                                        </fieldset>
                                    </form>
                                </div>
                            </div>
                            {/}                             
                        </div>
                        <!-- /applied-view -->

                        <!--
                        {? examiner || res.user_id == s.id || op} 
                        <ul class="pager">
                            <li {? !prev}class="disabled"{/}>{? prev}<a href="/challenge/applied_view/{prev.id}">&larr; 이전</a>{:}<a href="#" onclick="return false;">&larr; 이전</a>{/}</li>
                            <li {? !next}class="disabled"{/}>{? next}<a href="/challenge/applied_view/{next.id}">다음 &rarr;</a>{:}<a href="#" onclick="return false;">다음 &rarr;</a>{/}</li>
                        </ul> 
                        {/} 
                        -->
                    </div>
                    <!-- /content -->
                        
                    <div class="col-xs-12 col-sm-12 col-md-3 sidebar">
                        <div class="sticky" id="sidebar">
                            {? examiner}
                            <div class="panel competitor-list"  id="markedList">
                                <h3 class="panel-title">심사 목록</h3>
                                <ul class="nav nav-tabs">
                                    <li class="active"><a href="#mark-total" data-toggle="tab">전체 </a><span class="badge badge-info">{cnt_all}</span></li>
                                    <li><a href="#mark-complete" data-toggle="tab">심사완료 </a><span class="badge badge-primary"> {cnt_end}</span></li>
                                    <li><a href="#mark-none" data-toggle="tab">남은심사 </a><span class="badge badge-warning">{cnt_all - cnt_end}</span></li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane active" id="mark-total">
                                    </div>
                                    <!-- /tab-pane -->
                                    <div class="tab-pane" id="mark-complete">
                                    </div>
                                    <!-- /tab-pane -->
                                    <div class="tab-pane" id="mark-none">
                                    </div>
                                    <!-- /tab-pane --> 
                                </div>
                                <!-- /tab-content --> 
    <script type="text/javascript">
    //<![CDATA[

    get_ex_list('{res.id}', 'all', 1, 'mark-total');
    get_ex_list('{res.id}', 'end', 1, 'mark-complete');
    get_ex_list('{res.id}', 'yet', 1, 'mark-none');
    function get_ex_list(_id, _type, _page, _div) {
        var get_url = "/ajax_v3/get_ex_list_all/"+_id+"/"+_type+"/"+_page+"/"+_div;

        $.get(get_url, function(_data){
            $('#'+_div).html(_data);
        });
    }
    //]]>
    </script>
                            </div>
                            <!-- panel -->
                            {:} 
                            {? res.user_id == s.id || op}
                            <div class="panel competitor-list" id="markedList">
                                <h3 class="panel-title">참가자 목록</h3>
                                <ul class="nav nav-tabs">
                                    <li class="active"><a href="#applied-all" data-toggle="tab">전체 </a><span class="badge badge-info">{cnt_a_all}</span></li>
                                    <li><a href="#applied-received" data-toggle="tab">접수 </a><span class="badge badge-primary"> {cnt_a_suc}</span></li>
                                    <li><a href="#applied-standby" data-toggle="tab">대기 </a><span class="badge badge-default">{cnt_a_pre}</span></li>
                                    <li><a href="#applied-rejected" data-toggle="tab">반려 </a><span class="badge badge-warning">{cnt_a_rej}</span></li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane active" id="applied-all">
                                    </div>
                                    <!-- /tab-pane -->
                                    <div class="tab-pane" id="applied-received">
                                    </div>
                                    <!-- /tab-pane -->
                                    <div class="tab-pane" id="applied-standby">
                                    </div>
                                    <!-- /tab-pane --> 
                                    <div class="tab-pane" id="applied-rejected">
                                    </div>
                                    <!-- /tab-pane --> 
                                </div>
                                <!-- /tab-content --> 
    <script type="text/javascript">
    //<![CDATA[

    get_ap_list('{res.id}', 'all', 1, 'applied-all');
    get_ap_list('{res.id}', 'suc', 1, 'applied-received');
    get_ap_list('{res.id}', 'pre', 1, 'applied-standby');
    get_ap_list('{res.id}', 'rej', 1, 'applied-rejected');
    function get_ap_list(_id, _type, _page, _div) {
        var get_url = "/ajax_front/get_ap_list_all/"+_id+"/"+_type+"/"+_page+"/"+_div;

        $.get(get_url, function(_data){
            $('#'+_div).html(_data);
        });
    }
    //]]>
    </script>
                            </div>
                            <!-- panel --> 
                            {/}
                            {/}
                        <div>
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
$('#sidebar').affix({
      offset: {
        top: 70,
        // bottom: 0
      }
});

function get_apply(_this, _id) {
    $('li.media').removeClass('active');
    $(_this).parent().addClass('active');
    $.get("/ajax_v3/get_apply/"+_id, function(_data){
        $(".applied-view").html(_data);
    });
}

function get_apply2(_id) {
    $.get("/ajax_v3/get_apply/"+_id, function(_data){
        $(".applied-view").html(_data);
        get_ex_list('{res.id}', 'all', 1, 'mark-total');
        get_ex_list('{res.id}', 'end', 1, 'mark-complete');
        get_ex_list('{res.id}', 'yet', 1, 'mark-none');
    });
}

function add_scoring()
{
    var get_url = '/ajax_front/scoring_apply';
    var set_data = $("form[name=scoring_f]").serialize();

    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {
            alert("채점이 저장되었습니다.");
            //get_apply2($('input[name=apply_id]').val());
            window.location.href = "/challenge/applied_view/"+$('input[name=apply_id]').val();
        }
    });
}

function change_status()
{
    var get_url = '/ajax_front/change_status_competition_apply';
    var set_data = $("form[name=applied_view_status_f]").serialize();

    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {
            alert("접수 상태가 수정되었습니다.");
            window.location.href = "/challenge/applied_view/"+$('input[name=id]').val();
            // get_ap_list('{res.id}', 'all', 1, 'applied-all');
            // get_ap_list('{res.id}', 'suc', 1, 'applied-received');
            // get_ap_list('{res.id}', 'pre', 1, 'applied-standby');
            // get_ap_list('{res.id}', 'rej', 1, 'applied-rejected');
        }
    });
}

function get_total() {
    var tot_ = 0;
    $(".score_f").each(function(){
        tot_ = tot_ + parseInt(this.value);
        // console.log(tot_)
        if (isNaN(tot_)) tot_ = 0;
        $("#total_score").val(tot_);
    });
}

{? score}
get_total();
{/}
    
{@ ex_user}
    var per_tot_ = 0;
    $(".total_").each(function(){
        per_tot_ = per_tot_ + parseInt($(this).html());
        $("#per_total").html(per_tot_);
    });
{/}

$(".answered input").each(function(){
    $(this).attr("disabled", "disabled");
});
$(".answered textarea").each(function(){
    $(this).attr("disabled", "disabled");
});

//]]>
</script>