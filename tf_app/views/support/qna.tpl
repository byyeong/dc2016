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
                    <li role="presentation" >
                        <a href="/support">FAQ</a>
                    </li>
                    <li role="presentation" class="active">
                        <a href="/support/qna">Q&amp;A</a>
                    </li>
                </ul>
                <!-- /nav-tabs -->
                
                <!-- qna -->
                <div id="qna">
                    <div class="content-header">
                        <h3><a href="/support/qna">Q&amp;A</a></h3>
                    </div>

                    <div class="table-toolbar"> 
                        <div class="pull-right">
                            {? s.id}
                            <a href="/support/add" class="btn btn-primary btn-sm">
                                <i class="fa fa-pencil-square-o"></i>
                                문의하기
                            </a> 
                            <span class="sep"></span>
                            <a href="/support/qna/1?me=ture" class="btn btn-default btn-sm">
                                내 질문보기
                            </a>
                            {:}
                            <a href="/login" class="btn btn-primary btn-sm">
                                <i class="fa fa-pencil-square-o"></i>
                                로그인 후 문의하기
                            </a> 
                            {/}
                        </div>
                        <div class="form-inline">
                            <form method="get" action="/support" />
                                <select class="form-control input-sm" name="category">
                                    <option value="0" {? c == 0}selected{/}>전체</option>
                                    {@ category}
                                    <option value="{.id}" {? c == .id}selected{/}>{.category}</option>
                                    {/}
                                </select>
                                <div class="input-group input-group-sm" id="searchbar">
                                    <input type="text" value="" name="stx" class="form-control" value="{q}" required>
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" type="submit"><span class="glyphicon glyphicon-search"></span><span class="sr-only">검색</span></button>
                                    </span>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- /table-toolbar -->
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
                                    <td class="td-subject">{? !.open}<span class="icon-lock text-warning"></span> {/}<a href="/support/views/{.id}">{.title}</a></td>
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
                    <!-- /table -->
                    {? qna}
                    <nav class="paging">
                        <ul class="pagination">
                            {?page == 1}
                            <li class="disabled"><a href="#">&laquo;</a></li>
                            {:}
                            <li><a href="/support/qna/{page - 1}?category={c}&q={q}&me={me}">&laquo;</a></li>
                            {/}

                            {@paging.pages}
                            {?.type == "dot"}
                            <li class="disabled"><a href="#">...</a></li>
                            {:}
                            <li {?.type == "current"}class="active"{/}><a href="/support/qna/{.page}?category={c}&q={q}&me={me}">{.page}</a></li>
                            {/}
                            {/}

                            {?page == paging.tot_page}
                            <li class="disabled"><a href="#">&raquo;</a></li>
                            {:}
                            <li><a href="/support/qna/{page + 1}?category={c}&q={q}&me={me}" >&raquo;</a></li>
                            {/}
                        </ul>
                    </nav>
                    {/}
                    <!-- /paging -->
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
    window.location.href="/support/qna/1?me={me}&category="+_to;
});
</script>