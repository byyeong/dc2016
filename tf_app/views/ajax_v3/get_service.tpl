    <div class="modal-dialog modal-lg"> 
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> 
            </div>
            <div id="slide-product" class="carousel slide" data-ride="carousel">

                <!-- slides -->
                <div class="carousel-inner">
                    {@ res}{? .id}
                    <!-- item -->
                    <div class="item {? target == .id}active{/}" rel="{.id}">

                        <!-- article -->
                        <div class="article product-article">
                            <div class="article-header">
                                <div class="product-status">
                                    {? s && .user_id_bz == s.id}<a class="btn btn-default btn-xs pull-right" href="#" onclick="get_edit_service_modal('{.id}'); return false;">수정하기</a>{/}
                                    {? type == "just_launched"}
                                    {? .diff == 0}<span class="label label-success ">오늘 런칭!</span>{:}
                                    {? .diff < 5}<span class="label label-success ">{.diff * 24}시간 전</span>{:}<span class="label label-success ">{.diff}일 전 </span>{/}
                                    {/}{/}
                                </div>
                                
                                
                            </div>

                            <div class="article-body">   

                                <h3 class="product-heading">{.name}</h3>
                                {? .des_ele}
                                <p class="product-pitch">{.des_ele}</p>{/}
                                {? .des_pro}

                                <div id="fb-like-{.id}" data-href="http://dcamp.kr/showcase/views/{.id}" data-layout="standard" data-action="like" data-show-faces="true" data-share="true"></div>

                                {? .img1}
                                <div class="product-thumb">
                                    <div class="thumb-heading"></div>
                                    <div style="background-image:url({.img1});" class="thumb-img"> 
                                        <img src="/img/trans-4by3.png" class="img-responsive"> 
                                    </div>
                                </div>{/} 
                                
                                <article>
                                    {=add_brs(.des_pro)}
                                </article>{/}
                                
                                {? .web_url || .ios_url || .and_url}
                                <div class="related-url text-center">
                                    <div class="btn-group" role="group">
                                        {? .web_url}<a class="btn btn-default" href="{.web_url}"><i class="fa fa-fw fa-home"></i> <span>Homepage</span></a>{/}
                                        {? .ios_url}<a class="btn btn-default" href="{.ios_url}"><i class="fa fa-fw fa-apple"></i> <span>App Store</span></a>{/}
                                        {? .and_url}<a class="btn btn-default" href="{.and_url}"><i class="fa fa-fw fa-android"></i> <span>Google Play</span></a>{/}
                                    </div>
                                </div>{/}
                                
                                {? .movie1}
                                <div class="embed-responsive embed-responsive-16by9 related-video">
                                    {? .movie1_type == 1}<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/{.movie1}" frameborder="0" allowfullscreen></iframe>{/}
                                    {? .movie1_type == 2}<iframe src="https://player.vimeo.com/video/{.movie1}" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe></iframe>>{/}
                                </div>{/}

                                {? .art}
                                <div class="related-press">
                                    <h4>Press</h4>
                                    <ul>
                                        {@ .art}
                                        <li><a href="{..article}" target="_blank">{?..title}{..title}{:}{..article}{/}</a></li>
                                        {/}
                                    </ul>
                                </div>{/}
                                
                                {? .update}
                                <div class="product-update">
                                    <h4>Update</h4>
                                    <ul>
                                        {@ .update}
                                        <li>
                                            <p>{=add_brs(..description)}</p>
                                            <span class="date">{..date}</span>
                                        </li>
                                        {/}
                                        
                                    </ul>
                                </div>
                                {/}
                                
                                <br />
                                <div class="related-info">
                                    {@ .cats}
                                    <a href="/showcase?category={..id}" class="label label-info">{.._value}</a>
                                    {/}

                                    {? type != 'startup'}
                                    <span class="pull-right">
                                        <span class="by">by</span> {? .startup_id}<a href="/startup/{.startup_id}"><img style="width: 40px;" class="logo" alt="{.s.name}" src="{.s.logo}"> <strong>{.s.name}</strong></a>{:}<strong>{.startup_name}</strong>{/}
                                    </span>{/}
                                </div>

                            </div>
                        </div>
                        <!-- /article -->

                        <!-- #timeline -->
                        <div id="comment{.id}" class="comment"></div>
                        <!-- /#timeline -->

                    </div>
                    <!-- /item --> 
                    {/}{/}
                </div> 
                <!-- /slides -->
            </div>
        </div>
    </div> 
    <!-- /modal-dialog -->

    {? sizeof(res) > 1}
    <!-- Controls -->
    <a class="left carousel-control" href="#slide-product" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left"></span> <span class="sr-only">Prev</span>
    </a>
    <a class="right carousel-control" href="#slide-product" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right"></span> <span class="sr-only">Next</span>
    </a>
    {/}

<script type="text/javascript">
//<![CDAT
FB.XFBML.parse();
// FB.XFBML.parse(document.getElementById('fb-like'));
// FB.XFBML.parse($('.fb-like'));
//]]>
</script> 
<script type="text/javascript">
//<![CDATA[
get_timeline(10, '{target}', 1);
function get_timeline(_type, _id, _page)
{
    
    var get_url = '/ajax_front/get_timeline_2015/'+_type+'/'+_id+'/'+_page;
    $.get(get_url, function(_data) {
        $('#comment'+_id).html(_data);
        $('#comment'+_id).css('padding', '20px');
        $("a[rel^='prettyPhoto']").prettyPhoto({social_tools: false});
        $('#fb-like-'+_id).addClass('fb-like');
        FB.XFBML.parse();
    });
}

$('.carousel').bind('slide.bs.carousel', function() {
    _c_com = $('div.item.active').next().attr('rel');
    if (!_c_com) _c_com = $('div.item:eq(0)').attr('rel');
    // $('.comment').html('');
    get_timeline(10, _c_com, 1);
});

//]]>
</script> 