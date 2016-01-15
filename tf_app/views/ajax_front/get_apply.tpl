                            <div class="panel-heading"> 
                                <a class="btn btn-default btn-xs pull-right" href="/competition/applied_list/{res.id}">참가자 목록보기</a>
                                <h3 class="panel-title"><span class="icon-fixed-width  icon-check "></span>참가자 내용</h3>
                            </div>
                             <div class="panel-body">
                                <h4><span class="icon-fixed-width  icon-check "></span>경진대회 참가자 내용</h4>
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
                                
                                <div class="answered">
                                    {per.form}
                                    
                                    {? per.file}
                                    <dl>
                                        <dt>{res.form_file_title}{?res.form_file_req}<span class="text-danger">*</span>{/}</dt>
                                        <dd>
                                            <div class="file"><span class="icon-file"></span> <a href="/competition/get_source?file={per.file}">{per.file}</a></div>
                                        </dd>
                                    </dl>
                                    {/}

                                    {? res.form_file}
                                    {@ res.form_file}
                                    <br />
                                    <div class="form-group">
                                        <div class="control-label">{.title}{? .req} <span class="text-danger">*</span>{/}</div>
                                        {? .sub}<p class="help-block">{.sub}</p>{/}
                                        {? .val}
                                        <a href="/competition/get_source?file={.val}">[업로드된 파일 다운로드]</a>
                                        {/}
                                        <div class="file"><!--<input type="file" name="file_{.id}">--></div>
                                        <input type="hidden" name="o_file_{.id}" value="{.val}" />
                                    </div>
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
                                    <form class="form-horizontal " role="form" name="scoring_f">
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
                                                <div class="col-xs-12 col-sm-offset-4 col-sm-8 col-md-offset-2 col-md-10">
                                                <button class="btn btn-primary" onclick="add_scoring(); return false;">저장</button>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </form>
                                </div>
                                {/} 
                            </div> 
                            {/}
                                
                            {? res.user_id == s.id}
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
                                            <h4 class="media-heading"><a href="/member/{.ids}">{.name}</a></h4>
                                            <dl class="dl-horizontal well">
                                                {@ ex_user.score}
                                                <dt>{..name}</dt> <dd>{? ..scoring}<span class="badge">{..scoring}</span>{:}<span class="icon-minus text-muted"></span>{/}</dd>
                                                {/}
                                                <dt>총점</dt> <dd><span class="badge badge-info total_">{.total}</span></dd>
                                            </dl>
                                            <blockquote>
                                                <p>{.score[0].memo}</p>
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
                                            <div class="form-actions">
                                                <div class="col-xs-12 col-sm-offset-4 col-sm-8 col-md-offset-2 col-md-10">
                                                    <button class="btn btn-primary" onclick="change_status(); return false;">확인</button>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </form>
                                </div>
                            </div>
                            {/}                   
<script type="text/javascript">
//<![CDATA[

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