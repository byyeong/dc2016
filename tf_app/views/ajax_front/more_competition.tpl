                        {@ res}
                        <li class="media">
                             
                            {? .img}<a class="pull-left media-object"  href="/competition/views/{.id}"> <img src="{.img}" class="img-responsive"> </a>{/}
                            
                            <div class="media-body">
                                <h3 class="media-heading"><a href="/competition/views/{.id}">{.subject}</a></h3>
                                
                                <div class="sidebar pull-right">
                                    {? .edate < date('Y.m.dH:i')}<p> <span class="label label-default">완료</span> </p>{/}
                                    <div class="item-status">
                                        <dl class="dl-horizontal">
                                            {?.organized}
                                            <dt>주최&middot;주관</dt>
                                            <dd>{.organized}</dd>{/}
                                            <dt>신청기한</dt>
                                            <dd>{.date_s} ({=date_to_day_only(.date_s)}) {.time_s} ~ {.date_e} ({=date_to_day_only(.date_e)}) {.time_e}</dd>
                                            <dt>발표일자</dt>
                                            <dd>{.announce_d} ({=date_to_day_only(.announce_d)}) {.announce_t}</dd>
                                            {? !.platform && .platform_out}<dt>OC URL</dt>
                                            <dd><a href="{.platform_out}" target="_blank">{.platform_out}</a></dd>
                                            {/}
                                        </dl>
                                    </div>
                                </div>
                            
                                <p class="ellipsis100">{=substr(strip_tags(.contents), 0, 1000)}</p>
                                <div class="media-meta"> 
                                    <span class="author"><a  href="/member/{.ids}"><img class="img-circle" src="{.picture}">{.name}</a></span> <span class="time"><span class="icon-time"></span>&nbsp; {=trans_date_ago(.date_created)}</span> </div>
                            </div>
                            
                        </li>
                        <!-- /media -->
                        {/}