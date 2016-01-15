    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">월간 사물함 정보 <span>{res.name}</span> </h4>
            </div>
            <!-- modal-body -->
            <form class="form-horizontal" name="locker_info_{res.id}" role="form" method="post" onsubmit="return false;">
                <div class="modal-body">
                    <fieldset>
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-4 col-md-4 control-label">배정된 사물함 번호</div>
                            <div class="col-xs-12 col-sm-8 col-md-8">
                                <p class="form-control-static"> <strong>{res.locker_id}</strong> </p>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-4 col-md-4 control-label">이동할 사물함 번호</div>
                            <div class="col-xs-12 col-sm-8 col-md-8">
                                <select class="selectpicker" data-width="auto" name="locker_id">
                                    {@ locker}
                                    <option value="{.locker}">{.locker}</option>
                                    {/}
                                </select>
                            </div>
                        </div>
                    </fieldset>
                </div>
                <!-- /modal-body -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger pull-left" onclick="del_info(this, '{res.id}'); return false;">삭제</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-primary" onclick="edit_info(this); return false;">사물함 이동</button>
                </div>
            </form>
        </div>
        <!-- /modal-content --> 
    </div>
    <!-- /modal-dialog --> 
    
<script type="text/javascript">
//<![CDAT
function edit_info(_this)
{
    $(_this).hide();
    var get_url = '/ajax/get_locker_info/{res.date}/{res.user_id}';
    var frm = $('form[name=locker_info_{res.id}]');
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {
            get_already(1, '{res.date}');
            $(".modal").modal("hide");
        }
    });
}

function del_info(_this, _id)
{  
    $(_this).hide();
    var get_url = "/ajax/del_locker_info/"+_id;

    $.get(get_url, function() {
        get_already(1, '{res.date}');
        $(".modal").modal("hide");
    });
}
//]]>
</script>