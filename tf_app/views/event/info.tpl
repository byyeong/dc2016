<!-- rowContent -->
<div class="rowContent"  id="event"> 
    <!-- page-header -->
    <div class="page-header">
        <div class="container">
            <h2><a href="/event">Event</a></h2>
        </div>
    </div>
    <!-- /page-header --> 
    
    <!-- page-content -->
    <div class="page-content"> 
        <!-- container -->
        <div class="container">

            <!-- contentwrap -->
            <div class="editor">
                <div class="edit-header"><h3><span class="icon-user"></span> 신청자 리스트 </h3></div>
                <div class="edit-body">    
                    <!-- panel #pane-applicant-list -->
                    <div id="pane-applicant-list" class="panel panel-default"> 
                        <!-- panel-heading 
                        <div class="panel-heading">

                            <div class="actions"> 
                                <a data-original-title="다운로드" href="/ajax/info_excel_front/{res.id}" class="btn-down" data-toggle="tooltip" title=""><span class="glyphicon glyphicon-download-alt"></span> Excel</a>
                            </div>
                        </div>
                        //panel-heading --> 
                        
                        <!-- panel-body -->
                        <div class="panel-body info-field ">
                            <fieldset>
                                <dl class="dl-horizontal">
                                    <dt>개설일자</dt>
                                    <dd> {=str_replace("-", ".", res.date)} </dd>
                                </dl>
                                <!-- /dl-horizontal -->
                                
                                <dl class="dl-horizontal">
                                    <dt>개설자</dt>
                                    <dd> {res.mname} </dd>
                                </dl>
                                <!-- /dl-horizontal -->
                                
                                <dl class="dl-horizontal">
                                    <dt>이벤트 장소</dt>
                                    <dd> {? res.space_id == 0}{res.space_etc}{:}{res.opt}F {res.sname}{/} </dd>
                                </dl>
                                <!-- /dl-horizontal -->
                                
                                <dl class="dl-horizontal">
                                    <dt>성격</dt>
                                    <dd> {res.ename} </dd>
                                </dl>
                                <!-- /dl-horizontal -->
                                
                                <dl class="dl-horizontal">
                                    <dt>행사명</dt>
                                    <dd> <strong>{res.title}</strong> </dd>
                                </dl>
                                <!-- /dl-horizontal -->
                                
                                <dl class="dl-horizontal">
                                    <dt>시간</dt>
                                    <dd> {res.start} ~ {res.end} </dd>
                                </dl>
                                <!-- /dl-horizontal -->
                                
                                <dl class="dl-horizontal">
                                    <dt>인원</dt>
                                    <dd> 정원 <span class="badge badge-success">{res.cnt}</span>명 / 신청인원 <span class="badge badge-info"> {res.rcnt}</span>명</dd>
                                </dl>
                                <!-- /dl-horizontal -->
                                
                                <dl class="dl-horizontal">
                                    <dt>참여 선정 방법</dt>
                                    <dd> {? res.enroll_type == 1}선착순{:}관리자 선정{/} </dd>
                                </dl>
                                <!-- /dl-horizontal -->
                                
                                <dl class="dl-horizontal">
                                    <dt>신청상태</dt>
                                    {? res.state == 0}
                                    <dd> <span class="label ">예약중</span> </dd>
                                    {/}{? res.state == 1}
                                    <dd> <span class="label label-info">승인</span> </dd>
                                    {/}{? res.state == 2}
                                    <dd> <span class="label label-warning">반려</span> </dd>
                                    {/}
                                    
                                </dl>
                                <!-- /dl-horizontal --> 
                            </fieldset>
                        </div>
                        <!-- /panel-body -->
                        
                    </div>
                    <!-- /panel #pane-applicant-list--> 
                </div>
            </div>
            <!-- /contentwrap --> 

        </div>
        <!-- /container --> 
    </div>
    <!-- /page-content --> 
</div>
<!-- /rowContent --> 

<script type="text/javascript">
//<![CDATA[

get_list('1','{res.id}');
function get_list(_page, _id) {

    var set_data ={
        "id"        : _id,
    };
    var get_url = '/ajax/event_reserve_list/'+_page;
    $.post(get_url, set_data,function(_data){
        $('.table-striped').remove();
        $('.panel-footer').remove();
        $('.panel-body').after(_data);
    });
}
    
//]]>
</script>