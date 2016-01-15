
            
            {@ res}
            {?!c || c == 'event'}
            {? .cat == "event"}
            <div class="col-lg-3 item type1" data-groups='["event"]' > 
                <div class="inner">
                    <a href="/event/apply/{.id}">
                        <div class="imgbox"><img src="{.picture}"  data-src="holder.js/270x270" class="img-responsive img-thumb"></div>
                        {? dateDiff(.date, date('y.m.d'), '.') > -1}<div class="d-day img-circle">D-{=dateDiff(.date, date('y.m.d'), '.')}</div>{/}
                        <div class="sort"><strong>Event</strong></div>
                        <div class="caption">
                            <h3 class="ellipsis">{.title}</h3>
                            <span class="date"><span class="icon-calendar"></span> {.date}</span>
                        </div>
                    </a>
                </div>
            </div>
            {/}   
            {/}
            
            {?!c || c == 'startup'}
            {? .cat == "startup"}
            <div class="col-lg-3 item type2" data-groups='["startup"]' > 
                <div class="inner">
                    <a href="/startup/{.id}">
                        <div class="imgbox"><img src="{? .logo}{.logo}{:}/img/default-img-company.png{/}"  data-src="holder.js/80x80" class="img-responsive img-circle"></div>
                        <div class="sort  img-circle"><strong>Startup</strong></div>
                        <h3>{.name} </h3>
                        <p class="ellipsis">{.bio}</p>
                    </a>
                </div>
            </div>             
            {/}
            {/}
            
            {?!c || c == 'people'}
            {? .cat == "people"}
            <div class="col-lg-3 item type2" data-groups='["people"]' > 
                <div class="inner">
                    <a href="/member/{.ids}">
                        <div class="imgbox"><img src="{? .picture}{.picture}{:}/img/default-img-member.png{/}"  data-src="holder.js/80x80" class="img-responsive img-circle"></div>
                        <div class="sort img-circle"><strong>People</strong></div>
                        <h3>{.name}</h3>
                        <p class="ellipsis">{.bio}</p>
                    </a>
                </div>
            </div>
            {/}
            {/}
            
            {?!c || c == 'recruit'}
            {? .cat == "recruit"}
            <div class="col-lg-3 item type2" data-groups='["recruit"]' >
                <div class="inner">
                    <a href="/recruit/views/{.rid}">
                        <div class="imgbox"><img src="{?.logo}{.logo}{:}/img/default-img-company.png{/}" data-src="holder.js/80x80" class="img-responsive img-circle"></div>
                        <div class="sort  img-circle"><strong>Recruit</strong></div>
                        <h3 class="ellipsis">{.title}</h3> 
                    </a>
                </div>
            </div>
            {/}
            {/}
            
            {?!c || c == 'news'}
            {? .cat == "news"}
            {? .main}
            <div class="col-lg-3 item type1" data-groups='["news"]' > 
                <div class="inner">
                    <a href="/news/views/{.type}/{.id}">
                        <div class="imgbox">
                            <img src="{.main}" data-src="holder.js/270x270"  class="img-responsive  img-thumb" >
                        </div>
                        <div class="sort"><strong>{? .type == 1}News{/}{? .type == 3}Notice{/}</strong></div>
                        <div class="caption"><h3 class="ellipsis">{.title}</h3></div>
                    </a>               
                </div>
            </div>
            {:}
            <div class="col-lg-3 item type2" data-groups='["news"]' > 
                <div class="inner">
                    <a href="/news/views/{.type}/{.id}">
                        <div class="imgbox">
                            <img {? .type == 1}src="/img/default-img-news.png"{/}{? .type == 3}src="/img/default-img-notice.png"{/}  data-src="holder.js/80x80"  class="img-responsive  img-circle">
                        </div>
                        <div class="sort img-circle"><strong>{? .type == 1}News{/}{? .type == 3}Notice{/}</strong></div>
                        <h3 class="ellipsis">{.title}</h3>     
                    </a>               
                </div>
            </div>
            {/}
            {/}
            {/}
            
            <div class="col-lg-3 item shuffle_sizer"></div>
            {/}
            
        