<div class="modal-dialog">
    <!-- /modal-content -->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h3 class="modal-title"><span class="icon-user"></span><span class="break"></span>비밀번호 찾기</h3>
      </div>
      <div class="modal-body">
        {?res}
        <!-- todo :  정보를 찾았을 경우 -->
        <div class="well text-center">
            <h4>입력한 메일 주소로 비밀번호 초기화 정보 메일이 발송 되었습니다. </h4>
            <div>메일을 확인 하신 후 로그인 해주세요.</div>
        </div>
        {:}
        
        <!-- todo : 정보를 못찾았을 경우 -->
        <div class="alert alert-danger">
            <strong>Oops!</strong> <br>입력된 내용으로 확인할 수 있는 정보가 없습니다.  <br> 다시 입력해 주시기 바랍니다.
        </div>
        {/}
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        <!--<button type="button" class="btn btn-primary">확인</button>-->
      </div>
    </div>
    <!-- /modal-content -->
  </div> 