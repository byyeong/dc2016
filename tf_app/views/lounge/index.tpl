
            <div class="main">    
                <div class="row">
                    <!--  #content -->
                    <div id="contents" class="col-xs-12 col-sm-12 col-md-8">
                        <form id="timeline-form" role="form" method="post" name="p_form" onsubmit="submit_p_form('0', '{fb.public}'); return false">                       
                        
                            <fieldset>
                                <legend class="sr-only">
                                    타임라인 쓰기
                                </legend>
                                <div class="media media-form">
                                    <a href="#" class="pull-left media-object">
                                        <img src="{? s}{s.picture}{:}/img/default-img-member.png{/}" alt="{s.name}" class="avatar img-circle">
                                    </a>
                                    <div class="media-body">
                                        <div class="row">
                                            <div class="form-group col-xs-12 col-sm-12 col-md-12 left">
                                                <label class="sr-only">&nbsp; D.CAMP 라운지에 글을 남겨주세요.</label>
                                                {? s}
                                                <textarea rows="4" class="form-control" placeholder="D.CAMP 라운지에 글을 남겨주세요." name="cont"></textarea>
                                                {:}
                                                <textarea rows="4" class="form-control" placeholder="D.CAMP 라운지에 글을 남기기 위해서 로그인이 필요합니다." name="cont" disabled></textarea>
                                                {/}
                                            </div>
                                        </div>

                                        <div class="form-group form-submit" onsubmit="return false;"> 
                                            <label class="checkbox-inline" >
                                              <input type="checkbox" data-toggle="checkbox" name="fb" value="1" {? ! fb}disabled="disabled"{:}checked="checked"{/}>
                                              Facebook
                                            </label>
                                            <label class="checkbox-inline">
                                              <input type="checkbox" data-toggle="checkbox" checked="checked" name="tw" value="1" {? ! fb}disabled="disabled"{:}checked="checked"{/}>
                                              Twitter
                                            </label>
                                            &nbsp;&nbsp;
                                            {? s.id}
                                            <button type="submit" class="btn btn-primary" id="submit_f">업데이트</button>
                                            {:}
                                            <button class="btn btn-primary" disabled>로그인 해주세요</button>
                                            {/}
                                            <input type="hidden" name="id" value="0" />
                                        </div>
                                    </div>
                                </div>
                            </fieldset>
                        </form>

                        <!-- #timeline-media -->
                        <section id="timeline-media">
                            <div class="page-header">
                                <h3><span class="glyphicon glyphicon-comment"></span>&nbsp; Timeline</h3>
                            </div>

                            <!-- media -->
                            <ul class="media-list" id="timeline">
                                {@ comments}
                                <li class="media" id="com{.bid}">
                                    {?.user_id == s.id}
                                    <button onclick="del_comm('{.bid}', 0); return false;" aria-hidden="true" class="close" type="button">×</button>
                                    {/}
                                    <a class="media-left" href="/member/{.ids}">
                                        <img src="{.picture}" alt="{.name}" class="avatar img-circle">
                                    </a>
                                    <div class="media-body">
                                        <h4 class="media-heading">
                                            <a href="/member/{.ids}">{.name}</a> <small><a href="/lounge/comment/{.id}">{=substr(.date_created, 0, -3)}</a></small>
                                        </h4>
                                        <div class="media-content"> 
                                            {? .image}
                                            <div class="pull-right">
                                                <a rel="prettyPhoto" style="background:url({.image}) center center no-repeat #000; background-size: 180px auto;" class="img-thumbnail" href="{.image}"><img src="/img/trans.png"></a>
                                            </div>
                                            {/}
                                            <p>{=trans_url(add_brs(.contents))}</p>
                                        </div>
                                        
                                        {? .p_name}
                                        <div class="media-footer">
                                            <small>
                                            {? .p_type == 3}<a href="/lounge/event/{.p_id}">Event - {.p_name}</a>{/}
                                            {? .p_type == 6}<a href="/contents/views/{.p_id}">Blog - {.p_name}</a>{/}
                                            {? .p_type == 7}<a href="/challenge/views/{.p_id}">Challenge - {.p_name}</a>{/}
                                            {? .p_type == 8}<a href="/office_hours/mentor/{.p_id}">Office Hours - {.p_name}</a>{/}
                                            {? .p_type == 9}<a href="/benefits/views/{.p_id}">Benefits - {.p_name}</a>{/}
                                            {? .p_type == 10}<a href="/showcase/views/{.p_id}">Showcase - {.p_name}</a>{/}
                                            </small>
                                        </div>
                                        {/}
                                        <div class="media-meta">
                                            <div class="meta-actions">
                                                <div class="btn-group btn-like {? .is_like}active{/}">
                                                    <button type="button" class="btn btn-default btn-sm" onclick="comment_like(this, '{.id}', '{.is_like}'); return false;">
                                                        <span class="glyphicon glyphicon-heart"></span> 
                                                        <span class="sr-only">좋아요 </span>{? .like}<span id="li_cnt{.id}">{.like}</span> {/}
                                                    </button>
                                                    <button aria-controls="like-media" aria-expanded="true" data-target="#like-media{.id}" data-toggle="collapse" class="btn btn-default btn-sm" type="button" {? ! .like}style="display: none;"{/} onclick="get_like('{.id}'); return false;">
                                                        <span class="caret"></span>
                                                    </button>
                                                </div>
                                                <button type="button" class="btn btn-default btn-sm" data-toggle="collapse" data-target="#re-media{.id}" aria-expanded="true" aria-controls="re-media">
                                                    <span class="glyphicon glyphicon-comment"></span> <span class="sr-only">댓글 </span>  <span id="re_cnt{.id}">{=sizeof(.comm)}</span>
                                                </button> 
                                            </div>
                                        </div>
                                        <div id="like-media{.id}" class="collapse"></div>
                                        
                                        <ul id="re-media{.id}" class="media-list collapse">
                                            {@ .comm}
                                            <li class="media" id="com{..bid}">
                                                {?..user_id == s.id}
                                                <button onclick="del_comm('{..bid}', '{..parent}'); return false;" aria-hidden="true" class="close" type="button">×</button>
                                                {/}
                                                <a href="/member/{..ids}" class="media-left">
                                                    <img src="{..picture}" alt="{..name}" class="avatar img-circle">
                                                </a>
                                                <div class="media-body">
                                                    <h4 class="media-heading">
                                                        <a href="/member/{..ids}">{..name}</a> <small>{=substr(..date_created, 0, -3)}</small>
                                                    </h4>
                                                    <p>{=trans_url(add_brs(..contents))}</p>
                                                </div>
                                            </li>
                                            {/}
                                            {? s.id}
                                            <li class="media media-form" style="margin: 15px 0 0;">
                                                <a href="#" class="media-left">
                                                    {? s.id}
                                                    <img src="{s.picture}" alt="{s.name}" class="avatar img-circle">
                                                    {:}
                                                    <img src="/img/default-img-member.png" alt="name" class="avatar img-circle">
                                                    {/}
                                                </a>
                                                <div class="media-body">
                                                    <form role="form" name="lo_comm_form{.id}"> 
                                                        <fieldset>
                                                        <input type="hidden" name="p_type" value="{.p_type}" />
                                                        <input type="hidden" name="depth" value="1" />
                                                        <input type="hidden" name="parent" value="{.id}" />
                                                        <input type="hidden" name="p_id" value="{.p_id}" />
                                                        <input type="hidden" name="user_id" value="{s.id}" />
                                                            <div class="form-group">                        
                                                                <textarea rows="2" class="form-control" placeholder="댓글을 남겨주세요." name="contents"></textarea>
                                                            </div> 
                                                            {? s.id}
                                                            <button class="btn btn-primary" onclick="submit_lo_comm(this, '{.id}'); return false;">업데이트</button>
                                                            {:}
                                                            <button class="btn btn-primary" style="cursor: default" disabled>로그인 해주세요</button>
                                                            {/}
                                                        </fieldset>
                                                    </form>
                                                </div>
                                            </li>
                                            {/}
                                        </ul>
                                    </div>
                                </li>
                                {/}
                            </ul>
                            <!-- /media -->

                            <!-- pagination --> 
                            <nav class="paging text-center row" {? sizeof(comments) < 10}style="display: none;"{/}> 
                                <div class="col-xs-8 col-xs-offset-2 col-sm-6 col-sm-offset-3 col-md-6 col-md-offset-3">
                                    <input type="hidden" id="t_page" value="2" />
                                    <a href="#" class="btn btn-default btn-block" onclick="timeline_call(0); return false;" id="m_t_btn">더보기</a>  
                                </div>
                            </nav> 
                            <!-- /pagination -->

                        </section>
                        <!-- /#timeline-media -->

                        <!-- #now-user -->
                        <section id="now-user">
                            <div class="page-header">
                                <h3><span class="fui-user"></span>&nbsp; D.CAMP Now</h3>
                            </div>

                            <p class="lead">지금 D.CAMP에서는 {=sizeof(users)}+명이 함께하고 있습니다.</p>

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
                    <!-- / #content -->

                    <!-- #sidebar -->
                    <div id="sidebar" class="col-xs-12 col-sm-12 col-md-4">
                        <section id="today-event">
                            <div class="page-header">
                                <h3><span class="fui-calendar"></span>&nbsp; 오늘의 D.CAMP</h3>
                            </div>
                            
                            <ul class="media-list">
                                {@ event}
                                <li class="media">
                                    {? .picture}
                                    <a class="media-left" href="/lounge/event/{.id}">
                                      <img src="{.picture}">
                                    </a>
                                    {/}
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/lounge/event/{.id}">{.title}</a> </h4>
                                        <p>{?.date}{.date} ({=date_to_day_only(.date)}) {? .start}{.start}{/}{/} {?.date_e}~ {.date_e} ({=date_to_day_only(.date_e)}) {? .end}{.end}{/}{/} </p>
                                    </div>
                                </li>
                                {/}
                            </ul>
                        </section>

                    </div>
                    <!-- /#sidebar -->
                </div>
            </div>
            <!-- /main -->
            <!-- /End Contents -->