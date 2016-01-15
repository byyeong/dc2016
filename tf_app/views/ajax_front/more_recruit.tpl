                        {@ res}
                        <li class="media"> 
                            <a class="pull-left media-object"  href="/startup/{.sid}"> 
                                <img src="{.logo}" class="img-responsive"> 
                            </a>
                            <div class="media-body">
                                <h3 class="media-heading">
                                    <a href="/startup/{.sid}">
                                        {.sname}
                                    </a>
                                </h3>
                                {? .bis}
                                <ul class="list-inline list-tags"> 
                                    {@ .bis}
                                    <li>{.._value}</li>
                                    {/}
                                </ul>
                                {/}
                                <p class="lead">{=htmlspecialchars(.bio)}</p>

                                <div class="media-field well">
                                    <a href="/recruit/views/{.rid}">
                                        <h4>{.title}</h4>
                                        {? .term}
                                        <dl class="dl-horizontal">
                                            <dt>고용형태</dt>
                                            <dd>{@ .term}{? ..key_ == 0}{.._value}{:}, {.._value}{/}{/}</dd>
                                        </dl>
                                        {/}
                                        <dl class="dl-horizontal">
                                            <dt>업무분야</dt>
                                            <dd>{@ .inv}{? ..key_ == 0}{.._value}{:}, {.._value}{/}{/}</dd>
                                        </dl>
                                        <dl class="dl-horizontal">
                                            <dt>접수기간</dt>
                                            <dd>{? !.start && !.end}상시{:}{? .start}{.start} ({=date_to_day_only(.start)}){/}{?.end} ~{.end} ({=date_to_day_only(.end)}) {/}{/}</dd>
                                        </dl>
                                    </a>
                                </div>
                                <div class="media-meta"> 
                                    <span class="author"><a href="/member/{.ids}"><img src="{.mpicture}" class="img-circle"> {.mname}</a></span> , 
                                    <span class="time"><span class="icon-time"></span> {=trans_date_ago(.date_created)}</span>
                                </div>
                            </div>
                        </li>
                        <!-- /media -->
                        {/}