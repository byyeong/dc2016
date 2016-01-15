                    {@ res}
                    <div class="item card col-xs-12 col-sm-4 col-md-3"> 
                        <div class="inner">
                            <a href="/program/views/{.id}" class="featured-img">
                                <span style="background-image:url({? .img}{.img}{:}/img/default-img-pic.png{/});">
                                    <img class="img-responsive" src="/images/img_trans.png" >
                                </span>
                                <img class="sr-only" src="{? .img}{.img}{:}/img/default-img-pic.png{/}" >
                            </a> 
                            <div class="caption"> 
                                <span class="category">{.category}</span>
                                <h3>
                                    <a href="/program/views/{.id}" class="mulitple">
                                    {.title}
                                    </a>
                                </h3>
                                <dl class="dl-horizontal">
                                    <dt>지원기관 </dt>
                                    <dd class="ellipsis">{.agency}</dd>
                                    <dt>접수기간</dt>
                                    <dd>{? .a_start}{=substr(.a_start, 0, 10)} ~ {=substr(.a_end, 0, 10)}{:}상시{/}</dd>
                                </dl>
                            </div>
                            <div class="footer">
                                <span class="author">
                                    <a href="/member/{.ids}" data-toggle="tooltip" data-placement="top" title="{.name}({.ids})">
                                        <img src="{? .picture}{.picture}{:}/images/img_default.png{/}" class="img-circle"> <span class="ellipsis">{.name}({.ids})</span>
                                    </a>
                                </span>
                                <span class="date">{=substr(.date_created, 0, 10)}</span>
                            </div>
                        </div>
                    </div>
                    <!-- /item -->
                    {/}