<!-- content -->
<div id="regist-startup" class="content"> 
    <div class="row">
        <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-8 col-md-offset-2"> 
                   
            <!-- header -->
            <div class="header">
                <h1><a href="/"><img src="/img/logo.png" alt="D.CAMP"></a> <small>스타트업</small></h1>
            </div>
            <!-- /header --> 
     
            <!-- panel -->
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h2><span class="icon-building"></span> 스타트업 연결하기</h2>
                </div>
                <div class="panel-body">
                
                    <div class="guide-wrap">
                        <p>소속되어 있는 Startup 정보를 입력하면 개인정보와 연계되어 포트폴리오로 활용이 가능합니다. <br>
                            입력한 정보와 소속관계는 해당 기업에서 검증을 거친 후 승인됩니다.</p>
                        <ul>
                            <li>디캠프에 이미 등록된 기업인 경우 검색을 통해 추가 입력 없이 기존 기업 정보로 바로 연계 신청이 접수됩니다.</li>
                            <li>개인정보와 기업정보의 연계는 해당 기업 관리자의 승인 이후 연계처리됩니다.</li>
                            <li>아래 검색창에 개인정보와 연계할 기업 이름을 입력하고 검색해 주세요</li>
                        </ul>
                    </div>
                        
                    <!-- well -->
                    <div class="well search-form">
                        <form class="form-horizontal" role="form">
                            <fieldset> 
                                    <div class="input-group">
                                        <input type="text" class="form-control" placeholder="스타트업 이름을 입력해 주세요" id="search">
                                        <span class="input-group-btn">
                                            <button class="btn btn-default" data-toggle="modal" href="#md-searchStartup" onclick="search_startup(); return false;"><span class="icon-search"></span><span class="sr-only">검색하기</span></button>
                                        </span> 
                                     </div> 
                                <!-- /input-group --> 
                            </fieldset>
                        </form>
                    </div>
                    <!-- /well -->
                    
                    <div class="text-center">
                        <a href="#" class="btn btn-default">홈으로</a> 
                        <!--<a href="#" class="btn btn-primary">정보입력</a>-->
                    </div>
                    
                </div>
                <!-- /panel-body --> 
            </div>
            <!-- /panel --> 
            
            
        </div>
    </div>
</div>
<!-- /content--> 




<!-- modal #searchStartup -->
<div class="modal fade" id="md-searchStartup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    
</div>
<!-- /modal #searchStartup -->

<script type="text/javascript">
//<![CDAT

function search_startup(){
    var key = $('#search').val();
    var get_url = '/ajax_front/get_search_startup/';
    var set_data ={
        "data" 		: key,
    };
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {

            $('#md-searchStartup').html(_data);

        }
    });
}

//]]>
</script> 