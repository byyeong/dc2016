            <div class="main">    
                
                <section id="user-permalink">

                    <div class="media-caption">
                        {? ev}
                        <p class="lead">
                            <span class="label-icon"><span class="glyphicon glyphicon-calendar"></span></span>  
                            <a href="{ev.u}">{ev.t}</a>
                        </p>
                        {/}
                        <a href="/member/{res.ids}" class="caption-object"><img src="{res.picture}" alt="{res.name}" class="img-responsive avatar img-circle"></a>

                        <div class="caption">
                            <h3><a href="/member/{res.ids}">{res.name}</a>  <small>{res.bdate}</small></h3>
                            <p>{res.contents}</p>
                        </div>
                    </div>

                </section>


                <!-- #now-user -->
                <section id="now-user">
                    <div class="page-header">
                        <h3><span class="glyphicon glyphicon-user"></span>&nbsp; D.CAMP {? ev && datetimeDiff(ev.date_e, ev.end, date('y.m.d H:i'), '.') < 0}With{:}Now{/}</h3>
                    </div>

                    <p class="lead">
                        {? ev}
                        {? datetimeDiff(ev.date_e, ev.end, date('y.m.d H:i'), '.') < 0}
                        {=sizeof(users)}+명이 함께 했습니다.
                        {:}
                        지금 D.CAMP에서는 {=sizeof(users)}+명이 함께하고 있습니다.
                        {/}
                        {:}지금 D.CAMP에서는 {=sizeof(users)}+명이 함께하고 있습니다.
                        {/}
                    </p>

                    <ul class="list-inline">
                        {@ users}
                        <li>
                            <a href="/member/{.ids}" data-toggle="" data-placement="top" title="{.name}">
                              <img src="{.picture}" alt="{.name}" class="img-responsive avatar img-circle">
                            </a>
                        </li>
                        {/}
                    </ul>
                </section>
                <!-- /#now-user -->


            </div>
            <!-- /main -->