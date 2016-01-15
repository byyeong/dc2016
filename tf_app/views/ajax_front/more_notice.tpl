                    {@ res}
                    <li class="media"> 
                        <!--
                        <a href="#" class="pull-left"> <img   data-src="holder.js/80x80" class="media-object" style="width: 80px; height: 80px;"> </a>
                        //-->
                        <div class="media-body">
                            <div class="media-heading">
                                <h4><a href="/news/views/{.type}/{.id}">{.title} </a></h4>
                                <span class="time"><span class="icon icon-time"></span>&nbsp; {=str_replace("-", ".", substr(.date_created, 0, 10))}</span> </div>
                            <p>{.contents}</p>
                        </div>
                    </li>
                    {/}