<!-- rowContent -->
<div class="rowContent"  id="notice"> 
    <!-- page-header -->
    <div class="page-header">
        <div class="container">
            <h2><a href="/notice">Notice</a></h2>
        </div>
    </div>
    <!-- /page-header --> 
    
    <!-- page-content -->
    <div class="page-content"> 
        <!-- container -->
        <div class="container">
            
            <div class="row">
                
                <div class="col-xs-12 col-sm-12 col-md-9 content" >
                     
                    <!-- media-list -->
                    <ul class="media-list post-list">
                        {@ res}
                        <li class="media"> 
                            {? .main}<a class="pull-left media-object" href="/notice/views/{.type}/{.id}"> <img src="{.main}" class="img-responsive" > </a>{/}
                            <div class="media-body">
                                <h3 class="media-heading"><a href="/notice/views/{.type}/{.id}">{.title}</a></h3>
                                <p class="ellipsis">{=strip_tags(.contents)}</p>
                                <div class="media-meta"> 
                                    <!--span class="category">{? .type == 1}News{/}{? .type == 3}Notice{/} </span-->
                                    {?.wr} 
                                    <span class="author"><a  href="/member/{.wr.ids}"><img src="{.wr.picture}" class="img-circle"> {.wr.name}</a></span>
                                    {/} 
                                    <span class="time"><span class="icon-time"></span>&nbsp; {=trans_date_ago(.date_created)}</span> 
                                </div>
                            </div>
                            <!-- /media-content --> 
                        </li>
                        <!-- /media -->
                        {/}
                    </ul>
                    <input type="hidden" id="page" value="{page}" />
                    {? sizeof(res) > 9}
                    <div class="pager"> <a href="#" class="btn btn-default" onclick="more_notice(); return false;"> &darr;  더보기</a> </div>
                    {/}
                    <!-- /media-list -->
                </div>
                <!-- /content -->
                
                <!-- sidebar -->
                <div class="col-xs-12 col-sm-12 col-md-3 sidebar"> 
                     <iframe src="http://www.facebook.com/plugins/likebox.php?href=http%3A%2F%2Fwww.facebook.com%2Fdcamp.kr&amp;width=210&amp;colorscheme=light&amp;show_faces=true&amp;border_color=%23F0ECE3&amp;stream=true&amp;header=false&amp;height=608" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:210px; height:608px;" allowTransparency="true"></iframe>
                </div>
                <!-- /sidebar --> 
            </div>
            <!-- /row --> 
        </div>
        <!-- /container --> 
    </div>
    <!-- /page-content --> 
</div>
<!-- /rowContent --> 

<script type="text/javascript">
//<![CDAT

function more_notice () {
    var _page = parseInt($('#page').val());
    _page = _page + 1;
    var get_url = '/ajax_front/more_notice2/'+ _page;
    $.get(get_url, function(_data) {
        if (_data) {
            $('#page').val(_page);
            $('.post-list').append(_data);
        }
        else {
            $('.pager').hide();
            alert('마지막 페이지 입니다.');
        }
    });
}

//]]>
</script> 