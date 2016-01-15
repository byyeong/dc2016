	          {@ res}
                        <li class="media"> 
                            {? .main}<a class="pull-left media-object" href="/notice/views/{.type}/{.id}"> <img src="{.main}" class="img-responsive" > </a>{/}
                            <div class="media-body">
                                <h3 class="media-heading"><a href="/notice/views/{.type}/{.id}">{.title}</a></h3>
                                <p class="ellipsis">{=strip_tags(.contents)}</p>
                                <div class="media-meta"> <span class="category">{? .type == 1}News{/}{? .type == 3}Notice{/} </span>{?.wr} <span class="author"><a  href="/member/{.wr.ids}"><img src="{.wr.picture}" class="img-circle"> {.wr.name}</a></span>{/} <span class="time"><span class="icon-time"></span>&nbsp; {=trans_date_ago(.date_created)}</span> </div>
                            </div>
                            <!-- /media-content --> 
                        </li>
                        <!-- /media -->
                        {/}