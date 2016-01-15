             
                <div class="content col-xs-12 col-sm-12 col-md-9">
                    <div class="content-header">
                        <button class="btn btn-primary btn-sm pull-right" onclick="javascript:location.href='/contents/edit/'"><span class="icon-fixed-width icon-large icon-edit"></span> 콘텐츠 작성하기</button>
                        <h3 class="content-heading"> <span class="icon-file-text"></span> 콘텐츠 관리 </h3>
                    </div>
                    <div class="tab-content">
                        <div class="tab-pane active" id="writed-list"> {? res}
                            <!-- ul class="media-list post-list">
                                {@ res}
                                <li class="media"> {?.img}<a class="pull-left" href="/contents/views/{.id}"> <img src="{.img}" class="media-object" > </a>{/}
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/contents/views/{.id}">{.subject}</a></h4>
                                        <button onclick="javascript:location.href='/contents/edit/{.id}'" class="btn btn-default btn-xs">Edit</button>
                                        {? .state == 1}<span class="label label-success">승인</span>{/}
                                        {? .state == 0}<span class="label label-warning">승인대기</span>{/}
                                        <p>{= strip_tags(.contents)} </p>
                                        <div class="media-actions"> <span class="category"><a  href="/contents/{.cid}">{.cname}</a></span> <span class="author"><a  href="/member/{.ids}">{.mname}</a></span> 
                                        <span class="time"><span class="icon-time"></span>&nbsp; {= trans_date_ago(.date_created)}</span> </div>
                                    </div> 
                                </li> 
                                {/}
                            </ul -->
                            
                            <div class="table-responsive">
                                <table class="table table-hover table-striped">
                                    <thead>
                                        <tr>
                                            <th class="td-num" width="60">번호</th>
                                            <th class="td-status" width="60">상태</th>
                                            <th class="td-subject">제목</th>
                                            <th class="td-cat" width="160">카테고리</th>
                                            <th class="td-date" width="160">작성일</th>
                                            <th class="td-manage" width="80">관리</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {@ res}
                                        <tr  id="cont_{.id}">
                                            <td class="td-num">{= res_cnt - (pagesize*(page-1) + .key_)}</td>
                                            <td class="td-status"> 
                                                {? .state == 1}<span class="label label-success">승인</span>{/}
                                                {? .state == 0}<span class="label label-warning">승인대기</span>{/}
                                            </td>
                                            <td class="td-subject">
                                                <!--
                                                {?.img}<a class="pull-left media-object" href="/contents/views/{.id}"> <img src="{.img}" class="img-responsive" > </a>{/}
                                                -->
                                                <a href="/contents/views/{.id}">{.subject}</a> 
                                                <!--<p class="ellipsis">{= strip_tags(.contents)} </p>-->
                                            </td>
                                            <td class="td-cat"><a  href="/contents/{.cid}">{.cname}</a></td>
                                            <td class="td-date">{= trans_date_ago(.date_created)}</td>
                                            <td class="td-manage">  
                                                <a title="수정하기" data-toggle="tooltip" class="btn btn-default btn-xs" href="/contents/edit/{.id}" > 
                                                    <span class="icon-fixed-width icon-pencil"></span> <span class="sr-only">Edit</span> 
                                                </a> &nbsp;                                                 
                                                <button data-toggle="tooltip" class="btn btn-danger btn-xs" type="button" title="삭제" onclick="del_cont('{res.id}'); return false;"> 
                                                    <span class="icon-fixed-width icon-trash"></span> <span class="sr-only">삭제</span> 
                                                </button>
                                            </td>
                                        </tr>
                                        {/}
                                    </tbody>
                                </table>
                            </div>
                            
                            <div class="paging text-center">
                                <ul class="pagination" style=" margin: 0;">
                                    {?page == 1}
                                    <li class="disabled"><a href="#">&laquo;</a></li>
                                    {:}
                                    <li><a href="/member/edit_contents/{page - 1}">&laquo;</a></li>
                                    {/}

                                    {@paging.pages}
                                    {?.type == "dot"}
                                    <li class="disabled"><a href="#">...</a></li>
                                    {:}
                                    <li {?.type == "current"}class="active"{/}><a href="/member/edit_contents/{.page}">{.page}</a></li>
                                    {/}
                                    {/}

                                    {?page == paging.tot_page}
                                    <li class="disabled"><a href="#">&raquo;</a></li>
                                    {:}
                                    <li><a href="/member/edit_contents/{page + 1}" >&raquo;</a></li>
                                    {/}
                                </ul>
                            </div>
                            <!-- /paging -->
                            
                            {:}
                            <div class="alert alert-info">
                                <p><strong>Oops!</strong> 작성한 콘텐츠가 없습니다.  콘텐츠를 작성해주세요.</p>
                            </div>
                            {/} 
                        </div>
                        <!-- /tab-pane -->

                    </div>
                    <!-- /tab-content --> 
                    
                </div>
                <!-- /content --> 
                
<script type="text/javascript">
//<![CDATA[
function del_cont(_id) {
    msg_confirm('del_cont_('+_id+')', '정말 삭제 하겠습니까?');
}

function del_cont_(_id) {
    
    var _url = '/ajax_front/del_cont/'+_id;
    $.get(_url, function (){
        $('#cont_'+_id).remove();
        $('.modal').modal('hide');
    });
        
}
//]]>
</script>