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
                    <li role="presentation" class="active">
                        <a href="/support">FAQ</a>
                    </li>
                    <li role="presentation">
                        <a href="/support/qna">Q&amp;A</a>
                    </li>
                </ul>
                <!-- /nav-tabs -->
                
                <!-- faq -->
                <div id="faq">
                    <div class="content-header">
                        <h3><a href="/support">FAQ</a></h3>
                    </div> 

                    <div class="table-responsive">
                        <table class="table table-stripe">
                            <thead>
                                <th width="60">번호</th>
                                <th width="240">분류</th>
                                <th>제목</th> 
                            </thead>
                            <tbody>
                                {? faq}
                                {@ faq}
                                <tr>
                                    <td>{.key_ + 1}</td>
                                    <td>{.category}</td>
                                    <td class="td-subject"><a href="/support/views/{.id}">{.title}</a></td> 
                                </tr>
                                {/}
                                {:}
                                <td colspan="3">등록된 FAQ가 없습니다.</td>
                                {/}
                            </tbody>
                        </table>
                    </div>
                    <!-- /table -->
                    {? faq}
                    <nav class="paging">
                        <ul class="pagination">
                            {?page == 1}
                            <li class="disabled"><a href="#">&laquo;</a></li>
                            {:}
                            <li><a href="/support/{page - 1}">&laquo;</a></li>
                            {/}

                            {@paging.pages}
                            {?.type == "dot"}
                            <li class="disabled"><a href="#">...</a></li>
                            {:}
                            <li {?.type == "current"}class="active"{/}><a href="/support/{.page}">{.page}</a></li>
                            {/}
                            {/}

                            {?page == paging.tot_page}
                            <li class="disabled"><a href="#">&raquo;</a></li>
                            {:}
                            <li><a href="/support/{page + 1}" >&raquo;</a></li>
                            {/}
                        </ul>
                    </nav>
                    {/}
                    <!-- /paging -->
                </div>
                <!-- /faq -->

                <!-- /End Contents --> 
            </div>
        </div>
        <!-- /page-content -->
    </div>
    <!-- /rowContent -->