    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">심사위원 거절 사유 보기  </h4>
            </div>
            <!-- modal-body -->
            <div class="modal-body"> 
                 <div class="member-info">
                    <div class="row">
                        {? res.picture}<div class="col-md-4"> <img src="{res.picture}" class="img-responsive"> </div>{/}
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
                                <dd>
                                    {?res.memail}<a href="mailto:{res.memail}">{res.memail}</a>
                                    {:}<a href="mailto:{res.email}">{res.email}</a>{/}
                                </dd>
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
                        <dt>거절사유</dt>
                        <dd>{res.des}</dd>
                    </dl> 
                </div>
                <!-- /member-detail --> 

            </div>
            <!-- /modal-body -->
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
            </div>
        </div>
        <!-- /modal-content --> 
    </div>
    <!-- /modal-dialog --> 