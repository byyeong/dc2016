
                    <!-- contentswrap -->
                    <div class="col-md-7 contentswrap"> 
                        <!-- section -->
                        <section> 
                            
                            <!-- panel --> 
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h2>
                                        <span class="icon-user"></span><span class="break"></span>
                                        {res.name} {?res.team}/ {res.team}{/} 
                                    </h2>
                                    <div class="actions"> 
                                        <span class="break"></span> 
                                        <a title="목록보기" data-toggle="tooltip" class="btn-list" href="/admin_office/oh_apply/{res.oh_id}">
                                            <span class="icon-align-justify"></span>
                                        </a> 
                                    </div>
                                </div>
                                <!-- /panel-heading -->
                                <!-- panel-body -->
                                <div class="panel-body">
                                    <h3>기본질문</h3>
                                    <div class="well">
                                        <dl class="dl-horizontal">
                                            <dt>참가자 이름</dt>
                                            <dd>{res.name}</dd>
                                        </dl>

                                        <dl class="dl-horizontal">
                                            <dt>휴대폰 번호</dt>
                                            <dd>{res.tel}</dd>
                                        </dl>

                                        <dl class="dl-horizontal">
                                            <dt>이메일 주소</dt>
                                            <dd>{res.email}</dd>
                                        </dl>

                                        <dl class="dl-horizontal">
                                            <dt>참가회사/팀명</dt>
                                            <dd>{res.team}</dd>
                                        </dl>

                                        <dl class="dl-horizontal">
                                            <dt>D.CAMP기업프로필 주소</dt>
                                            <dd><a href="{=check_http(res.profile_url)}">{res.profile_url}</a></dd>
                                        </dl>

                                        <dl class="dl-horizontal">
                                            <dt>제품/서비스명</dt>
                                            <dd>{res.s_subject}</dd>
                                        </dl>

                                        <dl class="dl-horizontal">
                                            <dt>Elevator pitch </dt>
                                            <dd>{=add_brs(res.s_description)}</dd>
                                        </dl>

                                        <dl class="dl-horizontal">
                                            <dt>Problem </dt>
                                            <dd>{=add_brs(res.s_description_p)}</dd>
                                        </dl>

                                        <dl class="dl-horizontal">
                                            <dt>Solution </dt>
                                            <dd>{=add_brs(res.s_description_s)}</dd>
                                        </dl>

                                        <dl class="dl-horizontal">
                                            <dt>간단한 자기소개</dt>
                                            <dd>{=add_brs(res.m_description)}</dd>
                                        </dl>

                                        <dl class="dl-horizontal">
                                            <dt>팀소개</dt>
                                            <dd>{=add_brs(res.t_description)}</dd>
                                        </dl>

                                        <dl class="dl-horizontal">
                                            <dt>이야기 나누고 싶은 상담 주제</dt>
                                            <dd>{=add_brs(res.topic)}</dd>
                                        </dl>
                                        <dl class="dl-horizontal">
                                            <dt>첨부파일</dt>
                                            <dd>
                                                {? res.file}<a href="/office_hours/get_source?apply_id={res.id}">{res.filename}</a>{/}
                                                {? res.file_link} <a target="_blank" href="{res.file_link}">{res.file_link}</a>{/}
                                            </dd>
                                        </dl>
                                    </div>
                                
                                    {? etc}
                                    <h3>추가질문 </h3>
                                    <div class="well">
                                        {@ etc}
                                        <dl class="">
                                            <dt>{.subject}</dt>
                                            <dd>{.contents}</dd>
                                        </dl>
                                        {/}
                                    </div>
                                    {/}
                                </div>
                                <!-- /panel-body -->
                                <!-- panel-footer -->
                                <div class="panel-footer">
                                    <form class="form-horizontal" role="form" method="post" onsubmit="return false;" name="f_apply">
                                        <fieldset>
                                            <div class="form-group">
                                                <span class="col-xs-12 col-sm-2 col-md-2 control-label ">심사하기</span>
                                                <div class="col-xs-12 col-sm-10 col-md-10" id="oh_status">
                                                    <label class="radio-inline">
                                                        <input type="radio" name="status" value="0" {? res.status == 0}checked="checked"{/}> 심사중
                                                    </label>
                                                    <label class="radio-inline">
                                                        <input type="radio" name="status" value="1" {? res.status == 1}checked="checked"{/}> 선정
                                                    </label>
                                                    <label class="radio-inline">
                                                        <input type="radio" name="status" value="2" {? res.status == 2}checked="checked"{/}> 미선정
                                                    </label>
                                                </div>
                                            </div>

                                            <div class="form-group st1" {? res.status != 1}style="display: none;"{/}>
                                                <span class="col-xs-12 col-sm-2 col-md-2 control-label ">상담시간 </span>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <div class="form-inline">
                                                        <span class="form-control-static">{=date_to_kr(oh.e_start)} </span> 
                                                        <select class="form-control" name="times">
                                                            <optgroup label="시간선택">
                                                                {@ times}
                                                                <option value="{.id}" {? res.suc_t.id == .id}selected="selected"{/} {? .apply_id}disabled="disabled"{/}>{.start}~{.end}{? .apply_id} [선정]{/}</option>
                                                                {/}
                                                            </optgroup>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="form-group st2" {? res.status < 2}style="display: none;"{/}>
                                                <span class="col-xs-12 col-sm-2 col-md-2 control-label ">간단 피드백 </span>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <div class="form-inline">
                                                        <textarea name="rec_desc" placeholder="간단한 피드백을 남기실 수 있습니다." style="width: 500px;" >{res.rec_desc}</textarea>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="form-group form-submit">
                                                <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                                    <button class="btn btn-default btn-sm">취소</button>
                                                    <button class="btn btn-primary btn-sm" onclick="submit_apply_st(); return false;">확인</button>
                                                </div>
                                            </div>
                                            <input type="hidden" name="id" value="{res.id}" />
                                        </fieldset>
                                    </form>
                                </div>
                                <!-- /panel-footer -->
                            </div>
                            <!-- /panel -->  
                        </section>
                        <!-- /section --> 
                    </div>
                    <!-- /contentwrap --> 

                    <!-- sidebar -->
                    <div class="col-sm-3 sidebar right">
                        <div class="sticky" id="sidebar">
                        </div>
                    </div>
                    <!-- /sidebar -->

            
<script type="text/javascript">
//<![CDATA[

$('body').css('padding-bottom', '113px');
$(document).ready(function() {
    $('#oh_status input[type=radio]').change(function() {
        if (this.value == '1') {
            $('.st1').slideDown();
            $('.st2').slideUp();
        }
        else if (this.value == '2') {
            $('.st2').slideDown();
            $('.st1').slideUp();
        }
        else {
            $('.st1').slideUp();
            $('.st2').slideUp();
        }
    });
});
get_oh_apply_list('{oh.id}');
//]]>
</script>
