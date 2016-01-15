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
                                                        <a href="/member/{.ids}">{..name}></a> <small>{=substr(..date_created, 0, -3)}</small>
                                                    </h4>
                                                    <p>{=trans_url(add_brs(..contents))}</p>
                                                </div>
                                            </li>
                                            {/}
                                            {? s.id}
                                            <li class="media media-form" style="margin: 15px 0 0">
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
                                                        <input type="hidden" name="p_type" value="3" />
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
                                                            <div class="btn btn-primary" disabled>로그인 해주세요</div>
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