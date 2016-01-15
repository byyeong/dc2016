                                        
                                            <li class="media" id="com_{res.id}"> 
                                                 {? s.id == res.user_id}<button type="button" class="close" aria-hidden="true" onclick="del_comm('{res.id}', 0); return false;">&times;</button>{/}
                                                <a class="pull-left" href="/member/{res.ids}"> <img src="{? res.picture}{res.picture}{:}/img/default-img-member.png{/}" class="media-object img-circle" data-src="holder.js/40x40" data-toggle="tooltip" title="userName"  style="width:40px;"> </a>
                                                <div class="media-body"> 
                                                    <h4 class="media-heading">
                                                        <a href="/member/{res.ids}">{res.name}</a>
                                                        <small>{=trans_date_ago(res.date_created)}</small>
                                                    </h4> 
                                                    <div class="media-content">{res.contents}</div>
                                                </div>
                                            </li>