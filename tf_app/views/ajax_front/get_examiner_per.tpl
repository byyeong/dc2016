    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">심사위원 정보 </h4>
            </div>
            <!-- modal-body -->
            <div class="modal-body">
                <div class="member-info">
                    <div class="row">
                        {?res.picture}<div class="col-md-4"> <img src="{res.picture}" class="img-responsive"> </div>{/}
                        <div class="col-md-8">
                            <dl class="dl-horizontal">
                                <dt>이름</dt>
                                <dd><a href="/member/{res.ids}"><strong>{res.name}</strong></a></dd>
                            </dl>
                            <dl class="dl-horizontal">
                                <dt>아이디</dt>
                                <dd>{res.ids}</dd>
                            </dl>
                            <dl class="dl-horizontal">
                                <dt>이메일</dt>
                                <dd><a href="mailto:{res.email}">{res.email}</a></dd>
                            </dl>
                            <dl class="dl-horizontal">
                                <dt>전화번호</dt>
                                <dd>{res.tel}</dd>
                            </dl>
                            {? res.com}
                            <dl class="dl-horizontal">
                                <dt>소속/역할</dt>
                                <dd><a href="/startup/{res.com.id}">{res.com.name}</a> {?res.com.role}/ {res.com.role}{/}</dd>
                            </dl>
                            {/}
                        </div>
                    </div>
                </div>
                <!-- /member-info -->
                
                <div class="member-detail">
                    <dl class="dl-horizontal">
                        <dt>자기소개</dt>
                        <dd>{=htmlspecialchars(res.bio)}</dd>
                    </dl>
                    <dl class="dl-horizontal">
                        <dt>심사위원 이력</dt>
                        <dd>
                            <ul>
                                {@ res.comp}
                                <li><a href="/competition/views/{.id}">{.subject}</a></li>
                                {/}
                            </ul>
                        </dd>
                    </dl>
                </div>
                <!-- /member-detail --> 
                
                <div class="member-memo">
                    <div class="form-group">
                        <label class="text-danger"><span class="icon-warning-sign"></span> 메모</label>
                        <textarea disabled="" rows="3" class="form-control">{res.admin_des}</textarea>
                    </div>
                </div>
            </div>
            <!-- /modal-body -->
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
                <!--<button type="button" class="btn btn-primary">확인</button>-->
            </div>
        </div>
        <!-- /modal-content --> 
    </div>
    <!-- /modal-dialog --> 