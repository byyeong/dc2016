    <!-- rowContent -->
    <div id="product" class="rowContent"> 
        <!-- page-header -->
        <div class="page-header">
            <div class="container">
                <h2><a href="/showcase">Showcase</a></h2>

                <div class="pull-right">
                    
                    <select class="selectpicker" name="status">
                        <option value="just_launched" {? status == 'just_launched'}selected="selected"{/}>Just Launched!</option>
                        <option value="archived" {? status != 'just_launched'}selected="selected"{/}>Archived</option>
                    </select>

                    {? status != 'just_launched'}
                    <select class="selectpicker" name="status2">
                        <option value="archived" {? status == 'archived'}selected="selected"{/}>서비스중</option>
                        <option value="ready" {? status == 'ready'}selected="selected"{/}>개발중</option>
                    </select>{/}
                    
                    <a href="#" class="btn btn-primary pull-right" onclick="edit_service_modal('0', '0'); return false;">
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

                <div class="header-banner" style="background-image:url({? visual}{visual.pic_1}{:}/images/hstyleoption/aureliejouan-lights.jpg{/});">
                    <a href="{visual.des_3}">
                        <div class="inner">
                            <h3>{? visual.des_1}{visual.des_1}{:}Showcase 서비스를 소개합니다!{/}</h3>
                            <p>{? visual.des_2}{visual.des_2}{:}오늘 새롭게 런칭하거나 주요 업데이트를 단행한 서비스들을 소개합니다.{/}</p>
                        </div>
                    </a>
                </div>

                <div class="row">
                    <!-- content -->
                    <div class="col-xs-12 col-sm-12 col-md-9 content">
                        <!-- media-list -->
                        <ul class="media-list post-list product-list">
                            {@ res}{? .id}
                            <li class="media {.id}"> 
                                {? .img1}
                                <div class="col-xs-12 col-sm-5 col-md-5 media-object {? .key_ % 2 != 0}pull-right{/}">
                                    <div class="product-thumb">
                                        <div class="thumb-heading"></div>
                                        <a class="thumb-img" href="#" onclick="get_service_modal('{.id}','{status}','{category}'); return false;" style="background-image:url({.img1});"> 
                                            <img class="img-responsive" src="/img/trans-4by3.png"> 
                                        </a>
                                    </div>
                                </div>{/}

                                <div class="col-xs-12 {? !.img1}col-sm-12 col-md-12{:}col-sm-7 col-md-7{/} media-body ">
                                    <div class="product-status text-right">
                                        {? status == "just_launched"}
                                        {? .diff == 0}<span class="label label-success ">오늘 런칭!</span>{:}
                                        {? .diff < 5}<span class="label label-success ">{.diff * 24}시간 전</span>{:}<span class="label label-success ">{.diff}일 전 </span>{/}
                                        {/}{/}
                                    </div>

                                    <a href="#" onclick="get_service_modal('{.id}','{status}','{category}'); return false;" class="media-content">
                                        <h3 class="media-heading">
                                            {.name}
                                        </h3> 
                                        <p class="product-pitch">{.des_ele}</p>
                                        <p class="quater">{.des_pro}</p>
                                    </a>

                                    <div class="media-meta">
                                        {? .cats}
                                        <div class="category">
                                            {@ .cats}
                                            <a href="/showcase?category={..id}" class="label label-default">{.._value}</a> 
                                            {/}
                                        </div> 
                                        {/}
                                        <span class="author">by {? .s.id}<a href="/startup/{.s.id}"><strong>{.s.name}</strong></a>{:}<strong>{.startup_name}</strong>{/}</span> 
                                        {? .date}
                                        , <span class="time"><i class="fa fa-fw fa-clock-o"></i> {.date}</span>{/}
                                        <span class="comments">, <i class="fa fa-fw fa-comments"></i> <span class="cnt">{.com}</span></span> 
                                    </div> 
                                </div>
                            </li>
                            <!-- /media -->
                            {/}{/}
                        </ul>
                        <!-- /media-list -->

                        <input type="hidden" id="page" value="1" />
                        {? sizeof(res) > 9}
                        <div class="pager"> <a href="#" class="btn btn-default" onclick="more_betazone('{category}','{status}'); return false;"> &darr;  더보기</a> </div>
                        {/}
                    </div>
                    <!-- /content -->

                    <!-- sidebar -->
                    <!--div class="col-xs-12 col-sm-12 col-md-3 sidebar">
                        <section class="list-category">
                            <header>
                                <h3>Category</h3>
                            </header>
                            <ul class="list-unstyled">
                                <li><a href="/showcase?status={status}">{? category}All <span class="cnt">({tot})</span>{:}<b>All <span class="cnt">({tot})</span></b>{/}</a></a></li>
                                {@ cat}{?.cnt}
                                <li><a href="/showcase?status={status}&category={.id}">{? category == .id}<b>{._value} <span class="cnt">({.cnt})</span></b>{:}{._value} <span class="cnt">({.cnt})</span>{/}</a></li>
                                {/}{/}
                            </ul>
                        </section>
                    </div-->
                    <!-- /sidebar -->

                </div>
                <!-- /End Contents --> 
            </div>
        </div>
        <!-- /page-content -->
    </div>
    <!-- /rowContent -->

<div class="modal fade modal-product-detail" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" ></div>
<div class="modal fade modal-product-editor" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="z-index: 2;"></div> 

<link rel="stylesheet" href="/css/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />
<script src="/js/jquery.prettyPhoto.js" type="text/javascript" charset="utf-8"></script>

<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}
    
$(document).ready(function(){ 
    $("select[name=status]").change(function() 
    { 
        var _val = $("select[name=status] option:selected").val();
        document.location.href = "/showcase?status="+_val;
    }); 

    $("select[name=status2]").change(function() 
    { 
        var _val = $("select[name=status2] option:selected").val();
        document.location.href = "/showcase?status="+_val;
    }); 
}); 

//]]>
</script>