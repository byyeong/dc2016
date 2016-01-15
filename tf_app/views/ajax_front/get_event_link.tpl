<div class="modal-dialog">
        <div class="modal-content">
        
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">이벤트 연결하기</h4>
            </div>
            
            <div class="modal-body">                 
                 <form role="form" onsubmit="return false;" name="e_s_l_form" action="/ajax_front/get_event_link/{res.id}" method="post">
                    <fieldset>
                        <input type="hidden" name="id" value="{res.id}" />
                         <div class="well">
                            <p>{res.purpose} </p>
                            <small>
                                        <span class="spot"><span class="icon icon-map-marker"></span> {res.opt}F {res.name}</span>
                                        <span class="time"><span class="icon icon-time"></span> {res.date} {res.start} ~ {res.end}</span>
                                    </small>
                         </div>
                         
                         <div class="form-group">
                            <label>이벤트 연결 주소 입력하기</label>
                            <div class="input-group">
                                <span class="input-group-addon"><span class="icon-fixed-width icon-link"></span></span>
                                <input type="text" class="form-control" placeholder="http://" name="rel_url" value="{res.rel_url}">
                            </div>
                        </div>
                         
                    </fieldset>
                 </form>
            </div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" onclick="submit_sel('{res.id}'); return false">저장하기</button>
            </div>
        
        </div>
        <!-- modal-content -->
    </div>
    <!-- modal-dialog -->
