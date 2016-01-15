    {? where}<div class="modal-backdrop fade in" style="height: 5000px;"></div>{/}
    <div class="modal-dialog modal-lg"> 
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> 
            </div>
            <div id="slide-product" class="carousel slide" data-ride="carousel">

                <!-- slides -->
                <div class="carousel-inner">
                    <!-- item -->
                    <div class="item active">

                        <!-- article -->
                        <div class="article product-article">
                            <div class="article-header">
                                <div class="product-status">
                                    {? res.user_id_bz == s.id}<a class="btn btn-default btn-xs pull-right" href="#" onclick="get_edit_service_modal('{res.id}'); return false;">수정하기</a>{/}
                                    {? res.date}
                                    {? res.date == today}
                                    {? res.type == 0}<span class="label label-success ">오늘 런칭!</span>{/}
                                    {? res.type == 1}<span class="label label-primary ">오늘 업데이트!</span>{/}
                                    {:}
                                    <span class="label label-warning">개발중</span>
                                    {/}{/}
                                </div>
                                
                                {? res.img1}<img src="{res.img1}" class="img-responsive">{/}
                            </div>
                            
                            <div class="article-body">    
                                <h3 class="product-heading">{res.name}</h3>
                                {? res.des_ele}
                                <p class="product-pitch">{res.des_ele}</p>{/}
                                {? res.des_pro}
                                <article>
                                    {res.des_pro}
                                </article>{/}

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
                                    {? res.movie1_type == 2}<iframe src="https://player.vimeo.com/video/{res.movie1}" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe></iframe>>{/}
                                </div>{/}

                                {? res.art}
                                <div class="related-press">
                                    <h4>Press</h4>
                                    <ul>
                                        {@ res.art}
                                        <li><a href="{.article}" target="_blank">{?.title}{.title}{:}{.article}{/}</a></li>
                                        {/}
                                    </ul>
                                </div>{/}
                                
                                <div class="related-info">
                                    {@ res.cats}
                                    <a href="/showcase?category={.id}" class="label label-info">{._value}</a>
                                    {/}

                                    <span class="pull-right">
                                        <span class="by">by</span> {? res.startup_id}<a href="/startup/{res.startup_id}"><strong>{res.s.name}</strong></a>{:}<strong>{res.startup_name}</strong>{/}
                                    </span>
                                </div>

                            </div>
                        </div>
                        <!-- /article -->
                    </div>
                    <!-- /item --> 
                </div> 
                <!-- /slides -->
            </div>
        </div>
    </div> 
    <!-- /modal-dialog -->

    <!-- Controls -->
    {? prev}
    <a class="left carousel-control" href="#" role="button" data-slide="prev" onclick="get_service_modal_next('{prev}','st','{res.startup_id}'); return false;">
        <span class="glyphicon glyphicon-chevron-left"></span> <span class="sr-only">Prev</span>
    </a>
    {/}
    {? next}
    <a class="right carousel-control" href="#" role="button" data-slide="next" onclick="get_service_modal_next('{next}','st','{res.startup_id}'); return false;">
        <span class="glyphicon glyphicon-chevron-right"></span> <span class="sr-only">Next</span>
    </a>
    {/}