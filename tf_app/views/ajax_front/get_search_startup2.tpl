    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                {? stype == 1}
                <h3 class="modal-title"><span class="icon-search"></span> <span class="break"></span> 스타트업 검색</h3>
                {/}
                {? stype == 2}
                <h3 class="modal-title"><span class="icon-search"></span> <span class="break"></span> 창업유관기관 검색</h3>
                {/}
            </div>
            <!-- /modal-header -->
            <div class="modal-body"> 
                
                <!-- search-input -->
                <div class="well search-form">
                    <div class="input-group">
                        {? stype == 1}
                        <input type="text" class="form-control" placeholder=" 스타트업 이름을 입력해 주세요" value="{key}" id="search_in">
                        {/}
                        {? stype == 2}
                        <input type="text" class="form-control" placeholder=" 창업유관기관 이름을 입력해 주세요" value="{key}" id="search_in">
                        {/}
                        <span class="input-group-btn">
                            <button data-toggle="modal" href="#searchStartup" class="btn btn-default" onclick="search_startup_in(); return false;"><span class="glyphicon glyphicon-search"></span><span class="sr-only">검색하기</span></button>
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
                                {? form}
                                <li><a href="#" onclick="send_com('{.name}', '{form}'); return false;">{.name} <span class="label label-default pull-right">선택</span></a></li>
                                {:}
                                <li><a href="#" onclick="send_com('{.name}'); return false;">{.name} <span class="label label-default pull-right">선택</span></a></li>
                                {/}
                                {/}
                            </ol> 
                    </div>
                    <!-- /list-result -->
                    {:}
                    
                    <br />
                    <!-- todo : 검색결과가 없을 때 --> 
                    <div class="alert alert-danger"><strong>Oops!</strong> 검색결과가 없습니다. 새로 입력할까요?</div>
                    {/}
                    
                    <!-- 
                    <div class="well well-sm add-input">
                        <h4>기업이 확인되지 않을 경우 새로 등록해 주세요.</h4>
                        <input type="text" class="form-control" name="name" id="new_startup" placeholder=" 등록할 기업이름을 입력해주세요." {?!res}value="{key}"{/}>
                    </div>
                    //--> 
                </div>
                <!-- /search-result --> 

            </div>
            <!-- /modal-body -->
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" onclick="enter_startup('{form}','{stype}');">새로 입력</button>
            </div>
            <!-- /modal-footer --> 
        </div>
        <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 
    
<script type="text/javascript">
//<![CDAT

function search_startup_in(){
    var key = $('#search_in').val();
    var get_url = '/ajax_front/get_search_startup_in2/{stype}/{is_diable_select}';
    var set_data ={
        "data" 		: key,
        "form"          : '{form}',
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

function send_com(_val){
    recive_com(_val);
    $("#md-searchStartup").modal("hide");
}

function send_com(_val, _form){
    recive_com(_val, _form);
    $("#md-searchStartup").modal("hide");
}
//]]>
</script> 