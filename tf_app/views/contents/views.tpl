    <!-- rowContent -->
    <div class="rowContent"  id="contents"> 
        <div class="page-header">
            <div class="container">
                <h2><a href="/contents/{res.cid}">Blog</a></h2>
            </div>
        </div>
        <!-- /page-header -->
        
        <!-- page-content -->
        <div class="page-content"> 
            <!-- container -->
            <div class="container">
                <div class="row"> 
                    <!-- content -->
                    <div class="col-xs-12 col-sm-12 col-md-9 content"> 
                        
                        <!-- article -->
                        <div id="article">
                            <div class="article-header">
                                <h3>{res.subject}</h3>
                                <div class="meta">
                                    <span class="category"><a  href="/contents/{res.cid}">{res.cname}</a></span>, 
                                    <span class="author"><a  href="/member/{res.ids}">{res.name}</a></span>, 
                                    <span class="time"><span class="icon-time"></span> {= trans_date_ago(res.date_created)}</span> 
                                    {? res.user_id == s.id} &nbsp;  <span class="modify"><a href="/contents/edit/{res.id}" class="btn btn-default btn-xs">수정하기</a></span>{/}
                                </div>
                             </div> 
                            
                            <div class="article-body">
                                <div class="fb-like" data-href="http://dcamp.kr/contents/views/{res.id}" data-width="The pixel width of the plugin" data-height="The pixel height of the plugin" data-colorscheme="light" data-layout="standard" data-action="like" data-show-faces="true" data-send="false"></div>
                                
                                <!-- article -->
                                <article>{res.contents}</article>
                                <!-- /article -->
                                
                                <!-- post-author -->
                                <div id="aboutAuthor" class="media"> 
                                    <a href="/member/{res.ids}" class="pull-left"> <img class="media-object" src="{res.picture}"> </a>
                                    <div class="media-body">
                                        <h4 class="media-heading">
                                            <a href="/member/{res.ids}">{res.name}</a> 
                                            {? res.com.sid}
                                            <small>
                                                <i class="fa fa-building"></i>
                                                <a href="/startup/{res.com.sid}">{res.com.name}</a>
                                            </small> 
                                            {/}
                                        </h4>
                                        <p>{=htmlspecialchars(res.bio)}</p>
                                   </div>
                                </div>
                                <!-- /post-author -->

                                <div id="ccl" class="media well">
                                    <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/" class="media-left media-middle"><img alt="크리에이티브 커먼즈 라이선스" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" class="media-object"></a>
                                    <div class="media-body">
                                        <a xmlns:cc="http://creativecommons.org/ns#" href="http://dcamp.kr/contents/views/{res.id}" property="cc:attributionName" rel="cc:attributionURL">디캠프</a>에 의해 작성된 <span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">{res.subject}</span>은(는) <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">크리에이티브 커먼즈 저작자표시-비영리-동일조건변경허락 4.0 국제 라이선스</a>에 따라 이용할 수 있습니다.<br><a xmlns:dct="http://purl.org/dc/terms/" href="http://dcamp.kr" rel="dct:source">http://dcamp.kr</a>의 저작물에 기반이 라이선스의 범위 이외의 이용허락을 얻기 위해서는 <a xmlns:cc="http://creativecommons.org/ns#" href="http://dcamp.kr/support/qna" rel="cc:morePermissions">http://dcamp.kr/support/qna</a>을 참조하십시오.
                                    </div>
                                </div>
                            </div> 
                        </div>
                        <!-- /article --> 
                        
                        
                        <div id="comment">
                            
<script type="text/javascript">
//<![CDATA[
get_timeline(6, '{res.id}', 1);
function get_timeline(_type, _id, _page)
{
    var get_url = '/ajax_front/get_timeline/'+_type+'/'+_id+'/'+_page;
    $.get(get_url, function(_data) {
        $('#comment').html(_data);
    });
}
//]]>
</script> 
                        </div>
                        <!-- /comment --> 
                        
                    </div>
                    <!-- /content --> 
                    
                    <!-- sidebar -->
                    <div class="col-xs-12 col-sm-12 col-md-3 sidebar"> 
                        
                        <!-- panel -->
                        <div class="panel  category">
                            <h3 class="panel-title">카테고리</h3> 
                            <ul class="list-unstyled">
                                <li><a href="/contents">전체</a> <small>({acnt})</small></li>
                                {@ cat_list}
                                <li><a href="/contents/{.id}">{.name}</a> <small>({.cnt})</small></li>
                                {/}
                            </ul> 
                        </div>
                        <!-- /panel--> 

                        <form id="search-form" class="" role="search" action="/contents" method="get">
                            <div class="form-group">
                                <input type="search" class="form-control input-sm" placeholder="Search blog" name="key" value="{key}">
                            </div>
                        </form>
                        <br>
                        
                        <!-- panel -->
                        <div class="panel  recentpost">
                            <h3 class="panel-title">많이 본 글</h3> 
                            <ul class="media-list post-list">
                                {@ hot_cont}
                                <li class="media"> 
                                    {?.picture}<a class="pull-left media-object" href="/contents/views/{.id}" style="background-image:url({.picture});"> <img src="/img/trans.png" class="img-responsive" > </a>
                                    {:}
                                    <a class="pull-left media-object" href="/contents/views/{.id}" style="background-image:url({?.img}{.img}{:}/img/default-img-news.png{/});"> <img src="/img/trans.png" class="img-responsive" > </a>
                                    {/}
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/contents/views/{.id}">{.subject}</a></h4>
                                        <div class="media-meta"> 
                                            <span class="category"><a href="/contents/{.cid}">{.cname}</a></span> 
                                            <span class="author"><a href="/member/{.ids}">{.mname}</a></span> 
                                            <span class="time"><span class="icon-time"></span>&nbsp; {= substr(.date_created, 0, 10)}</span>
                                        </div>
                                    </div>
                                    <!-- /media-content --> 
                                </li>
                                {/}
                            </ul> 
                        </div>
                        <!-- /panel --> 
                        
                        <!-- panel -->
                        <div class="panel  recentpost">
                            <h3 class="panel-title">최근 글</h3> 
                            <ul class="media-list post-list">
                                {@ curr_cont}
                                <li class="media"> 
                                    {? .picture}<a class="pull-left media-object" href="/contents/views/{.id}"> <img src="{.picture}" class="img-responsive" > </a>
                                    {:}
                                    <a class="pull-left media-object" href="/contents/views/{.id}"> <img src="{?.img}{.img}{:}/img/default-img-news.png{/}" class="img-responsive" > </a>
                                    {/}
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/contents/views/{.id}">{.subject}</a></h4>
                                        <div class="media-meta">
                                            <span class="category"><a  href="/contents/{.cid}">{.cname}</a></span> 
                                            <span class="author"><a  href="/member/{.ids}">{.mname}</a></span> 
                                            <span class="time"><span class="icon-time"></span>&nbsp; {= trans_date_ago(res.date_created)}</span> 
                                        </div>
                                    </div>
                                    <!-- /media-content --> 
                                </li>
                                {/}
                            </ul> 
                        </div>
                        <!-- /panel--> 

                        <div class="fb-page" data-href="https://www.facebook.com/dcamp.kr" data-width="263" data-small-header="false" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="true" data-show-posts="false"><div class="fb-xfbml-parse-ignore"><blockquote cite="https://www.facebook.com/dcamp.kr"><a href="https://www.facebook.com/dcamp.kr">D.CAMP</a></blockquote></div></div>
                        
                    </div>
                    <!-- /sidebar --> 
                </div>
            </div>
            <!-- /container --> 
        </div>
        <!-- /page-content --> 
    </div>
    <!-- /rowContent --> 