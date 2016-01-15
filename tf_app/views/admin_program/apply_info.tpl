<script src="/js/jquery.ui.touch-punch.min.js"></script>
<script type="text/javascript">
//<![CDATA[

$(function() {
    $("#sortable").sortable({
    cancel: '.form-control',
    handle: 'i.icon-move',
    onDragStart: function (item, container, _super) {
       // Duplicate items of the no drop area
       if(!container.options.drop)
         item.clone().insertAfter(item)
       _super(item)
     }
    });
 });
 
{? sizeof(res.forms) < 1}
get_form_field(0, '{res.id}');
{/}

{? !res.form_file}
get_form_file(0, '{res.id}');
{/}

{? msgt}
_m = "지원서 작성을 완료했습니다.<br><br>운영 페이지로 이동할까요?";
$('#md-warning-ch .btn-danger').html('이동하기');
$('#md-warning-ch .btn-danger').attr('onclick', 'javascript:location.href="/admin_program/applied_list/{res.id}?tab=dashboard"');
$('#md-warning-ch p').html(_m);
$('#md-warning-ch').modal('show');
{/}
//]]>
</script>
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                    
                    <!-- panel #pane-event-edit -->
                    <div id="pane-event-edit" class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-edit"></span><span class="break"></span> Benefits 정보입력</h2>
                        </div>
                        <!-- /panel-heading -->
                        
                        <div class="panel-heading">   
                            <!-- tab-content -->
                            <ul class="nav nav-tabs">
                                <li><a href="/admin_program/edit/{res.id}">{? res}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}신청 정보 입력</a></li>
                                <li class="active"><a href="/admin_program/apply_info/{res.id}">{? res.basic || res.forms || res.form_file}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}지원서 만들기</a></li>
                            </ul>
                        </div>
                        <br/>
                        <div class="tab-content"> 
                            <div class="tab-pane active" id="formApply">
                                <form class="form-horizontal" role="form" name="info_form" method="post" onsubmit="return false;">
                                    <fieldset>
                                        <legend class="sr-only">참가 신청 정보 설정</legend>

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label">기본 질문 선택 <span class="fa fa-question-circle" data-toggle="popover" title="지원자가 대회 지원 시 프로필 정보를 자동으로 불러옵니다.
지원자가 수정할 수 있습니다."></span>
                                            </div>
                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                
                                                <div class="checkbox">
                                                  <label>
                                                    <input type="checkbox" name="basic1" id="basic1" value="1" {? (res.basic & 1) == 1}checked="checked"{/}>참가자 이름
                                                  </label>
                                                </div>
                                                <div class="checkbox">
                                                  <label>
                                                    <input type="checkbox" name="basic2" value="2" {? (res.basic & 2) == 2}checked="checked"{/}>휴대폰 번호
                                                  </label>
                                                </div>
                                                <div class="checkbox">
                                                  <label>
                                                    <input type="checkbox" name="basic3" value="4" {? (res.basic & 4) == 4}checked="checked"{/}>이메일 주소
                                                  </label>
                                                </div>
                                                <div class="checkbox">
                                                  <label>
                                                    <input type="checkbox" name="basic4" value="8" {? (res.basic & 8) == 8}checked="checked"{/}>간단한 자기소개 
                                                  </label>
                                                </div>
                                                <div class="checkbox">
                                                  <label>
                                                    <input type="checkbox" name="basic5" value="16" {? (res.basic & 16) == 16}checked="checked"{/}>팀소개
                                                  </label>
                                                </div>
                                                <div class="checkbox">
                                                  <label>
                                                    <input type="checkbox" name="basic6" value="32" {? (res.basic & 32) == 32}checked="checked"{/}>참가회사/팀명 
                                                  </label>
                                                </div>
                                                <div class="checkbox">
                                                  <label>
                                                    <input type="checkbox" name="basic7" value="64" {? (res.basic & 64) == 64}checked="checked"{/}>제품/서비스명
                                                  </label>
                                                </div>
                                                <div class="checkbox">
                                                  <label>
                                                    <input type="checkbox" name="basic8" value="128" {? (res.basic & 128) == 128}checked="checked"{/} onchange="check_ser(this);">제품/서비스 한 줄 소개 (준비하고 있는 제품/서비스를 한 문장<small>(50자 이내)</small>으로 소개해주세요.)
                                                  </label>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /form-group --> 

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label">참가 양식 만들기 <span class="fa fa-question-circle" data-toggle="popover" title="기본 질문 이 외에 지원서에 포함될 추가 질문을 생성합니다."></span>
                                            </div>
                                            <div class="col-xs-12 col-sm-10 col-md-10">  
                                            
                                                <ol id="sortable">
                                                    {@ res.forms}
                                                    {? .type == "text"}
                                                    <li class="ui-state-default entry-item form-group"> 
                                                        <input type="hidden" value="text" class="type" />
                                                        <div class="set-wrap pull-right">                                                            
                                                            <button class="btn btn-default btn-xs edit" type="button" onclick="get_form_field_e(this, '{.id}', '{res.id}'); return false;"><span class="icon-edit"></span></button> 
                                                            <button class="btn btn-default btn-xs delete" type="button" onclick="delete_form_sort(this, '{.id}'); return false;"><span class="icon-trash"></span></button> 
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label"><span class="t-title">{=add_brs(.title)}</span> {?.required}<span class="text-danger">*</span>{/}</label>
                                                            {?.sub}<p class="help-block">{=add_brs(.sub)}</p>{/}
                                                            <input type="text" class="form-control" disabled>
                                                        </div>
                                                    </li>
                                                    {/}

                                                    {? .type == "textarea"}
                                                    <li class="ui-state-default entry-item form-group"> 
                                                        <input type="hidden" value="textarea" class="type" />
                                                        <div class="set-wrap pull-right">                                                            
                                                            <button class="btn btn-default btn-xs edit" type="button" onclick="get_form_field_e(this, '{.id}', '{res.id}'); return false;"><span class="icon-edit"></span></button> 
                                                            <button class="btn btn-default btn-xs delete" type="button" onclick="delete_form_sort(this, '{.id}'); return false;"><span class="icon-trash"></span></button> 
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label"><span class="t-title">{=add_brs(.title)}</span> {?.required}<span class="text-danger">*</span>{/}</label>
                                                            {?.sub}<p class="help-block">{=add_brs(.sub)}</p>{/}
                                                            <textarea rows="5" class="form-control" disabled></textarea>
                                                        </div>
                                                    </li>
                                                    {/}

                                                    {? .type == "query"}
                                                    <li class="ui-state-default entry-item form-group"> 
                                                        <input type="hidden" value="query" class="type" />
                                                        <input type="hidden" value="{@ .opts}{.value_},{/}" class="opt" />
                                                        <div class="set-wrap pull-right">                                                            
                                                            <button class="btn btn-default btn-xs edit" type="button" onclick="get_form_field_e(this, '{.id}', '{res.id}'); return false;"><span class="icon-edit"></span></button> 
                                                            <button class="btn btn-default btn-xs delete" type="button" onclick="delete_form_sort(this, '{.id}'); return false;"><span class="icon-trash"></span></button> 
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label"><span class="t-title">{=add_brs(.title)}</span> {?.required}<span class="text-danger">*</span>{/}</label>
                                                            {?.sub}<p class="help-block">{=add_brs(.sub)}</p>{/}
                                                            <ul class="list-unstyled">
                                                                {@ .opts}
                                                                <li class="radio">
                                                                    <label>
                                                                        <input type="radio" name="opt{=date('is')}" disabled>{..value_}
                                                                    </label>
                                                                </li>
                                                                {/}
                                                            </ul>                                       
                                                        </div>
                                                    </li>
                                                    {/}
                                                    {/}
                                                </ol>
                                                <!-- /sortable -->
                                                
                                                <button class="btn btn-info btn-sm" id="btn_form" onclick="get_form_field(0, '{res.id}'); return false;"><span class="icon-plus"></span>&nbsp;항목추가</button>
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label">파일첨부 사용 여부 <span class="fa fa-question-circle" data-toggle="popover" title="지원자가 업로드해야 하는 파일이 있을 경우 생성합니다.
하나의 항목 당 하나의 파일이 업로드 가능합니다. (항목 당 8Mb 한도)"></span>
                                            </div>
                                            <div class="col-xs-12 col-sm-10 col-md-10 file_space">
                                                
                                                
                                                 {? res.form_file}
                                                 {@ res.form_file}
                                                 <div class="ui-state-default entry-item m_file"> 
                                                     <input type="hidden" class="type" value="file" /> 
                                                    <div class="set-wrap pull-right">                                                            
                                                        <button class="btn btn-default btn-xs edit" type="button" onclick="get_form_file_e(this, '{.id}', '{res.id}'); return false;"><span class="icon-edit"></span></button> 
                                                        <button onclick="delete_form_file(this, '{.id}'); return false;" type="button" class="btn btn-default btn-xs delete"><span class="icon-trash"></span></button>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label"><span class="t-title">{.title}</span> {?.req}<span class="text-danger">*</span>{/}</label> 
                                                        <p class="help-block">{.sub}</p>
                                                        <input type="file" disabled="disabled"> 
                                                   </div>   
                                                </div>
                                                {/}
                                                {/}   

                                                <button class="btn btn-info btn-sm" id="btn_file" onclick="get_form_file(0, '{res.id}'); return false;"><span class="icon-plus"></span>&nbsp;첨부파일 항목추가</button>
                                                
                                            </div>
                                        </div>
                                        
                                        <div class="form-group form-submit">
                                            <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                                <a href="#" class="btn btn-default">취소</a> 
                                                <a href="#" onclick="submit_info(this); return false;" class="btn btn-primary">확인</a>
                                            </div>
                                        </div>
                                        <input type="hidden" name="id" value="{res.id}" /> 
                                    </fieldset>
                                </form>
                            </div> 
                        </div>
                        <!-- /tab-content -->
                    </div>
                    <!-- /panel #pane-event-edit --> 
                    
                    
                    
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 
            <!-- /End Page Cotents --> 
        </div>
    </div>
</div>
<!-- /container --> 