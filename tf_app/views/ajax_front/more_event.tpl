                   {@ res}
                    <div class="item card col-xs-12 col-sm-4 col-md-3">  
                        <div class="inner">
                            <a href="/event/apply/{.id}" class="featured-img">
                                <span style="background-image:url({? .picture}{.picture}{:}/images/img_thumb.png{/});">
                                    <img class="img-responsive" src="/images/img_trans.png" >
                                </span>
                            </a> 
                            <div class="caption">
                                <h3>
                                    <a href="/event/apply/{.id}" class="mulitple">{.title}</a>
                                </h3>
                                <dl class="dl-horizontal">
                                    <dt>신청기한</dt>
                                    <dd>{? .apply_start}{.apply_start} {/}{? .apply_end} ~ {.apply_end} {/} </dd>
                                    <dt>신청현황</dt>
                                    <dd>{? .eroll == 1}신청자 <span class="badge badge-success">{.rcnt}</span> / {/} 정원 <span class="badge badge-info">{?.cnt}{.cnt}{:}제한없음{/}</span></dd>
                                </dl>
                            </div>
                            <div class="footer">
                                <span class="category">
                                    <a href="/event/ing/?type={.eid}">{.ename}</a>
                                </span><span class="sep"></span>
                                <span class="author">
                                    <a href="/member/{.ids}" data-toggle="tooltip" data-placement="top" title="{.mname}">
                                        <img src="{.mpicture}" class="img-circle"> <span class="ellipsis">{.mname}</span>
                                    </a>
                                </span>
                                <span class="date">{=substr(.date_created, 0, 10)}</span>
                            </div>
                        </div>
                    </div>
                    <!-- /item --> 
                    {/}