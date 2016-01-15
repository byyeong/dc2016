    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3 class="modal-title">작성한 경진대회 목록 </h3>
            </div>
            <!-- /modal-header -->
            <div class="modal-body"> 

                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th width="60" class="td-select"><span class="icon-check"></span></th>
                                <th class="td-name">제목</th> 
                                <th class="td-date">날짜</th>
                            </tr>
                        </thead>
                        <tbody>
                            {? res}
                            {@ res}
                            <tr>
                                <td class="td-select"><input type="radio" name="pick" value="{.id}"></td>
                                <td class="td-subject"><a href="/challenge/views/{.id}" target="_blank">{.subject}{? .department} - {.department}{/}</a></td>
                                <td class="td-date">{.date_s} ({=date_to_day_only(.date_s)}) {.time_s} ~ {.date_e} ({=date_to_day_only(.date_e)}) {.time_e}</td>
                            </tr>
                            {/}
                            {:}
                            <tr>
                                <td class="td-select">개최했던 경진대회 내역이 없습니다.</td>
                            </tr>
                            {/}
                        </tbody>
                    </table>
                </div>

            </div>
            <!-- /modal-body -->
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" onclick="pick_oc();">확인</button>
            </div>
            <!-- /modal-footer --> 
        </div>
        <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 