
                <div class="content col-xs-12 col-sm-12 col-md-9">
                    <div class="content-header">
                        <button class="btn btn-primary btn-sm pull-right"  onclick="edit_service_modal('0', '0'); return false;"><span class="icon-fixed-width icon-large icon-edit"></span> 제품/서비스 등록하기</button>
                        <h3> 
                            <i class="fa fa-fw fa-desktop"></i> 
                            Showcase
                        </h3>
                    </div>
                    <!-- media-list -->
                    <ul class="media-list post-list product-list">
                        {@ res}
                        <li class="media media_li_{.id}">  
                            <div class="row">
                                
                                {?.img1}
                                <div class="col-xs-12 col-sm-3 col-md-3 media-object">
                                    <div class="product-thumb">
                                        <div class="thumb-heading"></div>
                                        <a class="thumb-img" href="/showcase/views/{.id}" style="background-image:url({.img1});"> 
                                            <img class="img-responsive" src="/img/trans-4by3.png"> 
                                        </a>
                                    </div>
                                </div>{/}

                                <div class="col-xs-12 {? .img1}col-sm-9 col-md-9{:}col-sm-12 col-md-12{/} media-body ">
                                    <div class="product-status pull-right">
                                        {? .date}
                                        {? .date == today}
                                        {? .type == 0}<span class="label label-success ">오늘 런칭!</span>{/}
                                        {? .type == 1}<span class="label label-primary ">오늘 업데이트!</span>{/}
                                        {:}
                                        <span class="label label-warning">개발중</span>
                                        {/}{/}
                                        <a class="btn btn-default btn-xs " href="#"  onclick="edit_service_modal('{.id}', 0); return false;">수정하기</a>
                                        <a class="btn btn-danger btn-xs " href="#" onclick="del_service('{.id}', 1); return false;">삭제하기</a> 
                                    </div>
                                    <a href="/showcase/views/{.id}" class="media-content">
                                        <h3 class="media-heading">
                                            {.name}
                                        </h3> 
                                        <p class="product-pitch">{.des_ele}</p>
                                    </a>

                                    <div class="media-meta">
                                        {? .cats}
                                        <span class="category">
                                            {@ .cats}
                                            <a href="/showcase?category={..id}" class="label label-default">{.._value}</a> 
                                            {/}
                                        </span> 
                                        {/}
                                        <span class="author">by {? .s.id}<a href="/startup/{.s.id}"><strong>{.s.name}</strong></a>{:}<strong>{.startup_name}</strong>{/}</span> 
                                        , <span class="time"><i class="fa fa-fw fa-clock-o"></i> {=substr(str_replace('-', '.', .date_created), 0, 10)}</span>
                                        <span class="comments">, <span class="icon-comments"></span> <span class="cnt">{.com}</span></span> 
                                    </div>
                                </div>
                            </div>
                        </li>
                        <!-- /media -->
                        {/}
                    </ul>
                    <!-- /media-list -->
                    {? sizeof(res) > 9}
                    <input type="hidden" id="page" value=1 />
                    <div class="pager"> <a href="#" onclick="more_bz_my(); return false;" class="btn btn-default"> &darr;  더보기</a> </div>
                    {/}
                </div>
                <!-- /content -->

<div class="modal fade modal-product-editor" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="z-index: 2;"></div>

<script src="/js/dcamp-bz.js"></script>