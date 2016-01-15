    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">출입 발급 정보  <span>{res.name}</span> </h4>
            </div>
            <!-- modal-body -->
            <div class="modal-body">
                <form name="ent_user_f" method="post">
                <input type="hidden" name="user_id" value="{res.id}" />
                <div class="member-info">
                    <div class="row">
                        <div class="col-md-4"> <img src="{res.picture}" class="img-responsive"> </div>
                        <div class="col-md-8"> 
                            <dl class="dl-horizontal">
                                <dt>이메일</dt>
                                <dd>{res.email}</dd>
                            </dl>
                            <dl class="dl-horizontal">
                                <dt>멤버십 승인일</dt>
                                <dd>{= substr(res.mem.date_edited, 0, 10)}</dd>
                            </dl>
                            <dl class="dl-horizontal">
                                <dt>총 방문수</dt>
                                <dd><span class="badge badge-info">{res.cnt_al}</span></dd>
                            </dl>
                            <dl class="dl-horizontal">
                                <dt>이번달 방문수</dt>
                                <dd><span class="badge badge-success">{res.cnt_m}</span></dd>
                            </dl>                             
                        </div>
                    </div>
                </div> 
                <!-- /self-info -->
                <div class="member-memo">
                    <div class="form-group">
                        <dl class="dl-horizontal">
                            <dt>추천인/추천기관</dt>
                            <dd>{res.com.name}{? res.com && res.mem_} / {/}{res.mem_.name}</dd>
                        </dl>
                        <dl class="dl-horizontal">
                            <dt>창업 관련 활동</dt>
                            <dd>{res.mem.act}</dd>
                        </dl>
                        <dl class="dl-horizontal">
                            <dt>기타 경력</dt>
                            <dd>{res.mem.career}</dd>
                        </dl>
                    </div>
                    <div class="form-group">
                        <label class="text-danger"><span class="icon-warning-sign"></span> 메모</label>
                        <textarea class="form-control" rows="3" name="admin_des">{res.admin_des}</textarea>
                    </div>
                </div>
                </form>
            </div>
            <!-- /modal-body -->
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" onclick="edit_user_info(this);">메모 저장</button>
            </div>
        </div>
        <!-- /modal-content --> 
    </div>
    <!-- /modal-dialog --> 
    
<script type="text/javascript">
//<![CDATA[
function edit_user_info(_this) {
    $(_this).hide();
    var get_url = '/ajax/entrance_user/{res.id}';
    var frm = $('form[name=ent_user_f]');
    var set_data = frm.serialize();;
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {
            $('.modal').modal('hide');
        }
    });
}
//]]>
</script>