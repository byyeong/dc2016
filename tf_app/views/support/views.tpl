    <!-- rowContent -->
    <div id="support" class="rowContent"> 
        <!-- page-header -->
        <div class="page-header">
            <div class="container">
                <h2><a href="/support">Member  Support</a></h2>
            </div>
        </div>
        <!-- /page-header -->

        <!-- page-content -->
        <div class="page-content"> 
            <div class="container"> 
                <!-- Start Contents -->

                <ul class="nav nav-tabs">
                    <li role="presentation" {?res.type == 1}class="active"{/}>
                        <a href="/support">FAQ</a>
                    </li>
                    <li role="presentation" {?res.type == 2}class="active"{/}>
                        <a href="/support/qna">Q&amp;A</a>
                    </li>
                </ul>
                <!-- /nav-tabs -->

                <div id="qna">
                    <div class="content-header">
                        <h3>
                            {?res.type == 1}<a href="/support">FAQ</a>{/}
                            {?res.type == 2}<a href="/support/qna">Q&amp;A</a>{/}
                        </h3>
                    </div>
                    {?res.type == 1}
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">[{res.cat.category}] {res.title}</h3>
                        </div>
                        <div class="panel-body"> 
                            <article>
                                {res.content}
                            </article> 
                        </div>
                    </div>
                    {/}
                    {?res.type == 2}    
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">[{res.cat.category}] {res.title}</h3>
                        </div>
                        <div class="panel-body">
                            <dl class="dl-horizontal">
                                <dt>작성자</dt>
                                <dd>{res.name}</dd>

                                {? res.cat.user_id == s.id}
                                <dt>전화번호 </dt>
                                <dd>{res.tel}</dd>
                                <dt>이메일 </dt>
                                <dd>{res.email}</dd>
                                <dt>공개여부 </dt>
                                <dd>{? res.open}공개{:}비공개{/}</dd>
                                {/}

                                <dt>작성일</dt>
                                <dd>{=str_replace('-', '.', substr(res.date_created,0,10))}</dd>
                                <dt>질문내용</dt>
                                <dd>
                                    <article>
                                        {res.content}
                                    </article>
                                </dd>
                            </dl>
                        </div>
                        {? res.cat.user_id == s.id}
                        <div class="panel-footer">
                            <form class="form-horizontal" method="post" action="/support/views/{res.id}" id="qna_f">
                                <fieldset>
                                    <div class="form-group"> 
                                        <span class="col-lg-2 control-label"> 담당자 </span>
                                        <div class="col-lg-10"> 
                                            <select class="selectpicker" name="category">
                                                {@ category}
                                                <option value="{.id}" {? res.cat.id == .id}selected{/}>{.category} - {.name} </option>
                                                {/}
                                            </select>
                                            <span class="btn btn-primary" onclick="send_ch_cat(this, '{res.id}'); 
                                            return false;"> 담당자 변경 (메일을 보냅니다)</span>
                                        </div>
                                    </div>
                                    <!-- /form-group --> 

                                    <div class="form-group"> 
                                        <span class="col-lg-2 control-label"> 답변하기</span>
                                        <div class="col-lg-10"> 
                                          <textarea rows="6" class="form-control" name="content" placeholder="내용을 입력해 주세요">{res.act.content}</textarea>
                                        </div>
                                    </div>
                                    <!-- /form-group --> 

                                    <div class="form-group form-submit"> 
                                        <div class="col-lg-offset-2">
                                            <button type="button" class="btn btn-default" onclick="javascript='location.href=/admin_manage/qna'">취소</button>
                                            <button type="submit" class="btn btn-primary" id="submit_b">저장</button>
                                        </div>
                                    </div>
                                    <input type="hidden" name="parent" value="{res.id}" />
                                    <input type="hidden" name="p_id" value="{res.act.id}" />
                                    <input type="hidden" name="user_id" value="{s.id}" />
                                    <input type="hidden" name="emailer" value="{res.email}" />
                                </fieldset>
                            </form>
                        </div>
                        {:}
                        {? res.act}
                        <div class="panel-footer">
                            <dl class="dl-horizontal">
                                <dt>답변자 </dt>
                                <dd>{res.cat.name}</dd>
                                <dt>답변내용</dt>
                                <dd>
                                    <article>
                                        {res.act.content}
                                    </article>
                                </dd>
                            </dl>
                        </div>
                        {/}
                        {/}

                    </div>
                    {/}
                    <nav class="paging">
                        {?res.type == 1}<a href="/support" class="btn btn-default">목록보기</a>{/}
                        {?res.type == 2}<a href="/support/qna" class="btn btn-default">목록보기</a>{/}
                    </nav>
                        
                </div>


                <!-- /End Contents --> 
            </div>
        </div>
        <!-- /page-content -->
    </div>
    <!-- /rowContent -->

<script>
$('#submit_b').click(function(){
    $(this).attr("disabled", "disabled");
    document.getElementById("qna_f").submit();
});
</script>