    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">선정이력 - 사용자이름</h4>
            </div>
            <div class="modal-body">

                <div class="table-responsive">
                    <table class="table table-hover table-striped">
                        <thead>
                            <tr>
                                <th width="50" class="td-num">번호</th> 
                                <th class="td-date">날짜</th>
                                <th class="td-subject">제목</th>
                                <th class="td-status">선정여부</th>
                            </tr>
                        </thead>
                        <tbody>
                            {@ res}
                            <tr>
                                <td class="td-num">{=sizeof(res) - .key_}</td> 
                                <td class="td-date">{=substr(.e_start, 0, 10)}</td>
                                <td class="td-subject">{.subject}</td>
                                <td class="td-status">
                                    {? .astatus == 1}
                                    <span class="label label-success">선정</span>
                                    {:}
                                    <span class="label label-default">미선정</span>
                                    {/}
                                </td>
                            </tr>
                            {/}
                        </tbody> 
                    </table>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>