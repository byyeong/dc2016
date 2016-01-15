                            {@ res}
                            <li class="media"> 
                                <a class="pull-left media-object" href="{? .p_type == 2}/startup/{.p_id}{:}/member/{.ids}{/}"> 
                                    <img src="{? .picture}{.picture}{:}/img/default-img-member.png{/}" class="img-circle" data-toggle="tooltip" title="{.name}" > 
                                </a>
                                <div class="media-body" id="com_{.id}"> 
                                    {? (s.per & settings->permission1) == settings->permission1}
                                    <button title="숨기기" data-toggle="tooltip" aria-hidden="true" class="close btn-hidden" type="button" onclick="hide_news('{.id}'); return false;"><span class="icon-check-minus"></span></button>
                                    {/}
                                    {? s.id == .user_id}<button type="button" class="close" aria-hidden="true" onclick="del_comm('{.id}', 1); return false;">&times;</button>{/}
                                    <h4 class="media-heading"><a href="{? .p_type == 2}/startup/{.p_id}{:}/member/{.ids}{/}">{.name}</a></h4> 
                                    
                                    <div class="media-content">
                                        <div class="ellipsis_n" >{=add_brs(.contents)}
                                            <a class="readmore" style="display: inline;" >더보기 »</a>
                                        </div>
                                        {? .sub}{.sub}{/}
                                    </div>
                                    
                                    <div class="media-meta">
                                        <span class="time"><span class="fontawesome icon-time"></span><a href="/timeline/{.id}">&nbsp; {=trans_date_ago(.date_created)}</a></span>
                                        {? s}<button class="btn btn-link btn-xs" onclick="open_com(this); return false;">댓글쓰기</button>{/}
                                    </div>

                                    <!-- sub media -->
                                    <ul class="media-list">
                                        {@ .comm}
                                        <li class="media" id="com_{..id}"> 
                                             {? s.id == ..user_id}<button type="button" class="close" aria-hidden="true" onclick="del_comm('{..id}', 0); return false;">&times;</button>{/}
                                            <a class="pull-left media-object" href="#"> <img src="{..picture}" class="img-circle" data-toggle="tooltip" title="{..name}" > </a>
                                            <div class="media-body"> 
                                                <h4 class="media-heading"><a href="/member/{..ids}">{..name}</a></h4> 
                                                <div class="media-content">{..contents}</div>
                                                <div class="media-meta">
                                                    <span class="time"><span class="fontawesome icon-time"></span>&nbsp; {=trans_date_ago(..date_created)}</span>
                                                </div>
                                            </div>
                                        </li>
                                        {/}
                                    </ul>
                                    <!-- /sub media --> 
                                    
                                    <!-- sub media form -->
                                    <div class="media-form rounded" style="display: none;"> 
                                        <a class="pull-left media-object" href="/member/{s.ids}"> 
                                            <img src="{?s.picture}{s.picture}{:}/img/default-img-member.png{/}" class=" img-circle" data-toggle="tooltip" title="{s.name}" style="width:40px;"> 
                                        </a>
                                        <div class="media-body">
                                            <form name="tl_c_form_{.id}">
                                                <input type="hidden" name="p_type" value="{.p_type}" />
                                                <input type="hidden" name="depth" value="1" />
                                                <input type="hidden" name="parent" value="{.id}" />
                                                <input type="hidden" name="p_id" value="{.p_id}" />
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
                            {/}