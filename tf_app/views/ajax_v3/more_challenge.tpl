                    {@ res}
                    <li class="media row"> 
                        {? .img}
                        <a class="pull-left media-object col-xs-12 col-sm-3 col-md-3"  href="/challenge/views/{? .url}{.url}{:}{.id}{/}"> 
                            <img src="{.img}" class="img-responsive" > 
                        </a>
                        {/}
                        <div class="media-body col-xs-12 {? .img}col-sm-9 col-md-9{:}col-sm-12 col-md-12{/}">
                            <h3 class="media-heading">
                                <a href="/challenge/views/{? .url}{.url}{:}{.id}{/}">{.subject}</a>  {? .is_ing} <span class="label label-primary" style="font-size: 11px;">접수 중</span>{/}
                            </h3> 
                            <p class="mulitple">{? .summary}{.summary}{:}{=mb_substr(strip_tags(.contents), 0, 400, 'UTF-8')}{/}</p>

                            <div class="item-status">
                                <dl class="dl-horizontal">
                                    <dt>주최/주관 </dt>
                                    <dd>{.organized}</dd>
                                    <dt>신청기한</dt>
                                    <dd>{.date_s} ({=date_to_day_only(.date_s)}) {.time_s} ~ {.date_e} ({=date_to_day_only(.date_e)}) {.time_e}</dd>
                                    <dt>발표일자</dt>
                                    <dd>{.announce_d} ({=date_to_day_only(.announce_d)}) {.announce_t}</dd>
                                </dl>
                            </div>

                            <div class="media-meta"> 
                                <span class="author"><a  href="/member/{.ids}"><img class="img-circle" src="{.picture}">{.name}</a></span> , 
                                <span class="time"><span class="icon-time"></span> {=substr(.date_created, 0, 10)}</span>
                            </div>
                        </div>
                    </li>
                    <!-- /media -->
                    {/}