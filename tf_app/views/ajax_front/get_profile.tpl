    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">멤버승인하기</h4>
            </div>
            <div class="modal-body">
            <!-- Start modal content -->
                <p>멤버 신청한 "{res.name}"님을 멤버로 승인하겠습니까?</p> 
            <!-- Start modal content -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal" onclick="javascript:window.location.href='/member/{res.ids}';">프로필보기</button>
                <button type="button" class="btn btn-default" onclick="edit_state_user(3, '{smid}', '{res.id}'); return false;">삭제하기</button>
                <button type="button" class="btn btn-primary" onclick="edit_state_user(1, '{smid}', '{res.id}'); return false;">승인하기</button>
              </div> 
        </div>
    </div>