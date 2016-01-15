    <!-- rowContent -->
    <div id="product" class="rowContent"> 
        <!-- page-header -->
        <div class="page-header">
            <div class="container">
                <h2><a href="/showcase">Showcase</a></h2>

                <div class="pull-right">
                    <a href="/showcase/edit" class="btn btn-primary btn-sm">
                        제품/서비스 등록하기 
                    </a>
                </div>

            </div>
        </div>
        <!-- /page-header -->

        <!-- page-content -->
        <div class="page-content"> 
            <div class="container"> 
                <!-- Start Contents -->
                <div class="row">

                    <!-- content -->
                    <div class="col-xs-12 col-sm-12 col-md-9 content">
                        
                        <!-- article -->
                        <div class="article product-article">
                            <div class="article-header">
                                <div class="product-status">
                                    {? res.user_id_bz == s.id}<a class="btn btn-default btn-xs pull-right" href="/showcase/edit/{res.id}">수정하기</a>{/}
                                </div>
                                
                            </div>

                            <div class="article-body">    
                                <h3 class="product-heading">{res.name}</h3>
                                {? res.des_ele}
                                <p class="product-pitch">{res.des_ele}</p>{/}
                                

                                <div class="fb-like" data-href="http://dcamp.kr/showcase/views/{res.id}" data-width="The pixel width of the plugin" data-height="The pixel height of the plugin" data-colorscheme="light" data-layout="standard" data-action="like" data-show-faces="true" data-send="false"></div>
                                
                                {? res.img1}
                                <div class="product-thumb">
                                    <div class="thumb-heading"></div>
                                    <div style="background-image:url({res.img1});" class="thumb-img"> 
                                        <img src="/img/trans-4by3.png" class="img-responsive"> 
                                    </div>
                                </div>{/}

                                {? res.des_pro}
                                <article>
                                    {=add_brs(res.des_pro)}
                                </article>{/}
                                
                                {? res.web_url || res.ios_url || res.and_url}
                                <div class="related-url text-center">
                                    <div class="btn-group" role="group">
                                        {? res.web_url}<a class="btn btn-default" href="{res.web_url}"><i class="fa fa-fw fa-home"></i> <span>Homepage</span></a>{/}
                                        {? res.ios_url}<a class="btn btn-default" href="{res.ios_url}"><i class="fa fa-fw fa-apple"></i> <span>App Store</span></a>{/}
                                        {? res.and_url}<a class="btn btn-default" href="{res.and_url}"><i class="fa fa-fw fa-android"></i> <span>Google Play</span></a>{/}
                                    </div>
                                </div>{/}
                                {? res.movie1}
                                <div class="embed-responsive embed-responsive-16by9 related-video">
                                    {? res.movie1_type == 1}<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/{res.movie1}" frameborder="0" allowfullscreen></iframe>{/}
                                    {? res.movie1_type == 2}<iframe src="https://player.vimeo.com/video/{res.movie1}" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>{/}
                                </div>{/}
                                {? res.art}
                                <div class="related-press">
                                    <h4>Press</h4>
                                    <ul>
                                        {@ res.art}
                                        <li><a href="{.article}" target="_blank">{?.title}{.title}{:}{.article}{/}</a></li>
                                        {/}
                                    </ul>
                                </div>
                                {/}
                                {? res.dates}
                                <div class="product-update">
                                    <h4>Update</h4>
                                    <ul>
                                        {@ res.dates}
                                        <li>
                                            <p>{=add_brs(.description)}</p>
                                            <span class="date">{.date}</span>
                                        </li>
                                        {/}
                                        
                                    </ul>
                                </div>
                                {/}
                                <div class="related-info">
                                    {@ res.cats}
                                    <a href="/showcase?category={.id}" class="label label-info">{._value}</a>
                                    {/}

                                    <span class="pull-right">
                                        <span class="by">by</span> {? res.startup_id}<a href="/startup/{res.startup_id}"><img style="width: 40px;" class="logo" alt="{res.s.name}" src="{res.s.logo}"> <strong>{res.s.name}</strong></a>{:}<strong>{res.startup_name}</strong>{/}
                                    </span>
                                </div>
                            </div>
                        </div>
                        <!-- /article -->

                        <!-- #timeline -->
                        <div id="comment">
<script type="text/javascript">
//<![CDATA[
get_timeline(10, '{res.id}', 1);
function get_timeline(_type, _id, _page)
{
    var get_url = '/ajax_front/get_timeline_2015/'+_type+'/'+_id+'/'+_page;
    $.get(get_url, function(_data) {
        $('#comment').html(_data);
    });
}
//]]>
</script> 
                        </div>
                        <!-- /#timeline -->

                    </div>
                    <!-- /content -->

                    <!-- sidebar -->
                    <div class="col-xs-12 col-sm-12 col-md-3 sidebar">
                        <section class="list-category">
                            <header>
                                <h3>카테고리</h3>
                            </header>
                            <ul class="list-unstyled">
                                <li><a href="/showcase">All <span class="cnt">({tot})</span></a></a></li>
                                {@ cat}
                                <li {? category == .id}class="active"{/}><a href="/showcase?category={.id}">{._value} <span class="cnt">({.cnt})</span></a></li>
                                {/}
                            </ul>
                        </section>
                    </div>
                    <!-- /sidebar -->

                </div>
                <!-- /End Contents --> 
            </div>
        </div>
        <!-- /page-content -->
    </div>
    <!-- /rowContent -->