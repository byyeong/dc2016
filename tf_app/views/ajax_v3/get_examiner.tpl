                        <form class="form-horizontal well" role="form" onsubmit="edit_ex_noti('{cid}'); return false;">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">심사위원 공지</label>
                                <div class="col-sm-10">
                                    <textarea placeholder="심사위원에 공지할 내용을 입력하세요." rows="3" class="form-control" name="ex_notice">{cc.ex_notice}</textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                    <button class="btn btn-default" type="submit" onclick="edit_ex_noti('{cid}'); return false;">저장하기</button>
                                </div>
                            </div>
                        </form>
                        <h4><span class="icon-user"></span> 심사위원 명단</h4>
                        {? res}
                        <div class="table-responsive">
                            <form name="ex_list">
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th width="60" class="td-select"><input type="checkbox" id="ex_check_all"></th>
                                            <th class="td-name">이름</th>
                                            <th class="td-group">소속</th>
                                            <th class="td-history">심사위원 이력</th>
                                            <th class="td-info">심사위원 정보</th>
                                            <th class="td-status">상태</th>
                                            <th class="td-manage">관리</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {@ res}
                                        <tr id="exm_{.id}">
                                            <td class="td-select"><input type="checkbox" value="{.id}" name="ex_con"></td>
                                            <td class="td-name">
                                                {?.name}<a onclick="view_examiner('{.user_id}'); return false;" href="#">{.name}</a>{:}
                                                초대 중 ...{/}
                                            </td>
                                            <td class="td-group">
                                                <a href="/startup/{.com.sid}" target="_blank">{.com.name}</a>
                                            </td>
                                            <td class="td-history"><a href="#" onclick="view_examiner('{.user_id}'); return false;">{.comp}</a></td>
                                            <td class="td-info">
                                                {?.name}<a class="btn btn-default btn-xs" onclick="view_examiner('{.user_id}'); return false;" href="#">정보보기</a>{:}
                                                {.email}{/}
                                            </td>
                                            <td class="td-status">
                                                {? .status == 0}
                                                <span class="label label-default">초대중</span>
                                                {/}{? .status == 1}
                                                <span class="label label-success">승락</span>
                                                {/}{? .status == 2}
                                                <button title="내용있음" type="button" class="btn btn-warning btn-xs" data-toggle="tooltip" onclick="get_reject('{.id}', '{.competition_id}'); return false;">거절</span></button></td>
                                                {/}
                                            </td>
                                            <td class="td-manage">
                                                <button title="삭제" type="button" class="btn btn-danger btn-xs" data-toggle="tooltip" onclick="del_examiner('{.id}'); return false;"><span class="icon-fixed-width icon-trash"></span></button></td>
                                        </tr>
                                        {/}
                                    </tbody>
                                </table>
                            </form>
                        </div>
                        {? cc.ex_confirm}
                        <div class="list-controller"> <button class="btn btn-primary btn-sm" disabled="disabled">심사위원 최종 선정 완료</button>
                        </div>
                        {:}
                        <div class="list-controller"> 선택한 위원을
                            <button class="btn btn-primary btn-sm" onclick="ex_confirm(this); return false;" {? cc.ex_confirm}disabled="disabled"{/}>심사위원으로 최종 선정</button>
                        </div>
                        {/}

<script type="text/javascript">
//<![CDATA[
$("#ex_check_all").click(function(){
    var chk = $(this).prop("checked");//.attr('checked');
    if(chk) {
        $("input[name=ex_con]").prop('checked', true);
        $("input[name=ex_con]:disabled").prop('checked', false);
    }
    else  $("input[name=ex_con]").prop('checked', false);
});
//]]>
</script>

                        {:}
                        <div class="alert alert-warning">  선정된 심사위원이 없습니다. 아래의 목록에서 심사위원을 선정하거나 초대해주세요.  </div>
                        {/}

<script type="text/javascript">
//<![CDATA[
function edit_ex_noti(_id) {
    var url = '/ajax_v3/edit_ex_notice/';
    var set_data ={
        "id":_id,
        "cont": $('textarea[name=ex_notice]').val(),
    };

    $.post(url, set_data, function(_data){
        alert('저장 되었습니다.');
    });
}
//]]>
</script>