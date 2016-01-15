    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                <h3 class="modal-title"><span class="icon-search"></span> <span class="break"></span> 회원 검색</h3>
            </div>
            <!-- /modal-header -->
            <div class="modal-body"> 
                
                <!-- search-input -->
                <div class="well search-form">
                    <h4>찾고자 하는 이름을 입력하세요</h4>
                    <div class="input-group">
                        <input type="text" placeholder="" required="required" name="q" value="{q}" class="form-control" onkeypress="if(event.keyCode==13) {search_member_q(); return false;}">
                        <span class="input-group-btn">
                            <button class="btn btn-default" onclick="search_member_q(); return false;"><span class="icon-search"></span><span class="sr-only">검색하기</span></button>
                        </span> 
                    </div>
                </div>
                <!-- /search-input --> 
                <br />
                <!-- search-result -->
                <div class="search-result">                     
                    <div class="alert alert-danger"><strong>Oops!</strong> 검색결과가 없습니다. 다시 입력해주세요.</div>
                </div>
                <!-- /search-result --> 
                
            </div>
            <!-- /modal-body -->
            <div class="modal-footer">
                <button data-dismiss="modal" class="btn btn-default" type="button">취소</button>
                <button data-dismiss="modal" class="btn btn-primary" type="button">확인</button>
            </div>
            <!-- /modal-footer --> 
        </div>
        <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 