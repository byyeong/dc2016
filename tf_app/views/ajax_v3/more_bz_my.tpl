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