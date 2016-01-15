                                    {@ res}{? !.is_hidden || .is_hidden && res.user_id == s.id || .is_hidden && pid == s.id}                                    
                                    <li class="media"> 
                                        {? s.id == .user_id}<button type="button" class="close" aria-hidden="true" onclick="del_comm('{.id}', 1); return false;">&times;</button>{/}
                                        <a class="pull-left media-object " href="/member/{.ids}"> 
                                            <img src="{? .picture}{.picture}{:}/img/default-img-member.png{/}" class="img-circle" data-toggle="tooltip" title="{.name}"> 
                                        </a>
                                        <div class="media-body" id="com_{.id}">
                                            <h4 class="media-heading">
                                                <a href="/member/{.ids}">{.name}</a>
                                                <small><a href="/timeline/{.id}">&nbsp; {=trans_date_ago(.date_created)}</a></small>
                                            </h4>                                             
                                            <div class="media-content">
                                                {? .image}<div class="pull-right">
                                                    <a rel="prettyPhoto" style="background:url({.image}) center center no-repeat #000; background-size: 180px auto;" class="img-thumbnail" href="{.image}"><img src="/img/trans.png"></a>
                                                </div>{/}
                                                <div class="ellipsis" >{=add_brs(.contents)}
                                                <a class="readmore" style="display: inline;" >더보기 »</a></div>
                                                {? .sub}{.sub}{/}
                                            </div>
                                            <div class="media-meta">
                                                <div class="meta-actions" style="text-align: right;">
                                                    <div class="btn-group btn-like ">
                                                        <button type="button" class="btn btn-default btn-sm" onclick="comment_like(this, '{.id}', '{.is_like}'); return false;">
                                                            <span class="glyphicon glyphicon-heart"></span> 
                                                            <span class="sr-only">좋아요 </span>{? .like}<span id="li_cnt{.id}">{.like}</span> {/}
                                                        </button>
                                                        <button aria-controls="like-media" aria-expanded="true" data-target="#like-media{.id}" data-toggle="collapse" class="btn btn-default btn-sm" type="button" {? ! .like}style="display: none;"{/} onclick="get_like('{.id}'); return false;">
                                                            <span class="caret"></span>
                                                        </button>
                                                    </div>
                                                    <button aria-controls="re-media" aria-expanded="true" data-target="#re-media{.id}" data-toggle="collapse" class="btn btn-default btn-sm" type="button" onclick="open_com(this); return false;">
                                                        <span class="glyphicon glyphicon-comment"></span> <span class="sr-only">댓글 </span>  <span id="re_cnt{.id}">{=sizeof(.comm)}</span>
                                                    </button> 
                                                </div>
                                            </div>
                                            <div id="like-media{.id}" class="collapse"></div>

                                            <!-- sub media -->
                                            <ul class="media-list" style="display: none;">
                                                {@ .comm}
                                                <li class="media" id="com_{..id}"> 
                                                    {? s.id == ..user_id}<button type="button" class="close" aria-hidden="true" onclick="del_comm('{..id}', 0); return false;">&times;</button>{/}
                                                    <a class="pull-left media-object " href="#"> <img src="{..picture}" class="img-circle" data-toggle="tooltip" title="{..name}" > </a>
                                                    <div class="media-body"> 
                                                        <h4 class="media-heading">
                                                            <a href="/member/{..ids}">{..name}</a>
                                                            <small>{=trans_date_ago(..date_created)}</small>
                                                        </h4> 
                                                        <div class="media-content">{..contents}</div>
                                                    </div>
                                                </li>
                                                {/}
                                            </ul>
                                            <!-- /sub media --> 
                                            <!-- sub media form -->
                                            <div class="media media-form rounded" style="display: none;"> 
                                                <a class="pull-left media-object " href="/member/{s.ids}"> 
                                                    <img src="{?s.picture}{s.picture}{:}/img/default-img-member.png{/}" class="img-circle" data-toggle="tooltip" title="{s.name}"> 
                                                </a>
                                                <div class="media-body">
                                                    <form name="tl_c_form_{.id}">
                                                        <input type="hidden" name="p_type" value="{type}" />
                                                        <input type="hidden" name="depth" value="1" />
                                                        <input type="hidden" name="parent" value="{.id}" />
                                                        <input type="hidden" name="p_id" value="{pid}" />
                                                        <input type="hidden" name="user_id" value="{s.id}" />
                                                        <fieldset>
                                                            <div class="form-group">
                                                                <label class="sr-only" for="inputTimeline">타임라인에 글쓰기</label>
                                                                <textarea row="3" class="form-control" id="inputTimeline" name="contents"></textarea>
                                                            </div>
                                                            <!-- /form-group -->
                                                            <button class="btn btn-primary btn-sm" onclick="submit_c_coment(this, '{.id}'); return false;">저장하기</button>
                                                        </fieldset>
                                                    </form>
                                                </div>
                                            </div>
                                            <!-- /sub media form --> 
                                                
                                        </div>
                                    </li>
                                    {/}{/}