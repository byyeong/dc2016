    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3 class="modal-title"><span class="icon-search"></span> <span class="break"></span> 스타트업 검색</h3>
            </div>
            <!-- /modal-header -->
            <div class="modal-body"> 
                
                <!-- search-input -->
                <div class="well search-form">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder=" 스타트업 이름을 입력해 주세요" value="{key}" id="search_in">
                        <span class="input-group-btn">
                            <button data-toggle="modal" href="#searchStartup" class="btn btn-default" onclick="search_company_in(); return false;"><span class="icon-search"></span><span class="sr-only">검색하기</span></button>
                        </span> 
                     </div>
                </div>
                <!-- /search-input -->  
                    
                <!-- search-result -->
                <div class="search-result">
                     
                    <!-- todo : 검색 리스트 -->
                    {? res}
                    <!-- list-result -->
                    <div class="list-result"> 
                            <ol class="list-unstyled">
                                {@ res}
                                <li><a href="#" onclick="send_com('{v}','{.name}'); return false;">{.name} <span class="label label-default pull-right">선택</span></a></li>
                                {/}
                            </ol> 
                    </div>
                    <!-- /list-result -->
                    {:}
                    
                    
                    <!-- todo : 검색결과가 없을 때 --> 
                    <div class="alert alert-danger"><strong>Oops!</strong> 검색결과가 없습니다. 다시 입력해주세요.</div>
                    {/}
                </div>
                <!-- /search-result --> 
                
            </div>
            <!-- /modal-body -->
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                <!--<button type="button" class="btn btn-primary" onclick="enter_startup();">확인</button>-->
            </div>
            <!-- /modal-footer --> 
        </div>
        <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 
    
<script type="text/javascript">
//<![CDAT

function search_company_in(){
    var key = $('#search_in').val();
    var get_url = '/ajax_front/get_search_company_in/';
    var set_data ={
        "data" 		: key,
        "v" 		: {v},
    };
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {

            $('.search-result').html(_data);

        }
    });
}

function send_com(_v, _val){
    recive_com(_v, _val);
    $(".modal").modal("hide");
}
//]]>
</script> 