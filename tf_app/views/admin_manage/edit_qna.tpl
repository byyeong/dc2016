            <!-- contentwrap -->
            <div class="col-md-10 contentswrap">
                <!-- section -->
                <section> 
                    
                    <!-- panel #pane-qna-read -->
                    <div id="pane-qna-read"class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2>
                                <a href="qna-list.html">
                                    <span class="glyphicon glyphicon-arrow-left"></span><span class="sr-only">목록</span>
                                </a>
                                <span class="break"></span>
                                {q.title}
                            </h2>
                        </div>
                        <!-- /panel-heading -->
                            <!-- panel-body -->
                            <div class="panel-body">
                                

                                <dl class="dl-horizontal">
                                    <dt>분류 </dt>
                                    <dd>{q.category}</dd>
                                    <dt>작성자</dt>
                                    <dd>{q.name}</dd>
                                    <dt>전화번호</dt>
                                    <dd>{q.tel}</dd>
                                    <dt>이메일</dt>
                                    <dd>{q.email}</dd>
                                    <dt>작성일</dt>
                                    <dd>{q.date_created}</dd>
                                    <dt>공개여부</dt>
                                    <dd>{? q.open}공개{:}비공개{/}</dd>
                                </dl>
                                <article>
                                    {=add_brs(q.content)}
                                </article>
                            </div>
                            <!-- /panel-body -->
                            <!-- panel-footer -->
                            <div class="panel-footer">
                                <form class="form-horizontal" method="post" action="/admin_manage/edit_qna/{q.id}">
                                    <fieldset>
                                        <div class="form-group"> 
                                            <span class="col-lg-2 control-label"> 담당자 </span>
                                            <div class="col-lg-10"> 
                                                <select class="selectpicker" name="category">
                                                    {@ cat}
                                                    <option value="{.id}" {? q.cat == .id}selected{/}>{.category} - {.name}</option>
                                                    {/}
                                                </select>
                                                <span class="btn btn-primary" onclick="send_ch_cat(this, '{q.id}'); return false;"> 담당자 변경 (메일을 보냅니다)</span>
                                            </div>
                                        </div>
                                        <!-- /form-group --> 

                                        <div class="form-group"> 
                                            <span class="col-lg-2 control-label"> 답변하기</span>
                                            <div class="col-lg-10"> 
                                              <textarea rows="6" class="form-control" name="content" placeholder="내용을 입력해 주세요">{ans.content}</textarea>
                                            </div>
                                        </div>
                                        <!-- /form-group --> 

                                        <div class="form-group form-submit"> 
                                            <div class="col-lg-offset-2">
                                                <button type="button" class="btn btn-default" onclick="javascript='location.href=/admin_manage/qna'">취소</button>
                                                <button type="submit" class="btn btn-primary">저장</button>
                                            </div>
                                        </div>
                                        <input type="hidden" name="parent" value="{q.id}" />
                                        <input type="hidden" name="p_id" value="{ans.id}" />
                                        <input type="hidden" name="user_id" value="{s.user_id}" />
                                        <input type="hidden" name="emailer" value="{q.email}" />
                                    </fieldset>
                                </form>
                            </div>
                            <!-- /panel-footer -->
                    </div>
                    <!-- /panel #pane-qna-read--> 
                    
                </section>
                <!-- /section -->
            </div>
            <!-- /contentwrap -->             

<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}

//]]>
</script>