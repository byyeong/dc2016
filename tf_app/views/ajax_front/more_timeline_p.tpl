                                            {@ res}
                                            {? !.is_hidden || .is_hidden && res.user_id == s.id || .is_hidden && pid == s.id}
                                            <li class="media">
                                                <a class="media-left" href="/member/{.ids}"> 
                                                    <img src="{? .picture}{.picture}{:}/img/default-img-member.png{/}" class="media-object img-circle" data-toggle="tooltip" title="작성자">
                                                </a>
                                                <div class="media-body" id="com_{.id}">
                                                    <div class="media-heading">
                                                        {? s.id == .user_id}
                                                        <button type="button" class="close delete" data-toggle="tooltip" title="삭제" onclick="del_comm('{.id}', 1); return false;">&times;</button>
                                                        {/}
                                                        <strong><a href="/member/{.ids}">{.name}</a></strong>
                                                        <span class="date"><span class="glyphicon glyphicon-time"></span>{=trans_date_ago(.date_created)}</span> 
                                                        {? s}
                                                        <button class="btn btn-default btn-xs" onclick="open_com(this); return false;">댓글쓰기</button>    
                                                        {/}                                                   
                                                    </div>
                                                    <div class="media-content">
                                                        <div class="ellipsis" >{=trans_url(add_brs(.contents))}
                                                        <a class="readmore" style="display: inline;" >더보기 »</a></div>

                                                        {? .sub}
                                                        <div class="media-share">
                                                            {.sub}
                                                        </div>
                                                        {/}
                                                    </div>
                                                    <!-- /media-share --> 
                                                     
                                                    <ul class="media-list">
                                                        {@ .comm}
                                                        <li class="media" id="com_{..id}"> 
                                                            <a class="media-left" href="/member/{..ids}"> 
                                                                <img src="{..picture}" class="media-object img-circle" data-toggle="tooltip" title="{..name}">
                                                            </a>
                                                            <div class="media-body">
                                                                <div class="media-heading">
                                                                    {? s.id == ..user_id}
                                                                    <button type="button" class="close delete" data-toggle="tooltip" title="삭제" onclick="del_comm('{..id}', 0); return false;">&times;</button>
                                                                    {/}
                                                                    <strong><a href="/member/{..ids}">{..name}</a></strong>
                                                                    <span class="date"><span class="glyphicon glyphicon-time"></span>{=trans_date_ago(..date_created)}</span> 
                                                                </div>
                                                                <p>{=trans_url(add_brs(..contents))}</p>
                                                            </div>
                                                        </li> 
                                                        {/}
                                                        <!-- /media -->
                                                        <li class="media form-edit-set" style="display: none;">
                                                            <form role="form" name="tl_c_form_{.id}">
                                                                <fieldset>
                                                                    <a class="media-left" href="/member/{s.ids}"> 
                                                                        <img src="{?s.picture}{s.picture}{:}/img/default-img-member.png{/}" class="media-object img-circle" data-toggle="tooltip" title="{s.name}">
                                                                    </a>
                                                                    <div class="media-body">
                                                                        <div class="form-group">
                                                                            <label class="sr-only">댓글내용</label>
                                                                            <textarea row="3" class="form-control" placeholder="댓글을 입력하세요" id="inputTimeline" name="contents"></textarea>
                                                                        </div>
                                                                        <div class="form-group form-submit">
                                                                            <button class="btn btn-default btn-sm" onclick="submit_c_coment(this, '{.id}'); return false;">저장하기</button>
                                                                        </div>
                                                                    </div>
                                                                    <input type="hidden" name="p_type" value="{type}" />
                                                                    <input type="hidden" name="depth" value="1" />
                                                                    <input type="hidden" name="parent" value="{.id}" />
                                                                    <input type="hidden" name="p_id" value="{pid}" />
                                                                    <input type="hidden" name="user_id" value="{s.id}" />
                                                                </fieldset>
                                                            </form>
                                                        </li> 
                                                        <!-- /media -->
                                                    </ul>
                                                    <!-- /media-list --> 
                                                </div>
                                            </li>
                                            <!-- /media --> 
                                            {/}
                                            {/}