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