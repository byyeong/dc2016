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
                {? banner.pic_1 && banner.active_1}
                <div style="background-image:url({banner.pic_1});" class="header-banner">
                    <a href="{banner.des_3}">
                        <div class="inner">
                            <h3>{banner.des_1}</h3>
                            <p>{banner.des_2}</p>
                        </div>
                    </a>
                </div>
                {/}
                
                <div class="row"> 
                
                    <!-- content -->
                    <div class="col-xs-12 col-sm-12 col-md-9 content">  
                        
                        {? cat}
                        <div class="media-title">  
                            <div class="caption"> 
                                <h3>{cat.name}</h3>
                                {?cat.des}<p>{cat.des}</p>{/}
                            </div>
                        </div>
                        {/} 

                        <!-- media-list -->
                        <ul class="media-list post-list c_post-list">
                            {@ res}
                            <li class="media row"> 
                                
                                {? .picture}<a class="pull-left media-object col-xs-12 col-sm-3 col-md-3" href="/contents/views/{.id}"> <img src="{.picture}" class="img-responsive" > </a>
                                {:}
                                {?.img}<a class="pull-left media-object col-xs-12 col-sm-3 col-md-3" href="/contents/views/{.id}"> <img src="{.img}" class="img-responsive" > </a>{/}
                                {/}

                                <div class="media-body {? .img || .picture}col-xs-12 col-sm-9 col-md-9{:}col-xs-12 col-sm-12 col-md-12{/}">
                                    <h3 class="media-heading"><a href="/contents/views/{.id}">{.subject}</a>
                                    </h3>
                                     
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12col-md-12">
                                            <p class="ellipsis80">{=substr(strip_tags(.contents), 0, 800)}</p>
                                        </div>
                                    </div> 


                                    <div class="media-meta"> <span class="category"><a  href="/contents/{.cid}">{.cname}</a></span>
                                        <span class="sep"></span>
                                        <span class="author"><a  href="/member/{.ids}"><img class="img-circle" src="{.mpicture}"> {.mname}</a></span>
                                        <span class="time"><span class="icon-time"></span>&nbsp; {= trans_date_ago(.date_created)}</span></div>
                                </div>
                            </li>
                            {/}
                        </ul>
                        <input type="hidden" id="page" value="1" />
                        {? sizeof(res) > 9}
                        <div class="pager"> <a href="#" class="btn btn-default" onclick="more_content(); return false;"> &darr;  더보기</a> </div>
                        {/}  
                        
                    </div>
                    <!-- /content --> 
                    
                    <!-- sidebar -->
                    <div class="col-xs-12 col-sm-12 col-md-3 sidebar"> 
                        
                        <!-- panel -->
                        <div class="panel  category">
                            <h3 class="panel-title">카테고리</h3> 
                            <ul class="list-unstyled">
                                <li>{? !cat}<b>{/}<a href="/contents">전체</a> <small>({acnt})</small>{? !cat}</b>{/}</li>
                                {@ cat_list}
                                <li>{? cat.id == .id}<b>{/}<a href="/contents/{.id}">{.name}</a> <small>({.cnt})</small>{? cat.id == .id}</b>{/}</li>
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

                        <div class="panel">
                            <div class="fb-page" data-href="https://www.facebook.com/dcamp.kr" data-width="263" data-small-header="false" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="true" data-show-posts="false"><div class="fb-xfbml-parse-ignore"><blockquote cite="https://www.facebook.com/dcamp.kr"><a href="https://www.facebook.com/dcamp.kr">D.CAMP</a></blockquote></div></div>
                        </div>
                        
                    </div>
                    <!-- /sidebar --> 
                    
                    
                </div>
            </div>
            <!-- /container --> 
        </div>
        <!-- /page-content --> 
    </div>
    <!-- /rowContent --> 
<script type="text/javascript">
//<![CDAT
$(document).ready(function() {
    _p = parseInt($('#page').val());
    if (_p > 1) {
        for (i = 2; i < _p+1; i++) { 
            more_content (i);
        }
    }
});
function more_content (_id) {
    if (!_id) {
        var _page = parseInt($('#page').val());
        _page = _page + 1;
    }
    else 
        var _page = _id;

    
    var get_url = '/ajax_front/more_contents/{cid}/'+ _page+"?key={key}";
    $.get(get_url, function(_data) {
        if (_data) {
            $('#page').val(_page);
            $('.c_post-list').append(_data);

            $(".ellipsis80").dotdotdot({
                height           : 80
            });
        }
        else {
            $('.pager').hide();
            alert('마지막 페이지 입니다.');
        }
    });
}

//]]>
</script> 