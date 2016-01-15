<div class="modal-dialog">
    <!-- /modal-content -->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h3 class="modal-title"><span class="icon-user"></span><span class="break"></span>아이디 찾기</h3>
      </div>
      <div class="modal-body">
      
          {? res}
        <!-- todo : 정보를 찾았을 경우 -->
        <h4>회원님의 아이디를 확인해주세요.</h4>
        <div class="well text-center">
            회원님의 아이디는  <strong class="text-primary">{res.ids}</strong> 입니다.
        </div>
        <div>아래의 [확인]버튼을 누르면 로그인 화면으로 이동합니다. 로그인 해주세요.</div>
        {:}
        <!-- todo : 정보를 못찾았을 경우 -->
        <div class="alert alert-danger">
            <strong>Oops!</strong> <br>입력한 정보로 확인할 수 있는 아이디가 없습니다. <br>입력 정보를 확인하고 다시 입력해 주시기 바랍니다.
        </div>
        {/}
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        {? res}
        <a href="/login" class="btn btn-primary">확인</a>
        {/}
      </div>
    </div>
    <!-- /modal-content -->
  </div> 