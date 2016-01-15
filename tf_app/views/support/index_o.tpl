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

                {? faq}
                <div id="faq">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-2 left">
                            <h3>FAQ</h3>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-10 right">
                            
                            <!-- panel-group -->
                            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                                {@ faq}
                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="headingOne"> 
                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne{.id}" aria-expanded="true" aria-controls="collapseOne">
                                        {.title}
                                        </a> 
                                    </div>
                                    <div id="collapseOne{.id}" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                                        <div class="panel-body">
                                        {.content}
                                        </div>
                                    </div>
                                </div> 
                                <!-- /panel -->
                                {/}
                            </div>
                            <!-- /panel-group -->

                        </div>
                    </div>
                </div>
                <!-- /faq -->
                {/}

                <div id="qna">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-2 left">
                            <h3>Q&amp;A</h3>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-10 right">

                            <div class="table-toolbar"> 
                                {? s.id}
                                <a href="/support/add" class="btn btn-default btn-sm pull-right">
                                    <i class="fa fa-pencil-square-o"></i>
                                    문의하기
                                </a>
                                {:}
                                <a href="/login" class="btn btn-default btn-sm pull-right">
                                    <i class="fa fa-pencil-square-o"></i>
                                    로그인 후 문의하기
                                </a>
                                {/}
                                <div class="form-inline">
                                    <form method="get" action="/support" />
                                        <select class="form-control input-sm" name="category">
                                            <option value="0" {? c == 0}selected{/}>전체</option>
                                            {@ category}
                                            <option value="{.id}" {? c == .id}selected{/}>{.category}</option>
                                            {/}
                                        </select>
                                        <div class="input-group input-group-sm" id="searchbar">
                                            <input type="text" name="q" class="form-control" value="{q}" required>
                                            <span class="input-group-btn">
                                                <button class="btn btn-default" type="submit">
                                                    <span class="glyphicon glyphicon-search"></span><span class="sr-only">검색</span>
                                                </button>
                                            </span>
                                        </div>
                                    </form>
                                </div>

                            </div>

                            <div class="table-responsive">
                                <table class="table table-stripe">
                                    <thead>
                                        <th>번호</th>
                                        <th>분류</th>
                                        <th>제목</th>
                                        <th>작성자</th>
                                        <th>작성일</th>
                                        <th>상태</th>
                                    </thead>
                                    <tbody>
                                        {? qna}
                                        {@ qna}
                                        <tr>
                                            <td>{= qna_c - (pagesize*(page-1) + .key_)}</td>
                                            <td>{.category}</td>
                                            <td>{? !.open}<span class="icon-lock text-warning"></span> {/}<a href="/support/views/{.id}">{.title}</a></td>
                                            <td>{.name}</td>
                                            <td>{=str_replace('-', '.', substr(.date_created,0,10))}</td>
                                            <td>
                                                {? .re_suc}
                                                <span class="label label-success">처리완료</span>
                                                {:}
                                                <span class="label label-primary">처리중</span>
                                                {/}
                                            </td>
                                        </tr>
                                        {/}
                                        {:}
                                        <tr>
                                            <td colspan="6">등록된 Q&A가 없습니다.</td>
                                        </tr>
                                        {/}
                                    </tbody>
                                </table>
                            </div>
                            {? qna}
                            <nav class="paging">
                                <ul class="pagination">
                                    {?page == 1}
                                    <li class="disabled"><a href="#">&laquo;</a></li>
                                    {:}
                                    <li><a href="/support/{page - 1}?category={c}&q={q}">&laquo;</a></li>
                                    {/}

                                    {@paging.pages}
                                    {?.type == "dot"}
                                    <li class="disabled"><a href="#">...</a></li>
                                    {:}
                                    <li {?.type == "current"}class="active"{/}><a href="/support/{.page}?category={c}&q={q}">{.page}</a></li>
                                    {/}
                                    {/}

                                    {?page == paging.tot_page}
                                    <li class="disabled"><a href="#">&raquo;</a></li>
                                    {:}
                                    <li><a href="/support/{page + 1}?category={c}&q={q}" >&raquo;</a></li>
                                    {/}
                                </ul>
                            </nav>
                            {/}
                        </div>
                    </div>
                </div>
                <!-- /qna -->

                <!-- /End Contents --> 
            </div>
        </div>
        <!-- /page-content -->
    </div>
    <!-- /rowContent -->

<script>
$('select[name=category]').change(function(){
    _to = $("select[name=category] option:selected").val();
    window.location.href="/support/1?category="+_to;
});
</script>