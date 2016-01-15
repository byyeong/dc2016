<!-- rowContent -->
<div class="rowContent"  id="notice">  
    
    <div class="page-header">
            <div class="container">
                <h2><a href="/notice">Notice</a></h2>
            </div>
        </div>        
    <!-- /page-header -->
    
    <div class="page-content"> 
        <!-- container -->
        <div class="container">  
                <div class="row">
                 
                    <!-- content -->
                    <div class="col-xs-12 col-sm-12 col-md-9 content">
                        <div id="article">
                            <div class="article-header">
                                <h3> {res.title} </h3>
                                <div class="meta">
                                    <span class="category">{? type == 1}News{/}{? type == 3}Notice{/}</span>,{?res.wr} <span class="author"><a  href="/member/{res.wr.ids}">{res.wr.name}</a></span>,{/} 
                                    <span class="time"><span class="icon icon-time"></span>&nbsp; {=str_replace("-", ".", substr(res.date_created, 0, 10))}</span> 
                                </div>
                            </div>
                            
                            <div class="article-body">
                                <div class="fb-like" data-href="http://dcamp.kr/notice/views/{res.id}" data-width="The pixel width of the plugin" data-height="The pixel height of the plugin" data-colorscheme="light" data-layout="standard" data-action="like" data-show-faces="true" data-send="false"></div>
                                
                                <article> {res.contents} </article>
                            </div>
                        </div>
                        <!-- / article --> 
                         
                        <div id="comment">
<script type="text/javascript">
//<![CDATA[
get_timeline(5, '{res.id}', 1);
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
                        
                        <!-- pager -->
                        <!--
                        <ul class="pager">
                            <li><a href="#">&larr; 이전</a></li>
                            <li><a href="#">다음 &rarr;</a></li>
                        </ul>
                        //-->
                        <!-- /pager --> 
                    </div>
                    <!-- / content -->
                    
                    <!-- sidebar --> 
                    <div class="col-xs-12 col-sm-12 col-md-3 sidebar">
                        <!--
                        {@ s_res}
                        <div class="item">
                            <div class="inner"> 
                                <a href="/notice/views/{.type}/{.id}">
                                    <h3>{.title}</h3>
                                    <div class="metainfo"> 
                                        <span class="type">{? .type == 1}News{/}{? .type == 3}Notice{/}</span>
                                        <span class="date">{=str_replace("-", ".", substr(.date_created, 0, 10))}</span> 
                                        <span class="icon-caret-right">
                                    </div>
                                </a>
                            </div>
                        </div>
                        {/}
                        -->
                        
                        <!-- panel -->
                        <div class="panel  recentpost">
                            <h3 class="panel-title">Recent Notice</h3> 
                            <ul class="media-list post-list">
                                {@ s_res}
                                <li class="media"> 
                                    {?.img}<a class="pull-left media-object" href="/notice/views/{.type}/{.id}"> <img src="{.img}" class="img-responsive" > </a>{/}
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/notice/views/{.type}/{.id}">{.title}</a></h4>
                                        <div class="media-meta">
                                            <!-- span class="type">{? .type == 1}News{/}{? .type == 3}Notice{/}</span -->
                                            <span class="date">{=str_replace("-", ".", substr(.date_created, 0, 10))}</span> 
                                        </div>
                                    </div>
                                    <!-- /media-content --> 
                                </li>
                                {/}
                            </ul> 
                        </div>
                        <!-- /panel-->
                     
                    </div>
                    <!-- / sidebar --> 
                    
            </div> 
        </div>
        <!-- /container --> 
    </div>
    <!-- /page-content --> 
</div>
<!-- /rowContent --> 