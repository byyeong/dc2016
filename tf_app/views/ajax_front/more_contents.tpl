                        {@ res}
                        <li class="media row"> 
                                
                            {? .picture}<a class="pull-left media-object col-xs-12 col-sm-3 col-md-3" href="/contents/views/{.id}"> <img src="{.picture}" class="img-responsive" > </a>
                            {:}
                            {?.img}<a class="pull-left media-object col-xs-12 col-sm-3 col-md-3" href="/contents/views/{.id}"> <img src="{.img}" class="img-responsive" > </a>{/}
                            {/}

                            <div class="media-body {? .img || .picture}col-xs-12 col-sm-9 col-md-9{:}col-xs-12 col-sm-12 col-md-12{/}">
                                <h3 class="media-heading"><a href="/contents/views/{.id}">{.subject}</a>
                                </h3>
                                 
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12col-md-12">
                                        <p class="ellipsis80">{=substr(strip_tags(.contents), 0, 800)}</p>
                                    </div>
                                </div> 


                                <div class="media-meta"> <span class="category"><a  href="/contents/{.cid}">{.cname}</a></span>
                                    <span class="sep"></span>
                                    <span class="author"><a  href="/member/{.ids}"><img class="img-circle" src="{.mpicture}"> {.mname}</a></span>
                                    <span class="time"><span class="icon-time"></span>&nbsp; {= trans_date_ago(.date_created)}</span></div>
                            </div>
                        </li>
                        {/}