            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section>
                    <div class="panel panel-default" id="pane-product-edit"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="icon-align-justify"></span><span class="break"></span> Showcase 목록</h2> 
                            <div class="actions"> 
                                <span class="break"></span> 
                                <a href="/admin_showcase" class="btn-list" data-toggle="tooltip" title="목록보기">
                                    <span class="icon-align-justify"></span>
                                </a> 
                            </div>
                        </div>
                        <!-- /panel-heading -->
                        <div class="panel-body">
                            <!-- article -->
                            <div class="article product-article">
                                <div class="article-header">
                                    <div class="product-status">
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
                                    </div>{/}

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
                        <!-- /panel-body -->
                        <div class="panel-footer">
                            <form class="form-horizontal" role="form" action="/admin_showcase/views/{res.id}" method="post">
                                <fieldset>
                                    <div class="form-group">
                                        <span class="col-xs-12 col-sm-2 col-md-2 control-label ">승인하기</span>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <select class="selectpicker" name="status_bz">
                                                <option value="0" {? res.status_bz == 0}selected="selected"{/}>대기</option>
                                                <option value="1" {? res.status_bz == 1}selected="selected"{/}>승인</option>
                                                <option value="2" {? res.status_bz == 2}selected="selected"{/}>반려</option>
                                            </select> 
                                            <input type="text" placeholder="반려사유를 적어주세요" id="inputReject" class="form-control" name="status_bz_des" {? res.status_bz == 2}value="{res.status_bz_des}"{/}>

                                        </div>
                                    </div> 
                                    <div class="form-group form-submit">
                                        <div class="col-xs-12 col-sm-offset-2 col-md-offset-2">
                                            <button type="button" class="btn btn-default" onclick="javascript:location.href='/admin_showcase'">취소</button>
                                            <button type="submit" class="btn btn-primary">확인</button>
                                        </div>
                                    </div>
                                    <input type="hidden" name="id" value="{res.id}" />
                                </fieldset>
                            </form>
                        </div>
                        <!-- /panel-footer -->
                    </div>
                    <!-- /panel --> 
                    
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 

<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}
    
$(document).ready(function(){ 
    $("select[name=state]").change(function() 
    { 
        var _val = $("select[name=state] option:selected").val();
        document.location.href = "/admin_contents?sort=c.state&order="+_val;
    }); 

    $(".td-founded button").click(function()
    {
        {? order_f == 'ASC'}document.location.href = "/admin_event?search={search}&type={type}&sort={sort}&order={order}&order_t=order_t&order_e=DESC";
        {:}document.location.href = "/admin_event?search={search}&type={type}&sort={sort}&order={order}&order_t=order_t&order_e=ASC";{/}
    });

    $(".td-date button").click(function()
    {
        {? order_d == 'ASC'}document.location.href = "/admin_event?search={search}&type={type}&sort={sort}&order={order}&order_t=order_t&order_e=DESC";
        {:}document.location.href = "/admin_event?search={search}&type={type}&sort={sort}&order={order}&order_t=order_t&order_e=ASC";{/}
    });
}); 

//]]>
</script>