
    <!-- rowContent -->
    <div class="rowContent" id="competition"> 
        
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
                            <h3 class="content-heading"><a href="/member/edit_program_m">Benefit 관리</a> > 운영 현황</h3> 
                        </div>
                        
                        <div class="well applied-item">
                            <div class="media">
                                {? res.img}<a href="/program/views/{res.id}" class="pull-left media-object"><img class="img-responsive" src="{res.img}" ></a>{/}
                                <div class="media-body">
                                    <h4 class="media-heading"><a href="/program/views/{res.id}">{res.title}</a></h4>
                                    <div class="item-status">
                                        <dl class="dl-horizontal ">
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
                                                상시 <span class="label label-primary">접수중</span>
                                                {/}
                                            </dd>
                                        </dl>
                                    </div>
                                </div>
                                {? (res.user_id == s.id) || op}
                                <div class="list-controller pull-right">
                                    <a href="/program/edit/{res.id}" class="btn btn-primary btn-sm">세부정보 설정하기</a>
                                </div>
                                {/}
                            </div>
                            <!-- /media -->
                        </div>
                        <!-- /applied-item -->  
                        
                        <div class="applied-view panel panel-default"> 
                            <div class="panel-heading"> 
                                <button onClick="window.print()" class="btn btn-default btn-xs pull-right">인쇄하기</button>
                                <a class="btn btn-default btn-xs pull-right" href="/program/applied_list/{res.id}">프로그램 참가자 목록보기</a>
                                <h3 class="panel-title"><span class="icon-fixed-width  icon-check "></span>참가자 내용</h3>
                            </div>
                             <div class="panel-body">
                                {? per.ids}
                                <div class="media well" id="applicant-info"> 
                                    <a href="/member/{per.ids}" class="pull-left media-object"><img class="img-responsive" src="{per.picture}" ></a>
                                    <div class="media-body">
                                        <h5 class="media-heading"><a href="/member/{per.ids}">{per.name}</a></h5>
                                        <div class="item-status">
                                            <dl class="dl-horizontal "> 
                                                <dt>회사/팀</dt>
                                                <dd><a href="/startup/{per.com.sid}">{per.com.name}</a></dd>
                                                <dt>접수일자</dt>
                                                <dd>{=date_to_kr(per.date_created)}</dd>
                                            </dl>
                                        </div>
                                    </div>
                                </div>
                                <!-- /media -->
                                {/}
                                <div class="answered">
                                    <br />
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
                                        <dd>{per.s_des}</dd>
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
                                        <dd>{.ress}</dd>
                                        {/}
                                    </dl>
                                    {/}
                                    {/}

                                    
                                    {? res.form_file}
                                    {@ res.form_file}
                                    <dl>
                                        <dt>{.title}{? .req} <span class="text-danger">*</span>{/}</dt>
                                        <dd>
                                            {? .val}
                                            <span class="icon-file"></span>
                                            <a href="/program/get_source?aid={per.id}&fid={.fid}">{.val}</a>
                                            {/}
                                        </dd>
                                    </dl>
                                    {/}
                                    {/}
                                </div>
                                <!-- /answered  -->                              
                            </div>       
                        </div>
                        <!-- /applied-view -->
                    </div>
                    <!-- /content -->
                        
                    <div class="col-xs-12 col-sm-12 col-md-3 sidebar">
                        <div class="sticky" id="sidebar">
                            {? res.user_id == s.id || op}
                            <div class="panel competitor-list" id="markedList">
                                <h3 class="panel-title">참가자 목록</h3>
                                <ul class="nav nav-tabs">
                                    <li class="active"><a href="#applied-all" data-toggle="tab">전체 </a><span class="badge badge-info">{cnt_a_all}</span></li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane active" id="applied-all">
                                    </div>
                                    <!-- /tab-pane -->
                                </div>
                                <!-- /tab-content --> 
    <script type="text/javascript">
    //<![CDATA[

    get_ap_list('{res.id}', 'all', 1, 'applied-all');
    function get_ap_list(_id, _type, _page, _div) {
        var get_url = "/ajax_v3/get_pro_list_all/"+_id+"/"+_type+"/"+_page+"/"+_div;

        $.get(get_url, function(_data){
            $('#'+_div).html(_data);
        });
    }
    //]]>
    </script>
                            </div>
                            <!-- panel --> 
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
    $.get("/ajax_v3/get_apply_p/"+_id, function(_data){
        $(".applied-view").html(_data);
    });
}

//]]>
</script>