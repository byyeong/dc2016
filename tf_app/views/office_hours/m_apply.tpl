    <!-- rowContent -->
    <div class="rowContent"  id="userProfile"> 
        
        <!-- page-header -->
        <div class="page-header">
            <div class="container">
                <h2><a href="/office_hours/m_list">Office Hours</a></h2>

                <a href="/office_hours/m_info" class="btn btn-default btn-sm pull-right">
                    <span class="icon-fixed-width icon-large icon-user"></span> 멘토정보 수정하기 
                </a>
                <a href="/office_hours/m_apply_all" class="btn btn-default btn-sm pull-right">
                    <span class="fa fa-fw fa-check-square"></span> 신청자 모두보기 
                </a>
                <a href="/office_hours/m_add" class="btn btn-default btn-sm pull-right">
                    <span class="icon-fixed-width icon-large icon-edit"></span> Office Hours 추가하기
                </a>
                <a href="/office_hours/m_list" class="btn btn-default btn-sm pull-right">
                    <span class="icon-fixed-width icon-large icon-list"></span> 전체 리스트보기
                </a>
            </div>
        </div>
        <!-- /page-header --> 
        
        <!-- page-content -->
        <div class="page-content"> 

            <!-- container -->
            <div class="container">
                <div class="row">

                    <!-- content -->
                    <div class="col-xs-12 col-sm-12 col-sm-9 content">
                        <div class="content-header">
                            <h3 class="content-heading"><span class="icon-trophy"></span> 참가자 내용보기</h3>
                        </div>

                        <div class="well applied-item">
                            <div class="media">
                                <a href="#" class="pull-left media-object">
                                    <span style="background-image:url({oh.picture});">
                                        <img class="img-responsive" src="/images/img_trans.png">
                                    </span>
                                </a>
                                <div class="media-body">
                                    <h4 class="media-heading">
                                        <a href="/office_hours/views/{oh.id}">
                                            {oh.subject}
                                        </a>
                                    </h4>
                                    <div class="item-status">
                                        <dl class="dl-horizontal">
                                            <dt>주최&middot;주관</dt>
                                            <dd>{oh.hosted}</dd>
                                            <dt>참가 장소</dt>
                                            <dd>{oh.place}</dd>
                                            <dt>참가 일자 </dt>
                                            <dd>{=substr(oh.e_start, 0, 10)} ({=date_to_day_only(oh.e_start)}) {=substr(oh.e_start, 11)} ~ {=substr(oh.e_end, 0, 10)} ({=date_to_day_only(oh.e_end)}) {=substr(oh.e_end, 11)} / 팀당 1시간</dd>
                                            <dt>접수 기간</dt>
                                            <dd>{=substr(oh.a_start, 0, 10)} ({=date_to_day_only(oh.a_start)}) {=substr(oh.a_start, 11)} ~ {=substr(oh.a_end, 0, 10)} ({=date_to_day_only(oh.a_end)}) {=substr(oh.a_end, 11)} {? oh.a_start > date('Y.m.d H:i')}<span class="badge">D-{=dateDiff(oh.a_start, date('Y.m.d'), '.')}</span>{/}</dd>
                                            <dt>발표 일자</dt>
                                            <dd>{=substr(oh.r_date, 0, 10)} ({=date_to_day_only(oh.r_date)}) {=substr(oh.r_date, 11)} / 메일을 통해 개별 안내 {? oh.r_date > date('Y.m.d H:i')}<span class="badge">D-{=dateDiff(oh.r_date, date('Y.m.d'), '.')}</span>{/}</dd>
                                        </dl> 
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /applied-item -->


                        <div class="applied-view panel panel-default">
                            <div class="panel-heading"> 
                                <a class="btn btn-default btn-xs pull-right" href="/office_hours/m_apply_list/{oh.id}">참가자 목록보기</a>
                                <h3 class="panel-title"><span class="icon-fixed-width  icon-check "></span>참가자 내용 - {res.name} </h3>
                            </div>
                            <div class="panel-body">
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
                                    <dd><a target="_blank" href="{=check_http(res.profile_url)}">{res.team}</a></dd>
                                </dl>

                                <dl class="dl-horizontal">
                                    <dt>제품/서비스명</dt>
                                    <dd>{res.s_subject}</dd>
                                </dl>
                            </div>
                            <!-- /panel-body -->
                            <div class="panel-body">
                                <dl>
                                    <dt>Elevator pitch </dt>
                                    <dd>{=add_brs(res.s_description)}</dd>
                                </dl>

                                <dl>
                                    <dt>Problem </dt>
                                    <dd>{=add_brs(res.s_description_p)}</dd>
                                </dl>

                                <dl>
                                    <dt>Solution </dt>
                                    <dd>{=add_brs(res.s_description_s)}</dd>
                                </dl>

                                <dl>
                                    <dt>간단한 자기소개</dt>
                                    <dd>{=add_brs(res.m_description)}</dd>
                                </dl>

                                <dl>
                                    <dt>팀소개</dt>
                                    <dd>{=add_brs(res.t_description)}</dd>
                                </dl>

                                <dl>
                                    <dt>이야기 나누고 싶은 상담 주제</dt>
                                    <dd>{=add_brs(res.topic)}</dd>
                                </dl>
                                
                                {@ etc}
                                <dl>
                                    <dt>{.subject}</dt>
                                    <dd>{.contents}</dd>
                                </dl>
                                {/}
                                
                                <dl>
                                    <dt>첨부파일</dt>
                                    <dd>
                                        {? res.file}<a href="/office_hours/get_source?apply_id={res.id}">{res.filename}</a>{/}
                                        {? res.file_link} <a target="_blank" href="{res.file_link}">{res.file_link}</a>{/}
                                    </dd>
                                </dl>
                            </div>
                            <!-- /panel-body -->
                            <div class="panel-footer">
                                <form class="form-horizontal" role="form" method="post" onsubmit="return false;" name="f_apply">
                                    <fieldset>
                                        <div class="form-group" id="oh_status">
                                            <span class="col-xs-12 col-sm-2 col-md-2 control-label ">심사하기</span>
                                            <div class="col-xs-12 col-sm-10 col-md-10">
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
                                                <button class="btn btn-default btn-sm" onclick="javascript:location.href='/office_hours/m_apply_list/{oh.id}'">취소</button>
                                                <button class="btn btn-primary btn-sm" onclick="submit_apply_st(); return false;">확인</button>
                                            </div>
                                        </div>
                                        
                                        <input type="hidden" name="id" value="{res.id}" />
                                    </fieldset>
                                </form>
                            </div>
                            <!-- /panel-footer -->
                        </div>
                        <!-- /applied-view -->
                    </div>
                    <!-- /content -->
                    
                    <!-- sidebar -->
                    <div class="col-xs-12 col-sm-12 col-sm-3 sidebar">
                        <div class="sticky" id="sidebar">
                        </div>
                    </div>
                    <!-- /sidebar -->
                </div>

        </div>
        <!-- /page-content --> 
        
    </div>
    <!-- /rowContent -->

<script type="text/javascript">
//<![CDATA[
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

$('#sidebar').affix({
      offset: {
        top: 70,
        // bottom: 0
      }
});
//]]>
</script>