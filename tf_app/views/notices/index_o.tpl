<!-- rowContent -->
<div class="rowContent"  id="news"> 
    <!-- page-header -->
    <div class="page-header">
        <div class="container">
            <h1>뉴스 <small>News</small></h1>
        </div>
    </div>
    <!-- /page-header --> 
    
    <!-- page-content -->
    <div class="page-content"> 
        <!-- container -->
        <div class="container">
            <ul class="nav nav-tabs">
                <li><a href="/notice/startup">스타트업 뉴스</a></li>
                <li  class="active"><a href="/notice" >D.CAMP 뉴스</a></li>
                <li><a href="/notice/notice" >공지사항</a></li>
            </ul>
            
            <!-- content -->
            <div class="content" id="news-list">
                <h3>D.CAMP 뉴스 </h3>
                <ul class="media-list">
                    {@ res}
                    <li class="media"> 
                        <!--
                        <a href="#" class="pull-left"> <img   data-src="holder.js/80x80" class="media-object" style="width: 80px; height: 80px;"> </a>
                        //-->
                        <div class="media-body">
                            <div class="media-heading">
                                <h4><a href="/notice/views/{.type}/{.id}">{.title} </a></h4>
                                <span class="time"><span class="icon icon-time"></span>&nbsp; {=str_replace("-", ".", substr(.date_created, 0, 10))}</span> </div>
                            <p>{=strip_tags(.contents)}</p>
                        </div>
                    </li>
                    {/}
                    <!-- /media -->
                </ul>
                {? more}
                <div class="paging text-center"> <a class="btn btn-default" href="#" onclick="more_news(this,'{type}','{n_page}'); return false;"> ↓  더보기</a> </div>
                {/}
            </div>
            <!-- /content --> 
        </div>
        <!-- /container --> 
    </div>
    <!-- /page-content --> 
</div>
<!-- /rowContent --> 

<script type="text/javascript">
//<![CDAT

function more_news(_this, _type, _page){

    var get_url = "/ajax_front/more_notice/"+_type+"/"+_page;
    var n_p = parseInt(_page)+1
    $.post(get_url, function(_data) {
        if (_data !== '') {
            $('#news-list ul').append(_data);
            $(_this).attr('onclick', "more_news(this,"+_type+","+n_p+"); return false;");
        } else {
            $(_this).parent().remove();
            alert("마지막 페이지입니다.");
        }
    });
}

//]]>
</script> 