                                <div class="panel-heading">
                                    <h3>제품/서비스 정보</h3>
                                    {? s && edi.user_id == s.id}<button class="btn btn-default btn-xs" onclick="edit_service_modal('0', '{sid}'); return false;">추가하기 </button>{/}
                                </div>
                                {? !res}
                                <!-- TODO : none 상태 -->
                                <div class="panel-body"> 
                                    <!-- alert -->
                                    <div class="alert alert-info">
                                        <p class="text-info"><strong>Oops!</strong> 입력된 내용이 없습니다. [추가하기]를 클릭해서 해당 내용을 입력해주세요.</p>
                                    </div>
                                    <!-- /alert --> 
                                </div>
                                <!-- /panel-body -->
                                {:}
                                <!-- panel-body -->
                                <div class="panel-body">

                                    <!-- media-list -->
                                    <ul class="media-list post-list product-list">
                                        {@ res}
                                        <li class="media"> 
                                            <div class="row">
                                                {? .img1}
                                                <div class="col-xs-12 col-sm-5 col-md-5 media-object {? .key_ % 2 != 0}pull-right{/}">
                                                    <div class="product-thumb">
                                                        <div class="thumb-heading"></div>
                                                        <a class="thumb-img" onclick="get_service_modal('{.id}','startup','{.startup_id}'); return false;" href="#" style="background-image:url({.img1});"> 
                                                            <img class="img-responsive" src="/img/trans-4by3.png"> 
                                                        </a>
                                                    </div>
                                                </div>{/}

                                                <div class="col-xs-12 {? .img1}col-sm-7 col-md-7{:}col-sm-12 col-md-12{/} media-body ">
                                                    <div class="product-status text-right">
                                                        {? .date}
                                                        {? .date == today}
                                                        {? .type == 0}<span class="label label-success ">오늘 런칭!</span>{/}
                                                        {? .type == 1}<span class="label label-primary ">오늘 업데이트!</span>{/}
                                                        {:}
                                                        <span class="label label-warning">개발중</span>
                                                        {/}{/}
                                                        {? (s && .user_id_bz == s.id) || (s && edi.user_id == s.id)}
                                                        <a class="btn btn-default btn-xs " href="#" onclick="edit_service_modal('{.id}', '{.startup_id}'); return false;">수정하기</a>
                                                        <a class="btn btn-danger btn-xs " href="#" onclick="del_service('{.id}', 0); return false;">삭제하기</a>
                                                        {/}
                                                    </div>

                                                    <a onclick="get_service_modal('{.id}','startup','{.startup_id}'); return false;" href="#"  class="media-content">
                                                        <h3 class="media-heading">
                                                            {.name}
                                                        </h3> 
                                                        <p class="product-pitch">{.des_ele}</p>
                                                        <p class="quater">{.des_pro}</p>
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
                                                        {? .date_created}, <span class="time"><i class="fa fa-fw fa-clock-o"></i> {=substr(str_replace('-', '.', .date_created), 0, 10)}</span>{/}
                                                        <span class="comments">, <i class="fa fa-fw fa-comments"></i> <span class="cnt">{.com}</span></span>  
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                        <!-- /media -->
                                        {/}
                                    </ul>
                                    <!-- /media-list -->
                                    
                                </div>
                                <!-- /panel-body -->
                                {/}
                                
<div class="modal fade modal-product-detail" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" ></div>
<div class="modal fade modal-product-editor" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="z-index: 2;"></div>

<link rel="stylesheet" href="/css/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />
<script src="/js/jquery.prettyPhoto.js" type="text/javascript" charset="utf-8"></script>
<script src="/js/dcamp-bz.js"></script>