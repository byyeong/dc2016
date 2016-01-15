
                                            <li class="media" id="com_{res.id}"> 
                                                {? st}
                                                <a class="media-left" href="/startup/{st.is}"> 
                                                    <img src="{st.logo}" class="media-object img-circle" data-toggle="tooltip" title="{st.name}">
                                                </a>
                                                {:}
                                                <a class="media-left" href="/member/{res.ids}"> 
                                                    <img src="{res.picture}" class="media-object img-circle" data-toggle="tooltip" title="{res.name}">
                                                </a>
                                                {/}
                                                <div class="media-body">
                                                    <div class="media-heading">
                                                        {? s.id == res.user_id}
                                                        <button type="button" class="close delete" data-toggle="tooltip" title="삭제" onclick="del_comm('{res.id}', 0); return false;">&times;</button>
                                                        {/}
                                                        <strong><a href="/member/{res.ids}">{res.name}</a></strong>
                                                        <span class="date"><span class="glyphicon glyphicon-time"></span>{=trans_date_ago(res.date_created)}</span> 
                                                    </div>
                                                    <p>{res.contents}</p>
                                                </div>
                                            </li> 